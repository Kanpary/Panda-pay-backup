<?php
declare(strict_types=1);

function game_fetch_player_profile(PDO $pdo, string $userId): array
{
    $stmt = $pdo->prepare('SELECT is_influencer
                           FROM profiles
                           WHERE user_id = :user_id
                           LIMIT 1');
    $stmt->execute([':user_id' => $userId]);

    return $stmt->fetch() ?: [];
}

function game_fetch_global_settings(PDO $pdo): array
{
    return $pdo->query('SELECT difficulty,coin_return,game_speed,jump_height,common_player_coin_percentage
                        FROM game_settings
                        ORDER BY updated_at DESC
                        LIMIT 1')->fetch() ?: [];
}

function game_fetch_influencer_settings(PDO $pdo): array
{
    return $pdo->query('SELECT gain_multiplier,difficulty_reduction,coin_return,jump_multiplier,influencer_coin_percentage,influencer_calculation_mode,
                               influencer_jump_multiplier_v2,influencer_fixed_coin_value_v2,influencer_double_coins_v2
                        FROM influencer_settings
                        ORDER BY updated_at DESC
                        LIMIT 1')->fetch() ?: [];
}

function game_clamp(float $value, float $min, float $max): float
{
    if ($value < $min) {
        return $min;
    }
    if ($value > $max) {
        return $max;
    }
    return $value;
}

function game_resolve_session_values(PDO $pdo, string $userId, float $betAmount): array
{
    $gameSettings = game_fetch_global_settings($pdo);
    $profile = game_fetch_player_profile($pdo, $userId);

    $baseTarget = round($betAmount * 5, 2);
    $commonPercent = max(0.0, (float)($gameSettings['common_player_coin_percentage'] ?? 5.0));
    $targetAmount = $baseTarget;
    $coinValue = round($betAmount * ($commonPercent / 100), 4);

    $isInfluencer = (bool)($profile['is_influencer'] ?? false);
    if (!$isInfluencer) {
        return [
            'target_amount' => $targetAmount,
            'coin_value' => $coinValue,
        ];
    }

    $settings = game_fetch_influencer_settings($pdo);
    $fixedCoinValueV2 = game_clamp((float)($settings['influencer_fixed_coin_value_v2'] ?? 1.0), 1.0, 10000.0);
    $coinValue = round($fixedCoinValueV2, 4);

    return [
        'target_amount' => $targetAmount,
        'coin_value' => $coinValue,
    ];
}

function game_start_session(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $input = get_json_input();
    $betAmount = (float)($input['bet_amount'] ?? 0);
    $difficulty = (float)($input['difficulty'] ?? 50);
    $coinReturn = (float)($input['coin_return'] ?? 5);
    $gameSpeed = (float)($input['game_speed'] ?? 1);
    $jumpHeight = (float)($input['jump_height'] ?? 12);
    if ($betAmount <= 0) json_error('Invalid bet amount', 422);

    try {
        $pdo->beginTransaction();
        $w = $pdo->prepare('SELECT player_balance FROM wallets WHERE user_id=:user_id LIMIT 1 FOR UPDATE');
        $w->execute([':user_id'=>$userId]);
        $wallet = $w->fetch();
        if (!$wallet) throw new RuntimeException('wallet_not_found');
        $before = (float)$wallet['player_balance'];
        if ($before < $betAmount) throw new RuntimeException('insufficient_balance');

        $after = round($before - $betAmount, 2);
        $sessionValues = game_resolve_session_values($pdo, $userId, $betAmount);
        $target = (float)$sessionValues['target_amount'];
        $coinValue = (float)$sessionValues['coin_value'];

        $pdo->prepare('UPDATE wallets SET player_balance=:b,updated_at=CURRENT_TIMESTAMP WHERE user_id=:u')
            ->execute([':b'=>$after, ':u'=>$userId]);

        $sessionId = uuid_v4();
        $maxPayoutAmount = $target;

        $pdo->prepare('INSERT INTO game_sessions (id,user_id,bet_amount,target_amount,coin_value,max_payout_amount,difficulty,coin_return,game_speed,jump_height,status)
                       VALUES (:id,:u,:bet,:target,:coin,:max_payout,:d,:cr,:gs,:jh,:status)')
            ->execute([
                ':id'=>$sessionId, ':u'=>$userId, ':bet'=>$betAmount, ':target'=>$target, ':coin'=>$coinValue,
                ':max_payout'=>$maxPayoutAmount,
                ':d'=>$difficulty, ':cr'=>$coinReturn, ':gs'=>$gameSpeed, ':jh'=>$jumpHeight, ':status'=>'active'
            ]);

        $pdo->prepare('INSERT INTO wallet_transactions (user_id,game_session_id,type,amount,balance_before,balance_after,description)
                       VALUES (:u,:sid,:type,:amount,:bb,:ba,:desc)')
            ->execute([
                ':u'=>$userId, ':sid'=>$sessionId, ':type'=>'bet', ':amount'=>-$betAmount,
                ':bb'=>$before, ':ba'=>$after, ':desc'=>'Game bet placed'
            ]);

        $pdo->commit();
        json_success(['session_id'=>$sessionId, 'balance'=>$after, 'target_amount'=>$target, 'coin_value'=>$coinValue]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage()==='insufficient_balance') json_error('insufficient_balance', 409);
        if ($e->getMessage()==='wallet_not_found') json_error('Wallet not found', 404);
        json_error('Failed to start game session', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to start game session', 500);
    }
}

function game_finish_session(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $input = get_json_input();
    $sessionId = trim((string)($input['session_id'] ?? ''));
    $status = trim((string)($input['status'] ?? ''));
    $coinsRaw = $input['coins_collected'] ?? 0;

    if (!is_int($coinsRaw) && !(is_string($coinsRaw) && ctype_digit($coinsRaw))) {
        json_error('coins_collected must be an integer >= 0', 422);
    }
    $coins = (int)$coinsRaw;
    if ($coins < 0) {
        json_error('coins_collected must be an integer >= 0', 422);
    }

    if ($sessionId === '') json_error('session_id is required', 422);
    $normalized = $status === 'won' ? 'won' : ($status === 'cashed_out' ? 'cashed_out' : 'lost');
    // SECURITY: payout_amount from client is intentionally ignored.

    try {
        $pdo->beginTransaction();
        $s = $pdo->prepare('SELECT id,user_id,status,coin_value,max_payout_amount,target_amount FROM game_sessions WHERE id=:id LIMIT 1 FOR UPDATE');
        $s->execute([':id'=>$sessionId]);
        $session = $s->fetch();
        if (!$session || $session['user_id'] !== $userId) throw new RuntimeException('session_not_found');
        if ($session['status'] !== 'active') throw new RuntimeException('session_already_finished');

        $coinValue = (float)$session['coin_value'];
        $maxPayout = isset($session['max_payout_amount'])
            ? (float)$session['max_payout_amount']
            : (float)$session['target_amount'];
        $profile = game_fetch_player_profile($pdo, $userId);
        $isInfluencer = (bool)($profile['is_influencer'] ?? false);

        // Recalculate payout strictly on server side.
        $payout = 0.0;
        if (in_array($normalized, ['cashed_out', 'won'], true)) {
            $payout = round($coins * $coinValue, 2);
            $payout = max(0.0, $payout);
            if (!$isInfluencer) {
                $payout = min($payout, max(0.0, $maxPayout));
            }
        }

        $w = $pdo->prepare('SELECT player_balance FROM wallets WHERE user_id=:u LIMIT 1 FOR UPDATE');
        $w->execute([':u'=>$userId]);
        $wallet = $w->fetch();
        if (!$wallet) throw new RuntimeException('wallet_not_found');

        $before = (float)$wallet['player_balance'];
        $after = $before;
        if (in_array($normalized, ['cashed_out', 'won'], true) && $payout > 0) {
            $after = round($before + $payout, 2);
            $pdo->prepare('UPDATE wallets SET player_balance=:b,updated_at=CURRENT_TIMESTAMP WHERE user_id=:u')
                ->execute([':b'=>$after, ':u'=>$userId]);
            $pdo->prepare('INSERT INTO wallet_transactions (user_id,game_session_id,type,amount,balance_before,balance_after,description)
                           VALUES (:u,:sid,:type,:amount,:bb,:ba,:desc)')
                ->execute([
                    ':u'=>$userId, ':sid'=>$sessionId, ':type'=>'win', ':amount'=>$payout,
                    ':bb'=>$before, ':ba'=>$after, ':desc'=>'Game payout'
                ]);
        }

        $pdo->prepare('UPDATE game_sessions
                       SET status=:st, coins_collected=:coins, payout_amount=:payout, ended_at=CURRENT_TIMESTAMP, updated_at=CURRENT_TIMESTAMP
                       WHERE id=:id')
            ->execute([
                ':st'=>$normalized, ':coins'=>max(0, $coins), ':payout'=>$normalized === 'lost' ? 0 : $payout, ':id'=>$sessionId
            ]);

        $pdo->commit();
        json_success([
            'balance'=>$after,
            'payout_amount'=>$payout,
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage()==='session_not_found') json_error('Session not found', 404);
        if ($e->getMessage()==='session_already_finished') json_error('Session already finished', 409);
        if ($e->getMessage()==='wallet_not_found') json_error('Wallet not found', 404);
        json_error('Failed to finish game session', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to finish game session', 500);
    }
}

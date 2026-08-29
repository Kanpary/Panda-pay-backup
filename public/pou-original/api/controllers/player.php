<?php
declare(strict_types=1);

function player_wallet(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $stmt = $pdo->prepare('SELECT id,user_id,player_balance,affiliate_balance,total_deposited,total_withdrawn,total_affiliate_earned,created_at,updated_at
                           FROM wallets WHERE user_id = :user_id LIMIT 1');
    $stmt->execute([':user_id'=>$userId]);
    $wallet = $stmt->fetch();
    if (!$wallet) json_error('Wallet not found', 404);
    json_success($wallet);
}

function player_dashboard(PDO $pdo): void
{
    $userId = require_auth($pdo);

    $profileStmt = $pdo->prepare('SELECT user_id,full_name,username,email,phone,cpf,is_influencer,referral_code,referred_by,created_at,updated_at
                                  FROM profiles WHERE user_id = :user_id LIMIT 1');
    $profileStmt->execute([':user_id' => $userId]);
    $profile = $profileStmt->fetch();

    $walletStmt = $pdo->prepare('SELECT id,user_id,player_balance,affiliate_balance,total_deposited,total_withdrawn,total_affiliate_earned,created_at,updated_at
                                 FROM wallets WHERE user_id = :user_id LIMIT 1');
    $walletStmt->execute([':user_id' => $userId]);
    $wallet = $walletStmt->fetch();

    $depositsStmt = $pdo->prepare('SELECT id,amount,status,provider,external_id,created_at,updated_at,paid_at
                                   FROM deposits WHERE user_id = :user_id ORDER BY created_at DESC LIMIT 10');
    $depositsStmt->execute([':user_id' => $userId]);
    $deposits = $depositsStmt->fetchAll();

    $withdrawalsStmt = $pdo->prepare('SELECT id,wallet_type,amount,fee_amount,net_amount,status,pix_key,pix_key_type,notes,created_at,updated_at,processed_at
                                      FROM withdrawals WHERE user_id = :user_id ORDER BY created_at DESC LIMIT 10');
    $withdrawalsStmt->execute([':user_id' => $userId]);
    $withdrawals = $withdrawalsStmt->fetchAll();

    $banners = $pdo->query("SELECT id,title,image_url,placement,is_active,sort_order,created_at,updated_at
                            FROM banners WHERE is_active = 1 ORDER BY sort_order ASC, created_at DESC")->fetchAll();

    $financial = $pdo->query('SELECT id,min_deposit,min_withdrawal_player,min_withdrawal_affiliate,withdrawal_fee_percent,withdrawal_fee_fixed,pix_enabled,updated_at
                              FROM financial_settings ORDER BY updated_at DESC LIMIT 1')->fetch();

    $influencerSettings = $pdo->query('SELECT gain_multiplier,difficulty_reduction,coin_return,jump_multiplier,influencer_coin_percentage,influencer_calculation_mode,
                                              influencer_jump_multiplier_v2,influencer_fixed_coin_value_v2,influencer_double_coins_v2,updated_at
                                       FROM influencer_settings
                                       ORDER BY updated_at DESC
                                       LIMIT 1')->fetch();

    $affStmt = $pdo->prepare('SELECT
                                COALESCE(SUM(CASE WHEN status IN ("available","pending") THEN amount ELSE 0 END), 0) AS pending_or_available,
                                COALESCE(SUM(CASE WHEN status = "paid" THEN amount ELSE 0 END), 0) AS paid_total,
                                COUNT(*) AS total_rows
                              FROM affiliate_commissions
                              WHERE affiliate_user_id = :user_id');
    $affStmt->execute([':user_id' => $userId]);
    $affSummary = $affStmt->fetch() ?: [
        'pending_or_available' => '0.00',
        'paid_total' => '0.00',
        'total_rows' => 0,
    ];

    $refStmt = $pdo->prepare('SELECT COUNT(*) AS referred_users FROM profiles WHERE referred_by = :user_id');
    $refStmt->execute([':user_id' => $userId]);
    $refCount = $refStmt->fetch();

    $recentReferralsStmt = $pdo->prepare('SELECT full_name,email,created_at
                                          FROM profiles
                                          WHERE referred_by = :user_id
                                          ORDER BY created_at DESC
                                          LIMIT 50');
    $recentReferralsStmt->execute([':user_id' => $userId]);
    $recentReferrals = $recentReferralsStmt->fetchAll();

    json_success([
        'profile' => $profile ?: new stdClass(),
        'wallet' => $wallet ?: new stdClass(),
        'recent_deposits' => $deposits,
        'recent_withdrawals' => $withdrawals,
        'recent_referrals' => $recentReferrals,
        'banners' => $banners,
        'financial_settings' => $financial ?: new stdClass(),
        'influencer_settings' => $influencerSettings ?: new stdClass(),
        'affiliate_summary' => [
            'pending_or_available' => $affSummary['pending_or_available'],
            'paid_total' => $affSummary['paid_total'],
            'total_rows' => (int)$affSummary['total_rows'],
            'referred_users' => (int)($refCount['referred_users'] ?? 0),
        ],
    ]);
}

function player_deposits(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
    if ($limit <= 0) {
        $limit = 10;
    }
    if ($limit > 100) {
        $limit = 100;
    }

    $stmt = $pdo->prepare('SELECT id,amount,status,provider,external_id,qr_code,payment_link,metadata,created_at,updated_at,paid_at
                           FROM deposits
                           WHERE user_id = :user_id
                           ORDER BY created_at DESC
                           LIMIT ' . $limit);
    $stmt->execute([':user_id' => $userId]);

    json_success([
        'items' => $stmt->fetchAll(),
        'limit' => $limit,
    ]);
}

function player_withdrawals_create(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $input = get_json_input();

    $amount = (float)($input['amount'] ?? 0);
    $walletType = (string)($input['wallet_type'] ?? 'player');
    $pixKey = trim((string)($input['pix_key'] ?? ''));
    $pixKeyType = trim((string)($input['pix_key_type'] ?? ''));

    if (!in_array($walletType, ['player', 'affiliate'], true)) {
        json_error('Invalid wallet_type. Allowed: player, affiliate', 422);
    }
    if ($amount <= 0) {
        json_error('Invalid withdrawal amount', 422);
    }

    $financial = $pdo->query('SELECT min_withdrawal_player,min_withdrawal_affiliate,withdrawal_fee_percent,withdrawal_fee_fixed
                              FROM financial_settings ORDER BY updated_at DESC LIMIT 1')->fetch();
    if (!$financial) {
        json_error('Financial settings not found', 500);
    }

    $minValue = $walletType === 'affiliate'
        ? (float)$financial['min_withdrawal_affiliate']
        : (float)$financial['min_withdrawal_player'];
    if ($amount < $minValue) {
        json_error('Withdrawal amount below minimum allowed', 422, [
            'min_value' => number_format($minValue, 2, '.', ''),
            'wallet_type' => $walletType,
        ]);
    }

    $feePercent = max(0.0, (float)$financial['withdrawal_fee_percent']);
    $feeFixed = max(0.0, (float)$financial['withdrawal_fee_fixed']);
    $feeAmount = round(($amount * ($feePercent / 100)) + $feeFixed, 2);
    $netAmount = max(0.0, round($amount - $feeAmount, 2));

    try {
        $pdo->beginTransaction();

        $walletStmt = $pdo->prepare('SELECT player_balance,affiliate_balance,total_withdrawn
                                     FROM wallets
                                     WHERE user_id = :user_id
                                     LIMIT 1
                                     FOR UPDATE');
        $walletStmt->execute([':user_id' => $userId]);
        $wallet = $walletStmt->fetch();
        if (!$wallet) {
            throw new RuntimeException('wallet_not_found');
        }

        $currentBalance = $walletType === 'affiliate'
            ? (float)$wallet['affiliate_balance']
            : (float)$wallet['player_balance'];
        if ($currentBalance < $amount) {
            throw new RuntimeException('insufficient_balance');
        }

        $newBalance = round($currentBalance - $amount, 2);
        if ($newBalance < 0) {
            throw new RuntimeException('negative_balance_blocked');
        }

        if ($walletType === 'affiliate') {
            $update = $pdo->prepare('UPDATE wallets
                                     SET affiliate_balance = :new_balance, total_withdrawn = total_withdrawn + :amount, updated_at = CURRENT_TIMESTAMP
                                     WHERE user_id = :user_id');
        } else {
            $update = $pdo->prepare('UPDATE wallets
                                     SET player_balance = :new_balance, total_withdrawn = total_withdrawn + :amount, updated_at = CURRENT_TIMESTAMP
                                     WHERE user_id = :user_id');
        }
        $update->execute([
            ':new_balance' => $newBalance,
            ':amount' => $amount,
            ':user_id' => $userId,
        ]);

        $withdrawalId = uuid_v4();
        $createWithdrawal = $pdo->prepare('INSERT INTO withdrawals
                                           (id,user_id,wallet_type,amount,fee_amount,net_amount,status,pix_key,pix_key_type,notes)
                                           VALUES
                                           (:id,:user_id,:wallet_type,:amount,:fee_amount,:net_amount,:status,:pix_key,:pix_key_type,:notes)');
        $createWithdrawal->execute([
            ':id' => $withdrawalId,
            ':user_id' => $userId,
            ':wallet_type' => $walletType,
            ':amount' => $amount,
            ':fee_amount' => $feeAmount,
            ':net_amount' => $netAmount,
            ':status' => 'pending',
            ':pix_key' => $pixKey !== '' ? $pixKey : null,
            ':pix_key_type' => $pixKeyType !== '' ? $pixKeyType : null,
            ':notes' => 'Withdrawal requested by player',
        ]);

        $walletTxType = $walletType === 'affiliate' ? 'withdrawal_affiliate' : 'withdrawal_player';
        $createTx = $pdo->prepare('INSERT INTO wallet_transactions
                                   (user_id,game_session_id,type,amount,balance_before,balance_after,description)
                                   VALUES
                                   (:user_id,NULL,:type,:amount,:balance_before,:balance_after,:description)');
        $createTx->execute([
            ':user_id' => $userId,
            ':type' => $walletTxType,
            ':amount' => -$amount,
            ':balance_before' => $currentBalance,
            ':balance_after' => $newBalance,
            ':description' => $walletType === 'affiliate' ? 'Affiliate withdrawal request' : 'Player withdrawal request',
        ]);

        $pdo->commit();
        json_success([
            'withdrawal_id' => $withdrawalId,
            'status' => 'pending',
            'wallet_type' => $walletType,
            'amount' => number_format($amount, 2, '.', ''),
            'fee_amount' => number_format($feeAmount, 2, '.', ''),
            'net_amount' => number_format($netAmount, 2, '.', ''),
        ], 201);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        if ($e->getMessage() === 'wallet_not_found') {
            json_error('Wallet not found', 404);
        }
        if ($e->getMessage() === 'insufficient_balance' || $e->getMessage() === 'negative_balance_blocked') {
            json_error('Insufficient balance', 409);
        }
        json_error('Failed to create withdrawal', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        json_error('Failed to create withdrawal', 500);
    }
}

function player_profile_update(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $input = get_json_input();

    $fullName = trim((string)($input['full_name'] ?? ''));
    $phone = trim((string)($input['phone'] ?? ''));
    $cpf = trim((string)($input['cpf'] ?? ''));
    $usernameRaw = trim((string)($input['username'] ?? ''));
    $username = $usernameRaw !== '' ? strtolower($usernameRaw) : null;

    if ($username !== null) {
        if (strlen($username) < 3 || strlen($username) > 80) {
            json_error('Username must be between 3 and 80 characters', 422);
        }
        if (!preg_match('/^[a-z0-9._-]+$/', $username)) {
            json_error('Username has invalid characters', 422);
        }

        $check = $pdo->prepare('SELECT user_id FROM profiles WHERE username = :username AND user_id <> :user_id LIMIT 1');
        $check->execute([':username' => $username, ':user_id' => $userId]);
        if ($check->fetch()) {
            json_error('Username already in use', 409);
        }
    }

    $stmt = $pdo->prepare('UPDATE profiles
                           SET full_name = :full_name,
                               phone = :phone,
                               cpf = :cpf,
                               username = :username,
                               updated_at = CURRENT_TIMESTAMP
                           WHERE user_id = :user_id');
    $stmt->execute([
        ':full_name' => $fullName,
        ':phone' => $phone !== '' ? $phone : null,
        ':cpf' => $cpf !== '' ? $cpf : null,
        ':username' => $username,
        ':user_id' => $userId,
    ]);

    $fetch = $pdo->prepare('SELECT user_id,full_name,username,email,phone,cpf,is_influencer,referral_code,referred_by,created_at,updated_at
                            FROM profiles
                            WHERE user_id = :user_id
                            LIMIT 1');
    $fetch->execute([':user_id' => $userId]);
    $profile = $fetch->fetch();

    json_success(['profile' => $profile ?: new stdClass()]);
}

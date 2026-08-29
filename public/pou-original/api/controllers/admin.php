<?php
declare(strict_types=1);

if (!function_exists('table_exists')) {
    function table_exists(PDO $pdo, string $table): bool {
        try {
            $result = $pdo->query("SELECT 1 FROM `{$table}` LIMIT 1");
            return $result !== false;
        } catch (Exception $e) {
            return false;
        }
    }
}

if (!function_exists('resolve_withdrawals_table')) {
    function resolve_withdrawals_table(PDO $pdo): string {
        return table_exists($pdo, 'withdrawals') ? 'withdrawals' : 'withdraws';
    }
}

function admin_require(PDO $pdo): string
{
    $userId = require_auth($pdo);
    require_admin($pdo, $userId);
    return $userId;
}

function admin_log_action(PDO $pdo, string $adminUserId, string $action, ?string $targetUserId = null, ?array $metadata = null): void
{
    $stmt = $pdo->prepare('INSERT INTO admin_logs (admin_user_id, action, target_user_id, metadata, ip_address)
                           VALUES (:admin_user_id, :action, :target_user_id, :metadata, :ip_address)');
    $stmt->execute([
        ':admin_user_id' => $adminUserId,
        ':action' => $action,
        ':target_user_id' => $targetUserId,
        ':metadata' => $metadata !== null ? json_encode($metadata, JSON_UNESCAPED_UNICODE) : null,
        ':ip_address' => substr((string)($_SERVER['REMOTE_ADDR'] ?? ''), 0, 64),
    ]);
}

function admin_assert_active_user(PDO $pdo, string $targetUserId): array
{
    $stmt = $pdo->prepare('SELECT u.id, u.deleted_at AS user_deleted_at, p.deleted_at AS profile_deleted_at
                           FROM users u
                           LEFT JOIN profiles p ON p.user_id = u.id
                           WHERE u.id = :id
                           LIMIT 1');
    $stmt->execute([':id' => $targetUserId]);
    $row = $stmt->fetch();
    if (!$row) {
        json_error('User not found', 404);
    }
    if ($row['user_deleted_at'] !== null || $row['profile_deleted_at'] !== null) {
        json_error('User not found', 404);
    }
    return $row;
}

function admin_stats(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $from = trim((string)($_GET['from'] ?? ''));
    $to = trim((string)($_GET['to'] ?? ''));
    $hasFrom = $from !== '' && preg_match('/^\d{4}-\d{2}-\d{2}$/', $from);
    $hasTo = $to !== '' && preg_match('/^\d{4}-\d{2}-\d{2}$/', $to);
    if (!$hasFrom || !$hasTo) {
        $to = date('Y-m-d');
        $from = date('Y-m-d', strtotime('-30 days'));
    }
    if (strtotime($from) > strtotime($to)) {
        $tmp = $from;
        $from = $to;
        $to = $tmp;
    }

    $withdrawalsTable = resolve_withdrawals_table($pdo);
    $windowStart = $from . ' 00:00:00';
    $windowEnd = $to . ' 23:59:59';

    $stats = [];
    $stats['total_users'] = (int)$pdo->query('SELECT COUNT(*) FROM users WHERE deleted_at IS NULL')->fetchColumn();

    $depSummaryStmt = $pdo->prepare("SELECT
            COUNT(*) AS total_deposits,
            SUM(CASE WHEN status = 'paid' THEN 1 ELSE 0 END) AS paid_deposits,
            SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending_deposits,
            COALESCE(SUM(CASE WHEN status = 'paid' THEN amount ELSE 0 END), 0) AS sum_paid_deposits
        FROM deposits
        WHERE created_at BETWEEN :from AND :to");
    $depSummaryStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    $depSummary = $depSummaryStmt->fetch() ?: [];
    $stats['total_deposits'] = (int)($depSummary['total_deposits'] ?? 0);
    $stats['paid_deposits'] = (int)($depSummary['paid_deposits'] ?? 0);
    $stats['pending_deposits'] = (int)($depSummary['pending_deposits'] ?? 0);
    $stats['sum_paid_deposits'] = (float)($depSummary['sum_paid_deposits'] ?? 0);

    $wdSummaryStmt = $pdo->prepare("SELECT
            COUNT(*) AS total_withdrawals,
            SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending_withdrawals,
            SUM(CASE WHEN wallet_type = 'affiliate' THEN 1 ELSE 0 END) AS affiliate_withdrawals,
            COALESCE(SUM(CASE WHEN status IN ('approved','paid','processing') THEN amount ELSE 0 END), 0) AS sum_withdrawals
        FROM `{$withdrawalsTable}`
        WHERE created_at BETWEEN :from AND :to");
    $wdSummaryStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    $wdSummary = $wdSummaryStmt->fetch() ?: [];
    $stats['total_withdrawals'] = (int)($wdSummary['total_withdrawals'] ?? 0);
    $stats['pending_withdrawals'] = (int)($wdSummary['pending_withdrawals'] ?? 0);
    $stats['affiliate_withdrawals'] = (int)($wdSummary['affiliate_withdrawals'] ?? 0);
    $stats['sum_withdrawals'] = (float)($wdSummary['sum_withdrawals'] ?? 0);

    $commSummaryStmt = $pdo->prepare("SELECT
            COUNT(*) AS total_commissions,
            COALESCE(SUM(amount), 0) AS sum_commissions
        FROM affiliate_commissions
        WHERE created_at BETWEEN :from AND :to");
    $commSummaryStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    $commSummary = $commSummaryStmt->fetch() ?: [];
    $stats['total_commissions'] = (int)($commSummary['total_commissions'] ?? 0);
    $stats['sum_commissions'] = (float)($commSummary['sum_commissions'] ?? 0);

    $stats['total_player_balance'] = (float)$pdo->query("SELECT COALESCE(SUM(player_balance),0) FROM wallets")->fetchColumn();
    $stats['total_affiliate_balance'] = (float)$pdo->query("SELECT COALESCE(SUM(affiliate_balance),0) FROM wallets")->fetchColumn();

    $daily = [];
    $current = strtotime($from);
    $end = strtotime($to);
    while ($current <= $end) {
        $day = date('Y-m-d', $current);
        $daily[$day] = [
            'date' => $day,
            'deposits' => 0.0,
            'withdrawals' => 0.0,
            'users' => 0,
            'commissions' => 0.0,
        ];
        $current = strtotime('+1 day', $current);
    }

    $depDailyStmt = $pdo->prepare("SELECT DATE(created_at) AS d, COALESCE(SUM(amount), 0) AS v
                                   FROM deposits
                                   WHERE status = 'paid' AND created_at BETWEEN :from AND :to
                                   GROUP BY DATE(created_at)");
    $depDailyStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    foreach ($depDailyStmt->fetchAll() as $row) {
        $day = (string)($row['d'] ?? '');
        if (isset($daily[$day])) {
            $daily[$day]['deposits'] = (float)($row['v'] ?? 0);
        }
    }

    $wdDailyStmt = $pdo->prepare("SELECT DATE(created_at) AS d, COALESCE(SUM(amount), 0) AS v
                                  FROM `{$withdrawalsTable}`
                                  WHERE status IN ('approved','paid','processing') AND created_at BETWEEN :from AND :to
                                  GROUP BY DATE(created_at)");
    $wdDailyStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    foreach ($wdDailyStmt->fetchAll() as $row) {
        $day = (string)($row['d'] ?? '');
        if (isset($daily[$day])) {
            $daily[$day]['withdrawals'] = (float)($row['v'] ?? 0);
        }
    }

    $usersDailyStmt = $pdo->prepare("SELECT DATE(created_at) AS d, COUNT(*) AS v
                                     FROM users
                                     WHERE deleted_at IS NULL AND created_at BETWEEN :from AND :to
                                     GROUP BY DATE(created_at)");
    $usersDailyStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    foreach ($usersDailyStmt->fetchAll() as $row) {
        $day = (string)($row['d'] ?? '');
        if (isset($daily[$day])) {
            $daily[$day]['users'] = (int)($row['v'] ?? 0);
        }
    }

    $commDailyStmt = $pdo->prepare("SELECT DATE(created_at) AS d, COALESCE(SUM(amount), 0) AS v
                                    FROM affiliate_commissions
                                    WHERE created_at BETWEEN :from AND :to
                                    GROUP BY DATE(created_at)");
    $commDailyStmt->execute([':from' => $windowStart, ':to' => $windowEnd]);
    foreach ($commDailyStmt->fetchAll() as $row) {
        $day = (string)($row['d'] ?? '');
        if (isset($daily[$day])) {
            $daily[$day]['commissions'] = (float)($row['v'] ?? 0);
        }
    }

    $stats['from'] = $from;
    $stats['to'] = $to;
    $stats['daily'] = array_values($daily);

    admin_log_action($pdo, $adminId, 'admin.stats.view', null, ['from' => $from, 'to' => $to]);
    json_success($stats);
}

function admin_users_list(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 50;
    if ($limit <= 0) $limit = 50;
    if ($limit > 200) $limit = 200;

    $withdrawalsTable = resolve_withdrawals_table($pdo);
    $sql = "SELECT
              u.id AS user_id,
              u.email,
              u.created_at AS user_created_at,
              u.deleted_at AS user_deleted_at,
              p.full_name,
              p.username,
              p.phone,
              p.cpf,
              p.is_influencer,
              p.referral_code,
              p.referred_by,
              p.deleted_at AS profile_deleted_at,
              COALESCE(w.player_balance,0) AS player_balance,
              COALESCE(w.affiliate_balance,0) AS affiliate_balance,
              COALESCE(w.total_deposited,0) AS total_deposited_wallet,
              COALESCE(w.total_withdrawn,0) AS total_withdrawn_wallet,
              CASE
                WHEN EXISTS(SELECT 1 FROM user_roles ur WHERE ur.user_id = u.id AND ur.role = 'admin') THEN 'admin'
                ELSE 'user'
              END AS role,
              COALESCE((SELECT COUNT(*) FROM deposits d WHERE d.user_id = u.id), 0) AS deposits_count,
              COALESCE((SELECT COUNT(*) FROM `{$withdrawalsTable}` wd WHERE wd.user_id = u.id), 0) AS withdrawals_count,
              COALESCE((SELECT COUNT(*) FROM profiles p2 WHERE p2.referred_by = u.id), 0) AS referrals_count
            FROM users u
            LEFT JOIN profiles p ON p.user_id = u.id
            LEFT JOIN wallets w ON w.user_id = u.id
            WHERE u.deleted_at IS NULL
              AND (p.deleted_at IS NULL OR p.user_id IS NULL)
            ORDER BY u.created_at DESC
            LIMIT {$limit}";
    $items = $pdo->query($sql)->fetchAll();

    admin_log_action($pdo, $adminId, 'admin.users.list', null, ['limit' => $limit]);
    json_success([
        'items' => $items,
        'limit' => $limit,
    ]);
}

function admin_user_detail(PDO $pdo, string $targetUserId): void
{
    $adminId = admin_require($pdo);
    admin_assert_active_user($pdo, $targetUserId);

    try {
        $userStmt = $pdo->prepare("
            SELECT id, email, created_at, updated_at, deleted_at
            FROM users
            WHERE id = :id
              AND deleted_at IS NULL
            LIMIT 1
        ");

        $userStmt->execute([':id' => $targetUserId]);
        $user = $userStmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            json_error('Usuário não encontrado', 404);
        }

        // Profile query with safety for column names
        $profile = [];
        if (table_exists($pdo, 'profiles')) {
            $profileStmt = $pdo->prepare("
                SELECT *
                FROM profiles
                WHERE user_id = :id
                  AND deleted_at IS NULL
                LIMIT 1
            ");
            $profileStmt->execute([':id' => $targetUserId]);
            $profile = $profileStmt->fetch(PDO::FETCH_ASSOC) ?: [];
        }

        $wallet = [];
        if (table_exists($pdo, 'wallets')) {
            $walletStmt = $pdo->prepare("SELECT * FROM wallets WHERE user_id = :id LIMIT 1");
            $walletStmt->execute([':id' => $targetUserId]);
            $wallet = $walletStmt->fetch(PDO::FETCH_ASSOC) ?: [];
        }

        $recentDeposits = [];
        if (table_exists($pdo, 'deposits')) {
            $depStmt = $pdo->prepare("SELECT * FROM deposits WHERE user_id = :id ORDER BY created_at DESC LIMIT 10");
            $depStmt->execute([':id' => $targetUserId]);
            $recentDeposits = $depStmt->fetchAll(PDO::FETCH_ASSOC);
        }

        $recentWithdrawals = [];
        $withdrawalsTable = resolve_withdrawals_table($pdo);
        if ($withdrawalsTable && table_exists($pdo, $withdrawalsTable)) {
            $wdStmt = $pdo->prepare("SELECT * FROM `{$withdrawalsTable}` WHERE user_id = :id ORDER BY created_at DESC LIMIT 10");
            $wdStmt->execute([':id' => $targetUserId]);
            $recentWithdrawals = $wdStmt->fetchAll(PDO::FETCH_ASSOC);
        }

        $recentWalletTransactions = [];
        if (table_exists($pdo, 'wallet_transactions')) {
            $txStmt = $pdo->prepare("SELECT * FROM wallet_transactions WHERE user_id = :id ORDER BY created_at DESC LIMIT 20");
            $txStmt->execute([':id' => $targetUserId]);
            $recentWalletTransactions = $txStmt->fetchAll(PDO::FETCH_ASSOC);
        }

        $recentCommissions = [];
        if (table_exists($pdo, 'affiliate_commissions')) {
            // Check for column name (referral_user_id vs referred_user_id)
            $commTableInfo = $pdo->query("DESCRIBE affiliate_commissions")->fetchAll(PDO::FETCH_COLUMN);
            $referralCol = in_array('referred_user_id', $commTableInfo) ? 'referred_user_id' : 'referral_user_id';
            
            $commStmt = $pdo->prepare("
                SELECT *
                FROM affiliate_commissions
                WHERE affiliate_user_id = :affiliate_id
                   OR `{$referralCol}` = :referral_id
                ORDER BY created_at DESC
                LIMIT 20
            ");
            $commStmt->execute([
                ':affiliate_id' => $targetUserId,
                ':referral_id' => $targetUserId
            ]);
            $recentCommissions = $commStmt->fetchAll(PDO::FETCH_ASSOC);
        }

        admin_log_action($pdo, $adminId, 'admin.users.detail', $targetUserId);

        json_success([
            'user' => $user,
            'profile' => !empty($profile) ? $profile : new stdClass(),
            'wallet' => !empty($wallet) ? $wallet : new stdClass(),
            'recent_deposits' => $recentDeposits,
            'recent_withdrawals' => $recentWithdrawals,
            'recent_wallet_transactions' => $recentWalletTransactions,
            'recent_commissions' => $recentCommissions
        ]);

    } catch (Throwable $e) {
        error_log('[admin_user_detail] Error: ' . $e->getMessage());
        json_error('Erro ao carregar detalhes do usuário: ' . $e->getMessage(), 500);
    }
}


function admin_user_update_profile(PDO $pdo, string $targetUserId): void
{
    $adminId = admin_require($pdo);
    admin_assert_active_user($pdo, $targetUserId);
    $input = get_json_input();

    $fullName = trim((string)($input['full_name'] ?? ''));
    $phone = trim((string)($input['phone'] ?? ''));
    $cpf = trim((string)($input['cpf'] ?? ''));
    $usernameRaw = trim((string)($input['username'] ?? ''));
    $username = $usernameRaw !== '' ? strtolower($usernameRaw) : null;
    $isInfluencer = isset($input['is_influencer']) ? (int)(!!$input['is_influencer']) : null;
    $referredBy = trim((string)($input['referred_by'] ?? ''));

    $comissaoCpa = array_key_exists('comissao_cpa', $input) ? (float)$input['comissao_cpa'] : null;
    $comissaoCpaNivel2 = array_key_exists('comissao_cpa_nivel2', $input) ? (float)$input['comissao_cpa_nivel2'] : null;
    $customCommissionPercent = array_key_exists('custom_commission_percent', $input) ? (float)$input['custom_commission_percent'] : null;
    $customGameDifficulty = array_key_exists('custom_game_difficulty', $input) ? (float)$input['custom_game_difficulty'] : null;
    $customCoinReturn = array_key_exists('custom_coin_return', $input) ? (float)$input['custom_coin_return'] : null;
    $customGameSpeed = array_key_exists('custom_game_speed', $input) ? (float)$input['custom_game_speed'] : null;
    $customJumpHeight = array_key_exists('custom_jump_height', $input) ? (float)$input['custom_jump_height'] : null;
    $customBonusPercent = array_key_exists('custom_bonus_percent', $input) ? (float)$input['custom_bonus_percent'] : null;

    if ($username !== null) {
        if (!preg_match('/^[a-z0-9._-]{3,80}$/', $username)) {
            json_error('Invalid username', 422);
        }
        $chk = $pdo->prepare('SELECT user_id FROM profiles WHERE username = :u AND user_id <> :id LIMIT 1');
        $chk->execute([':u' => $username, ':id' => $targetUserId]);
        if ($chk->fetch()) {
            json_error('Username already in use', 409);
        }
    }

    $refTarget = null;
    if ($referredBy !== '') {
        $refChk = $pdo->prepare('SELECT id FROM users WHERE id = :id LIMIT 1');
        $refChk->execute([':id' => $referredBy]);
        if (!$refChk->fetch()) {
            json_error('referred_by user not found', 422);
        }
        $refTarget = $referredBy;
    }

    $stmt = $pdo->prepare('UPDATE profiles
                           SET full_name = :full_name,
                               phone = :phone,
                               cpf = :cpf,
                               username = :username,
                               is_influencer = COALESCE(:is_influencer, is_influencer),
                               referred_by = :referred_by,
                               comissao_cpa = :comissao_cpa,
                               comissao_cpa_nivel2 = :comissao_cpa_nivel2,
                               custom_commission_percent = :custom_commission_percent,
                               custom_game_difficulty = :custom_game_difficulty,
                               custom_coin_return = :custom_coin_return,
                               custom_game_speed = :custom_game_speed,
                               custom_jump_height = :custom_jump_height,
                               custom_bonus_percent = :custom_bonus_percent,
                               updated_at = CURRENT_TIMESTAMP
                           WHERE user_id = :user_id');
    $stmt->execute([
        ':full_name' => $fullName,
        ':phone' => $phone !== '' ? $phone : null,
        ':cpf' => $cpf !== '' ? $cpf : null,
        ':username' => $username,
        ':is_influencer' => $isInfluencer,
        ':referred_by' => $refTarget,
        ':comissao_cpa' => $comissaoCpa,
        ':comissao_cpa_nivel2' => $comissaoCpaNivel2,
        ':custom_commission_percent' => $customCommissionPercent,
        ':custom_game_difficulty' => $customGameDifficulty,
        ':custom_coin_return' => $customCoinReturn,
        ':custom_game_speed' => $customGameSpeed,
        ':custom_jump_height' => $customJumpHeight,
        ':custom_bonus_percent' => $customBonusPercent,
        ':user_id' => $targetUserId,
    ]);

    $fetch = $pdo->prepare('SELECT * FROM profiles WHERE user_id = :id LIMIT 1');
    $fetch->execute([':id' => $targetUserId]);
    $profile = $fetch->fetch();
    if (!$profile) json_error('Profile not found', 404);

    admin_log_action($pdo, $adminId, 'admin.users.profile.update', $targetUserId, [
        'updated_fields' => array_keys($input),
    ]);
    json_success(['profile' => $profile]);
}

function admin_user_update_auth(PDO $pdo, string $targetUserId): void
{
    $adminId = admin_require($pdo);
    admin_assert_active_user($pdo, $targetUserId);
    $input = get_json_input();

    $email = strtolower(trim((string)($input['email'] ?? '')));
    $password = isset($input['password']) ? (string)$input['password'] : null;

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        json_error('Invalid email', 422);
    }

    $dup = $pdo->prepare('SELECT id FROM users WHERE email = :email AND id <> :id LIMIT 1');
    $dup->execute([':email' => $email, ':id' => $targetUserId]);
    if ($dup->fetch()) {
        json_error('Email already in use', 409);
    }

    if ($password !== null && $password !== '' && strlen($password) < 6) {
        json_error('Password must have at least 6 characters', 422);
    }

    if ($password !== null && $password !== '') {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $pdo->prepare('UPDATE users SET email = :email, password_hash = :password_hash, updated_at = CURRENT_TIMESTAMP WHERE id = :id');
        $stmt->execute([':email' => $email, ':password_hash' => $hash, ':id' => $targetUserId]);
    } else {
        $stmt = $pdo->prepare('UPDATE users SET email = :email, updated_at = CURRENT_TIMESTAMP WHERE id = :id');
        $stmt->execute([':email' => $email, ':id' => $targetUserId]);
    }

    $pdo->prepare('UPDATE profiles SET email = :email, updated_at = CURRENT_TIMESTAMP WHERE user_id = :id')
        ->execute([':email' => $email, ':id' => $targetUserId]);

    $fetch = $pdo->prepare('SELECT id,email,created_at,updated_at,deleted_at FROM users WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $targetUserId]);
    $user = $fetch->fetch();
    if (!$user) json_error('User not found', 404);

    admin_log_action($pdo, $adminId, 'admin.users.auth.update', $targetUserId, [
        'email_updated' => true,
        'password_updated' => $password !== null && $password !== '',
    ]);
    json_success(['user' => $user]);
}

function admin_user_wallet_adjust(PDO $pdo, string $targetUserId): void
{
    $adminId = admin_require($pdo);
    admin_assert_active_user($pdo, $targetUserId);
    $input = get_json_input();

    $walletType = (string)($input['wallet_type'] ?? '');
    $operation = (string)($input['operation'] ?? '');
    $amount = (float)($input['amount'] ?? 0);
    $reason = trim((string)($input['reason'] ?? ''));

    if (!in_array($walletType, ['player', 'affiliate'], true)) json_error('Invalid wallet_type', 422);
    if (!in_array($operation, ['credit', 'debit'], true)) json_error('Invalid operation', 422);
    if ($amount <= 0) json_error('Invalid amount', 422);
    if ($reason === '') json_error('Reason is required', 422);

    try {
        $pdo->beginTransaction();
        $walletStmt = $pdo->prepare('SELECT player_balance, affiliate_balance FROM wallets WHERE user_id = :user_id LIMIT 1 FOR UPDATE');
        $walletStmt->execute([':user_id' => $targetUserId]);
        $wallet = $walletStmt->fetch();
        if (!$wallet) throw new RuntimeException('wallet_not_found');

        $current = $walletType === 'player' ? (float)$wallet['player_balance'] : (float)$wallet['affiliate_balance'];
        $delta = $operation === 'credit' ? $amount : -$amount;
        $new = round($current + $delta, 2);
        if ($new < 0) throw new RuntimeException('negative_balance');

        if ($walletType === 'player') {
            $upd = $pdo->prepare('UPDATE wallets SET player_balance = :new_balance, updated_at = CURRENT_TIMESTAMP WHERE user_id = :user_id');
        } else {
            $upd = $pdo->prepare('UPDATE wallets SET affiliate_balance = :new_balance, updated_at = CURRENT_TIMESTAMP WHERE user_id = :user_id');
        }
        $upd->execute([':new_balance' => $new, ':user_id' => $targetUserId]);

        $txType = "admin_{$operation}_{$walletType}";
        $tx = $pdo->prepare('INSERT INTO wallet_transactions
                            (user_id, admin_id, game_session_id, type, amount, balance_before, balance_after, reason, description)
                            VALUES
                            (:user_id, :admin_id, NULL, :type, :amount, :before, :after, :reason, :description)');
        $tx->execute([
            ':user_id' => $targetUserId,
            ':admin_id' => $adminId,
            ':type' => $txType,
            ':amount' => $delta,
            ':before' => $current,
            ':after' => $new,
            ':reason' => $reason,
            ':description' => 'Admin wallet adjustment',
        ]);

        admin_log_action($pdo, $adminId, 'admin.users.wallet.adjust', $targetUserId, [
            'wallet_type' => $walletType,
            'operation' => $operation,
            'amount' => $amount,
            'reason' => $reason,
            'balance_before' => $current,
            'balance_after' => $new,
        ]);

        $pdo->commit();
        json_success([
            'wallet_type' => $walletType,
            'operation' => $operation,
            'amount' => number_format($amount, 2, '.', ''),
            'balance_before' => number_format($current, 2, '.', ''),
            'balance_after' => number_format($new, 2, '.', ''),
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage() === 'wallet_not_found') json_error('Wallet not found', 404);
        if ($e->getMessage() === 'negative_balance') json_error('Operation would result in negative balance', 409);
        json_error('Failed to adjust wallet', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to adjust wallet', 500);
    }
}

function admin_user_soft_delete(PDO $pdo, string $targetUserId): void
{
    $adminId = admin_require($pdo);
    if ($targetUserId === $adminId) {
        json_error('Admin cannot delete own account', 403);
    }
    admin_assert_active_user($pdo, $targetUserId);

    try {
        $pdo->beginTransaction();
        $pdo->prepare('UPDATE users SET deleted_at = COALESCE(deleted_at, CURRENT_TIMESTAMP), updated_at = CURRENT_TIMESTAMP WHERE id = :id')
            ->execute([':id' => $targetUserId]);
        $pdo->prepare('UPDATE profiles SET deleted_at = COALESCE(deleted_at, CURRENT_TIMESTAMP), updated_at = CURRENT_TIMESTAMP WHERE user_id = :id')
            ->execute([':id' => $targetUserId]);
        $pdo->prepare('UPDATE auth_sessions SET revoked_at = CURRENT_TIMESTAMP WHERE user_id = :id AND revoked_at IS NULL')
            ->execute([':id' => $targetUserId]);

        admin_log_action($pdo, $adminId, 'admin.users.soft_delete', $targetUserId);
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to delete user', 500);
    }

    json_success([
        'user_id' => $targetUserId,
        'deleted' => true,
    ]);
}

function admin_deposits_list(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 50;
    if ($limit <= 0) $limit = 50;
    if ($limit > 200) $limit = 200;

    $status = isset($_GET['status']) ? trim((string)$_GET['status']) : '';
    $userId = isset($_GET['user_id']) ? trim((string)$_GET['user_id']) : '';

    $where = [];
    $params = [];
    if ($status !== '') {
        $where[] = 'd.status = :status';
        $params[':status'] = $status;
    }
    if ($userId !== '') {
        $where[] = 'd.user_id = :user_id';
        $params[':user_id'] = $userId;
    }
    $whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

    $sql = "SELECT
              d.id,
              d.user_id,
              u.email,
              p.full_name,
              p.username,
              d.amount,
              d.bonus_amount,
              COALESCE(d.total_credited, d.amount + COALESCE(d.bonus_amount,0)) AS total_credited,
              d.status,
              d.provider,
              d.gateway,
              COALESCE(d.transaction_id, d.external_id) AS transaction_id,
              d.created_at,
              d.paid_at
            FROM deposits d
            LEFT JOIN users u ON u.id = d.user_id
            LEFT JOIN profiles p ON p.user_id = d.user_id
            {$whereSql}
            ORDER BY d.created_at DESC
            LIMIT {$limit}";
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    admin_log_action($pdo, $adminId, 'admin.deposits.list', null, [
        'status' => $status !== '' ? $status : null,
        'user_id' => $userId !== '' ? $userId : null,
        'limit' => $limit,
    ]);

    json_success([
        'items' => $stmt->fetchAll(),
        'limit' => $limit,
    ]);
}

function admin_deposit_approve(PDO $pdo, string $depositId): void
{
    $adminId = admin_require($pdo);

    try {
        $pdo->beginTransaction();

        $depStmt = $pdo->prepare('SELECT id,user_id,amount,bonus_amount,total_credited,status,created_at
                                  FROM deposits
                                  WHERE id = :id
                                  LIMIT 1
                                  FOR UPDATE');
        $depStmt->execute([':id' => $depositId]);
        $deposit = $depStmt->fetch();
        if (!$deposit) throw new RuntimeException('deposit_not_found');
        if ($deposit['status'] !== 'pending') throw new RuntimeException('invalid_status');

        $targetUserId = (string)$deposit['user_id'];
        admin_assert_active_user($pdo, $targetUserId);

        $walletStmt = $pdo->prepare('SELECT player_balance,total_deposited
                                     FROM wallets
                                     WHERE user_id = :user_id
                                     LIMIT 1
                                     FOR UPDATE');
        $walletStmt->execute([':user_id' => $targetUserId]);
        $wallet = $walletStmt->fetch();
        if (!$wallet) throw new RuntimeException('wallet_not_found');

        $amount = (float)$deposit['amount'];
        $bonus = isset($deposit['bonus_amount']) ? (float)$deposit['bonus_amount'] : 0.0;
        $totalCredited = $deposit['total_credited'] !== null
            ? (float)$deposit['total_credited']
            : round($amount + $bonus, 2);
        if ($totalCredited < 0) $totalCredited = 0.0;

        $before = (float)$wallet['player_balance'];
        $after = round($before + $totalCredited, 2);

        $updWallet = $pdo->prepare('UPDATE wallets
                                    SET player_balance = :player_balance,
                                        total_deposited = total_deposited + :credited,
                                        updated_at = CURRENT_TIMESTAMP
                                    WHERE user_id = :user_id');
        $updWallet->execute([
            ':player_balance' => $after,
            ':credited' => $totalCredited,
            ':user_id' => $targetUserId,
        ]);

        $updDeposit = $pdo->prepare('UPDATE deposits
                                     SET status = :status,
                                         total_credited = :total_credited,
                                         admin_id = :admin_id,
                                         paid_at = CURRENT_TIMESTAMP,
                                         updated_at = CURRENT_TIMESTAMP
                                     WHERE id = :id');
        $updDeposit->execute([
            ':status' => 'paid',
            ':total_credited' => $totalCredited,
            ':admin_id' => $adminId,
            ':id' => $depositId,
        ]);

        $tx = $pdo->prepare('INSERT INTO wallet_transactions
                             (user_id, admin_id, game_session_id, type, amount, balance_before, balance_after, reason, description)
                             VALUES
                             (:user_id, :admin_id, NULL, :type, :amount, :before, :after, :reason, :description)');
        $tx->execute([
            ':user_id' => $targetUserId,
            ':admin_id' => $adminId,
            ':type' => 'deposit',
            ':amount' => $totalCredited,
            ':before' => $before,
            ':after' => $after,
            ':reason' => 'Manual deposit approval',
            ':description' => 'Admin approved deposit',
        ]);

        $commissionResult = process_affiliate_commission_for_paid_deposit($pdo, $deposit, $totalCredited);

        admin_log_action($pdo, $adminId, 'admin.deposits.approve', $targetUserId, [
            'deposit_id' => $depositId,
            'amount' => $amount,
            'bonus_amount' => $bonus,
            'total_credited' => $totalCredited,
            'commission_result' => $commissionResult,
        ]);

        $pdo->commit();
        json_success([
            'deposit_id' => $depositId,
            'status' => 'paid',
            'credited_amount' => number_format($totalCredited, 2, '.', ''),
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage() === 'deposit_not_found') json_error('Deposit not found', 404);
        if ($e->getMessage() === 'wallet_not_found') json_error('Wallet not found', 404);
        if ($e->getMessage() === 'invalid_status') json_error('Deposit is not pending', 409);
        json_error('Failed to approve deposit', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to approve deposit', 500);
    }
}

function admin_deposit_reject(PDO $pdo, string $depositId): void
{
    $adminId = admin_require($pdo);

    try {
        $pdo->beginTransaction();
        $depStmt = $pdo->prepare('SELECT id,user_id,status
                                  FROM deposits
                                  WHERE id = :id
                                  LIMIT 1
                                  FOR UPDATE');
        $depStmt->execute([':id' => $depositId]);
        $deposit = $depStmt->fetch();
        if (!$deposit) throw new RuntimeException('deposit_not_found');
        if ($deposit['status'] !== 'pending') throw new RuntimeException('invalid_status');

        $upd = $pdo->prepare('UPDATE deposits
                              SET status = :status,
                                  admin_id = :admin_id,
                                  rejected_at = CURRENT_TIMESTAMP,
                                  updated_at = CURRENT_TIMESTAMP
                              WHERE id = :id');
        $upd->execute([
            ':status' => 'rejected',
            ':admin_id' => $adminId,
            ':id' => $depositId,
        ]);

        admin_log_action($pdo, $adminId, 'admin.deposits.reject', (string)$deposit['user_id'], [
            'deposit_id' => $depositId,
        ]);

        $pdo->commit();
        json_success([
            'deposit_id' => $depositId,
            'status' => 'rejected',
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage() === 'deposit_not_found') json_error('Deposit not found', 404);
        if ($e->getMessage() === 'invalid_status') json_error('Deposit is not pending', 409);
        json_error('Failed to reject deposit', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to reject deposit', 500);
    }
}

function admin_withdrawals_list(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 50;
    if ($limit <= 0) $limit = 50;
    if ($limit > 200) $limit = 200;

    $status = isset($_GET['status']) ? trim((string)$_GET['status']) : '';
    $userId = isset($_GET['user_id']) ? trim((string)$_GET['user_id']) : '';

    $where = [];
    $params = [];
    if ($status !== '') {
        $where[] = 'w.status = :status';
        $params[':status'] = $status;
    }
    if ($userId !== '') {
        $where[] = 'w.user_id = :user_id';
        $params[':user_id'] = $userId;
    }
    $whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

    $sql = "SELECT
              w.id,
              w.user_id,
              u.email,
              p.full_name,
              p.username,
              w.amount,
              w.wallet_type,
              w.pix_key,
              w.pix_key_type,
              w.status,
              w.created_at,
              w.processed_at,
              w.paid_at
            FROM withdrawals w
            LEFT JOIN users u ON u.id = w.user_id
            LEFT JOIN profiles p ON p.user_id = w.user_id
            {$whereSql}
            ORDER BY w.created_at DESC
            LIMIT {$limit}";
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    admin_log_action($pdo, $adminId, 'admin.withdrawals.list', null, [
        'status' => $status !== '' ? $status : null,
        'user_id' => $userId !== '' ? $userId : null,
        'limit' => $limit,
    ]);

    json_success([
        'items' => $stmt->fetchAll(),
        'limit' => $limit,
    ]);
}

function admin_withdrawal_approve(PDO $pdo, string $withdrawalId): void
{
    $adminId = admin_require($pdo);

    try {
        $pdo->beginTransaction();
        $stmt = $pdo->prepare('SELECT id,user_id,status,wallet_type,amount
                               FROM withdrawals
                               WHERE id = :id
                               LIMIT 1
                               FOR UPDATE');
        $stmt->execute([':id' => $withdrawalId]);
        $withdrawal = $stmt->fetch();
        if (!$withdrawal) throw new RuntimeException('withdrawal_not_found');
        if ($withdrawal['status'] !== 'pending') throw new RuntimeException('invalid_status');

        admin_assert_active_user($pdo, (string)$withdrawal['user_id']);

        $upd = $pdo->prepare('UPDATE withdrawals
                              SET status = :status,
                                  admin_id = :admin_id,
                                  processed_at = CURRENT_TIMESTAMP,
                                  updated_at = CURRENT_TIMESTAMP
                              WHERE id = :id');
        $upd->execute([
            ':status' => 'approved',
            ':admin_id' => $adminId,
            ':id' => $withdrawalId,
        ]);

        admin_log_action($pdo, $adminId, 'admin.withdrawals.approve', (string)$withdrawal['user_id'], [
            'withdrawal_id' => $withdrawalId,
            'amount' => (float)$withdrawal['amount'],
            'wallet_type' => (string)$withdrawal['wallet_type'],
        ]);

        $pdo->commit();
        json_success([
            'withdrawal_id' => $withdrawalId,
            'status' => 'approved',
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage() === 'withdrawal_not_found') json_error('Withdrawal not found', 404);
        if ($e->getMessage() === 'invalid_status') json_error('Withdrawal must be pending', 409);
        json_error('Failed to approve withdrawal', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to approve withdrawal', 500);
    }
}

function admin_withdrawal_cancel(PDO $pdo, string $withdrawalId): void
{
    $adminId = admin_require($pdo);

    try {
        $pdo->beginTransaction();
        $stmt = $pdo->prepare('SELECT id,user_id,status,wallet_type,amount
                               FROM withdrawals
                               WHERE id = :id
                               LIMIT 1
                               FOR UPDATE');
        $stmt->execute([':id' => $withdrawalId]);
        $withdrawal = $stmt->fetch();
        if (!$withdrawal) throw new RuntimeException('withdrawal_not_found');
        if (!in_array($withdrawal['status'], ['pending', 'approved'], true)) {
            throw new RuntimeException('invalid_status');
        }

        $targetUserId = (string)$withdrawal['user_id'];
        admin_assert_active_user($pdo, $targetUserId);

        $walletStmt = $pdo->prepare('SELECT player_balance, affiliate_balance
                                     FROM wallets
                                     WHERE user_id = :user_id
                                     LIMIT 1
                                     FOR UPDATE');
        $walletStmt->execute([':user_id' => $targetUserId]);
        $wallet = $walletStmt->fetch();
        if (!$wallet) throw new RuntimeException('wallet_not_found');

        $amount = (float)$withdrawal['amount'];
        $walletType = (string)$withdrawal['wallet_type'];
        $before = $walletType === 'affiliate' ? (float)$wallet['affiliate_balance'] : (float)$wallet['player_balance'];
        $after = round($before + $amount, 2);

        if ($walletType === 'affiliate') {
            $updWallet = $pdo->prepare('UPDATE wallets
                                        SET affiliate_balance = :new_balance,
                                            total_withdrawn = GREATEST(total_withdrawn - :amount, 0),
                                            updated_at = CURRENT_TIMESTAMP
                                        WHERE user_id = :user_id');
        } else {
            $updWallet = $pdo->prepare('UPDATE wallets
                                        SET player_balance = :new_balance,
                                            total_withdrawn = GREATEST(total_withdrawn - :amount, 0),
                                            updated_at = CURRENT_TIMESTAMP
                                        WHERE user_id = :user_id');
        }
        $updWallet->execute([
            ':new_balance' => $after,
            ':amount' => $amount,
            ':user_id' => $targetUserId,
        ]);

        $updWithdrawal = $pdo->prepare('UPDATE withdrawals
                                        SET status = :status,
                                            admin_id = :admin_id,
                                            rejected_at = CURRENT_TIMESTAMP,
                                            processed_at = CURRENT_TIMESTAMP,
                                            updated_at = CURRENT_TIMESTAMP
                                        WHERE id = :id');
        $updWithdrawal->execute([
            ':status' => 'canceled',
            ':admin_id' => $adminId,
            ':id' => $withdrawalId,
        ]);

        $tx = $pdo->prepare('INSERT INTO wallet_transactions
                             (user_id, admin_id, game_session_id, type, amount, balance_before, balance_after, reason, description)
                             VALUES
                             (:user_id, :admin_id, NULL, :type, :amount, :before, :after, :reason, :description)');
        $tx->execute([
            ':user_id' => $targetUserId,
            ':admin_id' => $adminId,
            ':type' => 'withdrawal_refund',
            ':amount' => $amount,
            ':before' => $before,
            ':after' => $after,
            ':reason' => 'Admin canceled withdrawal',
            ':description' => 'Withdrawal refunded',
        ]);

        admin_log_action($pdo, $adminId, 'admin.withdrawals.cancel', $targetUserId, [
            'withdrawal_id' => $withdrawalId,
            'wallet_type' => $walletType,
            'refunded_amount' => $amount,
        ]);

        $pdo->commit();
        json_success([
            'withdrawal_id' => $withdrawalId,
            'status' => 'canceled',
            'refunded_amount' => number_format($amount, 2, '.', ''),
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage() === 'withdrawal_not_found') json_error('Withdrawal not found', 404);
        if ($e->getMessage() === 'wallet_not_found') json_error('Wallet not found', 404);
        if ($e->getMessage() === 'invalid_status') json_error('Withdrawal must be pending or approved', 409);
        json_error('Failed to cancel withdrawal', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to cancel withdrawal', 500);
    }
}

function admin_reject_unknown_fields(array $input, array $allowed): void
{
    $unknown = array_diff(array_keys($input), $allowed);
    if (!empty($unknown)) {
        json_error('Unknown fields: ' . implode(', ', $unknown), 422);
    }
}

function admin_to_bool($value): int
{
    if (is_bool($value)) return $value ? 1 : 0;
    if (is_int($value)) return $value !== 0 ? 1 : 0;
    $str = strtolower(trim((string)$value));
    return in_array($str, ['1', 'true', 'yes', 'on'], true) ? 1 : 0;
}

function admin_ensure_single_settings_row(PDO $pdo, string $table): string
{
    $stmt = $pdo->query("SELECT id FROM `{$table}` ORDER BY updated_at DESC LIMIT 1");
    $row = $stmt->fetch();
    if ($row && isset($row['id']) && (string)$row['id'] !== '') {
        return (string)$row['id'];
    }

    $id = uuid_v4();
    $ins = $pdo->prepare("INSERT INTO `{$table}` (id) VALUES (:id)");
    $ins->execute([':id' => $id]);
    return $id;
}

function admin_game_settings_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $stmt = $pdo->query('SELECT id,difficulty,difficulty_per_level,coin_return,game_speed,jump_height,game_title,game_subtitle,
                                login_banner_url,register_banner_url,rtp_global,coin_frequency,spring_frequency,spring_boost,
                                moving_platform_speed_multiplier,progressive_distance_multiplier,difficulty_rtp_balance,common_player_coin_percentage,
                                created_at,updated_at
                         FROM game_settings
                         ORDER BY updated_at DESC
                         LIMIT 1');
    $row = $stmt->fetch();
    admin_log_action($pdo, $adminId, 'admin.game_settings.view');
    $settings = $row ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_game_settings_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'difficulty','difficulty_per_level','coin_return','game_speed','jump_height','game_title','game_subtitle',
        'login_banner_url','register_banner_url','rtp_global','coin_frequency','spring_frequency','spring_boost',
        'moving_platform_speed_multiplier','progressive_distance_multiplier','difficulty_rtp_balance','common_player_coin_percentage',
    ];
    admin_reject_unknown_fields($input, $allowed);

    $id = admin_ensure_single_settings_row($pdo, 'game_settings');

    $mapped = [
        'difficulty' => isset($input['difficulty']) ? (float)$input['difficulty'] : null,
        'difficulty_per_level' => isset($input['difficulty_per_level']) ? (int)$input['difficulty_per_level'] : null,
        'coin_return' => isset($input['coin_return']) ? (float)$input['coin_return'] : null,
        'game_speed' => isset($input['game_speed']) ? (float)$input['game_speed'] : null,
        'jump_height' => isset($input['jump_height']) ? (float)$input['jump_height'] : null,
        'game_title' => array_key_exists('game_title', $input) ? trim((string)$input['game_title']) : null,
        'game_subtitle' => array_key_exists('game_subtitle', $input) ? trim((string)$input['game_subtitle']) : null,
        'login_banner_url' => array_key_exists('login_banner_url', $input) ? trim((string)$input['login_banner_url']) : null,
        'register_banner_url' => array_key_exists('register_banner_url', $input) ? trim((string)$input['register_banner_url']) : null,
        'rtp_global' => isset($input['rtp_global']) ? (float)$input['rtp_global'] : null,
        'coin_frequency' => isset($input['coin_frequency']) ? (float)$input['coin_frequency'] : null,
        'spring_frequency' => isset($input['spring_frequency']) ? (float)$input['spring_frequency'] : null,
        'spring_boost' => isset($input['spring_boost']) ? (float)$input['spring_boost'] : null,
        'moving_platform_speed_multiplier' => isset($input['moving_platform_speed_multiplier']) ? (float)$input['moving_platform_speed_multiplier'] : null,
        'progressive_distance_multiplier' => isset($input['progressive_distance_multiplier']) ? (float)$input['progressive_distance_multiplier'] : null,
        'difficulty_rtp_balance' => isset($input['difficulty_rtp_balance']) ? (float)$input['difficulty_rtp_balance'] : null,
        'common_player_coin_percentage' => isset($input['common_player_coin_percentage']) ? (float)$input['common_player_coin_percentage'] : null,
    ];

    $sets = [];
    $params = [':id' => $id];
    foreach ($mapped as $field => $value) {
        if (array_key_exists($field, $input)) {
            $sets[] = "{$field} = :{$field}";
            $params[":{$field}"] = $value === '' ? null : $value;
        }
    }
    if (empty($sets)) {
        json_error('No valid fields provided', 422);
    }

    $sql = 'UPDATE game_settings SET ' . implode(', ', $sets) . ', updated_at = CURRENT_TIMESTAMP WHERE id = :id';
    $upd = $pdo->prepare($sql);
    $upd->execute($params);

    $fetch = $pdo->prepare('SELECT id,difficulty,difficulty_per_level,coin_return,game_speed,jump_height,game_title,game_subtitle,
                                   login_banner_url,register_banner_url,rtp_global,coin_frequency,spring_frequency,spring_boost,
                                   moving_platform_speed_multiplier,progressive_distance_multiplier,difficulty_rtp_balance,common_player_coin_percentage,
                                   created_at,updated_at
                            FROM game_settings
                            WHERE id = :id
                            LIMIT 1');
    $fetch->execute([':id' => $id]);
    $updated = $fetch->fetch();

    admin_log_action($pdo, $adminId, 'admin.game_settings.update', null, ['updated_fields' => array_keys($input)]);
    $settings = $updated ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_financial_settings_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $stmt = $pdo->query('SELECT *
                         FROM financial_settings
                         ORDER BY updated_at DESC
                         LIMIT 1');
    $row = $stmt->fetch();
    if ($row) {
        $playerMin = isset($row['min_withdrawal_player']) ? (float)$row['min_withdrawal_player'] : 0.0;
        $affiliateMin = isset($row['min_withdrawal_affiliate']) ? (float)$row['min_withdrawal_affiliate'] : 0.0;
        $row['minimum_withdrawal_amount'] = max($playerMin, $affiliateMin);
    }
    admin_log_action($pdo, $adminId, 'admin.financial_settings.view');
    $settings = $row ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_financial_settings_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'min_deposit','min_withdrawal_player','min_withdrawal_affiliate',
        'minimum_withdrawal_amount',
        'deposit_bonus_enabled','deposit_bonus_percent','deposit_bonus_min_amount',
        'deposit_card_1','deposit_card_2','deposit_card_3','deposit_card_4',
    ];
    admin_reject_unknown_fields($input, $allowed);

    $id = admin_ensure_single_settings_row($pdo, 'financial_settings');

    $minimumWithdrawalAmount = array_key_exists('minimum_withdrawal_amount', $input)
        ? max(0.0, (float)$input['minimum_withdrawal_amount'])
        : null;
    $mapped = [
        'min_deposit' => isset($input['min_deposit']) ? max(0.0, (float)$input['min_deposit']) : null,
        'min_withdrawal_player' => isset($input['min_withdrawal_player']) ? max(0.0, (float)$input['min_withdrawal_player']) : null,
        'min_withdrawal_affiliate' => isset($input['min_withdrawal_affiliate']) ? max(0.0, (float)$input['min_withdrawal_affiliate']) : null,
        'deposit_bonus_enabled' => array_key_exists('deposit_bonus_enabled', $input) ? admin_to_bool($input['deposit_bonus_enabled']) : null,
        'deposit_bonus_percent' => isset($input['deposit_bonus_percent']) ? max(0.0, (float)$input['deposit_bonus_percent']) : null,
        'deposit_bonus_min_amount' => isset($input['deposit_bonus_min_amount']) ? max(0.0, (float)$input['deposit_bonus_min_amount']) : null,
        'deposit_card_1' => array_key_exists('deposit_card_1', $input) ? max(0.0, (float)$input['deposit_card_1']) : null,
        'deposit_card_2' => array_key_exists('deposit_card_2', $input) ? max(0.0, (float)$input['deposit_card_2']) : null,
        'deposit_card_3' => array_key_exists('deposit_card_3', $input) ? max(0.0, (float)$input['deposit_card_3']) : null,
        'deposit_card_4' => array_key_exists('deposit_card_4', $input) ? max(0.0, (float)$input['deposit_card_4']) : null,
    ];
    if ($minimumWithdrawalAmount !== null) {
        $mapped['min_withdrawal_player'] = $minimumWithdrawalAmount;
        $mapped['min_withdrawal_affiliate'] = $minimumWithdrawalAmount;
        $input['min_withdrawal_player'] = $minimumWithdrawalAmount;
        $input['min_withdrawal_affiliate'] = $minimumWithdrawalAmount;
    }

    $sets = [];
    $params = [':id' => $id];
    foreach ($mapped as $field => $value) {
        if (array_key_exists($field, $input)) {
            $sets[] = "{$field} = :{$field}";
            $params[":{$field}"] = $value;
        }
    }
    if (empty($sets)) json_error('No valid fields provided', 422);

    $sql = 'UPDATE financial_settings SET ' . implode(', ', $sets) . ', updated_at = CURRENT_TIMESTAMP WHERE id = :id';
    $upd = $pdo->prepare($sql);
    $upd->execute($params);

    $fetch = $pdo->prepare('SELECT * FROM financial_settings WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $id]);
    $updated = $fetch->fetch();
    if ($updated) {
        $playerMin = isset($updated['min_withdrawal_player']) ? (float)$updated['min_withdrawal_player'] : 0.0;
        $affiliateMin = isset($updated['min_withdrawal_affiliate']) ? (float)$updated['min_withdrawal_affiliate'] : 0.0;
        $updated['minimum_withdrawal_amount'] = max($playerMin, $affiliateMin);
    }

    admin_log_action($pdo, $adminId, 'admin.financial_settings.update', null, ['updated_fields' => array_keys($input)]);
    $settings = $updated ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_commission_settings_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $row = $pdo->query('SELECT * FROM commission_settings ORDER BY updated_at DESC LIMIT 1')->fetch();
    admin_log_action($pdo, $adminId, 'admin.commission_settings.view');
    $settings = $row ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_commission_settings_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'default_commission_percent',
        'default_commission_percent_level2',
        'first_deposit_only',
        'min_deposit_for_commission',
        'affiliate_skip_interval',
        'is_active',
    ];
    admin_reject_unknown_fields($input, $allowed);

    if (array_key_exists('default_commission_percent', $input)) {
        if (!is_numeric($input['default_commission_percent'])) {
            json_error('default_commission_percent must be a number', 422);
        }
        $v = (float)$input['default_commission_percent'];
        if ($v < 0 || $v > 100) {
            json_error('default_commission_percent must be between 0 and 100', 422);
        }
    }

    if (array_key_exists('default_commission_percent_level2', $input)) {
        if (!is_numeric($input['default_commission_percent_level2'])) {
            json_error('default_commission_percent_level2 must be a number', 422);
        }
        $v = (float)$input['default_commission_percent_level2'];
        if ($v < 0 || $v > 100) {
            json_error('default_commission_percent_level2 must be between 0 and 100', 422);
        }
    }

    if (array_key_exists('min_deposit_for_commission', $input)) {
        if (!is_numeric($input['min_deposit_for_commission'])) {
            json_error('min_deposit_for_commission must be a number', 422);
        }
        $v = (float)$input['min_deposit_for_commission'];
        if ($v < 0) {
            json_error('min_deposit_for_commission must be greater than or equal to 0', 422);
        }
    }

    if (array_key_exists('affiliate_skip_interval', $input)) {
        if (filter_var($input['affiliate_skip_interval'], FILTER_VALIDATE_INT) === false) {
            json_error('affiliate_skip_interval must be an integer', 422);
        }
        $v = (int)$input['affiliate_skip_interval'];
        if ($v < 0 || $v > 10) {
            json_error('affiliate_skip_interval must be between 0 and 10', 422);
        }
    }

    $id = admin_ensure_single_settings_row($pdo, 'commission_settings');

    $mapped = [
        'default_commission_percent' => isset($input['default_commission_percent']) ? (float)$input['default_commission_percent'] : null,
        'default_commission_percent_level2' => isset($input['default_commission_percent_level2']) ? (float)$input['default_commission_percent_level2'] : null,
        'first_deposit_only' => array_key_exists('first_deposit_only', $input) ? admin_to_bool($input['first_deposit_only']) : null,
        'min_deposit_for_commission' => isset($input['min_deposit_for_commission']) ? (float)$input['min_deposit_for_commission'] : null,
        'affiliate_skip_interval' => isset($input['affiliate_skip_interval']) ? (int)$input['affiliate_skip_interval'] : null,
        'is_active' => array_key_exists('is_active', $input) ? admin_to_bool($input['is_active']) : null,
    ];

    $sets = [];
    $params = [':id' => $id];
    foreach ($mapped as $field => $value) {
        if (array_key_exists($field, $input)) {
            $sets[] = "{$field} = :{$field}";
            $params[":{$field}"] = $value;
        }
    }
    if (empty($sets)) json_error('No valid fields provided', 422);

    $upd = $pdo->prepare('UPDATE commission_settings SET ' . implode(', ', $sets) . ', updated_at = CURRENT_TIMESTAMP WHERE id = :id');
    $upd->execute($params);

    $fetch = $pdo->prepare('SELECT * FROM commission_settings WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $id]);
    $updated = $fetch->fetch();

    admin_log_action($pdo, $adminId, 'admin.commission_settings.update', null, ['updated_fields' => array_keys($input)]);
    $settings = $updated ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_influencer_settings_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $row = $pdo->query('SELECT * FROM influencer_settings ORDER BY updated_at DESC LIMIT 1')->fetch();
    admin_log_action($pdo, $adminId, 'admin.influencer_settings.view');
    $settings = $row ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_influencer_settings_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'gain_multiplier',
        'difficulty_reduction',
        'coin_return',
        'jump_multiplier',
        'influencer_coin_percentage',
        'influencer_calculation_mode',
        'influencer_jump_multiplier_v2',
        'influencer_fixed_coin_value_v2',
        'influencer_double_coins_v2',
    ];
    admin_reject_unknown_fields($input, $allowed);

    $nonNegativeNumericFields = [
        'gain_multiplier',
        'difficulty_reduction',
        'coin_return',
        'jump_multiplier',
        'influencer_coin_percentage',
        'influencer_jump_multiplier_v2',
        'influencer_fixed_coin_value_v2',
    ];
    foreach ($nonNegativeNumericFields as $field) {
        if (array_key_exists($field, $input)) {
            if (!is_numeric($input[$field])) {
                json_error("{$field} must be a number", 422);
            }
            if ((float)$input[$field] < 0) {
                json_error("{$field} must be greater than or equal to 0", 422);
            }
        }
    }

    $maxConstraints = [
        'gain_multiplier' => 10.0,
        'difficulty_reduction' => 90.0,
        'coin_return' => 10000.0,
        'jump_multiplier' => 3.0,
        'influencer_coin_percentage' => 100.0,
        'influencer_jump_multiplier_v2' => 5.0,
        'influencer_fixed_coin_value_v2' => 10000.0,
    ];
    foreach ($maxConstraints as $field => $max) {
        if (array_key_exists($field, $input) && is_numeric($input[$field]) && (float)$input[$field] > $max) {
            json_error("{$field} must be less than or equal to {$max}", 422);
        }
    }

    if (array_key_exists('influencer_jump_multiplier_v2', $input) && (float)$input['influencer_jump_multiplier_v2'] < 1) {
        json_error('influencer_jump_multiplier_v2 must be greater than or equal to 1', 422);
    }
    if (array_key_exists('influencer_fixed_coin_value_v2', $input) && (float)$input['influencer_fixed_coin_value_v2'] < 1) {
        json_error('influencer_fixed_coin_value_v2 must be greater than or equal to 1', 422);
    }

    if (array_key_exists('influencer_calculation_mode', $input)) {
        $mode = trim((string)$input['influencer_calculation_mode']);
        $allowedModes = ['multiplier', 'percentage', 'fixed'];
        if (!in_array($mode, $allowedModes, true)) {
            json_error('influencer_calculation_mode must be one of: multiplier, percentage, fixed', 422);
        }
    }

    $id = admin_ensure_single_settings_row($pdo, 'influencer_settings');

    $mapped = [
        'gain_multiplier' => isset($input['gain_multiplier']) ? (float)$input['gain_multiplier'] : null,
        'difficulty_reduction' => isset($input['difficulty_reduction']) ? (float)$input['difficulty_reduction'] : null,
        'coin_return' => isset($input['coin_return']) ? (float)$input['coin_return'] : null,
        'jump_multiplier' => isset($input['jump_multiplier']) ? (float)$input['jump_multiplier'] : null,
        'influencer_coin_percentage' => isset($input['influencer_coin_percentage']) ? (float)$input['influencer_coin_percentage'] : null,
        'influencer_calculation_mode' => array_key_exists('influencer_calculation_mode', $input) ? trim((string)$input['influencer_calculation_mode']) : null,
        'influencer_jump_multiplier_v2' => isset($input['influencer_jump_multiplier_v2']) ? (float)$input['influencer_jump_multiplier_v2'] : null,
        'influencer_fixed_coin_value_v2' => isset($input['influencer_fixed_coin_value_v2']) ? (float)$input['influencer_fixed_coin_value_v2'] : null,
        'influencer_double_coins_v2' => array_key_exists('influencer_double_coins_v2', $input) ? admin_to_bool($input['influencer_double_coins_v2']) : null,
    ];

    $sets = [];
    $params = [':id' => $id];
    foreach ($mapped as $field => $value) {
        if (array_key_exists($field, $input)) {
            $sets[] = "{$field} = :{$field}";
            $params[":{$field}"] = $value;
        }
    }
    if (empty($sets)) json_error('No valid fields provided', 422);

    $upd = $pdo->prepare('UPDATE influencer_settings SET ' . implode(', ', $sets) . ', updated_at = CURRENT_TIMESTAMP WHERE id = :id');
    $upd->execute($params);

    $fetch = $pdo->prepare('SELECT * FROM influencer_settings WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $id]);
    $updated = $fetch->fetch();

    admin_log_action($pdo, $adminId, 'admin.influencer_settings.update', null, ['updated_fields' => array_keys($input)]);
    $settings = $updated ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_character_settings_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $row = $pdo->query('SELECT * FROM character_settings ORDER BY updated_at DESC LIMIT 1')->fetch();
    admin_log_action($pdo, $adminId, 'admin.character_settings.view');
    $settings = $row ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_character_settings_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'character_name',
        'character_image_url',
        'bg_music_url',
        'bg_music_enabled',
        'jump_sound_url',
        'land_sound_url',
        'spring_sound_url',
        'coin_sound_url',
    ];
    admin_reject_unknown_fields($input, $allowed);

    $id = admin_ensure_single_settings_row($pdo, 'character_settings');

    $mapped = [
        'character_name' => array_key_exists('character_name', $input) ? trim((string)$input['character_name']) : null,
        'character_image_url' => array_key_exists('character_image_url', $input) ? trim((string)$input['character_image_url']) : null,
        'bg_music_url' => array_key_exists('bg_music_url', $input) ? trim((string)$input['bg_music_url']) : null,
        'bg_music_enabled' => array_key_exists('bg_music_enabled', $input) ? admin_to_bool($input['bg_music_enabled']) : null,
        'jump_sound_url' => array_key_exists('jump_sound_url', $input) ? trim((string)$input['jump_sound_url']) : null,
        'land_sound_url' => array_key_exists('land_sound_url', $input) ? trim((string)$input['land_sound_url']) : null,
        'spring_sound_url' => array_key_exists('spring_sound_url', $input) ? trim((string)$input['spring_sound_url']) : null,
        'coin_sound_url' => array_key_exists('coin_sound_url', $input) ? trim((string)$input['coin_sound_url']) : null,
    ];

    $sets = [];
    $params = [':id' => $id];
    foreach ($mapped as $field => $value) {
        if (array_key_exists($field, $input)) {
            $sets[] = "{$field} = :{$field}";
            $params[":{$field}"] = $value === '' ? null : $value;
        }
    }
    if (empty($sets)) json_error('No valid fields provided', 422);

    $upd = $pdo->prepare('UPDATE character_settings SET ' . implode(', ', $sets) . ', updated_at = CURRENT_TIMESTAMP WHERE id = :id');
    $upd->execute($params);

    $fetch = $pdo->prepare('SELECT * FROM character_settings WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $id]);
    $updated = $fetch->fetch();

    admin_log_action($pdo, $adminId, 'admin.character_settings.update', null, ['updated_fields' => array_keys($input)]);
    $settings = $updated ?: [];
    if (!is_array($settings)) {
        $settings = [];
    }
    json_success(array_merge($settings, ['settings' => $settings]));
}

function admin_game_asset_upload(PDO $pdo): void
{
    $adminId = admin_require($pdo);

    if (!isset($_FILES['file']) || !is_array($_FILES['file'])) {
        json_error('Arquivo não enviado', 422);
    }

    $file = $_FILES['file'];
    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
        json_error('Falha no upload do arquivo', 422);
    }

    $tmpPath = (string)($file['tmp_name'] ?? '');
    $originalName = (string)($file['name'] ?? '');
    $size = (int)($file['size'] ?? 0);

    if ($tmpPath === '' || !is_uploaded_file($tmpPath)) {
        json_error('Arquivo inválido', 422);
    }
    if ($size <= 0 || $size > 10 * 1024 * 1024) {
        json_error('Arquivo deve ter no máximo 10MB', 422);
    }

    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    $allowedExtensions = ['mp3', 'wav', 'ogg', 'webm'];
    if (!in_array($extension, $allowedExtensions, true)) {
        json_error('Extensão não permitida. Use mp3, wav, ogg ou webm', 422);
    }

    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $mime = (string)$finfo->file($tmpPath);
    $allowedMimes = [
        'audio/mpeg',
        'audio/mp3',
        'audio/wav',
        'audio/x-wav',
        'audio/wave',
        'audio/ogg',
        'audio/webm',
        'video/webm',
        'application/ogg',
    ];
    if (!in_array($mime, $allowedMimes, true)) {
        json_error('Tipo de arquivo não permitido', 422);
    }

    $projectRoot = dirname(__DIR__, 2);
    $relativeDir = '/uploads/game-assets/audio';
    $targetDir = $projectRoot . $relativeDir;
    if (!is_dir($targetDir) && !mkdir($targetDir, 0775, true) && !is_dir($targetDir)) {
        json_error('Não foi possível criar diretório de upload', 500);
    }

    $safeBase = preg_replace('/[^a-zA-Z0-9._-]/', '_', pathinfo($originalName, PATHINFO_FILENAME));
    if ($safeBase === '' || $safeBase === null) {
        $safeBase = 'audio';
    }
    $finalName = $safeBase . '_' . date('YmdHis') . '_' . substr(uuid_v4(), 0, 8) . '.' . $extension;
    $targetPath = $targetDir . DIRECTORY_SEPARATOR . $finalName;

    if (!move_uploaded_file($tmpPath, $targetPath)) {
        json_error('Falha ao salvar arquivo no servidor', 500);
    }

    $url = $relativeDir . '/' . $finalName;
    admin_log_action($pdo, $adminId, 'admin.game_assets.upload', null, [
        'filename' => $finalName,
        'mime' => $mime,
        'size' => $size,
    ]);

    json_success([
        'url' => $url,
        'filename' => $finalName,
    ]);
}

function admin_banners_upload(PDO $pdo): void
{
    $adminId = admin_require($pdo);

    if (!isset($_FILES['file'])) {
        json_error('Arquivo não enviado', 422);
    }

    $file = $_FILES['file'];
    if (!is_array($file) || ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
        json_error('Falha no upload do arquivo', 422);
    }

    $tmpPath = (string)($file['tmp_name'] ?? '');
    $originalName = (string)($file['name'] ?? '');
    if ($tmpPath === '' || !is_uploaded_file($tmpPath)) {
        json_error('Arquivo inválido', 422);
    }

    $size = (int)($file['size'] ?? 0);
    if ($size <= 0) {
        json_error('Arquivo inválido', 422);
    }
    if ($size > 5 * 1024 * 1024) {
        json_error('Arquivo deve ter no máximo 5MB', 422);
    }

    $ext = strtolower((string)pathinfo($originalName, PATHINFO_EXTENSION));
    $allowedExt = ['jpg', 'jpeg', 'png', 'webp', 'gif'];
    if (!in_array($ext, $allowedExt, true)) {
        json_error('Extensão não permitida. Use jpg, jpeg, png, webp ou gif', 422);
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mime = $finfo ? (string)finfo_file($finfo, $tmpPath) : '';
    if ($finfo) {
        finfo_close($finfo);
    }

    $allowedMime = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
    if (!in_array($mime, $allowedMime, true)) {
        json_error('Tipo de arquivo não permitido', 422);
    }

    $baseDir = dirname(__DIR__, 2);
    $uploadDir = $baseDir . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'banners';
    if (!is_dir($uploadDir) && !mkdir($uploadDir, 0775, true) && !is_dir($uploadDir)) {
        json_error('Não foi possível criar diretório de upload', 500);
    }

    $filename = 'banner_' . date('Ymd_His') . '_' . bin2hex(random_bytes(8)) . '.' . $ext;
    $targetPath = $uploadDir . DIRECTORY_SEPARATOR . $filename;
    if (!move_uploaded_file($tmpPath, $targetPath)) {
        json_error('Falha ao salvar arquivo no servidor', 500);
    }

    $publicUrl = '/uploads/banners/' . $filename;
    admin_log_action($pdo, $adminId, 'admin.banners.upload', null, [
        'filename' => $filename,
        'mime' => $mime,
        'size' => $size,
    ]);

    json_success([
        'url' => $publicUrl,
        'filename' => $filename,
    ]);
}

function admin_banners_list(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $items = $pdo->query('SELECT id,title,subtitle,image_url,is_active,sort_order,placement,created_at,updated_at
                          FROM banners
                          ORDER BY sort_order ASC, created_at DESC')->fetchAll();
    admin_log_action($pdo, $adminId, 'admin.banners.list');
    json_success(['items' => $items]);
}

function admin_banners_create(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = ['title','subtitle','image_url','is_active','sort_order'];
    admin_reject_unknown_fields($input, $allowed);

    $imageUrl = trim((string)($input['image_url'] ?? ''));
    if ($imageUrl === '') json_error('image_url is required', 422);
    $title = trim((string)($input['title'] ?? ''));
    $subtitle = trim((string)($input['subtitle'] ?? ''));
    $isActive = array_key_exists('is_active', $input) ? admin_to_bool($input['is_active']) : 1;
    $sortOrder = array_key_exists('sort_order', $input) ? (int)$input['sort_order'] : 0;
    $id = uuid_v4();

    $stmt = $pdo->prepare('INSERT INTO banners (id,title,subtitle,image_url,is_active,sort_order,placement)
                           VALUES (:id,:title,:subtitle,:image_url,:is_active,:sort_order,:placement)');
    $stmt->execute([
        ':id' => $id,
        ':title' => $title !== '' ? $title : null,
        ':subtitle' => $subtitle !== '' ? $subtitle : null,
        ':image_url' => $imageUrl,
        ':is_active' => $isActive,
        ':sort_order' => $sortOrder,
        ':placement' => 'global',
    ]);

    $fetch = $pdo->prepare('SELECT id,title,subtitle,image_url,is_active,sort_order,placement,created_at,updated_at FROM banners WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $id]);
    $banner = $fetch->fetch();

    admin_log_action($pdo, $adminId, 'admin.banners.create', null, ['banner_id' => $id]);
    json_success(['banner' => $banner ?: new stdClass()], 201);
}

function admin_banners_update(PDO $pdo, string $bannerId): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = ['title','subtitle','image_url','is_active','sort_order'];
    admin_reject_unknown_fields($input, $allowed);

    $exists = $pdo->prepare('SELECT id FROM banners WHERE id = :id LIMIT 1');
    $exists->execute([':id' => $bannerId]);
    if (!$exists->fetch()) json_error('Banner not found', 404);

    $mapped = [
        'title' => array_key_exists('title', $input) ? trim((string)$input['title']) : null,
        'subtitle' => array_key_exists('subtitle', $input) ? trim((string)$input['subtitle']) : null,
        'image_url' => array_key_exists('image_url', $input) ? trim((string)$input['image_url']) : null,
        'is_active' => array_key_exists('is_active', $input) ? admin_to_bool($input['is_active']) : null,
        'sort_order' => array_key_exists('sort_order', $input) ? (int)$input['sort_order'] : null,
    ];

    $sets = [];
    $params = [':id' => $bannerId];
    foreach ($mapped as $field => $value) {
        if (array_key_exists($field, $input)) {
            $sets[] = "{$field} = :{$field}";
            $params[":{$field}"] = ($field === 'title' || $field === 'subtitle' || $field === 'image_url')
                ? (($value === '') ? null : $value)
                : $value;
        }
    }
    if (empty($sets)) json_error('No valid fields provided', 422);

    $upd = $pdo->prepare('UPDATE banners SET ' . implode(', ', $sets) . ', updated_at = CURRENT_TIMESTAMP WHERE id = :id');
    $upd->execute($params);

    $fetch = $pdo->prepare('SELECT id,title,subtitle,image_url,is_active,sort_order,placement,created_at,updated_at FROM banners WHERE id = :id LIMIT 1');
    $fetch->execute([':id' => $bannerId]);
    $banner = $fetch->fetch();

    admin_log_action($pdo, $adminId, 'admin.banners.update', null, ['banner_id' => $bannerId, 'updated_fields' => array_keys($input)]);
    json_success(['banner' => $banner ?: new stdClass()]);
}

function admin_banners_delete(PDO $pdo, string $bannerId): void
{
    $adminId = admin_require($pdo);
    $exists = $pdo->prepare('SELECT id FROM banners WHERE id = :id LIMIT 1');
    $exists->execute([':id' => $bannerId]);
    if (!$exists->fetch()) json_error('Banner not found', 404);

    $del = $pdo->prepare('DELETE FROM banners WHERE id = :id');
    $del->execute([':id' => $bannerId]);

    admin_log_action($pdo, $adminId, 'admin.banners.delete', null, ['banner_id' => $bannerId]);
    json_success(['banner_id' => $bannerId, 'deleted' => true]);
}

function admin_gateway_akadpay_config_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $config = akadpay_get_config($pdo, false);
    admin_log_action($pdo, $adminId, 'admin.gateway.akadpay.config.view');
    if (!$config) {
        json_success(new stdClass());
    }

    json_success(akadpay_config_public_view($config));
}

function admin_gateway_akadpay_config_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'token',
        'secret',
        'client_id',
        'client_secret',
        'webhook_secret',
        'webhook_secret_validation',
        'deposit_callback_url',
        'withdrawal_callback_url',
        'is_active',
        'api_base_url',
    ];
    admin_reject_unknown_fields($input, $allowed);

    $existing = akadpay_get_config($pdo, false);
    $id = $existing['id'] ?? uuid_v4();

    $token = array_key_exists('token', $input) ? trim((string)$input['token']) : ($existing['token'] ?? null);
    $secret = array_key_exists('secret', $input) ? trim((string)$input['secret']) : ($existing['secret'] ?? null);
    $clientId = array_key_exists('client_id', $input) ? trim((string)$input['client_id']) : ($existing['client_id'] ?? null);
    $clientSecret = array_key_exists('client_secret', $input) ? trim((string)$input['client_secret']) : ($existing['client_secret'] ?? null);
    $webhookSecret = array_key_exists('webhook_secret', $input) ? trim((string)$input['webhook_secret']) : ($existing['webhook_secret'] ?? null);
    $webhookSecretValidation = array_key_exists('webhook_secret_validation', $input)
        ? admin_to_bool($input['webhook_secret_validation'])
        : (int)($existing['webhook_secret_validation'] ?? 1);
    $depositCallbackUrl = array_key_exists('deposit_callback_url', $input) ? trim((string)$input['deposit_callback_url']) : ($existing['deposit_callback_url'] ?? null);
    $withdrawalCallbackUrl = array_key_exists('withdrawal_callback_url', $input) ? trim((string)$input['withdrawal_callback_url']) : ($existing['withdrawal_callback_url'] ?? null);
    $apiBaseUrl = array_key_exists('api_base_url', $input) ? trim((string)$input['api_base_url']) : ($existing['api_base_url'] ?? null);
    $isActive = array_key_exists('is_active', $input)
        ? admin_to_bool($input['is_active'])
        : (int)($existing['is_active'] ?? 0);

    if (!$existing) {
        $insert = $pdo->prepare('INSERT INTO akadpay_config
                                 (id,is_active,webhook_secret_validation,api_base_url,token,secret,client_id,client_secret,webhook_secret,deposit_callback_url,withdrawal_callback_url)
                                 VALUES
                                 (:id,:is_active,:webhook_secret_validation,:api_base_url,:token,:secret,:client_id,:client_secret,:webhook_secret,:deposit_callback_url,:withdrawal_callback_url)');
        $insert->execute([
            ':id' => $id,
            ':is_active' => $isActive,
            ':webhook_secret_validation' => $webhookSecretValidation,
            ':api_base_url' => $apiBaseUrl !== '' ? $apiBaseUrl : null,
            ':token' => $token !== '' ? $token : null,
            ':secret' => $secret !== '' ? $secret : null,
            ':client_id' => $clientId !== '' ? $clientId : null,
            ':client_secret' => $clientSecret !== '' ? $clientSecret : null,
            ':webhook_secret' => $webhookSecret !== '' ? $webhookSecret : null,
            ':deposit_callback_url' => $depositCallbackUrl !== '' ? $depositCallbackUrl : null,
            ':withdrawal_callback_url' => $withdrawalCallbackUrl !== '' ? $withdrawalCallbackUrl : null,
        ]);
    } else {
        $update = $pdo->prepare('UPDATE akadpay_config
                                 SET is_active = :is_active,
                                     webhook_secret_validation = :webhook_secret_validation,
                                     api_base_url = :api_base_url,
                                     token = :token,
                                     secret = :secret,
                                     client_id = :client_id,
                                     client_secret = :client_secret,
                                     webhook_secret = :webhook_secret,
                                     deposit_callback_url = :deposit_callback_url,
                                     withdrawal_callback_url = :withdrawal_callback_url,
                                     updated_at = CURRENT_TIMESTAMP
                                 WHERE id = :id');
        $update->execute([
            ':id' => $id,
            ':is_active' => $isActive,
            ':webhook_secret_validation' => $webhookSecretValidation,
            ':api_base_url' => $apiBaseUrl !== '' ? $apiBaseUrl : null,
            ':token' => $token !== '' ? $token : null,
            ':secret' => $secret !== '' ? $secret : null,
            ':client_id' => $clientId !== '' ? $clientId : null,
            ':client_secret' => $clientSecret !== '' ? $clientSecret : null,
            ':webhook_secret' => $webhookSecret !== '' ? $webhookSecret : null,
            ':deposit_callback_url' => $depositCallbackUrl !== '' ? $depositCallbackUrl : null,
            ':withdrawal_callback_url' => $withdrawalCallbackUrl !== '' ? $withdrawalCallbackUrl : null,
        ]);
    }

    $saved = akadpay_get_config($pdo, false);
    admin_log_action($pdo, $adminId, 'admin.gateway.akadpay.config.update', null, [
        'updated_fields' => array_keys($input),
        'is_active' => $isActive,
    ]);
    json_success([
        'config' => $saved ? akadpay_config_public_view($saved) : new stdClass(),
    ]);
}

function admin_gateway_webhook_logs_list(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 50;
    if ($limit <= 0) $limit = 50;
    if ($limit > 200) $limit = 200;

    $provider = trim((string)($_GET['provider'] ?? ''));
    $type = trim((string)($_GET['type'] ?? ''));
    $status = trim((string)($_GET['status'] ?? ''));

    $where = [];
    $params = [];
    if ($provider !== '') {
        $where[] = 'provider = :provider';
        $params[':provider'] = $provider;
    }
    if ($type !== '') {
        $where[] = 'event_type = :event_type';
        $params[':event_type'] = $type;
    }
    if ($status !== '') {
        $where[] = 'processing_status = :processing_status';
        $params[':processing_status'] = $status;
    }
    $whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

    $sql = "SELECT id,provider,event_type,external_id,signature,status_code,processing_status,created_at,payload
            FROM webhook_logs
            {$whereSql}
            ORDER BY created_at DESC
            LIMIT {$limit}";
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $items = $stmt->fetchAll();

    admin_log_action($pdo, $adminId, 'admin.gateway.webhook_logs.list', null, [
        'provider' => $provider !== '' ? $provider : null,
        'type' => $type !== '' ? $type : null,
        'status' => $status !== '' ? $status : null,
        'limit' => $limit,
    ]);

    json_success([
        'items' => $items,
        'limit' => $limit,
    ]);
}

function admin_gateway_onixpay_config_get(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $config = onixpay_get_config($pdo, false);
    admin_log_action($pdo, $adminId, 'admin.gateway.onixpay.config.view');
    if (!$config) {
        json_success(new stdClass());
    }
    json_success(onixpay_config_public_view($config));
}

function admin_gateway_onixpay_config_update(PDO $pdo): void
{
    $adminId = admin_require($pdo);
    $input = get_json_input();
    $allowed = [
        'client_id',
        'client_secret',
        'webhook_secret',
        'deposit_callback_url',
        'withdrawal_callback_url',
        'is_active',
        'api_base_url',
    ];
    admin_reject_unknown_fields($input, $allowed);

    $existing = onixpay_get_config($pdo, false);
    $id = $existing['id'] ?? uuid_v4();

    $clientId = array_key_exists('client_id', $input) ? trim((string)$input['client_id']) : ($existing['client_id'] ?? null);
    $clientSecret = array_key_exists('client_secret', $input) ? trim((string)$input['client_secret']) : ($existing['client_secret'] ?? null);
    $webhookSecret = array_key_exists('webhook_secret', $input) ? trim((string)$input['webhook_secret']) : ($existing['webhook_secret'] ?? null);
    $depositCallbackUrl = array_key_exists('deposit_callback_url', $input) ? trim((string)$input['deposit_callback_url']) : ($existing['deposit_callback_url'] ?? null);
    $withdrawalCallbackUrl = array_key_exists('withdrawal_callback_url', $input) ? trim((string)$input['withdrawal_callback_url']) : ($existing['withdrawal_callback_url'] ?? null);
    $apiBaseUrl = array_key_exists('api_base_url', $input) ? trim((string)$input['api_base_url']) : ($existing['api_base_url'] ?? null);
    $isActive = array_key_exists('is_active', $input)
        ? admin_to_bool($input['is_active'])
        : (int)($existing['is_active'] ?? 0);

    if (!$existing) {
        $insert = $pdo->prepare('INSERT INTO onixpay_config
                                 (id,is_active,api_base_url,client_id,client_secret,webhook_secret,deposit_callback_url,withdrawal_callback_url)
                                 VALUES
                                 (:id,:is_active,:api_base_url,:client_id,:client_secret,:webhook_secret,:deposit_callback_url,:withdrawal_callback_url)');
        $insert->execute([
            ':id' => $id,
            ':is_active' => $isActive,
            ':api_base_url' => $apiBaseUrl !== '' ? $apiBaseUrl : null,
            ':client_id' => $clientId !== '' ? $clientId : null,
            ':client_secret' => $clientSecret !== '' ? $clientSecret : null,
            ':webhook_secret' => $webhookSecret !== '' ? $webhookSecret : null,
            ':deposit_callback_url' => $depositCallbackUrl !== '' ? $depositCallbackUrl : null,
            ':withdrawal_callback_url' => $withdrawalCallbackUrl !== '' ? $withdrawalCallbackUrl : null,
        ]);
    } else {
        $update = $pdo->prepare('UPDATE onixpay_config
                                 SET is_active = :is_active,
                                     api_base_url = :api_base_url,
                                     client_id = :client_id,
                                     client_secret = :client_secret,
                                     webhook_secret = :webhook_secret,
                                     deposit_callback_url = :deposit_callback_url,
                                     withdrawal_callback_url = :withdrawal_callback_url,
                                     updated_at = CURRENT_TIMESTAMP
                                 WHERE id = :id');
        $update->execute([
            ':id' => $id,
            ':is_active' => $isActive,
            ':api_base_url' => $apiBaseUrl !== '' ? $apiBaseUrl : null,
            ':client_id' => $clientId !== '' ? $clientId : null,
            ':client_secret' => $clientSecret !== '' ? $clientSecret : null,
            ':webhook_secret' => $webhookSecret !== '' ? $webhookSecret : null,
            ':deposit_callback_url' => $depositCallbackUrl !== '' ? $depositCallbackUrl : null,
            ':withdrawal_callback_url' => $withdrawalCallbackUrl !== '' ? $withdrawalCallbackUrl : null,
        ]);
    }

    $saved = onixpay_get_config($pdo, false);
    admin_log_action($pdo, $adminId, 'admin.gateway.onixpay.config.update', null, [
        'updated_fields' => array_keys($input),
        'is_active' => $isActive,
    ]);
    json_success([
        'config' => $saved ? onixpay_config_public_view($saved) : new stdClass(),
    ]);
}

function admin_withdrawal_process(PDO $pdo, string $withdrawalId): void
{
    $adminId = admin_require($pdo);
    $onixpay = onixpay_get_config($pdo, true);
    if (!$onixpay) {
        json_error('OnixPay config is missing or inactive', 503);
    }

    try {
        $pdo->beginTransaction();

        $stmt = $pdo->prepare('SELECT id,user_id,status,wallet_type,amount,net_amount,pix_key,pix_key_type
                               FROM withdrawals
                               WHERE id = :id
                               LIMIT 1
                               FOR UPDATE');
        $stmt->execute([':id' => $withdrawalId]);
        $withdrawal = $stmt->fetch();
        if (!$withdrawal) throw new RuntimeException('withdrawal_not_found');
        if ((string)$withdrawal['status'] !== 'approved') throw new RuntimeException('invalid_status');

        admin_assert_active_user($pdo, (string)$withdrawal['user_id']);

        $profileStmt = $pdo->prepare('SELECT full_name,email,cpf,phone FROM profiles WHERE user_id = :user_id LIMIT 1');
        $profileStmt->execute([':user_id' => (string)$withdrawal['user_id']]);
        $profile = $profileStmt->fetch() ?: [];

        $pixKeyType = trim((string)($withdrawal['pix_key_type'] ?? ''));
        if (!in_array($pixKeyType, ['cpf', 'email', 'telefone', 'aleatoria'], true)) {
            throw new RuntimeException('invalid_pix_key_type');
        }

        $beneficiaryName = trim((string)($profile['full_name'] ?? ''));
        $beneficiaryCpf = only_digits((string)($profile['cpf'] ?? ''));

        $requestPayload = [
            'client_id' => (string)($onixpay['client_id'] ?? ''),
            'client_secret' => (string)($onixpay['client_secret'] ?? ''),
            'nome' => $beneficiaryName,
            'cpf' => $beneficiaryCpf,
            'valor' => round((float)$withdrawal['net_amount'] > 0 ? (float)$withdrawal['net_amount'] : (float)$withdrawal['amount'], 2),
            'chave_pix' => trim((string)($withdrawal['pix_key'] ?? '')),
            'descricao' => 'Saque via ' . ($_SERVER['HTTP_HOST'] ?? 'plataforma'),
            'urlnoty' => trim((string)($onixpay['withdrawal_callback_url'] ?? '')),
        ];

        $apiResult = onixpay_request($onixpay, '/pix/payment.php', $requestPayload);
        $resp = is_array($apiResult['json']) ? $apiResult['json'] : [];
        $transactionId = (string)($resp['transactionId'] ?? $resp['transaction_id'] ?? $resp['id'] ?? '');
        $externalId = (string)($resp['external_id'] ?? $resp['externalId'] ?? $resp['id'] ?? $withdrawal['id']);
        $statusRaw = strtolower((string)($resp['status'] ?? ''));

        $nextStatus = 'processing';
        $paidAt = null;
        if (in_array($statusRaw, ['paid', 'approved', 'success', 'completed'], true)) {
            $nextStatus = 'paid';
            $paidAt = date('Y-m-d H:i:s');
        } elseif ($statusRaw === 'pending') {
            $nextStatus = 'processing';
        }
        if ((int)$apiResult['http_status'] >= 400) {
            $nextStatus = 'approved';
        }

        $upd = $pdo->prepare('UPDATE withdrawals
                              SET status = :status,
                                  admin_id = :admin_id,
                                  transaction_id = :transaction_id,
                                  external_id = :external_id,
                                  response = :response,
                                  processed_at = COALESCE(processed_at, CURRENT_TIMESTAMP),
                                  paid_at = :paid_at,
                                  updated_at = CURRENT_TIMESTAMP
                              WHERE id = :id');
        $upd->execute([
            ':status' => $nextStatus,
            ':admin_id' => $adminId,
            ':transaction_id' => $transactionId !== '' ? $transactionId : null,
            ':external_id' => $externalId !== '' ? $externalId : null,
            ':response' => json_encode([
                'http_status' => $apiResult['http_status'],
                'json' => $apiResult['json'],
                'raw_body' => $apiResult['raw_body'],
            ], JSON_UNESCAPED_UNICODE),
            ':paid_at' => $paidAt,
            ':id' => $withdrawalId,
        ]);

        admin_log_action($pdo, $adminId, 'admin.withdrawals.process', (string)$withdrawal['user_id'], [
            'withdrawal_id' => $withdrawalId,
            'status' => $nextStatus,
            'http_status' => $apiResult['http_status'],
            'transaction_id' => $transactionId !== '' ? $transactionId : null,
        ]);

        $pdo->commit();
        json_success([
            'withdrawal_id' => $withdrawalId,
            'status' => $nextStatus,
            'transaction_id' => $transactionId !== '' ? $transactionId : null,
        ]);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ($e->getMessage() === 'withdrawal_not_found') json_error('Withdrawal not found', 404);
        if ($e->getMessage() === 'invalid_status') json_error('Withdrawal must be approved before processing', 409);
        if ($e->getMessage() === 'invalid_pix_key_type') json_error('Invalid pix_key_type for OnixPay pixout', 422);
        json_error('Failed to process withdrawal', 500);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        json_error('Failed to process withdrawal', 500);
    }
}

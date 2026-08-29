<?php
declare(strict_types=1);

if (!function_exists('uuid_v4')) {
    function uuid_v4(): string
    {
        $data = random_bytes(16);
        $data[6] = chr((ord($data[6]) & 0x0f) | 0x40);
        $data[8] = chr((ord($data[8]) & 0x3f) | 0x80);
        return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }
}

function generate_referral_code(): string
{
    return strtolower(substr(bin2hex(random_bytes(6)), 0, 8));
}

function auth_register(PDO $pdo): void
{
    $input = get_json_input();
    $email = strtolower(trim((string)($input['email'] ?? '')));
    $password = (string)($input['password'] ?? '');
    $fullName = trim((string)($input['full_name'] ?? ''));
    $phone = trim((string)($input['phone'] ?? ''));
    $cpf = trim((string)($input['cpf'] ?? ''));
    $username = trim((string)($input['username'] ?? ''));
    $referredByCode = trim((string)($input['referred_by'] ?? ''));

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) json_error('Invalid email', 422);
    if (strlen($password) < 6) json_error('Password must have at least 6 characters', 422);

    $userId = uuid_v4();
    $profileId = uuid_v4();
    $walletId = uuid_v4();
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    $referredBy = null;
    if ($referredByCode !== '') {
        $refStmt = $pdo->prepare('SELECT user_id FROM profiles WHERE referral_code = :code LIMIT 1');
        $refStmt->execute([':code' => $referredByCode]);
        $ref = $refStmt->fetch();
        if ($ref) $referredBy = $ref['user_id'];
    }

    try {
        $pdo->beginTransaction();
        $pdo->prepare('INSERT INTO users (id, email, password_hash) VALUES (:id,:email,:password_hash)')
            ->execute([':id'=>$userId, ':email'=>$email, ':password_hash'=>$passwordHash]);

        $pdo->prepare('INSERT INTO profiles (id,user_id,full_name,username,email,phone,cpf,referral_code,referred_by)
                       VALUES (:id,:user_id,:full_name,:username,:email,:phone,:cpf,:referral_code,:referred_by)')
            ->execute([
                ':id'=>$profileId, ':user_id'=>$userId, ':full_name'=>$fullName,
                ':username'=>$username !== '' ? $username : null, ':email'=>$email,
                ':phone'=>$phone !== '' ? $phone : null, ':cpf'=>$cpf !== '' ? $cpf : null,
                ':referral_code'=>generate_referral_code(), ':referred_by'=>$referredBy
            ]);

        $pdo->prepare('INSERT INTO wallets (id,user_id,player_balance,affiliate_balance,total_deposited,total_withdrawn,total_affiliate_earned)
                       VALUES (:id,:user_id,0,0,0,0,0)')
            ->execute([':id'=>$walletId, ':user_id'=>$userId]);

        $pdo->prepare('INSERT INTO user_roles (user_id,role) VALUES (:user_id,:role)')
            ->execute([':user_id'=>$userId, ':role'=>'user']);

        session_regenerate_id(true);
        $_SESSION['user_id'] = $userId;

        $pdo->prepare('INSERT INTO auth_sessions (session_id,user_id,ip_address,user_agent)
                       VALUES (:session_id,:user_id,:ip_address,:user_agent)')
            ->execute([
                ':session_id'=>session_id(), ':user_id'=>$userId,
                ':ip_address'=>substr((string)($_SERVER['REMOTE_ADDR'] ?? ''),0,64),
                ':user_agent'=>substr((string)($_SERVER['HTTP_USER_AGENT'] ?? ''),0,255)
            ]);

        $pdo->commit();
    } catch (PDOException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if ((int)$e->getCode() === 23000) json_error('User already exists or duplicated unique field', 409);
        json_error('Failed to register user', 500);
    }

    json_success(['user' => ['id'=>$userId, 'email'=>$email]], 201);
}

function auth_login(PDO $pdo): void
{
    $input = get_json_input();
    $email = strtolower(trim((string)($input['email'] ?? '')));
    $password = (string)($input['password'] ?? '');
    if (!filter_var($email, FILTER_VALIDATE_EMAIL) || $password === '') json_error('Invalid credentials', 422);

    $stmt = $pdo->prepare('SELECT u.id,u.email,u.password_hash
                           FROM users u
                           LEFT JOIN profiles p ON p.user_id = u.id
                           WHERE u.email = :email
                             AND u.deleted_at IS NULL
                             AND (p.user_id IS NULL OR p.deleted_at IS NULL)
                           LIMIT 1');
    $stmt->execute([':email'=>$email]);
    $user = $stmt->fetch();
    if (!$user || !password_verify($password, $user['password_hash'])) json_error('Invalid credentials', 401);

    session_regenerate_id(true);
    $_SESSION['user_id'] = $user['id'];
    $pdo->prepare('INSERT INTO auth_sessions (session_id,user_id,ip_address,user_agent)
                   VALUES (:session_id,:user_id,:ip_address,:user_agent)')
        ->execute([
            ':session_id'=>session_id(), ':user_id'=>$user['id'],
            ':ip_address'=>substr((string)($_SERVER['REMOTE_ADDR'] ?? ''),0,64),
            ':user_agent'=>substr((string)($_SERVER['HTTP_USER_AGENT'] ?? ''),0,255)
        ]);

    json_success(['user' => ['id'=>$user['id'], 'email'=>$user['email']]]);
}

function auth_logout(PDO $pdo): void
{
    $pdo->prepare('UPDATE auth_sessions SET revoked_at = CURRENT_TIMESTAMP WHERE session_id = :session_id AND revoked_at IS NULL')
        ->execute([':session_id'=>session_id()]);
    $_SESSION = [];
    if (ini_get('session.use_cookies')) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000, $params['path'], $params['domain'], (bool)$params['secure'], (bool)$params['httponly']);
    }
    session_destroy();
    json_success(['message'=>'Logged out']);
}

function auth_session(PDO $pdo): void
{
    $userId = current_user_id();
    if ($userId === null) json_success(['authenticated'=>false, 'user'=>null]);

    $stmt = $pdo->prepare('SELECT u.id,u.email
                           FROM users u
                           INNER JOIN auth_sessions s ON s.user_id = u.id
                           LEFT JOIN profiles p ON p.user_id = u.id
                           WHERE s.session_id = :session_id
                             AND s.revoked_at IS NULL
                             AND u.deleted_at IS NULL
                             AND (p.user_id IS NULL OR p.deleted_at IS NULL)
                           LIMIT 1');
    $stmt->execute([':session_id'=>session_id()]);
    $user = $stmt->fetch();
    if (!$user) json_success(['authenticated'=>false, 'user'=>null]);
    json_success(['authenticated'=>true, 'user'=>$user]);
}

function auth_me(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $stmt = $pdo->prepare("SELECT u.id,u.email,p.full_name,p.username,p.phone,p.cpf,
                           EXISTS(SELECT 1 FROM user_roles ur WHERE ur.user_id=u.id AND ur.role='admin') AS is_admin
                           FROM users u
                           LEFT JOIN profiles p ON p.user_id=u.id
                           WHERE u.id=:user_id
                             AND u.deleted_at IS NULL
                             AND (p.user_id IS NULL OR p.deleted_at IS NULL)
                           LIMIT 1");
    $stmt->execute([':user_id'=>$userId]);
    $row = $stmt->fetch();
    if (!$row) json_error('User not found', 404);
    $row['is_admin'] = (bool)$row['is_admin'];
    json_success(['user'=>$row]);
}

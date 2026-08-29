<?php
declare(strict_types=1);

require_once __DIR__ . '/helpers/response.php';
require_once __DIR__ . '/helpers/request.php';
require_once __DIR__ . '/helpers/session.php';
require_once __DIR__ . '/helpers/ids.php';
require_once __DIR__ . '/helpers/akadpay.php';
require_once __DIR__ . '/helpers/onixpay.php';
require_once __DIR__ . '/conn.php';
require_once __DIR__ . '/middleware/auth.php';
require_once __DIR__ . '/middleware/admin.php';
require_once __DIR__ . '/controllers/auth.php';
require_once __DIR__ . '/controllers/public.php';
require_once __DIR__ . '/controllers/player.php';
require_once __DIR__ . '/controllers/game.php';
require_once __DIR__ . '/controllers/payments.php';
require_once __DIR__ . '/controllers/admin.php';

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
header('Access-Control-Allow-Credentials: true');

if (get_request_method() === 'OPTIONS') {
    http_response_code(204);
    exit;
}

start_secure_session();
$pdo = db();
$method = get_request_method();
$path = get_request_path();

if ($path === '/index.php') {
    $path = '/';
}

$routes = [
    'POST /auth/register' => fn() => auth_register($pdo),
    'POST /auth/login' => fn() => auth_login($pdo),
    'POST /auth/logout' => fn() => auth_logout($pdo),
    'GET /auth/session' => fn() => auth_session($pdo),
    'GET /auth/me' => fn() => auth_me($pdo),

    'GET /public/game-settings' => fn() => public_game_settings($pdo),
    'GET /public/banners' => fn() => public_banners($pdo),
    'GET /public/financial-settings' => fn() => public_financial_settings($pdo),

    'GET /player/wallet' => fn() => player_wallet($pdo),
    'GET /player/dashboard' => fn() => player_dashboard($pdo),
    'GET /player/deposits' => fn() => player_deposits($pdo),
    'POST /player/withdrawals' => fn() => player_withdrawals_create($pdo),
    'PUT /player/profile' => fn() => player_profile_update($pdo),

    'POST /game/session/start' => fn() => game_start_session($pdo),
    'POST /game/session/finish' => fn() => game_finish_session($pdo),

    'POST /payments/deposit/create' => fn() => payments_deposit_create($pdo),
    'POST /payments/webhook/onixpay' => fn() => payments_webhook_onixpay($pdo),

    'GET /admin/stats' => fn() => admin_stats($pdo),
    'GET /admin/users' => fn() => admin_users_list($pdo),
    'GET /admin/deposits' => fn() => admin_deposits_list($pdo),
    'GET /admin/withdrawals' => fn() => admin_withdrawals_list($pdo),
    'GET /admin/game-settings' => fn() => admin_game_settings_get($pdo),
    'PUT /admin/game-settings' => fn() => admin_game_settings_update($pdo),
    'GET /admin/financial-settings' => fn() => admin_financial_settings_get($pdo),
    'PUT /admin/financial-settings' => fn() => admin_financial_settings_update($pdo),
    'GET /admin/commission-settings' => fn() => admin_commission_settings_get($pdo),
    'PUT /admin/commission-settings' => fn() => admin_commission_settings_update($pdo),
    'GET /admin/influencer-settings' => fn() => admin_influencer_settings_get($pdo),
    'PUT /admin/influencer-settings' => fn() => admin_influencer_settings_update($pdo),
    'GET /admin/character-settings' => fn() => admin_character_settings_get($pdo),
    'PUT /admin/character-settings' => fn() => admin_character_settings_update($pdo),
    'POST /admin/game-assets/upload' => fn() => admin_game_asset_upload($pdo),
    'GET /admin/banners' => fn() => admin_banners_list($pdo),
    'POST /admin/banners' => fn() => admin_banners_create($pdo),
    'POST /admin/banners/upload' => fn() => admin_banners_upload($pdo),
    'GET /admin/gateway/akadpay/config' => fn() => admin_gateway_akadpay_config_get($pdo),
    'PUT /admin/gateway/akadpay/config' => fn() => admin_gateway_akadpay_config_update($pdo),
    'GET /admin/gateway/onixpay/config' => fn() => admin_gateway_onixpay_config_get($pdo),
    'PUT /admin/gateway/onixpay/config' => fn() => admin_gateway_onixpay_config_update($pdo),
    'GET /admin/gateway/webhook-logs' => fn() => admin_gateway_webhook_logs_list($pdo),
];

$normalizedPath = preg_replace('#^/api#', '', $path);
if ($normalizedPath === '') {
    $normalizedPath = '/';
}

$key = $method . ' ' . $normalizedPath;
if (isset($routes[$key])) {
    $routes[$key]();
}

if ($method === 'GET' && preg_match('#^/admin/users/([a-fA-F0-9-]{36})$#', $normalizedPath, $m)) {
    admin_user_detail($pdo, $m[1]);
}

if ($method === 'PUT' && preg_match('#^/admin/users/([a-fA-F0-9-]{36})/profile$#', $normalizedPath, $m)) {
    admin_user_update_profile($pdo, $m[1]);
}

if ($method === 'PUT' && preg_match('#^/admin/users/([a-fA-F0-9-]{36})/auth$#', $normalizedPath, $m)) {
    admin_user_update_auth($pdo, $m[1]);
}

if ($method === 'POST' && preg_match('#^/admin/users/([a-fA-F0-9-]{36})/wallet/adjust$#', $normalizedPath, $m)) {
    admin_user_wallet_adjust($pdo, $m[1]);
}

if ($method === 'DELETE' && preg_match('#^/admin/users/([a-fA-F0-9-]{36})$#', $normalizedPath, $m)) {
    admin_user_soft_delete($pdo, $m[1]);
}

if ($method === 'POST' && preg_match('#^/admin/deposits/([a-fA-F0-9-]{36})/approve$#', $normalizedPath, $m)) {
    admin_deposit_approve($pdo, $m[1]);
}

if ($method === 'POST' && preg_match('#^/admin/deposits/([a-fA-F0-9-]{36})/reject$#', $normalizedPath, $m)) {
    admin_deposit_reject($pdo, $m[1]);
}

if ($method === 'POST' && preg_match('#^/admin/withdrawals/([a-fA-F0-9-]{36})/approve$#', $normalizedPath, $m)) {
    admin_withdrawal_approve($pdo, $m[1]);
}

if ($method === 'POST' && preg_match('#^/admin/withdrawals/([a-fA-F0-9-]{36})/cancel$#', $normalizedPath, $m)) {
    admin_withdrawal_cancel($pdo, $m[1]);
}

if ($method === 'POST' && preg_match('#^/admin/withdrawals/([a-fA-F0-9-]{36})/process$#', $normalizedPath, $m)) {
    admin_withdrawal_process($pdo, $m[1]);
}

if ($method === 'PUT' && preg_match('#^/admin/banners/([a-fA-F0-9-]{36})$#', $normalizedPath, $m)) {
    admin_banners_update($pdo, $m[1]);
}

if ($method === 'DELETE' && preg_match('#^/admin/banners/([a-fA-F0-9-]{36})$#', $normalizedPath, $m)) {
    admin_banners_delete($pdo, $m[1]);
}

json_error('Route not found', 404, [
    'method' => $method,
    'path' => $normalizedPath,
]);

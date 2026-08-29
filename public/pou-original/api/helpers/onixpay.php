<?php
declare(strict_types=1);

function onixpay_get_config(PDO $pdo, bool $mustBeActive = false): ?array
{
    $sql = 'SELECT *
            FROM onixpay_config
            ORDER BY updated_at DESC
            LIMIT 1';
    $row = $pdo->query($sql)->fetch();
    if (!$row) {
        return null;
    }
    if ($mustBeActive && (int)($row['is_active'] ?? 0) !== 1) {
        return null;
    }
    return $row;
}

function onixpay_mask_secret(?string $value): ?string
{
    $raw = trim((string)$value);
    if ($raw === '') {
        return null;
    }
    $len = strlen($raw);
    if ($len <= 6) {
        return str_repeat('*', $len);
    }
    return substr($raw, 0, 3) . str_repeat('*', $len - 6) . substr($raw, -3);
}

function onixpay_config_public_view(array $config): array
{
    return [
        'id' => $config['id'] ?? null,
        'is_active' => (int)($config['is_active'] ?? 0),
        'api_base_url' => $config['api_base_url'] ?? null,
        'client_id' => onixpay_mask_secret($config['client_id'] ?? null),
        'client_secret' => onixpay_mask_secret($config['client_secret'] ?? null),
        'webhook_secret' => onixpay_mask_secret($config['webhook_secret'] ?? null),
        'deposit_callback_url' => $config['deposit_callback_url'] ?? null,
        'withdrawal_callback_url' => $config['withdrawal_callback_url'] ?? null,
        'client_id_masked' => onixpay_mask_secret($config['client_id'] ?? null),
        'client_secret_masked' => onixpay_mask_secret($config['client_secret'] ?? null),
        'webhook_secret_masked' => onixpay_mask_secret($config['webhook_secret'] ?? null),
        'created_at' => $config['created_at'] ?? null,
        'updated_at' => $config['updated_at'] ?? null,
    ];
}

function onixpay_validate_webhook(array $config, array $payload): array
{
    $webhookSecret = trim((string)($config['webhook_secret'] ?? ''));
    if ($webhookSecret === '') {
        return ['ok' => true, 'reason' => 'no_webhook_secret_configured'];
    }
    $signatureHeader = substr((string)($_SERVER['HTTP_X_ONIXPAY_SIGNATURE'] ?? ''), 0, 512);
    if ($signatureHeader === '') {
        return ['ok' => false, 'reason' => 'missing_x_onixpay_signature'];
    }
    $body = file_get_contents('php://input');
    if (!is_string($body) || $body === '') {
        return ['ok' => false, 'reason' => 'empty_request_body'];
    }
    $expected = 'sha256=' . hash_hmac('sha256', $body, $webhookSecret);
    if (!hash_equals($expected, $signatureHeader)) {
        return ['ok' => false, 'reason' => 'hmac_signature_mismatch'];
    }
    return ['ok' => true, 'reason' => 'hmac_validated'];
}

function onixpay_request(
    array $config,
    string $resourcePath,
    array $payload
): array {
    $baseUrl = rtrim((string)($config['api_base_url'] ?? ''), '/');
    if ($baseUrl === '') {
        $baseUrl = 'https://onixpay.space/api/v2';
    }
    $url = $baseUrl . '/' . ltrim($resourcePath, '/');
    $jsonBody = json_encode($payload, JSON_UNESCAPED_UNICODE);
    if ($jsonBody === false) {
        throw new RuntimeException('onixpay_payload_encode_error');
    }
    if (!function_exists('curl_init')) {
        throw new RuntimeException('curl_not_available');
    }
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Accept: application/json',
        ],
        CURLOPT_POSTFIELDS => $jsonBody,
    ]);
    $raw = curl_exec($ch);
    $errno = curl_errno($ch);
    $error = curl_error($ch);
    $status = (int)curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    if ($errno !== 0) {
        throw new RuntimeException('onixpay_http_error:' . $error);
    }
    $decoded = null;
    if (is_string($raw) && trim($raw) !== '') {
        $decoded = json_decode($raw, true);
        if (!is_array($decoded)) {
            $decoded = null;
        }
    }
    return [
        'http_status' => $status,
        'raw_body' => is_string($raw) ? $raw : null,
        'json' => $decoded,
        'url' => $url,
    ];
}

function onixpay_request_get(
    array $config,
    string $resourcePath,
    array $params
): array {
    $baseUrl = rtrim((string)($config['api_base_url'] ?? ''), '/');
    if ($baseUrl === '') {
        $baseUrl = 'https://onixpay.space/api/v2';
    }
    $query = http_build_query($params, '', '&', PHP_QUERY_RFC3986);
    $url = $baseUrl . '/' . ltrim($resourcePath, '/') . ($query !== '' ? '?' . $query : '');
    if (!function_exists('curl_init')) {
        throw new RuntimeException('curl_not_available');
    }
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTPHEADER => [
            'Accept: application/json',
        ],
    ]);
    $raw = curl_exec($ch);
    $errno = curl_errno($ch);
    $error = curl_error($ch);
    $status = (int)curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    if ($errno !== 0) {
        throw new RuntimeException('onixpay_http_error:' . $error);
    }
    $decoded = null;
    if (is_string($raw) && trim($raw) !== '') {
        $decoded = json_decode($raw, true);
        if (!is_array($decoded)) {
            $decoded = null;
        }
    }
    return [
        'http_status' => $status,
        'raw_body' => is_string($raw) ? $raw : null,
        'json' => $decoded,
        'url' => $url,
    ];
}

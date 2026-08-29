<?php
declare(strict_types=1);

function only_digits(?string $value): string
{
    return preg_replace('/\D+/', '', (string)$value) ?? '';
}

function akadpay_get_config(PDO $pdo, bool $mustBeActive = false): ?array
{
    $sql = 'SELECT *
            FROM akadpay_config
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

function akadpay_mask_secret(?string $value): ?string
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

function akadpay_config_public_view(array $config): array
{
    $tokenMasked = akadpay_mask_secret($config['token'] ?? null);
    $secretMasked = akadpay_mask_secret($config['secret'] ?? null);
    $clientIdMasked = akadpay_mask_secret($config['client_id'] ?? null);
    $clientSecretMasked = akadpay_mask_secret($config['client_secret'] ?? null);
    $webhookSecretMasked = akadpay_mask_secret($config['webhook_secret'] ?? null);

    return [
        'id' => $config['id'] ?? null,
        'is_active' => (int)($config['is_active'] ?? 0),
        'webhook_secret_validation' => (int)($config['webhook_secret_validation'] ?? 1),
        'api_base_url' => $config['api_base_url'] ?? null,
        'deposit_callback_url' => $config['deposit_callback_url'] ?? null,
        'withdrawal_callback_url' => $config['withdrawal_callback_url'] ?? null,
        // Keep masked aliases compatible with older/newer admin bundles.
        'token' => $tokenMasked,
        'secret' => $secretMasked,
        'client_id' => $clientIdMasked,
        'client_secret' => $clientSecretMasked,
        'webhook_secret' => $webhookSecretMasked,
        'token_masked' => $tokenMasked,
        'secret_masked' => $secretMasked,
        'client_id_masked' => $clientIdMasked,
        'client_secret_masked' => $clientSecretMasked,
        'webhook_secret_masked' => $webhookSecretMasked,
        'created_at' => $config['created_at'] ?? null,
        'updated_at' => $config['updated_at'] ?? null,
    ];
}

function akadpay_validate_webhook(array $config, array $payload): array
{
    // AkadPay callback contract in use does not provide HMAC/signature fields.
    // Accept the webhook payload and let the payment processor enforce lookup,
    // paid status checks and idempotency on the financial records.
    return ['ok' => true, 'reason' => 'akadpay_callback_contract_without_signature'];
}

function akadpay_request(
    array $config,
    string $resourcePath,
    array $payload
): array {
    $baseUrl = rtrim((string)($config['api_base_url'] ?? ''), '/');
    if ($baseUrl === '') {
        $baseUrl = 'https://painel.akadpay.com.br/api';
    }

    $url = $baseUrl . '/' . ltrim($resourcePath, '/');
    $jsonBody = json_encode($payload, JSON_UNESCAPED_UNICODE);
    if ($jsonBody === false) {
        throw new RuntimeException('akadpay_payload_encode_error');
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
        throw new RuntimeException('akadpay_http_error:' . $error);
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

<?php
declare(strict_types=1);

function json_response(array $payload, int $statusCode = 200): void
{
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

function json_success(array $data = [], int $statusCode = 200): void
{
    json_response([
        'success' => true,
        'data' => $data,
    ], $statusCode);
}

function json_error(string $message, int $statusCode = 400, array $extra = []): void
{
    json_response([
        'success' => false,
        'error' => $message,
        'details' => $extra,
    ], $statusCode);
}


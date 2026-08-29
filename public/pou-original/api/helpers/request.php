<?php
declare(strict_types=1);

function get_json_input(): array
{
    $raw = file_get_contents('php://input');
    if ($raw === false || $raw === '') {
        return [];
    }

    $decoded = json_decode($raw, true);
    if (!is_array($decoded)) {
        json_error('Invalid JSON body', 400);
    }

    return $decoded;
}

function get_request_method(): string
{
    return strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');
}

function get_request_path(): string
{
    $uri = $_SERVER['REQUEST_URI'] ?? '/';
    $path = parse_url($uri, PHP_URL_PATH) ?? '/';

    $scriptName = $_SERVER['SCRIPT_NAME'] ?? '';
    $baseDir = rtrim(str_replace('\\', '/', dirname($scriptName)), '/');
    if ($baseDir !== '' && $baseDir !== '.' && str_starts_with($path, $baseDir)) {
        $path = substr($path, strlen($baseDir));
    }

    return '/' . ltrim($path, '/');
}


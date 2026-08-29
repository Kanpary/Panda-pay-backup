<?php
declare(strict_types=1);

/*
 * Hostinger/phpMyAdmin configuration:
 * Fill DB_HOST, DB_NAME, DB_USER, DB_PASS with your MySQL credentials.
 */
const DB_HOST = 'sql101.infinityfree.com';
const DB_NAME = 'if0_41806029_test';
const DB_USER = 'if0_41806029';
const DB_PASS = 'FU5QHbPDE1';
const DB_CHARSET = 'utf8mb4';

function db(): PDO
{
    static $pdo = null;
    if ($pdo instanceof PDO) {
        return $pdo;
    }

    $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;

    try {
        $pdo = new PDO($dsn, DB_USER, DB_PASS, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]);
    } catch (PDOException $e) {
        json_error('Database connection failed', 500, [
            'code' => $e->getCode(),
        ]);
    }

    return $pdo;
}


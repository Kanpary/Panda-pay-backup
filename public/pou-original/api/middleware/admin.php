<?php
declare(strict_types=1);

function require_admin(PDO $pdo, string $userId): void
{
    $stmt = $pdo->prepare(
        "SELECT 1 FROM user_roles WHERE user_id = :user_id AND role = 'admin' LIMIT 1"
    );
    $stmt->execute([':user_id' => $userId]);
    if (!$stmt->fetchColumn()) {
        json_error('Forbidden', 403);
    }
}


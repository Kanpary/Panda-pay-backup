<?php
declare(strict_types=1);

function require_auth(PDO $pdo): string
{
    $userId = current_user_id();
    if ($userId === null) {
        json_error('Unauthorized', 401);
    }

    $stmt = $pdo->prepare(
        'SELECT s.user_id
         FROM auth_sessions s
         INNER JOIN users u ON u.id = s.user_id
         LEFT JOIN profiles p ON p.user_id = u.id
         WHERE s.session_id = :session_id
           AND s.user_id = :user_id
           AND s.revoked_at IS NULL
           AND u.deleted_at IS NULL
           AND (p.user_id IS NULL OR p.deleted_at IS NULL)
         LIMIT 1'
    );
    $stmt->execute([
        ':session_id' => session_id(),
        ':user_id' => $userId,
    ]);

    if (!$stmt->fetch()) {
        session_unset();
        session_destroy();
        json_error('Unauthorized', 401);
    }

    $touchStmt = $pdo->prepare(
        'UPDATE auth_sessions SET last_activity = CURRENT_TIMESTAMP WHERE session_id = :session_id'
    );
    $touchStmt->execute([':session_id' => session_id()]);

    return $userId;
}

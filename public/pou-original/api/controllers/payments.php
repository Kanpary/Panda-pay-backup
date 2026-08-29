<?php
declare(strict_types=1);

function payments_deposit_create(PDO $pdo): void
{
    $userId = require_auth($pdo);
    $input = get_json_input();

    $amount = (float)($input['amount'] ?? 0);
    if ($amount <= 0) {
        json_error('Invalid deposit amount', 422);
    }

    $settings = $pdo->query('SELECT min_deposit,deposit_bonus_enabled,deposit_bonus_percent,deposit_bonus_min_amount
                             FROM financial_settings
                             ORDER BY updated_at DESC
                             LIMIT 1')->fetch();
    if (!$settings) {
        json_error('Financial settings not found', 500);
    }
    $minDeposit = (float)$settings['min_deposit'];
    if ($amount < $minDeposit) {
        json_error('Deposit amount below minimum allowed', 422, [
            'min_deposit' => number_format($minDeposit, 2, '.', ''),
        ]);
    }

    $bonusEnabled = isset($settings['deposit_bonus_enabled']) && (int)$settings['deposit_bonus_enabled'] === 1;
    $bonusPercent = isset($settings['deposit_bonus_percent']) ? max(0.0, (float)$settings['deposit_bonus_percent']) : 0.0;
    $bonusMinAmount = isset($settings['deposit_bonus_min_amount']) ? max(0.0, (float)$settings['deposit_bonus_min_amount']) : 0.0;
    $bonusAmount = 0.0;
    if ($bonusEnabled && $bonusPercent > 0 && $amount >= $bonusMinAmount) {
        $bonusAmount = round($amount * ($bonusPercent / 100), 2);
    }
    $totalCredited = round($amount + $bonusAmount, 2);

    $onixpay = onixpay_get_config($pdo, true);
    if (!$onixpay) {
        json_error('OnixPay config is missing or inactive', 503);
    }

    $profileStmt = $pdo->prepare('SELECT full_name,email,cpf,phone FROM profiles WHERE user_id = :user_id LIMIT 1');
    $profileStmt->execute([':user_id' => $userId]);
    $profile = $profileStmt->fetch() ?: [];

    $debtorName = trim((string)($profile['full_name'] ?? 'Jogador'));
    $debtorCpf = only_digits((string)($profile['cpf'] ?? ''));
    $postback = trim((string)($onixpay['deposit_callback_url'] ?? ''));

    $depositId = uuid_v4();
    $insert = $pdo->prepare('INSERT INTO deposits
                             (id,user_id,amount,bonus_amount,total_credited,status,provider,gateway,external_id,transaction_id,qr_code,qrcode,qr_code_image_url,pix_qr_image,pix_code,payment_link,payload,response,metadata)
                             VALUES
                             (:id,:user_id,:amount,:bonus_amount,:total_credited,:status,:provider,:gateway,:external_id,:transaction_id,:qr_code,:qrcode,:qr_code_image_url,:pix_qr_image,:pix_code,:payment_link,:payload,:response,:metadata)');
    $insert->execute([
        ':id' => $depositId,
        ':user_id' => $userId,
        ':amount' => $amount,
        ':bonus_amount' => $bonusAmount,
        ':total_credited' => $totalCredited,
        ':status' => 'pending',
        ':provider' => 'onixpay',
        ':gateway' => 'onixpay',
        ':external_id' => null,
        ':transaction_id' => null,
        ':qr_code' => null,
        ':qrcode' => null,
        ':qr_code_image_url' => null,
        ':pix_qr_image' => null,
        ':pix_code' => null,
        ':payment_link' => null,
        ':payload' => null,
        ':response' => null,
        ':metadata' => json_encode([
            'source' => 'onixpay_real',
            'created_via' => 'payments_deposit_create',
            'bonus_enabled' => $bonusEnabled,
            'bonus_percent' => $bonusPercent,
            'bonus_min_amount' => $bonusMinAmount,
        ], JSON_UNESCAPED_UNICODE),
    ]);

    $requestPayload = [
        'client_id' => (string)($onixpay['client_id'] ?? ''),
        'client_secret' => (string)($onixpay['client_secret'] ?? ''),
        'nome' => $debtorName,
        'cpf' => $debtorCpf,
        'valor' => round($amount, 2),
        'descricao' => 'Deposito via ' . $_SERVER['HTTP_HOST'] ?? 'plataforma',
        'urlnoty' => $postback,
    ];

    try {
        $apiResult = onixpay_request($onixpay, '/pix/qrcode.php', $requestPayload);
    } catch (Throwable $e) {
        $updateFail = $pdo->prepare('UPDATE deposits
                                     SET status = :status,
                                         payload = :payload,
                                         response = :response,
                                         updated_at = CURRENT_TIMESTAMP
                                     WHERE id = :id');
        $updateFail->execute([
            ':status' => 'failed',
            ':payload' => json_encode($requestPayload, JSON_UNESCAPED_UNICODE),
            ':response' => json_encode([
                'error' => $e->getMessage(),
            ], JSON_UNESCAPED_UNICODE),
            ':id' => $depositId,
        ]);
        json_error('Failed to create PIX on OnixPay', 502, ['deposit_id' => $depositId]);
    }

    $resp = is_array($apiResult['json']) ? $apiResult['json'] : [];
    $transactionId = (string)($resp['transactionId'] ?? $resp['transaction_id'] ?? $resp['id'] ?? '');
    $externalId = (string)($resp['external_id'] ?? $resp['externalId'] ?? $resp['reference_code'] ?? $depositId);
    $pixCode = (string)($resp['qrcode'] ?? $resp['pix_code'] ?? $resp['qr_code'] ?? $resp['pixCopiaECola'] ?? '');
    $qrImage = (string)($resp['qr_code_image_url'] ?? $resp['pix_qr_image'] ?? $resp['qrCodeImage'] ?? '');
    $paymentLink = (string)($resp['payment_link'] ?? '');

    $status = 'pending';
    if ((int)$apiResult['http_status'] >= 400) {
        $status = 'failed';
    }

    $update = $pdo->prepare('UPDATE deposits
                             SET status = :status,
                                 external_id = :external_id,
                                 transaction_id = :transaction_id,
                                 qr_code = :qr_code,
                                 qrcode = :qrcode,
                                 pix_code = :pix_code,
                                 qr_code_image_url = :qr_code_image_url,
                                 pix_qr_image = :pix_qr_image,
                                 payment_link = :payment_link,
                                 payload = :payload,
                                 response = :response,
                                 updated_at = CURRENT_TIMESTAMP
                             WHERE id = :id');
    $update->execute([
        ':status' => $status,
        ':external_id' => $externalId !== '' ? $externalId : $depositId,
        ':transaction_id' => $transactionId !== '' ? $transactionId : null,
        ':qr_code' => $pixCode !== '' ? $pixCode : null,
        ':qrcode' => $pixCode !== '' ? $pixCode : null,
        ':pix_code' => $pixCode !== '' ? $pixCode : null,
        ':qr_code_image_url' => $qrImage !== '' ? $qrImage : null,
        ':pix_qr_image' => $qrImage !== '' ? $qrImage : null,
        ':payment_link' => $paymentLink !== '' ? $paymentLink : null,
        ':payload' => json_encode($requestPayload, JSON_UNESCAPED_UNICODE),
        ':response' => json_encode([
            'http_status' => $apiResult['http_status'],
            'json' => $apiResult['json'],
            'raw_body' => $apiResult['raw_body'],
        ], JSON_UNESCAPED_UNICODE),
        ':id' => $depositId,
    ]);

    if ($status === 'failed') {
        json_error('OnixPay rejected deposit creation', 502, [
            'deposit_id' => $depositId,
            'http_status' => $apiResult['http_status'],
        ]);
    }

    json_success([
        'deposit_id' => $depositId,
        'status' => 'pending',
        'amount' => number_format($amount, 2, '.', ''),
        'pix_code' => $pixCode !== '' ? $pixCode : null,
        'qrcode' => $pixCode !== '' ? $pixCode : null,
        'qr_code_image_url' => $qrImage !== '' ? $qrImage : null,
        'transaction_id' => $transactionId !== '' ? $transactionId : null,
    ], 201);
}

function payments_webhook_onixpay(PDO $pdo): void
{
    $payload = get_json_input();
    $provider = 'onixpay';
    $onixpayConfig = onixpay_get_config($pdo, true);
    if (!$onixpayConfig) {
        json_error('OnixPay config is missing or inactive', 503);
    }

    $eventType = trim((string)($payload['transactionType'] ?? $payload['event'] ?? $payload['type'] ?? $payload['status'] ?? ''));
    $transactionId = trim((string)($payload['transactionId'] ?? $payload['transaction_id'] ?? $payload['id'] ?? ''));
    $externalId = trim((string)($payload['external_id'] ?? $payload['externalId'] ?? ''));
    $statusRaw = strtolower(trim((string)($payload['status'] ?? $payload['payment_status'] ?? $payload['situation'] ?? '')));
    $signature = substr((string)($_SERVER['HTTP_X_ONIXPAY_SIGNATURE'] ?? ($_SERVER['HTTP_X_SIGNATURE'] ?? '')), 0, 255);

    $isPaid = in_array($statusRaw, ['paid', 'approved', 'success', 'completed'], true);
    $typeTransaction = strtoupper(trim((string)($payload['transactionType'] ?? '')));

    $logStmt = $pdo->prepare('INSERT INTO webhook_logs
                              (provider,event_type,external_id,payload,signature,status_code,processing_status)
                              VALUES
                              (:provider,:event_type,:external_id,:payload,:signature,:status_code,:processing_status)');
    $logStatus = $isPaid ? 'received' : 'ignored';
    $logStmt->execute([
        ':provider' => $provider,
        ':event_type' => $eventType !== '' ? $eventType : null,
        ':external_id' => $transactionId !== '' ? $transactionId : ($externalId !== '' ? $externalId : null),
        ':payload' => json_encode($payload, JSON_UNESCAPED_UNICODE),
        ':signature' => $signature !== '' ? $signature : null,
        ':status_code' => null,
        ':processing_status' => $logStatus,
    ]);
    $webhookLogId = (int)$pdo->lastInsertId();

    $validation = onixpay_validate_webhook($onixpayConfig, $payload);
    if (!$validation['ok']) {
        $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code WHERE id = :id')
            ->execute([
                ':status' => 'error',
                ':status_code' => 401,
                ':id' => $webhookLogId,
            ]);
        json_error('Unauthorized OnixPay webhook', 401, ['reason' => $validation['reason']]);
    }

    if (!$isPaid) {
        $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code WHERE id = :id')
            ->execute([
                ':status' => 'ignored',
                ':status_code' => 200,
                ':id' => $webhookLogId,
            ]);
        json_success([
            'message' => 'Webhook ignored: payment not confirmed',
            'status' => $statusRaw,
        ], 200);
    }

    try {
        $pdo->beginTransaction();

        if ($typeTransaction === 'PAYMENT') {
            $wdStmt = $pdo->prepare('SELECT id,user_id,status,transaction_id
                                     FROM withdrawals
                                     WHERE transaction_id = :transaction_id
                                     ORDER BY created_at DESC
                                     LIMIT 1
                                     FOR UPDATE');
            $wdStmt->execute([':transaction_id' => $transactionId]);
            $withdrawal = $wdStmt->fetch();
            if (!$withdrawal) {
                throw new RuntimeException('withdrawal_not_found');
            }

            if ((string)$withdrawal['status'] === 'paid') {
                $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code WHERE id = :id')
                    ->execute([
                        ':status' => 'processed',
                        ':status_code' => 200,
                        ':id' => $webhookLogId,
                    ]);
                $pdo->commit();
                json_success([
                    'message' => 'Withdrawal already paid (idempotent)',
                    'withdrawal_id' => (string)$withdrawal['id'],
                ], 200);
            }

            $updWd = $pdo->prepare('UPDATE withdrawals
                                    SET status = :status,
                                        paid_at = COALESCE(paid_at, CURRENT_TIMESTAMP),
                                        response = :response,
                                        updated_at = CURRENT_TIMESTAMP
                                    WHERE id = :id');
            $updWd->execute([
                ':status' => 'paid',
                ':response' => json_encode([
                    'webhook_status' => $statusRaw,
                    'payload' => $payload,
                ], JSON_UNESCAPED_UNICODE),
                ':id' => (string)$withdrawal['id'],
            ]);

            $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code WHERE id = :id')
                ->execute([
                    ':status' => 'processed',
                    ':status_code' => 200,
                    ':id' => $webhookLogId,
                ]);
            $pdo->commit();
            json_success([
                'message' => 'Withdrawal marked as paid',
                'withdrawal_id' => (string)$withdrawal['id'],
            ], 200);
        }

        $depositWhere = [];
        $depositParams = [
            ':gateway' => 'onixpay',
        ];
        if ($transactionId !== '') {
            $depositWhere[] = 'transaction_id = :transaction_id';
            $depositParams[':transaction_id'] = $transactionId;
        }
        if ($externalId !== '') {
            $depositWhere[] = 'external_id = :external_id';
            $depositWhere[] = 'id = :deposit_id';
            $depositParams[':external_id'] = $externalId;
            $depositParams[':deposit_id'] = $externalId;
        }
        if (empty($depositWhere)) {
            throw new RuntimeException('deposit_lookup_missing_identifiers');
        }

        $depositSql = 'SELECT id,user_id,amount,bonus_amount,total_credited,status,transaction_id,external_id,created_at
                       FROM deposits
                       WHERE gateway = :gateway
                         AND (' . implode(' OR ', $depositWhere) . ')
                       ORDER BY created_at DESC
                       LIMIT 1
                       FOR UPDATE';
        $depStmt = $pdo->prepare($depositSql);
        $depStmt->execute($depositParams);
        $deposit = $depStmt->fetch();
        if (!$deposit) {
            throw new RuntimeException('deposit_not_found');
        }

        if ((string)$deposit['status'] === 'paid') {
            $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code WHERE id = :id')
                ->execute([
                    ':status' => 'processed',
                    ':status_code' => 200,
                    ':id' => $webhookLogId,
                ]);
            $pdo->commit();
            json_success([
                'message' => 'Deposit already paid (idempotent)',
                'deposit_id' => $deposit['id'],
            ], 200);
        }

        if ((string)$deposit['status'] !== 'pending') {
            throw new RuntimeException('invalid_deposit_status');
        }

        $walletStmt = $pdo->prepare('SELECT player_balance,total_deposited
                                     FROM wallets
                                     WHERE user_id = :user_id
                                     LIMIT 1
                                     FOR UPDATE');
        $walletStmt->execute([':user_id' => (string)$deposit['user_id']]);
        $wallet = $walletStmt->fetch();
        if (!$wallet) {
            throw new RuntimeException('wallet_not_found');
        }

        $amount = (float)$deposit['amount'];
        $bonusAmount = (float)$deposit['bonus_amount'];
        $toCredit = (float)$deposit['total_credited'];
        if ($toCredit <= 0) {
            $toCredit = round($amount + $bonusAmount, 2);
        }

        $before = (float)$wallet['player_balance'];
        $after = round($before + $toCredit, 2);

        $updWallet = $pdo->prepare('UPDATE wallets
                                    SET player_balance = :player_balance,
                                        total_deposited = total_deposited + :total_credited,
                                        updated_at = CURRENT_TIMESTAMP
                                    WHERE user_id = :user_id');
        $updWallet->execute([
            ':player_balance' => $after,
            ':total_credited' => $toCredit,
            ':user_id' => (string)$deposit['user_id'],
        ]);

        $transactionIdForDb = $transactionId !== '' ? $transactionId : null;
        $externalIdForDb = $externalId !== '' ? $externalId : null;
        $updDeposit = $pdo->prepare('UPDATE deposits
                                     SET status = :status,
                                         paid_at = CURRENT_TIMESTAMP,
                                         total_credited = :total_credited,
                                         transaction_id = COALESCE(:transaction_id, transaction_id),
                                         external_id = COALESCE(:external_id, external_id),
                                         response = :response,
                                         updated_at = CURRENT_TIMESTAMP
                                     WHERE id = :id');
        $updDeposit->execute([
            ':status' => 'paid',
            ':total_credited' => $toCredit,
            ':transaction_id' => $transactionIdForDb,
            ':external_id' => $externalIdForDb,
            ':response' => json_encode([
                'webhook_status' => $statusRaw,
                'payload' => $payload,
            ], JSON_UNESCAPED_UNICODE),
            ':id' => (string)$deposit['id'],
        ]);

        $tx = $pdo->prepare('INSERT INTO wallet_transactions
                             (user_id, admin_id, game_session_id, type, amount, balance_before, balance_after, reason, description)
                             VALUES
                             (:user_id, NULL, NULL, :type, :amount, :before, :after, :reason, :description)');
        $tx->execute([
            ':user_id' => (string)$deposit['user_id'],
            ':type' => 'deposit',
            ':amount' => $toCredit,
            ':before' => $before,
            ':after' => $after,
            ':reason' => 'OnixPay webhook deposit confirmation',
            ':description' => 'Deposit credited automatically from webhook',
        ]);

        try {
            $commissionResult = process_affiliate_commission_for_paid_deposit($pdo, $deposit, $toCredit);
            $pdo->prepare('INSERT INTO webhook_logs
                           (provider,event_type,external_id,payload,signature,status_code,processing_status)
                           VALUES
                           (:provider,:event_type,:external_id,:payload,:signature,:status_code,:processing_status)')
                ->execute([
                    ':provider' => $provider,
                    ':event_type' => 'affiliate_commission',
                    ':external_id' => (string)$deposit['id'],
                    ':payload' => json_encode($commissionResult, JSON_UNESCAPED_UNICODE),
                    ':signature' => $signature !== '' ? $signature : null,
                    ':status_code' => 200,
                    ':processing_status' => 'processed',
                ]);
        } catch (Throwable $e) {
            $pdo->prepare('INSERT INTO webhook_logs
                           (provider,event_type,external_id,payload,signature,status_code,processing_status)
                           VALUES
                           (:provider,:event_type,:external_id,:payload,:signature,:status_code,:processing_status)')
                ->execute([
                    ':provider' => $provider,
                    ':event_type' => 'affiliate_commission_error',
                    ':external_id' => (string)$deposit['id'],
                    ':payload' => json_encode([
                        'error_message' => $e->getMessage(),
                        'error_file' => $e->getFile(),
                        'error_line' => $e->getLine(),
                        'error_trace' => substr($e->getTraceAsString(), 0, 4000),
                        'deposit_id' => (string)$deposit['id'],
                        'referred_user_id' => (string)$deposit['user_id'],
                    ], JSON_UNESCAPED_UNICODE),
                    ':signature' => $signature !== '' ? $signature : null,
                    ':status_code' => 200,
                    ':processing_status' => 'error',
                ]);
        }

        $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code WHERE id = :id')
            ->execute([
                ':status' => 'processed',
                ':status_code' => 200,
                ':id' => $webhookLogId,
            ]);

        $pdo->commit();
        json_success([
            'message' => 'Deposit credited successfully',
            'deposit_id' => (string)$deposit['id'],
            'credited_amount' => number_format($toCredit, 2, '.', ''),
            'balance_after' => number_format($after, 2, '.', ''),
        ], 200);
    } catch (RuntimeException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        $reason = $e->getMessage();
        $errorPayload = [
            'webhook_payload' => $payload,
            'idTransaction' => $transactionId,
            'typeTransaction' => $typeTransaction,
            'error_message' => $e->getMessage(),
            'error_file' => $e->getFile(),
            'error_line' => $e->getLine(),
            'error_trace' => substr($e->getTraceAsString(), 0, 4000),
        ];
        $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code, payload = :payload WHERE id = :id')
            ->execute([
                ':status' => 'error',
                ':status_code' => 200,
                ':payload' => json_encode($errorPayload, JSON_UNESCAPED_UNICODE),
                ':id' => $webhookLogId,
            ]);

        json_success([
            'message' => 'Webhook processed with no financial action',
            'reason' => $reason,
        ], 200);
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        $errorPayload = [
            'webhook_payload' => $payload,
            'idTransaction' => $transactionId,
            'typeTransaction' => $typeTransaction,
            'error_message' => $e->getMessage(),
            'error_file' => $e->getFile(),
            'error_line' => $e->getLine(),
            'error_trace' => substr($e->getTraceAsString(), 0, 4000),
        ];
        $pdo->prepare('UPDATE webhook_logs SET processing_status = :status, status_code = :status_code, payload = :payload WHERE id = :id')
            ->execute([
                ':status' => 'error',
                ':status_code' => 200,
                ':payload' => json_encode($errorPayload, JSON_UNESCAPED_UNICODE),
                ':id' => $webhookLogId,
            ]);
        json_success([
            'message' => 'Webhook processed with internal error',
        ], 200);
    }
}

function process_affiliate_commission_for_paid_deposit(PDO $pdo, array $deposit, float $creditedAmount): array
{
    $depositId = (string)$deposit['id'];
    $referredUserId = (string)$deposit['user_id'];
    $depositAmount = (float)$deposit['amount'];
    $depositCreatedAt = (string)($deposit['created_at'] ?? '');

    $profileStmt = $pdo->prepare('SELECT referred_by FROM profiles WHERE user_id = :user_id LIMIT 1');
    $profileStmt->execute([':user_id' => $referredUserId]);
    $playerProfile = $profileStmt->fetch();
    $level1AffiliateId = trim((string)($playerProfile['referred_by'] ?? ''));
    if ($level1AffiliateId === '') {
        return ['status' => 'ignored', 'reason' => 'no_referrer'];
    }

    $settings = $pdo->query('SELECT *
                             FROM commission_settings
                             ORDER BY updated_at DESC
                             LIMIT 1')->fetch();
    if (!$settings || (int)$settings['is_active'] !== 1) {
        return ['status' => 'ignored', 'reason' => 'commission_inactive'];
    }

    $minDeposit = max(0.0, (float)$settings['min_deposit_for_commission']);
    if ($depositAmount < $minDeposit) {
        return ['status' => 'ignored', 'reason' => 'below_min_deposit_for_commission', 'min_deposit_for_commission' => $minDeposit];
    }

    $paidCountStmt = $pdo->prepare("SELECT COUNT(*)
                                    FROM deposits
                                    WHERE user_id = :user_id
                                      AND status = 'paid'
                                      AND amount >= :min_deposit");
    $paidCountStmt->execute([
        ':user_id' => $referredUserId,
        ':min_deposit' => $minDeposit,
    ]);
    $paidCount = (int)$paidCountStmt->fetchColumn();

    if ((int)$settings['first_deposit_only'] === 1 && $paidCount !== 1) {
        return ['status' => 'ignored', 'reason' => 'first_deposit_only_rule', 'paid_count' => $paidCount];
    }

    $level1ProfileStmt = $pdo->prepare('SELECT user_id,referred_by,comissao_cpa,comissao_cpa_nivel2
                                        FROM profiles
                                        WHERE user_id = :user_id
                                        LIMIT 1');
    $level1ProfileStmt->execute([':user_id' => $level1AffiliateId]);
    $level1Profile = $level1ProfileStmt->fetch();
    if (!$level1Profile) {
        return ['status' => 'ignored', 'reason' => 'level1_profile_not_found'];
    }

    $level2AffiliateId = trim((string)($level1Profile['referred_by'] ?? ''));
    $level2Profile = null;
    if ($level2AffiliateId !== '') {
        $level2ProfileStmt = $pdo->prepare('SELECT user_id,comissao_cpa,comissao_cpa_nivel2
                                            FROM profiles
                                            WHERE user_id = :user_id
                                            LIMIT 1');
        $level2ProfileStmt->execute([':user_id' => $level2AffiliateId]);
        $level2Profile = $level2ProfileStmt->fetch() ?: null;
        if ($level2Profile === null) {
            $level2AffiliateId = '';
        }
    }

    $basePercentLevel1 = (float)$settings['default_commission_percent'];
    $basePercentLevel2 = (float)$settings['default_commission_percent_level2'];
    $percentLevel1 = $level1Profile['comissao_cpa'] !== null ? (float)$level1Profile['comissao_cpa'] : $basePercentLevel1;
    $percentLevel2 = $level2Profile && $level2Profile['comissao_cpa_nivel2'] !== null
        ? (float)$level2Profile['comissao_cpa_nivel2']
        : $basePercentLevel2;

    $payouts = [];
    if ($percentLevel1 > 0) {
        $payouts[] = [
            'affiliate_user_id' => $level1AffiliateId,
            'percent' => $percentLevel1,
            'level' => 1,
        ];
    }
    if ($level2AffiliateId !== '' && $percentLevel2 > 0) {
        $payouts[] = [
            'affiliate_user_id' => $level2AffiliateId,
            'percent' => $percentLevel2,
            'level' => 2,
        ];
    }

    if (empty($payouts)) {
        return ['status' => 'ignored', 'reason' => 'no_positive_commission'];
    }

    $created = [];
    foreach ($payouts as $payout) {
        $affId = (string)$payout['affiliate_user_id'];
        $skipInterval = max(0, (int)$settings['affiliate_skip_interval']);
        if ($skipInterval > 0) {
            $eligibleEventNumber = affiliate_commission_eligible_event_number(
                $pdo,
                $affId,
                (int)$payout['level'],
                $depositId,
                $depositCreatedAt,
                $minDeposit,
                (int)$settings['first_deposit_only'] === 1
            );
            $cycle = $skipInterval + 1;
            if ($eligibleEventNumber > 0 && $eligibleEventNumber % $cycle === 0) {
                continue;
            }
        }

        $existsStmt = $pdo->prepare("SELECT id
                                     FROM affiliate_commissions
                                     WHERE affiliate_user_id = :affiliate_user_id
                                       AND referred_user_id = :referred_user_id
                                       AND source_type = 'deposit'
                                       AND source_id = :source_id
                                     LIMIT 1");
        $existsStmt->execute([
            ':affiliate_user_id' => $affId,
            ':referred_user_id' => $referredUserId,
            ':source_id' => $depositId,
        ]);
        if ($existsStmt->fetch()) {
            continue;
        }

        $commissionAmount = round($depositAmount * ((float)$payout['percent'] / 100), 2);
        if ($commissionAmount <= 0) {
            continue;
        }

        $walletStmt = $pdo->prepare('SELECT affiliate_balance,total_affiliate_earned,comissao_disponivel
                                     FROM wallets
                                     WHERE user_id = :user_id
                                     LIMIT 1
                                     FOR UPDATE');
        $walletStmt->execute([':user_id' => $affId]);
        $wallet = $walletStmt->fetch();
        if (!$wallet) {
            continue;
        }

        $before = (float)$wallet['affiliate_balance'];
        $after = round($before + $commissionAmount, 2);

        $updWallet = $pdo->prepare('UPDATE wallets
                            SET affiliate_balance = :affiliate_balance,
                                total_affiliate_earned = total_affiliate_earned + :amount_total_affiliate_earned,
                                comissao_disponivel = comissao_disponivel + :amount_comissao_disponivel,
                                updated_at = CURRENT_TIMESTAMP
                            WHERE user_id = :user_id');
        $updWallet->execute([
       ':affiliate_balance' => $after,
       ':amount_total_affiliate_earned' => $commissionAmount,
       ':amount_comissao_disponivel' => $commissionAmount,
       ':user_id' => $affId,
        ]);

        $insCommission = $pdo->prepare("INSERT INTO affiliate_commissions
                                        (affiliate_user_id,referred_user_id,source_type,source_id,amount,status)
                                        VALUES
                                        (:affiliate_user_id,:referred_user_id,'deposit',:source_id,:amount,'available')");
        $insCommission->execute([
            ':affiliate_user_id' => $affId,
            ':referred_user_id' => $referredUserId,
            ':source_id' => $depositId,
            ':amount' => $commissionAmount,
        ]);

        $txStmt = $pdo->prepare('INSERT INTO wallet_transactions
                                 (user_id, admin_id, game_session_id, type, amount, balance_before, balance_after, reason, description)
                                 VALUES
                                 (:user_id, NULL, NULL, :type, :amount, :before, :after, :reason, :description)');
        $txStmt->execute([
            ':user_id' => $affId,
            ':type' => 'commission',
            ':amount' => $commissionAmount,
            ':before' => $before,
            ':after' => $after,
            ':reason' => 'Affiliate commission from paid deposit',
            ':description' => 'CPA level ' . (int)$payout['level'] . ' - source deposit ' . $depositId,
        ]);

        $created[] = [
            'affiliate_user_id' => $affId,
            'level' => (int)$payout['level'],
            'percent' => (float)$payout['percent'],
            'amount' => $commissionAmount,
        ];
    }

    if (empty($created)) {
        return ['status' => 'ignored', 'reason' => 'commission_already_processed_or_unavailable_wallet'];
    }

    return [
        'status' => 'paid',
        'deposit_id' => $depositId,
        'items' => $created,
    ];
}

function affiliate_commission_eligible_event_number(
    PDO $pdo,
    string $affiliateUserId,
    int $level,
    string $currentDepositId,
    string $currentDepositCreatedAt,
    float $minDeposit,
    bool $firstDepositOnly
): int {
    if ($currentDepositCreatedAt === '') {
        $stmt = $pdo->prepare('SELECT created_at FROM deposits WHERE id = :id LIMIT 1');
        $stmt->execute([':id' => $currentDepositId]);
        $currentDepositCreatedAt = (string)$stmt->fetchColumn();
        if ($currentDepositCreatedAt === '') {
            return 0;
        }
    }

    if ($level === 1) {
        $joins = 'INNER JOIN profiles referred_profile ON referred_profile.user_id = d.user_id';
        $affiliateWhere = 'referred_profile.referred_by = :affiliate_user_id';
    } elseif ($level === 2) {
        $joins = 'INNER JOIN profiles referred_profile ON referred_profile.user_id = d.user_id
                  INNER JOIN profiles level1_profile ON level1_profile.user_id = referred_profile.referred_by';
        $affiliateWhere = 'level1_profile.referred_by = :affiliate_user_id';
    } else {
        return 0;
    }

    $firstDepositSql = '';
    if ($firstDepositOnly) {
        $firstDepositSql = " AND NOT EXISTS (
                                SELECT 1
                                FROM deposits prev
                                WHERE prev.user_id = d.user_id
                                  AND prev.status = 'paid'
                                  AND prev.amount >= :min_deposit
                                  AND (
                                      prev.created_at < d.created_at
                                      OR (prev.created_at = d.created_at AND prev.id < d.id)
                                  )
                            )";
    }

    $sql = "SELECT COUNT(*)
            FROM deposits d
            {$joins}
            WHERE d.status = 'paid'
              AND d.amount >= :min_deposit
              AND {$affiliateWhere}
              AND (
                  d.created_at < :current_created_at
                  OR (d.created_at = :current_created_at AND d.id <= :current_deposit_id)
              )
              {$firstDepositSql}";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':affiliate_user_id' => $affiliateUserId,
        ':min_deposit' => $minDeposit,
        ':current_created_at' => $currentDepositCreatedAt,
        ':current_deposit_id' => $currentDepositId,
    ]);

    return (int)$stmt->fetchColumn();
}

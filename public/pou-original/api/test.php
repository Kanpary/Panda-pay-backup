<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "Step 1: response.php\n";
require_once __DIR__ . '/helpers/response.php';
echo "OK\n";

echo "Step 2: onixpay.php\n";
require_once __DIR__ . '/helpers/onixpay.php';
echo "OK\n";

echo "Step 3: conn.php\n";
require_once __DIR__ . '/conn.php';
echo "OK\n";

echo "Step 4: payments.php\n";
require_once __DIR__ . '/controllers/payments.php';
echo "OK\n";

echo "Step 5: admin.php\n";
require_once __DIR__ . '/controllers/admin.php';
echo "OK\n";

echo "\nALL OK\n";

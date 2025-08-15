<?php
// Use Replit's PostgreSQL environment variables
$host = $_ENV['PGHOST'] ?? 'localhost';
$dbname = $_ENV['PGDATABASE'] ?? 'hotdog_dona_jo';
$username = $_ENV['PGUSER'] ?? 'postgres';
$password = $_ENV['PGPASSWORD'] ?? '';
$port = $_ENV['PGPORT'] ?? '5432';

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Erro na conexão: " . $e->getMessage());
}
?>

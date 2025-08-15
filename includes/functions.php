<?php
function isLoggedIn() {
    return isset($_SESSION['cliente_id']);
}

function isAdmin() {
    return isset($_SESSION['admin_id']);
}

function requireLogin() {
    if (!isLoggedIn()) {
        header('Location: /cliente/login.php');
        exit;
    }
}

function requireAdmin() {
    if (!isAdmin()) {
        header('Location: /admin/login.php');
        exit;
    }
}

function formatPrice($price) {
    return 'R$ ' . number_format($price, 2, ',', '.');
}

function calculateDiscountPercentage($original, $promotional) {
    if ($original <= 0) return 0;
    return round(100 - ($promotional / $original) * 100);
}

function addNotification($pdo, $tipo, $titulo, $mensagem, $destinatario, $cliente_id = null, $pedido_id = null) {
    $stmt = $pdo->prepare("INSERT INTO notificacoes (tipo, titulo, mensagem, destinatario, cliente_id, pedido_id) VALUES (?, ?, ?, ?, ?, ?)");
    return $stmt->execute([$tipo, $titulo, $mensagem, $destinatario, $cliente_id, $pedido_id]);
}

function getCartTotal($cart) {
    $total = 0;
    foreach ($cart as $item) {
        $total += $item['preco'] * $item['quantidade'];
    }
    return $total;
}

function getCartCount() {
    if (!isset($_SESSION['carrinho'])) {
        return 0;
    }
    $count = 0;
    foreach ($_SESSION['carrinho'] as $item) {
        $count += $item['quantidade'];
    }
    return $count;
}

function cleanInput($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>

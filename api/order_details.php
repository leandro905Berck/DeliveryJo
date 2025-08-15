<?php
session_start();
include '../includes/conexao.php';
include '../includes/functions.php';

header('Content-Type: application/json');

if (!isAdmin()) {
    echo json_encode(['success' => false, 'message' => 'Acesso negado']);
    exit;
}

$pedido_id = (int)($_GET['id'] ?? 0);

if ($pedido_id <= 0) {
    echo json_encode(['success' => false, 'message' => 'ID inválido']);
    exit;
}

try {
    // Get order details
    $stmt = $pdo->prepare("
        SELECT p.*, c.nome as cliente_nome, c.telefone as cliente_telefone, 
               c.endereco as cliente_endereco, b.nome as bairro_nome
        FROM pedidos p 
        JOIN clientes c ON p.cliente_id = c.id
        JOIN bairros b ON c.bairro_id = b.id
        WHERE p.id = ?
    ");
    $stmt->execute([$pedido_id]);
    $pedido = $stmt->fetch();
    
    if (!$pedido) {
        echo json_encode(['success' => false, 'message' => 'Pedido não encontrado']);
        exit;
    }
    
    // Get order items
    $stmt = $pdo->prepare("
        SELECT pi.*, 
               CASE 
                   WHEN pi.tipo_item = 'lanche' THEN l.nome 
                   ELSE a.nome 
               END as item_nome
        FROM pedido_itens pi
        LEFT JOIN lanches l ON pi.tipo_item = 'lanche' AND pi.item_id = l.id
        LEFT JOIN acompanhamentos a ON pi.tipo_item = 'acompanhamento' AND pi.item_id = a.id
        WHERE pi.pedido_id = ?
    ");
    $stmt->execute([$pedido_id]);
    $itens = $stmt->fetchAll();
    
    echo json_encode([
        'success' => true,
        'pedido' => $pedido,
        'itens' => $itens
    ]);
    
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Erro interno']);
}
?>
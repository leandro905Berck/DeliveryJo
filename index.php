<?php
session_start();
include 'includes/conexao.php';
include 'includes/header.php';

// Get all active products
$stmt = $pdo->query("SELECT * FROM lanches WHERE ativo = TRUE ORDER BY nome");
$lanches = $stmt->fetchAll();

$stmt = $pdo->query("SELECT * FROM acompanhamentos WHERE ativo = TRUE ORDER BY nome");
$acompanhamentos = $stmt->fetchAll();
?>

<!-- Hero Section -->
<div class="hero-section text-center">
    <div class="container">
        <h1 class="hero-title">🌭 Hot Dog da Dona Jo</h1>
        <p class="hero-subtitle">Os melhores hot dogs da cidade, entregues com carinho na sua casa!</p>
    </div>
</div>

<div class="container">
    <!-- Category Tabs -->
    <ul class="nav nav-pills category-tabs justify-content-center mb-4" id="categoryTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="lanches-tab" data-bs-toggle="pill" data-bs-target="#lanches" type="button" role="tab">
                <i class="fas fa-hotdog me-2"></i>Hot Dogs
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="acompanhamentos-tab" data-bs-toggle="pill" data-bs-target="#acompanhamentos" type="button" role="tab">
                <i class="fas fa-utensils me-2"></i>Acompanhamentos
            </button>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="categoryTabContent">
        <!-- Lanches Tab -->
        <div class="tab-pane fade show active" id="lanches" role="tabpanel">
            <div class="row">
                <?php foreach ($lanches as $item): ?>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 position-relative">
                        <?php if ($item['em_promocao'] && $item['preco_promocional']): ?>
                        <span class="badge badge-discount position-absolute">
                            <?= calculateDiscountPercentage($item['preco'], $item['preco_promocional']) ?>% OFF
                        </span>
                        <?php endif; ?>
                        
                        <img src="https://via.placeholder.com/400x200/dc3545/ffffff?text=<?= urlencode($item['nome']) ?>" 
                             class="card-img-top" alt="<?= htmlspecialchars($item['nome']) ?>">
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><?= htmlspecialchars($item['nome']) ?></h5>
                            <p class="card-text text-muted flex-grow-1"><?= htmlspecialchars($item['descricao']) ?></p>
                            
                            <div class="price-section mb-3">
                                <?php if ($item['em_promocao'] && $item['preco_promocional']): ?>
                                    <span class="price-original"><?= formatPrice($item['preco']) ?></span>
                                    <span class="price-promotional d-block"><?= formatPrice($item['preco_promocional']) ?></span>
                                <?php else: ?>
                                    <span class="price-regular"><?= formatPrice($item['preco']) ?></span>
                                <?php endif; ?>
                            </div>
                            
                            <button class="btn btn-success w-100 add-to-cart" 
                                    data-item-id="<?= $item['id'] ?>" 
                                    data-item-type="lanche">
                                <i class="fas fa-cart-plus me-2"></i>Adicionar ao Carrinho
                            </button>
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>

        <!-- Acompanhamentos Tab -->
        <div class="tab-pane fade" id="acompanhamentos" role="tabpanel">
            <div class="row">
                <?php foreach ($acompanhamentos as $item): ?>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="https://via.placeholder.com/400x200/ffc107/ffffff?text=<?= urlencode($item['nome']) ?>" 
                             class="card-img-top" alt="<?= htmlspecialchars($item['nome']) ?>">
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><?= htmlspecialchars($item['nome']) ?></h5>
                            <p class="card-text text-muted flex-grow-1"><?= htmlspecialchars($item['descricao']) ?></p>
                            
                            <div class="price-section mb-3">
                                <span class="price-regular"><?= formatPrice($item['preco']) ?></span>
                            </div>
                            
                            <button class="btn btn-success w-100 add-to-cart" 
                                    data-item-id="<?= $item['id'] ?>" 
                                    data-item-type="acompanhamento">
                                <i class="fas fa-cart-plus me-2"></i>Adicionar ao Carrinho
                            </button>
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

    <!-- Empty state if no products -->
    <?php if (empty($lanches) && empty($acompanhamentos)): ?>
    <div class="text-center py-5">
        <i class="fas fa-utensils fa-3x text-muted mb-3"></i>
        <h3 class="text-muted">Cardápio em atualização</h3>
        <p class="text-muted">Nossos deliciosos produtos estarão disponíveis em breve!</p>
    </div>
    <?php endif; ?>
</div>

<!-- Floating WhatsApp Button -->
<button class="whatsapp-fab" onclick="window.open('https://wa.me/5511999999999', '_blank')" title="Fale conosco no WhatsApp">
    <i class="fab fa-whatsapp"></i>
</button>

<script>
// Add to cart functionality
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
            const itemId = this.dataset.itemId;
            const itemType = this.dataset.itemType;
            
            // Check if user is logged in
            <?php if (!isLoggedIn()): ?>
            showWarningNotification('Você precisa fazer login para adicionar itens ao carrinho.');
            setTimeout(() => {
                window.location.href = '/cliente/login.php';
            }, 2000);
            return;
            <?php endif; ?>
            
            addToCart(itemId, itemType);
        });
    });
});

function addToCart(itemId, itemType) {
    const button = document.querySelector(`[data-item-id="${itemId}"][data-item-type="${itemType}"]`);
    const originalText = button.innerHTML;
    
    button.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Adicionando...';
    button.disabled = true;

    const formData = new FormData();
    formData.append('action', 'add');
    formData.append('item_id', itemId);
    formData.append('item_type', itemType);

    fetch('/cliente/carrinho.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showSuccessNotification('Produto adicionado ao carrinho!');
            updateCartBadge(data.cartCount);
        } else {
            showErrorNotification(data.message || 'Erro ao adicionar produto');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showErrorNotification('Erro ao adicionar produto');
    })
    .finally(() => {
        button.innerHTML = originalText;
        button.disabled = false;
    });
}

function updateCartBadge(count) {
    const badge = document.querySelector('.navbar .badge');
    if (badge) {
        if (count > 0) {
            badge.textContent = count;
            badge.style.display = 'inline';
        } else {
            badge.style.display = 'none';
        }
    }
}
</script>

<?php include 'includes/footer.php'; ?>

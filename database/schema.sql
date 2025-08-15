-- Banco de dados para Hot Dog da Dona Jo
CREATE DATABASE IF NOT EXISTS hotdog_dona_jo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hotdog_dona_jo;

-- Tabela de bairros com valores de frete
CREATE TABLE bairros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_frete DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco TEXT NOT NULL,
    bairro_id INT NOT NULL,
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bairro_id) REFERENCES bairros(id)
);

-- Tabela de lanches
CREATE TABLE lanches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    em_promocao BOOLEAN DEFAULT FALSE,
    preco_promocional DECIMAL(10,2) NULL,
    foto VARCHAR(255),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de acompanhamentos
CREATE TABLE acompanhamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    foto VARCHAR(255),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    total_produtos DECIMAL(10,2) NOT NULL,
    frete DECIMAL(10,2) NOT NULL,
    total_geral DECIMAL(10,2) NOT NULL,
    status ENUM('pendente', 'aceito', 'preparando', 'entregando', 'entregue', 'cancelado') DEFAULT 'pendente',
    observacoes TEXT,
    endereco_entrega TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela de itens do pedido
CREATE TABLE pedido_itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    tipo_item ENUM('lanche', 'acompanhamento') NOT NULL,
    item_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE
);

-- Tabela de notificações
CREATE TABLE notificacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('novo_pedido', 'pedido_aceito', 'pedido_cancelado') NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    mensagem TEXT NOT NULL,
    destinatario ENUM('admin', 'cliente') NOT NULL,
    cliente_id INT NULL,
    pedido_id INT NULL,
    lida BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

-- Tabela de administradores
CREATE TABLE administradores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir dados iniciais
INSERT INTO bairros (nome, valor_frete) VALUES 
('Centro', 3.00),
('Vila Nova', 5.00),
('Jardim América', 4.50),
('São José', 6.00),
('Cidade Alta', 7.00);

INSERT INTO administradores (nome, email, senha) VALUES 
('Admin', 'admin@hotdog.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'); -- senha: password

INSERT INTO lanches (nome, descricao, preco, foto) VALUES 
('Hot Dog Tradicional', 'Pão, salsicha, molho especial, batata palha e milho', 12.00, 'hotdog-tradicional.jpg'),
('Hot Dog Especial', 'Pão, salsicha, queijo, presunto, molho especial, batata palha e milho', 15.00, 'hotdog-especial.jpg'),
('Hot Dog Bacon', 'Pão, salsicha, bacon, queijo, molho especial, batata palha e milho', 18.00, 'hotdog-bacon.jpg');

INSERT INTO acompanhamentos (nome, descricao, preco, foto) VALUES 
('Batata Frita', 'Porção de batata frita crocante', 8.00, 'batata-frita.jpg'),
('Refrigerante 350ml', 'Coca-Cola, Guaraná ou Fanta', 4.00, 'refrigerante.jpg'),
('Suco Natural 300ml', 'Laranja, Limão ou Maracujá', 5.00, 'suco-natural.jpg');

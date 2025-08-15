-- Banco de dados para Hot Dog da Dona Jo - PostgreSQL
-- Drop tables if they exist (in reverse order due to foreign keys)
DROP TABLE IF EXISTS notificacoes;
DROP TABLE IF EXISTS pedido_itens;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS acompanhamentos;
DROP TABLE IF EXISTS lanches;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS administradores;
DROP TABLE IF EXISTS bairros;

-- Create ENUM types
CREATE TYPE status_pedido AS ENUM ('pendente', 'aceito', 'preparando', 'entregando', 'entregue', 'cancelado');
CREATE TYPE tipo_item AS ENUM ('lanche', 'acompanhamento');
CREATE TYPE tipo_notificacao AS ENUM ('novo_pedido', 'pedido_aceito', 'pedido_cancelado');
CREATE TYPE destinatario_notificacao AS ENUM ('admin', 'cliente');

-- Tabela de bairros com valores de frete
CREATE TABLE bairros (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_frete DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de administradores
CREATE TABLE administradores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco TEXT NOT NULL,
    bairro_id INTEGER NOT NULL REFERENCES bairros(id),
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de lanches
CREATE TABLE lanches (
    id SERIAL PRIMARY KEY,
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
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    foto VARCHAR(255),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(id),
    total_produtos DECIMAL(10,2) NOT NULL,
    frete DECIMAL(10,2) NOT NULL,
    total_geral DECIMAL(10,2) NOT NULL,
    status status_pedido DEFAULT 'pendente',
    observacoes TEXT,
    endereco_entrega TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de itens do pedido
CREATE TABLE pedido_itens (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    tipo_item tipo_item NOT NULL,
    item_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL
);

-- Tabela de notificações
CREATE TABLE notificacoes (
    id SERIAL PRIMARY KEY,
    tipo tipo_notificacao NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    mensagem TEXT NOT NULL,
    destinatario destinatario_notificacao NOT NULL,
    cliente_id INTEGER REFERENCES clientes(id),
    pedido_id INTEGER REFERENCES pedidos(id),
    lida BOOLEAN DEFAULT FALSE,
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

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for automatic updated_at on pedidos table
CREATE TRIGGER update_pedidos_updated_at BEFORE UPDATE ON pedidos
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
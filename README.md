Replit-Commit-Author: Agent
Replit-Commit-Session-Id: 5e5ec4ea-3b62-4fbd-8ff5-a1174ccc19b4
Replit-Commit-Checkpoint-Type: full_checkpoint
Replit-Commit-Screenshot-Url: https://storage.googleapis.com/screenshot-production-us-central1/9c9f4b74-e164-4666-aba2-45fabd100490/5e5ec4ea-3b62-4fbd-8ff5-a1174ccc19b4/8PQBQkQ


# Hot Dog da Dona Jo - Sistema de Delivery

## Descrição
Sistema completo de delivery para a lanchonete "Hot Dog da Dona Jo" com área administrativa, sistema de pedidos, carrinho de compras e notificações em tempo real.

## Funcionalidades Principais

### Para Clientes:
- 🍔 Cardápio interativo com lanches e acompanhamentos
- 🛒 Carrinho de compras com atualização em tempo real  
- 📍 Cálculo de frete por bairro
- 💳 Seleção de forma de pagamento
- 📱 Confirmação de entrega pelo cliente
- 🔔 Sistema de notificações
- 📋 Histórico de pedidos

### Para Administradores:
- 👨‍💼 Dashboard administrativo completo
- 📊 Visualização e gerenciamento de pedidos
- 📈 Estatísticas de vendas
- 🔔 Notificações de novos pedidos e confirmações
- 📝 Detalhes completos dos pedidos

## Tecnologias Utilizadas
- **Backend**: PHP 8+
- **Banco de Dados**: PostgreSQL
- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Framework CSS**: Bootstrap 5
- **Ícones**: Font Awesome

## Instalação

### 1. Requisitos
- PHP 8.0 ou superior
- PostgreSQL 12 ou superior
- Servidor web (Apache/Nginx)

### 2. Configuração do Banco de Dados
```bash
# Restaurar o banco de dados
psql -U seu_usuario -d nome_do_banco < database_export.sql
```

### 3. Configuração do PHP
Certifique-se de que as seguintes extensões estão habilitadas:
- pdo_pgsql
- pgsql
- session

### 4. Configuração das Variáveis de Ambiente
Configure as seguintes variáveis no seu servidor:
```
DATABASE_URL=postgresql://usuario:senha@host:porta/banco
PGHOST=seu_host
PGPORT=5432
PGUSER=seu_usuario
PGPASSWORD=sua_senha
PGDATABASE=nome_do_banco
```

### 5. Estrutura de Arquivos
```
/
├── admin/              # Área administrativa
├── api/               # APIs e endpoints
├── assets/            # CSS, JS e imagens
├── cliente/           # Área do cliente
├── database/          # Scripts do banco
├── includes/          # Arquivos compartilhados
├── index.php          # Página principal
└── database_export.sql # Backup do banco
```

## Acesso ao Sistema

### Cliente
- Acesse a página principal: `http://seu-dominio/`
- Cadastre-se ou faça login
- Navegue pelo cardápio e faça seus pedidos

### Administrador
- Acesse: `http://seu-dominio/admin/`
- **Login**: admin@hotdog.com
- **Senha**: password

## Dados de Teste

### Bairros Cadastrados
- Centro (Frete: R$ 3,00)
- Jardim das Flores (Frete: R$ 5,00)  
- Vila Nova (Frete: R$ 4,00)
- Bela Vista (Frete: R$ 6,00)

### Cardápio Pré-cadastrado
- **Lanches**: Hot Dog Tradicional, Hot Dog Especial, Hot Dog Vegetariano
- **Acompanhamentos**: Batata Frita, Refrigerante, Suco Natural

## Funcionalidades Avançadas

### Sistema de Notificações
- Notificações em tempo real para admin e clientes
- Marcação automática como lida
- Diferentes tipos de notificação

### Confirmação de Entrega
- Cliente pode confirmar recebimento do pedido
- Status automático muda para "entregue"
- Notificação para o administrador

### Carrinho Inteligente
- Adição/remoção de itens sem recarregar página
- Cálculo automático de totais
- Persistência entre sessões

## Suporte e Manutenção
- Logs de erro disponíveis nos arquivos de log do servidor
- Sistema de backup automático do banco de dados
- Documentação técnica em `replit.md`

## Segurança
- Senhas criptografadas com hash seguro
- Validação de sessões
- Proteção contra SQL injection
- Sanitização de dados de entrada

---

**Desenvolvido para Hot Dog da Dona Jo**  
*Sistema completo de delivery com tecnologia moderna e interface amigável*

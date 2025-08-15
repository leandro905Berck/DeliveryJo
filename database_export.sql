--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.pedidos DROP CONSTRAINT IF EXISTS pedidos_cliente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pedido_itens DROP CONSTRAINT IF EXISTS pedido_itens_pedido_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notificacoes DROP CONSTRAINT IF EXISTS notificacoes_pedido_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notificacoes DROP CONSTRAINT IF EXISTS notificacoes_cliente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.clientes DROP CONSTRAINT IF EXISTS clientes_bairro_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pedidos DROP CONSTRAINT IF EXISTS pedidos_pkey;
ALTER TABLE IF EXISTS ONLY public.pedido_itens DROP CONSTRAINT IF EXISTS pedido_itens_pkey;
ALTER TABLE IF EXISTS ONLY public.notificacoes DROP CONSTRAINT IF EXISTS notificacoes_pkey;
ALTER TABLE IF EXISTS ONLY public.lanches DROP CONSTRAINT IF EXISTS lanches_pkey;
ALTER TABLE IF EXISTS ONLY public.clientes DROP CONSTRAINT IF EXISTS clientes_pkey;
ALTER TABLE IF EXISTS ONLY public.clientes DROP CONSTRAINT IF EXISTS clientes_email_key;
ALTER TABLE IF EXISTS ONLY public.bairros DROP CONSTRAINT IF EXISTS bairros_pkey;
ALTER TABLE IF EXISTS ONLY public.administradores DROP CONSTRAINT IF EXISTS administradores_pkey;
ALTER TABLE IF EXISTS ONLY public.administradores DROP CONSTRAINT IF EXISTS administradores_email_key;
ALTER TABLE IF EXISTS ONLY public.acompanhamentos DROP CONSTRAINT IF EXISTS acompanhamentos_pkey;
ALTER TABLE IF EXISTS public.pedidos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pedido_itens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notificacoes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lanches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.clientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bairros ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.administradores ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.acompanhamentos ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.pedidos_id_seq;
DROP TABLE IF EXISTS public.pedidos;
DROP SEQUENCE IF EXISTS public.pedido_itens_id_seq;
DROP TABLE IF EXISTS public.pedido_itens;
DROP SEQUENCE IF EXISTS public.notificacoes_id_seq;
DROP TABLE IF EXISTS public.notificacoes;
DROP SEQUENCE IF EXISTS public.lanches_id_seq;
DROP TABLE IF EXISTS public.lanches;
DROP SEQUENCE IF EXISTS public.clientes_id_seq;
DROP TABLE IF EXISTS public.clientes;
DROP SEQUENCE IF EXISTS public.bairros_id_seq;
DROP TABLE IF EXISTS public.bairros;
DROP SEQUENCE IF EXISTS public.administradores_id_seq;
DROP TABLE IF EXISTS public.administradores;
DROP SEQUENCE IF EXISTS public.acompanhamentos_id_seq;
DROP TABLE IF EXISTS public.acompanhamentos;
DROP TYPE IF EXISTS public.tipo_notificacao;
DROP TYPE IF EXISTS public.tipo_item;
DROP TYPE IF EXISTS public.status_pedido;
DROP TYPE IF EXISTS public.destinatario_notificacao;
--
-- Name: destinatario_notificacao; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.destinatario_notificacao AS ENUM (
    'admin',
    'cliente'
);


--
-- Name: status_pedido; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.status_pedido AS ENUM (
    'pendente',
    'aceito',
    'preparando',
    'entregando',
    'entregue',
    'cancelado'
);


--
-- Name: tipo_item; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.tipo_item AS ENUM (
    'lanche',
    'acompanhamento'
);


--
-- Name: tipo_notificacao; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.tipo_notificacao AS ENUM (
    'novo_pedido',
    'pedido_aceito',
    'pedido_cancelado'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: acompanhamentos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acompanhamentos (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text,
    preco numeric(10,2) NOT NULL,
    foto character varying(255),
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: acompanhamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.acompanhamentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: acompanhamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.acompanhamentos_id_seq OWNED BY public.acompanhamentos.id;


--
-- Name: administradores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.administradores (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(255) NOT NULL,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: administradores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.administradores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: administradores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.administradores_id_seq OWNED BY public.administradores.id;


--
-- Name: bairros; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bairros (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    valor_frete numeric(10,2) DEFAULT 0.00 NOT NULL,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: bairros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bairros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bairros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bairros_id_seq OWNED BY public.bairros.id;


--
-- Name: clientes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    telefone character varying(20) NOT NULL,
    endereco text NOT NULL,
    bairro_id integer NOT NULL,
    senha character varying(255) NOT NULL,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: lanches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lanches (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text,
    preco numeric(10,2) NOT NULL,
    em_promocao boolean DEFAULT false,
    preco_promocional numeric(10,2),
    foto character varying(255),
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: lanches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lanches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lanches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lanches_id_seq OWNED BY public.lanches.id;


--
-- Name: notificacoes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notificacoes (
    id integer NOT NULL,
    tipo public.tipo_notificacao NOT NULL,
    titulo character varying(255) NOT NULL,
    mensagem text NOT NULL,
    destinatario public.destinatario_notificacao NOT NULL,
    cliente_id integer,
    pedido_id integer,
    lida boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: notificacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notificacoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notificacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notificacoes_id_seq OWNED BY public.notificacoes.id;


--
-- Name: pedido_itens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pedido_itens (
    id integer NOT NULL,
    pedido_id integer NOT NULL,
    tipo_item public.tipo_item NOT NULL,
    item_id integer NOT NULL,
    quantidade integer DEFAULT 1 NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


--
-- Name: pedido_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pedido_itens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pedido_itens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pedido_itens_id_seq OWNED BY public.pedido_itens.id;


--
-- Name: pedidos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pedidos (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    total_produtos numeric(10,2) NOT NULL,
    frete numeric(10,2) NOT NULL,
    total_geral numeric(10,2) NOT NULL,
    status public.status_pedido DEFAULT 'pendente'::public.status_pedido,
    observacoes text,
    endereco_entrega text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento character varying(50),
    confirmado_cliente boolean DEFAULT false
);


--
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;


--
-- Name: acompanhamentos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acompanhamentos ALTER COLUMN id SET DEFAULT nextval('public.acompanhamentos_id_seq'::regclass);


--
-- Name: administradores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administradores ALTER COLUMN id SET DEFAULT nextval('public.administradores_id_seq'::regclass);


--
-- Name: bairros id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bairros ALTER COLUMN id SET DEFAULT nextval('public.bairros_id_seq'::regclass);


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: lanches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lanches ALTER COLUMN id SET DEFAULT nextval('public.lanches_id_seq'::regclass);


--
-- Name: notificacoes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacoes ALTER COLUMN id SET DEFAULT nextval('public.notificacoes_id_seq'::regclass);


--
-- Name: pedido_itens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido_itens ALTER COLUMN id SET DEFAULT nextval('public.pedido_itens_id_seq'::regclass);


--
-- Name: pedidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);


--
-- Data for Name: acompanhamentos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.acompanhamentos (id, nome, descricao, preco, foto, ativo, created_at) FROM stdin;
1	Batata Frita	Porção de batata frita crocante	8.00	batata-frita.jpg	t	2025-08-15 19:25:22.01029
2	Refrigerante 350ml	Coca-Cola, Guaraná ou Fanta	4.00	refrigerante.jpg	t	2025-08-15 19:25:22.01029
3	Suco Natural 300ml	Laranja, Limão ou Maracujá	5.00	suco-natural.jpg	t	2025-08-15 19:25:22.01029
\.


--
-- Data for Name: administradores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.administradores (id, nome, email, senha, ativo, created_at) FROM stdin;
1	Admin	admin@hotdog.com	$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	t	2025-08-15 19:25:14.708974
\.


--
-- Data for Name: bairros; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bairros (id, nome, valor_frete, ativo, created_at) FROM stdin;
2	Vila Nova	5.00	t	2025-08-15 19:25:14.708974
3	Jardim América	4.50	t	2025-08-15 19:25:14.708974
4	São José	6.00	t	2025-08-15 19:25:14.708974
5	Cidade Alta	7.00	t	2025-08-15 19:25:14.708974
1	Centro	2.00	t	2025-08-15 19:25:14.708974
\.


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.clientes (id, nome, email, telefone, endereco, bairro_id, senha, ativo, created_at) FROM stdin;
1	LEANDRO MATHEUS BERCK	leandromberck@gmail.com	((19) 99761-6323	Jardim Santos Dumont\r\nCasa	1	$2y$10$4UtI0VexIe.C0oTM9M6DZOh/XlRkxCz6RzlvlkM26sC4KRpW1pn2K	t	2025-08-15 19:35:17.163467
\.


--
-- Data for Name: lanches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lanches (id, nome, descricao, preco, em_promocao, preco_promocional, foto, ativo, created_at) FROM stdin;
3	Hot Dog Bacon	Pão, salsicha, bacon, queijo, molho especial, batata palha e milho	18.00	t	8.00	hotdog-bacon.jpg	t	2025-08-15 19:25:22.01029
2	Hot Dog Especial	Pão, salsicha, queijo, presunto, molho especial, batata palha e milho	15.00	t	10.00	hotdog-especial.jpg	t	2025-08-15 19:25:22.01029
1	Hot Dog Tradicional	Pão, salsicha, molho especial, batata palha e milho	12.00	t	10.00	hotdog-tradicional.jpg	t	2025-08-15 19:25:22.01029
\.


--
-- Data for Name: notificacoes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notificacoes (id, tipo, titulo, mensagem, destinatario, cliente_id, pedido_id, lida, created_at) FROM stdin;
1	novo_pedido	Novo Pedido Recebido	Pedido #1 de LEANDRO MATHEUS BERCK	admin	\N	1	f	2025-08-15 19:38:17.838766
2	pedido_aceito	Status do Pedido Atualizado	Seu pedido foi aceito e está sendo preparado!	cliente	1	1	t	2025-08-15 19:39:59.166083
3	pedido_aceito	Status do Pedido Atualizado	Seu pedido está sendo preparado!	cliente	1	1	t	2025-08-15 19:40:57.088383
4	pedido_aceito	Status do Pedido Atualizado	Seu pedido saiu para entrega!	cliente	1	1	t	2025-08-15 19:45:52.322651
5	pedido_aceito	Status do Pedido Atualizado	Seu pedido foi entregue!	cliente	1	1	t	2025-08-15 19:48:13.675953
6	novo_pedido	Novo Pedido Recebido	Pedido #2 de LEANDRO MATHEUS BERCK	admin	\N	2	f	2025-08-15 19:51:08.697727
7	pedido_aceito	Status do Pedido Atualizado	Seu pedido foi aceito e está sendo preparado!	cliente	1	2	t	2025-08-15 19:51:57.9107
8	pedido_aceito	Status do Pedido Atualizado	Seu pedido está sendo preparado!	cliente	1	2	t	2025-08-15 19:52:10.277239
9	pedido_aceito	Status do Pedido Atualizado	Seu pedido saiu para entrega!	cliente	1	2	t	2025-08-15 19:52:51.873465
10	novo_pedido	Novo Pedido Recebido	Pedido #3 de LEANDRO MATHEUS BERCK	admin	\N	3	f	2025-08-15 19:56:57.707769
11	pedido_aceito	Status do Pedido Atualizado	Seu pedido foi aceito e está sendo preparado!	cliente	1	3	t	2025-08-15 19:57:38.791201
12	pedido_aceito	Status do Pedido Atualizado	Seu pedido está sendo preparado!	cliente	1	3	t	2025-08-15 19:57:46.548021
13	pedido_aceito	Status do Pedido Atualizado	Seu pedido saiu para entrega!	cliente	1	3	t	2025-08-15 19:58:24.218283
14	novo_pedido	Novo Pedido Recebido	Pedido #4 de LEANDRO MATHEUS BERCK	admin	\N	4	f	2025-08-15 20:01:46.482478
15	pedido_aceito	Status do Pedido Atualizado	Seu pedido foi aceito e está sendo preparado!	cliente	1	4	t	2025-08-15 20:02:21.504346
16	pedido_aceito	Status do Pedido Atualizado	Seu pedido está sendo preparado!	cliente	1	4	t	2025-08-15 20:02:32.345296
17	pedido_aceito	Status do Pedido Atualizado	Seu pedido saiu para entrega!	cliente	1	4	t	2025-08-15 20:03:16.354827
18	novo_pedido	Novo Pedido Recebido	Pedido #5 de LEANDRO MATHEUS BERCK	admin	\N	5	f	2025-08-15 20:05:51.420877
19	pedido_aceito	Status do Pedido Atualizado	Seu pedido foi aceito e está sendo preparado!	cliente	1	5	t	2025-08-15 20:06:30.94629
20	pedido_aceito	Status do Pedido Atualizado	Seu pedido está sendo preparado!	cliente	1	5	f	2025-08-15 20:07:02.923989
21	pedido_aceito	Status do Pedido Atualizado	Seu pedido saiu para entrega!	cliente	1	5	f	2025-08-15 20:07:36.676864
\.


--
-- Data for Name: pedido_itens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pedido_itens (id, pedido_id, tipo_item, item_id, quantidade, preco_unitario, subtotal) FROM stdin;
1	1	acompanhamento	1	2	8.00	16.00
2	1	lanche	3	2	8.00	16.00
3	2	lanche	3	2	8.00	16.00
4	3	lanche	3	1	8.00	8.00
5	3	acompanhamento	3	1	5.00	5.00
6	4	lanche	2	2	10.00	20.00
7	4	lanche	1	1	10.00	10.00
8	4	acompanhamento	2	1	4.00	4.00
9	5	lanche	1	1	10.00	10.00
10	5	acompanhamento	2	1	4.00	4.00
\.


--
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pedidos (id, cliente_id, total_produtos, frete, total_geral, status, observacoes, endereco_entrega, created_at, updated_at, forma_pagamento, confirmado_cliente) FROM stdin;
1	1	32.00	2.00	34.00	entregue		Jardim Santos Dumont\r\nCasa	2025-08-15 19:38:17.838766	2025-08-15 19:38:17.838766	\N	f
2	1	16.00	2.00	18.00	entregue		Jardim Santos Dumont\r\nCasa	2025-08-15 19:51:08.697727	2025-08-15 19:51:08.697727	pix	t
3	1	13.00	2.00	15.00	entregue	Bem passado e com bastante ketchup	Jardim Santos Dumont\r\nCasa	2025-08-15 19:56:57.707769	2025-08-15 19:56:57.707769	dinheiro	t
4	1	34.00	2.00	36.00	entregue	Sem sal na batata	Jardim Santos Dumont\r\nCasa	2025-08-15 20:01:46.482478	2025-08-15 20:01:46.482478	dinheiro	t
5	1	14.00	2.00	16.00	entregando		Avenida painguas	2025-08-15 20:05:51.420877	2025-08-15 20:05:51.420877	dinheiro	f
\.


--
-- Name: acompanhamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.acompanhamentos_id_seq', 3, true);


--
-- Name: administradores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.administradores_id_seq', 1, true);


--
-- Name: bairros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bairros_id_seq', 5, true);


--
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clientes_id_seq', 1, true);


--
-- Name: lanches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lanches_id_seq', 3, true);


--
-- Name: notificacoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notificacoes_id_seq', 21, true);


--
-- Name: pedido_itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pedido_itens_id_seq', 10, true);


--
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 5, true);


--
-- Name: acompanhamentos acompanhamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acompanhamentos
    ADD CONSTRAINT acompanhamentos_pkey PRIMARY KEY (id);


--
-- Name: administradores administradores_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administradores
    ADD CONSTRAINT administradores_email_key UNIQUE (email);


--
-- Name: administradores administradores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administradores
    ADD CONSTRAINT administradores_pkey PRIMARY KEY (id);


--
-- Name: bairros bairros_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bairros
    ADD CONSTRAINT bairros_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: lanches lanches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lanches
    ADD CONSTRAINT lanches_pkey PRIMARY KEY (id);


--
-- Name: notificacoes notificacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT notificacoes_pkey PRIMARY KEY (id);


--
-- Name: pedido_itens pedido_itens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido_itens
    ADD CONSTRAINT pedido_itens_pkey PRIMARY KEY (id);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_bairro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_bairro_id_fkey FOREIGN KEY (bairro_id) REFERENCES public.bairros(id);


--
-- Name: notificacoes notificacoes_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT notificacoes_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: notificacoes notificacoes_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT notificacoes_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id);


--
-- Name: pedido_itens pedido_itens_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido_itens
    ADD CONSTRAINT pedido_itens_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- Name: pedidos pedidos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- PostgreSQL database dump complete
--


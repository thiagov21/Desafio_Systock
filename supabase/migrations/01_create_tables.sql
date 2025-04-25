-- Tabela de vendas
CREATE TABLE IF NOT EXISTS public.venda(
    venda_id int8 NOT NULL,
    data_emissao date NOT NULL,
    horariomov varchar(8) DEFAULT '00:00:00'::character varying NOT NULL,
    produto_id varchar(25) DEFAULT ''::character varying NOT NULL,
    qtde_vendida float8 NULL,
    valor_unitario numeric(12, 4) DEFAULT 0 NOT NULL,
    filial_id int8 DEFAULT 1 NOT NULL,
    item int4 DEFAULT 0 NOT NULL,
    unidade_medida varchar(3) NULL,
    CONSTRAINT pk_consumo PRIMARY KEY (filial_id, venda_id, data_emissao, produto_id, item, horariomov)
);

-- Tabela de pedidos de compra
CREATE TABLE IF NOT EXISTS public.pedido_compra(
    pedido_id float8 DEFAULT 0 NOT NULL,
    data_pedido date NULL,
    item float8 DEFAULT 0 NOT NULL,
    produto_id varchar(25) DEFAULT '0' NOT NULL,
    descricao_produto varchar(255) NULL,
    ordem_compra float8 DEFAULT 0 NOT NULL,
    qtde_pedida float8 NULL,
    filial_id int4 NULL,
    data_entrega date NULL,
    qtde_entregue float8 DEFAULT 0 NOT NULL,
    qtde_pendente float8 DEFAULT 0 NOT NULL,
    preco_compra float8 DEFAULT 0 NULL,
    fornecedor_id int4 DEFAULT 0 NULL,
    CONSTRAINT pedido_compra_pkey PRIMARY KEY (pedido_id, produto_id, item)
);

-- Tabela de entradas de mercadoria
CREATE TABLE IF NOT EXISTS public.entradas_mercadoria (
    data_entrada date NULL,
    nro_nfe varchar(255) NOT NULL,
    item float8 DEFAULT 0 NOT NULL,
    produto_id varchar(25) DEFAULT '0' NOT NULL,
    descricao_produto varchar(255) NULL,
    qtde_recebida float8 NULL,
    filial_id int4 NULL,
    custo_unitario numeric(12, 4) DEFAULT 0 NOT NULL,
    ordem_compra float8 DEFAULT 0 NOT NULL,
    CONSTRAINT entradas_mercadoria_pkey PRIMARY KEY (ordem_compra, item, produto_id, nro_nfe)
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_venda_data ON public.venda(data_emissao);
CREATE INDEX IF NOT EXISTS idx_pedido_data ON public.pedido_compra(data_pedido);
CREATE INDEX IF NOT EXISTS idx_entrada_data ON public.entradas_mercadoria(data_entrada);

# Catálogo de Dados

## Tabelas

### 1. Venda
Registro de todas as vendas realizadas no sistema.

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| venda_id | int8 | Identificador único da venda | 12345 |
| data_emissao | date | Data em que a venda foi realizada | 2025-02-15 |
| horariomov | varchar(8) | Horário da movimentação | 14:30:00 |
| produto_id | varchar(25) | Código identificador do produto | PROD001 |
| qtde_vendida | float8 | Quantidade vendida do produto | 5.0 |
| valor_unitario | numeric(12,4) | Valor unitário do produto | 29.9900 |
| filial_id | int8 | Identificador da filial | 1 |
| item | int4 | Número do item na venda | 1 |
| unidade_medida | varchar(3) | Unidade de medida do produto | UN |

**Chave Primária**: (filial_id, venda_id, data_emissao, produto_id, item, horariomov)

### 2. Pedido Compra
Controle dos pedidos de compra realizados.

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| pedido_id | float8 | Identificador único do pedido | 1001 |
| data_pedido | date | Data em que o pedido foi realizado | 2025-01-10 |
| item | float8 | Número do item no pedido | 1 |
| produto_id | varchar(25) | Código identificador do produto | PROD001 |
| descricao_produto | varchar(255) | Descrição detalhada do produto | Detergente Líquido 500ml |
| ordem_compra | float8 | Número da ordem de compra | 5001 |
| qtde_pedida | float8 | Quantidade solicitada | 100.0 |
| filial_id | int4 | Identificador da filial | 1 |
| data_entrega | date | Data prevista para entrega | 2025-01-15 |
| qtde_entregue | float8 | Quantidade já entregue | 80.0 |
| qtde_pendente | float8 | Quantidade pendente de entrega | 20.0 |
| preco_compra | float8 | Preço unitário de compra | 15.50 |
| fornecedor_id | int4 | Identificador do fornecedor | 123 |

**Chave Primária**: (pedido_id, produto_id, item)

### 3. Entradas Mercadoria
Registro das entradas de mercadorias no estoque.

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| data_entrada | date | Data do recebimento | 2025-01-12 |
| nro_nfe | varchar(255) | Número da nota fiscal | NFE123456 |
| item | float8 | Número do item na nota | 1 |
| produto_id | varchar(25) | Código identificador do produto | PROD001 |
| descricao_produto | varchar(255) | Descrição detalhada do produto | Detergente Líquido 500ml |
| qtde_recebida | float8 | Quantidade recebida | 80.0 |
| filial_id | int4 | Identificador da filial | 1 |
| custo_unitario | numeric(12,4) | Custo unitário do produto | 12.5000 |
| ordem_compra | float8 | Número da ordem de compra | 5001 |

**Chave Primária**: (ordem_compra, item, produto_id, nro_nfe)

## Relacionamentos

- A tabela `entradas_mercadoria` se relaciona com `pedido_compra` através do campo `ordem_compra`
- Todas as tabelas compartilham os campos `produto_id` e `filial_id` para rastreamento

## Índices
- idx_venda_data: Otimiza consultas por data em vendas
- idx_pedido_data: Melhora performance em consultas de pedidos por data
- idx_entrada_data: Acelera buscas de entradas por data
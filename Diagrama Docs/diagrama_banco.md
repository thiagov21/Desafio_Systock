# Diagrama do Banco de Dados

```mermaid
erDiagram
    VENDA {
        int8 venda_id PK
        date data_emissao PK
        varchar horariomov PK
        varchar produto_id PK
        float8 qtde_vendida
        numeric valor_unitario
        int8 filial_id PK
        int4 item PK
        varchar unidade_medida
    }

    PEDIDO_COMPRA {
        float8 pedido_id PK
        date data_pedido
        float8 item PK
        varchar produto_id PK
        varchar descricao_produto
        float8 ordem_compra FK
        float8 qtde_pedida
        int4 filial_id
        date data_entrega
        float8 qtde_entregue
        float8 qtde_pendente
        float8 preco_compra
        int4 fornecedor_id
    }

    ENTRADAS_MERCADORIA {
        date data_entrada
        varchar nro_nfe PK
        float8 item PK
        varchar produto_id PK
        varchar descricao_produto
        float8 qtde_recebida
        int4 filial_id
        numeric custo_unitario
        float8 ordem_compra PK,FK
    }

    PEDIDO_COMPRA ||--|{ ENTRADAS_MERCADORIA : "gera"
    PEDIDO_COMPRA ||--|{ VENDA : "abastece"
```

## Fluxos de Negócio

### 1. Fluxo de Compras
1. Criação do Pedido de Compra
   - Registro na tabela `PEDIDO_COMPRA`
   - Campos principais: pedido_id, produto_id, qtde_pedida
   - Status inicial: qtde_pendente = qtde_pedida

2. Recebimento de Mercadoria
   - Registro na tabela `ENTRADAS_MERCADORIA`
   - Vinculação através do campo ordem_compra
   - Atualização de qtde_entregue e qtde_pendente em PEDIDO_COMPRA

### 2. Fluxo de Vendas
1. Registro de Venda
   - Entrada na tabela `VENDA`
   - Controle por filial, produto e data/hora
   - Registro de quantidade e valor unitário

### 3. Fluxo de Análise (Consultas do Desafio)

#### Parte 1 - Análises Básicas
1. Consumo Mensal (Fevereiro/2025)
   - Fonte: Tabela `VENDA`
   - Agrupamento por produto
   - Totalização de qtde_vendida

2. Requisições Pendentes
   - Fonte: Tabela `PEDIDO_COMPRA`
   - Filtro: qtde_pendente > 0
   - Período: Jan-Mar/2025

3. Produtos Não Movimentados
   - Cruzamento das três tabelas
   - Identificação de produtos requisitados sem movimentação

#### Parte 2 - Transformações
- Foco em pedidos frequentes (>10 requisições)
- Formatação de dados para apresentação
- Período: Jan-Mar/2025

#### Parte 3 - Validação
1. Análise de Totais Diários
2. Tempo Médio de Entrega
3. Divergências Pedido vs Recebimento
4. Tendências de Consumo
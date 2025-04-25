# Documentação dos Scripts SQL

## Parte 1 - Consultas Básicas

### 1.1 Consumo Mensal
**Objetivo**: Análise de consumo por produto em fevereiro/2025
**Tabelas**: VENDA
**Lógica**:
- Filtro por período (01-28/02/2025)
- Agrupamento por produto
- Soma de quantidades vendidas

### 1.2 Pedidos Pendentes
**Objetivo**: Identificar produtos com entregas pendentes
**Tabelas**: PEDIDO_COMPRA
**Lógica**:
- Filtro por período (Jan-Mar/2025)
- Condição: qtde_pendente > 0
- Agrupamento por produto
- Totalização de quantidades

### 1.3 Produtos Não Movimentados
**Objetivo**: Identificar produtos sem movimentação
**Tabelas**: PEDIDO_COMPRA, VENDA, ENTRADAS_MERCADORIA
**Lógica**:
- Subquery para produtos requisitados
- Exclusão de produtos vendidos
- Exclusão de produtos recebidos
- Período: Fevereiro/2025

## Parte 2 - Transformações

### Transformações de Dados
**Objetivo**: Análise de produtos frequentemente requisitados
**Tabelas**: PEDIDO_COMPRA
**Lógica**:
1. CTE para produtos com mais de 10 pedidos
2. Concatenação de campos
3. Formatação de datas
4. Totalização de quantidades

## Parte 3 - Validação

### Consultas de Validação
**Objetivo**: Suporte à validação com cliente
**Tabelas**: Todas
**Consultas**:
1. **Totais Diários**
   - Agrupamento por data
   - Métricas: vendas, volume, valor

2. **Tempo de Entrega**
   - JOIN entre pedidos e entradas
   - Cálculo de média de dias

3. **Divergências**
   - Comparação pedido vs recebimento
   - Identificação de diferenças

4. **Tendências**
   - Agrupamento semanal
   - Análise de volumes
# Estratégia de Validação com o Cliente

## Principais Pontos de Validação

1. **Integridade dos Dados**
   - Verificar se todos os pedidos têm suas respectivas entradas
   - Confirmar se os valores de quantidade pendente estão corretos
   - Validar se não há duplicidade de registros

2. **Consistência das Informações**
   - Conferir se os valores unitários estão corretos
   - Verificar se as datas de entrega são posteriores às datas de pedido
   - Validar se os totais batem com os relatórios do cliente

3. **Regras de Negócio**
   - Confirmar o fluxo de pedido -> entrada -> venda
   - Verificar as políticas de estoque mínimo
   - Validar os prazos de entrega

## Consultas de Apoio para Validação

As consultas estão disponíveis em `queries/parte3/validacao_cliente.sql` e incluem:

1. Totais diários de vendas
2. Tempo médio entre pedido e entrega
3. Produtos com maior divergência entre pedido e recebimento
4. Análise de tendências de consumo

## Técnicas de Validação

1. **Amostragem Estratificada**
   - Selecionar casos representativos de cada tipo de operação
   - Validar manualmente com documentos físicos

2. **Reconciliação de Dados**
   - Comparar totais entre diferentes relatórios
   - Verificar saldos iniciais e finais

3. **Análise de Exceções**
   - Identificar outliers e casos atípicos
   - Investigar padrões irregulares
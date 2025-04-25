-- 1.3 Produtos requisitados mas não consumidos e não recebidos (Fevereiro 2025)

WITH produtos_requisitados AS (
    SELECT DISTINCT 
        pc.produto_id,
        pc.descricao_produto
    FROM 
        pedido_compra pc
    WHERE 
        pc.data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
),
produtos_consumidos AS (
    SELECT DISTINCT 
        produto_id
    FROM 
        venda
    WHERE 
        data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
),
produtos_recebidos AS (
    SELECT DISTINCT 
        produto_id
    FROM 
        entradas_mercadoria
    WHERE 
        data_entrada BETWEEN '2025-02-01' AND '2025-02-28'
)
SELECT 
    pr.produto_id,
    pr.descricao_produto
FROM 
    produtos_requisitados pr
WHERE 
    pr.produto_id NOT IN (SELECT produto_id FROM produtos_consumidos)
    AND pr.produto_id NOT IN (SELECT produto_id FROM produtos_recebidos);
-- produtos que não tiveram vendas nem entradas — podem ser problemas de cadastro --
SELECT 
    pc.produto_id,
    pc.descricao_produto,
    COALESCE(SUM(v.qtde_vendida), 0) AS total_vendido,
    COALESCE(SUM(em.qtde_recebida), 0) AS total_recebido
FROM 
    pedido_compra pc
LEFT JOIN 
    venda v ON pc.produto_id = v.produto_id 
            AND v.data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
LEFT JOIN 
    entradas_mercadoria em ON pc.produto_id = em.produto_id 
            AND em.data_entrada BETWEEN '2025-02-01' AND '2025-02-28'
WHERE 
    pc.data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    pc.produto_id, pc.descricao_produto
HAVING 
    COALESCE(SUM(v.qtde_vendida), 0) = 0
    AND COALESCE(SUM(em.qtde_recebida), 0) = 0
ORDER BY 
    pc.produto_id;

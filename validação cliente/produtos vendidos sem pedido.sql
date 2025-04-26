-- PoProdutos Vendidos Sem Pedido de Compra --
SELECT 
    v.produto_id,
    COUNT(*) AS total_vendas_sem_pedido
FROM 
    venda v
LEFT JOIN 
    pedido_compra pc ON v.produto_id = pc.produto_id
WHERE 
    pc.produto_id IS NULL
    AND v.data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    v.produto_id
ORDER BY 
    total_vendas_sem_pedido DESC;

-- 1.2 Produtos com requisição pendente

SELECT 
    pc.produto_id,
    pc.descricao_produto,
    SUM(pc.qtde_pedida) as total_pedido,
    SUM(pc.qtde_entregue) as total_entregue,
    SUM(pc.qtde_pendente) as total_pendente
FROM 
    pedido_compra pc
WHERE 
    pc.data_pedido BETWEEN '2025-01-01' AND '2025-03-31'
    AND pc.qtde_pendente > 0
GROUP BY 
    pc.produto_id, pc.descricao_produto
ORDER BY 
    total_pendente DESC;
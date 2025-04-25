SELECT 
    pc.produto_id,
    pc.descricao_produto,
    SUM(pc.qtde_pedida) AS total_pedido,
    SUM(em.qtde_recebida) AS total_recebido,
    SUM(pc.qtde_pedida - em.qtde_recebida) AS divergencia
FROM pedido_compra pc
LEFT JOIN entradas_mercadoria em ON pc.ordem_compra = em.ordem_compra
WHERE pc.data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY pc.produto_id, pc.descricao_produto
HAVING SUM(pc.qtde_pedida - em.qtde_recebida) <> 0
ORDER BY ABS(SUM(pc.qtde_pedida - em.qtde_recebida)) DESC;

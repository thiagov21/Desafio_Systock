SELECT 
    pc.produto_id,
    pc.descricao_produto,
    ROUND(AVG(em.data_entrada - pc.data_pedido)::numeric, 2) AS tempo_medio_dias
FROM pedido_compra pc
JOIN entradas_mercadoria em ON pc.ordem_compra = em.ordem_compra
WHERE pc.data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY pc.produto_id, pc.descricao_produto
ORDER BY tempo_medio_dias DESC;

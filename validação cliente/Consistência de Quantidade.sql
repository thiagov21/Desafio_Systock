-- Consistência de Quantidade Vendida vs Recebida --
SELECT 
    v.produto_id,
    SUM(v.qtde_vendida) AS total_vendido,
    SUM(em.qtde_recebida) AS total_recebido,
    (SUM(em.qtde_recebida) - SUM(v.qtde_vendida)) AS saldo
FROM 
    venda v
LEFT JOIN 
    entradas_mercadoria em ON v.produto_id = em.produto_id
WHERE 
    v.data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    v.produto_id
HAVING 
    (SUM(em.qtde_recebida) - SUM(v.qtde_vendida)) < 0
ORDER BY 
    saldo;

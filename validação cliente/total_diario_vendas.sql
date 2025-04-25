SELECT 
    data_emissao,
    COUNT(DISTINCT venda_id) AS total_vendas,
    ROUND(SUM(qtde_vendida)::numeric, 0) AS volume_total,
    ROUND(SUM(qtde_vendida * valor_unitario)::numeric, 2) AS valor_total
FROM venda
WHERE data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY data_emissao
ORDER BY data_emissao;

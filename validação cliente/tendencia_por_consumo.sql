SELECT 
    produto_id AS "Produto",
    TO_CHAR(DATE_TRUNC('week', data_emissao), 'YYYY-MM-DD') AS "Semana",
    ROUND(SUM(qtde_vendida)::numeric, 0) AS "Volume Semanal"
FROM venda
WHERE data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    produto_id, DATE_TRUNC('week', data_emissao)
ORDER BY 
    produto_id, "Semana";

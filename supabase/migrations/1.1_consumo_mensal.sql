-- 1.1 Consumo por produto e mês (Fevereiro 2025)

SELECT 
    v.produto_id,
    SUM(v.qtde_vendida) as total_consumo
FROM 
    venda v
WHERE 
    v.data_emissao >= '2025-02-01' 
    AND v.data_emissao <= '2025-02-28'
GROUP BY 
    v.produto_id
ORDER BY 
    total_consumo DESC;
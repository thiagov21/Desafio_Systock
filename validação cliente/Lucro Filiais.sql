-- ===============================
-- 📊 1. TOTAL DE VENDAS POR FILIAL
-- ===============================
SELECT 
    filial_id,
    SUM(qtde_vendida * valor_unitario) AS total_vendas
FROM 
    venda
WHERE 
    data_emissao BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY 
    filial_id
ORDER BY 
    total_vendas DESC;


-- ===============================
-- 💸 2. LUCRO OU PREJUÍZO POR FILIAL
-- ===============================
SELECT 
    v.filial_id,
    SUM(v.qtde_vendida * v.valor_unitario) AS total_vendas,
    SUM(COALESCE(em.qtde_recebida, 0) * COALESCE(em.custo_unitario, 0)) AS total_custo,
    (SUM(v.qtde_vendida * v.valor_unitario) - SUM(COALESCE(em.qtde_recebida, 0) * COALESCE(em.custo_unitario, 0))) AS lucro_bruto
FROM 
    venda v
LEFT JOIN 
    entradas_mercadoria em ON v.produto_id = em.produto_id AND v.filial_id = em.filial_id
WHERE 
    v.data_emissao BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY 
    v.filial_id
ORDER BY 
    lucro_bruto DESC;


-- ===============================
-- 🏆 3. RANKING DAS FILIAIS
-- ===============================
SELECT 
    filial_id,
    SUM(qtde_vendida * valor_unitario) AS total_vendas,
    RANK() OVER (ORDER BY SUM(qtde_vendida * valor_unitario) DESC) AS ranking
FROM 
    venda
WHERE 
    data_emissao BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY 
    filial_id;

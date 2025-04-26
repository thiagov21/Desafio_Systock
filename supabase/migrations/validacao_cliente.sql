-- Consultas para Validação com Cliente

-- 1. Totais diários de vendas (Fevereiro 2025)
SELECT 
    TO_CHAR(data_emissao, 'DD/MM/YYYY') as data_emissao,  -- Ajustado para formato DD/MM/YYYY
    COUNT(DISTINCT venda_id) as total_vendas,
    SUM(qtde_vendida) as volume_total,
    SUM(qtde_vendida * valor_unitario) as valor_total
FROM 
    venda
WHERE 
    data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    data_emissao
ORDER BY 
    data_emissao;

-- 2. Tempo médio entre pedido e entrega
SELECT 
    pc.produto_id,
    pc.descricao_produto,
    AVG(em.data_entrada - pc.data_pedido) as tempo_medio_entrega
FROM 
    pedido_compra pc
    JOIN entradas_mercadoria em ON pc.ordem_compra = pc.ordem_compra
WHERE 
    pc.data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    pc.produto_id, pc.descricao_produto
ORDER BY 
    tempo_medio_entrega DESC;

-- 3. Divergências entre pedido e recebimento
SELECT 
    pc.produto_id,
    pc.descricao_produto,
    SUM(pc.qtde_pedida) as total_pedido,
    SUM(em.qtde_recebida) as total_recebido,
    SUM(pc.qtde_pedida - em.qtde_recebida) as divergencia
FROM 
    pedido_compra pc
    LEFT JOIN entradas_mercadoria em ON pc.ordem_compra = pc.ordem_compra
WHERE 
    pc.data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    pc.produto_id, pc.descricao_produto
HAVING 
    SUM(pc.qtde_pedida - em.qtde_recebida) <> 0
ORDER BY 
    ABS(SUM(pc.qtde_pedida - em.qtde_recebida)) DESC;

-- 4. Análise de tendências de consumo
SELECT 
    v.produto_id,
    pc.descricao_produto,
    TO_CHAR(DATE_TRUNC('week', v.data_emissao::DATE), 'DD/MM/YYYY') as semana,
    SUM(v.qtde_vendida) as volume_semanal
FROM 
    venda v
JOIN 
    pedido_compra pc ON v.produto_id = pc.produto_id
WHERE 
    v.data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    v.produto_id, pc.descricao_produto, TO_CHAR(DATE_TRUNC('week', v.data_emissao::DATE), 'DD/MM/YYYY')
ORDER BY 
    v.produto_id, semana;

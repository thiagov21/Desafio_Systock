-- Consultas para Validação com Cliente

-- 1. Totais diários de vendas (Fevereiro 2025)
SELECT 
    data_emissao,
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
    JOIN entradas_mercadoria em ON pc.ordem_compra = em.ordem_compra
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
    LEFT JOIN entradas_mercadoria em ON pc.ordem_compra = em.ordem_compra
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
    produto_id,
    DATE_TRUNC('week', data_emissao) as semana,
    SUM(qtde_vendida) as volume_semanal
FROM 
    venda
WHERE 
    data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY 
    produto_id, DATE_TRUNC('week', data_emissao)
ORDER BY 
    produto_id, semana;
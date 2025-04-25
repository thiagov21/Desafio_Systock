SELECT 
    CONCAT(p.produto_id, ' - ', p.descricao_produto) AS Produto,
    p.qtde_pedida AS Qtde_Requisitada,
    TO_CHAR(p.data_pedido, 'DD/MM/YYYY') AS Data_Solicitacao
FROM 
    public.pedido_compra p
WHERE 
    p.qtde_pedida > 10
    AND p.data_pedido BETWEEN '2025-01-01' AND '2025-03-31';

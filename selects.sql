
-- Seleções de dados


-- 1)
SELECT
    p.*,
    pro.id,
    pro.tipo,
    ROUND(preco :: DECIMAL, 2) preco,
    pro.pts_de_lealdade
FROM
    produtos_pedidos pp
    JOIN pedidos p ON p.id = pp.pedido_id
    JOIN produtos pro ON pro.id = pp.produto_id;
-- 2)
SELECT
    p.id
FROM
    produtos_pedidos pp
    JOIN pedidos p ON pp.pedido_id = p.id
    JOIN produtos pro ON pp.produto_id = pro.id
WHERE
    pro.nome ILIKE 'Fritas';

-- 3)
SELECT
    c.nome gostam_de_fritas
FROM
    produtos_pedidos pp
    JOIN pedidos p ON pp.pedido_id = p.id
    JOIN produtos pro ON pp.produto_id = pro.id
    JOIN clientes c ON c.id = p.cliente_id
WHERE
    pro.nome ILIKE 'Fritas';

-- 4)
SELECT
    ROUND(SUM(pro.preco) :: NUMERIC, 2)
FROM
    produtos_pedidos pp
    JOIN pedidos p ON p.id = pp.pedido_id
    JOIN produtos pro ON pro.id = pp.produto_id
WHERE
    p.cliente_id = (
        SELECT
            id
        FROM
            clientes
        WHERE
            nome ILIKE 'Laura'
    );

-- 5)
SELECT
    pro.nome,
    COUNT(*)
FROM
    pedidos p
    JOIN produtos_pedidos pp ON p.id = pp.pedido_id
    JOIN produtos pro ON pro.id = pp.produto_id
GROUP BY
    pro.nome
ORDER BY
    pro.nome;
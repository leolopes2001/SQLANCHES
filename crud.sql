-- Simulações de um CRUD
-- Criação
-- 1)
INSERT INTO
    clientes(nome, lealdade)
VALUES
    ('Georgia', 0) RETURNING *;

-- 2)
INSERT INTO
	pedidos(status,cliente_id)
VALUES
	('Recebido',(SELECT id FROM clientes WHERE nome ILIKE 'Georgia'));
-- 3)

INSERT INTO
	produtos_pedidos(pedido_id,produto_id)
VALUES
	(7,(SELECT id FROM produtos WHERE nome = 'Big Serial')),
	(7,(SELECT id FROM produtos WHERE nome = 'Varchapa')),
	(7,(SELECT id FROM produtos WHERE nome = 'Fritas')),
	(7,(SELECT id FROM produtos WHERE nome = 'Coca-Cola')),
	(7,(SELECT id FROM produtos WHERE nome = 'Coca-Cola'));
-- Leitura
-- 1)
SELECT 
	c.*,
	pe.*,
	p.id,
	p.nome,
	p.tipo,
	ROUND((p.preco)::DECIMAL,2) preco,
	p.pts_de_lealdade
FROM 
	 clientes c
JOIN produtos_pedidos pp ON pp.pedido_id = c.id 
JOIN produtos p ON p.id = pp.produto_id
JOIN pedidos pe ON pp.pedido_id = pe.id
WHERE c.nome ILIKE 'Georgia';
-- Atualização
-- 1)
UPDATE 
	clientes
SET
	lealdade = (
		SELECT 
			SUM(pro.pts_de_lealdade)
		FROM 
			produtos_pedidos pp 
		INNER JOIN pedidos p ON pp.pedido_id = p.id 
		INNER JOIN produtos pro ON pp.produto_id = pro.id
		INNER JOIN clientes c ON c.id = p.cliente_id
		WHERE c.nome = 'Georgia'	
	)
WHERE nome ILIKE 'Georgia';

-- Deleção

DELETE FROM clientes WHERE nome = 'Marcelo';
-- 1)
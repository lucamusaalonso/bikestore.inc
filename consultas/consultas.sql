/*
1. Clientes que não realizaram uma compra
Utilizei o SELECT da tabela costumers com informações básicas, juntando com a tabela orders pelo customer_id e a condição final WHERE traz apenas os valores nulos, demonstrando os que não fizeram compras.
*/

SELECT c.custommer_id, c.first_name, c.last_name, c.city, c.state
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- -----------------------------------------------------------------------------------------------------------------------------------

/*
2. Produtos que não foram comprados
Lógica parecida com a primeira listagem, porém com mais JOINs para buscar nome, marca e preço dos produtos em diferntes tabelas
*/

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    b.brand_name,
    p.list_price
FROM
    products p
LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
LEFT JOIN
    categories c ON p.category_id = c.category_id
LEFT JOIN
    brands b ON p.brand_id = b.brand_id
WHERE
    oi.order_id IS NULL;

-- --------------------------------------------------------------------------------------------------------------------------------

/*
3. Listar produtos sem estoque
Lógica parecida com o item anterior, apenas acrescentando a quantidade em estoque da tabela 'stocks'
*/

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    b.brand_name,
    p.list_price
FROM
    products p
LEFT JOIN
    stocks s ON p.product_id = s.product_id
LEFT JOIN
    categories c ON p.category_id = c.category_id
LEFT JOIN
    brands b ON p.brand_id = b.brand_id
WHERE
    (s.quantity IN NULL OR s.quantity = 0);

-- ---------------------------------------------------------------------------------------------------------------------------------

/*
4. Agrupar a quantidade de vendas que uma determinada marca faz por loja.
Lógica parecida com as anteriores, porém agora é necessário o acréscimo do SUM para termos as vendas totais e GROUP BY para agrupar e o nome ou id da marca para detalhar.
*/

SELECT
    st.store_name,
    b.brand_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM
    order_items oi
JOIN
    orders o ON oi.order_id = o.order_id
JOIN
    products p ON oi.product_id = p.product_id
JOIN
    brands b ON p.brand_id = b.brand_id
JOIN
    stores st ON o.store_id = st.store_id
WHERE
    b.brand_name = 'Caloi' -- exemplo que utilizei | para não ter marca específica, basta retirar esta linha com o comando WHERE
GROUP BY
    st.store_name, b.brand_name
ORDER BY
    st.store_name, b.brand_name;

-- -----------------------------------------------------------------------------------------------------------------------------------

-- 5. Listar funcionários que não estejam relacionados a um pedido

SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    st.store_name
FROM
    staffs s
LEFT JOIN
    orders o ON s.staff_id = o.staff_id
LEFT JOIN
    stores st ON s.store_id = st.store_id
WHERE
    o.order_id IS NULL;

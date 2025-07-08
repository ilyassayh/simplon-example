
SELECT orders.order_id, customers.name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT customers.name
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;

SELECT customers.name, COUNT(orders.order_id) AS total_commandes
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.name;

SELECT SUM(total_amount) AS montant_total
FROM orders;

SELECT COUNT(*) AS nombre_clients
FROM customers;

SELECT AVG(total_amount) AS montant_moyen
FROM orders;

SELECT customer_id, SUM(total_amount) AS total_client
FROM orders
GROUP BY customer_id;

SELECT DATE_TRUNC('month', order_date) AS mois, COUNT(*) AS nombre_commandes
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

SELECT DATE_TRUNC('month', order_date) AS mois, AVG(total_amount) AS moyenne_mensuelle
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

SELECT customer_id, SUM(total_amount) AS total_client
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 1000;

SELECT DISTINCT customer_id
FROM orders
WHERE total_amount > 200;

SELECT customer_id, SUM(total_amount) AS total_client
FROM orders
GROUP BY customer_id
ORDER BY total_client DESC
LIMIT 1;

SELECT *
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);

CREATE VIEW customer_orders_view AS
SELECT customers.name, orders.order_id, orders.total_amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id;

SELECT name, SUM(total_amount) AS total
FROM customer_orders_view
GROUP BY name
HAVING SUM(total_amount) > 1000;

CREATE VIEW monthly_sales_view AS
SELECT DATE_TRUNC('month', order_date) AS mois, SUM(total_amount) AS ventes
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

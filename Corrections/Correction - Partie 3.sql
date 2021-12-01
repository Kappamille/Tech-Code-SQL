# Affichez les téléphones des clients dont la commande est en acheminement
SELECT phone, orders.status FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.status = 2;

# Combien de commandes sont dans chaque statut 
SELECT order_statuses.status, COUNT(orders.status) AS nb_orders  FROM orders
RIGHT JOIN order_statuses 
ON orders.status = order_statuses.order_status_id
GROUP BY order_statuses.order_status_id;

#3 - Affichez le nombre de commandes passés pour chaque utilisateur
SELECT customers.customer_id, COUNT(order_id) AS nb_orders FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
Group by customers.customer_id;


# Affichez le prix total pour chaque commande
SELECT orders.order_id, SUM(quantity*unit_price) as total FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by orders.order_id;

# Combien de recette avons nous fait depuis le lancement de notre magasin ?
SELECT SUM(subtotal.total) AS recette FROM (SELECT SUM(quantity*unit_price) as total FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by orders.order_id) AS subtotal;

# Affichez combien chaque client à dépensé dans notre magasin jusque la

SELECT subtotal.customer_id, SUM(subtotal.total) AS depenses_total_client
FROM (
SELECT customers.customer_id, orders.order_id, SUM(quantity*unit_price) as total FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id
group by orders.order_id) 
AS subtotal
GROUP BY subtotal.customer_id;

# Afficher pour chaque client le nombre total d'artciles acheté (toutes commandes confondues)
SELECT customer_id, order_items.product_id, SUM(quantity) AS total_quantity FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by customer_id, order_items.product_id
ORDER BY customer_id, total_quantity DESC;


# Affichez l’article préféré de  (le plus acheté) pour chaque client

SELECT sub.customer_id, sub.product_id, sub.total_quantity FROM (SELECT customer_id, order_items.product_id, products.name, SUM(quantity) AS total_quantity FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by customer_id, order_items.product_id) AS sub
INNER JOIN 
 (SELECT subtable.customer_id, MAX(subtable.total_quantity) AS total_quantity  FROM (
SELECT customer_id, order_items.product_id, products.name, SUM(quantity) AS total_quantity FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by customer_id, order_items.product_id) 
AS subtable
group by subtable.customer_id) AS s
ON sub.customer_id = s.customer_id AND sub.total_quantity = s.total_quantity;

# Quel est notre article le plus acheté ?
SELECT order_items.product_id, products.name, SUM(quantity) AS total_quantity FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by order_items.product_id 
ORDER BY total_quantity DESC
LIMIT 1;

#Affichez tous les clients ayant commandé au moins 2 articles différents
SELECT customer_id, COUNT(order_items.product_id) AS nb_diff_articles FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by customer_id
HAVING nb_diff_articles >2 ;

#Combien est ce que les clients depensent en moyenne sur notre store en moyenne
SELECT AVG(subtable.total) AS prix_commande_moyenne FROM (
SELECT orders.order_id, SUM(quantity*unit_price) as total FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
group by orders.order_id) AS subtable;

#Combien de commandes est ce que les clients font en moyenne sur notre magasin
SELECT AVG(subtable.nb_orders) AS avg_nb_orders FROM (
SELECT customers.customer_id, COUNT(order_id) AS nb_orders FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
Group by customers.customer_id) AS subtable;

#Affichez les adresses des clients qui ont dépensé + de 100€ sur notre store et dont la commande n’a pas encore été envoyée
SELECT first_name, last_name, address_number, address_name, postal_code, city FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
INNER JOIN customers ON customers.customer_id = orders.customer_id
WHERE orders.status = 1
group by orders.order_id Having SUM(quantity*unit_price) > 100.0;

#Affichez pour chaque produit son stock futur (on prend en compte toutes les commandes)
SELECT products.product_id, products.name, products.quantity_in_stock, IFNULL(SUM(quantity),0) AS total_quantity, products.quantity_in_stock - IFNULL(SUM(quantity),0) AS future_stock FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
RIGHT JOIN products ON order_items.product_id = products.product_id
group by products.product_id
ORDER BY product_id;

#Afficher les produits à restocker ugremment (stock futur <10)
SELECT products.product_id, products.name, products.quantity_in_stock, IFNULL(SUM(quantity),0) AS total_quantity, products.quantity_in_stock - IFNULL(SUM(quantity),0) AS future_stock FROM orders
LEFT JOIN order_items ON orders.order_id = order_items.order_id
RIGHT JOIN products ON order_items.product_id = products.product_id
group by products.product_id
Having future_stock < 10
ORDER BY future_stock;


 

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));




SELECT first_name, last_name, MAX(points) FROM customers;


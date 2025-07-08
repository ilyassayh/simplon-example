---
# 📘 Challenge 1 : Création de la base de données

Crée une base de données appelée `store_db` et sélectionne-la pour la suite.

```sql
CREATE DATABASE store_db;
\c store_db;
```

---
# 📘 Challenge 2 : Création des tables

## Table `customers`

```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);
```

## Table `products`

```sql
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);
```

## Table `orders`

```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
```

## Table `order_items`

```sql
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

---
# 📘 Challenge 3 : Insertion de données

## Clients

```sql
INSERT INTO customers (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'john.doe@gmail.com', '0612345678'),
('Alice', 'Smith', 'alice.smith@yahoo.com', '0623456789'),
('David', 'Dubois', 'david.dubois@live.com', '0634567890'),
('Maria', 'Gonzalez', 'maria.gon@gmail.com', '0645678901'),
('Karim', 'Dali', 'karim.dali@outlook.com', '0656789012');
```

## Produits

```sql
INSERT INTO products (name, price, category) VALUES
('Laptop', 899.99, 'Electronics'),
('Smartphone', 599.50, 'Electronics'),
('Office Chair', 149.90, 'Furniture'),
('Coffee Maker', 79.99, 'Appliances'),
('USB-C Cable', 15.00, 'Accessories');
```

## Commandes

```sql
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-15', 914.99),
(3, '2024-03-02', 78.99),
(2, '2023-12-30', 149.90),
(1, '2024-04-18', 614.50),
(5, '2022-11-01', 79.99);
```

## Articles des commandes

```sql
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 5, 1),
(2, 4, 1),
(3, 3, 1),
(4, 2, 1),
(5, 4, 1);
```

---
# 📘 Challenge 4 : Requêtes de sélection simples

## Tous les clients

```sql
SELECT * FROM customers;
```

## Commandes après le 1er janvier 2024

```sql
SELECT * FROM orders
WHERE order_date > '2024-01-01';
```

## Nom et e-mail des clients ayant passé une commande

```sql
SELECT DISTINCT c.first_name, c.last_name, c.email
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
```

---
# 📘 Challenge 5 : Clauses WHERE

## Clients dont le prénom est "John"

```sql
SELECT * FROM customers
WHERE first_name = 'John';
```

## Commandes dont le montant est supérieur à 100 €

```sql
SELECT * FROM orders
WHERE total_amount > 100;
```

## Clients dont le nom commence par "D"

```sql
SELECT * FROM customers
WHERE last_name LIKE 'D%';
```

---
# 📘 Challenge 6 : Mise à jour de données

## Mise à jour du numéro de téléphone du client avec ID 1

```sql
UPDATE customers
SET phone_number = '0600000000'
WHERE customer_id = 1;
```

## Augmenter `total_amount` de 10%

```sql
UPDATE orders
SET total_amount = total_amount * 1.10;
```

## Correction d'une adresse e-mail

```sql
UPDATE customers
SET email = 'john.doe@correct.com'
WHERE email = 'john.doe@gmail.com';
```

---
# 📘 Challenge 7 : Suppression de données

## Supprimer les commandes avant 2023

```sql
DELETE FROM orders
WHERE order_date < '2023-01-01';
```

## Supprimer un client (et ses commandes grâce à ON DELETE CASCADE)

```sql
DELETE FROM customers
WHERE customer_id = 5;
```

## Supprimer toutes les commandes d’un client spécifique (ID 1)

```sql
DELETE FROM orders
WHERE customer_id = 1;
```

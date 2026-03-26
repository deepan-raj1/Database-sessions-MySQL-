-- MySQL Module 8 – Subqueries & Advanced Queries Lab

-- Part 1 – Setup Database
CREATE DATABASE IF NOT EXISTS subquery_lab;
USE subquery_lab;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price INT
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    amount INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Indexes (Performance)
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_product_id ON orders(product_id);

-- Part 2 – Insert Sample Data
INSERT INTO users (name, city) VALUES
('Arun', 'Chennai'),
('Bala', 'Bangalore'),
('Charan', 'Chennai'),
('Divya', 'Hyderabad'),
('Esha', 'Mumbai');

INSERT INTO products (name, price) VALUES
('Laptop', 60000),
('Mobile', 20000),
('Tablet', 15000),
('Headphones', 2000),
('Monitor', 12000);

INSERT INTO orders (user_id, product_id, amount) VALUES
(1, 1, 60000),
(1, 4, 2000),
(2, 2, 20000),
(3, 3, 15000),
(3, 1, 60000),
(4, 5, 12000);

-- Part 3 – Guided Exercises
SELECT name
FROM users
WHERE id IN (SELECT user_id FROM orders);

SELECT name
FROM users u
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.user_id = u.id
);

SELECT name
FROM users u
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.user_id = u.id
);

SELECT name
FROM users u
WHERE (
    SELECT SUM(amount) FROM orders o WHERE o.user_id = u.id
) > (SELECT AVG(amount) FROM orders);

SELECT name
FROM users
WHERE id IN (
    SELECT user_id
    FROM orders
    WHERE product_id IN (
        SELECT id FROM products WHERE price > 15000
    )
);

-- Part 4 – Practice
SELECT name FROM products
WHERE id IN (SELECT product_id FROM orders);

SELECT name FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.product_id = p.id
);

SELECT name FROM users
WHERE city = 'Chennai'
AND id IN (SELECT user_id FROM orders);

SELECT name FROM users u
WHERE (
    SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id
) > 1;

SELECT name FROM products
WHERE id IN (
    SELECT product_id FROM orders
    WHERE amount = (SELECT MAX(amount) FROM orders)
);

-- Part 5 – Challenge
SELECT name
FROM users u
WHERE NOT EXISTS (
    SELECT id FROM products p
    WHERE NOT EXISTS (
        SELECT 1 FROM orders o
        WHERE o.user_id = u.id AND o.product_id = p.id
    )
);

SELECT name
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN products p ON o.product_id = p.id
    WHERE o.user_id = u.id AND p.price > 20000
);

SELECT name
FROM users
WHERE id IN (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    HAVING SUM(amount) = (
        SELECT MAX(total_spent)
        FROM (
            SELECT SUM(amount) AS total_spent
            FROM orders
            GROUP BY user_id
        ) AS temp
    )
);

SELECT name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Bonus
SELECT DISTINCT u.name
FROM users u
JOIN orders o ON u.id = o.user_id;

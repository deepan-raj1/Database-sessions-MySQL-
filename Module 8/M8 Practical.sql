-- Part 1 – Setup Database
-- STEP 1: Create Database
CREATE DATABASE IF NOT EXISTS subquery_lab;
USE subquery_lab;

-- STEP 2: Drop Tables (Reset)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
SET FOREIGN_KEY_CHECKS = 1;

-- STEP 3: Create Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- STEP 4: Create Products Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price INT
);

-- STEP 5: Create Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    amount INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);


-- Part 2 – Insert Sample Data
-- Users
INSERT INTO users (name, city) VALUES
('Arun', 'Chennai'),
('Bala', 'Bangalore'),
('Charan', 'Chennai'),
('Divya', 'Hyderabad'),
('Esha', 'Mumbai');

-- Products
INSERT INTO products (name, price) VALUES
('Laptop', 60000),
('Mobile', 20000),
('Tablet', 15000),
('Headphones', 2000),
('Monitor', 12000);

-- Orders
INSERT INTO orders (user_id, product_id, amount) VALUES
(1, 1, 60000),
(1, 4, 2000),
(2, 2, 20000),
(3, 3, 15000),
(3, 1, 60000),
(4, 5, 12000);



-- Part 3 – Guided Exercises (Trainer + Students)
-- Exercise 1 – Subquery with IN
-- 👉 Find users who placed at least one order

SELECT name
FROM users
WHERE id IN (
    SELECT user_id FROM orders
);

-- Exercise 2 – Subquery with NOT IN
-- 👉 Find users who did NOT place any orders

SELECT name
FROM users
WHERE id NOT IN (
    SELECT user_id FROM orders
);


-- Exercise 3 – EXISTS
-- 👉 Find users who have orders using EXISTS

SELECT name
FROM users u
WHERE EXISTS (
    SELECT 1 
    FROM orders o
    WHERE o.user_id = u.id
);


-- Exercise 4 – Correlated Subquery
-- 👉 Find users who spent more than average order amount

SELECT name
FROM users u
WHERE (
    SELECT SUM(amount)
    FROM orders o
    WHERE o.user_id = u.id
) > (
    SELECT AVG(amount) FROM orders
);


-- Exercise 5 – Nested Subquery
-- 👉 Find users who ordered products costing more than 15000

SELECT name
FROM users
WHERE id IN (
    SELECT user_id
    FROM orders
    WHERE product_id IN (
        SELECT id FROM products WHERE price > 15000
    )
);


-- Part 4 – Student Practice (Important)
-- Task 1 - Find products that have been ordered
-- Using Subquery (IN)
SELECT name
FROM products
WHERE id IN (
    SELECT product_id FROM orders
);

-- Task 2 Find products that have NOT been ordered
-- Using Subquery (NOT IN)
SELECT name
FROM products
WHERE id NOT IN (
    SELECT product_id FROM orders
);

-- Advanced fix:
SELECT name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o
    WHERE o.product_id = p.id
);

-- Task 3 Find users from Chennai who placed orders
-- Using Subquery
SELECT name
FROM users
WHERE city = 'Chennai'
AND id IN (
    SELECT user_id FROM orders
);

-- Task 4 Find users who placed more than 1 order
-- Using Correlated Subquery
SELECT name
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM orders o
    WHERE o.user_id = u.id
) > 1;

-- Task 5 Find the most expensive product ordered
-- Using Nested Subquery
SELECT name
FROM products
WHERE id = (
    SELECT product_id
    FROM orders
    ORDER BY amount DESC
    LIMIT 1
);

-- Alternative (Conceptually Stronger)
SELECT name
FROM products
WHERE id IN (
    SELECT product_id
    FROM orders
    WHERE amount = (
        SELECT MAX(amount) FROM orders
    )
);

-- Part 5 – Challenge Level 🔥
-- Challenge 1 - Find users who ordered all products
--👉 Concept: NOT EXISTS + double subquery (advanced logic)
SELECT name
FROM users u
WHERE NOT EXISTS (
    SELECT id
    FROM products p
    WHERE NOT EXISTS (
        SELECT 1
        FROM orders o
        WHERE o.user_id = u.id
        AND o.product_id = p.id
    )
);

-- Challenge 2 - Find users who never ordered expensive products (> 20000)
-- 👉 Concept: NOT IN / NOT EXISTS
SELECT name
FROM users
WHERE id NOT IN (
    SELECT user_id
    FROM orders
    WHERE product_id IN (
        SELECT id FROM products WHERE price > 20000
    )
);

-- Better Approach (EXISTS)
SELECT name
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN products p ON o.product_id = p.id
    WHERE o.user_id = u.id
    AND p.price > 20000
);

-- Challenge 3 - Find users whose total spending is highest
-- 👉 Concept: Aggregation + Subquery
-- Inner query → calculates spending per user
-- Outer query → picks maximum spender
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

-- Challenge 4 - Find products with price greater than average price
-- 👉 Concept: Simple Subquery
SELECT name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- Part 6 – Bonus (JOIN vs Subquery)
-- 👉 Ask students to rewrite:

SELECT name
FROM users
WHERE id IN (
    SELECT user_id FROM orders
);

-- 👉 Using JOIN
SELECT DISTINCT u.name
FROM users u
JOIN orders o ON u.id = o.user_id;

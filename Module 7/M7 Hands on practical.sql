-- STEP 1 – Setup Database (Students type with you)
CREATE DATABASE IF NOT EXISTS join_lab;
USE join_lab;


-- STEP 2 – Create Tables
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS products;


-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- Orders Table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10,2)
);

-- Categories Table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- Products Table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    category_id INT
);


-- STEP 3 – Insert Sample Data
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David');

INSERT INTO orders (user_id, amount) VALUES
(1, 500), (1, 300), (2, 200);

INSERT INTO categories (name) VALUES
('Electronics'), ('Clothing');

INSERT INTO products (name, category_id) VALUES
('Laptop', 1),
('Mobile', 1),
('Shirt', 2);

-- STEP 4 – Understand the Problem


-- STEP 5 – INNER JOIN (Core Concept)
SELECT users.name, orders.amount
FROM users
INNER JOIN orders
ON users.id = orders.user_id;


-- STEP 6 – LEFT JOIN (Very Important)
SELECT users.name, orders.amount
FROM users
LEFT JOIN orders
ON users.id = orders.user_id;

-- STEP 7 – RIGHT JOIN
SELECT users.name, orders.amount
FROM users
RIGHT JOIN orders
ON users.id = orders.user_id;


-- STEP 8 – SELF JOIN (Important Interview Topic)

-- Modify table:
ALTER TABLE users ADD manager_id INT;

-- Update table
UPDATE users SET manager_id = NULL WHERE id = 1;
UPDATE users SET manager_id = 1 WHERE id IN (2,3);
UPDATE users SET manager_id = 2 WHERE id = 4;

-- Query:
SELECT e.name AS employee, m.name AS manager
FROM users e
JOIN users m
ON e.manager_id = m.id;


-- STEP 9 – Table Aliases (Make it Clean)
SELECT u.name, o.amount
FROM users u
JOIN orders o
ON u.id = o.user_id;

-- STEP 10 – Column Aliases
SELECT u.name AS user_name, o.amount AS order_amount
FROM users u
JOIN orders o
ON u.id = o.user_id;

-- STEP 11 – REAL USE CASE 1: User Order History
SELECT u.name, o.id AS order_id, o.amount
FROM users u
LEFT JOIN orders o
ON u.id = o.user_id;

-- STEP 12 – REAL USE CASE 2: Product-Category Mapping
SELECT p.name AS product, c.name AS category
FROM products p
JOIN categories c
ON p.category_id = c.id;

-- STEP 13 – Common Mistake Demo (IMPORTANT)
SELECT users.name, orders.amount
FROM users, orders;

-------------------------------
-- STEP 14 – Challenge Questions (Give Students)

-- Task 1 - Show all users with total order amount
SELECT u.name, SUM(o.amount)
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.name;

-- Task 2 - Find users who never placed orders
SELECT u.name
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;

-- Task 3 - Count number of orders per user
SELECT u.name, COUNT(o.id)
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.name;


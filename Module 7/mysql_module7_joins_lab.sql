-- ============================================
-- MySQL Module 7 Lab: JOINS & Aliases
-- ============================================

-- STEP 1 – Setup Database
CREATE DATABASE IF NOT EXISTS join_lab;
USE join_lab;

-- STEP 2 – Drop Tables (Safe Reset)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;
SET FOREIGN_KEY_CHECKS = 1;

-- STEP 3 – Create Tables

-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES users(id)
);

-- Orders Table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
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
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- STEP 4 – Insert Sample Data

INSERT INTO users (name, manager_id) VALUES
('Alice', NULL),
('Bob', 1),
('Charlie', 1),
('David', 2);

INSERT INTO orders (user_id, amount) VALUES
(1, 500), (1, 300), (2, 200);

INSERT INTO categories (name) VALUES
('Electronics'), ('Clothing');

INSERT INTO products (name, category_id) VALUES
('Laptop', 1),
('Mobile', 1),
('Shirt', 2);

-- ============================================
-- STEP 5 – INNER JOIN
-- Shows only matching records
SELECT u.name, o.id AS order_id, o.amount
FROM users u
INNER JOIN orders o ON u.id = o.user_id;

-- STEP 6 – LEFT JOIN
-- Shows all users, NULL if no orders
SELECT u.name, o.amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
ORDER BY u.name;

-- STEP 7 – RIGHT JOIN
-- Shows all orders
SELECT u.name, o.amount
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id;

-- Equivalent LEFT JOIN (better practice)
SELECT u.name, o.amount
FROM orders o
LEFT JOIN users u ON u.id = o.user_id;

-- STEP 8 – SELF JOIN
-- Employee → Manager mapping
SELECT e.name AS employee, m.name AS manager
FROM users e
JOIN users m ON e.manager_id = m.id;

-- STEP 9 – Table Aliases
SELECT u.name, o.amount
FROM users u
JOIN orders o ON u.id = o.user_id;

-- STEP 10 – Column Aliases
SELECT u.name AS user_name, o.amount AS order_amount
FROM users u
JOIN orders o ON u.id = o.user_id;

-- STEP 11 – Use Case: User Order History
SELECT u.name, o.id AS order_id, o.amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id;

-- STEP 12 – Use Case: Product-Category Mapping
SELECT p.name AS product, c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.id;

-- STEP 13 – Common Mistake (Cartesian Product)
SELECT u.name, o.amount
FROM users u, orders o;

-- ============================================
-- STEP 14 – Practice Tasks

-- Task 1: Total order amount per user
SELECT u.id, u.name, SUM(o.amount) AS total_amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- Task 2: Users without orders
SELECT u.name
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;

-- Task 3: Count orders per user
SELECT u.name, COUNT(o.id) AS order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- Task 4: Top customer
SELECT u.name, SUM(o.amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name
ORDER BY total_spent DESC;

-- ============================================
-- END OF LAB

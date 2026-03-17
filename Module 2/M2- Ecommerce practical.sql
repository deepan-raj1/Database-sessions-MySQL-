--Step 1 - Create database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;


--Step 2 - Create tables
-- 1. customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL
);

-- 2. products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- 3. orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. order items table
CREATE TABLE order_items (
    order_id INT, 
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)   
);


-- Step 3 -- Insert sample data

-- 1. Insert into customers table
INSERT INTO customers (name, phone)
VALUES
('Arjun', '999999999'),
('Vikram', '8888888888'),
('Ravi', '7777777777'),
('Pooja', '6666666666'),
('Arora', '5555555555');

-- 2. Insert into products table
INSERT INTO products(name, price)
VALUES
('Laptop', 50000),
('Keyboard', 1000),
('Mouse', 500);

-- 3. Insert into orders table
INSERT INTO orders(customer_id)
VALUES
(1),(2),(3),(4),(5);

-- 4. Insert into order_items table
INSERT INTO order_items(order_id, product_id, quantity)
VALUES
(1, 1, 2),  -- Laptop
(1, 2, 5),	-- keyboard
(2, 3, 7);	-- mouse




-- Step 4
-- Join 4 tables - to see full order details
-- we want orderid, customer name, product name, price, quantity, total price

SELECT 
	o.order_id,
    c.name AS customer_name,
    p.name AS product_name,
    p.price,
    oi.quantity,
    (p.price * oi.quantity) AS total_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id;


    

-- Step 5
-- Filter Orders for Specific Customer
SELECT 
    o.order_id,
    c.name AS customer_name,
    p.name AS product_name,
    p.price,
    oi.quantity,
    (p.price * oi.quantity) AS total_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.name = 'Vikram';



-- Step 6
-- Update Example (Update arjun phone no.)
UPDATE customers
SET phone = '1234567890'
WHERE customer_id = 1;


-- Step 7
-- Delete Test (Check Foreign Key) (Should fail because orders exist.)
DELETE FROM customers WHERE customer_id = 1;


-- Step 8
-- Add New Column (Schema Change)
ALTER TABLE orders
ADD order_status VARCHAR(50) DEFAULT 'Pending';

 
-- Step 9    
-- Add Price Snapshot (Advanced Practice)
ALTER TABLE order_items
ADD order_price DECIMAL(10,2);

UPDATE order_items oi
JOIN products p ON oi.product_id = p.product_id
SET oi.order_price = p.price;

-- Step 10
-- Drop Tables (Reset Practice)
DROP TABLE order_items;
DROP TABLE orders;
DROP TABLE products;
DROP TABLE customers;

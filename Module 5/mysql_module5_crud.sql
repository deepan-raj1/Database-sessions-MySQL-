-- =========================================
-- MySQL Module 5 – CRUD Operations (CORE)
-- Trainer: Live Coding Script
-- =========================================

-- Step 1 – Setup Practice Database
CREATE DATABASE company_db;
USE company_db;

-- Step 2 – Create Practice Table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    joining_date DATE
);

-- Step 3 – INSERT (Create Data)
INSERT INTO employees (name, department, salary, city, joining_date)
VALUES
('Anita', 'HR', 40000, 'Bangalore', '2023-03-15'),
('Karthik', 'IT', 60000, 'Chennai', '2022-11-20'),
('Meena', 'Finance', 55000, 'Hyderabad', '2023-01-12'),
('Suresh', 'IT', 45000, 'Chennai', '2023-07-01'),
('Divya', 'HR', 42000, 'Mumbai', '2023-02-25');

-- View inserted data
SELECT * FROM employees;

-- ==============================
-- Step 4 – SELECT (Read Data)
-- ==============================

-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT name, salary FROM employees;

-- For Practice:
-- Display Only name and department
-- Display Only salary column

-- ==============================
-- Step 5 – WHERE (Filtering)
-- ==============================

SELECT * FROM employees
WHERE department = 'IT';

SELECT * FROM employees
WHERE salary > 50000;

-- For Practice
-- Find Employees from Chennai
-- Find Employees with salary > 45000


-- ==============================
-- Step 6 – AND / OR
-- ==============================

SELECT * FROM employees
WHERE department = 'IT' AND city = 'Chennai';

SELECT * FROM employees
WHERE department = 'IT' OR department = 'HR';

-- For Practice
-- Find employees From HR AND salary > 40000
-- Find employees From Chennai OR Bangalore

-- ==============================
-- Step 7 – LIKE (Pattern Search)
-- ==============================

-- Find names starting with "A"
SELECT * FROM employees
WHERE name LIKE 'A%';

-- Ending with 'a'
SELECT * FROM employees
WHERE name LIKE '%a';

-- Contains "ar"
SELECT * FROM employees
WHERE name LIKE '%ar%';

-- ==============================
-- Step 8 – IN
-- ==============================

-- Instead of
SELECT * FROM employees
WHERE city='Chennai' OR city='Mumbai';

-- Use
SELECT * FROM employees
WHERE city IN ('Chennai','Mumbai');

-- For Practice
-- Find employees from Chennai, Hyderabad, Bangalore

-- ==============================
-- Step 9 – BETWEEN
-- ==============================

-- Includes both 40000 and 55000
SELECT * FROM employees
WHERE salary BETWEEN 40000 AND 55000;

SELECT * FROM employees
WHERE joining_date BETWEEN '2023-01-01' AND '2023-12-31';

-- ==============================
-- Step 10 – ORDER BY (Sorting)
-- ==============================

-- Ascending (default)
SELECT * FROM employees
ORDER BY salary;

-- Descending
SELECT * FROM employees
ORDER BY salary DESC;

-- Sort by multiple columns
SELECT * FROM employees
ORDER BY department, salary DESC;

-- ==============================
-- Step 11 – LIMIT / OFFSET
-- ==============================

-- Used for pagination (limit number of rows)

-- Get first 3 rows
SELECT * FROM employees
LIMIT 3;

-- Skip 2 rows then show 3
SELECT * FROM employees
LIMIT 3 OFFSET 2;

-- Useful for web pages

-- ==============================
-- Step 12 – UPDATE
-- ==============================

-- Syntax
UPDATE table_name
SET column = value
WHERE condition;

-- Example
UPDATE employees
SET salary = 52000
WHERE emp_id = 1;

-- Update multiple columns
UPDATE employees
SET salary = 60000, city = 'Pune'
WHERE name = 'Anita';

-- ==============================
-- Step 13 – DELETE
-- ==============================

-- Removes records from a table

DELETE FROM employees
WHERE emp_id = 3;

DELETE FROM employees
WHERE department = 'HR';

-- ⚠ WARNING: Always use WHERE in DELETE
-- Deletes ALL rows
DELETE FROM employees;




--------------------------------------------
-- Practical Mini Exercise Tasks
Task 1 Insert 3 employees.
Task 2 Display employees from IT department
Task 3 Find employees with salary between 40000 and 60000
Task 4 Sort employees by salary descending
Task 5 Update salary of employee emp_id = 2
Task 6 Delete employees from Mumbai
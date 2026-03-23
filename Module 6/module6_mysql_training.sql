-- Module 6: Functions, Grouping & Filtering (Final Script)

-- STEP 1: Setup Database (Students type with you)
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- STEP 2: Create Table
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    phone VARCHAR(15),
    joining_date DATE
);

-- STEP 3: Insert Data
INSERT INTO employees (name, department, salary, phone, joining_date) VALUES
('Arun', 'HR', 30000, '9876543210', '2022-01-10'),
('Divya', 'IT', 50000, NULL, '2021-03-15'),
('Kiran', 'IT', 60000, '9123456780', '2020-07-20'),
('Meena', 'HR', 35000, NULL, '2023-02-01'),
('Ravi', 'Sales', 40000, '9988776655', '2022-05-25'),
('Suresh', 'Sales', 45000, NULL, '2021-11-11');

-- STEP 4: Basic SELECT (Warm-up)
SELECT * FROM employees;

-- STEP 5: Aggregate Functions
SELECT COUNT(*) AS total_employees FROM employees;
SELECT COUNT(phone) AS phone_count FROM employees;

SELECT SUM(salary) AS total_salary FROM employees;
SELECT AVG(salary) AS avg_salary FROM employees;
SELECT MIN(salary) AS min_salary FROM employees;
SELECT MAX(salary) AS max_salary FROM employees;

-- STEP 6: Date Functions
SELECT NOW();
SELECT CURDATE();

-- STEP 7: String Functions
SELECT CONCAT(name, ' works in ', department) AS emp_info FROM employees;
SELECT name, IFNULL(phone, 'No Phone') AS phone_status FROM employees;

-- STEP 8: GROUP BY (Importat Section)
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- STEP 9: HAVING
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- STEP 10: WHERE vs HAVING (Important Concept)
SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 30000
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- STEP 11: Final Combined Query
SELECT department, 
       COUNT(*) AS total_emp, 
       AVG(salary) AS avg_salary
FROM employees
WHERE salary > 30000
GROUP BY department
HAVING AVG(salary) > 40000;

-- STEP 12 NULL Count Example
SELECT COUNT(*) - COUNT(phone) AS null_phone_count FROM employees;

-- STEP 13 Trick Question
-- 🧪 Tasks: 
-- Count employees in each department 
-- Show highest salary per department 
-- Replace NULL phone values 
-- Show departments with avg salary > 45000

-- STEP 15 - This may give unpredictable results
SELECT department, salary 
FROM employees 
GROUP BY department;

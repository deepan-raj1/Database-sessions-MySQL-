-- STEP 1: Setup Database (Students type with you)
CREATE DATABASE company_db;
USE company_db;


-- STEP 2: Create Table
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


-- STEP 5: COUNT() (Introduce Aggregate)
SELECT COUNT(*) FROM employees;
SELECT COUNT(phone) FROM employees;

-- STEP 6: SUM() and AVG()
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;

-- STEP 7: MIN() and MAX()
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;

-- STEP 8: Date Functions
SELECT NOW();
SELECT CURDATE();

-- STEP 9: String Functions
-- CONCAT
SELECT CONCAT(name, ' works in ', department) FROM employees;

-- IFNULL
SELECT name, IFNULL(phone, 'No Phone') FROM employees;

-- STEP 10: GROUP BY (Important Section ⚠️)
-- First Demo
SELECT department, COUNT(*) 
FROM employees
GROUP BY department;

-- Average per department
SELECT department, AVG(salary)
FROM employees
GROUP BY department;

-- STEP 11: HAVING (Filtering Groups)
SELECT department, COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- STEP 12: WHERE vs HAVING (Important Concept)
-- Example 1
SELECT department, AVG(salary)
FROM employees
WHERE salary > 30000
GROUP BY department;

-- Example 2
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;



-- STEP 13: Final Combined Query (Real-world)
SELECT department, COUNT(*) AS total_emp, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 30000
GROUP BY department
HAVING avg_salary > 40000;

-- STEP 14: Live Challenge (Students Do)
-- 🧪 Tasks:
-- Count employees in each department
-- Show highest salary per department
-- Replace NULL phone values
-- Show departments with avg salary > 45000

-- STEP 15: Bonus Trick Question (Very Important)
SELECT department, salary 
FROM employees 
GROUP BY department;

-- STEP 16: Wrap-Up Questions
-- Difference between WHERE & HAVING
-- COUNT(*) vs COUNT(column)
-- Why GROUP BY is used

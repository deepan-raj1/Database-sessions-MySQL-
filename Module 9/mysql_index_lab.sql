-- ============================================
-- MySQL Module 9: Indexes & Performance Lab
-- Industry-Level Trainer Reference
-- ============================================

-- 🟦 Part 1 – Setup Database
CREATE DATABASE IF NOT EXISTS index_lab;
USE index_lab;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    join_date DATE
);

-- 🟦 Part 2 – Insert Bulk Data (IMPORTANT)
INSERT INTO employees (name, department, salary, city, join_date)
SELECT 
    CONCAT('Emp', FLOOR(RAND()*10000)),
    ELT(FLOOR(1 + RAND()*3), 'IT', 'HR', 'Finance'),
    FLOOR(30000 + RAND()*70000),
    ELT(FLOOR(1 + RAND()*4), 'Chennai', 'Mumbai', 'Delhi', 'Bangalore'),
    DATE_ADD('2018-01-01', INTERVAL FLOOR(RAND()*2000) DAY)
FROM information_schema.tables t1
LIMIT 5000;

-- 🟦 Part 3 – Without Index
EXPLAIN SELECT * FROM employees WHERE name = 'Emp100';

-- 🟦 Part 4 – Single Column Index
CREATE INDEX idx_name ON employees(name);

EXPLAIN SELECT * FROM employees WHERE name = 'Emp100';

-- 🟦 Part 5 – Composite Index
CREATE INDEX idx_dept_salary ON employees(department, salary);

EXPLAIN 
SELECT * FROM employees 
WHERE department = 'IT' AND salary > 60000;

-- 🟦 Part 6 – Leftmost Prefix Rule
EXPLAIN SELECT * FROM employees WHERE department = 'IT';
EXPLAIN SELECT * FROM employees WHERE salary > 60000;

-- 🟦 Part 7 – Function Issue
EXPLAIN 
SELECT * FROM employees 
WHERE YEAR(join_date) = 2022;

EXPLAIN 
SELECT * FROM employees 
WHERE join_date BETWEEN '2022-01-01' AND '2022-12-31';

-- 🟦 Part 8 – Covering Index
CREATE INDEX idx_cover ON employees(name, salary);

EXPLAIN 
SELECT name, salary 
FROM employees 
WHERE name = 'Emp100';

-- 🟦 Part 9 – LIKE Optimization
EXPLAIN SELECT * FROM employees WHERE name LIKE '%100';
EXPLAIN SELECT * FROM employees WHERE name LIKE 'Emp1%';

-- 🟦 Part 10 – Expression Issue
EXPLAIN SELECT * FROM employees WHERE salary + 1000 > 60000;
EXPLAIN SELECT * FROM employees WHERE salary > 59000;

-- 🟦 Part 11 – Index Impact on ORDER BY
EXPLAIN 
SELECT * FROM employees 
WHERE department = 'IT'
ORDER BY salary;

-- 🟦 Part 12 – Show Indexes
SHOW INDEX FROM employees;

-- 🟦 Part 13 – Modern Performance Analysis
EXPLAIN ANALYZE SELECT * FROM employees WHERE department = 'IT';

-- 🟦 Part 14 – Drop Index
DROP INDEX idx_name ON employees;

EXPLAIN SELECT * FROM employees WHERE name = 'Emp100';

-- ============================================
-- End of Lab
-- ============================================








-- 🟦 Part 1 – Setup Database

-- 👉 Task 1: Create Database
CREATE DATABASE IF NOT EXISTS index_lab;
USE index_lab;


-- 👉 Task 2: Create Table
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    join_date DATE
);


-- 👉 Task 3: Insert Sample Data

-- 👉 (Important: Run multiple times to increase data size)

INSERT INTO employees (name, department, salary, city, join_date) VALUES
('John', 'IT', 60000, 'Chennai', '2022-01-10'),
('Alice', 'HR', 50000, 'Mumbai', '2021-03-15'),
('Bob', 'IT', 70000, 'Bangalore', '2020-07-20'),
('David', 'Finance', 65000, 'Delhi', '2019-11-25'),
('Emma', 'IT', 72000, 'Chennai', '2023-05-18'),
('Sophia', 'HR', 48000, 'Chennai', '2022-09-12'),
('Liam', 'Finance', 80000, 'Mumbai', '2021-12-01'),
('Noah', 'IT', 75000, 'Bangalore', '2020-04-05');


-- 🟦 Part 2 – Without Index (Performance Check)

-- 👉 Task 4: Run Query Without Index
SELECT * FROM employees WHERE name = 'John';


-- 👉 Task 5: Analyze Using EXPLAIN
EXPLAIN SELECT * FROM employees WHERE name = 'John';
-- 👉 Observe:
-- type: ALL → Full table scan
-- rows: large number


-- 🟦 Part 3 – Single Column Index
-- 👉 Task 6: Create Index on Name
CREATE INDEX idx_name ON employees(name);

-- 👉 Task 7: Run Same Query Again
SELECT * FROM employees WHERE name = 'John';

-- 👉 Task 8: Check EXPLAIN Again
EXPLAIN SELECT * FROM employees WHERE name = 'John';
-- 👉 Observe:
-- type: ref
-- Faster lookup

-- 🟦 Part 4 – Composite Index
-- 👉 Task 9: Create Composite Index
CREATE INDEX idx_dept_salary 
ON employees(department, salary);


-- 👉 Task 10: Query Using Composite Index
SELECT * 
FROM employees 
WHERE department = 'IT' AND salary > 60000;


-- 👉 Task 11: Analyze Query
EXPLAIN 
SELECT * 
FROM employees 
WHERE department = 'IT' AND salary > 60000;
-- 👉 Observe index usage


-- 🟦 Part 5 – Leftmost Prefix Rule
-- 👉 Task 12: Works (Correct Usage)
SELECT * FROM employees WHERE department = 'IT';

-- 👉 Task 13: Does NOT Use Index Properly
SELECT * FROM employees WHERE salary > 60000;


-- 🟦 Part 6 – When Index Fails
-- 👉 Task 14: Function on Column
SELECT * 
FROM employees 
WHERE YEAR(join_date) = 2022;


-- 👉 Task 15: Optimized Query
SELECT * 
FROM employees 
WHERE join_date BETWEEN '2022-01-01' AND '2022-12-31';


-- 🟦 Part 7 – Insert Performance Impact
-- 👉 Task 16: Insert Data After Index
INSERT INTO employees (name, department, salary, city, join_date)
VALUES ('TestUser', 'IT', 55000, 'Chennai', '2023-01-01');
-- Slightly slower due to index updates


-- 🟦 Part 8 – Dropping Index
-- 👉 Task 17: Drop Index
DROP INDEX idx_name ON employees;


-- 👉 Task 18: Verify Again
EXPLAIN SELECT * FROM employees WHERE name = 'John';


-- 🟦 Part 9 – Challenge Tasks (Important)
-- Challenge 1: Create index on city, Run query:
SELECT * FROM employees WHERE city = 'Chennai';

-- Challenge 2:
-- Create composite index (city, department)
-- Test:
SELECT * 
FROM employees 
WHERE city = 'Chennai' AND department = 'IT';


-- Challenge 3 (Optimization Task):
-- 👉 Slow Query:
SELECT * FROM employees WHERE salary + 1000 > 60000;
-- ❌ Index not used due to expression on column
-- ✅ Fix:
SELECT * FROM employees WHERE salary > 59000;



-- 🟦 Part 10 – Bonus (Advanced)
-- 👉 Task 19: Show All Indexes
SHOW INDEX FROM employees;

-- 👉 Task 20: Measure Query Time (Optional)
SET profiling = 1;
SELECT * FROM employees WHERE name = 'John';
SHOW PROFILES;

----------------------------------------------------------------------------------

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



-- 🟦 Part 8 – Covering Index
CREATE INDEX idx_cover ON employees(name, salary);

EXPLAIN 
SELECT name, salary 
FROM employees 
WHERE name = 'Emp100';

-- All required columns are in index
-- MySQL does NOT access table
-- Covering Index (Index-only scan)
-- Benefit: Faster (no table lookup) & Less I/O

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




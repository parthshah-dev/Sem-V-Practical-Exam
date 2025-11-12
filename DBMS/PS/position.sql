-- =====================================================
-- MySQL Practical: Employee Duty Allocation Queries
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE DutyDB;
USE DutyDB;

-- Step 2: Create Tables
CREATE TABLE Empl (
    e_no INT PRIMARY KEY,
    e_name VARCHAR(50),
    post VARCHAR(50),
    pay_rate DECIMAL(10,2)
);

CREATE TABLE Position (
    pos_no INT PRIMARY KEY,
    post VARCHAR(50)
);

CREATE TABLE Duty_alloc (
    pos_no INT,
    e_no INT,
    month VARCHAR(20),
    year INT,
    shift VARCHAR(20)
);

-- Step 3: Insert Sample Data
INSERT INTO Empl VALUES
(123, 'Sachin', 'Manager', 50000),
(124, 'Amit', 'Engineer', 40000),
(125, 'Neha', 'Manager', 52000),
(126, 'Ravi', 'Technician', 35000),
(127, 'Karan', 'Manager', 48000);

INSERT INTO Position VALUES
(1, 'Manager'),
(2, 'Engineer'),
(3, 'Technician');

INSERT INTO Duty_alloc VALUES
(1, 123, 'April', 2003, 'First'),
(2, 124, 'April', 2003, 'Second'),
(1, 125, 'April', 2003, 'First'),
(3, 126, 'May', 2003, 'Third'),
(1, 127, 'April', 2003, 'Second');

-- =====================================================
-- (i) Get duty allocation details for e_no 123 for first shift in April 2003
-- =====================================================
SELECT *
FROM Duty_alloc
WHERE e_no = 123 AND month = 'April' AND year = 2003 AND shift = 'First';

-- =====================================================
-- (ii) Get employees whose pay_rate >= pay_rate of employee 'Sachin'
-- =====================================================
SELECT e_name, post, pay_rate
FROM Empl
WHERE pay_rate >= (
    SELECT pay_rate
    FROM Empl
    WHERE e_name = 'Sachin'
);

-- =====================================================
-- (iii) Create a view for min, max, and avg salary for all posts
-- =====================================================
CREATE VIEW salary_summary AS
SELECT post,
       MIN(pay_rate) AS Min_Salary,
       MAX(pay_rate) AS Max_Salary,
       AVG(pay_rate) AS Avg_Salary
FROM Empl
GROUP BY post;

-- Display the view
SELECT * FROM salary_summary;

-- =====================================================
-- (iv) Get count of different employees on each shift having post 'Manager'
-- =====================================================
SELECT d.shift, COUNT(DISTINCT d.e_no) AS Total_Managers
FROM Duty_alloc d
JOIN Empl e ON d.e_no = e.e_no
WHERE e.post = 'Manager'
GROUP BY d.shift;

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*

Practical: MySQL Employee Duty Allocation Queries

Theory:
This practical focuses on performing data retrieval, subqueries, joins, and view creation in a MySQL database related to employee duty management. The database includes three tables — Empl, Position, and Duty_alloc — representing employees, their posts, and their duty schedules. Queries demonstrate how to filter data using multiple conditions, use subqueries for comparative analysis (e.g., comparing pay rates), apply aggregate functions like MIN, MAX, and AVG for salary summaries, and count grouped results using GROUP BY. Creating a view allows efficient reusability of summarized data for reporting.

Step 1: Create and Use Database
CREATE DATABASE DutyDB;
USE DutyDB;

Step 2: Create Tables
CREATE TABLE Empl (
    e_no INT PRIMARY KEY,
    e_name VARCHAR(50),
    post VARCHAR(50),
    pay_rate DECIMAL(10,2)
);

CREATE TABLE Position (
    pos_no INT PRIMARY KEY,
    post VARCHAR(50)
);

CREATE TABLE Duty_alloc (
    pos_no INT,
    e_no INT,
    month VARCHAR(20),
    year INT,
    shift VARCHAR(20)
);

Step 3: Insert Sample Data
INSERT INTO Empl VALUES
(123, 'Sachin', 'Manager', 50000),
(124, 'Amit', 'Engineer', 40000),
(125, 'Neha', 'Manager', 52000),
(126, 'Ravi', 'Technician', 35000),
(127, 'Karan', 'Manager', 48000);

INSERT INTO Position VALUES
(1, 'Manager'),
(2, 'Engineer'),
(3, 'Technician');

INSERT INTO Duty_alloc VALUES
(1, 123, 'April', 2003, 'First'),
(2, 124, 'April', 2003, 'Second'),
(1, 125, 'April', 2003, 'First'),
(3, 126, 'May', 2003, 'Third'),
(1, 127, 'April', 2003, 'Second');

(i) Get duty allocation details for e_no 123 for first shift in April 2003
Query
SELECT *
FROM Duty_alloc
WHERE e_no = 123 AND month = 'April' AND year = 2003 AND shift = 'First';

Output
pos_no	e_no	month	year	shift
1	123	April	2003	First

Explanation:
This query filters Duty_alloc to retrieve details of employee 123 assigned to the First shift in April 2003.

(ii) Get employees whose pay_rate ≥ pay_rate of employee 'Sachin'
Query
SELECT e_name, post, pay_rate
FROM Empl
WHERE pay_rate >= (
    SELECT pay_rate
    FROM Empl
    WHERE e_name = 'Sachin'
);

Output
e_name	post	pay_rate
Sachin	Manager	50000.00
Neha	Manager	52000.00

Explanation:
A subquery retrieves Sachin’s pay rate (₹50,000), and the outer query lists all employees earning equal or more.

(iii) Create a view for min, max, and avg salary for all posts
Query
CREATE VIEW salary_summary AS
SELECT post,
       MIN(pay_rate) AS Min_Salary,
       MAX(pay_rate) AS Max_Salary,
       AVG(pay_rate) AS Avg_Salary
FROM Empl
GROUP BY post;

Display View
SELECT * FROM salary_summary;

Output
post	Min_Salary	Max_Salary	Avg_Salary
Engineer	40000.00	40000.00	40000.00
Manager	48000.00	52000.00	50000.00
Technician	35000.00	35000.00	35000.00

Explanation:
The salary_summary view aggregates salaries per post, making it reusable for quick department-level salary analysis.

(iv) Get count of different employees on each shift having post 'Manager'
Query
SELECT d.shift, COUNT(DISTINCT d.e_no) AS Total_Managers
FROM Duty_alloc d
JOIN Empl e ON d.e_no = e.e_no
WHERE e.post = 'Manager'
GROUP BY d.shift;

Output
shift	Total_Managers
First	2
Second	1

Explanation:
This query joins Duty_alloc and Empl to count unique managers assigned to each shift.

*/
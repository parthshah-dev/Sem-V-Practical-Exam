-- =====================================================
-- SQL DDL Demonstration: TABLE, VIEW, and INDEX
-- Environment: Client–Server (Two-Tier)
-- =====================================================

-- Step 1: Create a new database (if using MySQL)
-- CREATE DATABASE CompanyDB;
-- USE CompanyDB;

-- Step 2: Create a table named EMPLOYEE
CREATE TABLE Employee (
    Emp_ID     INT PRIMARY KEY,
    Emp_Name   VARCHAR(50),
    Dept_Name  VARCHAR(50),
    Salary     DECIMAL(10,2)
);

-- Step 3: Insert sample records
INSERT INTO Employee VALUES (101, 'Ravi Sharma', 'HR', 50000);
INSERT INTO Employee VALUES (102, 'Neha Patel', 'IT', 65000);
INSERT INTO Employee VALUES (103, 'Amit Singh', 'Finance', 70000);
INSERT INTO Employee VALUES (104, 'Karan Joshi', 'IT', 60000);
INSERT INTO Employee VALUES (105, 'Priya Mehta', 'HR', 48000);

COMMIT;

-- =====================================================
-- Step 4: Create a VIEW (Virtual Table)
-- A view displays employee details of the IT department
-- =====================================================
CREATE VIEW IT_Employees AS
SELECT Emp_ID, Emp_Name, Salary
FROM Employee
WHERE Dept_Name = 'IT';

-- Verify the view
SELECT * FROM IT_Employees;

-- =====================================================
-- Step 5: Create an INDEX
-- Index improves search performance on frequently queried columns
-- =====================================================
CREATE INDEX idx_deptname ON Employee(Dept_Name);

-- Verify Index (Oracle/MySQL command)
-- SHOW INDEX FROM Employee;  -- (MySQL)
-- or use this for Oracle:
-- SELECT INDEX_NAME, TABLE_NAME FROM USER_INDEXES WHERE TABLE_NAME = 'EMPLOYEE';

-- =====================================================
-- Step 6: Use Index in a Query
-- When querying by Dept_Name, the index speeds up retrieval
-- =====================================================
SELECT * FROM Employee WHERE Dept_Name = 'HR';

-- =====================================================
-- Step 7: Create a COMPOSITE (COMPLEX) INDEX (optional)
-- =====================================================
CREATE INDEX idx_dept_salary ON Employee(Dept_Name, Salary);

-- =====================================================
-- Step 8: Drop Objects (cleanup)
-- =====================================================
-- DROP VIEW IT_Employees;
-- DROP INDEX idx_deptname;
-- DROP INDEX idx_dept_salary;
-- DROP TABLE Employee;

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*
SQL DDL Demonstration: TABLE, VIEW, and INDEX

Theory:
This SQL script demonstrates the use of Data Definition Language (DDL) commands to create and manage tables, views, and indexes in a two-tier client–server environment. The Employee table is created to store details about employees, including department and salary. A view named IT_Employees is created to show only records belonging to the IT department, acting as a virtual table derived from a query. Indexes such as idx_deptname and idx_dept_salary are created to improve the speed of data retrieval when filtering or sorting by specific columns. DDL operations like CREATE TABLE, CREATE VIEW, and CREATE INDEX help define and optimize the database schema without manipulating actual data directly.

Step 1: Create the Table
CREATE TABLE Employee (
    Emp_ID     INT PRIMARY KEY,
    Emp_Name   VARCHAR(50),
    Dept_Name  VARCHAR(50),
    Salary     DECIMAL(10,2)
);

Step 2: Insert Sample Records
INSERT INTO Employee VALUES (101, 'Ravi Sharma', 'HR', 50000);
INSERT INTO Employee VALUES (102, 'Neha Patel', 'IT', 65000);
INSERT INTO Employee VALUES (103, 'Amit Singh', 'Finance', 70000);
INSERT INTO Employee VALUES (104, 'Karan Joshi', 'IT', 60000);
INSERT INTO Employee VALUES (105, 'Priya Mehta', 'HR', 48000);
COMMIT;


Employee Table:

Emp_ID	Emp_Name	Dept_Name	Salary
101	Ravi Sharma	HR	50000.00
102	Neha Patel	IT	65000.00
103	Amit Singh	Finance	70000.00
104	Karan Joshi	IT	60000.00
105	Priya Mehta	HR	48000.00
Step 3: Create a View
CREATE VIEW IT_Employees AS
SELECT Emp_ID, Emp_Name, Salary
FROM Employee
WHERE Dept_Name = 'IT';


Input Query:

SELECT * FROM IT_Employees;


Output:

Emp_ID	Emp_Name	Salary
102	Neha Patel	65000.00
104	Karan Joshi	60000.00
Step 4: Create Index
CREATE INDEX idx_deptname ON Employee(Dept_Name);


Purpose:
This index allows faster searching of employees based on department names (e.g., in queries using WHERE Dept_Name = 'HR').

Verification Command (MySQL):

SHOW INDEX FROM Employee;

Step 5: Use the Index
SELECT * FROM Employee WHERE Dept_Name = 'HR';


Output:

Emp_ID	Emp_Name	Dept_Name	Salary
101	Ravi Sharma	HR	50000.00
105	Priya Mehta	HR	48000.00
Step 6: Create Composite Index (Optional)
CREATE INDEX idx_dept_salary ON Employee(Dept_Name, Salary);


Explanation:
A composite index combines multiple columns (Dept_Name, Salary) to improve performance of queries that filter or sort by both columns simultaneously.
*/
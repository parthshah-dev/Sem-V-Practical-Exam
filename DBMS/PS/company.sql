-- =====================================================
-- MySQL Practical: Employee, Company, and Manager Queries
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Step 2: Create Tables
CREATE TABLE Emp (
    emp_id INT PRIMARY KEY,
    ename VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Company (
    c_id INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Works (
    emp_id INT,
    c_id INT,
    ename VARCHAR(50),
    cname VARCHAR(50),
    sal DECIMAL(10,2)
);

CREATE TABLE Manager (
    mgr_id INT PRIMARY KEY,
    mgrname VARCHAR(50)
);

-- Step 3: Insert Sample Data
INSERT INTO Emp VALUES
(1, 'Ravi', 'MG Road', 'Mumbai'),
(2, 'Sneha', 'JM Road', 'Pune'),
(3, 'Amit', 'FC Road', 'Delhi'),
(4, 'Karan', 'Karve Road', 'Pune');

INSERT INTO Company VALUES
(101, 'ABC', 'Mumbai'),
(102, 'Mbank', 'Delhi'),
(103, 'Bosch', 'Pune'),
(104, 'SBC', 'Bangalore');

INSERT INTO Works VALUES
(1, 101, 'Ravi', 'ABC', 18000),
(2, 102, 'Sneha', 'Mbank', 22000),
(3, 103, 'Amit', 'Bosch', 27000),
(4, 104, 'Karan', 'SBC', 55000);

INSERT INTO Manager VALUES
(201, 'Mr. Shah'),
(202, 'Ms. Ritu'),
(203, 'Mr. Kumar');

-- =====================================================
-- (i) Modify database so that company 'ABC' is now in Pune
-- =====================================================
UPDATE Company
SET city = 'Pune'
WHERE cname = 'ABC';

-- Verify
SELECT * FROM Company;

-- =====================================================
-- (ii) Give all managers of 'Mbank' a 10% raise. 
-- If salary > 20000, give only 3% raise
-- =====================================================
UPDATE Works
SET sal = CASE
              WHEN sal > 20000 THEN sal * 1.03
              ELSE sal * 1.10
          END
WHERE cname = 'Mbank';

-- Verify
SELECT * FROM Works;

-- =====================================================
-- (iii) Find names of all employees who work in 'Bosch' company in city 'Pune'
-- =====================================================
SELECT e.ename
FROM Emp e
JOIN Works w ON e.emp_id = w.emp_id
JOIN Company c ON w.c_id = c.c_id
WHERE w.cname = 'Bosch' AND c.city = 'Pune';

-- =====================================================
-- (iv) Delete all records in Works table for employees of company 'SBC' whose salary > 50000
-- =====================================================
DELETE FROM Works
WHERE cname = 'SBC' AND sal > 50000;

-- Verify Deletion
SELECT * FROM Works;

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*
MySQL Practical: Employee, Company, and Manager Queries

Theory:
This MySQL practical demonstrates how to manage and query relational data across multiple tables using UPDATE, DELETE, and JOIN operations. The database CompanyDB maintains records of employees, companies, and managers. The script covers important SQL operations — updating records based on conditions, applying conditional raises using the CASE statement, performing multi-table joins to fetch filtered results, and deleting specific rows based on logical criteria. These operations illustrate how SQL can be used for both data manipulation (DML) and data retrieval (DQL) efficiently within a multi-table relational environment.

Step 1: Create Database and Tables
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Emp (
    emp_id INT PRIMARY KEY,
    ename VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Company (
    c_id INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Works (
    emp_id INT,
    c_id INT,
    ename VARCHAR(50),
    cname VARCHAR(50),
    sal DECIMAL(10,2)
);

CREATE TABLE Manager (
    mgr_id INT PRIMARY KEY,
    mgrname VARCHAR(50)
);

Step 2: Insert Sample Data
INSERT INTO Emp VALUES
(1, 'Ravi', 'MG Road', 'Mumbai'),
(2, 'Sneha', 'JM Road', 'Pune'),
(3, 'Amit', 'FC Road', 'Delhi'),
(4, 'Karan', 'Karve Road', 'Pune');

INSERT INTO Company VALUES
(101, 'ABC', 'Mumbai'),
(102, 'Mbank', 'Delhi'),
(103, 'Bosch', 'Pune'),
(104, 'SBC', 'Bangalore');

INSERT INTO Works VALUES
(1, 101, 'Ravi', 'ABC', 18000),
(2, 102, 'Sneha', 'Mbank', 22000),
(3, 103, 'Amit', 'Bosch', 27000),
(4, 104, 'Karan', 'SBC', 55000);

INSERT INTO Manager VALUES
(201, 'Mr. Shah'),
(202, 'Ms. Ritu'),
(203, 'Mr. Kumar');

(i) Modify company 'ABC' city to Pune
UPDATE Company
SET city = 'Pune'
WHERE cname = 'ABC';


Input Query:

SELECT * FROM Company;


Output:

c_id	cname	city
101	ABC	Pune
102	Mbank	Delhi
103	Bosch	Pune
104	SBC	Bangalore
(ii) Give all managers of 'Mbank' a salary raise
UPDATE Works
SET sal = CASE
              WHEN sal > 20000 THEN sal * 1.03
              ELSE sal * 1.10
          END
WHERE cname = 'Mbank';


Input Query:

SELECT * FROM Works;


Output:

emp_id	c_id	ename	cname	sal
1	101	Ravi	ABC	18000
2	102	Sneha	Mbank	22660
3	103	Amit	Bosch	27000
4	104	Karan	SBC	55000

(Sneha’s salary increased by 3% since it was above 20000.)

(iii) Find employees who work in 'Bosch' company located in Pune
SELECT e.ename
FROM Emp e
JOIN Works w ON e.emp_id = w.emp_id
JOIN Company c ON w.c_id = c.c_id
WHERE w.cname = 'Bosch' AND c.city = 'Pune';


Output:

ename
Amit
(iv) Delete records from Works table for employees of 'SBC' whose salary > 50000
DELETE FROM Works
WHERE cname = 'SBC' AND sal > 50000;


Verification:

SELECT * FROM Works;


Output (After Deletion):

emp_id	c_id	ename	cname	sal
1	101	Ravi	ABC	18000
2	102	Sneha	Mbank	22660
3	103	Amit	Bosch	27000

(Record for Karan — 'SBC', salary 55000 — has been deleted.)
*/
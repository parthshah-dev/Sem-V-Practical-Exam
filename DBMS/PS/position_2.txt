-- =====================================================
-- MySQL Practical: Employee, Position and Duty Allocation Queries
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- Step 2: Create Tables
CREATE TABLE Employee (
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
INSERT INTO Employee VALUES
(101, 'Ravi', 'Manager', 60000),
(102, 'Amit', 'Engineer', 45000),
(103, 'Sneha', 'Technician', 35000),
(104, 'Karan', 'Manager', 62000),
(105, 'Neha', 'Engineer', 47000);

INSERT INTO Position VALUES
(1, 'Manager'),
(2, 'Engineer'),
(3, 'Technician');

INSERT INTO Duty_alloc VALUES
(1, 101, 'April', 2023, 'First'),
(2, 102, 'April', 2023, 'Second'),
(3, 103, 'May', 2023, 'Third'),
(1, 104, 'June', 2023, 'First'),
(2, 105, 'June', 2023, 'Second');

-- =====================================================
-- (i) Create view that displays first three columns of Employee table
-- =====================================================
CREATE VIEW emp_basic_view AS
SELECT e_no, e_name, post
FROM Employee;

-- Display the view
SELECT * FROM emp_basic_view;

-- =====================================================
-- (ii) Create view that displays LEFT OUTER JOIN between Employee and Position on post
-- =====================================================
CREATE VIEW emp_position_view AS
SELECT e.e_no, e.e_name, e.post, e.pay_rate, p.pos_no, p.post AS position_post
FROM Employee e
LEFT JOIN Position p ON e.post = p.post;

-- Display the view
SELECT * FROM emp_position_view;

-- =====================================================
-- (iii) Create index on pos_no attribute of Position table
-- =====================================================
CREATE INDEX idx_posno ON Position(pos_no);

-- Verify index creation
SHOW INDEX FROM Position;

-- =====================================================
-- (iv) Fire queries based on indexed column (pos_no)
-- =====================================================

-- Example 1: Retrieve position details by pos_no (uses index)
SELECT * FROM Position WHERE pos_no = 1;

-- Example 2: Retrieve employees having position number 2 (Engineer)
SELECT e.e_name, e.post
FROM Employee e
JOIN Position p ON e.post = p.post
WHERE p.pos_no = 2;

-- Example 3: Count of duties allocated by position number
SELECT pos_no, COUNT(e_no) AS total_employees
FROM Duty_alloc
GROUP BY pos_no;

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*

Practical: MySQL Employee, Position, and Duty Allocation Queries

Theory:
This practical demonstrates the use of views, joins, and indexes in MySQL to organize and optimize employee-related data management. A view is a virtual table that provides a simplified or specific perspective of data stored in one or more tables. It helps in data abstraction and security. A join operation is used to combine rows from multiple tables based on a related column, while an index improves query performance by speeding up data retrieval. The exercise also includes executing queries that leverage the indexed column for faster access, illustrating how indexing enhances efficiency in real-world databases.

Step 1: Create and Use Database
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

Step 2: Create Tables
CREATE TABLE Employee (
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
INSERT INTO Employee VALUES
(101, 'Ravi', 'Manager', 60000),
(102, 'Amit', 'Engineer', 45000),
(103, 'Sneha', 'Technician', 35000),
(104, 'Karan', 'Manager', 62000),
(105, 'Neha', 'Engineer', 47000);

INSERT INTO Position VALUES
(1, 'Manager'),
(2, 'Engineer'),
(3, 'Technician');

INSERT INTO Duty_alloc VALUES
(1, 101, 'April', 2023, 'First'),
(2, 102, 'April', 2023, 'Second'),
(3, 103, 'May', 2023, 'Third'),
(1, 104, 'June', 2023, 'First'),
(2, 105, 'June', 2023, 'Second');

(i) Create view that displays first three columns of Employee table
Query
CREATE VIEW emp_basic_view AS
SELECT e_no, e_name, post
FROM Employee;

Output
SELECT * FROM emp_basic_view;

e_no	e_name	post
101	Ravi	Manager
102	Amit	Engineer
103	Sneha	Technician
104	Karan	Manager
105	Neha	Engineer

Explanation:
This view displays only basic employee details — employee number, name, and designation — making it useful for restricted access reporting.

(ii) Create view that displays LEFT OUTER JOIN between Employee and Position on post
Query
CREATE VIEW emp_position_view AS
SELECT e.e_no, e.e_name, e.post, e.pay_rate, p.pos_no, p.post AS position_post
FROM Employee e
LEFT JOIN Position p ON e.post = p.post;

Output
SELECT * FROM emp_position_view;

e_no	e_name	post	pay_rate	pos_no	position_post
101	Ravi	Manager	60000.00	1	Manager
102	Amit	Engineer	45000.00	2	Engineer
103	Sneha	Technician	35000.00	3	Technician
104	Karan	Manager	62000.00	1	Manager
105	Neha	Engineer	47000.00	2	Engineer

Explanation:
This view shows all employees along with their related position numbers, even if there’s no matching position (thanks to LEFT JOIN).

(iii) Create index on pos_no attribute of Position table
Query
CREATE INDEX idx_posno ON Position(pos_no);

Verification
SHOW INDEX FROM Position;

Output
Table	Non_unique	Key_name	Seq_in_index	Column_name	Index_type
Position	0	PRIMARY	1	pos_no	BTREE
Position	1	idx_posno	1	pos_no	BTREE

Explanation:
An index is created on the pos_no column to enhance query performance during lookups or joins involving the Position table.

(iv) Fire queries based on indexed column (pos_no)
Example 1: Retrieve position details by pos_no
SELECT * FROM Position WHERE pos_no = 1;


Output

pos_no	post
1	Manager
Example 2: Retrieve employees having position number 2 (Engineer)
SELECT e.e_name, e.post
FROM Employee e
JOIN Position p ON e.post = p.post
WHERE p.pos_no = 2;


Output

e_name	post
Amit	Engineer
Neha	Engineer
Example 3: Count of duties allocated by position number
SELECT pos_no, COUNT(e_no) AS total_employees
FROM Duty_alloc
GROUP BY pos_no;


Output

pos_no	total_employees
1	2
2	2
3	1

Explanation:
The queries efficiently access records filtered or grouped by pos_no — an indexed column — leading to faster query execution.

*/
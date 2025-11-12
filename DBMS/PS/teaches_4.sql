-- =====================================================
-- MySQL Practical: Student, Instructor, and Course Queries
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Step 2: Create Tables
CREATE TABLE student (
    S_ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    tot_cred INT
);

CREATE TABLE instructor (
    T_ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(50),
    credits INT
);

-- Step 3: Insert Sample Data
INSERT INTO instructor VALUES
(101, 'Amol', 'Computer', 40000),
(102, 'Amit', 'Computer', 45000),
(103, 'Sneha', 'IT', 48000),
(104, 'Ravi', 'Mechanical', 50000),
(105, 'Karan', 'Computer', 60000);

INSERT INTO student VALUES
(1, 'Ram', 'Computer', 120),
(2, 'Aman', 'IT', 100),
(3, 'Anamika', 'Computer', 110),
(4, 'Samir', 'Mechanical', 130),
(5, 'Kamal', 'Computer', 90);

INSERT INTO course VALUES
(201, 'DBMS', 'Computer', 4),
(202, 'OS', 'Computer', 3),
(203, 'Networking', 'IT', 4);

-- =====================================================
-- (i) Find average salary of instructor in departments where avg salary > 42000
-- =====================================================
SELECT dept_name, AVG(salary) AS Average_Salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;

-- =====================================================
-- (ii) Increase salary of instructors in Computer dept by 10%
-- =====================================================
UPDATE instructor
SET salary = salary * 1.10
WHERE dept_name = 'Computer';

-- Verify update
SELECT * FROM instructor;

-- =====================================================
-- (iii) Find instructors whose names are neither 'Amol' nor 'Amit'
-- =====================================================
SELECT name, dept_name, salary
FROM instructor
WHERE name NOT IN ('Amol', 'Amit');

-- =====================================================
-- (iv) Find student names containing 'am' as substring
-- =====================================================
SELECT name
FROM student
WHERE name LIKE '%am%';

-- =====================================================
-- (v) Find names of students from Computer department who take 'DBMS' course
-- =====================================================
SELECT s.name AS Student_Name, s.dept_name, c.title AS Course_Title
FROM student s
JOIN course c ON s.dept_name = c.dept_name
WHERE s.dept_name = 'Computer' AND c.title = 'DBMS';

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*

Practical: MySQL Student, Instructor, and Course Queries

Theory:
This practical demonstrates the use of aggregate functions, pattern matching, conditional filtering, updating records, and joins in MySQL. It integrates data from multiple entities — student, instructor, and course — within a university database. Through this exercise, we learn how to use GROUP BY and HAVING for department-level aggregation, UPDATE to modify data conditionally, NOT IN for exclusion filters, LIKE for substring searches, and JOIN for retrieving related records across tables. These are essential SQL operations for handling real-world academic databases efficiently.

Step 1: Database Creation
CREATE DATABASE UniversityDB;
USE UniversityDB;

Step 2: Create Tables
CREATE TABLE student (
    S_ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    tot_cred INT
);

CREATE TABLE instructor (
    T_ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(50),
    credits INT
);

Step 3: Insert Sample Data
INSERT INTO instructor VALUES
(101, 'Amol', 'Computer', 40000),
(102, 'Amit', 'Computer', 45000),
(103, 'Sneha', 'IT', 48000),
(104, 'Ravi', 'Mechanical', 50000),
(105, 'Karan', 'Computer', 60000);

INSERT INTO student VALUES
(1, 'Ram', 'Computer', 120),
(2, 'Aman', 'IT', 100),
(3, 'Anamika', 'Computer', 110),
(4, 'Samir', 'Mechanical', 130),
(5, 'Kamal', 'Computer', 90);

INSERT INTO course VALUES
(201, 'DBMS', 'Computer', 4),
(202, 'OS', 'Computer', 3),
(203, 'Networking', 'IT', 4);

(i) Find average salary of instructor in departments where avg salary > 42000
Query
SELECT dept_name, AVG(salary) AS Average_Salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;

Output
dept_name	Average_Salary
Computer	48333.33
IT	48000.00
Mechanical	50000.00
(ii) Increase salary of instructors in Computer dept by 10%
Query
UPDATE instructor
SET salary = salary * 1.10
WHERE dept_name = 'Computer';

Verification
SELECT * FROM instructor;

Output
T_ID	name	dept_name	salary
101	Amol	Computer	44000.00
102	Amit	Computer	49500.00
103	Sneha	IT	48000.00
104	Ravi	Mechanical	50000.00
105	Karan	Computer	66000.00
(iii) Find instructors whose names are neither 'Amol' nor 'Amit'
Query
SELECT name, dept_name, salary
FROM instructor
WHERE name NOT IN ('Amol', 'Amit');

Output
name	dept_name	salary
Sneha	IT	48000.00
Ravi	Mechanical	50000.00
Karan	Computer	66000.00
(iv) Find student names containing 'am' as substring
Query
SELECT name
FROM student
WHERE name LIKE '%am%';

Output
name
Ram
Aman
Samir
(v) Find names of students from Computer department who take 'DBMS' course
Query
SELECT s.name AS Student_Name, s.dept_name, c.title AS Course_Title
FROM student s
JOIN course c ON s.dept_name = c.dept_name
WHERE s.dept_name = 'Computer' AND c.title = 'DBMS';

Output
Student_Name	dept_name	Course_Title
Ram	Computer	DBMS
Anamika	Computer	DBMS
Kamal	Computer	DBMS

*/
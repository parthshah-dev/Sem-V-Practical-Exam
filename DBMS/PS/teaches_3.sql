-- =====================================================
-- MySQL Practical: Instructor and Course Management
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Step 2: Create Tables
CREATE TABLE teaches (
    T_ID INT,
    course_id INT,
    sec_id INT,
    semester VARCHAR(10),
    year INT
);

CREATE TABLE section (
    course_id INT,
    sec_id INT,
    semester VARCHAR(10),
    year INT,
    building VARCHAR(30),
    room_no VARCHAR(10)
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
(101, 'Dr. Mehta', 'CSE', 55000),
(102, 'Dr. Roy', 'IT', 45000),
(103, 'Dr. Sharma', 'CSE', 65000),
(104, 'Dr. Singh', 'MECH', 32000),
(105, 'Dr. Patel', 'CIVIL', 28000);

INSERT INTO course VALUES
(101, 'Database Systems', 'CSE', 4),
(102, 'Networking', 'IT', 4),
(103, 'Operating Systems', 'CSE', 4),
(104, 'Fluid Mechanics', 'CIVIL', 3);

INSERT INTO teaches VALUES
(101, 101, 1, 'Fall', 2023),
(102, 102, 1, 'Spring', 2024),
(103, 103, 1, 'Fall', 2023),
(104, 104, 1, 'Winter', 2024);

INSERT INTO section VALUES
(101, 1, 'Fall', 2023, 'Main Building', '101A'),
(102, 1, 'Spring', 2024, 'Block B', '202B'),
(103, 1, 'Fall', 2023, 'Block C', '303C'),
(104, 1, 'Winter', 2024, 'Lab A', '404D');

-- =====================================================
-- (i) Display instructors with salary between 30000 and 60000 (descending)
-- =====================================================
SELECT name, dept_name, salary
FROM instructor
WHERE salary BETWEEN 30000 AND 60000
ORDER BY salary DESC;

-- =====================================================
-- (ii) Find average, minimum, and maximum salary in each department
-- =====================================================
SELECT dept_name,
       AVG(salary) AS Average_Salary,
       MIN(salary) AS Minimum_Salary,
       MAX(salary) AS Maximum_Salary
FROM instructor
GROUP BY dept_name;

-- =====================================================
-- (iii) Display instructor name, department, and salary for course_id = 101
-- =====================================================
SELECT i.name AS Instructor_Name, i.dept_name, i.salary
FROM instructor i
JOIN teaches t ON i.T_ID = t.T_ID
WHERE t.course_id = 101;

-- =====================================================
-- (iv) Find instructors whose average salary (per department) is greater than 60000
-- =====================================================
SELECT dept_name, AVG(salary) AS Avg_Salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 60000;

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================



/*

Practical: MySQL Instructor and Course Management

Theory:
This practical demonstrates how to manage and analyze data using SQL queries that involve filtering, aggregation, joins, and grouping in a university database. The instructor, course, teaches, and section tables represent a relational model of academic data. The queries cover a range of real-world database tasks: filtering rows using BETWEEN, grouping data using GROUP BY, aggregating values with functions like AVG(), MIN(), and MAX(), joining tables to relate instructors with their courses, and filtering grouped results using HAVING. These concepts are essential for understanding data analysis and reporting in SQL.

Step 1: Database Creation
CREATE DATABASE UniversityDB;
USE UniversityDB;

Step 2: Create Tables
CREATE TABLE teaches (
    T_ID INT,
    course_id INT,
    sec_id INT,
    semester VARCHAR(10),
    year INT
);

CREATE TABLE section (
    course_id INT,
    sec_id INT,
    semester VARCHAR(10),
    year INT,
    building VARCHAR(30),
    room_no VARCHAR(10)
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
(101, 'Dr. Mehta', 'CSE', 55000),
(102, 'Dr. Roy', 'IT', 45000),
(103, 'Dr. Sharma', 'CSE', 65000),
(104, 'Dr. Singh', 'MECH', 32000),
(105, 'Dr. Patel', 'CIVIL', 28000);

INSERT INTO course VALUES
(101, 'Database Systems', 'CSE', 4),
(102, 'Networking', 'IT', 4),
(103, 'Operating Systems', 'CSE', 4),
(104, 'Fluid Mechanics', 'CIVIL', 3);

INSERT INTO teaches VALUES
(101, 101, 1, 'Fall', 2023),
(102, 102, 1, 'Spring', 2024),
(103, 103, 1, 'Fall', 2023),
(104, 104, 1, 'Winter', 2024);

INSERT INTO section VALUES
(101, 1, 'Fall', 2023, 'Main Building', '101A'),
(102, 1, 'Spring', 2024, 'Block B', '202B'),
(103, 1, 'Fall', 2023, 'Block C', '303C'),
(104, 1, 'Winter', 2024, 'Lab A', '404D');

(i) Display instructors with salary between 30000 and 60000 (descending)
Query
SELECT name, dept_name, salary
FROM instructor
WHERE salary BETWEEN 30000 AND 60000
ORDER BY salary DESC;

Output
name	dept_name	salary
Dr. Mehta	CSE	55000.00
Dr. Roy	IT	45000.00
Dr. Singh	MECH	32000.00
(ii) Find average, minimum, and maximum salary in each department
Query
SELECT dept_name,
       AVG(salary) AS Average_Salary,
       MIN(salary) AS Minimum_Salary,
       MAX(salary) AS Maximum_Salary
FROM instructor
GROUP BY dept_name;

Output
dept_name	Average_Salary	Minimum_Salary	Maximum_Salary
CSE	60000.00	55000.00	65000.00
IT	45000.00	45000.00	45000.00
MECH	32000.00	32000.00	32000.00
CIVIL	28000.00	28000.00	28000.00
(iii) Display instructor name, department, and salary for course_id = 101
Query
SELECT i.name AS Instructor_Name, i.dept_name, i.salary
FROM instructor i
JOIN teaches t ON i.T_ID = t.T_ID
WHERE t.course_id = 101;

Output
Instructor_Name	dept_name	salary
Dr. Mehta	CSE	55000.00
(iv) Find instructors whose average salary (per department) is greater than 60000
Query
SELECT dept_name, AVG(salary) AS Avg_Salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 60000;

Output
dept_name	Avg_Salary
CSE	60000.00

*/
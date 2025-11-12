-- =====================================================
-- MySQL Practical: Instructor and Course Details
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Step 2: Create Tables
CREATE TABLE teaches (
    T_ID INT,
    course_id VARCHAR(10),
    sec_id INT,
    semester VARCHAR(10),
    year INT
);

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
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(50),
    credits INT
);

-- Step 3: Insert Sample Data
INSERT INTO instructor VALUES 
(101, 'Dr. Mehta', 'CSE', 30000),
(102, 'Dr. Roy', 'IT', 28000),
(103, 'Dr. Sharma', 'CSE', 26000),
(104, 'Dr. Singh', 'MECH', 24000);

INSERT INTO course VALUES
('CS101', 'Database Systems', 'CSE', 4),
('CS102', 'Operating Systems', 'CSE', 4),
('IT201', 'Web Technologies', 'IT', 3),
('ME101', 'Thermodynamics', 'MECH', 4);

INSERT INTO teaches VALUES
(101, 'CS101', 1, 'Fall', 2023),
(102, 'IT201', 1, 'Spring', 2024),
(103, 'CS102', 1, 'Fall', 2023),
(101, 'CS101', 2, 'Spring', 2024);

-- =====================================================
-- (i) Find names of all instructors whose salary > 25000
-- =====================================================
SELECT name, dept_name, salary
FROM instructor
WHERE salary > 25000;

-- =====================================================
-- (ii) Update instructor dept_name from CSE to IT
-- =====================================================
UPDATE instructor
SET dept_name = 'IT'
WHERE dept_name = 'CSE';

-- Verify
SELECT * FROM instructor;

-- =====================================================
-- (iii) Create Simple Index on course table and view dept-wise courses
-- =====================================================
CREATE INDEX idx_deptname ON course(dept_name);

SELECT dept_name, title
FROM course
ORDER BY dept_name;

-- =====================================================
-- (iv) Create View for instructor-course details
-- =====================================================
CREATE VIEW instructor_course_view AS
SELECT i.T_ID, i.name AS Instructor_Name, i.dept_name, 
       c.title AS Course_Title, t.sec_id, t.semester, t.year
FROM instructor i
JOIN teaches t ON i.T_ID = t.T_ID
JOIN course c ON t.course_id = c.course_id;

-- Display view
SELECT * FROM instructor_course_view;

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*

Practical: MySQL Instructor and Course Details

Theory:
This practical demonstrates how to use SQL queries, indexes, and views to manage and analyze university instructor and course data. It includes filtering records using conditions (WHERE), updating data, creating indexes to improve search performance, and building views to simplify complex joins for reporting purposes. By linking instructor, course, and teaches tables, we can retrieve complete instructor-course details efficiently. This exercise highlights relational database concepts such as data retrieval, schema updates, indexing for optimization, and view creation for reusable queries.

Step 1: Database Creation
CREATE DATABASE UniversityDB;
USE UniversityDB;

Step 2: Create Tables
CREATE TABLE teaches (
    T_ID INT,
    course_id VARCHAR(10),
    sec_id INT,
    semester VARCHAR(10),
    year INT
);

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
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(50),
    credits INT
);

Step 3: Insert Sample Data
INSERT INTO instructor VALUES 
(101, 'Dr. Mehta', 'CSE', 30000),
(102, 'Dr. Roy', 'IT', 28000),
(103, 'Dr. Sharma', 'CSE', 26000),
(104, 'Dr. Singh', 'MECH', 24000);

INSERT INTO course VALUES
('CS101', 'Database Systems', 'CSE', 4),
('CS102', 'Operating Systems', 'CSE', 4),
('IT201', 'Web Technologies', 'IT', 3),
('ME101', 'Thermodynamics', 'MECH', 4);

INSERT INTO teaches VALUES
(101, 'CS101', 1, 'Fall', 2023),
(102, 'IT201', 1, 'Spring', 2024),
(103, 'CS102', 1, 'Fall', 2023),
(101, 'CS101', 2, 'Spring', 2024);

(i) Find names of all instructors whose salary > 25000
Query
SELECT name, dept_name, salary
FROM instructor
WHERE salary > 25000;

Output
name	dept_name	salary
Dr. Mehta	CSE	30000.00
Dr. Roy	IT	28000.00
Dr. Sharma	CSE	26000.00
(ii) Update instructor dept_name from CSE to IT
Query
UPDATE instructor
SET dept_name = 'IT'
WHERE dept_name = 'CSE';

Verification
SELECT * FROM instructor;

Output
T_ID	name	dept_name	salary
101	Dr. Mehta	IT	30000.00
102	Dr. Roy	IT	28000.00
103	Dr. Sharma	IT	26000.00
104	Dr. Singh	MECH	24000.00
(iii) Create Simple Index on course table and view dept-wise courses
Query
CREATE INDEX idx_deptname ON course(dept_name);

SELECT dept_name, title
FROM course
ORDER BY dept_name;

Output
dept_name	title
CSE	Database Systems
CSE	Operating Systems
IT	Web Technologies
MECH	Thermodynamics

Verification of Index

SHOW INDEX FROM course;

(iv) Create View for instructor-course details
Query
CREATE VIEW instructor_course_view AS
SELECT i.T_ID, i.name AS Instructor_Name, i.dept_name, 
       c.title AS Course_Title, t.sec_id, t.semester, t.year
FROM instructor i
JOIN teaches t ON i.T_ID = t.T_ID
JOIN course c ON t.course_id = c.course_id;

Display View
SELECT * FROM instructor_course_view;

Output
T_ID	Instructor_Name	dept_name	Course_Title	sec_id	semester	year
101	Dr. Mehta	IT	Database Systems	1	Fall	2023
101	Dr. Mehta	IT	Database Systems	2	Spring	2024
102	Dr. Roy	IT	Web Technologies	1	Spring	2024
103	Dr. Sharma	IT	Operating Systems	1	Fall	2023

*/
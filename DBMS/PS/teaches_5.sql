-- =====================================================
-- MySQL Practical: Instructor and Course Management Queries
-- =====================================================

-- Step 1: Create and Use Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Step 2: Create Tables
CREATE TABLE teaches (
    T_ID INT,
    course_id INT,
    sec_id INT,
    semester VARCHAR(20),
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
    course_id INT PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(50),
    credits INT
);

-- Step 3: Insert Sample Data
INSERT INTO instructor VALUES
(101, 'Dr. Shree Mehta', 'Computer', 60000),
(102, 'Dr. Roy', 'Civil', 45000),
(103, 'Dr. Sharma', 'Computer', 55000),
(104, 'Dr. Nikhil', 'Mechanical', 40000),
(105, 'Dr. Shreeja', 'Computer', 62000);

INSERT INTO course VALUES
(201, 'DBMS', 'Computer', 4),
(202, 'OS', 'Computer', 3),
(203, 'Mechanics', 'Mechanical', 4),
(204, 'Surveying', 'Civil', 3);

INSERT INTO teaches VALUES
(101, 201, 1, 'First', 2010),
(102, 204, 1, 'First', 2010),
(103, 202, 1, 'Fifth', 2014),
(104, 203, 1, 'Fifth', 2014),
(105, 201, 1, 'First', 2010);

-- =====================================================
-- (i) Total number of instructors who taught a course in First semester 2010
-- =====================================================
SELECT COUNT(DISTINCT T_ID) AS Total_Instructors
FROM teaches
WHERE semester = 'First' AND year = 2010;

-- =====================================================
-- (ii) Names of all instructors from Computer dept whose name includes 'shree'
-- =====================================================
SELECT name, dept_name
FROM instructor
WHERE dept_name = 'Computer' AND name LIKE '%shree%';

-- =====================================================
-- (iii) Names of all instructors having salary greater than average salary of Civil Dept
-- =====================================================
SELECT name, dept_name, salary
FROM instructor
WHERE salary > (
    SELECT AVG(salary)
    FROM instructor
    WHERE dept_name = 'Civil'
);

-- =====================================================
-- (iv) Set of all courses taught in Fifth sem 2014 or First sem 2010 or both
-- =====================================================
SELECT DISTINCT course_id
FROM teaches
WHERE (semester = 'Fifth' AND year = 2014)
   OR (semester = 'First' AND year = 2010);

-- =====================================================
-- ✅ END OF PROGRAM
-- =====================================================


/*

Practical: MySQL Instructor and Course Management Queries

Theory:
This practical focuses on performing aggregate functions, subqueries, pattern matching, and set operations in a university database. It demonstrates how to analyze instructor and course data using SQL queries. Concepts such as COUNT(DISTINCT) are used to find unique instructors, LIKE is applied for substring matching in text data, and subqueries are used for comparisons against computed averages (for example, finding instructors whose salary exceeds the departmental average). Additionally, the query using OR conditions identifies distinct courses taught across different semesters, demonstrating basic set logic in SQL. These are essential tools for querying and analyzing relational data efficiently.

Step 1: Create and Use Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

Step 2: Create Tables
CREATE TABLE teaches (
    T_ID INT,
    course_id INT,
    sec_id INT,
    semester VARCHAR(20),
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
    course_id INT PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(50),
    credits INT
);

Step 3: Insert Sample Data
INSERT INTO instructor VALUES
(101, 'Dr. Shree Mehta', 'Computer', 60000),
(102, 'Dr. Roy', 'Civil', 45000),
(103, 'Dr. Sharma', 'Computer', 55000),
(104, 'Dr. Nikhil', 'Mechanical', 40000),
(105, 'Dr. Shreeja', 'Computer', 62000);

INSERT INTO course VALUES
(201, 'DBMS', 'Computer', 4),
(202, 'OS', 'Computer', 3),
(203, 'Mechanics', 'Mechanical', 4),
(204, 'Surveying', 'Civil', 3);

INSERT INTO teaches VALUES
(101, 201, 1, 'First', 2010),
(102, 204, 1, 'First', 2010),
(103, 202, 1, 'Fifth', 2014),
(104, 203, 1, 'Fifth', 2014),
(105, 201, 1, 'First', 2010);

(i) Total number of instructors who taught a course in First semester 2010
Query
SELECT COUNT(DISTINCT T_ID) AS Total_Instructors
FROM teaches
WHERE semester = 'First' AND year = 2010;

Output
Total_Instructors
3

Explanation:
Three instructors (T_ID 101, 102, 105) taught courses during the First semester of 2010.

(ii) Names of all instructors from Computer dept whose name includes 'shree'
Query
SELECT name, dept_name
FROM instructor
WHERE dept_name = 'Computer' AND name LIKE '%shree%';

Output
name	dept_name
Dr. Shree Mehta	Computer
Dr. Shreeja	Computer

Explanation:
The query uses the LIKE '%shree%' pattern to find instructors whose names contain the substring “shree”.

(iii) Names of all instructors having salary greater than average salary of Civil Dept
Query
SELECT name, dept_name, salary
FROM instructor
WHERE salary > (
    SELECT AVG(salary)
    FROM instructor
    WHERE dept_name = 'Civil'
);

Output
name	dept_name	salary
Dr. Shree Mehta	Computer	60000.00
Dr. Sharma	Computer	55000.00
Dr. Nikhil	Mechanical	40000.00
Dr. Shreeja	Computer	62000.00

Explanation:
The average salary of the Civil department is 45,000. The query selects all instructors earning more than this value.

(iv) Set of all courses taught in Fifth sem 2014 or First sem 2010 or both
Query
SELECT DISTINCT course_id
FROM teaches
WHERE (semester = 'Fifth' AND year = 2014)
   OR (semester = 'First' AND year = 2010);

Output
course_id
201
202
203
204

Explanation:
The query retrieves distinct course_ids that were taught in either the Fifth semester of 2014, the First semester of 2010, or both.

*/
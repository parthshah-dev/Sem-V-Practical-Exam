-- =====================================================
-- PL/SQL Program: Student Grade Categorization
-- =====================================================

-- Step 1: Create tables
CREATE TABLE Stud_Marks (
    RollNo      NUMBER PRIMARY KEY,
    Name        VARCHAR2(50),
    Total_Marks NUMBER
);

CREATE TABLE Result (
    RollNo NUMBER,
    Name   VARCHAR2(50),
    Class  VARCHAR2(30)
);

-- Step 2: Insert sample data
INSERT INTO Stud_Marks VALUES (1, 'Rahul', 1450);
INSERT INTO Stud_Marks VALUES (2, 'Neha', 950);
INSERT INTO Stud_Marks VALUES (3, 'Amit', 880);
INSERT INTO Stud_Marks VALUES (4, 'Suresh', 820);
INSERT INTO Stud_Marks VALUES (5, 'Priya', 780);
COMMIT;

-- Step 3: Create Stored Procedure
CREATE OR REPLACE PROCEDURE proc_Grade IS
    v_class VARCHAR2(30);
BEGIN
    FOR rec IN (SELECT RollNo, Name, Total_Marks FROM Stud_Marks) LOOP
        -- Categorize student based on marks
        IF rec.Total_Marks BETWEEN 990 AND 1500 THEN
            v_class := 'Distinction';
        ELSIF rec.Total_Marks BETWEEN 900 AND 989 THEN
            v_class := 'First Class';
        ELSIF rec.Total_Marks BETWEEN 825 AND 899 THEN
            v_class := 'Higher Second Class';
        ELSE
            v_class := 'Fail';
        END IF;

        -- Insert results into Result table
        INSERT INTO Result (RollNo, Name, Class)
        VALUES (rec.RollNo, rec.Name, v_class);
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('✅ Student Grades Processed Successfully.');
END;
/
-- Step 4: Execute the procedure
BEGIN
    proc_Grade;
END;
/

-- Step 5: Display final results
SELECT * FROM Result;


/*

PL/SQL Practical — Student Grade Categorization

Theory (1–1.5 paragraphs)
This PL/SQL program reads student marks from a table, classifies each student into a grade category using conditional logic, and stores the results in another table. The procedure proc_Grade loops over all records in Stud_Marks, uses IF / ELSIF / ELSE to decide the class (Distinction, First Class, Higher Second Class, Fail) based on the Total_Marks ranges, inserts the classification into the Result table, commits the transaction, and reports completion via DBMS_OUTPUT. This demonstrates cursor-for-loop processing, conditional branching, DML inside PL/SQL, and use of a stored procedure to encapsulate repeatable business logic.

Key syntax (procedure + execution)
CREATE OR REPLACE PROCEDURE proc_Grade IS
  v_class VARCHAR2(30);
BEGIN
  FOR rec IN (SELECT RollNo, Name, Total_Marks FROM Stud_Marks) LOOP
    IF rec.Total_Marks BETWEEN 990 AND 1500 THEN
      v_class := 'Distinction';
    ELSIF rec.Total_Marks BETWEEN 900 AND 989 THEN
      v_class := 'First Class';
    ELSIF rec.Total_Marks BETWEEN 825 AND 899 THEN
      v_class := 'Higher Second Class';
    ELSE
      v_class := 'Fail';
    END IF;

    INSERT INTO Result (RollNo, Name, Class)
    VALUES (rec.RollNo, rec.Name, v_class);
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('✅ Student Grades Processed Successfully.');
END;
/


To execute:

BEGIN
  proc_Grade;
END;
/

Input statements (already in your script)
CREATE TABLE Stud_Marks (
  RollNo      NUMBER PRIMARY KEY,
  Name        VARCHAR2(50),
  Total_Marks NUMBER
);

CREATE TABLE Result (
  RollNo NUMBER,
  Name   VARCHAR2(50),
  Class  VARCHAR2(30)
);

INSERT INTO Stud_Marks VALUES (1, 'Rahul', 1450);
INSERT INTO Stud_Marks VALUES (2, 'Neha', 950);
INSERT INTO Stud_Marks VALUES (3, 'Amit', 880);
INSERT INTO Stud_Marks VALUES (4, 'Suresh', 820);
INSERT INTO Stud_Marks VALUES (5, 'Priya', 780);
COMMIT;

Expected output

On procedure execution (DBMS_OUTPUT):

✅ Student Grades Processed Successfully.


Result table (SELECT * FROM Result):

ROWNUM	ROLLNO	NAME	CLASS
1	1	Rahul	Distinction
2	2	Neha	First Class
3	3	Amit	Higher Second Class
4	4	Suresh	Fail
5	5	Priya	Fail

(Exact ordering may vary; rows above reflect each inserted student and their computed class.)

*/
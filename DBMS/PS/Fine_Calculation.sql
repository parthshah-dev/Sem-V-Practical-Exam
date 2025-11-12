-- =====================================================
-- PL/SQL Program: Library Fine Calculation
-- =====================================================

-- Step 1: Create required tables (run once only)
CREATE TABLE Borrower (
    Roll_no     NUMBER PRIMARY KEY,
    Name        VARCHAR2(50),
    DateofIssue DATE,
    NameofBook  VARCHAR2(50),
    Status      CHAR(1)
);

CREATE TABLE Fine (
    Roll_no   NUMBER,
    FineDate  DATE,
    Amt       NUMBER
);

-- Step 2: Insert sample data
INSERT INTO Borrower VALUES (1, 'Rahul', SYSDATE - 20, 'DBMS', 'I');
INSERT INTO Borrower VALUES (2, 'Neha', SYSDATE - 10, 'OS', 'I');
INSERT INTO Borrower VALUES (3, 'Amit', SYSDATE - 40, 'CN', 'I');
COMMIT;

-- Step 3: Enable output and disable verify
SET SERVEROUTPUT ON;
SET VERIFY OFF;

-- Step 4: Accept user input
ACCEPT v_roll NUMBER PROMPT 'Enter Roll Number: '
ACCEPT v_book CHAR PROMPT 'Enter Book Name: '

-- Step 5: Fine calculation block
DECLARE
    v_rollno      NUMBER := &v_roll;
    v_bookname    VARCHAR2(50) := '&v_book';
    v_dateissue   DATE;
    v_days        NUMBER;
    v_fine        NUMBER := 0;
BEGIN
    -- Fetch date of issue for entered roll number and book
    SELECT DateofIssue INTO v_dateissue
    FROM Borrower
    WHERE Roll_no = v_rollno
      AND NameofBook = v_bookname
      AND Status = 'I';

    -- Calculate number of days between issue and today
    v_days := TRUNC(SYSDATE - v_dateissue);

    -- Fine logic
    IF v_days <= 15 THEN
        v_fine := 0;
    ELSIF v_days > 15 AND v_days <= 30 THEN
        v_fine := (v_days - 15) * 5;
    ELSE
        v_fine := (15 * 5) + ((v_days - 30) * 50);
    END IF;

    -- Update borrower status to 'R' (Returned)
    UPDATE Borrower
    SET Status = 'R'
    WHERE Roll_no = v_rollno
      AND NameofBook = v_bookname;

    -- Insert fine details if fine > 0
    IF v_fine > 0 THEN
        INSERT INTO Fine (Roll_no, FineDate, Amt)
        VALUES (v_rollno, SYSDATE, v_fine);
    END IF;

    COMMIT;

    -- Display results
    DBMS_OUTPUT.PUT_LINE('Book Returned Successfully.');
    DBMS_OUTPUT.PUT_LINE('Days Kept: ' || v_days);
    DBMS_OUTPUT.PUT_LINE('Fine Amount: Rs. ' || v_fine);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No matching record found for given Roll No. and Book Name.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


/*

PL/SQL Program: Library Fine Calculation

Theory:
This PL/SQL program automates the library fine calculation process for students based on the number of days a book has been issued. It uses data retrieval, conditional logic, DML operations, and exception handling in PL/SQL. The Borrower table keeps records of issued books, while the Fine table stores fine details. The program calculates fines according to predefined conditions, updates the borrower’s status to ‘R’ (Returned), and inserts a record in the fine table if applicable. Using variables, user input, and conditional statements, this program demonstrates core PL/SQL concepts like control flow, data manipulation, and error handling.

Step 1: Table Creation
CREATE TABLE Borrower (
    Roll_no     NUMBER PRIMARY KEY,
    Name        VARCHAR2(50),
    DateofIssue DATE,
    NameofBook  VARCHAR2(50),
    Status      CHAR(1)
);

CREATE TABLE Fine (
    Roll_no   NUMBER,
    FineDate  DATE,
    Amt       NUMBER
);

Step 2: Insert Sample Data
INSERT INTO Borrower VALUES (1, 'Rahul', SYSDATE - 20, 'DBMS', 'I');
INSERT INTO Borrower VALUES (2, 'Neha', SYSDATE - 10, 'OS', 'I');
INSERT INTO Borrower VALUES (3, 'Amit', SYSDATE - 40, 'CN', 'I');
COMMIT;

Step 3: Fine Calculation PL/SQL Block
SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT v_roll NUMBER PROMPT 'Enter Roll Number: '
ACCEPT v_book CHAR PROMPT 'Enter Book Name: '

DECLARE
    v_rollno      NUMBER := &v_roll;
    v_bookname    VARCHAR2(50) := '&v_book';
    v_dateissue   DATE;
    v_days        NUMBER;
    v_fine        NUMBER := 0;
BEGIN
    SELECT DateofIssue INTO v_dateissue
    FROM Borrower
    WHERE Roll_no = v_rollno
      AND NameofBook = v_bookname
      AND Status = 'I';

    v_days := TRUNC(SYSDATE - v_dateissue);

    IF v_days <= 15 THEN
        v_fine := 0;
    ELSIF v_days > 15 AND v_days <= 30 THEN
        v_fine := (v_days - 15) * 5;
    ELSE
        v_fine := (15 * 5) + ((v_days - 30) * 50);
    END IF;

    UPDATE Borrower
    SET Status = 'R'
    WHERE Roll_no = v_rollno
      AND NameofBook = v_bookname;

    IF v_fine > 0 THEN
        INSERT INTO Fine (Roll_no, FineDate, Amt)
        VALUES (v_rollno, SYSDATE, v_fine);
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Book Returned Successfully.');
    DBMS_OUTPUT.PUT_LINE('Days Kept: ' || v_days);
    DBMS_OUTPUT.PUT_LINE('Fine Amount: Rs. ' || v_fine);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No matching record found for given Roll No. and Book Name.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

Sample Input
Enter Roll Number: 1
Enter Book Name: DBMS

Expected Output
Book Returned Successfully.
Days Kept: 20
Fine Amount: Rs. 25

Explanation:

The book was kept for 20 days.

The first 15 days are free.

Remaining 5 days × ₹5 = ₹25 fine.

The status is updated to 'R' and fine details are inserted into the Fine table.

Contents of Fine Table (After Execution)
Roll_no	FineDate	Amt
1	11-NOV-2025	25

*/
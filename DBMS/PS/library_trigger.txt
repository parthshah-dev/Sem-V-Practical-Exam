-- =====================================================
-- PL/SQL Program: Trigger on Library Table
-- =====================================================

-- Step 1: Create main Library table
CREATE TABLE Library (
    BookID   NUMBER PRIMARY KEY,
    Title    VARCHAR2(100),
    Author   VARCHAR2(50),
    Price    NUMBER
);

-- Step 2: Create Audit table to record changes
CREATE TABLE Library_Audit (
    AuditID    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    BookID     NUMBER,
    Title      VARCHAR2(100),
    Author     VARCHAR2(50),
    Price      NUMBER,
    ActionType VARCHAR2(30),
    ActionDate DATE
);

-- Step 3: Create Trigger
CREATE OR REPLACE TRIGGER trg_Library_Audit
AFTER INSERT OR UPDATE OR DELETE
ON Library
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Library_Audit (BookID, Title, Author, Price, ActionType, ActionDate)
        VALUES (:NEW.BookID, :NEW.Title, :NEW.Author, :NEW.Price, 'INSERT', SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO Library_Audit (BookID, Title, Author, Price, ActionType, ActionDate)
        VALUES (:NEW.BookID, :NEW.Title, :NEW.Author, :NEW.Price, 'UPDATE', SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO Library_Audit (BookID, Title, Author, Price, ActionType, ActionDate)
        VALUES (:OLD.BookID, :OLD.Title, :OLD.Author, :OLD.Price, 'DELETE', SYSDATE);
    END IF;
END;
/
-- Step 4: Insert Sample Data to test trigger
INSERT INTO Library VALUES (1, 'Database Systems', 'Navathe', 550);
INSERT INTO Library VALUES (2, 'Operating Systems', 'Galvin', 650);
COMMIT;

-- Step 5: Perform Update and Delete operations
UPDATE Library SET Price = 600 WHERE BookID = 1;
DELETE FROM Library WHERE BookID = 2;
COMMIT;

-- Step 6: Display Records
SELECT * FROM Library;
SELECT * FROM Library_Audit;


/*
PL/SQL Program: Trigger on Library Table

Theory:
This PL/SQL program demonstrates the use of a trigger to maintain an audit trail of all data modifications (INSERT, UPDATE, DELETE) performed on a table. The trigger trg_Library_Audit fires automatically whenever a record in the Library table is inserted, updated, or deleted. It inserts corresponding details into the Library_Audit table along with the action type and timestamp. This ensures that any change in the Library table is recorded for accountability and data integrity. Triggers like these are widely used in enterprise systems for change tracking, logging, and compliance purposes.

Step 1: Create Main Library Table
CREATE TABLE Library (
    BookID   NUMBER PRIMARY KEY,
    Title    VARCHAR2(100),
    Author   VARCHAR2(50),
    Price    NUMBER
);

Step 2: Create Audit Table
CREATE TABLE Library_Audit (
    AuditID    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    BookID     NUMBER,
    Title      VARCHAR2(100),
    Author     VARCHAR2(50),
    Price      NUMBER,
    ActionType VARCHAR2(30),
    ActionDate DATE
);

Step 3: Create Trigger
CREATE OR REPLACE TRIGGER trg_Library_Audit
AFTER INSERT OR UPDATE OR DELETE
ON Library
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Library_Audit (BookID, Title, Author, Price, ActionType, ActionDate)
        VALUES (:NEW.BookID, :NEW.Title, :NEW.Author, :NEW.Price, 'INSERT', SYSDATE);

    ELSIF UPDATING THEN
        INSERT INTO Library_Audit (BookID, Title, Author, Price, ActionType, ActionDate)
        VALUES (:NEW.BookID, :NEW.Title, :NEW.Author, :NEW.Price, 'UPDATE', SYSDATE);

    ELSIF DELETING THEN
        INSERT INTO Library_Audit (BookID, Title, Author, Price, ActionType, ActionDate)
        VALUES (:OLD.BookID, :OLD.Title, :OLD.Author, :OLD.Price, 'DELETE', SYSDATE);
    END IF;
END;
/

Step 4: Insert Sample Data
INSERT INTO Library VALUES (1, 'Database Systems', 'Navathe', 550);
INSERT INTO Library VALUES (2, 'Operating Systems', 'Galvin', 650);
COMMIT;

Step 5: Perform Update and Delete Operations
UPDATE Library SET Price = 600 WHERE BookID = 1;
DELETE FROM Library WHERE BookID = 2;
COMMIT;

Step 6: Display Records
SELECT * FROM Library;
SELECT * FROM Library_Audit;

Expected Output
Library Table
BookID	Title	Author	Price
1	Database Systems	Navathe	600
Library_Audit Table
AuditID	BookID	Title	Author	Price	ActionType	ActionDate
1	1	Database Systems	Navathe	550	INSERT	2025-11-12 17:00:00
2	2	Operating Systems	Galvin	650	INSERT	2025-11-12 17:00:00
3	1	Database Systems	Navathe	600	UPDATE	2025-11-12 17:05:00
4	2	Operating Systems	Galvin	650	DELETE	2025-11-12 17:06:00

*/
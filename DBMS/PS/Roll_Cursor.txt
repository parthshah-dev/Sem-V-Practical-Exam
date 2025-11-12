-- =====================================================
-- PL/SQL Program: Demonstrating All Cursor Types
-- =====================================================

-- Step 1: Create base tables
CREATE TABLE N_RollCall (
    RollNo NUMBER PRIMARY KEY,
    Name   VARCHAR2(30),
    Status VARCHAR2(10)
);

CREATE TABLE O_RollCall (
    RollNo NUMBER PRIMARY KEY,
    Name   VARCHAR2(30),
    Status VARCHAR2(10)
);

-- Step 2: Insert sample data
INSERT ALL
    INTO N_RollCall VALUES (1, 'Rahul', 'Present')
    INTO N_RollCall VALUES (2, 'Amit',  'Absent')
    INTO N_RollCall VALUES (3, 'Suresh','Present')
    INTO N_RollCall VALUES (4, 'Neha',  'Present')
SELECT * FROM dual;

INSERT ALL
    INTO O_RollCall VALUES (1, 'Rahul', 'Present')
    INTO O_RollCall VALUES (2, 'Amit',  'Absent')
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Demonstration of All Cursor Types
-- =====================================================
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('   CURSOR TYPES DEMONSTRATION  ');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    -- 1️⃣ Implicit Cursor Example
    DBMS_OUTPUT.PUT_LINE('1. IMPLICIT CURSOR:');
    UPDATE N_RollCall SET Status = 'Updated' WHERE RollNo = 1;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('   Rows updated successfully using Implicit Cursor.');
    END IF;

    -- 2️⃣ Explicit Cursor Example
    DBMS_OUTPUT.PUT_LINE('2. EXPLICIT CURSOR:');
    DECLARE
        CURSOR c_explicit IS SELECT RollNo, Name FROM N_RollCall;
        v_roll N_RollCall.RollNo%TYPE;
        v_name N_RollCall.Name%TYPE;
    BEGIN
        OPEN c_explicit;
        LOOP
            FETCH c_explicit INTO v_roll, v_name;
            EXIT WHEN c_explicit%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('   RollNo: ' || v_roll || ' | Name: ' || v_name);
        END LOOP;
        CLOSE c_explicit;
    END;

    -- 3️⃣ Cursor FOR Loop Example
    DBMS_OUTPUT.PUT_LINE('3. CURSOR FOR LOOP:');
    FOR rec IN (SELECT RollNo, Name FROM N_RollCall)
    LOOP
        DBMS_OUTPUT.PUT_LINE('   RollNo: ' || rec.RollNo || ' | Name: ' || rec.Name);
    END LOOP;

    -- 4️⃣ Parameterized Cursor Example (Merge Data)
    DBMS_OUTPUT.PUT_LINE('4. PARAMETERIZED CURSOR (Merging Data):');

    DECLARE
        CURSOR c_param(p_roll NUMBER) IS
            SELECT RollNo, Name, Status FROM N_RollCall WHERE RollNo = p_roll;
        v_rec N_RollCall%ROWTYPE;
    BEGIN
        FOR rec IN (SELECT RollNo FROM N_RollCall)
        LOOP
            OPEN c_param(rec.RollNo);
            FETCH c_param INTO v_rec;
            IF v_rec.RollNo IS NOT NULL THEN
                BEGIN
                    INSERT INTO O_RollCall
                    SELECT v_rec.RollNo, v_rec.Name, v_rec.Status
                    FROM dual
                    WHERE NOT EXISTS (
                        SELECT 1 FROM O_RollCall o WHERE o.RollNo = v_rec.RollNo
                    );
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                        DBMS_OUTPUT.PUT_LINE('   Skipping duplicate RollNo: ' || v_rec.RollNo);
                END;
            END IF;
            CLOSE c_param;
        END LOOP;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('   Merge operation completed successfully.');
    END;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('All Cursor Examples Executed Successfully.');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
END;
/


/*
-- =====================================================
-- PL/SQL Program: Demonstrating All Cursor Types
-- =====================================================

-- Step 1: Create base tables
CREATE TABLE N_RollCall (
    RollNo NUMBER PRIMARY KEY,
    Name   VARCHAR2(30),
    Status VARCHAR2(10)
);

CREATE TABLE O_RollCall (
    RollNo NUMBER PRIMARY KEY,
    Name   VARCHAR2(30),
    Status VARCHAR2(10)
);

-- Step 2: Insert sample data
INSERT ALL
    INTO N_RollCall VALUES (1, 'Rahul', 'Present')
    INTO N_RollCall VALUES (2, 'Amit',  'Absent')
    INTO N_RollCall VALUES (3, 'Suresh','Present')
    INTO N_RollCall VALUES (4, 'Neha',  'Present')
SELECT * FROM dual;

INSERT ALL
    INTO O_RollCall VALUES (1, 'Rahul', 'Present')
    INTO O_RollCall VALUES (2, 'Amit',  'Absent')
SELECT * FROM dual;

COMMIT;

-- =====================================================
-- Demonstration of All Cursor Types
-- =====================================================
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('   CURSOR TYPES DEMONSTRATION  ');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    -- 1️⃣ Implicit Cursor Example
    DBMS_OUTPUT.PUT_LINE('1. IMPLICIT CURSOR:');
    UPDATE N_RollCall SET Status = 'Updated' WHERE RollNo = 1;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('   Rows updated successfully using Implicit Cursor.');
    END IF;

    -- 2️⃣ Explicit Cursor Example
    DBMS_OUTPUT.PUT_LINE('2. EXPLICIT CURSOR:');
    DECLARE
        CURSOR c_explicit IS SELECT RollNo, Name FROM N_RollCall;
        v_roll N_RollCall.RollNo%TYPE;
        v_name N_RollCall.Name%TYPE;
    BEGIN
        OPEN c_explicit;
        LOOP
            FETCH c_explicit INTO v_roll, v_name;
            EXIT WHEN c_explicit%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('   RollNo: ' || v_roll || ' | Name: ' || v_name);
        END LOOP;
        CLOSE c_explicit;
    END;

    -- 3️⃣ Cursor FOR Loop Example
    DBMS_OUTPUT.PUT_LINE('3. CURSOR FOR LOOP:');
    FOR rec IN (SELECT RollNo, Name FROM N_RollCall)
    LOOP
        DBMS_OUTPUT.PUT_LINE('   RollNo: ' || rec.RollNo || ' | Name: ' || rec.Name);
    END LOOP;

    -- 4️⃣ Parameterized Cursor Example (Merge Data)
    DBMS_OUTPUT.PUT_LINE('4. PARAMETERIZED CURSOR (Merging Data):');

    DECLARE
        CURSOR c_param(p_roll NUMBER) IS
            SELECT RollNo, Name, Status FROM N_RollCall WHERE RollNo = p_roll;
        v_rec N_RollCall%ROWTYPE;
    BEGIN
        FOR rec IN (SELECT RollNo FROM N_RollCall)
        LOOP
            OPEN c_param(rec.RollNo);
            FETCH c_param INTO v_rec;
            IF v_rec.RollNo IS NOT NULL THEN
                BEGIN
                    INSERT INTO O_RollCall
                    SELECT v_rec.RollNo, v_rec.Name, v_rec.Status
                    FROM dual
                    WHERE NOT EXISTS (
                        SELECT 1 FROM O_RollCall o WHERE o.RollNo = v_rec.RollNo
                    );
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                        DBMS_OUTPUT.PUT_LINE('   Skipping duplicate RollNo: ' || v_rec.RollNo);
                END;
            END IF;
            CLOSE c_param;
        END LOOP;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('   Merge operation completed successfully.');
    END;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('All Cursor Examples Executed Successfully.');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
END;
/

*/
CREATE OR REPLACE TRIGGER check_unique_id
BEFORE INSERT ON STUDENTS
FOR EACH ROW
DECLARE
    existing_id NUMBER;
BEGIN
    SELECT 1 INTO existing_id
    FROM STUDENTS
    WHERE ID = :NEW.ID;
    IF existing_id IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'STUDENT WITH THIS ID ALREADY EXISTS');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_unique_id_groups
BEFORE INSERT ON GROUPS
FOR EACH ROW
DECLARE
    existing_id NUMBER;
BEGIN
    SELECT 1 INTO existing_id
    FROM GROUPS
    WHERE ID = :NEW.ID;

    IF existing_id IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'GROUP WITH THIS ID ALREADY EXISTS');
    END IF;
END;
/

CREATE SEQUENCE STUDENTS_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER generate_student_id
BEFORE INSERT ON STUDENTS
FOR EACH ROW
BEGIN
    :NEW.ID := STUDENTS_SEQ.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER check_unique_group_name
BEFORE INSERT ON GROUPS
FOR EACH ROW
DECLARE
    existing_name NUMBER;
BEGIN
    SELECT 1 INTO existing_name
    FROM GROUPS
    WHERE NAME = :NEW.NAME;

    IF existing_name IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'GROUP WITH THIS NAME ALREADY EXISTS');
    END IF;
END;
/

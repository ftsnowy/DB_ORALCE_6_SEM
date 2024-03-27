CREATE OR REPLACE TRIGGER trigger_unique_id_students
BEFORE INSERT ON STUDENTS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM STUDENTS
    WHERE ID = :NEW.ID;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'STUDENT ID MUST BE UNIQUE');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trigger_unique_id_groups
BEFORE INSERT ON GROUPS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM GROUPS
    WHERE ID = :NEW.ID;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'GROUP ID MUST BE UNIQUE');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trigger_autoincrement_students_id
BEFORE INSERT ON STUDENTS
FOR EACH ROW
DECLARE
    v_id NUMBER;
BEGIN
    IF :NEW.ID IS NULL THEN
    
        SELECT MAX(ID)
        INTO v_id
        FROM STUDENTS;
        
        IF v_id IS NULL THEN
            :NEW.ID :=1;
        ELSE
            :NEW.ID :=v_id + 1;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trigger_autoincrement_groups_id
BEFORE INSERT ON GROUPS
FOR EACH ROW
DECLARE
    v_id NUMBER;
BEGIN
    IF :NEW.ID IS NULL THEN
    
        SELECT MAX(ID)
        INTO v_id
        FROM GROUPS;
        
        IF v_id IS NULL THEN
            :NEW.ID :=1;
        ELSE
            :NEW.ID :=v_id + 1;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trigger_unique_groups_name
BEFORE INSERT OR UPDATE ON GROUPS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF UPDATING AND :OLD.NAME = :NEW.NAME THEN
        RETURN;
    END IF;
    
    SELECT COUNT(*)
    INTO v_count
    FROM GROUPS
    WHERE NAME = :NEW.NAME;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'GROUPS WITH THIS ID ALREADY EXISTS');
    END IF;
END;
/
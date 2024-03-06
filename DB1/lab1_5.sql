CREATE OR REPLACE PROCEDURE insert_into_mytable(
    p_id IN NUMBER,
    p_val IN NUMBER
)
IS
BEGIN
    INSERT INTO MyTable (id, val) VALUES (p_id, p_val);
    DBMS_OUTPUT.PUT_LINE('New record added');
END;
/
CREATE OR REPLACE PROCEDURE update_mytable(
    p_id IN NUMBER,
    p_new_val IN NUMBER
)
IS
BEGIN
    UPDATE MyTable SET val = p_new_val WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('The record was updated');
END;
/
CREATE OR REPLACE PROCEDURE delete_from_mytable(
    p_id IN NUMBER
)
IS
BEGIN
    DELETE FROM MyTable WHERE id = p_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('The record was removed');
END;
/
BEGIN
insert_into_mytable(10001, 23);
END;
/
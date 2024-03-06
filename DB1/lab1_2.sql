DECLARE
    var_id NUMBER;
    var_val NUMBER;
BEGIN
    FOR i IN 1..10000 LOOP
        var_id := i;
        var_val := ROUND(DBMS_RANDOM.VALUE(1, 100));

        INSERT INTO MyTable (id, val) VALUES (var_id, var_val);
    END LOOP;
END;
/
Select * from MyTable ORDER BY id;  
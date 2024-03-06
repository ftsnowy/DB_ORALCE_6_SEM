DECLARE
  v_id NUMBER;
  v_val NUMBER;
BEGIN
  FOR i IN 1..10000 LOOP

    v_id := DBMS_RANDOM.VALUE(1, 10000);
    v_val := DBMS_RANDOM.VALUE;

    INSERT INTO MyTable (id, val) VALUES (ROUND(v_id), v_val);
  END LOOP;
  
  COMMIT; 
END;
/
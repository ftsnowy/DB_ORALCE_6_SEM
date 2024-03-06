CREATE OR REPLACE Procedure GenerateInsertStatement(p_id NUMBER)
IS
  v_val NUMBER;
  v_insert_statement VARCHAR2(100);
BEGIN

  v_val := ROUND(DBMS_RANDOM.VALUE(1, 100));

  v_insert_statement := 'INSERT INTO MyTable (id, val) VALUES (' || p_id || ', ' || v_val || ');';
  DBMS_OUTPUT.PUT_LINE(v_insert_statement);
END;
/
DECLARE
  input_id NUMBER := 897; 
BEGIN
  GenerateInsertStatement(input_id);
END;
/

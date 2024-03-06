CREATE OR REPLACE FUNCTION CheckEvenOddCount
RETURN VARCHAR2
IS
  v_even_count NUMBER := 0;
  v_odd_count NUMBER := 0;
BEGIN

  SELECT COUNT(*) INTO v_even_count FROM MyTable WHERE MOD(val, 2) = 0;
  SELECT COUNT(*) INTO v_odd_count FROM MyTable WHERE MOD(val, 2) <> 0;


  IF v_even_count > v_odd_count THEN
    RETURN 'TRUE';
  ELSIF v_odd_count > v_even_count THEN
    RETURN 'FALSE';
  ELSE
    RETURN 'EQUAL';
  END IF;
END;
/
DECLARE
    v_result VARCHAR2(10);
BEGIN
    v_result := CheckEvenOddCount();
    DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
END;
/

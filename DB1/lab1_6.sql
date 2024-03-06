CREATE OR REPLACE FUNCTION calculate_annual_compensation(
    p_monthly_salary IN NUMBER,
    p_annual_bonus_rate IN NUMBER
) RETURN NUMBER
IS
    v_annual_reward NUMBER;
BEGIN
    IF p_monthly_salary <= 0 OR p_annual_bonus_rate < 0 OR p_annual_bonus_rate > 100 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Incorrect input values');
    END IF;
    
    v_annual_reward := (1 + p_annual_bonus_rate / 100) * 12 * p_monthly_salary;
    
    RETURN v_annual_reward;
END;
/

DECLARE
    v_annual_reward NUMBER;
BEGIN
    v_annual_reward := calculate_annual_compensation('abc', -11);
    DBMS_OUTPUT.PUT_LINE('Total annual reward: ' || v_annual_reward);
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('??????: ' ||  SQLERRM);
END;
/

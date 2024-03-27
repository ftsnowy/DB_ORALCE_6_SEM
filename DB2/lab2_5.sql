CREATE OR REPLACE PROCEDURE restore_students_log(
    target_timestamp TIMESTAMP,
    offset_interval INTERVAL DAY TO SECOND DEFAULT NULL
)
IS
    v_target_date TIMESTAMP;
BEGIN
    
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRIGGER_UNIQUE_ID_STUDENTS DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRIGGER_STUDENTS_LOGGING DISABLE';

    IF offset_interval IS NOT NULL THEN
        v_target_date := SYSTIMESTAMP - offset_interval;
    ELSE
        v_target_date := target_timestamp;
    END IF;

    FOR log_rec IN (
        SELECT * FROM STUDENTS_LOG
        WHERE ACTION_DATE >= v_target_date
        ORDER BY ACTION_DATE DESC, LOG_ID DESC )
    LOOP
        IF log_rec.ACTION_TYPE = 'INSERT' THEN
            DELETE FROM STUDENTS
            WHERE ID = log_rec.NEW_STUDENT_ID;
        ELSIF log_rec.ACTION_TYPE = 'UPDATE' THEN
            UPDATE STUDENTS
            SET NAME = log_rec.OLD_NAME, GROUP_ID = log_rec.OLD_GROUP_ID
            WHERE ID = log_rec.OLD_STUDENT_ID;
        ELSIF log_rec.ACTION_TYPE = 'DELETE' THEN
            INSERT INTO STUDENTS (id, name, group_id)
            VALUES (log_rec.OLD_STUDENT_ID, log_rec.OLD_NAME, log_rec.OLD_GROUP_ID);
        END IF;
    END LOOP;
    
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRIGGER_UNIQUE_ID_STUDENTS ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRIGGER_STUDENTS_LOGGING ENABLE';
END;
/

BEGIN
    restore_students_log(TO_TIMESTAMP('2024-03-27 18:10:00', 'YYYY-MM-DD HH24:MI:SS'));
END;
/
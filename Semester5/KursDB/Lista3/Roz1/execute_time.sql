CREATE OR ALTER PROCEDURE EXECUTE_TIME
AS 
    BEGIN;
        DECLARE
            @cursor_time FLOAT,
            @insert_time FLOAT,
            @start TIME,
            @end TIME;
        
        SET @start=CURRENT_TIMESTAMP;
        EXEC CURSOR_BACK_UP
        SET @end = CURRENT_TIMESTAMP;

        SET @cursor_time = DATEDIFF(s, @start, @end)


        SET @start=CURRENT_TIMESTAMP;
        EXEC INSERT_BACK_UP
        SET @end = CURRENT_TIMESTAMP;

        SET @insert_time = DATEDIFF(s, @start, @end)
        
        SELECT @cursor_time, @insert_time;
    END;

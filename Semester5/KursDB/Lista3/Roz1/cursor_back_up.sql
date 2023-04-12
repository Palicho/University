

-- PROCEDURA KOPIUJĄCA ZA POMOCA CURSOR
CREATE OR ALTER PROCEDURE CURSOR_BACK_UP
AS
	BEGIN;
        -- TWORZENIE TABLICY Z BACKUP'EM
		DROP TABLE IF EXISTS _Backup;
		CREATE TABLE _Backup(
            Name VARCHAR(MAX),
			ProductNumber VARCHAR(MAX)
		);


		DECLARE 
			@p_name VARCHAR(MAX),
			@p_number VARCHAR(MAX);

		DECLARE back_up CURSOR 
		FOR
			SELECT 
				P.Name, 
				P.ProductNumber
			FROM [SalesLT].[Product] as P;

		OPEN back_up;

		FETCH NEXT FROM back_up INTO
			@p_name,
			@p_number;


		WHILE @@FETCH_STATUS = 0
			BEGIN;
				INSERT INTO _Backup(Name, ProductNumber)
					VALUES(
						@p_name,
						@p_number);
						
				FETCH NEXT FROM back_up INTO
					@p_name,
					@p_number;
			END;

		CLOSE back_up;

		DEALLOCATE back_up;
	

	END;

---


CREATE OR ALTER PROCEDURE  INSERT_BACK_UP
AS
	BEGIN;
	-- TWORZENIE TABLICY Z BACKUP'EM

	DROP TABLE IF EXISTS _Backup;
	CREATE TABLE _Backup(
		Name VARCHAR(MAX),
		ProductNumber VARCHAR(MAX)
	);


	INSERT INTO [dbo].[_Backup](name, ProductNumber)
		SELECT 
			Name, 
			ProductNumber
		FROM 
			[SalesLT].[Product];

	END;
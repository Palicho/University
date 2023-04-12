DROP TABLE IF EXISTS firstnames;

CREATE TABLE firstnames (
	ID INT PRIMARY KEY,
	Firstname VARCHAR(20)
);
GO;


DROP TABLE IF EXISTS lastnames;

CREATE TABLE lastnames(
	ID INT PRIMARY KEY,
	Lastname varchar(20)
);
GO;

DROP TABLE IF EXISTS fldata;

CREATE TABLE fldata(
	Firstname varchar(20) ,
	Lastname varchar(20) ,
	PRIMARY KEY (Firstname, Lastname)
);

GO;

-- INSERTS



-- procedure

DROP PROCEDURE IF EXISTS roz2;
GO;

CREATE PROCEDURE roz2
	@n INT
AS
	BEGIN;
		DECLARE
			@i INT,
			@num_fnames INT,
			@num_lnames INT;

		SET @i = 0;

		SELECT
			@num_fnames=COUNT(*) 
		FROM [dbo].[firstnames];

		SELECT 
			@num_lnames=COUNT(*) 
		FROM [dbo].[lastnames];

		
		IF ( ( @num_fnames * @num_lnames)/2 <= @n)
			BEGIN;
				THROW 50001, 'n przekracza liczbe mozliwych par', 1;
			END;
		ELSE
			BEGIN;
				DECLARE
					@fname varchar(20),
					@lname varchar(20);
				

				WHILE( @i<@n)
					BEGIN;
						SELECT TOP 1
							@fname=[dbo].[firstnames].Firstname FROM [dbo].[firstnames] ORDER BY NEWID();
						SELECT TOP 1
							@lname=[dbo].[lastnames].Lastname FROM [dbo].[lastnames] ORDER BY NEWID();
					IF NOT EXISTS (SELECT * FROM fldata WHERE [dbo].[fldata].Firstname= @fname AND [dbo].[fldata].Lastname = @lname)
						BEGIN;
							INSERT INTO fldata(Firstname, Lastname)
								VALUES(
									@fname,
									@lname
								)
							SET @i = @i +1
						END;
					END;
			SELECT * FROM [dbo].[fldata];
			END;
END;


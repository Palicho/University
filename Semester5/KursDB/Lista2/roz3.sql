DROP PROCEDURE IF EXISTS roz3;
GO;

CREATE PROCEDURE roz3
	@PESEL CHAR(11),
	@Nazwisko VARCHAR(30),
	@Miasto VARCHAR(30),
	@Data_Urodzenia char(10)
AS
	BEGIN;
	IF (@PESEL NOT LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
		BEGIN;
			THROW 50011, 'Pesel powinien skladac sie z samych liczb',2;
		END;
	IF (NOT  SUBSTRING(@Nazwisko,1,1) = UPPER(SUBSTRING(@Nazwisko,1,1))) OR LEN(@Nazwisko)<2
		BEGIN;
			THROW 50012, 'Nazwisko powinno zaczynac sie z wielkiej litery oraz zawierac wiecej niz 2 litery',2;
		END;
	IF ISDATE(@Data_Urodzenia) =0
		BEGIN;
			THROW 50013, 'Zły format daty',1;
		END;
  	
	  INSERT INTO [dbo].[Czytelnik](
	  	PESEL,
		Nazwisko,
		Miasto,
		Data_Urodzenia)
	  	Values(
		  @PESEL,
		  @Nazwisko,
		  @Miasto,
		  CAST(@Data_Urodzenia AS DATE)
		);


	END;

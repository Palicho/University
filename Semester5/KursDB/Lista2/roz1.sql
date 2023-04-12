DROP PROCEDURE  IF EXISTS roz1;
GO

CREATE PROCEDURE roz1 
    @Dni INT
AS
    SELECT 
        [dbo].[Czytelnik].PESEL,
        COUNT(*) 
    FROM 
        [dbo].[Wypozyczenie] 
        INNER JOIN [dbo].[Czytelnik] ON [dbo].[Czytelnik].Czytelnik_ID = [dbo].[Wypozyczenie].Czytelnik_ID 
    WHERE [dbo].[Wypozyczenie].Liczba_Dni >= @DNI 
GROUP BY [dbo].[Czytelnik].PESEL;
GO
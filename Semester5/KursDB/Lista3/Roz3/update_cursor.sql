DECLARE
	@pricePLN FLOAT,
	@currency VARCHAR(20),
	@price FLOAT,
	@productID INT,
	@exchange FLOAT;

DECLARE update_prices CURSOR DYNAMIC
FOR
	SELECT 
		ProductID,
		Currency,
		Price
	FROM [dbo].[Prices];

OPEN update_prices;

BEGIN;
	DROP TABLE IF EXISTS PricesPLN;
	SELECT
		ProductID,
		Currency,
		Price
	INTO 
		PricesPLN
	FROM
		[dbo].[Prices] 
	WHERE
		Currency = 'PLN';

	FETCH NEXT FROM update_prices INTO
		@productID,
		@currency,
		@price;

	WHILE @@FETCH_STATUS = 0
		BEGIN;
			SET @exchange = (SELECT PricePLN FROM [dbo].[Rates] WHERE @currency = Currency)
			IF @exchange IS NOT NULL
				BEGIN;
					SET @pricePLN = (SELECT TOP 1 Price FROM PricesPLN WHERE ProductID = @productID);
					UPDATE Prices SET Price = @exchange * @pricePLN WHERE CURRENT OF update_prices;

				END;

		FETCH NEXT FROM update_prices INTO
			@productID,
			@currency,
			@price;
		END;
END;

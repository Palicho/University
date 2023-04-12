INSERT INTO Products(ProductName)
        VALUES
	('pro1'),
        ('pro2'),
        ('pro3'),
        ('pro4'),
        ('pro5');

INSERT INTO Rates(Currency, PricePLN)
	VALUES
	('GBP',2.231),
	('CZK',8.23),
	('USD', 3.231),
	('PLN',1),
	('EUR',4.532);
	
INSERT INTO Prices(ProductID, Currency, Price)
	VALUES
	(1,'PLN',120),
	(2,'PLN',10),
	(3,'PLN',560),
	(4,'PLN',30),
	(5,'PLN',20),
	(2,'GBP',20),
	(4,'EUR',32),
	(1,'USD',3);

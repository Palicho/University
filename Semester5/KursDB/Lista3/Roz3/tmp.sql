DROP TABLE IF EXISTS Products;

CREATE TABLE Products(
        ID INT IDENTITY PRIMARY KEY,
        ProductName VARCHAR(20)
        );


INSERT INTO Products(ProductName)
        VALUES
		('pro1'),
        ('pro2'),
        ('pro3'),
        ('pro4'),
        ('pro5');


DROP TABLE IF EXISTS Prices;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products(
        ID INT IDENTITY PRIMARY KEY,
        ProductName VARCHAR(20)
        );


DROP TABLE IF EXISTS Rates;

CREATE TABLE Rates(
	Currency VARCHAR(20) PRIMARY KEY,
	PricePLN FLOAT
	);


DROP TABLE IF EXISTS Prices;

CREATE TABLE Prices(
        ProductID INT FOREIGN KEY REFERENCES Products(ID),
	Currency VARCHAR(20) FOREIGN KEY REFERENCES Rates(Currency),
	Price FLOAT
	);                              


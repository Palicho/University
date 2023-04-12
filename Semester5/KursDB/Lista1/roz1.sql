--roz1
SELECT [SalesLT].[Address].City FROM [SalesLT].[Address] INNER JOIN [SalesLT].[SalesOrderHeader] ON [SalesLT].[SalesOrderHeader].ShipToAddressID = [SalesLT].[Address].AddressID WHERE [SalesLT].[SalesOrderHeader].ShipDate IS NOT NULL GROUP BY [SalesLT].[Address].City ORDER BY [SalesLT].[Address].City ASC;
-- roz 2
SELECT [SalesLT].[ProductModel].Name, COUNT(*) AS POLICZ FROM [SalesLT].[ProductModel] INNER JOIN [SalesLT].[Product] ON [SalesLT].[ProductModel].ProductModelID = [SalesLT].[Product].ProductModelID GROUP BY [SalesLT].[ProductModel].Name HAVING Count(*)>1;
-- roz3
SELECT [SalesLT].[Address].City, COUNT([SalesLT].[CustomerAddress].CustomerID), COUNT(DISTINCT [SalesLT].[Customer].CustomerID) FROM [SalesLT].[Address] INNER JOIN [SalesLT].[CustomerAddress] ON [SalesLT].[CustomerAddress].AddressID = [SalesLT].[Address].AddressID INNER JOIN [SalesLT].[Customer] ON [SalesLT].[Customer].CustomerID = [SalesLT].[CustomerAddress].CustomerID GROUP BY [SalesLT].[Address].City; 
-- roz4
SELECT [SalesLT].[Product].ProductCategoryID, [SalesLT].[Product].Name FROM [SalesLT].[Product] INNER JOIN (
SELECT  [SalesLT].[ProductCategory].ParentProductCategoryID  AS ProductCategoryID FROM [SalesLT].[ProductCategory]
WHERE [SalesLT].[ProductCategory].ParentProductCategoryID IS NOT NULL GROUP BY  [SalesLT].[ProductCategory].ParentProductCategoryID) s
ON [SalesLT].[Product].ProductCategoryID = s.ProductCategoryID;

--roz5
SELECT 
[SalesLT].[SalesOrderHeader].SalesOrderID,
 SUM([SalesLT].[SalesOrderDetail].OrderQty * [SalesLT].[SalesOrderDetail].UnitPrice) - SUM([SalesLT].[SalesOrderDetail].OrderQty * [SalesLT].[SalesOrderDetail].UnitPrice* (1-[SalesLT].[SalesOrderDetail].UnitPriceDiscount)) AS Oszczednosci
FROM
[SalesLT].[SalesOrderHeader] INNER JOIN [SalesLT].[SalesOrderDetail] ON [SalesLT].[SalesOrderHeader].SalesOrderID = [SalesLT].[SalesOrderDetail].SalesOrderID
GROUP BY
[SalesLT].[SalesOrderHeader].SalesOrderID;

SELECT [SalesLT].[Customer].FirstName, [SalesLT].[Customer].LastName, z.SUMA_OSZCZEDNOSCI 
FROM 
    [SalesLT].[Customer] 
INNER JOIN 
	(SELECT [SalesLT].[Customer].CustomerID, SUM(s.Oszczednosci) AS SUMA_OSZCZEDNOSCI
	FROM 
	    [SalesLT].[Customer] 
	INNER JOIN 
		[SalesLT].[SalesOrderHeader] ON [SalesLT].[Customer].CustomerID = [SalesLT].[SalesOrderHeader].CustomerID
	INNER JOIN 
        (SELECT 
			[SalesLT].[SalesOrderHeader].SalesOrderID,
			SUM([SalesLT].[SalesOrderDetail].OrderQty * [SalesLT].[SalesOrderDetail].UnitPrice) - SUM([SalesLT].[SalesOrderDetail].OrderQty * [SalesLT].[SalesOrderDetail].UnitPrice* (1-[SalesLT].[SalesOrderDetail].UnitPriceDiscount)) AS Oszczednosci
		FROM
			[SalesLT].[SalesOrderHeader] 
        INNER JOIN [SalesLT].[SalesOrderDetail] ON [SalesLT].[SalesOrderHeader].SalesOrderID = [SalesLT].[SalesOrderDetail].SalesOrderID
		GROUP BY
			[SalesLT].[SalesOrderHeader].SalesOrderID ) s ON [SalesLT].[SalesOrderHeader].SalesOrderID = s.SalesOrderID 
	GROUP BY [SalesLT].[Customer].CustomerID ) z ON [SalesLT].[Customer].CustomerID = z.CustomerID;


--roz6
CREATE TABLE OrdersToProcess (
	SalesOrderID INT,
	Delayed BIT,
);

MERGE [dbo].[OrdersToProcess] AS Target
USING [SalesLT].[SalesOrderHeader] AS Source
ON Source.SalesOrderID = Target.SalesOrderID

--FOR Inserts
WHEN NOT MATCHED BY Target THEN
	INSERT (SalesOrderID, Delayed)

	VALUES (Source.SalesOrderID, (Source.DueDate > Source.ShipDate)) 
-- roz 7
drop table if exists automat

create table automat (id int identity(1000,10) not null primary key, nazwa varchar(20));

insert into automat(nazwa) values('ala');
insert into automat values('ania');
insert into automat values('basia');

select $identity, id from automat

select @@identity
SELECT IDENT_CURRENT('Address') AS Result;




INSERT INTO firstnames VALUES(1, 'tomasz')
INSERT INTO firstnames VALUES(2, 'bartosz')
INSERT INTO firstnames VALUES(3, 'kacper')
INSERT INTO firstnames VALUES(4, 'mateusz')
INSERT INTO firstnames VALUES(5, 'lukasz')
INSERT INTO firstnames VALUES(6, 'sebastian')



INSERT INTO lastnames VALUES(1, 'nowak')
INSERT INTO lastnames VALUES(2, 'nowacki')
INSERT INTO lastnames VALUES(3, 'kowal')
INSERT INTO lastnames VALUES(4, 'kowalski')
INSERT INTO lastnames VALUES(5, 'mlotek')
INSERT INTO lastnames VALUES(6, 'mlotkowski')
INSERT INTO lastnames VALUES(7, 'plotek')
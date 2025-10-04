SELECT Category, COUNT(Stockquantity) AS Quantity FROM Products
GROUP BY Category;

SELECT Category, AVG(Price) AS AvgPrice FROM Products
GROUP BY Category
HaVING Category LIKE 'Electronics';

SELECT * FROM Customers WHERE City LIKE 'L%';

SELECT * FROM Products WHERE ProductName LIKE '%er';

SELECT * FROM Customers WHERE Country LIKE '%A';

SELECT MAX(Price) AS MaxPrice FROM Products;

SELECT StockQuantity,
	CASE WHEN StockQuantity < 30 THEN 'Low Stock'
	ELSE 'Sufficient' END AS Status
FROM Products;

SELECT Country, COUNT(*) AS Quantity FROM Customers
GROUP BY Country;

SELECT MIN(Quantity) AS MinQ, MAX(Quantity) AS MaxQ FROM Orders;

SELECT DISTINCT CustomerID FROM Orders
WHERE YEAR(OrderDate) = 2023 AND MONTH(OrderDate) = 1
EXCEPT
SELECT DISTINCT CustomerID FROM Invoices;

SELECT ProductName FROM Products
UNION ALL
SELECT ProductNAme FROM Products_Discounted;

SELECT ProductName FROM Products
UNION
SELECT ProductNAme FROM Products_Discounted;

SELECT YEAR(OrderDate) AS Year, COUNT(*) AS OrderQuantity FROM Orders
GROUP BY YEAR(OrderDate);

SELECT ProductName,
CASE
	WHEN Price < 100 THEN 'Low'
	WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
	ELSE 'High'
END AS PriceStatus
FROM Products;

SELECT * INTO Population_Each_Year
FROM(
SELECT district_name, Year, Population
FROM city_population
) AS SourceTable
PIVOT
(
SUM(Population) FOR Year in ([2012],[2013])
) As PivotTable;

SELECT ProductID, SUM(SaleAmount) AS TotalSale FROM Sales
GROUP BY ProductID;

SELECT ProductName FROM Products WHERE ProductName LIKE '%oo%';

SELECT * INTO Population_Each_City
FROM(
SELECT district_name,Year,population
FROM city_population
) AS SourceTable
PIVOT(
SUM(Population) for District_name IN ([Bektemir],[Chilonzor],[Yakkasaroy])
) AS PivotTable;

SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent FROM Invoices
GROUP BY CustomerID ORDER BY TotalSpent DESC;
 

Select district_name,Year, Population
FROM Population_Each_Year
AS PivotTable
UNPIVOT(
Population for Year IN ([2012],[2013])
) As UnpivotedTable;

SELECT p.ProductName, COUNT(s.SaleID) AS Quantity
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

Select Year,district_name,Population
FROM Population_Each_City
AS PivotedTable
UNPIVOT(
Population FOR district_name IN ([Bektemir],[Chilonzor],[Yakkasaroy])
) AS UnpivotedTable;

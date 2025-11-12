--1
CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');

SELECT *,RIGHT(CONCAT('0',MONTH(Dt)),2) AS MonthPrefixedWithZero FROM Dates;

--2
CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);

SELECT COUNT(DISTINCT Id) AS Id,COUNT(DISTINCT rID) AS rID,SUM(MaxVal) AS TotalMaxSum 
FROM (SELECT Id,rID,MAX(Vals) AS MaxVal
	 FROM MyTabel
	 GROUP BY Id,rID) AS m;

--3
CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

SELECT * FROM TestFixLengths
WHERE LEN(Vals) > 5 AND LEN(Vals) < 11

--4
CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);

SELECT t.* FROM TestMaximum t
JOIN
	(SELECT Id,MAX(Vals) AS MaxVal 
	FROM TestMaximum
	GROUP BY ID) AS m
ON t.ID = m.ID AND t.Vals = m.MaxVal;

--5
CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

SELECT id,SUM(MaxVal) AS TotalSum FROM 
	(SELECT id,DetailedNumber,MAX(Vals) AS MaxVal
	FROM SumOfMax
	GROUP BY id,DetailedNumber) AS t
GROUP bY id;

--6
CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

SELECT *,
CASE
	WHEN a-b = 0 THEN ' '
	ELSE CAST(a-b AS varchar(10))
END AS Output
FROM TheZeroPuzzle;

--7
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);

INSERT INTO Customers (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');
select * from Sales
select SUM(QuantitySold * UnitPrice) As TotalRevenue from Sales;

--8
SELECT AVG(UnitPrice) AS AvgUnitPrice FROM Sales;

--9
SELECT COUNT(*) AS TotalTransactions FROM Sales;

--10
SELECT MAX(QuantitySold) MaxUnitSold FROM Sales;

--11
SELECT Category,COUNT(QuantitySold) SoldProducts FROM Sales
GROUP BY Category;

--12
SELECT Region,SUM(UnitPrice * QuantitySold) AS TotalRevPerRegion FROM Sales
GROUP BY Region;

--13
SELECT TOP 1 Product,SUM(QuantitySold * UnitPrice) AS Highest FROM Sales
GROUP BY Product
ORDER BY Highest;

--14
SELECT SaleDate,
       SUM(QuantitySold * UnitPrice) AS DailyRevenue,
       SUM(SUM(QuantitySold * UnitPrice)) OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;

--15
SELECT Category,
       SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
       SUM(QuantitySold * UnitPrice) * 100.0 /
           (SELECT SUM(QuantitySold * UnitPrice) FROM Sales) AS PercentageOfTotal
FROM Sales
GROUP BY Category
ORDER BY PercentageOfTotal DESC;

--16
SELECT 
    s.SaleID,c.CustomerName,s.Product,
    s.QuantitySold,s.UnitPrice,s.SaleDate
FROM Sales s
JOIN Customers c 
    ON s.CustomerID = c.CustomerID;

--17
SELECT c.CustomerID,c.CustomerName FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL;

--18
SELECT c.CustomerID,c.CustomerName,SUM(s.QuantitySold*s.UnitPrice) AS TotalRev
FROM Customers c
JOIN Sales s ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID,c.CustomerName;

--19
SELECT TOP 1 c.CustomerID,c.CustomerName,SUM(s.QuantitySold*s.UnitPrice) AS TotalRev
FROM Customers c
JOIN Sales s ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID,c.CustomerName
ORDER BY TotalRev DESC;

--20
SELECT c.CustomerID,c.CustomerName,SUM(s.QuantitySold*s.UnitPrice) AS TotalSales
FROM Customers c
JOIN Sales s ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID,c.CustomerName;

--21
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

SELECT DISTINCT p.ProductID,p.ProductName FROM Products p
JOIN Sales s ON p.ProductName = s.Product;

--23
SELECT TOP 1 ProductID,ProductName,SellingPrice FROM Products
ORDER BY SellingPrice DESC;

--24
SELECT ProductID,ProductName,Category FROM Products p
WHERE SellingPrice > (SELECT AVG(SellingPrice) FROM Products
						WHERE Category = p.Category);

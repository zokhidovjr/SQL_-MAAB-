CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')

create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

CREATE TABLE Products2 (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products2 (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

CREATE TABLE Orders1 (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products2(ProductID)
);

INSERT INTO Orders1 (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

--1
SELECT * FROM #Sales s
WHERE EXISTS (
	SELECT 1 FROM #Sales m
	WHERE m.CustomerName = s.CustomerName
	AND MONTH(m.SaleDate) = 3 AND YEAR(m.SaleDate) = 2024
);

--2
SELECT TOP 1 * FROM (
	SELECT Product,MAX(Quantity * Price) AS TotalRevenue FROM #Sales
	GROUP BY Product
) AS HighestTotal
ORDER BY TotalRevenue DESC;

--3
SELECT MAX(Total) AS SecondHighest FROM (
	SELECT DISTINCT Quantity * Price AS Total
	FROM #Sales
) t
WHERE Total < (SELECT MAX(Quantity * Price) FROM #Sales);

--4
SELECT DATEPART(MONTH, SaleDate) AS SaleMonth,
       (SELECT SUM(Quantity)
        FROM #Sales s2
        WHERE DATEPART(MONTH, s2.SaleDate) = DATEPART(MONTH, s1.SaleDate)) AS TotalQty
FROM #Sales s1
GROUP BY DATEPART(MONTH, SaleDate)
ORDER BY SaleMonth;

--5
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
    AND s2.CustomerName != s1.CustomerName
);

--6
SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple'  THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

--7
WITH RecursiveFamily AS (
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    SELECT f.ParentId, c.ChildID
    FROM Family f
    JOIN RecursiveFamily c ON f.ChildID = c.ParentId
)
SELECT DISTINCT ParentId AS PID, ChildID AS CHID
FROM RecursiveFamily
ORDER BY PID, CHID;

--8
SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders c
      WHERE c.CustomerID = o.CustomerID
        AND c.DeliveryState = 'CA'
  );

--9
SELECT e.*
FROM #EmployeeSales e
WHERE e.SalesAmount >
      (SELECT AVG(SalesAmount)
       FROM #EmployeeSales s
       WHERE s.Department = e.Department);

--10
SELECT Name
FROM Products2
WHERE Price > (SELECT AVG(Price) FROM Products2);

--11
SELECT Name, Stock
FROM Products2
WHERE Stock < (SELECT MAX(Stock) FROM Products2);

--12
SELECT Name
FROM Products2
WHERE Category = (
    SELECT Category FROM Products2 WHERE Name = 'Laptop'
);

--13
SELECT Name, Price
FROM Products2
WHERE Price > (
    SELECT MIN(Price) FROM Products2 WHERE Category = 'Electronics'
);

--14
SELECT p.Name, p.Category, p.Price
FROM Products2 p
WHERE p.Price > (
    SELECT AVG(Price)
    FROM Products2
    WHERE Category = p.Category
);

--15
SELECT DISTINCT p.Name
FROM Products2 p
WHERE EXISTS (
    SELECT 1
    FROM Orders1 o
    WHERE o.ProductID = p.ProductID
);

--16
SELECT p.Name
FROM Products2 p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders1 o WHERE o.ProductID = p.ProductID
);

--17
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQty
FROM Products2 p
JOIN Orders1 o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQty DESC;





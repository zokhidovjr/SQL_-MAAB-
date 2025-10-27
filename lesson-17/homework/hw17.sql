--1
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

SELECT r.Region,d.Distributor,COALESCE(rs.Sales,0) As Sales FROM
(SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN
(SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN #RegionSales rs
	ON rs.Region = r.Region AND d.Distributor = rs.Distributor;

-----------------------------------------------------------------------
--2
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

SELECT m.Name FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY m.Id,m.name
HAVING COUNT(e.id) >= 5

-----------------------------------------------------------------
--3
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT p.product_name,SUM(o.unit) as unit FROM Products p
JOIN Orders o ON o.product_id = p.product_id
WHERE YEAR(o.order_date) = 2020
AND MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100

-------------------------------------------------------------------
--4
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

WITH Vendors AS (
	SELECT CustomerID,Vendor,COUNT(*) AS OC,
	RANK() OVER (PARTITION BY CustomerID ORDER By COUNT(*) DESC) as rnk
	FROM Orders
	GROUP BY CustomerID,Vendor
)
SELECT CustomerID, Vendor,OC FROM Vendors
WHERE rnk = 1
------------------------------------------------------------------

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime INT = 1;

WHILE @i < @Check_Prime/2
BEGIN
	IF @Check_Prime % @i = 0
	BEGIN SET @IsPrime = 0;
	BREAK;
	END
	SET @i = @i + 1;
END
IF @IsPrime = 1
	PRINT CAST(@Check_Prime as NVARCHAR) + ' is a Prime Number';
ELSE
	PRINT CAST(@Check_Prime as NVARCHAR) +' is not a Prime Number';
-------------------------------------------------------------------
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

WITH Signals AS (
	SELECT Device_id,COUNT(Distinct Locations) No_Loc,COUNT(*) TotalS
	FROM Device
	GROUP BY Device_id
),
MostLoc AS (SELECT TOP 1 Locations,COUNT(*) SignalCnt FROM Device
GROUP BY Locations
ORDER BY COUNT(*) DESC
)
SELECT s.Device_id,m.Locations,s.No_Loc,s.TotalS FROM Signals s
CROSS JOIN MostLoc m
----------------------------------------------------
CREATE TABLE Employee1 (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee1 VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

SELEct EmpID,EmpName,Salary from Employee1 e
WHERE Salary >= (SELECT AVG(Salary) AvgSalary
				FROM Employee1 e1
				WHERE e.DeptID = e1.DeptID
				)
ORDER BY EmpID;
-----------------------------------------------------------------------------------
CREATE TABLE TheWinningNumbers (
    Number INT
);
INSERT INTO TheWinningNumbers (Number)
VALUES
(25),
(45),
(78);
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

WITH Cnt AS (
	SELECT 
		t.TicketID,
		COUNT(n.Number) AS Matchcnt
	FROM Tickets t
	LEFT JOIN TheWinningNumbers n
		ON t.Number = n.Number
	GROUP BY t.TicketID
),
WinCount AS (
	SELECT COUNT(*) AS TotalWinNums
	FROM TheWinningNumbers
)
SELECT 
	SUM(
		CASE 
			WHEN c.Matchcnt = w.TotalWinNums THEN 100
			WHEN c.Matchcnt > 0 THEN 10
			ELSE 0
		END
	) AS Total
FROM Cnt c
CROSS JOIN WinCount w;
--------------------------------------------------------------------------
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

SELECT User_id,Spend_date,
	COUNT(DISTINCT CASE WHEN Platform = '%Desktop%' THEN Platform END) AS Desktop

FROM Spending
----------------------------------------
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

WITH Numbers AS (
	SELECT 1 AS n
	UNION ALL SELECT 2
	UNION ALL SELECT 3
	UNION ALL SELECT 4
	UNION ALL SELECT 5
)
SELECT g.Product FROM Grouped g
JOIN Numbers n
	ON n.n <= g.Quantity
ORder BY g.Product;

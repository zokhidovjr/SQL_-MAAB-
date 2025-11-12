CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

--1
select *,
	ROW_NUMBER() OVER(ORDER BY SaleDate) AS RowNum
from ProductSales
--2
SELECT *,
	DENSE_RANK() OVER(ORDER BY Total DESC) AS RankNo
FROM (
	SELECT ProductName,SUM(Quantity) AS Total
	FROM ProductSales
	GROUP BY ProductName
) AS SaleSum;
--3
SELECT * FROM(
	SELECT CustomerID,SaleID,SaleAmount,
	RANK() OVER(PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS TopSale
	FROM ProductSales
) AS Ranked
WHERE TopSale = 1;
--4
SELECT SaleID,ProductName,SaleAmount,
	LEAD(SaleAmount) OVER(ORDER BY Saledate) AS NextAmount
FROM ProductSales;
--5
SELECT SaleID,ProductName,SaleAmount,
	LAG(SaleAmount) OVER(ORDER BY Saledate) AS PreAmount
FROM ProductSales;
--6
SELECT *
FROM (SELECT SaleID,ProductName,SaleAmount,
	LAG(SaleAmount) OVER(ORDER BY Saledate) AS Pre
	FROM ProductSales) AS Prev
WHERE SaleAmount > Pre;
--7
SELECT SaleID,ProductName,SaleAmount,
	SaleAmount - LAG(SaleAmount) OVER(ORDER BY Saledate) AS DIFF
FROM ProductSales;
--8
SELECT SaleID,SaleAmount,
	LEAD(SaleAmount) OVER(ORDER BY Saledate) AS NextAmount,
	((LEAD(SaleAmount) OVER(ORDER BY Saledate) - SaleAmount) / SaleAmount*100) AS PrecDiff 
FROM ProductSales;
--9
SELECT SaleID,SaleAmount,
	LAG(SaleAmount) OVER(ORDER BY Saledate) AS PreAmount,
	(SaleAmount - LAG(SaleAmount) OVER(ORDER BY Saledate)) 
	/ LAG(SaleAmount) OVER(ORDER BY SaleDate)*100 AS PrecDiff 
FROM ProductSales;
--10
SELECT SaleID,ProductName,SaleAmount,
	FIRST_VALUE(SaleAmount) OVER(Partition BY ProductName Order BY Saledate) As FirstSale,
	SaleAmount - FIRST_VALUE(SaleAmount) OVER(Partition BY ProductName Order BY Saledate) AS Diff
FROM ProductSales;
--11
SELECT * FROM(
	SELECT SaleID,ProductName,SaleAmount,
	LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) As PreSale
	FROM ProductSales
) AS PreAmount
WHERE SaleAmount > PreSale;
--12
SELECT SaleID,ProductName,SaleAmount,
	SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS RunningTotal
FROM ProductSales;
--13
SELECT SaleID,ProductName,SaleAmount,
    AVG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3
FROM ProductSales;
--14
SELECT SaleID,ProductName,SaleAmount,
	AVG(SaleAmount) OVER (PARTITION BY ProductName) AS AvgAmount,
	SaleAmount - AVG(SaleAmount) OVER (PARTITION BY ProductName) AS DiffAvgAmount
FROM ProductSales;

CREATE TABLE Employees01 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees01 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');
--15
WITH RankedEmps AS(
	SELECT *,
		RANK() OVER (PARTITION BY EmployeeID ORDER BY Salary DESC) AS SalaryRank
	FROM Employees01
)
SELECT * FROM RankedEmps
WHERE SalaryRank IN (
	SELECT SalaryRank FROM RankedEmps
	GROUP BY SalaryRank
	HAVING COUNT(*) > 1
);
--16
SELECT * FROM
(SELECT *,
	ROW_NUMBER() OVER(Partition BY Department ORDER BY Salary DESC) AS Top2
FROM Employees01) As Top2Salaries
WHERE Top2 IN (1,2);
--17
SELECT * FROM (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary) AS Lowest
	FROM Employees01
) AS LowestSalary
WHERE Lowest = 1;
--18
SELECT *,
	SUM(Salary) OVER (PARTITION BY Department
		ORDER BY Salary DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) As RunningTotal
FROM Employees01;
--19
SELECT *,
	SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees01;
--20
SELECT *,
	AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM Employees01;
--21
SELECT *,
	Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffAvgSalary
FROM Employees01;
--22
SELECT *,
	AVG(Salary) OVER 
	(PARTITION BY Department ORDER BY Salary
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3
FROM Employees01;
--23
SELECT SUM(Salary) AS Last3Hired FROM(
	SELECT TOP 3 *
	FROM Employees01
	ORDER BY HireDate) AS Last3;





--1---Easy_Tasks
WITH Numbers as (
	SELECT 1 AS n
	UNION ALL
	SELECT n+1
	FROM Numbers
	WHERE n < 1000
)
SELECT n FROM Numbers
OPTION (MAXRECURSION 1000);

--2
SELECT a.FirstName,a.LastName,b.TS FROM
(select EmployeeID,FirstName,LastName FROM Employees) as a
JOIN
(select EmployeeID,SUM(SalesAmount) AS TS FROM Sales
GROUP BY EmployeeID) as b
ON a.EmployeeID = b.EmployeeID;

--3
WITH AvgSalary AS (SELECT EmployeeID,AVG(Salary) as AvgSal 
FROM Employees
GROUP BY EmployeeID)
SELECT * FROM AvgSalary;

--4
SELECT p.ProductName,s.MaxSales FROM
(select ProductID,MAX(SalesAmount) AS MaxSales from Sales
GROUP BY ProductID) as s
JOIN
(select ProductID,ProductName from Products) as p
ON s.ProductID = p.ProductID;

--5
WITH Doubled as(
	SELECT 1 as n
	UNION ALL
	SELECT n*2
	FROM Doubled
	WHERE n*2 < 1000000
)
SELECT n FROM Doubled
OPTION (MAXRECURSION 100);

--6
WITH FiveSales AS(
	SELECT e.FirstName,e.LastName,COUNT(*) AS cnt_p
	FROM Sales s
	JOIN Employees e ON s.EmployeeID = e.EmployeeID
	GROUP BY e.EmployeeID,e.FirstName,e.LastName
)
SELECT FirstName,LastName,cnt_p FROM FiveSales
WHERE cnt_p > 5

--7
WITH MoreThanFifty AS (
	SELECT p.ProductName,SUM(s.SalesAmount) as totalS FROM Sales s
	JOIN Products p ON s.ProductID = p.ProductID
	GROUP BY p.ProductID,p.ProductName
)
SELECT * FROM MoreThanFifty
WHERE totalS > 500;

--8
WITH AboveAvg AS (SELECT AVG(Salary) as AvgSal FROM Employees)
SELECT e.EmployeeID,e.FirstName,e.LastName,e.Salary
FROM Employees e
CROSS JOIN AboveAvg a
WHERE e.Salary > a.AvgSal;

--Medium Tasks--

--1
SELECT TOP 5 e.FirstName,e.LastName,s.cnt_s FROM
(select EmployeeID,FirstName,LastName from Employees) as e
JOIN
(select EmployeeID,count(*) as cnt_s from Sales
group by EmployeeID) as s
ON e.EmployeeID = s.EmployeeID
ORDER BY s.cnt_s DESC;

--2
SELECT p.CategoryID,SUM(s.TS) as TotalSales FROM 
(select ProductID,SUM(SalesAmount) AS TS from Sales
GROUP BY ProductID) as s
JOIN
(select ProductID,CategoryID from Products) as p
ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;

--3
select * from Numbers1


--4
WITH SplitString AS (
    SELECT Id,1 AS Pos,SUBSTRING(String, 1, 1) AS CharPart,String
    FROM Example
    UNION ALL
    SELECT Id,Pos + 1,SUBSTRING(String, Pos + 1, 1),String
    FROM SplitString
    WHERE Pos < LEN(String)
)
SELECT Id, Pos, CharPart
FROM SplitString
ORDER BY Id, Pos;

--5
WITH MSales as (
	SELECT YEAR(SaleDate) as SY,
	MONTH(SaleDate) As SM,
	SUM(SalesAmount) as TS
	FROM Sales
	GROUP BY YEAR(SaleDate),MONTH(SaleDate)
)
SELECT SY,SM,TS,
	TS - LAG(TS) OVER (ORDER BY SY,SM) SDIFF
FROM MSales ORDER BY SY,SM;

--6
select e.FirstName,e.LastName,s.SY,s.SQ,s.TS from Employees e
JOIN (
	SELECT EmployeeID,YEAR(SaleDate) as SY,
			DATEPART(QUARTER,SaleDate) as SQ,
			SUM(SalesAmount) as TS
	FROM Sales
	GROUP BY EmployeeID, YEAR(SaleDate),DATEPART(QUARTER,SaleDate)
	HAVING SUM(SalesAmount) > 45000
) as s
ON e.EmployeeID = s.EmployeeID
ORDER BY s.SY,s.SQ,s.TS DESC;

--Difficult Tasks--

--1
WITH Fionacci AS (
	SELECT 1 as n,0 as f, 1 as next_f
	UNION ALL
	SELECT n+1,next_f,f+next_f FROM Fionacci
	WHERE N < 20
)
SELECT n,f FROM Fionacci

--2
SELECT Vals
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;

--4
SELECT TOP 5 e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS s
ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;

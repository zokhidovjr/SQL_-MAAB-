CREATE TABLE Customers (
    CustomerID INT,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    PaymentType VARCHAR(20)
);

INSERT INTO Customers VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'London'),
(3, 'Charlie', 'Paris'),
(4, 'David', 'New York'),
(5, 'Eva', 'Berlin');

INSERT INTO Orders VALUES
(101, 1, 250, 'Card'),
(102, 2, 100, 'Cash'),
(103, 3, 400, 'Card'),
(104, 4, 50,  'Cash'),
(105, 5, 300, 'Card'),
(106, 1, 150, 'Cash');

SELECT c.CustomerName , c.City, o.OrderAmount, o.PaymentType
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE city = 'New York'
	AND (o.PaymentType = 'Card' AND o.OrderAmount > 200)
	OR
	(o.PaymentType = 'Cash' AND o.OrderAmount < 100);

SELECT c.CustomerName, c.City, o.OrderAmount, o.PaymentType
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE City != 'London'
	AND o.PaymentType = 'Card';

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    OrderDate DATE,
    Quantity INT
);

INSERT INTO Products VALUES
(1, 'Laptop'),
(2, 'Phone'),
(3, 'Tablet');

INSERT INTO Orders VALUES
(101, 1, '2024-01-05', 5),
(102, 1, '2024-02-10', 3),
(103, 1, '2024-03-15', 2),
(104, 2, '2024-01-20', 10),
(105, 2, '2024-02-25', 7),
(106, 3, '2024-03-05', 4);

SELECT p.ProductName, o.OrderID, o.OrderDate, o.Quantity
FROM Products p
INNER JOIN Orders o ON o.OrderID = 
(SELECT TOP 1 OrderID, OrderDate, Quantity
FROM Orders o WHERE o.ProductID = p.ProductID
Order BY OrderDate DESC
) AS o;

SELECT * FROM Products
SELECT * FrOM Orders


CREATE TABLE Employees (
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE Projects (
    ProjectID INT,
    EmpID INT,
    ProjectName VARCHAR(50),
    StartDate DATE,
    Budget DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1, 'Alice', 'IT'),
(2, 'Bob', 'Finance'),
(3, 'Charlie', 'IT'),
(4, 'David', 'HR'),
(5, 'Eva', 'Marketing');

INSERT INTO Projects VALUES
(101, 1, 'Website Upgrade', '2024-04-10', 15000),
(102, 1, 'Data Migration', '2024-07-20', 12000),
(103, 2, 'Audit System', '2024-06-01', 8000),
(104, 3, 'Security Review', '2024-02-15', 10000),
(105, 3, 'AI Automation', '2024-09-10', 25000);

SELECT e.EmpName,e.Department,p.PRojectName,p.StartDate,p.Budget
FROM Employees e
CROSS APPLY(
SELECT TOP 1 ProjectName, StartDate, Budget FROM Projects p
WHERE p.EmpID = e.EmpID
ORDER BY StartDate DESC
) aS p;


SELECT e.EmpName,e.Department,p.PRojectName,p.StartDate,p.Budget
FROM Employees e
OUTER APPLY(
SELECT TOP 1 ProjectName, StartDate, Budget FROM Projects p
WHERE p.EmpID = e.EmpID
ORDER BY StartDate DESC
) aS p;


SELECT e.EmpName,e.Department,p.PRojectcount
FROM Employees e
outer APPLY(
SELECT count(*) as Projectcount FROM Projects p
WHERE p.EmpID = e.EmpID
) aS p;

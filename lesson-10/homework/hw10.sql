
SELECT e.Name,e.Salary,d.DepartmentName
FROM Employees e INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;

SELECT c.FirstName,c.LastName, o.OrderDate
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE Year(OrderDate) = '2023';

SELECT e.Name,d.DepartmentName FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT s.SupplierName, p.ProductName FROM Suppliers s
Left JOIN Products p ON s.SupplierID = p.SupplierID;

SELECT o.OrderID,o.OrderDate,
p.PaymentDate,p.Amount FROM Orders o
FULL JOIN Payments p ON o.OrderID = p.OrderID;

SELECT e.Name,e1.ManagerID FROM Employees e
LEFT JOIN Employees e1 ON e.EmployeeID = e1.EmployeeID;

SELECT s.Name, c.CourseName FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON c.CourseID = e.CourseID
WHERE c.CourseName = 'Math 101';

SELECT c.FirstName, c.LastName, o.Quantity FROM Customers c
INNER jOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;

SELECT e.Name, d.DepartmentName FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmpCount
FROM Departments d 
INNER JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;

SELECT p.ProductID, p.ProductName FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;

SELECT c.FirstName, c.LastName,
COUNT(o.OrderID)as TotalOrders FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName,c.LastName;

SELECT e.Name,d.DepartmentName FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID 
    AND e1.EmployeeID < e2.EmployeeID;

SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

SELECT 
    e.Name AS EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales'
  AND e.Salary > 60000;

  SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
INNER JOIN Payments p 
    ON o.OrderID = p.OrderID;

SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Orders o 
    ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

SELECT 
    e.Name AS EmployeeName,
    e.Salary
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);

SELECT 
    o.OrderID,
    o.OrderDate
FROM Orders o
LEFT JOIN Payments p 
    ON o.OrderID = p.OrderID
WHERE p.OrderID IS NULL 
  AND o.OrderDate < '2020-01-01';

SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Categories c 
    ON p.Category = c.CategoryID
WHERE c.CategoryID IS NULL;

SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID,
    e1.Salary
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID
   AND e1.EmployeeID < e2.EmployeeID
WHERE e1.Salary > 60000
  AND e2.Salary > 60000;

SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

SELECT 
    s.SaleID,
    p.ProductName,
    s.SaleAmount
FROM Sales s
JOIN Products p 
    ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;

SELECT 
    s.StudentID,
    s.Name
FROM Students s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollments e
    JOIN Courses c 
        ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Math 101'
);

SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentID
FROM Orders o
LEFT JOIN Payments p 
    ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName
FROM Products p
JOIN Categories c 
    ON p.Category = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

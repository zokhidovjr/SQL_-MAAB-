

SELECT s.SupplierName, p.ProductName FROM Products p
CROSS JOIN Suppliers s;

SELECT d.DepartmentName, e.Name
FROM Departments d
CROSS JOIN Employees e;

SELECT s.SupplierName, p.ProductName
FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID;

SELECT c.FirstName, c.LastName, o.OrderID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT s.Name, c.CourseName
FROM Students s
CROSS JOIN Courses c;

SELECT p.ProductName, o.OrderID
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT s.Name, e.CourseID
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID;

SELECT o.OrderID, p.PaymentID, p.Amount
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID;

SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

SELECT e.Name, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;

SELECT o.OrderID, p.ProductName, o.Quantity, p.StockQuantity
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity;

SELECT c.FirstName,c.LastName, s.ProductID, s.SaleAmount
FROM Customers c
INNER JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount >= 500;

SELECT s.Name, c.CourseName
FROM Enrollments e
INNER JOIN Students s ON e.StudentID = s.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';

SELECT o.OrderID, o.TotalAmount, p.Amount AS PaymentAmount
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount;

SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

SELECT s.SaleID, c.FirstName,c.LastName, s.SaleAmount
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

SELECT o.OrderID,c.FirstName,c.LastName, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100;

SELECT e1.Name AS Emp1, e2.Name AS Emp2
FROM Employees e1
INNER JOIN Employees e2 ON e1.EmployeeID <> e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID;

SELECT p.PaymentID, o.OrderID, o.Quantity, pr.Price, p.Amount
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID
INNER JOIN Products pr ON o.ProductID = pr.ProductID
WHERE p.Amount <> (o.Quantity * pr.Price);

SELECT s.Name
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL;

SELECT m.Name AS Manager, e.Name AS Employee,
       m.Salary AS ManagerSalary, e.Salary AS EmployeeSalary
FROM Employees m
INNER JOIN Employees e ON m.EmployeeID = e.ManagerID
WHERE m.Salary <= e.Salary;

SELECT c.FirstName, o.OrderID
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

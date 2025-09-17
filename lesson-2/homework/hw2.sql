create database MAAB_HomeWorks
use MAAB_HomeWorks
go
create table Employees(
EmpID INT,
Name VARCHAR(50),
Salary DECIMAL(10,2)
);

select * from Employees

insert into Employees VALUES(1,'John',80000000.00),(2,'James',50000000.00);
insert into Employees (EmpID, Name, Salary) VALUES (3,'Steph',40000000.00)
insert into Employees(EmpID, Name, Salary)
select 4, 'Andy', 35000000.00;

UPDATE Employees SET Salary = 7000 WHERE EmpID = 1;

DELETE from Employees where empid = 2;

--DELETE - removes data in the chosen row
--TRUNCATE - it removes table leaving only its structure
-- DROP - removes whole table 

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

ALTER TABLE Employees ADD Department VARCHAR(100);

select * from Employees

ALTER TABLE Employees
ALTER COLUMN Salary Float;

CREATE TABLE Departments(
DepartmentID INT Primary key,
DepartmentName VARCHAR(50)
);
  
select * from Departments

TRUNCATE table Employees

INSERT INTO Departments (DepartmentID,DepartmentName)
Select 1,'Sales'
INSERT INTO Departments (DepartmentID,DepartmentName)
select 2,'IT'
INSERT INTO Departments (DepartmentID,DepartmentName)
select 3,'HR'
INSERT INTO Departments (DepartmentID,DepartmentName)
select 4,'Finance'
INSERT INTO Departments (DepartmentID,DepartmentName)
select 5,'Admin'

UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

TRUNCATE TABLE Departments

alter table Employees 
drop column Department

EXEC sp_rename 'Employees','StaffMembers';

Drop table departments;

Create table Products(
ProductID INT Primary key,
ProductName Varchar(50),
Category Varchar(50),
Price Decimal(10,2) NOT NULL,
Made Varchar(50)
);

ALTER TABLE Products ADD StockQuantity INT default 50;

select * from Products

EXEC sp_rename 'Products.Category','ProductCategory';

INSERT INTO Products Values (1,'Banana','Fruit',5000.00,'Nigeria',100),
(2,'Chocolate','Sweets',12000.00,'France',250),
(3,'Tomato','Vegetable',8000.00,'Uzb',85),
(4,'Carrot','Vegetable',6000.00,'UZB',126),
(5,'Cheese','Dairy',50000.00,'Swz',60);

Select * INTO Products_Backup FROM Products;

EXEC sp_rename 'Products','Inventory';

ALTER TABLE Inventory
ALTER COLUMN Price Float;

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);

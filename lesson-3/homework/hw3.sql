-- BULK INSERT is a command that helps to import data

-- txt, csv, xls/xlsx, xml

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2)
);

INSERT INTO Products VALUES (1,'Apple',12000.00),(2,'Chocolate',21000.00),(3,'Banana',6000.00);

-- When in a given column there is NULL it does not have to have data in it if given NOT NULL it has to

ALTER TABLE Products
ADD CONSTRAINT Un_ProductName UNIQUE(ProductName)

SELECT * FROM Products

-- The purpose of commenting helps another programmer understand code

ALTER TABLE Products ADD CategoryID INT

CREATE TABLE Categories(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE
);

--IDENTITY is a command that automatically puts numbers to table(row)

BULK INSERT Products
FROM 'C:\Users\User\Desktop\Products.txt'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

-- PRIMATY KEY is a main data which can be only one
--while UNIQUE KEY requires defferent values and can be multiple

ALTER TABLE Products
ADD CONSTRAINT Price CHECK (Price>0)

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0

UPDATE Products
SET Price = ISNULL(Price, 0);

--Foreign key creates a relationship and a link to primary key

CREATE TABLE Customers(
Age INT CHECK(Age>=18)
);

CREATE TABLE TABL(
TablID INT IDENTITY(100,10)
)

CREATE TABLE OrderDetails(
OrderID INT NOT NULL,
ProductID INT NOT NULL,
Quantity INT NOT NULL,
Price DECIMAL(10,2) NOT NULL,
PRIMARY KEY (OrderID, ProductID)
)

CREATE TABLE Employees(
EmpID INT PRIMARY KEY,
Email VARCHAR(50) UNIQUE
)

CREATE TABLE MainTable(
MainID INT PRIMARY KEY,
MainName VARCHAR(50)
);
CREATE TABLE LilTable(
LilID INT PRIMARY KEY,
LilName VARCHAR(50),
MainID INT,
FOREIGN KEY (MainID) REFERENCES MainTable(MainID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

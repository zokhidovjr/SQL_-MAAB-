CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 

--1
SELECT customer_id,customer_name,total_amount,
	SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS runningtotal
from sales_data
ORDER BY customer_id,order_date;

--2
SELECT product_name,product_category,
	COUNT(*) OVER (PARTITION BY product_category) AS OrderCount
FROM sales_data;

--3
SELECT product_name,product_category,
	MAX(total_amount) OVER (PARTITION BY product_category) AS MaxAmount
FROM sales_data;

--4
SELECT product_name,product_category,unit_price,
	MIN(unit_price) OVER (PARTITION BY product_category) AS MinPrice
FROM sales_data;

--5
SELECT order_date,total_amount,
	AVG(total_amount) OVER (ORDER BY order_date
		ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Moving3Days
FROM sales_data
ORDER BY order_date;

--6
SELECT product_name,product_category,region,
	MAX(total_amount) OVER (PARTITION BY region) AS TotalAmount
FROM sales_data;

--7
SELECT customer_id,customer_name,SUM(total_amount) AS Total,
	RANK() OVER(ORDER BY SUM(total_amount) DESC) AS CustRank
FROM sales_data
GROUP bY customer_id,customer_name
ORDER BY CustRank;

--8
SELECT customer_id,customer_name,total_amount,
	total_amount - LAG(total_Amount) OVER (PARTITION BY customer_id
	ORDER BY order_date) AS PrevDiff
FROM sales_data
ORDER BY customer_id,order_date;

--9
SELECT * FROM(
	SELECT product_category,product_name,unit_price,
	DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS PriceRnk
	FROM sales_data
)AS Ranked
WHERE PriceRnk <=3;

--10
SELECT region,order_date,total_amount,
	SUM(total_amount) OVER (PARTITION BY region order by order_date) AS CumSum
FROM sales_data
ORDER BY region,order_date;

--11
SELECT product_category,order_date,total_amount,
	SUM(unit_price) OVER (PARTITION BY product_category) CumulativeRevenue
FROM sales_data
ORDER BY product_category,order_date;

--12
SELECT customer_id,
	SUM(customer_id) OVER (ORDER BY customer_id) SumVals
FROM sales_data;

--13
SELECT Value,
	SUM(Value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED
	PRECEDING AND CURRENT ROW) AS PrevSum
FROM OneColumn;

--14
SELECT customer_id,customer_name
FROM sales_data
GROUP BY customer_id,customer_name
HAVING COUNT(DISTINCT product_category) > 1;

--15
WITH CustomerTotals AS (
    SELECT 
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS TotalSpent
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)
SELECT 
    customer_id,
    customer_name,
    region,
    TotalSpent,
    AVG(TotalSpent) OVER (PARTITION BY region) AS AvgRegionSpending
FROM CustomerTotals
WHERE TotalSpent > (
    SELECT AVG(TotalSpent)
    FROM CustomerTotals AS c2
    WHERE c2.region = CustomerTotals.region
)
ORDER BY region, TotalSpent DESC;

--16
SELECT customer_id,customer_name,region,
	SUM(Total_amount) AS TotalSpent,
	RANK() OVER (PARTITION BY region OrDEr bY SUM(total_amount) DeSC) As rnk
FROM sales_data
GROUp BY customer_id,customer_name,region
ORDER BY region,rnk;

--17
SELECT customer_id,customer_name,order_date,total_amount,
	SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS RunningTotal
FROM sales_data
order BY order_date,customer_id;

--19
WITH SalesWithPrev AS (
    SELECT customer_id,customer_name,order_date,total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS PrevAmount
    FROM sales_data
)
SELECT *
FROM SalesWithPrev
WHERE total_amount > PrevAmount
ORDER BY customer_id, order_date;

--20
SELECT product_name,product_category,unit_price,
	AVG(unit_price) oVER() AS AvgPrice
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data)
ORDER bY unit_price DESC;

--21

--22

--23

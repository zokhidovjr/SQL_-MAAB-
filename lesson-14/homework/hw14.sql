
Select 
	LEFT(Name,CHARINDEX(',',Name)-1) as First,
	LTRIM(SUBSTRING(Name,CHARINDEX(',',Name)+1, LEN(Name))) as Second
FROM TestMultipleColumns;

select * from TestPercent WHERE Strs LIKE '%[%]%';

Select 
	LEFT(Vals,CHARINDEX('.',Vals)-1) as a,
	LTRIM(SUBSTRING(Vals,CHARINDEX('.',Vals)+1,LEN(Vals))) as b
FROM Splitter;

SELECT * from testDots 
WHERE LEN(Vals) - LEN(REPLACE(Vals,'.','')) > 2; 

SELECT LEN(Texts)-LEN(REPLACE(Texts,' ','')) as Space FROM CountSpaces;

select e.Name,e.Salary from Employee e
JOIN Employee m ON e.ManagerId = m.id
WHERE e.Salary > m.Salary;

SELECT Employee_ID, First_Name, Last_Name, Hire_Date,
	DATEDIFF(YEAR,HIRE_DATE,GETDATE()) as YearsofService
FROM Employees
WHERE DATEDIFF(YEAR,HIRE_DATE,GETDATE()) > 10 
	AND DATEDIFF(YEAR,HIRE_DATE,GETDATE()) < 15; 

select w1.Id FROM Weather w1
JOIN weather w2 ON w1.RecordDate = DATEADD(DAY,1,w2.RecordDate)
WHERE w1.Temperature > w2.Temperature;

SELECT player_id,MIN(event_date) as firstLog FROM Activity
GROUP BY player_id

SELECT value as Third
FROM fruits
CROSS APPLY STRING_SPLIT(fruit_List, ',',1)
WHERE ordinal = 3;

select FIRST_NAME,LAST_NAME,HIRE_DATE,
CASE WHEN DATEDIFF(YEAR,HIRE_DATE,GETDATE()) < 1 THEN 'New Hire'
	 WHEN DATEDIFF(YEAR,HIRE_DATE,GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
	 WHEN DATEDIFF(YEAR,HIRE_DATE,GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
	 WHEN DATEDIFF(YEAR,HIRE_DATE,GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
	 ELSE 'Veteran' 
END AS Level
from Employees

SELECT 
Vals,CASE 
     WHEN PATINDEX('%[^0-9]%', Vals) > 1 THEN 
          SUBSTRING(Vals, 1, PATINDEX('%[^0-9]%', Vals) - 1)
     WHEN PATINDEX('%[^0-9]%', Vals) = 1 THEN 
	 NULL
     ELSE 
          Vals
    END AS Number
FROM GetIntegers;

select device_id, MIN(event_date) as firstLog FroM Activity
GROUP BY device_id
-------------------------------------------------------------
DECLARE @val NVARCHAR(50) = 'rtcfvty34redt';
DECLARE @i INT = 1;
DECLARE @char NCHAR(1);
DECLARE @Letters NVARCHAR(50)='';
DECLARE @Numbers NVARCHAR(50)='';

WHILE @i<=LEN(@val)
BEGIN SET @char = SUBSTRING(@val,@i,1);
IF @char LIKE '[0-9]'
	SET @Numbers = @Numbers + @char;
ELSE
	SET @Letters = @Letters+@char;
SET @i=@i+1;
END;
SELECT @val as initial,
@Letters As Letters,
@Numbers As Numbers;

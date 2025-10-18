SELECT CONCAT_WS('-', EMPLOYEE_ID,First_Name,Last_Name) AS FullInfo FROM Employees
WHERE EMPLOYEE_ID = 100;

UPDATE Employees 
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER,'124','999');

SELECT FIRST_NAME,LEN(FIRST_NAME) As Length FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;

SELECT MANAGER_ID,SUM(SALARY) AS Total FROM Employees
GROUP BY MANAGER_ID;

SELECT Year1,GREATEST(Max1,Max2,Max3) AS Greatest FROM TestMax;

SELECT * FROM cinema
WHERE id % 2 = 1 AND description NOT LIKE 'Boring';

SELECT * FROM SingleOrder
ORDER BY CASE WHEN id = 0 THEN 1 ELSE 0 END, id;

SELECT COAlESCE(ssn,passportid,itin) as nullVal FROM person;

SELECT 
    FullName,
    SUBSTRING(FullName, 1, CHARINDEX(' ', FullName) - 1) AS FirstName,
    SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName) + 1,
        CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
    ) AS MiddleName,
    SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) + 1,
        LEN(FullName)
    ) AS LastName
FROM Students;

SELECT * FROM Orders
WHERE CustomerID IN (
	SELECT DISTINCT CustomerID FROM Orders
	WHERE DeliveryState = 'California'
)
AND DeliveryState = 'Texas';

SELECT SequenceNumber,
STRING_AGG(String,',') AS Mixed
FROM DMLTable
GROUP BY SequenceNumber;

SELECT 
    EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM Employees
WHERE 
    LEN(CONCAT(FIRST_NAME, LAST_NAME)) 
    - LEN(REPLACE(LOWER(CONCAT(FIRST_NAME, LAST_NAME)), 'a', '')) >= 3;

SELECT JOB_ID,COUNT(EMPLOYEE_ID) as TotalNum,
SUM(CASE WHEN DATEDIFF(YEAR,HIRE_DATE,GETDATE()) >= 3 THEN 1 ELSE 0 END) as over3,
(SUM(CASE WHEN DATEDIFF(YEAR,HIRE_DATE,GETDATE()) >= 3 THEN 1 ELSE 0 END)* 100 /COUNT(EMPLOYEE_ID)) As pOver3
FROM Employees
GROUP BY JOB_ID;

SELECT
	StudentID,
	Grade,
	SUM(Grade) OVER (Order BY StudentID) AS mix
FROM Students;

SELECT s1.StudentName as s1, s2.StudentName as s2,s1.Birthday as sharedb FROM Student s1
JOIN Student s2 ON DAY(s1.Birthday) = DAY(s2.Birthday)
AND MONTH(s1.Birthday) = MONTH(s2.Birthday)
AND s1.StudentName < s2.StudentName

SELECT CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END as p1,
CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END as p2,
SUM(Score) as totalscore
FROM PlayerScores
GROUP BY CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END;

DECLARE @str NVARCHAR(100) = 'tf56sd#%OqH';
DECLARE @i INT = 1;
DECLARE @len INT = LEN(@str);

DECLARE @upper NVARCHAR(100) = '';
DECLARE @lower NVARCHAR(100) = '';
DECLARE @nums  NVARCHAR(100) = '';
DECLARE @special NVARCHAR(100) = '';

WHILE @i <= @len
BEGIN
    DECLARE @ch NCHAR(1) = SUBSTRING(@str, @i, 1);

    IF ASCII(@ch) BETWEEN 65 AND 90
        SET @upper += @ch;
    ELSE IF ASCII(@ch) BETWEEN 97 AND 122
        SET @lower += @ch;
    ELSE IF ASCII(@ch) BETWEEN 48 AND 57
        SET @nums += @ch;
    ELSE
        SET @special += @ch;

    SET @i += 1;
END;

SELECT 
    @upper AS Uppercase,
    @lower AS Lowercase,
    @nums AS Numbers,
    @special AS SpecialChars;

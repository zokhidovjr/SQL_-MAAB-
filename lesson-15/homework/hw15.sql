--1
SELECT * FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM employees);

--2
SELECT * FROM Products
WHERE Price >(SELECT AVG(price) FROM products);

--3
SELECT * FROM employees e 
WHERE EXISTS(SELECT 1 FROM departments d
			 WHERE e.department_id = d.id
			 AND d.department_name = 'Sales');

--4
SELECT * FROM customers c
WHERE NOT EXISTS(SELECT 1 FROM orders o
				 WHERE c.customer_id = o.customer_id);

--5
SELECT p1.category_id,p1.Highest 
FROM
	(SELECT category_id,MAX(Price) as Highest FROm products1
				GROUP BY category_id) as p1;

--6
select e1.id,e1.name,e1.salary from employees1 e1
WHERE e1.department_id =(select top 1 department_id from employees1
						GRoup BY department_id
						Order By Avg(Salary) desc);

--7
select e2.* from employees2 e2
WHERE e2.salary >(SELECT AVG(salary) from employees2 e
				  WHERE e.department_id = e2.department_id);

--8
select s.student_id,s.name,g.course_id,g.grade from students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade =(select max(grade) as MaxGrade FROM grades g2
				WHERE g2.course_id = g.course_id);

--9
select id,product_name,price,category_id from
	(SELECT id,product_name,price,category_id,
	 DENSE_RANK() OVER (PARTITION BY category_id
						ORDER BY price DESC) AS rnk
	FROM products2
	 ) AS ranked
WHERE rnk = 3;

--10
select * FROM employees3 e
WHERE e.salary > (select AVG(salary) FROM employees3)
AND
e.salary < (select MAX(e2.salary) FROM employees3 e2
			WHERE e.department_id = e2.department_id);

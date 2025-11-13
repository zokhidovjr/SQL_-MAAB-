-- Data is information that can be recorded and processed.
-- Database is stored collection of related data.
-- Relational database is another database with related rows and columns making it easy to link tables using keys.
-- Table is structure in database that keeps data in rows and columns

-- 1.Relational Database Managment
--2.Security Features
--3.High Availability and Disaster Recovery
--4.Business Intelligence and Analytics
--5.Scalability and Perfomance

--Windows Authentication and SQL Server Authentication

Create Database SchoolDB;
use SchoolDB;

Create Table Students(
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
);

-- SQL Server - The database engine
-- SSMS - The managment tool or interface
-- SQL - The language used to communicate with SQL Server

--DQL = Query data (SELECT)
--DML = Manipulate data (INSERT, UPDATE, DELETE)
--DDL = Define structure (CREATE, ALTER, DROP, TRUNCATE)
--DCL = Control access (GRANT, REVOKE)
--TCL = Manage transactions (COMMIT, ROLLBACK)

INSERT INTO Students VALUES (1, 'Lee', 21),(2, 'John', 23),(3, 'Ali', 25);

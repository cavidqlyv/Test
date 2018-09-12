USE master
GO
IF NOT EXISTS (
    SELECT name
FROM sys.databases
WHERE name = N'ExamTask'
)
CREATE DATABASE ExamTask
GO

USE ExamTask

GO
IF OBJECT_ID('dbo.Student', 'U') IS NOT NULL
DROP TABLE dbo.Student
GO
CREATE TABLE dbo.Student
(
    id INT PRIMARY KEY IDENTITY(1,1),
    [name] VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    fin VARCHAR(10) NOT NULL UNIQUE,
    contact VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,
    username VARCHAR(40) NOT NULL,
    [password] VARCHAR(40) NOT NULL,
    [status] INT default 1

);

SELECT *
FROM student

CREATE TABLE Teacher
(
    id int PRIMARY KEY IDENTITY(1,1)
);

IF OBJECT_ID('dbo.Student', 'U') IS NOT NULL
DROP TABLE dbo.Student
GO
CREATE TABLE dbo.Student
(
    id INT PRIMARY KEY IDENTITY(1,1),
    [name] VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    fin VARCHAR(10) NOT NULL UNIQUE,
    contact VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,
    username VARCHAR(40) NOT NULL,
    [password] VARCHAR(40) NOT NULL,
    [status] BIT default 1

);
GO


IF OBJECT_ID('dbo.Teacher', 'U') IS NOT NULL
DROP TABLE dbo.Teacher
GO
CREATE TABLE dbo.Teacher
(
    id INT PRIMARY KEY IDENTITY(1,1),
    [name] VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    username VARCHAR(40) NOT NULL UNIQUE,
    [password] VARCHAR(40) NOT NULL,
    [status] BIT default 1
);
GO
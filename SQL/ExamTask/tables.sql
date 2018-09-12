-- Create a new database called 'ExamTask'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
FROM sys.databases
WHERE name = N'ExamTask'
)
CREATE DATABASE ExamTask
GO


CREATE TABLE Student
(
    id INT PRIMARY KEY identity(1,1),
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    fin VARCHAR(10) NOT NULL unique,
    contact VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,
    username VARCHAR(40) NOT NULL,
    password VARCHAR(40) NOT NULL,
    status INT default 1
);
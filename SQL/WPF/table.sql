USE master 

go 

IF NOT EXISTS (SELECT NAME 
               FROM   sys.databases 
               WHERE  NAME = N'wpftest') 
  CREATE DATABASE wpftest 

go 

IF Object_id('dbo.Student', 'U') IS NOT NULL 
  DROP TABLE dbo.student 

go 

CREATE TABLE dbo.student 
  ( 
     id             INT NOT NULL PRIMARY KEY, 
     fullname       VARCHAR(40) NOT NULL, 
     username       VARCHAR(40) NOT NULL, 
     [password]     VARCHAR(40) NOT NULL, 
     adress         VARCHAR(100), 
     twitter        VARCHAR(50), 
     facebook       VARCHAR(50), 
     mail           VARCHAR(50), 
     phone          VARCHAR(50), 
     birthdate      DATE, 
     imagepath      VARCHAR(200), 
     performance    DECIMAL(3, 1), 
     attendance     INT, 
     class          VARCHAR(40), 
     specialization VARCHAR(40), 
     points         INT, 
     coin           INT, 
     crystal        INT, 
     badges         INT 
  ); 

go 

IF Object_id('dbo.Teacher', 'U') IS NOT NULL 
  DROP TABLE dbo.teacher 

go 

CREATE TABLE dbo.teacher 
  ( 
     teacherid INT NOT NULL PRIMARY KEY, 
     column1   [NVARCHAR](50) NOT NULL, 
     column2   [NVARCHAR](50) NOT NULL 
  ); 

go 
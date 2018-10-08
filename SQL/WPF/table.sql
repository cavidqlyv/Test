USE master 

go 

/*
* Student
* Teacher
* Lesson
* Homework
* Group
* Group_Student
* GroupLessonTime
* StudentMarks
* 
*/

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
     id             INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
     fullname       VARCHAR(40) NOT NULL, 
     username       VARCHAR(40) UNIQUE NOT NULL, 
     [password]     VARCHAR(40) NOT NULL, 
     adress         VARCHAR(100), 
     twitter        VARCHAR(50), 
     facebook       VARCHAR(50), 
     mail           VARCHAR(50) NOT NULL, 
     phone          VARCHAR(20) NOT NULL, 
     birthdate      DATE, 
     imagePath      VARCHAR(200), 
     performance    DECIMAL(3,1), 
     attendance     INT, 
     class          VARCHAR(40), 
     specialization VARCHAR(40), 
     points         INT, 
     coin           INT, 
     crystal        INT, 
     badges         INT,
     [status]       BIT NOT NULL
  ); 

go 

IF Object_id('dbo.Teacher', 'U') IS NOT NULL 
  DROP TABLE dbo.teacher 

go 

CREATE TABLE dbo.teacher 
  ( 
     id           INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
     [fullname]   VARCHAR(50) NOT NULL, 
     username     VARCHAR(50) UNIQUE NOT NULL,
     [password]   VARCHAR(40) NOT NULL,
     mail         VARCHAR(60) NOT NULL,
     imagePath    VARCHAR(200),
     facebook     VARCHAR(40),
     twitter      VARCHAR(40),
     phone        VARCHAR(20),
     [status]       BIT NOT NULL
  ); 

go 

IF OBJECT_ID('dbo.Lesson', 'U') IS NOT NULL
DROP TABLE dbo.Lesson
GO

CREATE TABLE dbo.Lesson
(
  id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  [name] VARCHAR(40) NOT NULL,
  [status]       BIT NOT NULL
);
GO

IF OBJECT_ID('dbo.Homework', 'U') IS NOT NULL
DROP TABLE dbo.Homework
GO

CREATE TABLE dbo.Homework
(
  id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  filePath VARCHAR(200) NOT NULL,
  comment VARCHAR(200),
  [status]       BIT NOT NULL
);
GO

IF OBJECT_ID('dbo.Group', 'U') IS NOT NULL
DROP TABLE dbo.[Group]
GO
CREATE TABLE dbo.[Group]
(
  id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  [name] VARCHAR(50) NOT NULL,
  lesson_id INT CONSTRAINT fk_lesson_id FOREIGN KEY REFERENCES Lesson(id),
  [status] BIT NOT NULL
);
GO


IF OBJECT_ID('dbo.GroupLessonTime', 'U') IS NOT NULL
DROP TABLE dbo.GroupLessonTime
GO
CREATE TABLE dbo.GroupLessonDate
(
  id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  [date] DATETIME NOT NULL,
  room INT NOT NULL,
  group_id INT CONSTRAINT fk_group_id FOREIGN KEY REFERENCES dbo.[Group](id),
  [status] BIT NOT NULL
);
GO

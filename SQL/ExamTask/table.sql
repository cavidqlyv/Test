USE master 

go 

IF EXISTS (SELECT NAME 
           FROM   sys.databases 
           WHERE  NAME = N'ExamTask') 
ALTER DATABASE examtask SET  SINGLE_USER WITH ROLLBACK IMMEDIATE

  DROP DATABASE examtask 

go 

USE master 

go 

IF NOT EXISTS (SELECT NAME 
               FROM   sys.databases 
               WHERE  NAME = N'ExamTask') 
  CREATE DATABASE examtask 

go 

USE examtask 

go 

IF Object_id('dbo.Student', 'U') IS NOT NULL 
  DROP TABLE dbo.student 

go 

CREATE TABLE dbo.student 
  ( 
     id                INT PRIMARY KEY IDENTITY(1, 1), 
     [name]            VARCHAR(40) NOT NULL, 
     surname           VARCHAR(40) NOT NULL, 
     fin               VARCHAR(10) NOT NULL UNIQUE, 
     contact           VARCHAR(20) NOT NULL, 
     registration_date DATE NOT NULL, 
     username          VARCHAR(40) NOT NULL UNIQUE, 
     [password]        VARCHAR(40) NOT NULL, 
     [status]          BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Teacher', 'U') IS NOT NULL 
  DROP TABLE dbo.teacher 

go 

CREATE TABLE dbo.teacher 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     [name]     VARCHAR(40) NOT NULL, 
     surname    VARCHAR(40) NOT NULL, 
     contact    VARCHAR(20) NOT NULL, 
     username   VARCHAR(40) NOT NULL UNIQUE, 
     [password] VARCHAR(40) NOT NULL, 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Lesson', 'U') IS NOT NULL 
  DROP TABLE dbo.lesson 

go 

CREATE TABLE dbo.lesson 
  ( 
     id       INT PRIMARY KEY IDENTITY(1, 1), 
     [name]   NVARCHAR(40) NOT NULL, 
     price    INT NOT NULL, 
     [status] BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Group', 'U') IS NOT NULL 
  DROP TABLE dbo.[group] 

go 

CREATE TABLE dbo.[group] 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     [name]     NVARCHAR(50) NOT NULL UNIQUE, 
     teacher_id INT CONSTRAINT fk_group_teacher_id FOREIGN KEY REFERENCES 
     teacher(id), 
     lesson_id  INT CONSTRAINT fk_group_lesson_id FOREIGN KEY REFERENCES lesson( 
     id), 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Group_Student', 'U') IS NOT NULL 
  DROP TABLE dbo.group_student 

go 

CREATE TABLE dbo.group_student 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     student_id INT CONSTRAINT fk_groupstudent_student_id FOREIGN KEY REFERENCES 
     student(id), 
     group_id   INT CONSTRAINT fk_groupstudent_group_id FOREIGN KEY REFERENCES 
     [group]( 
     id), 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Student_Payments', 'U') IS NOT NULL 
  DROP TABLE dbo.student_payments 

go 

CREATE TABLE dbo.student_payments 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     student_id INT CONSTRAINT fk_studentpayments_student_id FOREIGN KEY 
     REFERENCES 
     student(id), 
     payment    INT NOT NULL, 
     [date] DATE NOT NULL,
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Student_Marks', 'U') IS NOT NULL 
  DROP TABLE dbo.student_marks 

go 

CREATE TABLE dbo.student_marks 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     student_id INT CONSTRAINT fk_studentmarks_student_id FOREIGN KEY REFERENCES 
     student(id), 
     [date]     DATE NOT NULL, 
     mark       INT NOT NULL, 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Student_LessonDay', 'U') IS NOT NULL 
  DROP TABLE dbo.student_lessondays 

go 

CREATE TABLE dbo.student_lessondays 
  ( 
     id             INT PRIMARY KEY IDENTITY(1, 1), 
     student_id     INT CONSTRAINT fk_studentlessondays_student_id FOREIGN KEY 
     REFERENCES 
     student(id), 
     student_status BIT NOT NULL, 
     [date]         DATE NOT NULL, 
     [status]       BIT DEFAULT 1 
  ); 

go 
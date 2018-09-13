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
    [status] BIT default 1

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
    [status] BIT DEFAULT 1

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
    [status] BIT DEFAULT 1
);
GO

IF OBJECT_ID('dbo.Lesson', 'U') IS NOT NULL
DROP TABLE dbo.Lesson
GO
CREATE TABLE dbo.Lesson
(
    id INT PRIMARY KEY IDENTITY(1,1),
    [name] NVARCHAR(40) NOT NULL,
    price INT NOT NULL,
    [status] BIT DEFAULT 1
);
GO

IF OBJECT_ID('dbo.Group', 'U') IS NOT NULL
DROP TABLE dbo.[Group]
GO
CREATE TABLE dbo.[Group]
(
    id INT PRIMARY KEY IDENTITY(1,1),
    [name] NVARCHAR(50) NOT NULL,
    teacher_id INT CONSTRAINT fk_teacher_id FOREIGN KEY REFERENCES Teacher(id),
    lesson_id INT CONSTRAINT fk_lesson_id FOREIGN KEY REFERENCES Lesson(id),    
    [status] BIT DEFAULT 1
);
GO


IF OBJECT_ID('dbo.Group_Student', 'U') IS NOT NULL
DROP TABLE dbo.Group_Student
GO
CREATE TABLE dbo.Group_Student
(
    id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT CONSTRAINT fk_student_id FOREIGN KEY REFERENCES Student(id),
    group_id INT CONSTRAINT fk_group_id FOREIGN KEY REFERENCES [Group](id)
);
GO

IF OBJECT_ID('dbo.Student_Payments', 'U') IS NOT NULL
DROP TABLE dbo.Student_Payments
GO
CREATE TABLE dbo.Student_Payments
(
    id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT CONSTRAINT fk_student_id FOREIGN KEY REFERENCES Student(id),
    payment DECIMAL(7,2) NOT NULL
);
GO

IF OBJECT_ID('dbo.Student_Marks', 'U') IS NOT NULL
DROP TABLE dbo.Student_Marks
GO
CREATE TABLE dbo.Student_Marks
(
    id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT CONSTRAINT fk_student_id FOREIGN KEY REFERENCES Student(id),
    [date] DATE NOT NULL,
    mark INT NOT NULL
);
GO





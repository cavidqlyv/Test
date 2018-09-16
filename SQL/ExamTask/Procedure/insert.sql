USE ExamTask

-- Insert Rows Student
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertStudent'
)
DROP PROCEDURE dbo.InsertStudent
GO

CREATE PROCEDURE dbo.InsertStudent
    @name VARCHAR(40),
    @surname VARCHAR(40),
    @fin VARCHAR(10),
    @contact VARCHAR(20),
    @registration_date DATE,
    @username VARCHAR(40),
    @password VARCHAR(40),
    @status BIT = 1
AS
INSERT INTO Student
VALUES(
        @name,
        @surname,
        @fin,
        @contact,
        @registration_date,
        @username,
        @password,
        @status);
GO



-- Insert Rows Teacher
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertTeacher'
)
DROP PROCEDURE dbo.InsertTeacher
GO
CREATE PROCEDURE dbo.InsertTeacher
    @name VARCHAR(40),
    @surname VARCHAR(40),
    @contact VARCHAR(20),
    @username VARCHAR(40),
    @password VARCHAR(40),
    @status BIT = 1
AS
INSERT INTO Teacher
VALUES(
        @name,
        @surname,
        @contact,
        @username,
        @password,
        @status
    )
GO


IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertLesson'
)
DROP PROCEDURE dbo.InsertLesson
GO
CREATE PROCEDURE dbo.InsertLesson
    @name VARCHAR(40),
    @price INT,
    @status BIT = 1
AS
INSERT INTO Lesson
VALUES(
        @name,
        @price,
        @status
    )
GO

IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertGroup'
)
DROP PROCEDURE dbo.InsertGroup
GO
CREATE PROCEDURE dbo.InsertGroup
    @name VARCHAR(40),
    @teacherId INT,
    @LessonId INT,
    @status BIT = 1
AS
INSERT INTO [Group]
VALUES(
        @name,
        @teacherId,
        @lessonId,
        @status
)
GO

IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertGroup_Student'
)
DROP PROCEDURE dbo.InsertGroup_Student

GO
CREATE PROCEDURE dbo.InsertGroup_Student
    @studentId INT,
    @groupId INT,
    @status BIT = 1
AS
INSERT INTO Group_Student
VALUES(
        @studentId,
        @groupId,
        @status
)
GO

IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertStudent_Payments'
)
DROP PROCEDURE dbo.InsertStudent_Payments
GO
CREATE PROCEDURE dbo.InsertStudent_Payments
    @studentId INT,
    @payment DECIMAL(7,2),
    @status BIT = 1
AS
INSERT INTO Student_Payments
VALUES(
        @studentId,
        @payment,
        @status
    )
GO

IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Insert_Student_Marks'
)
DROP PROCEDURE dbo.Insert_Student_Marks
GO
CREATE PROCEDURE dbo.Insert_Student_Marks
    @studentId INT,
    @date DATE,
    @mark INT,
    @status BIT = 1
AS
INSERT INTO Student_Marks
VALUES(
        @studentId,
        @date,
        @mark,
        @status
)
GO

IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Insert_Student_LessonDay'
)
DROP PROCEDURE dbo.Insert_Student_LessonDay
GO
CREATE PROCEDURE dbo.Insert_Student_LessonDay
    @studentId INT,
    @studentStatus BIT,
    @date DATE,
    @status BIT =1
AS
INSERT INTO Student_LesssonDays
VALUES(
        @studentId,
        @studentStatus,
        @date,
        @status
)
GO

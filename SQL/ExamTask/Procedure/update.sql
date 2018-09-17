USE ExamTask


-- Update Student
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Student'
)
DROP PROCEDURE dbo.Update_Student
GO

CREATE PROCEDURE dbo.Update_Student
    @id INT,
    @name VARCHAR(40),
    @surname VARCHAR(40),
    @fin VARCHAR(10),
    @contact VARCHAR(20),
    @registration_date DATE,
    @username VARCHAR(40),
    @password VARCHAR(40),
    @status BIT = 1
AS
UPDATE Student SET 
    [name] = @name,
    surname = @surname,
    fin = @fin,
    contact = @contact,
    registration_date = @registration_date,
    username = @username,
    [password] = @password,
    [status] = @status
    WHERE id = @id
GO


-- Update Teacher
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Teacher'
)
DROP PROCEDURE dbo.Update_Teacher
GO
CREATE PROCEDURE dbo.Update_Teacher
    @id INT,
    @name VARCHAR(40),
    @surname VARCHAR(40),
    @contact VARCHAR(20),
    @username VARCHAR(40),
    @password VARCHAR(40),
    @status BIT = 1
AS
UPDATE Teacher SET
[name] = @name,
surname = @surname,
contact = @contact,
username = @username,
[password] = @password,
[status] = @status
WHERE id = @id
GO


-- Update Lesson
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Lesson'
)
DROP PROCEDURE dbo.Update_Lesson
GO
CREATE PROCEDURE dbo.Update_Lesson
    @id INT,
    @name VARCHAR(40),
    @price INT,
    @status BIT = 1
AS
UPDATE Lesson SET
[name] = @name,
price = @price,
[status] = @status
WHERE id =@id
GO


-- Update Group
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Group'
)
DROP PROCEDURE dbo.Update_Group
GO
CREATE PROCEDURE dbo.Update_Group
    @id INT,
    @name VARCHAR(40),
    @teacherId INT,
    @LessonId INT,
    @status BIT = 1
AS
UPDATE [Group] SET
[name] = @name,
teacher_id = @teacherId,
lesson_id = @LessonId,
[status] = @status
WHERE id =@id
GO


-- Update Group_Student
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Group_Student'
)
DROP PROCEDURE dbo.Update_Group_Student

GO
CREATE PROCEDURE dbo.Update_Group_Student
    @id INT,
    @studentId INT,
    @groupId INT,
    @status BIT = 1
AS
UPDATE Group_Student SET
student_id = @studentId,

GO


-- Insert Student_Payments
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


-- Insert Student_Marks
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


-- Insert Student_LessonDay
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

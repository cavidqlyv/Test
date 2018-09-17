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
group_id = @groupId,
[status] = @status
WHERE id =@id
GO


-- Update Student_Payments
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Student_Payments'
)
DROP PROCEDURE dbo.Update_Student_Payments
GO
CREATE PROCEDURE dbo.Update_Student_Payments
    @id INT,
    @studentId INT,
    @payment DECIMAL(7,2),
    @status BIT = 1
AS
UPDATE Student_Payments SET
student_id = @studentId,
payment = @payment,
[status] = @status
WHERE id =@id
GO


-- Update Student_Marks
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Student_Marks'
)
DROP PROCEDURE dbo.Update_Student_Marks
GO
CREATE PROCEDURE dbo.Update_Student_Marks
    @id INT,
    @studentId INT,
    @date DATE,
    @mark INT,
    @status BIT = 1
AS
UPDATE Student_Marks SET
student_id = @studentId,
[date] = @date,
mark = @mark,
[status] = @status
WHERE id =@id
GO


-- Update Student_LessonDay
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Update_Student_LessonDay'
)
DROP PROCEDURE dbo.Update_Student_LessonDay
GO
CREATE PROCEDURE dbo.Update_Student_LessonDay
    @id INT,
    @studentId INT,
    @studentStatus BIT,
    @date DATE,
    @status BIT =1
AS
UPDATE Student_LessonDays SET
student_id = @studentId,
student_status = @studentStatus,
[date] = @date,
[status] = @status
WHERE id =@id
GO
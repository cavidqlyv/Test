USE ExamTask


-- Delete Student
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Student'
)
DROP PROCEDURE dbo.Delete_Student
GO
CREATE PROCEDURE dbo.Delete_Student
    @id INT
AS
UPDATE Student SET [status] =0 WHERE id = @id;
GO


-- Delete Teacher
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Teacher'
)
DROP PROCEDURE dbo.Delete_Teacher
GO
CREATE PROCEDURE dbo.Delete_Teacher
    @id INT
AS
UPDATE Teacher SET [status] =0 WHERE id = @id;
GO


-- Delete Lesson
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Lesson'
)
DROP PROCEDURE dbo.Delete_Lesson
GO
CREATE PROCEDURE dbo.Delete_Lesson
    @id INT
AS
UPDATE Lesson SET [status] =0 WHERE id = @id;
GO


-- Delete Group
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Group'
)
DROP PROCEDURE dbo.Delete_Group
GO
CREATE PROCEDURE dbo.Delete_Group
    @id INT
AS
UPDATE dbo.[Group] SET [status] =0 WHERE id = @id;
GO


-- Delete Group_Student
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Group_Student'
)
DROP PROCEDURE dbo.Delete_Group_Student
GO
CREATE PROCEDURE dbo.Delete_Group_Student
    @id INT
AS
UPDATE Group_Student SET [status] =0 WHERE id = @id;
GO


-- Delete Student_Payments
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Student_Payments'
)
DROP PROCEDURE dbo.Delete_Student_Payments
GO
CREATE PROCEDURE dbo.Delete_Student_Payments
    @id INT
AS
UPDATE Student_Payments SET [status] =0 WHERE id = @id;
GO


-- Delete Student_Marks
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Student_Marks'
)
DROP PROCEDURE dbo.Delete_Student_Marks
GO
CREATE PROCEDURE dbo.Delete_Student_Marks
    @id INT
AS
UPDATE Student_Marks
SET [status] =0
WHERE id = @id;
GO


-- Delete Student_LessonDays
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Delete_Student_LessonDays'
)
DROP PROCEDURE dbo.Delete_Student_LessonDays
GO
CREATE PROCEDURE dbo.Delete_Student_LessonDays
    @id INT
AS
    UPDATE Student_LessonDays
    SET [status] =0
    WHERE id = @id;
GO
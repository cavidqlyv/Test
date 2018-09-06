use c

-- Get a list of tables and views in the current database
SELECT table_catalog [database], table_schema [schema], table_name name, table_type type
FROM INFORMATION_SCHEMA.TABLES
GO

SELECT *
FROM Lesson;

GO
DROP PROCEDURE dbo.InsertLesson
GO
CREATE PROCEDURE dbo.InsertLesson
    @name VARCHAR(20),
    @dp int,
    @status int
AS
INSERT INTO Lesson
VALUES
    (@name , @dp , @status);
GO

EXECUTE dbo.InsertLesson 'test' , 100,1;
GO

DROP PROCEDURE dbo.UpdateLesson
GO
CREATE PROCEDURE dbo.UpdateLesson
    @id int,
    @name VARCHAR(20),
    @dp int,
    @status  int
AS
UPDATE Lesson set name = @name , default_price = @dp , [status] = @status
WHERE id = @id;
GO

EXECUTE dbo.UpdateLesson 1, 'test' , 100,1;

SELECT *
FROM Groupc;

DROP PROCEDURE dbo.DeleteLesson
GO
CREATE PROCEDURE dbo.DeleteLesson
    @id INT
AS

UPDATE Lesson SET [status] = 0 WHERE id = @id;
GO

EXECUTE dbo.DeleteLesson 1



DBCC LOGINFO

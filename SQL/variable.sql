CREATE DATABASE db1;

--use db1;

DECLARE @someBit bit = 0;

SET @someBit = 1;

PRINT @someBit;

--DROP TABLE v

CREATE TABLE v
(
    id INT IDENTITY(1,1),
    name NVARCHAR(20)
);

INSERT INTO v
values('əəəə');

INSERT INTO v
values(N'əəəə');


SELECT *
FROM v;
--use db1

DECLARE @myDateTime DATETIME = '09-04-2018 19:38';

PRINT @myDateTime;

DECLARE @myInt DECIMAL(3,2) = 5.25;

set @myDateTime = @myDateTime +@myInt;
PRINT @myDateTime

--DROP TABLE a;

CREATE TABLE a
(
    id INT IDENTITY(1,1),
    name NVARCHAR(20)
)

INSERT a
SELECT name
FROM v

-- Select rows from a Table or View 'a' in schema 'dbo'
SELECT *
FROM dbo.a
GO

INSERT INTO v
    (name)
OUTPUT
inserted.*
VALUES('name')

SELECT *
FROM v


DECLARE @myTable TABLE (
    id int ,
    newname VARCHAR(40),
    oldname VARCHAR(40));

UPDATE v SET name ='updatename' 
OUTPUT inserted.id, inserted.name AS 'newname',
deleted.name AS 'oldname' INTO @myTable WHERE name = 'name';

SELECT *
FROM @myTable;

-- Create a new stored procedure called 'Sample_Procedure' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'Sample_Procedure'
)
DROP PROCEDURE dbo.Sample_Procedure
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.Sample_Procedure
    @param1 /*parameter name*/ int /*datatype_for_param1*/ = 0,
    /*default_value_for_param1*/
    @param2 /*parameter name*/ int /*datatype_for_param1*/ = 0
/*default_value_for_param2*/
-- add more stored procedure parameters here
AS
-- body of the stored procedure
SELECT *
FROM Student
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.Sample_Procedure 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO


CREATE PROCEDURE dbo.student_insert
    @name VARCHAR(20),
    @surname VARCHAR(20),
    @fin VARCHAR(20),
    @contact VARCHAR(20),
    @rdate date
AS
INSERT into Student
    (name ,surname,fin,contact,registration_date)
VALUES(@name, @surname, @fin, @contact, @rdate)
GO
GO
GO
EXECUTE student_insert 'studenttest','studenttest1','123456','123456','05.09.2018';

EXECUTE Sample_Procedure;


GO
CREATE PROCEDURE dbo.student_update
    @id int,
    @name VARCHAR(20),
    @surname VARCHAR(20),
    @fin VARCHAR(20),
    @contact VARCHAR(20),
    @rdate date
AS
UPDATE Student SET name=@name , surname = @surname , fin = @fin , contact = @contact , registration_date = @rdate
WHERE id = @id;
GO

EXECUTE student_update 1, 'updatestudenttest','updatestudenttest1','1234567','1234567','05.09.2018';

GO

GO
CREATE PROCEDURE getFullNameById
    @id int,
    @fullname VARCHAR(40) OUTPUT
AS
DECLARE @name VARCHAR(20);
DECLARE @surname VARCHAR(20);
SELECT @name = name , @surname = surname
FROM Student
WHERE @id = id;
SET @fullname = @name + ' ' + @surname
RETURN 0

GO
DECLARE @fullname VARCHAR(40);

EXEC getFullNameById 1 , @fullname output;

PRINT @fullname;



SELECT * from Lesson


INSERT into Lesson VALUES('lesson5',100,1);

GO
CREATE PROCEDURE getMaxMinPrice
    @max int OUTPUT,
    @min int OUTPUT
AS

SELECT @max= max(default_price), @min = MIN(default_price)
FROM Lesson
RETURN 0
GO
DECLARE @max int;
DECLARE @min int; 

EXEC getMaxMinPrice @max output , @min output;

PRINT @max;
PRINT @min;



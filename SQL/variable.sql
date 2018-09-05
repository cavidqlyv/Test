CREATE DATABASE db1;

use db1;

DECLARE @someBit bit = 0;

SET @someBit = 1;

PRINT @someBit;

DROP TABLE v

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
use db1

DECLARE @myDateTime DATETIME = '09-04-2018 19:38';

PRINT @myDateTime;

DECLARE @myInt DECIMAL(3,2) = 5.25;

set @myDateTime = @myDateTime +@myInt;
PRINT @myDateTime

DROP TABLE a;

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
    @param1 /*parameter name*/ int /*datatype_for_param1*/ = 0, /*default_value_for_param1*/
    @param2 /*parameter name*/ int /*datatype_for_param1*/ = 0 /*default_value_for_param2*/
-- add more stored procedure parameters here
AS
    -- body of the stored procedure
    SELECT * FROM Student
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.Sample_Procedure 1 /*value_for_param1*/, 2 /*value_for_param2*/
GO
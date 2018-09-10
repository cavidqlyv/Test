USE c;

CREATE TABLE person(
    id INT IDENTITY(1,1) NOT NULL,
    name VARCHAR(200) NOT NULL,
    age int
);

GO
CREATE PROCEDURE dbo.insert_person
    @name  VARCHAR(200),
    @age  int 
AS
   INSERT into person VALUES(@name , @age);
GO
EXECUTE dbo.insert_person 'person4',17;
GO

SELECT * FROM dbo.person

CREATE CLUSTERED INDEX index_age
ON person
(age)

SELECT * FROM person

DECLARE @count int =0;

WHILE @count <100
BEGIN
PRINT @count;
SET @count+=1;
END;
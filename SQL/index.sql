
DROP TABLE person
CREATE TABLE person(
    id INT IDENTITY(1,1) NOT NULL,
    name VARCHAR(200) NOT NULL,
    age int
);
GO
DROP PROCEDURE insert_person
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

DROP TABLE rand_table

CREATE TABLE rand_table(
    id INT NOT NULL,
    rand_int INT NOT NULL,
    rand_string VARCHAR(255)
);

SELECT ROUND(RAND()*100 , 0) AS VALUE


DROP VIEW view_rand_int
GO
CREATE VIEW view_rand_int
AS
SELECT ROUND(RAND()*100 , 0) AS VALUE
GO

SELECT * FROM view_rand_int
DROP VIEW view_rand_string

GO
CREATE VIEW view_rand_string
AS
SELECT NEWID() as randString;
GO
DROP PROCEDURE insert_rand_table

SELECT * FROM view_rand_string;
GO
CREATE PROCEDURE insert_rand_table
@id int,
@randInt int,
@randString VARCHAR(255)
AS 
INSERT INTO rand_table VALUES(@id , @randInt , @randString);


GO
DECLARE @count int =10;
DECLARE @randInt int = 0;
DECLARE @randString VARCHAR(255)='';

WHILE @count <10000
BEGIN
SELECT @randInt = [VALUE] FROM view_rand_int;
SELECT @randString =randString FROM view_rand_string
EXECUTE insert_rand_table @count , @randInt , @randString; 
SET @count+=1;
END;

SELECT * FROM rand_table WHERE rand_string = '004E52DF-EB76-4FE5-B645-FA8B058FE84A'

SET STATISTICS TIME ON
--CPU time = 16 ms, elapsed time = 16 ms. 
--CPU time = 1217 ms, elapsed time = 1217 ms. 
SELECT * FROM rand_table WHERE rand_int = 15

GO
CREATE CLUSTERED INDEX index_rand_table_name
ON  rand_table (rand_string)

CREATE INDEX INDEX_rand_int
ON  rand_table (rand_int)
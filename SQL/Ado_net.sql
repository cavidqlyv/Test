USE master
GO
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'AdoNetExam'
)
CREATE DATABASE AdoNetExam
GO

use AdoNetExam

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
DROP TABLE dbo.Product
GO
CREATE TABLE dbo.Product
(
    id INT NOT NULL PRIMARY KEY IDENTITY,
    [name] VARCHAR(40) NOT NULL,
    price INT NOT NULL,
    [status] BIT DEFAULT 1 
);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertProduct'
)
DROP PROCEDURE dbo.InsertProduct
GO
CREATE PROCEDURE dbo.InsertProduct
    @name VARCHAR(40),
    @price INT
AS
    INSERT INTO Product VALUES(@name , @price , 1);
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'UpdateProduct'
)
DROP PROCEDURE dbo.UpdateProduct
GO
CREATE PROCEDURE dbo.UpdateProduct
    @id INT,
    @name VARCHAR(40),
    @price INT,
    @status BIT
AS
    UPDATE Product
    SET name = @name , price = @price,[status] = @status
    WHERE id = @id;
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'DeleteProduct'
)
DROP PROCEDURE dbo.DeleteProduct
GO
CREATE PROCEDURE dbo.DeleteProduct
    @id INT
AS
    UPDATE Product
    SET [status] =0
    WHERE id = @id;
GO
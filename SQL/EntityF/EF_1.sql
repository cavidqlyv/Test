USE master
GO
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'entitydb'
)
CREATE DATABASE entitydb
GO


USE entitydb
IF OBJECT_ID('dbo.author', 'U') IS NOT NULL
DROP TABLE dbo.author
GO
CREATE TABLE dbo.author
(
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [name] VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    
);
GO


IF OBJECT_ID('dbo.publisher', 'U') IS NOT NULL
DROP TABLE dbo.publisher
GO
CREATE TABLE dbo.publisher
(
    id INT NOT NULL PRIMARY KEY,
    [name] VARCHAR(40) NOT NULL,
    adress VARCHAR(40)
);
GO

IF OBJECT_ID('dbo.book', 'U') IS NOT NULL
DROP TABLE dbo.book
GO
CREATE TABLE dbo.book
(
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [name] VARCHAR(40) NOT NULL,
    price INT,
    [page] INT,
    author_id INT FOREIGN KEY REFERENCES author(id),
    publisher_id INT FOREIGN KEY REFERENCES publisher(id)    
);
GO

select * FROM author
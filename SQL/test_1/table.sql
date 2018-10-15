USE master
GO
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'officeDb'
)
CREATE DATABASE officeDb
GO

IF OBJECT_ID('dbo.DataTable', 'U') IS NOT NULL
DROP TABLE dbo.DataTable
GO
CREATE TABLE dbo.DataTable
(
    id              INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    order_number    INT NOT NULL,
    import_export   NVARCHAR(200),
    gb_number       INT NOT NULL,
    gb_status       INT NOT NULL DEFAULT 0 CHECK(gb_status in (1,2,3,4)),
    [status]        BIT NOT NULL
);
GO

-- Get a list of databases
SELECT name FROM sys.databases
GO
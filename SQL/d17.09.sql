use db1
GO
DROP TABLE  bank
CREATE TABLE  bank
(
    id INT IDENTITY(1,1),
    name VARCHAR(40),
    debit INT,
    kredit INT,
    balance INT
)

-- Create a new stored procedure called 'proc_Insert_Bank' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'proc_Insert_Bank'
)
DROP PROCEDURE dbo.proc_Insert_Bank
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.proc_Insert_Bank
@name VARCHAR(40),
@debit INT,
@kredit INT,
@balance INT
AS
INSERT INTO bank VALUES(@name,@debit,@kredit,@balance);
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.proc_Insert_Bank 'Bank1' , 3000,2000,5000;
EXECUTE dbo.proc_Insert_Bank 'Bank2' , 4000,3000,7000;
EXECUTE dbo.proc_Insert_Bank 'Bank3' , 5000,6000,11000;
EXECUTE dbo.proc_Insert_Bank 'Bank4' , 7000,8000,15000;
EXECUTE dbo.proc_Insert_Bank 'Bank5' , 9000,10000,19000;
EXECUTE dbo.proc_Insert_Bank 'Bank6' , 11000,12000,25000;
EXECUTE dbo.proc_Insert_Bank 'Bank7' , 13000,14000,27000;

GO

CREATE TRIGGER update_balance
ON bank
after update
AS
BEGIN
    UPDATE bank set kredit = balance-debit
END
GO

declare @id table(id int);
UPDATE bank  set  debit = 3000  output inserted.id into @id WHERE id = 1
select * from @id;

select * from bank
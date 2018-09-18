USE db1 

go 

DROP TABLE bank 

CREATE TABLE bank 
  ( 
     id      INT IDENTITY(1, 1), 
     NAME    VARCHAR(40), 
     debit   INT, 
     kredit  INT, 
     balance INT 
  ) 

-- Create a new stored procedure called 'proc_Insert_Bank' in schema 'dbo' 
-- Drop the stored procedure if it already exists 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'proc_Insert_Bank') 
  DROP PROCEDURE dbo.proc_insert_bank 

go 

-- Create the stored procedure in the specified schema 
CREATE PROCEDURE dbo.Proc_insert_bank @name    VARCHAR(40), 
                                      @debit   INT, 
                                      @kredit  INT, 
                                      @balance INT 
AS 
    INSERT INTO bank 
    VALUES     (@name, 
                @debit, 
                @kredit, 
                @balance); 

go 

-- example to execute the stored procedure we just created 
EXECUTE dbo.Proc_insert_bank 
  'Bank1', 
  3000, 
  2000, 
  5000; 

EXECUTE dbo.Proc_insert_bank 
  'Bank2', 
  4000, 
  3000, 
  7000; 

EXECUTE dbo.Proc_insert_bank 
  'Bank3', 
  5000, 
  6000, 
  11000; 

EXECUTE dbo.Proc_insert_bank 
  'Bank4', 
  7000, 
  8000, 
  15000; 

EXECUTE dbo.Proc_insert_bank 
  'Bank5', 
  9000, 
  10000, 
  19000; 

EXECUTE dbo.Proc_insert_bank 
  'Bank6', 
  11000, 
  12000, 
  25000; 

EXECUTE dbo.Proc_insert_bank 
  'Bank7', 
  13000, 
  14000, 
  27000; 

go 

CREATE TRIGGER update_balance 
ON bank 
after UPDATE 
AS 
  BEGIN 
      UPDATE bank 
      SET    kredit = balance - debit 
  END 

go 

DECLARE @id TABLE 
  ( 
     id INT 
  ); 

UPDATE bank 
SET    debit = 3000 
output inserted.id 
INTO @id 
WHERE  id = 1 

SELECT * 
FROM   @id; 

SELECT * 
FROM   bank 
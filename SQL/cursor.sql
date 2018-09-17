use db1
GO
DECLARE my_crusor CURSOR FOR
SELECT name,debit,kredit,balance FROM bank;

OPEN my_crusor;

CLOSE my_crusor;
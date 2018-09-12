use db1;

GO
CREATE FUNCTION [dbo].SumTwoNumbers
(
    @number1 INT,
    @number2 INT
)
RETURNS INT
AS
BEGIN
    DECLARE @sum INT=0;
    SET @sum = @number1 + @number2;
    RETURN @sum;
END
GO

SELECT dbo.SumTwoNumbers(5,7) AS Sum;

GO


CREATE FUNCTION [dbo].AvgAmount()
RETURNS INT
AS
BEGIN
    DECLARE @avg INT = 0;
    SELECT @avg= SUM(amount)
    FROM employee;

    SELECT @avg= @avg / COUNT(amount)
    FROM employee;
    RETURN @avg;
END


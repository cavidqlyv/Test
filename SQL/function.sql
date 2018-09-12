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
GO
SELECT DATENAME(WEEKDAY , GETDATE()) AS weekday
GO

CREATE FUNCTION [dbo].WeekDayAz
(
    @date DATETIME
)
RETURNS VARCHAR(40)
AS
BEGIN
    DECLARE @day VARCHAR(40);
    DECLARE @today VARCHAR(40);

    SELECT @day = DATENAME(WEEKDAY , @date);

    IF @day = 'Sunday'
    BEGIN
        SET @today = 'Bazar';
    END
    ELSE IF @day = 'Wednesday'
    BEGIN
        SET @today = '3-cu gun';
    END

    RETURN @today;
END
GO
SELECT dbo.WeekDayAz(GETDATE());

GO
CREATE FUNCTION dbo.func_employee_amount
(
    @amount int
)
RETURNS TABLE AS RETURN
(
    SELECT *
    FROM employee
    WHERE amount > @amount
)

GO
SELECT * FROM func_employee_amount(23)
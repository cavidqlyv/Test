use db1;

DECLARE @number1 int =6;
DECLARE @number2 int =0;
DECLARE @result int =0;

BEGIN TRY
    SET @result = @number1 / @number2
    PRINT @result;
END TRY
BEGIN CATCH
    PRINT ERROR_STATE()
END CATCH

USE c
SELECT *
FROM student

BEGIN TRY
    DELETE from student where id = 1;
    PRINT 'ok'
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE()
END CATCH

USE db1

DECLARE @contact VARCHAR(20)='123';

BEGIN TRY
    IF LEN(@contact)!=5
    BEGIN
        RAISERROR('contact lenght must be 5' , 11 , 4);
    END
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS message;
    SELECT ERROR_LINE() AS line;
    SELECT ERROR_NUMBER() AS number;
    SELECT ERROR_STATE() AS state;
    SELECT ERROR_SEVERITY() AS severity;
END CATCH
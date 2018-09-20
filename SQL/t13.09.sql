
CREATE FUNCTION dbo.getdate
(
    @day int,
    @month int,
    @year int
)
RETURNS DATE
AS
BEGIN
DECLARE @result DATE = CONVERT(varchar(4) , @year)+'-'+ CONVERT(varchar(2) , @month)+'-'+ CONVERT(varchar(2) , @day)
RETURN @result
END
GO
select dbo.getdate(1,2,2018);

DECLARE @result DATE = CONVERT(varchar(4) , 2018)+'-'+ CONVERT(varchar(2) , 2)+'-'+ CONVERT(varchar(2) ,22)
print @result
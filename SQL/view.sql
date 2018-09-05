use db

select *
from Lesson

INSERT into Lesson
VALUES('Lesson5' , 700 , 1);
GO
CREATE VIEW dbo.LessonPrice
as
    SELECT *
    from dbo.Lesson
    WHERE default_price > 300
GO
select *
FROM LessonPrice

SELECT *
FROM Groupc
GO
CREATE VIEW GroupDayCountPay
as
    SELECT grou_day_count_pay
    FROM Groupc
    WHERE grou_day_count_pay>10
    GO
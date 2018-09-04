use db

select * from Lesson

INSERT into Lesson VALUES('Lesson5' , 700 , 1);

CREATE VIEW dbo.LessonPrice
as SELECT * from dbo.Lesson WHERE default_price > 300

select * FROM LessonPrice
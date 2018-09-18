USE db 

SELECT * 
FROM   lesson 

INSERT INTO lesson 
VALUES     ('Lesson5', 
            700, 
            1); 

go 

CREATE VIEW dbo.lessonprice 
AS 
  SELECT * 
  FROM   dbo.lesson 
  WHERE  default_price > 300 

go 

SELECT * 
FROM   lessonprice 

SELECT * 
FROM   groupc 

go 

CREATE VIEW groupdaycountpay 
AS 
  SELECT grou_day_count_pay 
  FROM   groupc 
  WHERE  grou_day_count_pay > 10 

go 
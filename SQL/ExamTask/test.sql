USE examtask

SELECT * FROM Student;

SELECT * FROM Teacher;

SELECT * FROM Lesson;

SELECT * FROM [group];

SELECT * FROM group_student;


-- Insert Student_Payments 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Student_Payments') 
  DROP PROCEDURE dbo.insert_student_payments 

go 

CREATE PROCEDURE dbo.Insert_student_payments @studentId INT, 
                                             @payment   INT = -1,
                                             @date DATE = '01-01-0001',
                                             @status    BIT = 1 
AS 
   
    IF @payment = -1
    BEGIN
    SET @payment = (SELECT l.price FROM [group] AS g
    JOIN group_student gs ON  g.id = gs.group_id 
    JOIN lesson l ON l.id = g.lesson_id WHERE gs.student_id = @studentId);
    END
    IF @date = '0001-01-01'
    BEGIN
    Select @date =  GETDATE();
    END
    INSERT INTO student_payments 
    VALUES     ( @studentId, 
                 @payment,
                 @date, 
                 @status ); 

go 

EXECUTE Insert_student_payments 1

select * from student_payments

SELECT count(*) FROM student_lessondays

use examtask
SELECT * FROM student

SELECT * FROM teacher

SELECT * FROM lesson

SELECT * FROM [group]


SELECT * FROM group_student

SELECT * FROM student_lessondays

SELECT * FROM student_marks

SELECT * FROM student_payments

SELECT  dateadd(YEAR,2,cast(getDate() as date))
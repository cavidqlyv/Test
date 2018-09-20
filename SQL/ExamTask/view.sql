USE examtask 

go 

CREATE VIEW student_details 
AS 
  SELECT s.NAME      AS StudentName, 
         g.NAME      AS GroupName, 
         l.NAME      AS LessonName, 
         sm.mark     AS Mark, 
         sl.[status] AS Status, 
         sl.[date] 
  FROM   student s 
         JOIN group_student gs 
           ON s.id = gs.student_id 
         JOIN [group] g 
           ON gs.group_id = g.id 
         JOIN lesson l 
           ON g.lesson_id = l.id 
         JOIN student_lessondays sl 
           ON sl.student_id = s.id 
         JOIN student_marks sm 
           ON sm.student_id = s.id 
              AND sm.[date] = sl.[date] 

go 

SELECT * 
FROM   dbo.student_details 

go 

CREATE VIEW dbo.student_teacher_list 
AS 
  SELECT s.NAME AS StudentName, 
         t.NAME AS TEacherName, 
         g.NAME AS GroupName 
  FROM   student s 
         JOIN group_student gs 
           ON s.id = gs.student_id 
         JOIN [group] g 
           ON gs.group_id = g.id 
         JOIN teacher t 
           ON t.id = g.teacher_id 

go 

SELECT * FROM dbo.student_teacher_list
go
CREATE VIEW dbo.group_income 
AS 
  SELECT g.NAME          AS GroupName, 
         Sum(sp.payment) AS Income, 
         sp.[date] 
  FROM   [group] g 
         JOIN group_student AS gs 
           ON g.id = gs.group_id 
         JOIN student_payments AS sp 
           ON gs.student_id = sp.student_id 
  GROUP  BY g.NAME, 
            sp.[date] 

go 

SELECT * FROM group_income

SELECT * FROM student_payments
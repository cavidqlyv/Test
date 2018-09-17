USE examtask 

-- Delete Student 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Student') 
  DROP PROCEDURE dbo.delete_student 

go 

CREATE PROCEDURE dbo.Delete_student @id INT 
AS 
    UPDATE student 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Teacher 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Teacher') 
  DROP PROCEDURE dbo.delete_teacher 

go 

CREATE PROCEDURE dbo.Delete_teacher @id INT 
AS 
    UPDATE teacher 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Lesson 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Lesson') 
  DROP PROCEDURE dbo.delete_lesson 

go 

CREATE PROCEDURE dbo.Delete_lesson @id INT 
AS 
    UPDATE lesson 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Group 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Group') 
  DROP PROCEDURE dbo.delete_group 

go 

CREATE PROCEDURE dbo.Delete_group @id INT 
AS 
    UPDATE dbo.[group] 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Group_Student 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Group_Student') 
  DROP PROCEDURE dbo.delete_group_student 

go 

CREATE PROCEDURE dbo.Delete_group_student @id INT 
AS 
    UPDATE group_student 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Student_Payments 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Student_Payments') 
  DROP PROCEDURE dbo.delete_student_payments 

go 

CREATE PROCEDURE dbo.Delete_student_payments @id INT 
AS 
    UPDATE student_payments 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Student_Marks 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Student_Marks') 
  DROP PROCEDURE dbo.delete_student_marks 

go 

CREATE PROCEDURE dbo.Delete_student_marks @id INT 
AS 
    UPDATE student_marks 
    SET    [status] = 0 
    WHERE  id = @id; 

go 

-- Delete Student_LessonDays 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Delete_Student_LessonDays') 
  DROP PROCEDURE dbo.delete_student_lessondays 

go 

CREATE PROCEDURE dbo.Delete_student_lessondays @id INT 
AS 
    UPDATE student_lessondays 
    SET    [status] = 0 
    WHERE  id = @id; 

go 
USE examtask 
USE master
-- Update Student 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Student') 
  DROP PROCEDURE dbo.update_student 

go 

CREATE PROCEDURE dbo.Update_student @id                INT, 
                                    @name              VARCHAR(40), 
                                    @surname           VARCHAR(40), 
                                    @fin               VARCHAR(10), 
                                    @contact           VARCHAR(20), 
                                    @registration_date DATE, 
                                    @username          VARCHAR(40), 
                                    @password          VARCHAR(40), 
                                    @status            BIT = 1 
AS 
    UPDATE student 
    SET    [name] = @name, 
           surname = @surname, 
           fin = @fin, 
           contact = @contact, 
           registration_date = @registration_date, 
           username = @username, 
           [password] = @password, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Teacher 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Teacher') 
  DROP PROCEDURE dbo.update_teacher 

go 

CREATE PROCEDURE dbo.Update_teacher @id       INT, 
                                    @name     VARCHAR(40), 
                                    @surname  VARCHAR(40), 
                                    @contact  VARCHAR(20), 
                                    @username VARCHAR(40), 
                                    @password VARCHAR(40), 
                                    @status   BIT = 1 
AS 
    UPDATE teacher 
    SET    [name] = @name, 
           surname = @surname, 
           contact = @contact, 
           username = @username, 
           [password] = @password, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Lesson 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Lesson') 
  DROP PROCEDURE dbo.update_lesson 

go 

CREATE PROCEDURE dbo.Update_lesson @id     INT, 
                                   @name   VARCHAR(40), 
                                   @price  INT, 
                                   @status BIT = 1 
AS 
    UPDATE lesson 
    SET    [name] = @name, 
           price = @price, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Group 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Group') 
  DROP PROCEDURE dbo.update_group 

go 

CREATE PROCEDURE dbo.Update_group @id        INT, 
                                  @name      VARCHAR(40), 
                                  @teacherId INT, 
                                  @LessonId  INT, 
                                  @status    BIT = 1 
AS 
    UPDATE [group] 
    SET    [name] = @name, 
           teacher_id = @teacherId, 
           lesson_id = @LessonId, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Group_Student 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Group_Student') 
  DROP PROCEDURE dbo.update_group_student 

go 

CREATE PROCEDURE dbo.Update_group_student @id        INT, 
                                          @studentId INT, 
                                          @groupId   INT, 
                                          @status    BIT = 1 
AS 
    UPDATE group_student 
    SET    student_id = @studentId, 
           group_id = @groupId, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Student_Payments 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Student_Payments') 
  DROP PROCEDURE dbo.update_student_payments 

go 

CREATE PROCEDURE dbo.Update_student_payments @id        INT, 
                                             @studentId INT, 
                                             @payment   DECIMAL(7, 2), 
                                             @status    BIT = 1 
AS 
    UPDATE student_payments 
    SET    student_id = @studentId, 
           payment = @payment, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Student_Marks 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Student_Marks') 
  DROP PROCEDURE dbo.update_student_marks 

go 

CREATE PROCEDURE dbo.Update_student_marks @id        INT, 
                                          @studentId INT, 
                                          @date      DATE, 
                                          @mark      INT, 
                                          @status    BIT = 1 
AS 
    UPDATE student_marks 
    SET    student_id = @studentId, 
           [date] = @date, 
           mark = @mark, 
           [status] = @status 
    WHERE  id = @id 

go 

-- Update Student_LessonDay 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Update_Student_LessonDay') 
  DROP PROCEDURE dbo.update_student_lessonday 

go 

CREATE PROCEDURE dbo.Update_student_lessonday @id            INT, 
                                              @studentId     INT, 
                                              @studentStatus BIT, 
                                              @date          DATE, 
                                              @status        BIT =1 
AS 
    UPDATE student_lessondays 
    SET    student_id = @studentId, 
           student_status = @studentStatus, 
           [date] = @date, 
           [status] = @status 
    WHERE  id = @id 

go 
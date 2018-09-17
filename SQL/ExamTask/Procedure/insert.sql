USE examtask 

-- Insert Rows Student 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Student') 
  DROP PROCEDURE dbo.insert_student 

go 

CREATE PROCEDURE dbo.Insert_student @name              VARCHAR(40), 
                                    @surname           VARCHAR(40), 
                                    @fin               VARCHAR(10), 
                                    @contact           VARCHAR(20), 
                                    @registration_date DATE, 
                                    @username          VARCHAR(40), 
                                    @password          VARCHAR(40), 
                                    @status            BIT = 1 
AS 
    INSERT INTO student 
    VALUES     ( @name, 
                 @surname, 
                 @fin, 
                 @contact, 
                 @registration_date, 
                 @username, 
                 @password, 
                 @status ); 

go 

-- Insert Rows Teacher 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Teacher') 
  DROP PROCEDURE dbo.insert_teacher 

go 

CREATE PROCEDURE dbo.Insert_teacher @name     VARCHAR(40), 
                                    @surname  VARCHAR(40), 
                                    @contact  VARCHAR(20), 
                                    @username VARCHAR(40), 
                                    @password VARCHAR(40), 
                                    @status   BIT = 1 
AS 
    INSERT INTO teacher 
    VALUES     ( @name, 
                 @surname, 
                 @contact, 
                 @username, 
                 @password, 
                 @status ); 

go 

-- Insert Lesson 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Lesson') 
  DROP PROCEDURE dbo.insert_lesson 

go 

CREATE PROCEDURE dbo.Insert_lesson @name   VARCHAR(40), 
                                   @price  INT, 
                                   @status BIT = 1 
AS 
    INSERT INTO lesson 
    VALUES     ( @name, 
                 @price, 
                 @status ); 

go 

-- Insert Group 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Group') 
  DROP PROCEDURE dbo.insert_group 

go 

CREATE PROCEDURE dbo.Insert_group @name      VARCHAR(40), 
                                  @teacherId INT, 
                                  @LessonId  INT, 
                                  @status    BIT = 1 
AS 
    INSERT INTO [group] 
    VALUES     ( @name, 
                 @teacherId, 
                 @lessonId, 
                 @status ); 

go 

-- Insert Group_Student 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Group_Student') 
  DROP PROCEDURE dbo.insert_group_student 

go 

CREATE PROCEDURE dbo.Insert_group_student @studentId INT, 
                                          @groupId   INT, 
                                          @status    BIT = 1 
AS 
    INSERT INTO group_student 
    VALUES     ( @studentId, 
                 @groupId, 
                 @status ); 

go 

-- Insert Student_Payments 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Student_Payments') 
  DROP PROCEDURE dbo.insert_student_payments 

go 

CREATE PROCEDURE dbo.Insert_student_payments @studentId INT, 
                                             @payment   DECIMAL(7, 2), 
                                             @status    BIT = 1 
AS 
    INSERT INTO student_payments 
    VALUES     ( @studentId, 
                 @payment, 
                 @status ); 

go 

-- Insert Student_Marks 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Student_Marks') 
  DROP PROCEDURE dbo.insert_student_marks 

go 

CREATE PROCEDURE dbo.Insert_student_marks @studentId INT, 
                                          @date      DATE, 
                                          @mark      INT, 
                                          @status    BIT = 1 
AS 
    INSERT INTO student_marks 
    VALUES     ( @studentId, 
                 @date, 
                 @mark, 
                 @status ); 

go 

-- Insert Student_LessonDay 
IF EXISTS (SELECT * 
           FROM   information_schema.routines 
           WHERE  specific_schema = N'dbo' 
                  AND specific_name = N'Insert_Student_LessonDay') 
  DROP PROCEDURE dbo.insert_student_lessonday 

go 

CREATE PROCEDURE dbo.Insert_student_lessonday @studentId     INT, 
                                              @studentStatus BIT, 
                                              @date          DATE, 
                                              @status        BIT =1 
AS 
    INSERT INTO student_lesssondays 
    VALUES     ( @studentId, 
                 @studentStatus, 
                 @date, 
                 @status ); 

go
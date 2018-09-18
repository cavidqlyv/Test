USE master 

go 

IF EXISTS (SELECT NAME 
           FROM   sys.databases 
           WHERE  NAME = N'ExamTask') 
ALTER DATABASE examtask SET  SINGLE_USER WITH ROLLBACK IMMEDIATE

  DROP DATABASE examtask 

go 

USE master 

go 

IF NOT EXISTS (SELECT NAME 
               FROM   sys.databases 
               WHERE  NAME = N'ExamTask') 
  CREATE DATABASE examtask 

go 

USE examtask 

go 

IF Object_id('dbo.Student', 'U') IS NOT NULL 
  DROP TABLE dbo.student 

go 

CREATE TABLE dbo.student 
  ( 
     id                INT PRIMARY KEY IDENTITY(1, 1), 
     [name]            VARCHAR(40) NOT NULL, 
     surname           VARCHAR(40) NOT NULL, 
     fin               VARCHAR(10) NOT NULL UNIQUE, 
     contact           VARCHAR(20) NOT NULL, 
     registration_date DATE NOT NULL, 
     username          VARCHAR(40) NOT NULL UNIQUE, 
     [password]        VARCHAR(40) NOT NULL, 
     [status]          BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Teacher', 'U') IS NOT NULL 
  DROP TABLE dbo.teacher 

go 

CREATE TABLE dbo.teacher 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     [name]     VARCHAR(40) NOT NULL, 
     surname    VARCHAR(40) NOT NULL, 
     contact    VARCHAR(20) NOT NULL, 
     username   VARCHAR(40) NOT NULL UNIQUE, 
     [password] VARCHAR(40) NOT NULL, 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Lesson', 'U') IS NOT NULL 
  DROP TABLE dbo.lesson 

go 

CREATE TABLE dbo.lesson 
  ( 
     id       INT PRIMARY KEY IDENTITY(1, 1), 
     [name]   NVARCHAR(40) NOT NULL, 
     price    INT NOT NULL, 
     [status] BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Group', 'U') IS NOT NULL 
  DROP TABLE dbo.[group] 

go 

CREATE TABLE dbo.[group] 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     [name]     NVARCHAR(50) NOT NULL UNIQUE, 
     teacher_id INT CONSTRAINT fk_group_teacher_id FOREIGN KEY REFERENCES 
     teacher(id), 
     lesson_id  INT CONSTRAINT fk_group_lesson_id FOREIGN KEY REFERENCES lesson( 
     id), 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Group_Student', 'U') IS NOT NULL 
  DROP TABLE dbo.group_student 

go 

CREATE TABLE dbo.group_student 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     student_id INT CONSTRAINT fk_groupstudent_student_id FOREIGN KEY REFERENCES 
     student(id), 
     group_id   INT CONSTRAINT fk_groupstudent_group_id FOREIGN KEY REFERENCES 
     [group]( 
     id), 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Student_Payments', 'U') IS NOT NULL 
  DROP TABLE dbo.student_payments 

go 

CREATE TABLE dbo.student_payments 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     student_id INT CONSTRAINT fk_studentpayments_student_id FOREIGN KEY 
     REFERENCES 
     student(id), 
     payment    DECIMAL(7, 2) NOT NULL, 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Student_Marks', 'U') IS NOT NULL 
  DROP TABLE dbo.student_marks 

go 

CREATE TABLE dbo.student_marks 
  ( 
     id         INT PRIMARY KEY IDENTITY(1, 1), 
     student_id INT CONSTRAINT fk_studentmarks_student_id FOREIGN KEY REFERENCES 
     student(id), 
     [date]     DATE NOT NULL, 
     mark       INT NOT NULL, 
     [status]   BIT DEFAULT 1 
  ); 

go 

IF Object_id('dbo.Student_LessonDay', 'U') IS NOT NULL 
  DROP TABLE dbo.student_lessondays 

go 

CREATE TABLE dbo.student_lessondays 
  ( 
     id             INT PRIMARY KEY IDENTITY(1, 1), 
     student_id     INT CONSTRAINT fk_studentlessondays_student_id FOREIGN KEY 
     REFERENCES 
     student(id), 
     student_status BIT NOT NULL, 
     [date]         DATE NOT NULL, 
     [status]       BIT DEFAULT 1 
  ); 

go 


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


USE examtask 

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


USE examtask

EXECUTE dbo.Insert_student 
  'Hamlin', 
  'Gawthorp', 
  '5303884781', 
  'hgawthorp0@vinaora.com', 
  '2017-12-02', 
  'hgawthorp0', 
  'X1aILVov5'; 

EXECUTE dbo.Insert_student 
  'Nananne', 
  'Mudie', 
  '7606455538', 
  'nmudie1@addthis.com', 
  '2018-09-14', 
  'nmudie1', 
  'TQkytB13kzrX'; 

EXECUTE dbo.Insert_student 
  'Darbee', 
  'Crummey', 
  '5642921684', 
  'dcrummey2@bbb.org', 
  '2018-02-03', 
  'dcrummey2', 
  'UIk2MR9lL'; 

EXECUTE dbo.Insert_student 
  'Aldwin', 
  'Scandrite', 
  '0897025722', 
  'ascandrite3@epa.gov', 
  '2017-12-30', 
  'ascandrite3', 
  'KoUKheswj9kw'; 

EXECUTE dbo.Insert_student 
  'Illa', 
  'Billes', 
  '9650074992', 
  'ibilles4@nature.com', 
  '2018-08-25', 
  'ibilles4', 
  'bJtVVt'; 

EXECUTE dbo.Insert_student 
  'Coop', 
  'Hutcheon', 
  '4474876871', 
  'chutcheon5@weebly.com', 
  '2017-09-28', 
  'chutcheon5', 
  'oJrsuDUy1qN'; 

EXECUTE dbo.Insert_student 
  'Joelle', 
  'Norsworthy', 
  '6914355094', 
  'jnorsworthy6@liveinternet.ru', 
  '2018-04-03', 
  'jnorsworthy6', 
  '6mhQMWPPb'; 

EXECUTE dbo.Insert_student 
  'Haslett', 
  'Bredes', 
  '1299681197', 
  'hbredes7@tiny.cc', 
  '2018-05-02', 
  'hbredes7', 
  'T0XqohlQPQ'; 

EXECUTE dbo.Insert_student 
  'Jonis', 
  'Willford', 
  '6501511034', 
  'jwillford8@dailymail.co.uk', 
  '2017-10-16', 
  'jwillford8', 
  'qgYddw8N'; 

EXECUTE dbo.Insert_student 
  'Vergil', 
  'Cromie', 
  '8608123061', 
  'vcromie9@cbsnews.com', 
  '2018-04-29', 
  'vcromie9', 
  'bCuFs1x5V0'; 

EXECUTE dbo.Insert_student 
  'Daffy', 
  'Pennicard', 
  '3008106289', 
  'dpennicarda@ihg.com', 
  '2018-01-14', 
  'dpennicarda', 
  'TfFRd9lsx'; 

EXECUTE dbo.Insert_student 
  'Stinky', 
  'Gildroy', 
  '6122587304', 
  'sgildroyb@newyorker.com', 
  '2018-06-16', 
  'sgildroyb', 
  'VxRwKzAQnjI'; 

EXECUTE dbo.Insert_student 
  'Aila', 
  'De Maine', 
  '2514046530', 
  'ademainec@twitter.com', 
  '2017-10-11', 
  'ademainec', 
  'jXPKjny51'; 

EXECUTE dbo.Insert_student 
  'Corty', 
  'Lowmass', 
  '8168335804', 
  'clowmassd@sciencedirect.com', 
  '2017-09-17', 
  'clowmassd', 
  'FmAtb3I1D'; 

EXECUTE dbo.Insert_student 
  'Greta', 
  'Lideard', 
  '4379635686', 
  'glidearde@forbes.com', 
  '2018-05-22', 
  'glidearde', 
  'zY2ZLfy'; 

EXECUTE dbo.Insert_student 
  'Farlie', 
  'Ryman', 
  '9765490192', 
  'frymanf@phpbb.com', 
  '2018-04-05', 
  'frymanf', 
  'WAo8tdj29Ij'; 

EXECUTE dbo.Insert_student 
  'Nels', 
  'McPherson', 
  '9852577972', 
  'nmcphersong@bloglines.com', 
  '2018-08-16', 
  'nmcphersong', 
  'dwjqrce7'; 

EXECUTE dbo.Insert_student 
  'Izaak', 
  'Leftley', 
  '7980458812', 
  'ileftleyh@shinystat.com', 
  '2018-01-11', 
  'ileftleyh', 
  'eTHXmUn'; 

EXECUTE dbo.Insert_student 
  'Federica', 
  'Glusby', 
  '3099652865', 
  'fglusbyi@accuweather.com', 
  '2018-07-11', 
  'fglusbyi', 
  'i0u1fd42E'; 

EXECUTE dbo.Insert_student 
  'Fania', 
  'Stoter', 
  '9088009702', 
  'fstoterj@ustream.tv', 
  '2018-01-24', 
  'fstoterj', 
  'l01Thu'; 

EXECUTE dbo.Insert_student 
  'Patty', 
  'Anand', 
  '9708894239', 
  'panandk@wikispaces.com', 
  '2018-08-05', 
  'panandk', 
  'sOuATEY2Q'; 

EXECUTE dbo.Insert_student 
  'Bellanca', 
  'McGurgan', 
  '0773536389', 
  'bmcgurganl@xinhuanet.com', 
  '2018-02-11', 
  'bmcgurganl', 
  'zMgPzM5vH'; 

EXECUTE dbo.Insert_student 
  'Eduardo', 
  'Extall', 
  '3233304038', 
  'eextallm@amazon.de', 
  '2018-07-21', 
  'eextallm', 
  'IXpa8qgdJveQ'; 

EXECUTE dbo.Insert_student 
  'Agustin', 
  'Woodhead', 
  '0158656358', 
  'awoodheadn@bing.com', 
  '2018-07-09', 
  'awoodheadn', 
  'R7WiJbKz'; 

EXECUTE dbo.Insert_student 
  'Janie', 
  'Gilleson', 
  '7296678692', 
  'jgillesono@disqus.com', 
  '2017-09-30', 
  'jgillesono', 
  'WdvAM0yNgJk'; 

EXECUTE dbo.Insert_student 
  'Kurt', 
  'McGrann', 
  '6427211255', 
  'kmcgrannp@ihg.com', 
  '2017-11-21', 
  'kmcgrannp', 
  'G00i36ROjIW'; 

EXECUTE dbo.Insert_student 
  'Karl', 
  'Sans', 
  '6331988700', 
  'ksansq@biblegateway.com', 
  '2018-02-13', 
  'ksansq', 
  'GCSOeE0kTsi'; 

EXECUTE dbo.Insert_student 
  'Jocelyne', 
  'McGarrie', 
  '5667850904', 
  'jmcgarrier@acquirethisname.com', 
  '2017-11-22', 
  'jmcgarrier', 
  'Ml8qyG1jQCl0'; 

EXECUTE dbo.Insert_student 
  'Diarmid', 
  'Himsworth', 
  '8021582286', 
  'dhimsworths@buzzfeed.com', 
  '2018-07-05', 
  'dhimsworths', 
  'WpbDYXNQtk'; 

EXECUTE dbo.Insert_student 
  'Hort', 
  'Escott', 
  '7926158096', 
  'hescottt@china.com.cn', 
  '2017-10-19', 
  'hescottt', 
  'DkHNyb'; 

EXECUTE dbo.Insert_student 
  'Thayne', 
  'Simka', 
  '8136806348', 
  'tsimkau@devhub.com', 
  '2017-11-13', 
  'tsimkau', 
  'kRn6ALBi1'; 

EXECUTE dbo.Insert_student 
  'Priscella', 
  'Cund', 
  '5443246770', 
  'pcundv@discuz.net', 
  '2017-12-07', 
  'pcundv', 
  'gzK7mrgv'; 

EXECUTE dbo.Insert_student 
  'Tildi', 
  'Furphy', 
  '8048548768', 
  'tfurphyw@vinaora.com', 
  '2017-09-29', 
  'tfurphyw', 
  'zKGIEX'; 

EXECUTE dbo.Insert_student 
  'Deane', 
  'Lindenbluth', 
  '4156773051', 
  'dlindenbluthx@netscape.com', 
  '2017-09-23', 
  'dlindenbluthx', 
  'dKqB05'; 

EXECUTE dbo.Insert_student 
  'Quinlan', 
  'Seago', 
  '9844454410', 
  'qseagoy@storify.com', 
  '2018-04-27', 
  'qseagoy', 
  'QYfk4n8YaOi'; 

EXECUTE dbo.Insert_student 
  'Fritz', 
  'Deinhardt', 
  '8775697344', 
  'fdeinhardtz@sphinn.com', 
  '2017-10-16', 
  'fdeinhardtz', 
  'NqSPwX'; 

EXECUTE dbo.Insert_student 
  'Barbe', 
  'Craxford', 
  '1422459110', 
  'bcraxford10@geocities.com', 
  '2018-03-01', 
  'bcraxford10', 
  '1Sn7kXjbGHT'; 

EXECUTE dbo.Insert_student 
  'Jerrold', 
  'O''Keefe', 
  '8163225600', 
  'jokeefe11@php.net', 
  '2018-02-28', 
  'jokeefe11', 
  'a0aWQuOkgtG'; 

EXECUTE dbo.Insert_student 
  'Benni', 
  'Pellington', 
  '7619646817', 
  'bpellington12@opensource.org', 
  '2017-09-25', 
  'bpellington12', 
  'sySLkMDCJdM'; 

EXECUTE dbo.Insert_student 
  'Montgomery', 
  'Milham', 
  '8252609267', 
  'mmilham13@php.net', 
  '2017-10-13', 
  'mmilham13', 
  'tBcIn13ZaaP'; 

EXECUTE dbo.Insert_student 
  'Patrica', 
  'Union', 
  '7264172145', 
  'punion14@feedburner.com', 
  '2018-05-16', 
  'punion14', 
  'ptLwfjWGw'; 

EXECUTE dbo.Insert_student 
  'Jo', 
  'Sonley', 
  '0682830446', 
  'jsonley15@forbes.com', 
  '2017-12-10', 
  'jsonley15', 
  'g6omBiP5Q'; 

EXECUTE dbo.Insert_student 
  'Lina', 
  'Dahmel', 
  '4329785573', 
  'ldahmel16@so-net.ne.jp', 
  '2018-06-29', 
  'ldahmel16', 
  '9keBs2tT'; 

EXECUTE dbo.Insert_student 
  'Manny', 
  'Cadd', 
  '9438449309', 
  'mcadd17@quantcast.com', 
  '2018-01-11', 
  'mcadd17', 
  'AXcRqt36I'; 

EXECUTE dbo.Insert_student 
  'Carlos', 
  'Ballentime', 
  '6227351201', 
  'cballentime18@jigsy.com', 
  '2018-08-04', 
  'cballentime18', 
  'i7KWrhqd'; 

EXECUTE dbo.Insert_student 
  'Tamas', 
  'Almack', 
  '7008997467', 
  'talmack19@cdbaby.com', 
  '2018-01-01', 
  'talmack19', 
  'xYUFM4t78'; 

EXECUTE dbo.Insert_student 
  'Sauncho', 
  'Barnewille', 
  '4562453535', 
  'sbarnewille1a@loc.gov', 
  '2017-12-30', 
  'sbarnewille1a', 
  'C4F4ldgkuNsh'; 

EXECUTE dbo.Insert_student 
  'Flss', 
  'Petrov', 
  '7337898274', 
  'fpetrov1b@reference.com', 
  '2018-01-10', 
  'fpetrov1b', 
  'efnBdd717v0'; 

EXECUTE dbo.Insert_student 
  'Rayna', 
  'Peniman', 
  '9427742707', 
  'rpeniman1c@pagesperso-orange.fr', 
  '2018-03-16', 
  'rpeniman1c', 
  'yFalVfg3bOX'; 

EXECUTE dbo.Insert_student 
  'Jewell', 
  'Izakson', 
  '5012190112', 
  'jizakson1d@bloglovin.com', 
  '2018-07-19', 
  'jizakson1d', 
  'HE8bOpdU9U'; 

EXECUTE dbo.Insert_student 
  'Maegan', 
  'Shewring', 
  '8487114038', 
  'mshewring1e@umn.edu', 
  '2017-09-19', 
  'mshewring1e', 
  'qF9XNhF'; 

EXECUTE dbo.Insert_student 
  'Krisha', 
  'Gebb', 
  '6483590096', 
  'kgebb1f@cbsnews.com', 
  '2017-12-31', 
  'kgebb1f', 
  'O6KmuI5NPqk'; 

EXECUTE dbo.Insert_student 
  'Hermina', 
  'Ricardo', 
  '7216565690', 
  'hricardo1g@reuters.com', 
  '2018-04-18', 
  'hricardo1g', 
  'k6K2EC'; 

EXECUTE dbo.Insert_student 
  'Felic', 
  'Maskew', 
  '5790682001', 
  'fmaskew1h@plala.or.jp', 
  '2018-06-09', 
  'fmaskew1h', 
  'Pn3FlqSK'; 

EXECUTE dbo.Insert_student 
  'Tiffie', 
  'Siggee', 
  '8599237422', 
  'tsiggee1i@cbsnews.com', 
  '2018-03-05', 
  'tsiggee1i', 
  '2w1Yyz4eE2'; 

EXECUTE dbo.Insert_student 
  'Dot', 
  'Galia', 
  '1060749954', 
  'dgalia1j@seesaa.net', 
  '2017-10-14', 
  'dgalia1j', 
  'OnPVkx'; 

EXECUTE dbo.Insert_student 
  'Ragnar', 
  'Ilieve', 
  '3090835737', 
  'rilieve1k@senate.gov', 
  '2018-06-20', 
  'rilieve1k', 
  'hg5twMCT'; 

EXECUTE dbo.Insert_student 
  'Neille', 
  'Banner', 
  '6343057202', 
  'nbanner1l@ucoz.ru', 
  '2018-01-05', 
  'nbanner1l', 
  '9075Bd'; 

EXECUTE dbo.Insert_student 
  'Rania', 
  'Sperwell', 
  '8383623296', 
  'rsperwell1m@miitbeian.gov.cn', 
  '2017-12-05', 
  'rsperwell1m', 
  'VicfgjFDRQGB'; 

EXECUTE dbo.Insert_student 
  'Julee', 
  'Boreham', 
  '8037719779', 
  'jboreham1n@answers.com', 
  '2017-11-30', 
  'jboreham1n', 
  'Z2gz1QN6Eyh8'; 

EXECUTE dbo.Insert_student 
  'Robena', 
  'Mithun', 
  '9285599654', 
  'rmithun1o@netscape.com', 
  '2018-05-09', 
  'rmithun1o', 
  'ixfc19PEvonb'; 

EXECUTE dbo.Insert_student 
  'Andriana', 
  'Milillo', 
  '9136979514', 
  'amilillo1p@goo.gl', 
  '2018-01-15', 
  'amilillo1p', 
  'J0ANGRS4okB'; 

EXECUTE dbo.Insert_student 
  'Rick', 
  'Boddymead', 
  '8987795840', 
  'rboddymead1q@walmart.com', 
  '2017-10-25', 
  'rboddymead1q', 
  'P7kLiUTGQN'; 

EXECUTE dbo.Insert_student 
  'Darcy', 
  'Spurdon', 
  '8579154034', 
  'dspurdon1r@sun.com', 
  '2018-06-18', 
  'dspurdon1r', 
  'lxcbPm'; 

EXECUTE dbo.Insert_student 
  'Veronike', 
  'McNab', 
  '8644711942', 
  'vmcnab1s@wired.com', 
  '2018-02-14', 
  'vmcnab1s', 
  '1Ll7Bq'; 

EXECUTE dbo.Insert_student 
  'Mychal', 
  'Adkins', 
  '6312796900', 
  'madkins1t@scientificamerican.com', 
  '2018-06-29', 
  'madkins1t', 
  'MKR0OHQaJf'; 

EXECUTE dbo.Insert_student 
  'Fiorenze', 
  'Willerton', 
  '4965919000', 
  'fwillerton1u@hhs.gov', 
  '2018-01-09', 
  'fwillerton1u', 
  'lMHM67nI'; 

EXECUTE dbo.Insert_student 
  'Evonne', 
  'Colqueran', 
  '8901020217', 
  'ecolqueran1v@creativecommons.org', 
  '2018-02-06', 
  'ecolqueran1v', 
  'wva1Odm'; 

EXECUTE dbo.Insert_student 
  'Starla', 
  'Sieb', 
  '6617018887', 
  'ssieb1w@blog.com', 
  '2018-08-12', 
  'ssieb1w', 
  'n2gcYhu9v66'; 

EXECUTE dbo.Insert_student 
  'Rosco', 
  'Greensides', 
  '5552838864', 
  'rgreensides1x@comcast.net', 
  '2018-04-26', 
  'rgreensides1x', 
  'mXIsOlhx'; 

EXECUTE dbo.Insert_student 
  'Bartholemy', 
  'Beardall', 
  '7058089662', 
  'bbeardall1y@scribd.com', 
  '2018-09-14', 
  'bbeardall1y', 
  'RWecWr6'; 

EXECUTE dbo.Insert_student 
  'Lesley', 
  'Giacomuzzo', 
  '7225267532', 
  'lgiacomuzzo1z@slate.com', 
  '2018-05-30', 
  'lgiacomuzzo1z', 
  'u55DLnm'; 

EXECUTE dbo.Insert_student 
  'Ezmeralda', 
  'Cochet', 
  '9841739332', 
  'ecochet20@chronoengine.com', 
  '2018-08-01', 
  'ecochet20', 
  'D5A58dxi5'; 

EXECUTE dbo.Insert_student 
  'Moyna', 
  'Meale', 
  '4209452225', 
  'mmeale21@free.fr', 
  '2018-08-25', 
  'mmeale21', 
  'qVzweONsan'; 

EXECUTE dbo.Insert_student 
  'Celestina', 
  'Glover', 
  '4533696455', 
  'cglover22@blogtalkradio.com', 
  '2018-07-20', 
  'cglover22', 
  'oNJgOI'; 

EXECUTE dbo.Insert_student 
  'Katherina', 
  'McGonigal', 
  '5854726923', 
  'kmcgonigal23@vkontakte.ru', 
  '2018-02-06', 
  'kmcgonigal23', 
  'OKcvcwCe'; 

EXECUTE dbo.Insert_student 
  'Corri', 
  'Brewin', 
  '8790629384', 
  'cbrewin24@over-blog.com', 
  '2017-09-27', 
  'cbrewin24', 
  'lDJ1e0K'; 

EXECUTE dbo.Insert_student 
  'Tyson', 
  'Hubbucke', 
  '7749566708', 
  'thubbucke25@drupal.org', 
  '2018-07-01', 
  'thubbucke25', 
  'Xt1KWmOrwirS'; 

EXECUTE dbo.Insert_student 
  'Elnora', 
  'Vallentin', 
  '9308117390', 
  'evallentin26@multiply.com', 
  '2017-10-05', 
  'evallentin26', 
  'BWwn8s'; 

EXECUTE dbo.Insert_student 
  'Waldemar', 
  'Scothorn', 
  '5130990650', 
  'wscothorn27@deviantart.com', 
  '2018-05-23', 
  'wscothorn27', 
  'kDGoujg3kiR'; 

EXECUTE dbo.Insert_student 
  'Eleonora', 
  'Hancke', 
  '6518010260', 
  'ehancke28@ibm.com', 
  '2018-03-21', 
  'ehancke28', 
  'S2Xjt36DE'; 

EXECUTE dbo.Insert_student 
  'Zsazsa', 
  'Kleinerman', 
  '0197447674', 
  'zkleinerman29@chronoengine.com', 
  '2018-04-13', 
  'zkleinerman29', 
  'uboNVlMIRh5'; 

EXECUTE dbo.Insert_student 
  'Fanechka', 
  'Grelka', 
  '4770301405', 
  'fgrelka2a@squidoo.com', 
  '2018-01-15', 
  'fgrelka2a', 
  '1BCSGXaW'; 

EXECUTE dbo.Insert_student 
  'Devondra', 
  'Paule', 
  '0092542321', 
  'dpaule2b@digg.com', 
  '2018-08-07', 
  'dpaule2b', 
  'ClbiCSKxs'; 

EXECUTE dbo.Insert_student 
  'Alyse', 
  'Murray', 
  '4091879734', 
  'amurray2c@dailymotion.com', 
  '2018-03-23', 
  'amurray2c', 
  'NPWjpww'; 

EXECUTE dbo.Insert_student 
  'Jacenta', 
  'Ivshin', 
  '7232208874', 
  'jivshin2d@prnewswire.com', 
  '2018-08-25', 
  'jivshin2d', 
  'dG686mCa'; 

EXECUTE dbo.Insert_student 
  'Conrado', 
  'Creasey', 
  '9591880766', 
  'ccreasey2e@hibu.com', 
  '2018-04-08', 
  'ccreasey2e', 
  'aX6SFun6jALa'; 

EXECUTE dbo.Insert_student 
  'Clotilda', 
  'Clampton', 
  '3445607711', 
  'cclampton2f@spiegel.de', 
  '2017-10-15', 
  'cclampton2f', 
  'oMOAUoI'; 

EXECUTE dbo.Insert_student 
  'Lesly', 
  'Killoran', 
  '9684137592', 
  'lkilloran2g@sphinn.com', 
  '2018-02-04', 
  'lkilloran2g', 
  'Ibzf31SkfQAK'; 

EXECUTE dbo.Insert_student 
  'Briggs', 
  'Lehrmann', 
  '5681504260', 
  'blehrmann2h@gnu.org', 
  '2017-11-01', 
  'blehrmann2h', 
  '1ZFm7Fq6Qi'; 

EXECUTE dbo.Insert_student 
  'Hagan', 
  'Borris', 
  '9815919736', 
  'hborris2i@163.com', 
  '2017-10-14', 
  'hborris2i', 
  '5JrhaZhGjEF'; 

EXECUTE dbo.Insert_student 
  'Manya', 
  'Eaton', 
  '8397548086', 
  'meaton2j@google.co.jp', 
  '2018-09-10', 
  'meaton2j', 
  'tHG8nN'; 

EXECUTE dbo.Insert_student 
  'Kayne', 
  'Dornin', 
  '1051154174', 
  'kdornin2k@comcast.net', 
  '2018-05-10', 
  'kdornin2k', 
  'ZAxhNz61'; 

EXECUTE dbo.Insert_student 
  'Chad', 
  'Dudin', 
  '6716233913', 
  'cdudin2l@example.com', 
  '2018-01-12', 
  'cdudin2l', 
  'MPUbATc9TJ'; 

EXECUTE dbo.Insert_student 
  'Mufinella', 
  'Glyne', 
  '3993111873', 
  'mglyne2m@example.com', 
  '2017-11-10', 
  'mglyne2m', 
  'nIdjMYN'; 

EXECUTE dbo.Insert_student 
  'Otis', 
  'Stango', 
  '0672037676', 
  'ostango2n@shop-pro.jp', 
  '2018-07-01', 
  'ostango2n', 
  'IO1f9n6'; 

EXECUTE dbo.Insert_student 
  'George', 
  'Dochon', 
  '2418647649', 
  'gdochon2o@weebly.com', 
  '2018-07-16', 
  'gdochon2o', 
  'F8MPxj9Z'; 

EXECUTE dbo.Insert_student 
  'Ronnica', 
  'Kenelin', 
  '3761310082', 
  'rkenelin2p@nsw.gov.au', 
  '2018-01-26', 
  'rkenelin2p', 
  'ezOPu80YYy9'; 

EXECUTE dbo.Insert_student 
  'Niall', 
  'Dicty', 
  '2287659434', 
  'ndicty2q@de.vu', 
  '2017-11-29', 
  'ndicty2q', 
  'daI7hj6TNSZv'; 

EXECUTE dbo.Insert_student 
  'Steward', 
  'Coleford', 
  '7831703672', 
  'scoleford2r@amazon.de', 
  '2017-10-02', 
  'scoleford2r', 
  'otvB2P7'; 


----------------------------------------------

USE examtask

EXECUTE dbo.Insert_teacher 
  'Lissie', 
  'Hull', 
  'lhull0@xing.com', 
  'lhull0', 
  'du0aALD'; 

EXECUTE dbo.Insert_teacher 
  'Forster', 
  'Phillins', 
  'fphillins1@ezinearticles.com', 
  'fphillins1', 
  'gUPDzLDT1aze'; 

EXECUTE dbo.Insert_teacher 
  'Burke', 
  'Bedo', 
  'bbedo2@rakuten.co.jp', 
  'bbedo2', 
  '9qFNUAHwAVN'; 

EXECUTE dbo.Insert_teacher 
  'Ingrid', 
  'Grote', 
  'igrote3@friendfeed.com', 
  'igrote3', 
  'AElZZCM'; 

EXECUTE dbo.Insert_teacher 
  'Emmaline', 
  'Greasty', 
  'egreasty4@jalbum.net', 
  'egreasty4', 
  'KLkboU7AzRq'; 

EXECUTE dbo.Insert_teacher 
  'Karl', 
  'Wilacot', 
  'kwilacot5@miitbeian.gov.cn', 
  'kwilacot5', 
  'FQqRE5A'; 

EXECUTE dbo.Insert_teacher 
  'Robinetta', 
  'Rikkard', 
  'rrikkard6@free.fr', 
  'rrikkard6', 
  'SH7Cz89T'; 

EXECUTE dbo.Insert_teacher 
  'Trixi', 
  'Yanukhin', 
  'tyanukhin7@hubpages.com', 
  'tyanukhin7', 
  'u0KXMIf'; 

EXECUTE dbo.Insert_teacher 
  'Denys', 
  'Davidwitz', 
  'ddavidwitz8@phoca.cz', 
  'ddavidwitz8', 
  '3G6uSKf9gFrj'; 

EXECUTE dbo.Insert_teacher 
  'Joanie', 
  'Duxbarry', 
  'jduxbarry9@oaic.gov.au', 
  'jduxbarry9', 
  'wKhGIuRdv'; 

EXECUTE dbo.Insert_teacher 
  'Leta', 
  'Elis', 
  'lelisa@dot.gov', 
  'lelisa', 
  'imeaLo0t'; 

EXECUTE dbo.Insert_teacher 
  'Buckie', 
  'Gourley', 
  'bgourleyb@ft.com', 
  'bgourleyb', 
  '3isXS4j1NKV'; 

EXECUTE dbo.Insert_teacher 
  'Antoine', 
  'Echallie', 
  'aechalliec@gizmodo.com', 
  'aechalliec', 
  'eQvvutDRT0'; 

EXECUTE dbo.Insert_teacher 
  'Juditha', 
  'Disbury', 
  'jdisburyd@facebook.com', 
  'jdisburyd', 
  'h49bAMX8AoN'; 

EXECUTE dbo.Insert_teacher 
  'Meier', 
  'Monteath', 
  'mmonteathe@princeton.edu', 
  'mmonteathe', 
  'D03nYet3Jv'; 

EXECUTE dbo.Insert_teacher 
  'Frances', 
  'Jobbins', 
  'fjobbinsf@blinklist.com', 
  'fjobbinsf', 
  'WTi1y4mxkNK0'; 

EXECUTE dbo.Insert_teacher 
  'Wiatt', 
  'Crothers', 
  'wcrothersg@acquirethisname.com', 
  'wcrothersg', 
  'H8K9Zf2G6mAk'; 

EXECUTE dbo.Insert_teacher 
  'Margaret', 
  'Blumer', 
  'mblumerh@yellowpages.com', 
  'mblumerh', 
  'ToolOg6'; 

EXECUTE dbo.Insert_teacher 
  'Lance', 
  'Hachard', 
  'lhachardi@paypal.com', 
  'lhachardi', 
  '0sHnfT'; 

EXECUTE dbo.Insert_teacher 
  'Luther', 
  'Staddon', 
  'lstaddonj@wikimedia.org', 
  'lstaddonj', 
  'BeNgaMx'; 

SELECT * 
FROM   teacher 


--------------------------------------

USE examtask

EXECUTE dbo.Insert_lesson 
  'Desktop Support Technician', 
  300; 

EXECUTE dbo.Insert_lesson 
  'Marketing Assistant', 
  350; 

EXECUTE dbo.Insert_lesson 
  'Environmental Specialist', 
  550; 

EXECUTE dbo.Insert_lesson 
  'Food Chemist', 
  200; 

EXECUTE dbo.Insert_lesson 
  'Financial Advisor', 
  300; 

EXECUTE dbo.Insert_lesson 
  'Administrative Assistant I', 
  250; 

EXECUTE dbo.Insert_lesson 
  'Technical Writer', 
  650; 

EXECUTE dbo.Insert_lesson 
  'Senior Cost Accountant', 
  750; 

EXECUTE dbo.Insert_lesson 
  'Recruiting Manager', 
  350; 

EXECUTE dbo.Insert_lesson 
  'Chemical Engineer', 
  150; 

EXECUTE dbo.Insert_lesson 
  'Senior Editor', 
  500; 

EXECUTE dbo.Insert_lesson 
  'Director of Sales', 
  400; 

EXECUTE dbo.Insert_lesson 
  'Assistant Professor', 
  300; 

EXECUTE dbo.Insert_lesson 
  'Financial Analyst', 
  200; 

EXECUTE dbo.Insert_lesson 
  'Developer IV', 
  250; 

EXECUTE dbo.Insert_lesson 
  'Legal Assistant', 
  550; 

EXECUTE dbo.Insert_lesson 
  'VP Quality Control', 
  400; 

EXECUTE dbo.Insert_lesson 
  'Operator', 
  500; 

EXECUTE dbo.Insert_lesson 
  'Recruiter', 
  600; 

EXECUTE dbo.Insert_lesson 
  'Mechanical Systems Engineer', 
  700; 

SELECT * 
FROM   lesson 


USE examtask

EXECUTE dbo.Insert_Group 'jivanyushin0', 16, 17;
EXECUTE dbo.Insert_Group 'dkytter1', 1, 10;
EXECUTE dbo.Insert_Group 'smularkey2', 1, 8;
EXECUTE dbo.Insert_Group 'lmullinger3', 15, 18;
EXECUTE dbo.Insert_Group 'kblackster4', 5, 19;
EXECUTE dbo.Insert_Group 'mandrasch5', 14, 1;
EXECUTE dbo.Insert_Group 'avallack6', 16, 16;
EXECUTE dbo.Insert_Group 'nbettleson7', 11, 11;
EXECUTE dbo.Insert_Group 'lhryskiewicz8', 7, 16;
EXECUTE dbo.Insert_Group 'msimion9', 7, 9;
EXECUTE dbo.Insert_Group 'hcopleya', 19, 2;
EXECUTE dbo.Insert_Group 'amcauslandb', 12, 16;
EXECUTE dbo.Insert_Group 'hjosefsonc', 5, 10;
EXECUTE dbo.Insert_Group 'ipearcyd', 8, 4;
EXECUTE dbo.Insert_Group 'jfiggene', 11, 5;
EXECUTE dbo.Insert_Group 'gcowf', 2, 16;
EXECUTE dbo.Insert_Group 'dfaireg', 11, 15;
EXECUTE dbo.Insert_Group 'jpawsonh', 16, 7;
EXECUTE dbo.Insert_Group 'cbottelli', 13, 19;
EXECUTE dbo.Insert_Group 'gbutlerj', 18, 12;
EXECUTE dbo.Insert_Group 'clormank', 2, 6;
EXECUTE dbo.Insert_Group 'lpachtal', 4, 10;
EXECUTE dbo.Insert_Group 'qgatesmanm', 20, 16;
EXECUTE dbo.Insert_Group 'aduboisn', 16, 11;
EXECUTE dbo.Insert_Group 'cpreono', 18, 10;
EXECUTE dbo.Insert_Group 'jdorotp', 7, 14;
EXECUTE dbo.Insert_Group 'vpesterfieldq', 3, 18;
EXECUTE dbo.Insert_Group 'nsawterr', 6, 15;
EXECUTE dbo.Insert_Group 'rfolkerds', 13, 7;
EXECUTE dbo.Insert_Group 'gdevanneyt', 14, 9;

Select *FROM [group]

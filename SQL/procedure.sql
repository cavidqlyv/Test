USE c;

DROP PROCEDURE inser_teacher;
GO

CREATE PROCEDURE inser_teacher
as
BEGIN
    insert into Teacher
    values('TeacherName3', 'TeacherSurname3', '143456789', 1);
END;

EXEC inser_teacher;
GO
DROP PROCEDURE insert_update_teacher

GO
CREATE PROCEDURE insert_update_teacher
AS
BEGIN
    insert into Teacher
    values('TeacherName3', 'TeacherSurname3', '143456789', 1);

    UPDATE Student 
SET
    [name] = 'aaaa'
WHERE id =1;

    SELECT *
    from Teacher;
    SELECT *
    from Student;

END;

GO


EXEC insert_update_teacher;

drop PROC insert_update_teacher;
Drop PROCEDURE delete_tables

GO
CREATE PROCEDURE delete_tables
as
BEGIN
    DELETE from GroupStudnet;
    DELETE from Groupc;
    DELETE from Lesson;
    DELETE from Teacher;
    DELETE from Student;
    DELETE from GroupLessonDay;
    DELETE from LessonDay;
END;

EXEC delete_tables;


GO
CREATE PROCEDURE insert_table
AS
BEGIN

    insert into Student
    values('studentname1', 'studentsurname1', '1234', '12345678', '2018-2-2' , 1);

    insert into Student
    values('studentname2', 'studentsurname2', '1345', '12345678', '2018-3-2' , 1);

    insert into Student
    values('studentname3', 'studentsurname3', '1456', '12345678', '2018-4-2' , 1);

    insert into Teacher
    values('TeacherName1', 'TeacherSurname1', '123456789', 1);

    insert into Teacher
    values('TeacherName2', 'TeacherSurname2', '123456789', 1);

    insert into Lesson
    values('Lesson1', 100, 1);

    insert into Lesson
    values('Lesson2', 100, 1);

    insert into Groupc
    values('GroupName2', 2, 5, 2, 1);

END;


SELECT
    *
FROM
    SYSOBJECTS
WHERE
  xtype = 'U';
GO


use c

SELECT *
FROM teacher

GO

CREATE PROCEDURE dbo.TeacherInsertDefaultParam
    @surname VARCHAR(20),
    @contact VARCHAR(20),
    @name VARCHAR(30) = 'DefaultTeacherName',
    @status int = 1
AS
INSERT INTO Teacher
VALUES(@name , @surname , @contact , @status);
GO

EXECUTE TeacherInsertDefaultParam 'TeacherSurname6' , '1234567';

GO

CREATE PROCEDURE LessonPriceAvg
AS
DECLARE @avg decimal(14,5);
SELECT @avg  = AVG(default_price)
FROM Lesson
RETURN @avg

DECLARE @result DECIMAL (14,5);

--SET @result =
EXECUTE  @result = LessonPriceAvg;
PRINT @result;


SELECT * FROM dbo.Student


GO
CREATE PROCEDURE student_insert_result
@name VARCHAR(20),
@surname VARCHAR(20),
@fin VARCHAR (20),
@contact VARCHAR(20),
@rdate DATE,
@status INT
AS
DECLARE @message VARCHAR(20) = 'error';
IF LEN(@contact) =13
BEGIN
 
INSERT INTO Student VALUES(@name , @surname , @fin , @contact , @rdate , @status);
SET @message = 'ok';
END ;
RETURN @message;

EXECUTE student_insert_result 'test' , 'test' , '7895565' , '1234567889123' , '06-09-2018',1

DROP PROCEDURE StudentUniqueName;

GO
CREATE PROCEDURE StudentUniqueName
@name VARCHAR(20),
@surname VARCHAR(20),
@fin VARCHAR (20),
@contact VARCHAR(20),
@rdate DATE,
@status INT
AS
DECLARE @message int= 0;
DECLARE @count int= 0;

SELECT @count = COUNT(*) FROM  Student  WHERE name = @name 
IF @count =0
BEGIN
INSERT INTO Student VALUES(@name , @surname , @fin , @contact , @rdate , @status);
SET @message = 1;
END;

EXECUTE StudentUniqueName 'test' , 'test' , '789555565' , '1234567889123' , '06-09-2018',1;

Select * FROM Student;

CREATE TABLE student_name_index(
    name VARCHAR(20),
    rowindex int
);
GO
CREATE INDEX index_name
ON Student (surname)


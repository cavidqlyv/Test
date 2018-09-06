

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



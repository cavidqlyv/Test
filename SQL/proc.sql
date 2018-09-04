

CREATE PROC inser_teacher
as
BEGIN
    insert into Teacher
    values('TeacherName3', 'TeacherSurname3', '143456789', 1);
END;

EXEC inser_teacher;


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

-- Get a list of tables and views in the current database
SELECT table_catalog [c], table_schema [dbo], table_name name, table_type type
FROM dbo.TABLES
GO

sql

EXEC insert_update_teacher;

drop PROC insert_update_teacher;

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
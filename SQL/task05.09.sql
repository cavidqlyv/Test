use c;

SELECT *
FROM Student;
GO

CREATE TABLE StudentCopy
(
    id INT PRIMARY KEY ,
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    fin VARCHAR(10) NOT NULL unique,
    contact VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,
    status INT default 1
);

INSERT into StudentCopy
SELECT*
FROM Student

DROP TABLE StudentCopy

GO

CREATE VIEW StudentInfo
as
    SELECT s.name as StudentName,
        s.surname  as StudentSurname,
        t.name as TeacherName,
        l.name as LessonName
    FROM Student as s
        JOIN GroupStudnet as gs on s.id = gs.student_id
        JOIN Groupc as g on g.id = gs.group_id
        JOIN Teacher as t on t.id = g.teacher_id
        JOIN Lesson as l on l.id = g.lesson_id
GO
select *
FROM StudentInfo
GO
CREATE VIEW TeacherInfo
as
SELECT t.name as TeacherName , l.name as LessonName FROM Teacher as t
JOIN Groupc as g on g.teacher_id = t.id 
JOIN Lesson as l on g.lesson_id = l.id
GO

select * from TeacherInfo
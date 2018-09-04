use c

CREATE DEFAULT default_phone as '+994551234567';
CREATE RULE rule_default_phone as len(@phone) = 13;


Create Type phonetype    
from char(40) NOT NULL

sp_bindrule rule_default_phone,'phonetype'; 
sp_bindefault default_phone,'phonetype' ;

CREATE TABLE test3
(
    id INT not NULL IDENTITY(1,1),
    phone dbo.phonetype
)

SELECT *
FROM test3

INSERT into  test3
VALUEs('+994511234567')

CREATE TABLE student_count
(
    id int IDENTITY(1,1),
    count int
)

SELECT COUNT(*)
from Student

INSERT into student_count
VALUES(3)

use c

CREATE TRIGGER increment
on Student
after INSERT
as
BEGIN
    update student_count set count+=1;
end
GO

SELECT *
FROM student_count

SELECT*
FROM Student

INSERT into Student
VALUES('studentname4', 'studentsurname4', '1466', '12345678', '2018-4-2' , 1)

CREATE TRIGGER decrement
on Student
after DELETE
as
BEGIN
    update student_count set count-=1;
end
GO


DELETE FROM Gruopc
WHERE 	
GO

select *
from Student

SELECT *
from GroupStudnet

SELECT *
FROM Groupc

insert into Groupc
values('GroupName3', 2, 5, 2, 1)

use c

select *
FROM Lesson

insert into GroupStudnet
values(3, 1004, 1002, 5);



select g.name as Name, count(gs.student_id) as StudentCount , count(gs.student_id)* l.default_price
FROM GroupStudnet gs
    join Student s on s.id = gs.student_id
    join Groupc g on g.id = gs.group_id
    join Lesson l on l.id = g.lesson_id
GROUP by  g.name , l.default_price

CREATE TRIGGER deleteGroup
on GroupStudnet
after DELETE AS
BEGIN
    DELETE FROM Groupc WHERE id not in (select group_id
    from GroupStudnet)
END

DELETE from GroupStudnet WHERE group_id = 1004

CREATE TRIGGER getPrice
on GroupStudent
after INSERT
BEGIN
    select g.name as Name, count(gs.student_id) as StudentCount , count(gs.student_id)* l.default_price
    FROM GroupStudnet gs
        join Student s on s.id = gs.student_id
        join Groupc g on g.id = gs.group_id
        join Lesson l on l.id = g.lesson_id
    GROUP by  g.name , l.default_price
    join
END

CREATE TABLE test4
(
    id int IDENTITY(1,1),
    date DATE,
    amount int
)

use c

select *
from test4

SELECT*
FROM Lesson

CREATE TRIGGER sumLessonPrice
on Lesson
after INSERT as
BEGIN
    INSERT into test4
    VALUES
        (GETDATE() , (select sum(default_price)
            from Lesson) )
END


insert into Lesson
VALUES('lesson3', 200, 1)

CREATE TRIGGER showOld
on Teacher
after INSERT AS
BEGIN
    SELECT *
    from Teacher
END

DROP TRIGGER showNew

CREATE TRIGGER showNew
on Teacher
INSTEAD of INSERT AS
BEGIN
    SELECT *
    from Teacher
END

insert into Teacher
values('TeacherName3', 'TeacherSurname3', '143456789', 1);


DROP TRIGGER showOld



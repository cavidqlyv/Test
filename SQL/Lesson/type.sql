use db

drop table Student

create table Student
(
    id int primary key identity(1,1),
    name varchar(40) not null,
    surname varchar(40) not null,
    fin varchar(10) not null unique,
    contact varchar(20) not null,
    registration_date date not null,
    status int default 1
);



insert into Student
values('studentname1', 'studentsurname1', '1234', '12345678', '2018-2-2' , 1)

insert into Student
values('studentname2', 'studentsurname2', '1345', '12345678', '2018-3-2' , 1)

insert into Student
values('studentname3', 'studentsurname3', '1456', '12345678', '2018-4-2' , 1)

select *
FROM Student

DROP TABLE Teacher

create table Teacher
(
    id int primary key identity(1,1),
    name varchar(40) not null,
    surname varchar(40) not null,
    contact varchar(20) not null,
    status int default 1
);

select *
from Teacher

insert into Teacher
values('TeacherName1', 'TeacherSurname1', '123456789', 1);

insert into Teacher
values('TeacherName2', 'TeacherSurname2', '123456789', 1);

DROP TABLE Lesson

create table Lesson
(
    id int primary key identity(1,1),
    name varchar(40) not null,
    default_price int not null,
    status int default 1
);

insert into Lesson
values('Lesson2', 100, 1)

select *
from Lesson

create table Groupc
(
    id int primary key identity(1,1),
    name varchar(20) not null,
    teacher_id int constraint fk_teacher_id foreign key references Teacher(id),
    grou_day_count_pay decimal,
    lesson_id int constraint fk_lesson_id foreign key references Lesson(id),
    status int default 1
);

SELECT *
FROM Teacher

insert into Groupc
values('GroupName2', 2, 5, 2, 1)


create table GroupStudnet
(
    id int primary key identity(1,1),
    student_id int constraint fk_student_id foreign key references Student(id),
    group_id int constraint fk_group_id foreign key references Groupc(id),
    status int default 1,
    student_price int not null
);

SELECT *
FROM Student

insert into GroupStudnet
values(3, 2, 1, 5);

select *
from GroupStudnet

select *
from Groupc

create table LessonDay
(
    id int primary key identity(1,1),
    day tinyint not null
);

insert into LessonDay
values(7)

select *
from LessonDay

create table GroupLessonDay
(
    id int primary key identity(1,1),
    lessonDay_id int constraint fk_lessonDay_id foreign key references LessonDay(id),
    group_id int constraint fk1_group_id foreign key references Groupc(id)
);


insert into GroupLessonDay
values(1, 1)

select *
from Groupc

select Teacher.*
from Teacher join Groupc on Groupc.id = 1 join Lesson on Groupc.id = 1;

select s.name , s.surname , s.fin , s.contact , s.registration_date , g.name as groupname , g.id
from Groupc g
    join teacher t on g.teacher_id=t.id
    join lesson l on g.lesson_id=l.id
    join GroupStudnet gs on g.id=gs.group_id
    join student s on gs.student_id=s.id
where g.id=1;

select*
from Student

select s.name as StudentName , s.surname as StudentSurname, l.name as LessonName, t.name as TeacherName, g.name as GroupName
from Groupc g
    join teacher t on g.teacher_id=t.id
    join lesson l on g.lesson_id=l.id
    join GroupStudnet gs on g.id=gs.group_id
    join student s on gs.student_id=s.id;

select t.name as TeacherName , l.name as LessonName
from Groupc g
    join Teacher t on g.teacher_id= t.id
    join Lesson l on g.lesson_id = l.id

select *
from Groupc
--6)Muellimin ders saatlarinin cemini getirin
select sum(g.grou_day_count_pay) , t.name
from Groupc g
    join Teacher t on g.teacher_id = t.id
group by t.name
having sum(g.grou_day_count_pay)>4

--7)EN gec gelmis telebenin qruplarini ve derslerini getirmek
select *
from Groupc g
    join GroupStudnet gs on g.id = gs.group_id
    join Student s on s.id = gs.student_id
    join Lesson l on l.id= g.id
where s.registration_date = (select max(registration_date)
from Student s join GroupStudnet gs on s.id=gs.student_id )

--8)en cox qrupu olan telebeni getirmek

select s.name
from Student s
    join GroupStudnet gs on s.id = gs.student_id
--group by gs.student_id having COUNT(gs.student_id) = MAX(select  COUNT(gs.student_id) from GroupStudnet gs)



select s.name
from (
        select gs.student_id as StudentId, count(gs.student_id)  as StudentGroupCount
    FROM GroupStudnet gs
    GROUP by  gs.student_id
    HAVING count(gs.student_id) =
            (Select max(q.StudentGroup)
    from (
                select s.name as Name, count(gs.student_id)  as StudentGroup
        FROM GroupStudnet gs
            join Student s on s.id = gs.student_id
        GROUP by  gs.student_id , s.name )
	        as q)
    ) as N
    JOIN Student s on s.id = N.StudentId
--join Student on s.id = N.StudentId

-- use c

-- Select max(q.StudentGroup)
-- from ( select gs.student_id as StudentID, count(gs.student_id) as StudentGroup
--     FROM GroupStudnet gs
--     GROUP by  gs.student_id ) as q

-- select *
-- from GroupStudnet


-- SELECT gs.student_id, count(gs.student_id) AS StudentGroup
-- FROM GroupStudnet gs
-- GROUP by  gs.student_id

-- select max(student_id)
-- from GroupStudnet

-- select *
-- from Student

--9)her qrupun telebe sayini getirmek


select Groupc.name as Name , g.StudentCount
from
    ( select count(student_id) as StudentCount , group_id as GroupId
    from GroupStudnet
    GROUP BY group_id ) g
    JOIN Groupc on g.GroupId = Groupc.id


use c

SELECT s.registration_date
FROM Student s
WHERE MONTH(s.registration_date) 
IN
(( SELECT AVG(MONTH( s.registration_date))
FROM Student s), ( SELECT MAX(MONTH( s.registration_date))
FROM Student s))




CREATE TABLE test
(
    id int not NULL,
    name VARCHAR(40),
    price dbo.mytype
)

select *
FROM test

INSERT into test
    (id,name)
VALUES(1, 'test1')
INSERT into test
    (id,name,price)
VALUES(1, 'test2', 3)
INSERT into test
    (id,name,price)
VALUES(1, 'test2', 4)



CREATE TABLE test1
(
    id int not NULL,
    name VARCHAR(40),
    age dbo.mytypeage
)

SELECT *
FROM test1

INSERT into test1
VALUES(1, 'test1', 100)
INSERT into test1
    (id,name)
VALUES(2, 'test2')
GO
CREATE DEFAULT default_price AS 5
GO
CREATE RULE rule_default_price as @price in (1,3,5,7)
GO
CREATE DEFAULT default_age as 18;
GO
CREATE RULE rule_default_age as @age between 1 and 100;
GO
use c
GO
CREATE DEFAULT default_name as 'name';
GO
CREATE RULE rule_default_name as len(@name) >3;
GO

CREATE TABLE test2
(
    id int not null IDENTITY(1,1),
    name dbo.nametype,
    age dbo.mytypeage,
    price dbo.mytype
)

SELECT*
FROM test2


INSERT INTO test2
    (
    [name], [age], [price]
    )
VALUES
    (
        'name1', 5, 5
),
    (
        'name2', 7, 7
)
GO

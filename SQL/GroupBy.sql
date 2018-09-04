use db

drop table Student

create table Student
(
    id int primary key identity(1,1),
    name varchar(50) not null,
    surname varchar(50) not null,
    age int not null,
    email varchar(40) unique,
    birthdate date not null
);

insert into Student
values('aaaa', 'bbbb', 19, 'a', '1992-01-15');
insert into Student
values('aaaa', 'bbbb', 19, 'b', '1993-01-15');
insert into Student
values('cccc', 'dddd', 19, 'c', '1994-01-15');
insert into Student
values('eeee', 'ffff', 19, 'd', '1995-01-15');
insert into Student
values('gggg', 'hhhh', 19, 'e', '1996-01-15');
insert into Student
values('jjjj', 'kkkk', 19, 'f', '1997-01-15');
insert into Student
values('sfds', 'wert', 19, 'g', '1998-01-15');
insert into Student
values('rtyu', 'fhhg', 19, 'h', '1999-01-15');
insert into Student
values('aaaa', 'bbbb', 19, 'k', '2000-01-15');
insert into Student
values('eryu', 'bbbb', 25, 'y', '2001-01-15');

update Student set name='updatename' , surname='updatesurname' where id = 4;

select *
from Student
where age>20

select *
from Student
where age>20

select name+' '+surname as Fullname
from Student

select *
from Student
order by id desc



select distinct surname
from Student

select *
from Student
where name in (SELECT name
    FROM Student
    GROUP BY name
    HAVING ( COUNT(name) > 1)) or ( surname in( SELECT surname
    FROM Student
    GROUP BY surname
    HAVING ( COUNT(surname) > 1) ) );




select name , surname
from Student
group by name,surname;

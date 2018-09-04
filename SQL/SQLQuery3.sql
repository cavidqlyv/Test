select name+' '+surname as FullName
from Student;

select name+' '+cast(age as nvarchar(20)) as StudentAge
from Student;

select *
from Student;

select cast(YEAR(birthdate) as int) + cast(MONTH(birthdate) as int) +cast(DAY(birthdate) as int) as a
from Student;

select *
from Student
where len(surname) > 7;

select *
from Student
order by email;

select *
from Student
where cast(YEAR(birthdate) as int) between 1992 and 1994;

select *
from Student
where email like 'f%';

select *
from Teacher
where email is not null;

insert into Student
values(8, 'a', 'b', 'c', 5, '01-02-1992');

update Student set name='updatename' , surname='updatesurname' where id = 4;

create table test3
(
    id int primary key identity(1,1),
    name varchar(50) not null,
    surname varchar(50) not null,
    age int not null,
    email varchar(40) unique,
    birthdate date not null
);

use db

insert into test3
values('a', 'b', 1, 'a', '1-1-1992');

select *
from test3;
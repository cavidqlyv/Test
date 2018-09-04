use [t31.07]

create table Teacher
(
    id int primary key identity(1,1) not null,
    name varchar(40) not null,
    surname varchar(40) not null
);

create table Student
(
    id int primary key identity(1,1) not null,
    name varchar(40) not null,
    surname varchar(40) not null,
    teacher_id int constraint fk_teacher_id foreign key references Teacher(id)
);

create table Computer
(
    id int primary key identity(1,1) not null,
    username varchar(40) not null unique,
    password varchar(40) not null
);

create table StudentComputer
(
    id int not null identity(1,1) primary key,
    student_id int constraint fk_student_id foreign key references Student(id),
    computer_id int constraint fk_computer_id foreign key references Computer(id)
);

select *
from Student;

insert into Student
values('student3' , 'student3' , 2 );

select *
from Teacher;

insert into Teacher
values('teacher2' , 'teacher2');

select *
from Computer;

insert into Computer
values('computer2', 'computer2')

select *
from StudentComputer;

insert into StudentComputer
values(1, 2);

select Student.*, Computer.*
from Student, Computer, StudentComputer
where Student.id = StudentComputer.student_id and Computer.id = StudentComputer.computer_id
;

select Student.*, Teacher.*
from Student, Teacher
where Teacher.id = Student.teacher_id
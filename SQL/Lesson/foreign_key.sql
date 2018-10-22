create table student
(
    id int not null identity(1,1) primary key,
    name varchar(40) not null,
    email varchar(40) not null,
    surname varchar(40) not null,
    age int not null
);

create table computer
(
    id int not null identity(1,1) primary key,
    username varchar(40) not null unique,
    password varchar(40) not null,
    student_id int
);

insert into student
values('asd', 'qwe', 'qwe', 5);

select *
from student

insert into computer
values('yiu', 'asd', 1);


select *
from computer

select student.*, computer.*
from student, computer
where student.id = computer.student_id

alter table computer
add constraint fk_computer_id
foreign key (student_id)
references student(id)




create table student1
(
    id int not null identity(1,1) primary key,
    name varchar(40) not null,
    email varchar(40) not null,
    surname varchar(40) not null,
    age int not null
);

insert into student1
values('student3', 'student3', 'student3', 5);


create table teacher
(
    id int not null identity(1,1) primary key,
    name varchar(40) not null,
    email varchar(40) not null,
    surname varchar(40) not null,
    age int not null
);

insert into teacher
values('teacher3', 'teacher3', 'teacher3', 5);


create table TeacherStudent
(
    id int not null identity(1,1) primary key,
    student_id int constraint fk_student_id foreign key references student1(id),
    teacher_id int constraint fk_teacher_id foreign key references teacher(id)
);

insert into TeacherStudent
values(5, 5)

select *
from TeacherStudent

select *
from student1

select *
from teacher

select student1.*, teacher.*
from student1, teacher , TeacherStudent
where student1.id = TeacherStudent.student_id and teacher.id = TeacherStudent.teacher_id

create table LogBook
(
    id int not null,
    username varchar(40) not null,
    password varchar(40) not null
);

insert into LogBook
values(2, 'username2' , 'password2')

select student1.*, LogBook.*
from student1 , LogBook
where student1.id = LogBook.id

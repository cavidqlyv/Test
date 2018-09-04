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
values('studentname3', 'studentsurname3', 86454, '12345678', '2018-2-2' , 1)

select *
from Teacher

create table Teacher
(
    id int primary key identity(1,1),
    name varchar(40) not null,
    surname varchar(40) not null,
    contact varchar(20) not null,
    status int default 1
);

insert into Teacher
values('TeacherName2', 'TeacherSurname2', '123456789', 1);

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

insert into GroupStudnet
values(2, 1, 1, 5);

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

select g.* , t.* , s.*
from Groupc g join teacher t on g.teacher_id=t.id join lesson l on g.lesson_id=l.id
    join GroupStudnet gs on g.id=gs.group_id join student s on gs.student_id=s.id
where g.id=1;
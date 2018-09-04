USE db;

CREATE TABLE Student
(
    id INT PRIMARY KEY identity(1,1),
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    fin VARCHAR(10) NOT NULL unique,
    contact VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,
    status INT default 1
);

INSERT INTO Student
VALUES('studentname1', 'studentsurname1', '1234', '12345678', '2018-2-2' , 1);

INSERT INTO Student
VALUES('studentname2', 'studentsurname2', '1345', '12345678', '2018-3-2' , 1);

INSERT INTO Student
VALUES('studentname3', 'studentsurname3', '1456', '12345678', '2018-4-2' , 1);


SELECT *
FROM Student;

CREATE TABLE Teacher
(
    id INT PRIMARY KEY identity(1,1),
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    status INT default 1
);

SELECT *
FROM Teacher

INSERT INTO Teacher
VALUES('TeacherName1', 'TeacherSurname1', '123456789', 1);

INSERT INTO Teacher
VALUES('TeacherName2', 'TeacherSurname2', '123456789', 1);

CREATE TABLE Lesson
(
    id INT PRIMARY KEY identity(1,1),
    name VARCHAR(40) NOT NULL,
    default_price INT NOT NULL,
    status INT default 1
);

INSERT INTO Lesson
VALUES('Lesson2', 100, 1);

INSERT INTO Lesson
VALUES('Lesson3', 100, 1);

SELECT *
FROM Lesson;


CREATE TABLE Groupc
(
    id INT PRIMARY KEY identity(1,1),
    name VARCHAR(20) NOT NULL,
    teacher_id INT CONSTRAINT fk_teacher_id FOREIGN KEY references Teacher(id),
    grou_day_count_pay DECIMAL,
    lesson_id INT CONSTRAINT fk_lesson_id FOREIGN KEY references Lesson(id),
    status INT default 1
);

SELECT *
FROM Teacher;

INSERT INTO Groupc
VALUES('GroupName2', 1, 5, 1, 1);

CREATE TABLE GroupStudnet
(
    id INT PRIMARY KEY identity(1,1),
    student_id INT CONSTRAINT fk_student_id FOREIGN KEY REFERENCES Student(id),
    group_id INT CONSTRAINT fk_group_id FOREIGN KEY REFERENCES Groupc(id),
    status INT default 1,
    student_price INT NOT NULL
);

SELECT *
FROM GroupStudnet;


SELECT *
FROM Student

INSERT INTO GroupStudnet
VALUES(2, 1, 1, 5);

SELECT *
FROM GroupStudnet

SELECT *
FROM Groupc

CREATE TABLE LessonDay
(
    id INT PRIMARY KEY identity(1,1),
    day TINYINT NOT NULL
);

INSERT INTO LessonDay
VALUES(1);
INSERT INTO LessonDay
VALUES(2);
INSERT INTO LessonDay
VALUES(3);
INSERT INTO LessonDay
VALUES(4);
INSERT INTO LessonDay
VALUES(5);
INSERT INTO LessonDay
VALUES(6);
INSERT INTO LessonDay
VALUES(7);

CREATE TABLE GroupLessonDay
(
    id INT PRIMARY KEY identity(1,1),
    lessonDay_id INT CONSTRAINT fk_lessonDay_id FOREIGN KEY REFERENCES LessonDay(id),
    group_id INT CONSTRAINT fk1_group_id FOREIGN KEY REFERENCES Groupc(id)
);

INSERT INTO GroupLessonDay
VALUES(1, 1);


SELECT s.name AS StudentName , t.name AS TeacherName , l.name AS LessonName
FROM Student s
    JOIN GroupStudnet gs ON gs.student_id = s.id
    JOIN Groupc g ON g.id = gs.group_id
    JOIN Teacher t ON t.id = g.teacher_id
    JOIN Lesson l ON l.id = g.lesson_id
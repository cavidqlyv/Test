CREATE DATABASE db1;
USE db1; 

CREATE TABLE Student
(
    id INT identity(1,1),
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    fin VARCHAR(10) NOT NULL unique,
    contact VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,
    status INT default 1
);
GO
CREATE PROCEDURE insert_student
@name VARCHAR(40),
@surname VARCHAR(40),
@fin VARCHAR(10),
@contact VARCHAR(20),
@registration_date DATE,
@status int =1
AS
INSERT INTO Student VALUES(@name , @surname , @fin , @contact , @registration_date , @status)

EXECUTE insert_student 'name1' , 'surname1' , 'fin1' , 'contact1' ,'11-09-2018';

CREATE TABLE Teacher
(
    id INT identity(1,1),
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    status INT default 1
);


GO
CREATE PROCEDURE insert_teacher
@name VARCHAR(40),
@surname VARCHAR(40),
@contact VARCHAR(20),
@status int =1
AS
--INSERT INTO Teacher VALUES(@name , @surname , @contact , @status);

EXECUTE insert_teacher 'name1' , 'surname1' , 'contact1';

CREATE TABLE Lesson
(
    id INT identity(1,1),
    name VARCHAR(40) NOT NULL,
    default_price INT NOT NULL,
    status INT default 1
);


GO
CREATE CLUSTERED INDEX index_studnet_name
ON  Student (name)

--CREATE DATABASE db1;
--USE db1;
DROP TABLE Student
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
INSERT INTO Student
VALUES(@name , @surname , @fin , @contact , @registration_date , @status)

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

SELECT *
FROM Student

BEGIN TRANSACTION
EXECUTE insert_student 'name3' , 'surname3' , 'fin3' , 'contact3' ,'11-09-2018';
ROLLBACK TRANSACTION


GO
CREATE PROCEDURE student_insert_validate
    @name VARCHAR(40),
    @surname VARCHAR(40),
    @fin VARCHAR(10),
    @contact VARCHAR(20),
    @registration_date DATE,
    @status int =1
AS
BEGIN TRANSACTION
EXECUTE insert_student @name , @surname , @fin , @contact ,@registration_date , @status;
IF LEN(@contact) = 13
BEGIN
    ROLLBACK TRANSACTION
END;
ELSE
BEGIN
    COMMIT
END

EXECUTE student_insert_validate 'name4' , 'surname4' , 'fin9' , '1234567891011' ,'11-09-2018';
GO
CREATE TABLE employee
(
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR (40) NOT NULL,
    amount INT NOT NULL,
    year INT
)

GO
CREATE PROCEDURE insert_employee
    @name VARCHAR(40),
    @amount INT,
    @year INT
AS
INSERT INTO employee
VALUES(@name, @amount , @year)

EXECUTE insert_employee 'Name1' , 32 , 2016
EXECUTE insert_employee 'Name1' , 23 , 2016
EXECUTE insert_employee 'Name1' , 42 , 2016
EXECUTE insert_employee 'Name1' , 23 , 2017
EXECUTE insert_employee 'Name1' , 23 , 2017
EXECUTE insert_employee 'Name1' , 27 , 2018
EXECUTE insert_employee 'Name1' , 26 , 2018
EXECUTE insert_employee 'Name1' , 23 , 2018

EXECUTE insert_employee 'Name2' , 25 , 2016
EXECUTE insert_employee 'Name2' , 23 , 2016
EXECUTE insert_employee 'Name2' , 22 , 2016
EXECUTE insert_employee 'Name2' , 32 , 2017
EXECUTE insert_employee 'Name2' , 54 , 2017
EXECUTE insert_employee 'Name2' , 23 , 2018
EXECUTE insert_employee 'Name2' , 23 , 2018
EXECUTE insert_employee 'Name2' , 23 , 2018

SELECT name AS Name , SUM(amount) AS Amount , year AS Year
FROM employee
GROUP BY year , name

SELECT name , [2016] , [2017] , [2018]
FROM employee 
PIVOT(MAX(amount) FOR year IN ([2016] , [2017] , [2018])) AS employee_pivot

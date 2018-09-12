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
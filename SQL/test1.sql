CREATE DATABASE db

USE db

DROP TABLE test;

CREATE TABLE test
(
    id int identity(1,1),
    name nvarchar(20) unique
);

INSERT INTO test
VALUES('name1');

SELECT *
FROM test;

UPDATE test SET name='updatename' WHERE id = 1;

DELETE test WHERE id = 1;

CREATE TABLE person
(
    id int IDENTITY(1,1),
    name varchar(20),
    age int
);

SELECT *
FROM person;

INSERT INTO person
VALUES('name' , 16);

SELECT max(age) AS Age, name AS Name
FROM person
GROUP BY name;
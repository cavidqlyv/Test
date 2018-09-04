create table product(
id int not null identity primary key,
name varchar(40) not null,
price decimal default 0.0,
count int default 0,
end_date date default null);

insert into product(name,price,count,end_date) values('cccc',15,10,'2018-8-14');

select * from product

select max(cast(MONTH(end_date) as int)) + min(cast(MONTH(end_date) as int)) from product

select distinct name from product where price = (select max(price) from product)

select name , avg(price) from  product group by name;

select * from product 

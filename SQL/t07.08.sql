use c

CREATE TABLE product
(
    id int not NULL IDENTITY(1,1),
    name VARCHAR(40),
    price int NOT NULL
)

select*
FROM product

-- Insert rows into table 'product'
INSERT INTO product
    ( -- columns to insert data into
    [name], [price]
    )
VALUES
    (
        'product1', 10
),
    (
        'product2', 15
),
    (
        'product3', 20
),
    (
        'product4', 30
),
    (
        'product5', 40
),
    (
        'product6', 45
)

GO

select max(price)
from product

SELECT min(price)
from product

SELECT avg(price)
from product

SELECT sum(price)
from product

select *
from product
WHERE price>20

drop TABLE product
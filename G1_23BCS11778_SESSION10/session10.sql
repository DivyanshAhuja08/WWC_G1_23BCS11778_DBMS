--  DROP TABLE PRODUCTS_;
-- DROP TABLE orders;

CREATE TABLE PRODUCTS_ (
    product_id INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO PRODUCTS_ (product_id, product, category) VALUES
(1, 'LAPTOP', 'ELECTRONICS'),
(2, 'SMARTPHONE', 'ELECTRONICS'),
(3, 'TABLETS', 'ELECTRONICS'),
(9, 'PRINTER', 'ELECTRONICS'),
(4, 'HEADPHONES', 'ACCESSORIES'),
(5, 'SMARTWATCH', 'ACCESSORIES'),
(6, 'KEYBOARD', 'ACCESSORIES'),
(7, 'MOUSE', 'ACCESSORIES'),
(8, 'MONITOR', 'ACCESSORIES');

select row_number() over(partition by category order by product_id desc) as product_id,product,category
from 
PRODUCTS_

CREATE TABLE customers (
    id INT PRIMARY KEY,
    email VARCHAR(100)
);

INSERT INTO customers (id, email) VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

with cte as(
select row_number() over(partition by email order by id) as row,email,id
from 
customers
)
delete  from customers  where id in(
select id from cte where row>1
)
select * from customers


CREATE TABLE table_a (
    empid INT,
    ename VARCHAR(50),
    salary INT
);

CREATE TABLE table_b (
    empid INT,
    ename VARCHAR(50),
    salary INT
);

INSERT INTO table_a (empid, ename, salary) VALUES
(1, 'AA', 1000),
(2, 'BB', 300);

INSERT INTO table_b (empid, ename, salary) VALUES
(2, 'BB', 400),
(3, 'CC', 100);


with cte1 as(
select  *, row_number() over(partition by ename order by salary)  as row
from 
(
select * from table_a
union all
select * from table_b
) as t1
)
select empid,ename,salary from cte1 where row=1;




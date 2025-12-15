-- CLIENT TABLE
CREATE TABLE client_master (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    email VARCHAR(100)
);

-- SERVICE TABLE
CREATE TABLE service_catalog (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    hourly_rate NUMERIC(10,2)
);

-- INVOICE TABLE
CREATE TABLE invoice_details (
    invoice_id INT PRIMARY KEY,
    client_id INT REFERENCES client_master(client_id),
    service_id INT REFERENCES service_catalog(service_id),
    hours_worked INT,
    discount_percent INT,
    invoice_date DATE
);

-- INSERT INTO client_master
INSERT INTO client_master (client_id, client_name, email) VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com'),
(2, 'Anita Verma', 'anita@gmail.com'),
(3, 'Karan Singh', 'karan@gmail.com');

-- INSERT INTO service_catalog
INSERT INTO service_catalog (service_id, service_name, hourly_rate) VALUES
(101, 'Web Development', 1200.00),
(102, 'Data Analysis', 1500.00),
(103, 'SEO Optimization', 800.00);

-- INSERT INTO invoice_details
INSERT INTO invoice_details (invoice_id, client_id, service_id, hours_worked, discount_percent, invoice_date) VALUES
(1001, 1, 101, 10, 10, '2025-01-05'),
(1002, 2, 102, 8,  5,  '2025-01-07'),
(1003, 3, 103, 12, 0,  '2025-01-10');

Select * From client_master;

Select *  From service_catalog;
Select * From invoice_details;


create or replace view vw_invoice_summary as
select  t1.invoice_id ,t1.client_name,s.service_name , ((t1.hours_worked*s.hourly_rate)- ((t1.hours_worked*s.hourly_rate)*(t1.discount_percent/100)))
from
(select * from
invoice_details as i
join 
client_master as c
on
i.client_id=c.client_id
)   as t1
join 
service_catalog as s
on
t1.service_id=s.service_id;
-- 23bcs1778 Divyansh
select * from vw_invoice_summary

create role div
with login  password 'Div@08'

grant select on vw_invoice_summary to div


revoke select on vw_invoice_summary from div
create table customer(
 c_id int primary key,
 c_name varchar(20)
);
create table orders(
  order_id int,
  amount int,
  c_id int REFERENCES customer(c_id)
  on update cascade
  on delete cascade 
);
insert into customer values(1,'div');
insert into orders  values(1,1000,2);


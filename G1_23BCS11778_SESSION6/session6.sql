drop table Employees;
drop table Departments;

CREATE TABLE Employees (
    emp_id     INT PRIMARY KEY,
    name       VARCHAR(50),
    dept_id    INT,
    salary     INT
);


CREATE TABLE Departments (
    dept_id     INT PRIMARY KEY,
    dept_name   VARCHAR(50)
);

INSERT INTO Employees (emp_id, name, dept_id, salary) VALUES
(1, 'Asha', 10, 50000),
(2, 'Rohan', 10, 70000),
(3, 'Meera', 20, 40000),
(4, 'Kabir', 20, 55000),
(5, 'Isha', 30, 90000);

INSERT INTO Departments (dept_id, dept_name) VALUES
(10, 'HR'),
(20, 'Finance'),
(30, 'IT');
SELECT D.DEPT_NAME,E.NAME,E.SALARY,(SELECT AVG(SALARY):: NUMERIC(20,0) FROM EMPLOYEES WHERE DEPT_ID = D.DEPT_ID) AS DEPT_AVG_SALARY FROM EMPLOYEES AS E
LEFT JOIN DEPARTMENTS AS D
ON E.DEPT_ID = D.DEPT_ID
WHERE E.EMP_ID IN
(
SELECT EMP_ID FROM EMPLOYEES WHERE DEPT_ID = D.DEPT_ID
ORDER BY ABS(SALARY-(SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPT_ID = D.DEPT_ID)), SALARY DESC
LIMIT 1
)
drop table Persons;
CREATE TABLE Persons (
	id INT PRIMARY KEY,
	name VARCHAR(50),
	age INT,
	email VARCHAR(100)
);
INSERT INTO Persons (id, name, age, email) VALUES
(1, 'Rajesh', 28, 'rajesh@gmail.com'),
(2, 'Priya', 25, 'priya@gmail.com'),
(3, 'Suresh', 30, 'rajesh@gmail.com'),
(4, 'Anjali', 24, 'priya@gmail.com');

select 
p.id,p.name,p.age,coalesce(p3.email,'Duplicate Email')
from 
Persons as p
left join
(
select p1.id ,p1.email from Persons as p1 where p1.id in  (select min(p2.id)  from Persons as p2 where p1.email=p2.email)
) as p3
on p.id=p3.id

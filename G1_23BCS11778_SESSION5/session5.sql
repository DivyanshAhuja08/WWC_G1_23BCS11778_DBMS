drop table Departments;
drop table Employees;
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);


CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);


INSERT INTO Departments (DeptID, DeptName, Location) VALUES
(10, 'HR', 'Delhi'),
(20, 'IT', 'Mumbai'),
(30, 'Finance', 'Pune'),
(50, 'Marketing', 'Chennai');

INSERT INTO Employees (EmpID, EmpName, DeptID, Salary) VALUES
(1, 'Akash', 10, 50000),
(2, 'Nisha', 20, 60000),
(4, 'Simran', 30, 70000),
(5, 'Meena', 30, 55000);

select 
DeptName as DepartmentName,
(select count(*) from Employees as e where e.DeptID=d.DeptID  ) as employeecount,
(select avg(e.Salary)::Numeric(10,0) from Employees as e where e.DeptID=d.DeptID  ) as AvgSalary,
(select  coalesce((case when avg(e.Salary)>=60000 then 'High Avg' When avg(e.Salary) between 50000 and 59999 then 'Medium Avg'  when  avg(e.Salary)<50000 then 'Low Avg' End),'No Employees')  from Employees as e where e.DeptID=d.DeptID) as Salarycategory
from Departments as d
group by d.DeptID


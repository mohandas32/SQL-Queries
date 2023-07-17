create function getdetail(@id int)
returns table
as

	return select * from customer where customer_id = @id;


select * from dbo.getdetail(3001)  --running functon

create table dept11(
	deptid int identity(1,1) primary key,
	deptname varchar(50) not null

);

create table emp11(
	empid int identity primary key,
	empfname varchar(100) not null,
	emplname varchar(100) not null,
	empaddress varchar(255),
	dept_id int foreign key references dept11(deptid)  --defining foreign key at the time of table creation
);


select year(getdate())

select distinct e1.* from employees e1, employees e2 where e1.employee_id <> e2.employee_id and e1.salary = e2.salary;

select * from mddepartment
union 
select * from mdemployee


select * from MDEmployee where mdemployeeid =(select max(mdemployeeid) from mdemployee);
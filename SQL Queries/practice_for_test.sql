
--case example
select pro_name, pro_price, case
		when pro_price > 1000 then 'Costly'  --when the price is greater than 1000 then display 'costly'
		else
			'Cheaper'  --else display the message as 'cheaper'
		end as 'Message'
from item_mast

select 
		if (pro_price) > 1000 print 'Costly'
from item_mast



--function examples
--function to calculate the age from dob
go
create function calculateAge(@dob date)
returns int
as
	begin
		return year(current_timestamp) - year(@dob);
	end
go
select dbo.calculateAge('2000-03-01') as 'Your Age'


create table DummyTable
(
	id int identity(1,1),
	name varchar(100),
	address varchar(255)
);


insert into Dummytable(name) values('Mohan'),
							 ('Ankit'),
							 ('Jatin');

select * from DummyTable


--creating a function that will return the top 2 values from DummyTable
go
create function getTwoValues()
returns table
as
	return (select top(2) * from DummyTable)
go
select * from dbo.getTwovalues()

select * from emp_details
select * from emp_department
select * from mdemployee


--function to get the employee having highest salary
go
create function getHighestPaidEmployee()
returns table
	return (select top 1 * from mdemployee order by MDEmployeeSalary)

go

select * from getHighestPaidEmployee()

--procedure examples
--creating the procedure to get the details of employee working in the given department
go
alter procedure getEmployeeDetails(@departmentName varchar(100))
as
begin
	select e.emp_idno, e.emp_fname, e.emp_lname from emp_details e
	inner join emp_department d
	on e.EMP_DEPT = d.DPT_CODE where DPT_NAME=@departmentName
end;
go

exec getEmployeeDetails @departmentName = 'Finance'

sp_helptext getEmployeeDetails

--view example
create view displayEMployee 
as
select mdemployeefirstname, mdemployeelastname, mdemployeesalary from mdemployee;

select * from displayEmployee;

sp_depends MDemployee


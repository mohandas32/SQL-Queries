--creating database

--create database MadanMohan342;

--crating table

--create table Employee342(
--	EmployeeID int,
--	EmployeeName varchar(100),
--	EmployeeGender varchar(10)
--)

--performing alter table

--alter table Employee342 alter column EmployeeID varchar(3)
--alter table Employee342 alter column EmployeeID int
--alter table Employee342 alter column EmployeeID int not null
--alter table Employee342 add primary key(EmployeeID)

--insert into Employee342(EmployeeID,EmployeeName,EmployeeGender) values(1,'Mohan das','Male')
--insert into Employee342(EmployeeID,EmployeeName,EmployeeGender) values(2,'Vikrant Anand','Male')
--insert into Employee342(EmployeeID,EmployeeName,EmployeeGender) values(3,'Jatin Dhote','Male')
--insert into Employee342(EmployeeID,EmployeeName,EmployeeGender) values(4,'Darshan Rawal','Male')
--insert into Employee342(EmployeeID,EmployeeName,EmployeeGender) values(5,'Vedang Prajapati','Male')


--select * from Employee342
--Begin tran
--	update Employee342 set DepartmentID=1 where EmployeeID=1
--commit tran
--rollback tran


--alter table Employee342 add constraint U_name unique(EmployeeName)
--alter table Employee342 drop constraint U_name

--adding DepartmentID column in Employee342 table

--alter table Employee342 add DepartmentID int;
--alter table Employee342 add foreign key (DepartmentID) references department(DepartmentID)


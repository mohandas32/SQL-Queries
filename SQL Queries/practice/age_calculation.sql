USE MadanMohan342

create table EmployeeAge(
	dob date not null,
	--automatic calculate age from dob entered by the user
	--we cannot insert or alter the age column in future
	age as year(current_timestamp) - year(dob)
	);


insert into EmployeeAge(dob) values('2000-03-01')
select * from MDEmployee
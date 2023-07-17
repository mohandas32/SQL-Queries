use MD342MadanMohanDas

create sequence increment_1
start with 10
increment by 1;

select next value for increment_1

select * into #tempcustomer from customer

select name,username,password,email,dob,address,contactno from #tempcustomer 
group by name,username,password,email,dob,address,contactno having count(id) >1

insert into #tempcustomer values('Mohan','mohanuser','23232','mohan@gmail.com','2000-03-01','d cabin','3443434343')
insert into #tempcustomer values('Mohan','mohandas','12345','mohan@gmail.com','2002-08-30','d cabin','1234567890')

create synonym mycustomer for customer

select * from mycustomer

select username, coalesce(password,'N/A') from customer


--creating proceudre with output parameter
create or alter procedure sp_noofrecordincustomer
@count int output
as
begin
	select * from customer
	select @count=@@ROWCOUNT
end

declare @count int
exec sp_noofrecordincustomer @count =@count output

select @count as 'No of records in customer table'
if @count >3
begin
	print 'Records are more than 3'
end
else if @count =0
begin
	print 'There is no record in customer table'
end
else
begin
	print 'Records are less than 3'
end

begin try

	begin tran
		delete from customer
	rollback tran 
	commit tran
end try
begin catch
select 
	error_message(),
	error_line()
end catch
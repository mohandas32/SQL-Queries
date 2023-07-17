use MD342MadanMohanDas

create table Customer
(
	Id int,
	Name Varchar(100),
	UserName Varchar(255),
	Password Varchar(255),
	Email Varchar(255),
	DOB date,
	Address NVarchar(max),
	ContactNo Varchar(10)

)
alter table customer drop column Id;  --drop id column
alter table customer add Id int identity(1,1)  --add identity
alter table customer add primary key(Id);  --add primary key
alter table customer add constraint un_email unique(Email)
alter table customer add constraint un_username unique(UserName)

select * from customer

create or alter procedure AddEditCustomer
@id int =null,
@name varchar(100),
@username varchar(255),
@password varchar(255),
@email varchar(255),
@dob date,
@address nvarchar(max),
@contactno varchar(10)

as
begin
	if @id  in (select Id from customer)
		begin
			update customer
			set Name =@name, UserName=@username,Password=@password,Email=@email,DOB=@dob,Address=@address,ContactNo=@contactno
			where Id =@id;
			print 'Record Updated Successfully for id';
		end
	else
		begin
			insert into customer(Name,UserName,Password,Email,DOB,Address,ContactNo) 
			values(@name,@username,@password,@email,@dob,@address,@contactno);
			print 'Record Inserted Succesfully'
		end

end

exec AddEditCustomer 4,'Vikrant','vikky@customer','12345','vikky@gmail.com','2000-03-01','D cabin sabarmati','9099898989'

select * from Customer



--create a function that will generate random email

create or alter function generateEmail()
returns varchar(100)
as
begin
	declare @i int, @str varchar(20), @email varchar(255)
	set @i=0
	set @str=''
	set @email =''
	while @i<10
		begin
			set @str = @str + (select char from randomchar)
			set @i=@i+1
		end
	set @email= @str +'@gmail.com'
	return @email

end


select dbo.generateEmail()


--function that create random password
create or alter function generatePassword()
returns varchar(4) --password length should not be more than 4
as
begin
	declare @i int, @str varchar(4)
	set @i=0;
	set  @str='';
	
	while @i<=1
	begin
		set @str = @str + (select alphanum from randomalphanum) + (select char from randomchar)
		set @i = @i+1
	end
	
	return @str
end


select dbo.generatePassword()

--creating view that will store the random character
create or alter view randomchar as  
select  char(round(97 + rand() * 26,0)) as char

select char from randomchar

--creating view that will store the random number
create or alter view randomalphanum as
select char(round(48 + rand() * 9,0)) as alphanum

select alphanum from randomalphanum

--7. Create a Parameterized Store Procedure for Login as per Customer/Salesman EmailId and Password.  [10]
	--(If credentials matched then show "Login Successfull" then "Invalid User Input" , If EmailId  is not having in the Table then Create Emaild with Password( Random) ).
	
create or alter procedure LoginIntoSystem
@email varchar(255),
@password varchar(255)
as
begin
	if exists (select * from customer where Email =@email and Password =@password)
		begin
			print 'Login Successfull'
		end
	else
		begin
			print 'Invlaid Username and password'
			insert into customer(Email, Password) values(dbo.generateEmail(),dbo.generatePassword())
			print 'User creates with random email and password'
		end
end

exec LoginIntoSystem 'mohan@customer','1234235'

select * from customer


select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Customer' and DATA_TYPE ='varchar'



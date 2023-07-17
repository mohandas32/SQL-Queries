use MD342MadanMohanDas

DECLARE 
@email VARCHAR(250),
@password VARCHAR(250)

SET @email='mohan@gmail.com'
SET @password='mohan@13'

IF @email= ANY (SELECT email FROM Customer) AND @password = ANY (SELECT password FROM Customer)
	BEGIN
		PRINT 'LOGIN SUCCESSFUL'
	END
ELSE
	BEGIN
		PRINT '*****LOGIN UNSUCCESFUL*****'
	END

select * from customer

  
CREATE PROCEDURE SP_LoginIntoSystem  
@email VARCHAR(255),  
@password VARCHAR(255)  
AS  
BEGIN  
 IF (1 = (SELECT count(*) FROM Customer where Email = @email and Password = @password)) --checking email and password is there or not  
 BEGIN  
  PRINT 'Login Successful'  
 END  
 ELSE  
  PRINT '***EMAIL AND PASSWORD DOES NOT EXISTS IN CUSTOMER TABLE***'  

END
EXEC SP_LoginIntoSystem 'amitc@yahoo.com','mohan@123'


create function GenereteRandomEmail()
returns varchar(255)
as
begin
	declare @i int, @str varchar(100), @email varchar(255)
	set @i=0
	set @str=''
	set @email =''
	while @i<10
		begin
			set @str = @str +char(round(64 + rand() * 26,0)) 
			set @i=@i+1
		end
	set @email= @str +'@gmail.com'
	return @email
end

select dbo.GenereteRandomEmail()
select round(rand()*10,0)
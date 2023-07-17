--FUNCTION THAT ADD 2 NUMBERS
CREATE FUNCTION add2Numbers(@n1 int, @n2 int)
RETURNS VARCHAR(200)
AS
BEGIN
	RETURN CONCAT('The sum of 2 numbers you entered is ',(@n1 + @n2));
END;

--calling add2Numbers() function
SELECT dbo.add2Numbers(1,2) 


--create a function that will return a table
CREATE FUNCTION getTableData()
RETURNS TABLE
AS
	RETURN (SELECT EMP_FNAME FROM emp_details);



--we can use that function as a table because it return table
SELECT  * FROM dbo.getTableData();

--calling function from the procedure
CREATE PROCEDURE callingFunction
AS
BEGIN
	SELECT dbo.add2Numbers(1212,111); --calling user defined function
END

EXEC callingFunction

--creating function to check if the person is eligible to vote or not
CREATE FUNCTION eligibleToVote(@age INT)
RETURNS VARCHAR(200)
BEGIN
DECLARE @msg VARCHAR(200)
	IF (@age > 18)
		SET @msg = 'YOU ARE ELIGIBLE TO VOTE'
	ELSE
		SET @msg = 'YOU ARE NOT ELIGIBLE TO VOTE'
	RETURN @msg
END

SELECT dbo.eligibleToVote(12) AS 'MESSAGE'

CREATE FUNCTION productName()
RETURNS VARCHAR(100)
BEGIN
DECLARE @pname VARCHAR(100)
	SELECT @pname = pro_name FROM proce_products
	RETURN @pname
END

SELECT dbo.productName()

select * from sys.objects where type = 'FN';



select * from customer;

select case 
		when cust_name ='Jozy Altidor' then 'Mohan Das'
		when city ='London' then 'Ahmedabad'
		else cust_name
	   end 
from customer






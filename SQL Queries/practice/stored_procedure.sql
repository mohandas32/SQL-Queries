--Example of stored procedure
--Syntax
	--CREATE OR ALTER PROCEDURE [PROCEDURE NAME] @paramatername1 datatype(size), @paramtername2 datatype(size),...
	--AS
	--BEGIN
	--	[SQL STATEMENT]
	--END;

	--Executing


--Creating stored procedure to get the employee data by passsing city as a parameter
CREATE PROCEDURE getCityWiseData @city varchar(100)
AS
BEGIN
	SELECT * FROM MDEmployee WHERE MDEmployeeCity= @city;
END;

EXEC getCityWiseData @city='Surat';



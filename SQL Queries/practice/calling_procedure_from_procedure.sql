--creating parameterized procedure

--creating 1st procedure to get the details of employee by passing parameter
ALTER PROCEDURE sp_EmpDetail (@EmpID INT, @DeptName VARCHAR(250))
AS
BEGIN

	SELECT * FROM Employees WHERE Employee_Id <= @EmpID 
END;

EXEC sp_EmpDetail 2,'Software Development'                                                                                                                                                                                                                                                                                            
--creating another procedure to call 1st procedure
ALTER PROCEDURE sp_CallAnotherProcedure
AS
BEGIN 
	DECLARE
		@EmpID INT, @DeptName VARCHAR(200)  --declaring variables

		SET @EmpID = (SELECT TOP 1 Employee_id FROM Employees);  --set is used to assign the value to the variable defined
		SET @DeptName = (SELECT TOP 1 Department FROM Employees); 

		EXEC sp_EmpDetail @EmpID, @DeptName; --calling sp_EmpDetail 
END;

EXEC sp_CallAnotherProcedure;

USE MadanMohan342;

--sorting the data randomly
SELECT * FROM MDEmployee ORDER BY NEWID() ASC;

--getting the top 3 result
SELECT TOP 3 * FROM MDEmployee;

--string function
--join to string
select concat(MDEmployeeFirstName,' ',MDEmployeeLastName), MDEmployeeDOB from MDEmployee;

--display the salary of the employee in indian currency
select format(MDEmployeeSalary,'C','in-IN') from MDEmployee;

select Repeatn',4) from MDEmployee;


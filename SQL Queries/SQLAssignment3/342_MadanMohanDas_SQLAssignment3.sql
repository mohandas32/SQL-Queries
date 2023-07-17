USE MD342MadanMohanDas;

--creating table employees
CREATE TABLE Employees
(
	Employee_Id INT,
	Employee_Name VARCHAR(100),
	Department VARCHAR(100),
	Salary DECIMAL(10,2),
	Hire_Date DATE
);

INSERT INTO Employees(Employee_Id, Employee_Name, Department, Salary, Hire_Date)
VALUES
	(1,'Mohan','Mobile Development',30000,'2020-12-02'),
	(2,'Mihir','Software Development',20000,'2022-02-02'),
	(3,'Shashank','Software Development',22000,'2022-10-02'),
	(4,'Vikrant','Sales',45000,'2002-11-12'),
	(5,'Jatin','Sales',30000,'2000-12-02'),
	(6,'Niki','Business Executive',35000,'2019-12-02'),
	(7,'Viraj','Mobile Development',30000,'2022-12-02'),
	(8,'Uttam','Mobile Development',30000,'2022-10-20'),
	(9,'Raj','Designer',30000,'2023-01-02'),
	(10,'Vedang','Sales',42000,'2010-11-02'),
	(11,'Darshan','IT',28000,'2022-12-12'),
	(12,'Krunal','Business Executive',30000,'2020-12-02'),
	(13,'Vishal','Mobile Development',50000,'2018-01-01'),
	(14,'Bhavya','Software Development',50000,'2015-12-02'),
	(15,'Sanjay','Mobile Development',25000,'2023-01-23'),
	(16,'Dhrumil','Mobile Development',30000,'2023-03-11');

--How many employees are in the table?
		SELECT COUNT(*) AS 'NO. OF EMPLOYEES' FROM Employees;

--What is the highest salary in the table?
		SELECT MAX(SALARY) AS 'HIGHEST SALARY' FROM Employees;

--What is the average salary by department?
		SELECT Department, AVG(Salary) AS 'HIGHEST SALARY BY DEPARTMENT' FROM Employees GROUP BY Department

--Who are the top 5 highest paid employees?
		SELECT TOP(5) * FROM Employees ORDER BY Salary DESC

--How many employees were hired in the last year?
		SELECT * FROM Employees WHERE YEAR(Hire_Date) = YEAR(CURRENT_TIMESTAMP) - 1;

--How do you select all columns from a table named "employees"?
		SELECT * FROM Employees;

--How do you select only the "employee_id" and "employee_name" columns from a table named "employees"?
		SELECT Employee_Id, Employee_Name FROM Employees;

--How do you filter records in a table named "employees" to only include those where the "salary" column is greater than or equal to 50000?
		SELECT * FROM Employees WHERE Salary >=50000;

--How do you filter records in a table named "employees" to only include those where the "department" column is "Sales"?
		SELECT * FROM Employees WHERE Department ='Sales';

--How do you filter records in a table named "employees" to only include those where the "hire_date" column is between January 1, 2022 and December 31, 2022?
		SELECT * FROM Employees WHERE Hire_Date BETWEEN '2022-01-01' AND '2022-12-31';

--How do you calculate the average salary of all employees in a table named "employees"?
		SELECT AVG(Salary) AS 'AVERAGE SALARY OF ALL EMPLOYEE' FROM Employees;

--How do you calculate the total salary of all employees in a table named "employees"?
		SELECT SUM(Salary) AS 'TOTAL SALARY OF ALL EMPLOYEE' FROM Employees;

--How do you calculate the highest salary in a table named "employees"?
		SELECT MAX(Salary) AS 'HIGHEST SALARY' FROM Employees;

--How do you calculate the lowest salary in a table named "employees"?
		SELECT MIN(Salary) AS 'LOWEST SALARY' FROM Employees;

--How do you calculate the number of employees in a table named "employees"?
		SELECT COUNT(Employee_Id) AS 'NO. OF EMPLOYEES' FROM Employees;

--How do you sort the records in a table named "employees" by the "salary" column in ascending order?
		SELECT * FROM Employees ORDER BY Salary  --by default sorting order is ascending

--How do you sort the records in a table named "employees" by the "salary" column in descending order?
		SELECT * FROM Employees ORDER BY Salary DESC;

--How do you count the number of employees in each department in a table named "employees"?
		SELECT Department, COUNT(Employee_Id) FROM Employees GROUP BY Department;

--How do you select the first 10 records in a table named "employees"?
		SELECT TOP(10) * FROM Employees;

--How do you select the last 10 records in a table named "employees"?
		SELECT TOP(10) * FROM Employees ORDER BY Employee_Id DESC;

--How do you select the top 5 highest paid employees from a table named "employees"?
		SELECT TOP(5) * FROM Employees ORDER BY Salary DESC;

--How do you select the top 10 highest paid employees from a table named "employees"?
		SELECT TOP(10) * FROM Employees ORDER BY Salary DESC;
		
--How do you select the bottom 5 lowest paid employees from a table named "employees"?
		SELECT TOP(5) * FROM Employees ORDER BY Salary;

--How do you select the employees who have a salary that is above the average salary in a table named "employees"?
		SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);
	
--How do you select the employees who have a salary that is below the average salary in a table named "employees"?
		SELECT * FROM Employees WHERE Salary < (SELECT AVG(Salary) FROM Employees);
		
--How do you select the employees who have a salary that is between 40000 and 60000 in a table named "employees"?
		SELECT Employee_Name FROM Employees WHERE Salary BETWEEN 40000 AND 60000;

--How do you calculate the total salary of all employees in each department in a table named "employees"?
		SELECT Department, SUM(Salary) AS 'TOTAL SALARY' FROM Employees GROUP BY Department;

--How do you calculate the average salary of all employees in each department in a table named "employees"?
		SELECT Department, AVG(Salary) AS 'AVERAGE SALARY' FROM Employees GROUP BY Department;

--How do you calculate the highest salary of all employees in each department in a table named "employees"?
		SELECT Department, MAX(Salary) AS 'HIGHEST SALARY' FROM Employees GROUP BY Department;

--How do you calculate the lowest salary of all employees in each department in a table named "employees"?
		SELECT Department, MIN(Salary) AS 'LOWEST SALARY' FROM Employees GROUP BY Department;

--How do you select the employees who have been hired in the last year from a table named "employees"?
		SELECT * FROM Employees WHERE YEAR(Hire_Date) = YEAR(CURRENT_TIMESTAMP)-1 --calculate the last year from the current_timestamp

--How do you select the employees who have been hired in the last 6 months from a table named "employees"?
--Here, with the help of datediff get the difference of current date and hire_date in month and then apply the condition
		SELECT * FROM Employees WHERE DATEDIFF(MONTH,Hire_Date,CURRENT_TIMESTAMP) <=6

--How do you select the employees who have been hired in the last 3 months from a table named "employees"?
		SELECT * FROM Employees WHERE DATEDIFF(MONTH,Hire_Date,CURRENT_TIMESTAMP) <=3

--How do you select the employees who have been hired in the last week from a table named "employees"?
		SELECT * FROM Employees WHERE DATEDIFF(WEEK,Hire_Date,CURRENT_TIMESTAMP) =1

--How do you select the employees who have a name that starts with the letter "A" in a table named "employees"?
		SELECT * FROM Employees WHERE Employee_Name LIKE 'A%';

--How do you select the employees who have a name that ends with the letter "s" in a table named "employees"?
		SELECT * FROM Employees WHERE Employee_Name LIKE '%s';
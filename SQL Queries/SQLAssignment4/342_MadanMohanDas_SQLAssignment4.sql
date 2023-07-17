USE MD342MadanMohanDas;

CREATE TABLE Join_Employees
(
	EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	Title VARCHAR(255),
	BirthDate DATE,
	HireDate DATE,
	ReportsTo INT,
	Address NVARCHAR(MAX)
);

CREATE TABLE Join_Orders
(
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT,
	EmployeeID INT,
	OrderDate DATE
);

CREATE TABLE Join_Customers
(
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	CompanyName VARCHAR(100),
	ContactName VARCHAR(15),
	ContactTitle VARCHAR(255),
	[Address] NVARCHAR(MAX),
	City VARCHAR(100),
	Country VARCHAR(100)
);

--applying the foreign key to CustomerID and EmployeeID of Join_Orders table
ALTER TABLE Join_Orders ADD CONSTRAINT fk_joinorder_joincustomer FOREIGN KEY(CustomerID) REFERENCES Join_Customers(CustomerID);
ALTER TABLE Join_Orders ADD CONSTRAINT fk_joinorder_joinemployee FOREIGN KEY(EmployeeID) REFERENCES Join_Employees(EmployeeID);

--inserting record in Join_Employee table
INSERT INTO Join_Employees(FirstName, LastName, Title, BirthDate, HireDate, ReportsTo, Address)
VALUES
	('Mohan','Das','Software Developer','2000-03-01','2022-01-23',1,'D cabin, Sabarmati, Ahmedabad'),
	('Vikrant','Anand','Mobile Developer','2001-05-11','2002-01-23',3,'Near Bopal Gam BRTS, Bopal'),
	('Jatin','Dhote','Business Executive','2002-01-01','2021-01-23',1,'Motera Road, Near Motera Stadium'),
	('Darshan','Rawal','Sales Executive','2000-01-01','2020-01-23',1,'Satyam Residency, New Ranip'),
	('Vedang','Prajapati','Software Developer','1990-03-01','2005-01-23',1,'Near Science City');
	
--inserting record in Join_Customer table
INSERT INTO Join_Customers (CompanyName, ContactName, ContactTitle, Address, City, Country) 
VALUES
	('Centimia', 'Nanon', 'Honorable', '2 Buell Lane', 'New York', 'USA'),
	('Youbridge', 'Welbie', 'Ms', '0439 Waxwing Pass', 'Derbur', 'China'),
	('Kare', 'Sayres', 'Rev', '916 Hintze Drive', 'Shuiche', 'China'),
	('Feedmix', 'Keslie', 'Dr', '2966 Hallows Plaza', 'California', 'USA'),
	('Ainyx', 'Portia', 'Mr', '02733 Duke Avenue', 'Mumbai', 'India');


--inserting record in Join_Orders table
INSERT INTO Join_Orders(CustomerID, EmployeeID, OrderDate)
VALUES
	(1,2,'2022-12-12'),
	(2,1,'2023-01-23'),
	(1,1,'2022-12-31'),
	(3,4,'2023-11-12'),
	(4,5,'2022-10-10'),
	(1,5,'2021-02-14'),
	(5,3,'2022-02-02'),
	(2,1,'2023-02-12'),
	(3,2,'2023-03-11'),
	(1,2,'2023-01-14');

SELECT * FROM Join_Employees;
SELECT * FROM Join_Customers;
SELECT * FROM Join_Orders;


-- 1. Write a SQL query to retrieve the list of all orders made by customers in the "USA".
	SELECT O.*,C.Country FROM Join_Orders O INNER JOIN Join_Customers C 
	ON C.CustomerID = O.CustomerID WHERE C.Country='USA';

-- 2. Write a SQL query to retrieve the list of all customers who have placed an order.
	SELECT DISTINCT C.CustomerID, C.ContactName FROM Join_Orders O INNER JOIN Join_Customers C 
	ON C.CustomerID = O.CustomerID;

-- 3. Write a SQL query to retrieve the list of all employees who have not yet placed an order.
	SELECT E.EmployeeID, E.FirstName, E.LastName FROM Join_Employees E LEFT JOIN Join_Orders O
	ON E.EmployeeID = O.EmployeeID WHERE O.EmployeeID IS NULL;

-- 4. Write a SQL query to retrieve the list of all employees who have placed an order.
	SELECT DISTINCT E.EmployeeID,E.FirstName, E.LastName FROM Join_Orders O INNER JOIN Join_Employees E 
	ON E.EmployeeID = O.EmployeeID;

-- 5. Write a SQL query to retrieve the list of all customers who have not yet placed an order.
	SELECT C.CustomerID, C.ContactName FROM Join_Customers C LEFT JOIN Join_Orders O 
	ON C.CustomerID = O.CustomerID WHERE O.CustomerID IS NULL;

-- 6. Write a SQL query to retrieve the list of all customers who have placed an order, along with the order date.
	SELECT C.CustomerID, C.ContactName, O.OrderDate FROM Join_Customers C INNER JOIN Join_Orders O 
	ON O.CustomerID = C.CustomerID;

-- 7. Write a SQL query to retrieve the list of all orders placed by a particular customer.
	SELECT O.* FROM Join_Orders O INNER JOIN Join_Customers C 
	ON C.CustomerID = O.CustomerID WHERE O.CustomerID=2;  --finding the customer with CustomerID 2

-- 8. Write a SQL query to retrieve the list of all orders placed by a particular employee.
	SELECT O.* FROM Join_Orders O INNER JOIN Join_Employees E
	ON E.EmployeeID = O.EmployeeID WHERE O.EmployeeID = 2;  --finding the employee with EmployeeID 2

-- 9. Write a SQL query to retrieve the list of all orders placed by a particular customer on a particular date.
	SELECT O.* FROM Join_Orders O INNER JOIN Join_Employees E
	ON E.EmployeeID = O.EmployeeID WHERE O.CustomerID = 1 AND O.OrderDate='2022-12-12'; --finding the order for date 2022-12-12 and CustomerID 1

-- 10. Write a SQL query to retrieve the list of all customers who have not yet placed an order, sorted by their country.
	SELECT C.CustomerID, C.ContactName, C.Country FROM Join_Customers C LEFT JOIN Join_Orders O
	ON C.CustomerID = O.CustomerID WHERE O.CustomerID IS NULL ORDER BY C.Country;

-- 11. Write a SQL query to retrieve the list of all orders placed by customers in the "USA", sorted by order date.
	SELECT O.*,C.Country FROM Join_Orders O INNER JOIN Join_Customers C 
	ON C.CustomerID = O.CustomerID WHERE C.Country='USA' ORDER BY O.OrderDate;

-- 12. Write a SQL query to retrieve the list of all employees who have not yet placed an order, sorted by last name.
	SELECT E.EmployeeID, E.FirstName, E.LastName FROM Join_Employees E LEFT JOIN Join_Orders O 
	ON E.EmployeeID = O.EmployeeID  WHERE O.EMPLOYEEID IS NULL ORDER BY E.LastName;

-- 13. Write a SQL query to retrieve the list of all customers who have placed an order, sorted by their company name.
	SELECT DISTINCT C.CustomerID, C.ContactName,C.CompanyName FROM Join_Customers C INNER JOIN Join_Orders O 
	ON C.CustomerID = O.CustomerID ORDER BY C.CompanyName;

-- 14. Write a SQL query to retrieve the list of all employees who have placed an order, sorted by their hire date.
	SELECT DISTINCT E.EmployeeID, E.FirstName, E.LastName,E.HireDate FROM Join_Employees E INNER JOIN Join_Orders O 
	ON E.EmployeeID= O.EmployeeID ORDER BY E.HireDate;

-- 15. Write a SQL query to retrieve the list of all customers who have placed an order on a particular date, sorted by their company name.
	SELECT C.CustomerID, C.ContactName,C.CompanyName, O.OrderDate FROM Join_Orders O INNER JOIN Join_Customers C
	ON C.CustomerID = O.CustomerID WHERE O.OrderDate='2022-12-12' ORDER BY C.CompanyName;

-- 16. Write a SQL query to retrieve the list of all customers who have placed an order, along with the employee who handled the order.
-- Join the 3 tables Join_Orders, Join_Customers and Join_Employees
	SELECT C.CustomerID, C.ContactName, O.OrderDate, E.EmployeeID, CONCAT(E.FirstName,' ',E.LastName) AS 'NAME OF EMPLOYEE' FROM Join_Orders O
	INNER JOIN Join_Customers C ON C.CustomerID=O.CustomerID
	INNER JOIN Join_Employees E ON O.EmployeeID=E.EmployeeID;

-- 17. Write a SQL query to retrieve the list of all employees who have placed an order, along with the customer who placed the order.
	SELECT E.EmployeeID, E.FirstName, E.LastName, O.OrderDate, C.CustomerID, CONCAT(C.ContactTitle,' ',C.ContactName) AS 'CUSTOMER NAME' FROM Join_Orders O
	INNER JOIN Join_Employees E ON E.EmployeeID=O.EmployeeID
	INNER JOIN Join_Customers C ON O.CustomerID=C.CustomerID;

-- 18. Write a SQL query to retrieve the list of all orders placed by customers in a particular country, along with the customer name and order date.
	SELECT C.ContactName,C.Country, O.* FROM Join_Orders O INNER JOIN Join_Customers C 
	ON C.CustomerID = O.CustomerID WHERE C.Country='USA';

-- 19. Write a SQL query to retrieve the list of all orders placed by employees who were born in a particular year, along with the employee name and order date.
	SELECT O.*, E.FirstName, E.LastName FROM Join_Orders O INNER JOIN Join_Employees E
	ON O.EmployeeID = E.EmployeeID WHERE YEAR(E.BirthDate) = 2000;

-- 20. Write a SQL query to retrieve the list of all customers who have placed an order, along with the customer name, order date, and employee who handled the order.
	SELECT C.ContactName, O.OrderDate, E.EmployeeID, CONCAT(E.FirstName,' ',E.LastName) AS 'NAME OF EMPLOYEE' FROM Join_Orders O
	INNER JOIN Join_Customers C ON C.CustomerID=O.CustomerID
	INNER JOIN Join_Employees E ON O.EmployeeID=E.EmployeeID;

-- 21. Write a SQL query to retrieve the list of all orders placed by customers who have a particular contact title, along with the customer name and order date.
	SELECT C.ContactName, O.* FROM Join_Orders O INNER JOIN Join_Customers C 
	ON C.CustomerID = O.CustomerID WHERE C.ContactTitle='Ms';

-- 22. Write a SQL query to retrieve the list of all orders placed by employees who have a particular job title, along with the employee name and order date.
	SELECT E.FirstName, E.LastName, O.* FROM Join_Orders O INNER JOIN Join_Employees E
	ON O.EmployeeID = E.EmployeeID WHERE E.Title='Software Developer';

-- 23. Write a SQL query to retrieve the list of all customers who have placed an order on a particular date, along with the customer name, order date, and employee who handled the order.
	SELECT C.CustomerID, C.ContactName, O.OrderDate, O.EmployeeID, E.FirstName, E.LastName FROM Join_Orders O 
	INNER JOIN Join_Customers C ON C.CustomerID = O.CustomerID 
	INNER JOIN Join_Employees E ON O.EmployeeID = E.EmployeeID WHERE O.OrderDate='2022-12-12';

-- 24. Write a SQL query to retrieve the list of all orders placed by customers in a particular city, along with the customer name and order date.
	SELECT C.ContactName, C.City, O.* FROM Join_Orders O INNER JOIN Join_Customers C
	ON O.CustomerID = C.CustomerID WHERE C.City = 'New York';

-- 25. Write a SQL query to retrieve the list of all orders placed by employees who were born in a particular city, along with the employee name and order date.
	SELECT O.*, E.FirstName, E.LastName FROM Join_Orders O INNER JOIN Join_Employees E
	ON O.EmployeeID = E.EmployeeID WHERE E.Address LIKE '%Ahmedabad%';

-- 26. Write a SQL query to retrieve the list of all customers who have placed an order, along with the customer name, order date, and employee who handled the order, sorted by order date.
	SELECT C.CustomerID, C.ContactName, O.OrderDate, O.EmployeeID, E.FirstName, E.LastName FROM Join_Orders O 
	INNER JOIN Join_Customers C ON C.CustomerID = O.CustomerID
	INNER JOIN Join_Employees E ON O.EmployeeID = E.EmployeeID  ORDER BY O.OrderDate;

-- 27. Write a SQL query to retrieve the list of all orders placed by customers in a particular country, along with the customer name and order date, sorted by order date.
	SELECT C.CompanyName, O.*, C.Country FROM Join_Orders O INNER JOIN Join_Customers C
	ON O.CustomerID = C.CustomerID WHERE C.Country='USA' ORDER BY O.OrderDate;


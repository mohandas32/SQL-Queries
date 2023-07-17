USE MD342MadanMohanDas;

--creating emp_details table
CREATE TABLE emp_details
(
	EMP_IDNO INT PRIMARY KEY,
	EMP_FNAME VARCHAR(100),
	EMP_LNAME VARCHAR(100),
	EMP_DEPT INT
);

--creating emp_department table
CREATE TABLE emp_department
(
	DPT_CODE INT PRIMARY KEY,
	DPT_NAME VARCHAR(100),
	DPT_ALLOTMENT INT
);



--creating company_mast table
CREATE TABLE company_mast
(
	COM_ID INT PRIMARY KEY,
	COM_NAME VARCHAR(100)
);

--creating item_mast table
CREATE TABLE item_mast
(
	PRO_ID INT PRIMARY KEY,
	PRO_NAME VARCHAR(100),
	PRO_PRICE DECIMAL(10,2),
	PRO_COM INT
);


--creating orders table
CREATE TABLE orders
(
	ord_no INT PRIMARY KEY,
	purch_amt DECIMAL(10,2),
	ord_date DATE,
	customer_id INT,
	salesman_id INT
);

--creating salesman table
CREATE TABLE salesman
(
	salesman_id INT PRIMARY KEY,
	salesman_name VARCHAR(100), 
	city VARCHAR(100), 
	commission DECIMAL(3,2)  --3 digit before and 2 digit after decimal
);

--creating customer table
CREATE TABLE customer
(
	customer_id INT PRIMARY KEY,
	cust_name VARCHAR(100),
	city VARCHAR(100),
	grade INT,
	salesman_id INT
);

--applying foreign key to EMP_DEPT of emp_details table
ALTER TABLE emp_details ADD CONSTRAINT fk_empdetails_empdept FOREIGN KEY (EMP_DEPT) REFERENCES emp_department(DPT_CODE)

--applying foreign key to PRO_COM of item_mast table
ALTER TABLE item_mast ADD CONSTRAINT fk_item_companymast FOREIGN KEY (PRO_COM) REFERENCES company_mast(COM_ID);

--applying foreign key to salesman_id of customer table
ALTER TABLE customer ADD CONSTRAINT fk_customer_salesman FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id);


--applying foreign key to customer_id and salesman_id of orders table
ALTER TABLE orders ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);
ALTER TABLE orders ADD CONSTRAINT fk_order_salesman FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id);


--inserting data in emp_details table
INSERT INTO emp_details(EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT) 
VALUES
	(127323, 'Michale', 'Robbin', 57),
	(526689, 'Carlos', 'Snares', 63),
	(328717, 'Jhon', 'Snares', 63),
	(444527, 'Joseph', 'Dosni', 47),
	(659831, 'Zanifer', 'Emily', 47),
	(847674, 'Kuleswar', 'Sitaraman', 57),
	(748681, 'Henrey', 'Gabriel', 47),
	(555935, 'Alex', 'Manuel', 57),
	(539569, 'George', 'Mardy', 27),
	(733843, 'Mario', 'Saule', 63),
	(631548, 'Alan', 'Snappy', 27),
	(839139, 'Maria', 'Foster',57);

--inserting data in emp_department table
INSERT INTO emp_department(DPT_CODE, DPT_NAME, DPT_ALLOTMENT)
VALUES
	  (57, 'IT', 65000),
      (63,  'Finance', 15000),
      (47, 'HR', 240000),
      (27, 'RD', 55000),
      (89,  'QC',75000);


--inserting data in comapny_mast table
INSERT INTO company_mast(COM_ID, COM_NAME)
VALUES
	(11, 'Samsung'),
	(12, 'iBall'),
	(13, 'Epsion'),
	(14, 'Zebronics'),
	(15, 'Asus'),
	(16, 'Frontech');

--inserting data in item_mast
INSERT INTO item_mast(PRO_ID, PRO_NAME, PRO_PRICE, PRO_COM)
VALUES
	(101, 'Mother Board', 3200, 15),
	(102, 'Key Board', 450, 16),
	(103, 'ZIP drive', 250, 14),
	(104, 'Speaker', 550, 16),
	(105, 'Monitor', 5000, 11),
	(106, 'DVD drive', 900, 12),
	(107, 'CD drive', 800, 12),
	(108, 'Printer', 2600, 13),
	(109, 'Refill cartridge', 350, 13),
	(110, 'Mouse', 250, 12);

--inserting data into orders table
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
	(70001, 150.5, '2012-10-05', 3005, 5002),
	(70009, 270.65, '2012-09-10', 3001, 5005),
	(70002, 65.26, '2012-10-05', 3002, 5001),
	(70004, 110.5, '2012-08-17', 3009, 5003),
	(70007, 948.5, '2012-09-10', 3005, 5002),
	(70005, 2400.6, '2012-07-27', 3007, 5001),
	(70008, 5760, '2012-09-10', 3002, 5001),
	(70010, 1983.43, '2012-10-10', 3004, 5006),
	(70003, 2480.4, '2012-10-10', 3009, 5003),
	(70012, 250.45, '2012-06-27', 3008, 5002),
	(70011, 75.29, '2012-08-17', 3003, 5007),
	(70013, 3045.6, '2012-04-25', 3002, 5001);
	

--inserting data into salesman table
INSERT INTO salesman(salesman_id, salesman_name, city, commission )
VALUES
	(5001, 'James Hoog', 'New York', 0.15),
	(5002, 'Nail Knite', 'Paris', 0.13),
	(5005, 'Pit Alex', 'London', 0.11),
	(5006, 'Mc Lyon', 'Paris', 0.14),
	(5007, 'Paul Adam', 'Rome', 0.13),
	(5003, 'Lauson Hen', 'San Jose', 0.12);


--inserting data into customer table
INSERT INTO customer(customer_id, cust_name, city, grade,salesman_id )
VALUES
	(3002, 'Nick Rimando', 'New York', 100, 5001),
	(3007, 'Brad Davis', 'New York', 200, 5001),
	(3005, 'Graham Zusi', 'California', 200, 5002),
	(3008, 'Julian Green', 'London', 300, 5002),
	(3004, 'Fabian Johnson', 'Paris', 300, 5006),
	(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
	(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
	(3001, 'Brad Guzan', 'London', NULL ,5005);


SELECT * FROM emp_details;
SELECT * FROM emp_department;
SELECT * FROM customer;
SELECT * FROM salesman;
SELECT * FROM item_mast;
SELECT * FROM company_mast;
SELECT * FROM orders;


--1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city
	SELECT C.cust_name, S.salesman_name, C.city, S.city FROM customer C INNER JOIN salesman S
	ON C.city = S.city;


--2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000
	SELECT O.ord_no, O.purch_amt, C.cust_name, C.city FROM orders O
	INNER JOIN customer C ON O.customer_id = C.customer_id
	WHERE O.purch_amt BETWEEN 500 AND 2000;

--3. Write a SQL statement to know which salesman are working for which customer.
	SELECT S.salesman_name, C.cust_name FROM customer C INNER JOIN salesman S
	ON C.salesman_id = S.salesman_id;

--4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%
	SELECT C.customer_id, C.cust_name, S.commission FROM customer C INNER JOIN salesman S
	ON C.salesman_id = S.salesman_id
	WHERE S.commission > 0.12;

--5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%
	SELECT C.* FROM customer C
	INNER JOIN salesman S
	ON C.salesman_id = S.salesman_id AND C.city <> S.city AND S.commission > 0.12;

--6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.
	SELECT O.ord_no, O.ord_date, O.purch_amt, C.customer_id, C.cust_name, S.salesman_id, S.salesman_name, S.commission  FROM orders O
	INNER JOIN customer C ON O.customer_id = C. customer_id
	INNER JOIN salesman S ON O.salesman_id = S.salesman_id;

--7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
	SELECT O.*, C.cust_name, C.city, C.grade, S.salesman_name, S.commission  FROM orders O
	INNER JOIN customer C ON O.customer_id = C. customer_id
	INNER JOIN salesman S ON O.salesman_id = S.salesman_id;

--8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own. 
	SELECT * FROM customer WHERE salesman_id IS NOT NULL OR salesman_id IS NULL ORDER BY customer_id;

--9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own. 
	SELECT * FROM customer WHERE salesman_id IS NOT NULL AND  grade < 300 ORDER BY customer_id;
	
--10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
	SELECT C.cust_name, C.city, O.ord_date, O.ord_date, O.purch_amt FROM customer C
	INNER JOIN orders O
	ON O.customer_id = C.customer_id ORDER BY O.ord_date;
	
--11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own. 
	SELECT C.cust_name, C.city, O.ord_date, O.ord_date, O.purch_amt FROM customer C
	INNER JOIN orders O
	ON O.customer_id = C.customer_id

--12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.   
	SELECT DISTINCT S.* FROM salesman S 
	INNER JOIN customer C
	ON C.salesman_id = S.salesman_id ORDER BY S.salesman_id;

--13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier.
	SELECT S.* FROM salesman S 
	INNER JOIN customer C
	ON S.salesman_id = C.salesman_id
	INNER JOIN orders O
	ON C.customer_id = O.customer_id;

--14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
	SELECT S.* FROM salesman S 
	INNER JOIN customer C
	ON S.salesman_id = C.salesman_id
	INNER JOIN orders O
	ON C.customer_id = O.customer_id
	WHERE purch_amt >=2000 AND grade IS NOT NULL;
	
	
--15 . Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
	SELECT C.cust_name, C.city, O.ord_no, O.ord_date, O.purch_amt FROM customer C
	INNER JOIN orders O
	ON C.customer_id = O.customer_id;

--16 . Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade. 
	SELECT C.cust_name, C.city, O.ord_no, O.ord_date, O.purch_amt FROM customer C
	INNER JOIN orders O
	ON C.customer_id = O.customer_id
	WHERE grade IS NULL;

--17 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.
	SELECT S.salesman_name, C.cust_name FROM salesman S 
	CROSS JOIN customer C;

--18 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that customer who belongs to a city.
	SELECT S.salesman_name, C.cust_name FROM salesman S, customer C WHERE C.city IS NOT NULL;
	
--19 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade. 
	SELECT S.salesman_name, C.cust_name FROM salesman S 
	CROSS JOIN customer C
	WHERE C.city IS NOT NULL AND
	C.grade IS NOT NULL;

--20 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade. 
	SELECT S.salesman_name, C.cust_name FROM salesman S 
	CROSS JOIN customer C
	WHERE C.city <> S.city AND
	C.grade IS NOT NULL;

--21 . Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company.
	SELECT I.*, COMP.* FROM item_mast I 
	LEFT JOIN company_mast COMP
	ON I.PRO_COM = COMP.COM_ID;

--22 . Write a SQL query to display the item name, price, and company name of all the product
	SELECT I.PRO_NAME, I.PRO_PRICE, COMP.COM_NAME FROM item_mast I 
	INNER JOIN company_mast COMP
	ON I.PRO_COM = COMP.COM_ID;

--23 . Write a SQL query to display the average price of items of each company, showing the name of the company. 
	SELECT COMP.COM_NAME, AVG(I.PRO_PRICE) AS 'AVERAGE PRICE OF ITEM' FROM item_mast I
	INNER JOIN company_mast COMP
	ON I.PRO_COM = COMP.COM_ID GROUP BY COMP.COM_NAME;

--24 . Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.
	SELECT COMP.COM_NAME, AVG(I.PRO_PRICE) AS 'AVERAGE PRICE OF ITEM' FROM item_mast I
	INNER JOIN company_mast COMP
	ON I.PRO_COM = COMP.COM_ID GROUP BY COMP.COM_NAME HAVING AVG(PRO_PRICE) >= 350;

-- 25 . Write a SQL query to display the name of each company along with the ID and price for their most expensive product.
	SELECT COMP.COM_ID, COMP.COM_NAME, MAX(I.PRO_PRICE) AS 'PRICE OF MOST EXPENSIVE PRODUCT' FROM item_mast I 
	INNER JOIN company_mast COMP
	ON I.PRO_COM = COMP.COM_ID GROUP BY COMP.COM_NAME,COMP.COM_ID;

--26 . Write a query in SQL to display all the data of employees including their department
	SELECT E.*, D.DPT_NAME FROM emp_details E
	LEFT JOIN emp_department D
	ON E.EMP_DEPT = D.DPT_CODE;

--27 . Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department.
	SELECT E.EMP_FNAME, E.EMP_LNAME, D.DPT_NAME, D.DPT_ALLOTMENT FROM  emp_details E
	INNER JOIN emp_department D
	ON E.EMP_DEPT = D.DPT_CODE;

--28 . Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000. 
	SELECT E.EMP_FNAME, E.EMP_LNAME, D.DPT_NAME, D.DPT_ALLOTMENT FROM  emp_details E
	INNER JOIN emp_department D
	ON E.EMP_DEPT = D.DPT_CODE WHERE D.DPT_ALLOTMENT > 50000;

--29 . Write a query in SQL to find the names of departments where more than two employees are working.
	SELECT D.DPT_NAME AS 'DEPARTMENT HAVING MORE THAN 2 EMPLOYEES' FROM  emp_details E
	INNER JOIN emp_department D
	ON E.EMP_DEPT = D.DPT_CODE GROUP BY D.DPT_NAME HAVING COUNT(E.EMP_IDNO) > 2;

--30 . Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'
	SELECT O.*, S.salesman_name FROM orders O
	LEFT JOIN salesman S
	ON O.salesman_id = S.salesman_id WHERE S.salesman_name = 'Paul Adam';

--31 . Write a query to display all the orders for the salesman who belongs to the city London.
	SELECT O.*, S.city FROM orders O
	LEFT JOIN salesman S
	ON O.salesman_id = S.salesman_id WHERE S.city = 'London';

--32 . Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.
	SELECT O.*, S.salesman_name FROM orders O
	LEFT JOIN salesman S
	ON O.salesman_id = S.salesman_id WHERE O.customer_id = 3007;

--33 . Write a query to display all the orders which values are greater than the average order value for 10th October 2012.
	SELECT * FROM orders WHERE purch_amt > (SELECT AVG(purch_amt) FROM orders WHERE ord_date = '2012-10-10')

--34 . Write a query to find all orders attributed to a salesman in New york.
	SELECT O.* FROM orders O
	LEFT JOIN salesman S
	ON O.salesman_id = S.salesman_id WHERE S.city = 'New York';

--35 . Write a query to count the customers with grades above New York's average
	SELECT COUNT(customer_id) AS 'NO. OF CUSTOMER' FROM customer 
	WHERE grade > (SELECT AVG(GRADE) FROM customer WHERE city = 'New york')

--36 . Write a query to display all the customers with orders issued on date 17th August, 2012
	SELECT C.*, O.ord_date FROM customer C
	LEFT JOIN orders O
	ON C.customer_id = O.customer_id WHERE O.ord_date = '2012-08-17';

--37 . Write a query to find the name and numbers of all salesmen who had more than one customer. 
	SELECT S.salesman_id, S.salesman_name  FROM  salesman S
	LEFT JOIN customer C
	ON S.salesman_id = C.salesman_id GROUP BY S.salesman_id, S.salesman_name HAVING COUNT(C.customer_id) > 1;

--38 . Write a query to find all orders with order amounts which are above-average amounts for their customers.
	SELECT * FROM orders WHERE purch_amt > (SELECT AVG(purch_amt) FROM orders)

--39 . Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.  
	SELECT * FROM orders WHERE purch_amt >= (SELECT AVG(purch_amt) FROM orders)

--40 . Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date
	SELECT ord_date, SUM(purch_amt) FROM orders GROUP BY ord_date HAVING SUM(purch_amt) > 1000.00 ;

--41 . Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.
	SELECT * FROM customer WHERE EXISTS (SELECT * FROM customer WHERE city = 'London');
	
--42 . Write a query to find the salesmen who have multiple customers.

	SELECT S.salesman_id, S.salesman_name FROM salesman S
	LEFT JOIN customer C
	ON S.salesman_id = C.salesman_id GROUP BY S.salesman_id, S.salesman_name HAVING COUNT(C.customer_id) > 1;

--43 . Write a query to find all the salesmen who worked for only one customer
	SELECT S.salesman_id, S.salesman_name FROM salesman S
	LEFT JOIN customer C
	ON S.salesman_id = C.salesman_id GROUP BY S.salesman_id,S.salesman_name HAVING COUNT(C.customer_id) = 1;

--44 . Write a query that extract the rows of all salesmen who have customers with more than one orders.
	SELECT O.salesman_id, S.salesman_name, COUNT(customer_id) AS 'NO. OF CUSTOMER' FROM salesman S
	INNER JOIN orders O
	ON S.salesman_id = O.salesman_id GROUP BY O.salesman_id, S.salesman_name HAVING COUNT(O.customer_id) > 1;

--45 . Write a query to find salesmen with all information who lives in the city where any of the customers lives. 
	SELECT S.* FROM salesman S
	INNER JOIN customer C
	ON C.salesman_id = S.salesman_id WHERE S.city  = ANY (SELECT city FROM customer)

--46 . Write a query to find all the salesmen for whom there are customers that follow them.
	SELECT DISTINCT S.* FROM salesman S
	LEFT JOIN customer C
	ON C.salesman_id = S.salesman_id;

--47 . Write a query to display the salesmen which name are alphabetically lower than the name of the customers.
	SELECT * FROM salesman S
	WHERE  EXISTS(SELECT cust_name FROM customer WHERE S.salesman_name < cust_name);

--48 . Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
	SELECT * FROM customer C
	WHERE grade > ANY (SELECT grade FROM customer WHERE C.cust_name < 'New York')

--49 . Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012. 
	SELECT * FROM orders WHERE purch_amt > ANY (SELECT purch_amt FROM orders WHERE ord_date = '2012-09-10')

--50 . Write a query to find all orders with an amount smaller than any amount for a customer in London.
	SELECT * FROM orders O 
	WHERE purch_amt < ANY (SELECT O.purch_amt FROM orders O 
							INNER JOIN customer C 
							ON O.customer_id = C.customer_id WHERE C.city = 'London'); 

--51 . Write a query to display all orders with an amount smaller than any amount for a customer in London.
	SELECT * FROM orders O 
	WHERE purch_amt < ANY (SELECT O.purch_amt FROM orders O 
							INNER JOIN customer C 
							ON O.customer_id = C.customer_id WHERE C.city = 'London');

--52 . Write a query to display only those customers whose grade are, in fact, higher than every customer in New York. 
	SELECT customer_id, cust_name FROM customer WHERE grade > ALL (SELECT grade FROM customer WHERE city = 'New York');

--53 . Write a query to find only those customers whose grade are, higher than every customer to the city New York. 
	SELECT customer_id, cust_name,grade FROM customer WHERE grade > ALL (SELECT grade FROM customer WHERE city = 'New York');

--54 . Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London
	SELECT * FROM customer WHERE grade <> ALL (SELECT grade FROM customer WHERE city = 'London' AND grade IS NOT NULL);

--55 . Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris.
	SELECT * FROM customer WHERE grade <> ALL (SELECT grade FROM customer WHERE city = 'Paris');  --grade of paris is 300

--56 . Write a query to find all those customers who hold a different grade than any customer of the city Dallas.
	/* BEGIN TRAN
		UPDATE customer SET city = 'Dallas' WHERE city = 'Moscow'
	ROLLBACK TRAN
	COMMIT TRAN */ --update the value of city of customer to check the value

	SELECT * FROM customer WHERE grade NOT IN (SELECT grade FROM customer WHERE city = 'Dallas'); --grade of customer is 200 whose city is Dallas

--57 . Write a SQL query to find the average price of each manufacturer's products along with their name.
	SELECT I.PRO_NAME, AVG(I.PRO_PRICE) AS 'AVERAGE PRICE' FROM company_mast COMP
	INNER JOIN item_mast I
	ON I.PRO_COM = COMP.COM_ID GROUP BY I.PRO_NAME;

--58 . Write a SQL query to display the average price of the products which is more than or equal to 350 along with their names.
	SELECT PRO_NAME, AVG(PRO_PRICE) FROM item_mast GROUP BY PRO_NAME HAVING AVG(PRO_PRICE) >= 350;


--59 . Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
	SELECT COMP.COM_NAME, MAX(I.PRO_PRICE) AS 'EXPENSIVE PRODUCT PRICE' FROM company_mast COMP
	INNER JOIN item_mast I
	ON COMP.COM_ID = I.PRO_COM
	GROUP BY COMP.COM_NAME;



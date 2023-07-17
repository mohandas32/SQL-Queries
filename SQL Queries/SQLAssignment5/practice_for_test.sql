use MD342MadanMohanDas
SELECT * FROM emp_details;
SELECT * FROM emp_department;
SELECT * FROM customer;
SELECT * FROM salesman;
SELECT * FROM item_mast;
SELECT * FROM company_mast;
SELECT * FROM orders;


--1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city
	
	select s.salesman_name,c.cust_name from salesman s
	inner join customer c
	on c.salesman_id = s.salesman_id and c.city = s.city;

--2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000

	select o.ord_date, c.cust_name, c.city from orders o
	inner join customer c
	on o.customer_id = c.customer_id and purch_amt between 500 and 2000;
--3. Write a SQL statement to know which salesman are working for which customer.
	
	select s.salesman_id,s.salesman_name,c.customer_id, c.cust_name from salesman s
	inner join customer c
	on c.salesman_id = s.salesman_id

--4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%

	select s.salesman_id,s.salesman_name,c.customer_id, c.cust_name from customer c
	inner join salesman s
	on c.salesman_id = s.salesman_id where s.commission > 0.12

--5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%

	select c.* from customer c
	left join salesman s
	on c.salesman_id = s.salesman_id and c.city <> s.city where s.commission > 0.12

--6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.

	select o.ord_no, o.ord_date, o.purch_amt, o.customer_id, s.salesman_id, s.commission*100 as 'Commission in %' from orders o
	inner join salesman s
	on o.salesman_id = s.salesman_id;

--7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.



--8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own. 
	select * from customer where salesman_id is not null or salesman_id is null order by customer_id

--9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own. 
	select * from customer where (salesman_id is not null or salesman_id is null) and grade < 300 order by customer_id
	
--10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
	select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt from orders o
	inner join customer c
	on o.customer_id = c.customer_id;

--11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own. 

	select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.salesman_name, s.commission from orders o
	inner join customer c
	on o.customer_id = c.customer_id
	inner join salesman s
	on o.salesman_id = s.salesman_id


--12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.  
	select s.* from salesman s
	left join customer c
	on s.salesman_id = c.salesman_id 


--13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier.

--14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.

--15 . Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.

--16 . Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade. 

--17 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.
	
	select * from salesman, customer

--18 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that customer who belongs to a city.
	
	select * from salesman s
	cross join customer c 
	where c.city is not null;


--19 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade. 

	select * from salesman s
	cross join customer c
	where s.city is not null and c.grade is not null

--20 . Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade. 

	select * from salesman s 
	cross join customer c
	where s.city <> c.city and c.grade is not null;

--21 . Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company.

	select i.*, com.COM_NAME from item_mast i
	left join company_mast com
	on i.pro_com = com.com_id;

--22 . Write a SQL query to display the item name, price, and company name of all the product

	select i.pro_name, i.pro_price, com.com_name from item_mast i
	inner join company_mast com
	on i.PRO_COM=com.COM_ID;

--23 . Write a SQL query to display the average price of items of each company, showing the name of the company. 
	select com.COM_NAME,avg(i.pro_price) as 'Average price' from item_mast i
	inner join company_mast com
	on i.PRO_COM = com.COM_ID group by com.COM_NAME

--24 . Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.
	
	select com.COM_NAME,avg(i.pro_price) as 'Average price greater than or equal to 350' from item_mast i
	inner join company_mast com
	on i.PRO_COM = com.COM_ID group by com.COM_NAME having avg(i.pro_price) > 350

--25 . Write a SQL query to display the name of each company along with the ID and price for their most expensive product.

	select com.com_id, com.com_name, max(i.pro_price) from company_mast com
	inner join item_mast i
	on com.com_id = i.pro_com group by com.com_id, com.com_name;

--26 . Write a query in SQL to display all the data of employees including their department
	select emp.*, empdept.dpt_name from emp_details emp
	left join emp_department empdept
	on emp.EMP_DEPT = empdept.DPT_CODE

--27 . Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department.

	select emp.emp_fname, emp.emp_lname, dept.dpt_name, dept.dpt_allotment from emp_details emp
	inner join emp_department dept
	on emp.EMP_DEPT = dept.DPT_CODE

--28 . Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000. 
	select emp.emp_fname, emp.emp_lname, dept.dpt_name from emp_details emp
	inner join emp_department dept
	on emp.EMP_DEPT = dept.DPT_CODE where dept.DPT_ALLOTMENT >50000

--29 . Write a query in SQL to find the names of departments where more than two employees are working.
	select dept.DPT_NAME from emp_department dept
	inner join emp_details emp
	on emp.EMP_DEPT = dept.DPT_CODE
	group by dept.DPT_NAME having count(emp.emp_idno) > 2

--30 . Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'
	select o.* from orders o
	left join salesman s
	on o.salesman_id = s.salesman_id where  s.salesman_name='Paul Adam'

--31 . Write a query to display all the orders for the salesman who belongs to the city London.
	select o.* from orders o
	left join salesman s
	on o.salesman_id = s.salesman_id where s.city = 'London'

--32 . Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.
	

--33 . Write a query to display all the orders which values are greater than the average order value for 10th October 2012.

--34 . Write a query to find all orders attributed to a salesman in New york.
	select o.* from orders o
	left join salesman s
	on s.salesman_id=o.salesman_id where s.city='New York';

--35 . Write a query to count the customers with grades above New York's average

	
--36 . Write a query to display all the customers with orders issued on date 17th August, 2012

--37 . Write a query to find the name and numbers of all salesmen who had more than one customer. 

--38 . Write a query to find all orders with order amounts which are above-average amounts for their customers.

--39 . Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.  

--40 . Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date

--41 . Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London. 

--42 . Write a query to find the salesmen who have multiple customers. 

--43 . Write a query to find all the salesmen who worked for only one customer

--44 . Write a query that extract the rows of all salesmen who have customers with more than one orders.

--45 . Write a query to find salesmen with all information who lives in the city where any of the customers lives. 

--46 . Write a query to find all the salesmen for whom there are customers that follow them.

--47 . Write a query to display the salesmen which name are alphabetically lower than the name of the customers.

--48 . Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.

--49 . Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012. 

--50 . Write a query to find all orders with an amount smaller than any amount for a customer in London.

--51 . Write a query to display all orders with an amount smaller than any amount for a customer in London.

--52 . Write a query to display only those customers whose grade are, in fact, higher than every customer in New York. 

--53 . Write a query to find only those customers whose grade are, higher than every customer to the city New York. 

--54 . Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London

--55 . Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris.

--56 . Write a query to find all those customers who hold a different grade than any customer of the city Dallas.

--57 . Write a SQL query to find the average price of each manufacturer's products along with their name.
	select com.com_name, avg(i.pro_price) from company_mast com
	inner join item_mast i
	on com.COM_ID = i.PRO_COM group by com.COM_NAME;

--58 . Write a SQL query to display the average price of the products which is more than or equal to 350 along with their names.
	select pro_name,round(avg(pro_price),2) as 'Average Price' from item_mast  group by pro_name having avg(pro_price) >=350

--59 . Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
	select com.COM_NAME,max(i.pro_price) from item_mast i
	inner join company_mast com
	on com.COM_ID = i.PRO_COM
	group by com.com_name 


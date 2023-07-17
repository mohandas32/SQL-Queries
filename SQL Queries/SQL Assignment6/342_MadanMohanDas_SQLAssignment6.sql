USE MD342MadanMohanDas;

--creating products table
CREATE TABLE proce_products
(
	pro_id INT IDENTITY(101,1) PRIMARY KEY,
	pro_name VARCHAR(100),
	pro_price DECIMAL(10,2),
);

--creating customer table
CREATE TABLE proce_customers
(
	customer_id INT IDENTITY(1,1) PRIMARY KEY,
	customer_name VARCHAR(100),
	customer_address NVARCHAR(MAX),
);

--creating orders table
CREATE TABLE proce_orders
(
	order_id INT IDENTITY(1001,1) PRIMARY KEY,
	order_date DATE,
	purch_amt DECIMAL(10,2),
	customer_id INT,
	pro_id INT,
	CONSTRAINT fk_orders_customer FOREIGN KEY(customer_id) REFERENCES proce_customers(customer_id),
	CONSTRAINT fk_orders_product FOREIGN KEY(pro_id) REFERENCES proce_products(pro_id)	
);

ALTER TABLE proce_orders ADD payment_status VARCHAR(20); --adding column into proce_orders table

--inserting records in table
INSERT INTO proce_customers(customer_name, customer_address) 
VALUES
	('Mohan','D cabin, Sabarmati, Ahmedabad'),
	('Amit','Shastrinagar, Kalol, Gandhinagar'),
	('Amit','Ambika nagar, Kalol, Gandhinagar'),
	('Rohan','Kumkum residency, Kadi, Mehasana'),
	('Mick','11 Lala Street New York'),
	('Mihir','12th floor Shyam Residency, Vaishondevi circle'),
	('Shashank','Satyam society, Shaibaug, Ahmedabad'),
	('Vikrant','Pooja residency, near bopal gam, Ahmedabad'),
	('Vedang','3rd floor science city park, near science city'),
	('Jatin','11 krishna nagar, Bhopal'),
	('Niki','122 Shivam society,near maninagar'),
	('Raj','11th floor Khusi residency, near sargasan, Gandhinagar'),
	('Dhrumil','Near APMC market, vasna, Ahmedabad'),
	('Irfan','12th floor sukh society, near prahaladnagar, Ahmedabad'),
	('Alibaba','122 sui chi, Beging'),
	('Dhoni','12/2 shaam residency, Ranchi'),
	('Virat','17th floor Sukh residency, near rajori garden, Delhi'),
	('Rohit','D cabin, Sabarmati, Ahmedabad'),
	('Hariom','Vallabhpark, Sabarmati, Ahmedabad'),
	('Arjun','rishab apartment, Sabarmati, Ahmedabad');

INSERT INTO proce_products(pro_name, pro_price)
VALUES
	('Dell Monitor',15000),
	('iball Mouse',1200),
	('JBl Bluetooth speaker',5000),
	('Earphone',500.50),
	('Fastrack Watch',1500),
	('HP Laptop',35000),
	('Hp Pendrive',625.50),
	('Study Lamp',1000),
	('Joystick',500.25),
	('Milton Watter Bottle',725.50),
	('Dell Keyboard',950),
	('Samsung Smart TV',28000.50),
	('Video Game',1500),
	('Logistic Mouse',1200),
	('Sonata Smart Watch',6000),
	('Titan Analog Watch',3400.25),
	('Scanner',12000),
	('Mouse Pad',150.50),
	('Gaming PC',55000),
	('CD Drive',800);

	INSERT INTO proce_orders(order_date, purch_amt, customer_id, pro_id,payment_status)
	VALUES
		('2020-12-12',2400,1,120,'paid'),
		('2021-01-01',12000,1,117,'paid'),
		('2022-02-11',70000,4,106,'paid'),
		('2020-01-01',30000,3,101,'paid'),
		('2023-01-01',2400,11,102,'unpaid'),
		('2023-12-31',3000,5,105,'unpaid'),
		('2020-12-12',2000,18,108,'unpaid'),
		('2020-12-12',1600,1,120,'paid'),
		('2022-11-11',12000,13,117,'paid'),
		('2023-12-12',2400,14,120,'unpaid'),
		('2023-11-30',3000,11,105,'unpaid'),
		('2022-03-01',2400,12,120,'paid'),
		('2022-12-23',625.50,16,107,'paid'),
		('2021-10-09',10000,14,103,'paid'),
		('2020-03-22',24000,10,117,'paid'),
		('2019-02-03',2400,9,120,'unpaid'),
		('2022-01-03',70000,20,106,'paid'),
		('2023-10-11',1001,19,104,'paid'),
		('2021-11-10',300.50,7,118,'paid'),
		('2020-02-02',6800.50,12,116,'paid');

SELECT * FROM proce_products
SELECT * FROM proce_customers
SELECT * FROM proce_orders


--1.Create a stored procedure called "get_customers" that returns all customers from the "customers" table.
	CREATE PROCEDURE get_customers
	AS
	BEGIN
		SELECT * FROM proce_customers;
	END

	EXEC get_customers

--2.Create a stored procedure called "get_orders" that returns all orders from the "orders" table.
	CREATE PROCEDURE get_orders
	AS
	BEGIN
		SELECT * FROM proce_orders;
	END

	EXEC get_orders

--3.Create a stored procedure called "get_order_details" that accepts an order ID as a parameter and returns the details of that order (i.e., the products and quantities).
	CREATE PROCEDURE get_order_details (@ordId INT)
	AS
	BEGIN
		SELECT * FROM proce_orders WHERE order_id = @ordId;
	END
	
	EXEC get_order_details @ordId = 1001;

--4.Create a stored procedure called "get_customer_orders" that accepts a customer ID as a parameter and returns all orders for that customer.
	CREATE PROCEDURE get_customer_orders (@custId INT)
	AS
	BEGIN	
		SELECT * FROM proce_orders WHERE customer_id = @custId;
	END

	EXEC get_customer_orders @custId = 14
	
--5.Create a stored procedure called "get_order_total" that accepts an order ID as a parameter and returns the total amount of the order.
	CREATE PROCEDURE get_order_total (@ordId INT)
	AS
	BEGIN
		SELECT purch_amt FROM proce_orders WHERE order_id = @ordId
	END

	EXEC get_order_total @ordId = 1006;

--6.Create a stored procedure called "get_product_list" that returns a list of all products from the "products" table.
	CREATE PROCEDURE get_product_list
	AS
	BEGIN
		SELECT * FROM proce_products
	END

	EXEC get_product_list;

--7.Create a stored procedure called "get_product_info" that accepts a product ID as a parameter and returns the details of that product.
	CREATE PROCEDURE get_product_info (@proId INT)
	AS
	BEGIN
		SELECT * FROM proce_products WHERE pro_id = @proId
	END

	EXEC get_product_info @proId = 104;

--8.Create a stored procedure called "get_customer_info" that accepts a customer ID as a parameter and returns the details of that customer.
	CREATE PROCEDURE get_customer_info (@custId INT)
	AS
	BEGIN
		SELECT * FROM proce_customers WHERE customer_id = @custId
	END

	EXEC get_customer_info @custId = 14;

--9.Create a stored procedure called "update_customer_info" that accepts a customer ID and new information as parameters and updates the customer's information in the "customers" table.
	CREATE PROCEDURE update_customer_info (@custId INT, @custName VARCHAR(100), @custAdd NVARCHAR(MAX))
	AS 
	BEGIN
		UPDATE proce_customers SET customer_name = @custName, customer_address = @custAdd WHERE @custId = customer_id;
	END

	EXEC update_customer_info @custId = 4, @custName = 'Anand', @custAdd = '122 shivam apartment, near prahaladnagar'

--10.Create a stored procedure called "delete_customer" that accepts a customer ID as a parameter and deletes that customer from the "customers" table.
	CREATE PROCEDURE delete_customer (@custId INT)
	AS
	BEGIN
	--sometime we will not able to delete the customer record from proce_customer table because it is referencing in proce_orders table
		DELETE FROM proce_customers WHERE customer_id = @custId;
	END

	EXEC delete_customer @custId = 2;

--11.Create a stored procedure called "get_order_count" that accepts a customer ID as a parameter and returns the number of orders for that customer.
	CREATE PROCEDURE get_order_count (@custId INT)
	AS
	BEGIN
		SELECT COUNT(order_id) AS 'NO. OF ORDERS' FROM proce_orders 
		WHERE customer_id = @custId
	END

	EXEC get_order_count @custId = 12

--12.Create a stored procedure called "get_customer_balance" that accepts a customer ID as a parameter and returns the customer's balance (i.e., the total amount of all orders minus the total amount of all payments).
	CREATE PROCEDURE get_customer_balance (@custId INT)
	AS
	BEGIN
		SELECT SUM(purch_amt) - (SELECT SUM(purch_amt) FROM proce_orders WHERE payment_status = 'paid' AND customer_id = @custId) 
		FROM proce_orders WHERE customer_id = @custId
	END

	EXEC get_customer_balance @custId = 14;


--13.Create a stored procedure called "get_customer_payments" that accepts a customer ID as a parameter and returns all payments made by that customer.
	CREATE PROCEDURE get_customer_payment (@custId INT)
	AS
	BEGIN
		SELECT * FROM proce_orders 
		WHERE customer_id = @custId AND payment_status = 'paid'
	END

	EXEC get_customer_payment @custId = 14

--14.Create a stored procedure called "add_customer" that accepts a name and address as parameters and adds a new customer to the "customers" table.
	CREATE PROCEDURE add_customer (@custName VARCHAR(100), @custAdd VARCHAR(255))
	AS 
	BEGIN 
		INSERT INTO proce_customers(customer_name, customer_address) VALUES(@custName, @custAdd)
	END

	EXEC add_customer @custName = 'Rajkumar', @custAdd= '11 Raj society, near shaligram complex'

--15.Create a stored procedure called "get_top_products" that returns the top 10 products based on sales volume.
	CREATE PROCEDURE get_top_products
	AS
	BEGIN
		SELECT TOP(10) P.pro_id, P.pro_name, O.purch_amt FROM proce_products P
		INNER JOIN proce_orders O
		ON P.pro_id = O.pro_id ORDER BY O.purch_amt DESC;
	END

	EXEC get_top_products

--16.Create a stored procedure called "get_product_sales" that accepts a product ID as a parameter and returns the total sales volume for that product.
	CREATE PROCEDURE get_product_sales (@proId INT)
	AS
	BEGIN
		SELECT SUM(purch_amt) AS 'TOTAL SALES FOR THAT PRODUCT' FROM proce_orders WHERE pro_id = @proId;
	END

	EXEC get_product_sales @proId = 120;

--17.Create a stored procedure called "get_customer_orders_by_date" that accepts a customer ID and date range as parameters and returns all orders for that customer within the specified date range.
	CREATE PROCEDURE get_customer_orders_by_date (@custId INT, @fromDate DATE, @toDate DATE)
	AS
	BEGIN
		SELECT * FROM proce_orders WHERE customer_id = @custId AND order_date BETWEEN @fromDate AND @toDate;
	END

	EXEC get_customer_orders_by_date @custId = 1, @fromDate = '2020-12-12', @toDate = '2023-01-01'


--18.Create a stored procedure called "get_order_details_by_date" that accepts an order ID and date range as parameters and returns the details of that order within the specified date range.
	CREATE PROCEDURE get_order_details_by_date (@orderId INT, @fromDate DATE, @toDate DATE)
	AS
	BEGIN
		SELECT * FROM proce_orders WHERE order_id = @orderId AND order_date BETWEEN @fromDate AND @toDate;
	END

	EXEC get_order_details_by_date @orderId = 1003, @fromDate = '2020-01-01', @toDate = '2023-01-01'

--19.Create a stored procedure called "get_product_sales_by_date" that accepts a product ID and date range as parameters and returns the total sales volume for that product within the specified date range.
	CREATE PROCEDURE get_product_sales_by_date (@proId INT, @fromDate DATE, @toDate DATE)
	AS
	BEGIN
		SELECT SUM(purch_amt) AS 'TOTAL SALES OF PRODUCT' FROM proce_orders 
		WHERE pro_id = @proId AND order_date BETWEEN @fromDate AND @toDate
	END

	EXEC get_product_sales_by_date @proId = 120, @fromDate = '2018-01-01', @toDate = '2023-01-01'


--20.Create a stored procedure called "get_customer_balance_by_date" that accepts a customer ID and date range as parameters and returns the customer's balance within the specified date range.
	CREATE PROCEDURE get_customer_balance_by_date (@custId INT, @fromDate DATE, @toDate DATE)
	AS
	BEGIN
		SELECT * FROM proce_orders WHERE customer_id = @custId AND order_date BETWEEN @fromDate AND @toDate;
	END

	EXEC get_customer_balance_by_date @custId = 1, @fromDate = '2020-12-31', @toDate = '2023-03-20'


--21.Create a stored procedure called "add_order" that accepts a customer ID, order date, and total amount as parameters and adds a new order to the "orders" table.
	CREATE PROCEDURE add_order (@custId INT, @orderDate DATE, @total_amt DECIMAL(10,2))
	AS
	BEGIN
		INSERT INTO proce_orders(order_date, purch_amt, customer_id, pro_id)
		VALUES 
			(@orderDate, @total_amt, @custId, 117) --passing pro_id as 117 for this record
	END

	EXEC add_order @custId = 14 , @orderDate = '2023-01-23', @total_amt = 36000
	
--22.Create a stored procedure called "update_order_total" that accepts an order ID and a new total amount as parameters and updates the total amount of the order in the "orders" table.
	CREATE PROCEDURE update_order_total (@ordId INT, @total_amt DECIMAL(10,2))
	AS
	BEGIN
		UPDATE proce_orders SET purch_amt = @total_amt WHERE order_id = @ordId
	END

	EXEC update_order_total @ordId = 1002, @total_amt = 72000

--23.Create a stored procedure called "delete_order" that accepts an order ID as a parameter and deletes that order from the "orders" table.
	CREATE PROCEDURE delete_order (@ordId INT)
	AS
	BEGIN
		DELETE FROM proce_orders WHERE order_id = @ordId
	END

	EXEC delete_order @ordId = 1008


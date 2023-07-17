create table NameTable
(
	id int,
	name varchar(100)
)

insert into NameTable 
values(1,'Mohan'),(2,'Amit'),(3,'John'),(4,'Michel'),(5,'Dhoni'),(6,'Virat'),(7,'Rohit'),(8,'Jatin'),(9,'Raj'),(10,'Dhrumil'),     (11,'Shreya'),(12,'Suresh'),(13,'Mahesh'),(14,'Ram'),(15,'Shyam');


create or alter function RandomName()
returns varchar(100)
as
begin
declare 
@randomname varchar(100)
set @randomname= (select Name from NameTable where id = (select digit from randomnum))
return  @randomname
end

create view randomnum
as select round(1+rand()*15,0) as digit

select dbo.RandomName();


select * from customer
select * from salesman
select * from Items
select * from orders
select * from orderdetails


--3. Create a Parameterized Store Procedure to retrive all the OrderDetails as per Customer (If CustomerId not passed then retrive all the orders) ( Make sure to Add Everything in Single Procedure) [8]
--	Information I want : 
		--CustomerName
		--ItemName
		--Item Rate
		--Qty
		--OrderAmount (Qty * ItemRate)

create or alter procedure getOrderDetails
@cust_id int =null  -- give the default value to the column
as
begin
	if @cust_id is not null
		begin
			select c.name, i.name, i.rate, od.orderqty, (i.rate * od.OrderQty) as 'Order Quantity' from Orders o
			inner join customer c on c.id = o.Customer
			inner join OrderDetails od on od.Orderid = o.id
			inner join items i on i.id = od.ItemId where c.id=@cust_id
		
		end
	else
		begin
			select c.name, i.name, i.rate, od.orderqty, (i.rate * od.OrderQty) as 'Order Quantity' from Orders o
			inner join customer c on c.id = o.Customer
			inner join OrderDetails od on od.Orderid = o.id
			inner join items i on i.id = od.ItemId
		end
end

exec getOrderDetails 






		
--4. Create a User Defined Function that will retrive TotalOrderAmount from the OrderDetails Table as per Customer. [8]
--	I just want total amount as per customerid I Passed.

create or alter function md_totalorderamount(@cust_id int)
returns decimal(15,2)
as
begin
	return  (select sum(od.orderamount)  from OrderDetails od
	inner join orders o on o.id = od.OrderId
	inner join customer c on c.id = o.Customer where c.id= @cust_id)

end

select dbo.md_totalorderamount(3)
select * from OrderDetails


create or alter function md_totalorderquantity(@cust_id int)
returns int
as
begin
	return  (select sum(od.OrderQty)  from OrderDetails od
	inner join orders o on o.id = od.OrderId
	inner join customer c on c.id = o.Customer where c.id= @cust_id)

end
select dbo.md_totalorderquantity(3)
	
--5. Create a prameterized Store Procedure to retrive all the Order Information as per Customer. (If CustomerId not passed then retrive all the orders) [8]
--	Information I want : 
		--CustomerName
		--OrderNo
		--OrderQty (Total Qty of all the Items) (Using Function)
		--OrderAmount (Total Amount of Order) (Using Function)
		--SalesmanName
		--Address
		--City
		--ContactNo
		--MOP Name
		--DOD

create or alter procedure md_OrderInfoByCustomer
@cust_id int = null
as 
begin
	if @cust_id is not null
		begin
			select c.name,o.orderno,o.orderqty
		end
	else
		begin

		end

end

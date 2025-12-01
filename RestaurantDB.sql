-- Reastaurant Menu & Order System 
create database Reastaurant;
use Reastaurant;
--Tables : Menu, CustomerS, OrderS, OrderDetail

--Menu Table
create table Menu(
	foodID int primary key identity(1,1),
	ItemName varchar(200) not null,
	category varchar(100) not null,
	price Decimal(10,2) not null check(price>0)
);

--Customer Table
create table customers(
	customerID int primary key identity(1,1),
	name varchar(200) not null,
	email varchar(200) unique not null,
	phone varchar(200) unique not null
);

--Order Table
create table orders(
	orderID int primary key identity(1,1),
	customerID int,
	orderDate datetime default GETDATE(),
	TotalAmount decimal(10,2) NOT NULL DEFAULT 0,
	foreign key (customerID) references customers(customerID)
);

--OrderDetail Table
create table OrderDetails(
	orderDetailID int primary key identity(1,1),
	orderID int not null,
	foodID int not null,
	quantity int not null CHECK(quantity>0),
	LineTotal decimal(10,2) not null,
	foreign key (orderID) references orders(orderID),
	foreign key (foodID) references Menu(foodID)	
);

--Baisc Queries 
select * from Menu;
select * from customers;
select * from orders;
select * from OrderDetails;
SELECT NAME FROM SYS.TABLES;
select name from sys.databases;


-- INSERTING SAMPLE DATA
--MENU
INSERT INTO Menu (ItemName, category, price)
VALUES 
('Margherita Pizza', 'Main Course', 350),
('Veg Burger', 'Main Course', 200),
('French Fries', 'Starter', 120),
('Chocolate Cake', 'Dessert', 180),
('Paneer Tikka', 'Starter', 250),
('Masala Dosa', 'Main Course', 220),
('Spring Rolls', 'Starter', 150),
('Gulab Jamun', 'Dessert', 100),
('Cold Coffee', 'Beverage', 90),
('Lemonade', 'Beverage', 70),
('Chicken Biryani', 'Main Course', 400),
('Veg Pulao', 'Main Course', 280),
('Ice Cream Sundae', 'Dessert', 160),
('Garlic Bread', 'Starter', 130),
('Pasta Alfredo', 'Main Course', 300);
-- CUSTOMERS
INSERT INTO customers (name, email, phone)
VALUES 
('Rahul Sharma', 'rahul@email.com', '9876543210'),
('Priya Mehta', 'priya@email.com', '9123456789'),
('Ankit Verma', 'ankit@email.com', '9988776655'),
('Sneha Kapoor', 'sneha@email.com', '9112233445'),
('Rohan Gupta', 'rohan@email.com', '9001122334'),
('Neha Singh', 'neha@email.com', '9556677889'),
('Arjun Malhotra', 'arjun@email.com', '9223344556'),
('Kavita Joshi', 'kavita@email.com', '9334455667'),
('Manish Patel', 'manish@email.com', '9445566778'),
('Divya Nair', 'divya@email.com', '9667788990'),
('Suresh Reddy', 'suresh@email.com', '9778899001'),
('Pooja Bansal', 'pooja@email.com', '9889900112'),
('Vivek Kumar', 'vivek@email.com', '9990011223'),
('Meera Iyer', 'meera@email.com', '9111223344'),
('Aditya Jain', 'aditya@email.com', '9222334455');

--ORDERS
INSERT INTO orders (customerID, orderDate, TotalAmount)
VALUES 
(1, '2025-11-01 12:30:00', 470),
(2, '2025-11-02 19:00:00', 530),
(3, '2025-11-03 13:15:00', 300),
(4, '2025-11-04 20:45:00', 650),
(5, '2025-11-05 18:20:00', 220),
(6, '2025-11-06 14:10:00', 400),
(7, '2025-11-07 21:00:00', 700),
(8, '2025-11-08 12:00:00', 350),
(9, '2025-11-09 19:30:00', 280),
(10, '2025-11-10 13:00:00', 500),
(11, '2025-11-11 20:00:00', 600),
(12, '2025-11-12 18:40:00', 450),
(13, '2025-11-13 14:30:00', 320),
(14, '2025-11-14 19:50:00', 580),
(15, '2025-11-15 12:15:00', 720);

--ORDERDETAILS
INSERT INTO OrderDetails (orderID, foodID, quantity, LineTotal)
VALUES
(1, 1, 1, 350),
(1, 3, 1, 120),
(2, 2, 2, 400),
(2, 4, 1, 180),
(3, 6, 1, 220),
(3, 10, 1, 70),
(4, 11, 1, 400),
(4, 5, 1, 250),
(5, 7, 1, 150),
(5, 9, 1, 70),
(6, 12, 1, 280),
(6, 14, 1, 120),
(7, 1, 2, 700),
(8, 15, 1, 300),
(9, 8, 2, 200);

--BEGINNER LEVEL QUERIES: Q1 to Q8
--Q1:List all menu items with their category and price.
SELECT Menu.ItemName, Menu.category, Menu.price FROM Menu;

--Q2:Show all customers’ names and phone numbers.
select customers.name, customers.phone from customers;

--Q3:Retrieve all orders placed on 2025-11-05.
select orders.orderID from orders where orderDate >= '2025-11-05' and orderDate <= '2025-11-06';

select orders.orderID from orders where convert(date, orderDate) =  '2025-11-05';

select customers.name, orders.orderID, orders.TotalAmount, orders.orderDate from customers
join orders on customers.customerID = orders.orderID
where orders.orderDate between '2025-11-02' and '2025-11-06';

--Q4:Display the details of OrderID = 3 (items, quantity, line total).
select customers.name, Menu.ItemName, orderDetails.quantity, orderDetails.LineTotal,orders.TotalAmount
from orders
join orderDetails on  orders.orderID = orderDetails.orderID
join Menu on orderDetails.foodID = Menu.foodID
join customers on customers.customerID = orders.customerID
where orders.orderID =3;

--Q5:- Find the price of “Veg Burger”.
select Menu.ItemName, menu.price from Menu where ItemName = 'veg burger';

select sum(Menu.price) AS TotalMenuPrice from Menu;

--Q6:- Insert a new customer into the Customers table.
insert into customers
values (16,'Amit Gupta','amit.official.180820@gmail.com','9166107149');

select customers.name from customers where customers.customerID = 16

--Q7: - Update the price of “Paneer Tikka” to ₹270.
select Menu.ItemName, menu.price from Menu where Menu.ItemName = 'paneer tikka';

update Menu
set Menu.price = 270
where menu.ItemName = 'paneer tikka';

--Q8: - Delete the customer with CustomerID = 16
delete from customers where customers.customerID = 16;
select count(customers.customerID) from customers;

--INTERMEDIATE LEVEL QUERIES
--Q9:Show all orders with customer name, order date, and total amount.
select orders.orderID, customers.name, orders.orderDate, orders.TotalAmount
from orders
join customers on customers.customerID = orders.customerID;

--Q10: - List all items ordered by “Priya Mehta”.
select customers.name, Menu.ItemName
from customers
join orders on customers.customerID = orders.customerID
join orderDetails on orders.orderID = orderDetails.orderID
join Menu on orderDetails.foodID = Menu.foodID
where customers.name = 'priya mehta';

--Q11:- Find the total sales amount for November 2025.
select sum(orders.TotalAmount) AS TotalSalesAmount  from orders where month(orders.orderDate)=11;

--Q12:Show the most popular item (highest total quantity ordered).
select Menu.ItemName, OrderDetails.quantity from Menu
join OrderDetails on orderDetails.foodID = Menu.foodID
where orderDetails.quantity > 1;

--Q13: - Find customers who spent more than ₹500 in total.
select customers.name, orders.TotalAmount from customers
join orders on customers.customerID = orders.customerID
where orders.TotalAmount >500;

--Q14: Display the top 3 highest-priced menu items.
select top 3 Menu.ItemName, Menu.price from Menu
order by Menu.price desc;

--Q15:Count how many orders each customer has placed.
select customers.name, count(OrderDetails.orderDetailID) as NumberOfOrders from orders
join OrderDetails on orderDetails.orderID = orders.orderID
join customers on customers.customerID = orders.customerID
group by customers.name
order by NumberOfOrders desc;

--Q16: Show sales grouped by category (Starters, Main Course, Desserts, Beverages)
select Menu.category, sum(OrderDetails.LineTotal) As TotalSales from Menu
join orderDetails on Menu.foodID = orderDetails.foodID
group by Menu.category;

--Q17: Find the average order value.
select avg(orders.totalamount) as AverageOrderValue from orders;

--Q18: - List customers who never placed an order.
--Solution: 

--Q20.	Write a query to find the top 2 customers by spending.
select top 2 customers.name, sum(orders.TotalAmount) as TotalSpend from customers
join orders on customers.customerID = orders.customerID
group by customers.name
order by TotalSpend desc;

--Q23.	Show all orders that included “Pizza”
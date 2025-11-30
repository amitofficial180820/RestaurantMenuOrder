-- Reastaurant Menu & Order System 
create database Reastaurant;
use Reastaurant;

--Tables : Menu, CustomerS, OrderS, OrderDetail

--Menu Table
create table Menu(
	foodID int primary key,
	ItemName varchar(200) not null,
	category varchar(100) not null,
	price Decimal(10,2) not null check(price>0)
);

--Customer Table
create table customers(
	customerID int primary key,
	name varchar(200) not null,
	email varchar(200) unique not null,
	phone varchar(200) unique not null
);

--Order Table
create table orders(
	orderID int primary key,
	customerID int,
	orderDate datetime default GETDATE(),
	TotalAmount decimal(10,2) NOT NULL DEFAULT 0,
	foreign key (customerID) references customers(customerID)
);

--OrderDetail Table
create table OrderDetails(
	orderDetailID int primary key,
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

-- INSERTING SAMPLE DATA
--MENU
INSERT INTO MENU(foodID,ItemName,category,price)
VALUES (1, 'Margherita Pizza', 'Main Course', 350),
(2, 'Veg Burger', 'Main Course', 200),
(3, 'French Fries', 'Starter', 120),
(4, 'Chocolate Cake', 'Dessert', 180),
(5, 'Paneer Tikka', 'Starter', 250),
(6, 'Masala Dosa', 'Main Course', 220),
(7, 'Spring Rolls', 'Starter', 150),
(8, 'Gulab Jamun', 'Dessert', 100),
(9, 'Cold Coffee', 'Beverage', 90),
(10, 'Lemonade', 'Beverage', 70),
(11, 'Chicken Biryani', 'Main Course', 400),
(12, 'Veg Pulao', 'Main Course', 280),
(13, 'Ice Cream Sundae', 'Dessert', 160),
(14, 'Garlic Bread', 'Starter', 130),
(15, 'Pasta Alfredo', 'Main Course', 300);

--CUSTOMERS
INSERT INTO	customers(customerID, name, email, phone)
values (1, 'Rahul Sharma', '9876543210', 'rahul@email.com'),
(2, 'Priya Mehta', '9123456789', 'priya@email.com'),
(3, 'Ankit Verma', '9988776655', 'ankit@email.com'),
(4, 'Sneha Kapoor', '9112233445', 'sneha@email.com'),
(5, 'Rohan Gupta', '9001122334', 'rohan@email.com'),
(6, 'Neha Singh', '9556677889', 'neha@email.com'),
(7, 'Arjun Malhotra', '9223344556', 'arjun@email.com'),
(8, 'Kavita Joshi', '9334455667', 'kavita@email.com'),
(9, 'Manish Patel', '9445566778', 'manish@email.com'),
(10, 'Divya Nair', '9667788990', 'divya@email.com'),
(11, 'Suresh Reddy', '9778899001', 'suresh@email.com'),
(12, 'Pooja Bansal', '9889900112', 'pooja@email.com'),
(13, 'Vivek Kumar', '9990011223', 'vivek@email.com'),
(14, 'Meera Iyer', '9111223344', 'meera@email.com'),
(15, 'Aditya Jain', '9222334455', 'aditya@email.com');
--MISTAKENLY EMAIL ENTERED IN PHONE NUMBER, SO IT IS RESOLVED HERE: 
update customers
set email = phone ,
	phone = email;

--ORDERS
INSERT INTO orders(orderID, customerID, orderDate, TotalAmount)
values (1, 1, '2025-11-01 12:30:00', 470),
(2, 2, '2025-11-02 19:00:00', 530),
(3, 3, '2025-11-03 13:15:00', 300),
(4, 4, '2025-11-04 20:45:00', 650),
(5, 5, '2025-11-05 18:20:00', 220),
(6, 6, '2025-11-06 14:10:00', 400),
(7, 7, '2025-11-07 21:00:00', 700),
(8, 8, '2025-11-08 12:00:00', 350),
(9, 9, '2025-11-09 19:30:00', 280),
(10, 10, '2025-11-10 13:00:00', 500),
(11, 11, '2025-11-11 20:00:00', 600),
(12, 12, '2025-11-12 18:40:00', 450),
(13, 13, '2025-11-13 14:30:00', 320),
(14, 14, '2025-11-14 19:50:00', 580),
(15, 15, '2025-11-15 12:15:00', 720);

--ORDERDETAILS
INSERT INTO OrderDetails(orderDetailID, orderID, foodID, quantity, LineTotal)
values(1, 1, 1, 1, 350),
(2, 1, 3, 1, 120),
(3, 2, 2, 2, 400),
(4, 2, 4, 1, 180),
(5, 3, 6, 1, 220),
(6, 3, 10, 1, 70),
(7, 4, 11, 1, 400),
(8, 4, 5, 1, 250),
(9, 5, 7, 1, 150),
(10, 5, 9, 1, 70),
(11, 6, 12, 1, 280),
(12, 6, 14, 1, 120),
(13, 7, 1, 2, 700),
(14, 8, 15, 1, 300),
(15, 9, 8, 2, 200);

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

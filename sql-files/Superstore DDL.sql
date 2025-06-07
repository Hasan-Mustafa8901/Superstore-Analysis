CREATE DATABASE superstoreDB;

USE superstoreDB;

CREATE TABLE Customers(
customer_id VARCHAR(20) PRIMARY KEY,
customer_name VARCHAR(100),
segment VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
postal_code VARCHAR(6),
region VARCHAR(15),
country VARCHAR(50)
);
SELECT * FROM Customers;
DELETE FROM Customers;

CREATE TABLE Products(
product_id VARCHAR(20) PRIMARY KEY,
category VARCHAR(50),
sub_category VARCHAR(50),
product_name VARCHAR(100)
);

SELECT * FROM Products;

CREATE TABLE Orders(
row_id VARCHAR(4) PRIMARY KEY,
order_id VARCHAR(20),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(25),
product_id VARCHAR(20),
customer_id VARCHAR(20),
sales DECIMAL(10,3),
quantity INT,
discount DECIMAL(2,2),
profit DECIMAL(10,3) ,
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

SELECT * FROM Orders;

DESCRIBE Orders;
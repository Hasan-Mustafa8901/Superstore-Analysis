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

-- Monthly Sales and profit--
SELECT 
	DATE_FORMAT(order_date,'%Y-%m') AS month,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit
FROM Orders
GROUP BY month
ORDER BY month;
--

-- Customer Segment Analysis -- 

SELECT 
	c.segment,
    COUNT( DISTINCT o.customer_id) as no_of_customers,
    SUM(o.sales) as total_sales_per_segment
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY no_of_customers;
---

-- Top 5 Best and Worst Performing Products --
-- --Best performing----
SELECT 
	o.product_id,
    p.product_name,
    SUM(o.profit) AS profit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY o.product_id
ORDER BY profit DESC
LIMIT 5;
-- Worst Performing --- 
SELECT 
	o.product_id,
    p.product_name,
    SUM(o.profit) AS profit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY o.product_id
ORDER BY profit 
LIMIT 5;
--

-- Regional Sales Performance--

SELECT
	c.region, 
    SUM(o.sales) as total_sales,
    SUM(o.profit) as total_profit
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_profit DESC;

-- Shipping Efficiency Analysis -- 

SELECT
    AVG(DATEDIFF(ship_date, order_date)) AS Avg_delivery_days
FROM Orders;

SELECT
	ship_mode,
    AVG(DATEDIFF(ship_date, order_date)) AS Avg_delivery_days
FROM Orders
GROUP BY ship_mode
ORDER BY Avg_delivery_days DESC;

-- Advanced queries--

-- Profitablity by category and sub-category --
SELECT
	p.category,
    p.sub_category,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.category, p.sub_category
ORDER BY total_profit DESC;

-- Customer Loyalty : Repeat Customer Count --

SELECT 
	c.customer_id,
    c.customer_name,
    COUNT(DISTINCT(o.order_id)) AS total_orders
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING total_orders > 5
ORDER BY total_orders DESC;

-- Top 10 Customers by Revenue -- 

SELECT 
	c.customer_name,
    SUM(o.sales) as total_sales
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Customers by Profit -- 

SELECT 
	c.customer_name,
    SUM(o.profit) as total_profit
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_profit DESC
LIMIT 10;

-- Profit - Discount Correlation -- 

SELECT 
	discount,
    ROUND(AVG(profit),3) as avg_profit
FROM Orders
GROUP BY discount
ORDER BY discount DESC;

-- Regions with Lowest profit margins --

SELECT
	c.region,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit,
    ROUND(SUM(o.profit)/SUM(o.sales) * 100, 3) as profit_margins_pct
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY profit_margins_pct ASC;

-- Dead Products : Products with Sales but negative profit.

SELECT
	p.product_name,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_id
HAVING total_profit < 0
ORDER BY total_profit ASC;

-- Window Function: Rank Customers by Sales Within Each Region --


SELECT 
	c.region,
    c.customer_id,
    c.customer_name,
    SUM(o.sales) as total_sales,
    RANK() OVER (PARTITION BY c.region ORDER BY SUM(o.sales) DESC ) AS sales_rank 
FROM Orders o 
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region, c.customer_id, c.customer_name
ORDER BY c.region, sales_rank;

-- CTE: Find Product Categories with High Average Discount and Low Profit--

WITH DiscountedProducts AS(
	SELECT
		p.category,
        p.sub_category,
        ROUND(AVG(o.discount),2) AS avg_discount,
        SUM(o.profit) AS total_profit
	FROM Orders o
    JOIN Products p ON o.product_id = p.product_id
    GROUP BY p.category, p.sub_category
)
SELECT *
FROM DiscountedProducts
WHERE avg_discount > 0.2 AND total_profit < 0
ORDER BY avg_discount DESC;

-- KPI Metrics Report: Sales, Profit, Shipping Time, and Margin by Region -- 

SELECT
	c.region,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit,
    ROUND(AVG(DATEDIFF(o.ship_date, o.order_date)),2) AS avg_shipping_days,
    ROUND(SUM(o.profit) / SUM(o.sales) * 100, 2) AS profit_margin_pct
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;
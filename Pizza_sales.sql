-- Created a new database --
CREATE DATABASE capstone;

-- Table Overview --
SELECT * FROM pizza_sales;

-- To change the data Type of order_date & order_time --
ALTER TABLE pizza_sales MODIFY order_date DATE;
ALTER TABLE pizza_sales MODIFY order_time TIME;

-- To check the data types of the columns -- 
DESCRIBE pizza_sales;

-- To check the number of rows present in the table --
SELECT count(*)  FROM pizza_sales;



-- A. KPI's Reqiurement --
-- 1. Total Revenue --
SELECT round(sum(total_price),2) AS Total_Revenue FROM pizza_sales;

-- 2. Average Order value -- 
SELECT round(sum(total_price) / count(DISTINCT order_id),2) AS Avg_Order_value FROM pizza_sales;

-- 3. Total Pizza Sold -- 
SELECT sum(quantity) AS Total_Pizza_solds FROM pizza_sales;

-- 4. Total Orders --
SELECT count(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- 5. Average Pizza Per Order -- 
SELECT round(sum(quantity) / count(DISTINCT order_id),2) AS Avg_Pizza_Per_order FROM pizza_sales;

-- B. Daily Trend for Total Orders --
SELECT DAYNAME(order_date) AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- C. Monthly Trend for Orders --
SELECT monthname(order_date) AS month_name, count(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY monthname(order_date)
ORDER BY Total_orders DESC;

-- D. % of Sales by Pizza Category --
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- E. % of Sales by Pizza Size --
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- F. Total Pizzas Sold by Pizza Category -- 
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- G. Top 5 Pizzas by Revenue --
SELECT  pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
limit 5;

-- H. Bottom 5 Pizzas by Revenue --
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- I. Top 5 Pizzas by Quantity --
SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- J. Bottom 5 Pizzas by Quantity -- 
SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold asc
LIMIT 5;

-- K. Top 5 Pizzas by Total Orders --
SELECT  pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

-- L. Bottom 5 Pizzas by Total Orders --
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5; 
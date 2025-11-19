
/* _______________________________________________ 

   Retail Sales Analysis Project
   Purpose: Explore and analyze retail sales data
   Dataset: retail_sales
   _______________________________________________ */


/* --------------------------------------------------------
   1. DATABASE & TABLE CREATION
   -------------------------------------------------------- */
DROP DATABASE IF EXISTS sales_analysis;
CREATE DATABASE sales_analysis;
USE sales_analysis;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    unique_id INT PRIMARY KEY,
    order_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    total_sale DECIMAL(10,2),
    order_date DATE,
    order_status VARCHAR(50),
    product_category VARCHAR(100),
    cost_price DECIMAL(10,2),
    contact_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    last_name VARCHAR(100),
    first_name VARCHAR(100),
    order_size VARCHAR(20)
);

 -- Let's check our columns
DESCRIBE retail_sales;

 -- Here I imported a Dataset into the above table through Table Data Import Wizard.
 -- Checking if the imported correctly or not?
SELECT * FROM retail_sales
LIMIT 20;
	
/* -------------------------------------------------------
   2. DATA CLEANING
   ------------------------------------------------------- */
 -- i) Check for missing values
SELECT * FROM retail_sales
WHERE
    order_id IS NULL OR
    quantity IS NULL OR
    unit_price IS NULL OR
    total_sale IS NULL OR
    order_date IS NULL OR
    order_status IS NULL OR
    product_category IS NULL OR
    cost_price IS NULL OR
    contact_number IS NULL OR
    address IS NULL OR
    city IS NULL OR
    country IS NULL OR
    last_name IS NULL OR
    first_name IS NULL OR
    order_size IS NULL;

 -- ii) DELETE rows with missing values if they are not important.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM retail_sales
WHERE
    order_id IS NULL OR
    quantity IS NULL OR
    unit_price IS NULL OR
    total_sale IS NULL OR
    order_date IS NULL OR
    order_status IS NULL OR
    product_category IS NULL OR
    cost_price IS NULL OR
    contact_number IS NULL OR
    address IS NULL OR
    city IS NULL OR
    country IS NULL OR
    last_name IS NULL OR
    first_name IS NULL OR
    order_size IS NULL;
    
 -- iii) Check for duplicates based on order_id
SELECT order_id, 
	COUNT(*) AS duplicate_count
from retail_sales
GROUP BY order_id
HAVING count(*) > 1;
 -- Here the order_id has duplicates but these are not true duplicates, order_id is multi-item order.ALTER
    --  so we would look after other data inside these rows.

 -- Let us find true duplicates through a window function. 
SELECT *
FROM ( SELECT  *,
	ROW_NUMBER() OVER (
	PARTITION BY order_id, quantity, unit_price, total_sale,
		order_date, order_status, product_category,
		cost_price, contact_number, address, city,
		country, last_name, first_name, order_size
	ORDER BY unique_id) AS row_num
  FROM retail_sales
) AS temp
WHERE row_num > 1;

 -- iv) Now let's delete the above true duplicates through a window function.
DELETE FROM retail_sales
WHERE unique_id IN (
  SELECT unique_id
  FROM ( SELECT unique_id,
	ROW_NUMBER() OVER (
	PARTITION BY order_id, quantity, unit_price, total_sale,
			order_date, order_status, product_category,
			cost_price, contact_number, address, city,
			country, last_name, first_name, order_size
	ORDER BY unique_id
	) AS row_num FROM retail_sales
  ) AS duplicates
  WHERE row_num > 1);

SELECT * from retail_sales 
LIMIT 20;

/* -------------------------------------------------------
   3. DATA STANDARDIZATION
   ------------------------------------------------------- */
 -- i) Phone Number Cleaning and Standardization (removing dots, spaces, symbols).
UPDATE retail_sales
SET contact_number = REGEXP_REPLACE(contact_number, '[^0-9]', '')
WHERE contact_number REGEXP '[^0-9]';

 -- ii) Let's remove extra spaces and spacial characters from addresses.
  UPDATE retail_sales
SET address = TRIM(
    REGEXP_REPLACE(address, '[^a-zA-Z0-9\s\.,-]+', ' ')
);

/* -------------------------------------------------------
   4. DATA EXPLORATION & UNDERSTANDING (EDA)
   ------------------------------------------------------- */
 -- i) Summary stats (Minimum, maximum, average, total sales etc.)
SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT country) AS total_countries,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(AVG(total_sale), 2) AS avg_sale,
    MIN(total_sale) AS min_sale,
    MAX(total_sale) AS max_sale,
    SUM(total_sale) AS total_revenue
FROM retail_sales;

 -- ii) Top countries by number of orders
 SELECT 
    country, COUNT(*) AS total_orders
	FROM retail_sales
	GROUP BY country
	ORDER BY total_orders DESC;

 -- iii) Total sales by country
 SELECT country, SUM(total_sale) AS total_revenue
 FROM retail_sales
 GROUP BY country
 ORDER BY total_revenue DESC;

 -- iv) Top product categories by sales
 SELECT product_category, ROUND(SUM(total_sale), 2) AS total_revenue,
 COUNT(*) AS total_orders
 FROM retail_sales
 GROUP BY product_category
 ORDER BY total_revenue DESC;
 
 -- v) Monthly sales trend
 SELECT 
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    ROUND(SUM(total_sale), 2) AS monthly_revenue
FROM retail_sales
GROUP BY year, month
ORDER BY year, MONTH(MIN(order_date));

 -- vi) Order status distribution
 SELECT order_status,
 COUNT(*) AS total_orders
 FROM retail_sales
 GROUP BY order_status
 ORDER BY total_orders DESC;
 
 -- vii) Average order size by category
 SELECT product_category, order_size,
 COUNT(*) as total_orders
 FROM retail_sales
 GROUP BY product_category, order_size
 ORDER BY order_size, total_orders;
 
 -- viii) Profit analysis by category
 SELECT 
    product_category,
    ROUND(SUM(cost_price * quantity), 2) AS total_cost,
    ROUND(SUM(total_sale), 2) AS total_revenue,
    ROUND(SUM(total_sale) - SUM(cost_price * quantity), 2) AS total_profit,
    ROUND(AVG(total_sale - (cost_price * quantity)), 2) AS avg_profit_per_item
	FROM retail_sales
GROUP BY product_category
ORDER BY total_profit DESC;

 -- ix) Top 10 customers by total spending
 SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    ROUND(SUM(total_sale), 2) AS total_spent
	FROM retail_sales
GROUP BY first_name, last_name
ORDER BY total_spent DESC
LIMIT 10;

 -- x) Overall revenue, cost & profit margin summary
SELECT 
    ROUND(SUM(unit_price), 2) AS total_unit_price,
    ROUND(SUM(cost_price), 2) AS total_cost_price,
    ROUND(SUM(unit_price) - SUM(cost_price), 2) AS total_profit_margin,
    ROUND((SUM(unit_price) - SUM(cost_price)) / SUM(unit_price) * 100, 2) AS profit_margin_percent
FROM retail_sales;


/* -------------------------------------------------------
   5. BUSINESS KEY PROBLEMS & ANSWERS (Q&A)
   -------------------------------------------------------

Q1. Which country orders the most stuff?
Answer: USA has the most orders.

Q2. Which country makes the most money for us?
Answer: USA brings the highest total sales.

Q3. Which product categories sell the most?
Answer: Classic Cars, Motorcycles, and Trucks & Buses sell the most.

Q4. How do sales change month by month?
Answer: Sales go up in summer (June–Aug) and peak in December.

Q5. Which order status happens the most?
Answer: Most orders are “Shipped”, then “Pending” and “Cancelled”.

Q6. What’s the average order size per product category?
Answer: Motorcycles have the biggest average order size, then Classic Cars.

Q7. Which product categories make the most profit?
Answer: Classic Cars and Motorcycles make the most, Ships and Trains make the least.

Q8. Who are the top customers who spend the most?
Answer: Diego Freyre, Valarie Nelson, Peter Ferguson and some others spend the most money.

Q9. What’s the company’s overall profit margin?
Answer: Around 7.38% (20939.94) is overall profit margin.

Q10. Are there any categories where cost is more than revenue?
Answer: No, all categories have cost lower than unit price, so everything is profitable.
*/
                 
-- THE END ❤❤❤
# Retail Sales Analysis (SQL Project)
## Project Overview
This project highlights essential SQL techniques used in real retail analysis, from cleaning and organizing data to exploring trends and answering business-focused questions. It walks through the process of setting up a retail sales dataset and applying SQL to uncover meaningful insights. It’s a practical starter project for developing strong, job-ready SQL skills.

**Project Title:** Retail Sales Analysis  
**Level:** Beginner to Intermediate  
**Database:** sales_analysis  

## Project Objectives
- **Build a retail sales database** that organizes sales, products, and customer information efficiently.
- **Clean and preprocess the data** to make it accurate and ready for analysis.
- **Perform exploratory data analysis (EDA)** to identify trends, patterns, and anomalies in retail sales.
- **Write SQL queries to answer business questions**, such as top-selling products, store performance, and customer behavior.

## Project Structure
- `dataset/` - Contains the retail sales datasets:
  - `retail_sales_raw.csv` - Original raw dataset.
  - `retail_sales_clean.csv` - Cleaned and preprocessed dataset.
- `retail_sales_analysis_queries.sql` - SQL queries used for analysis and answering business questions.
- `README.md` - This file, containing project details.


## Dataset Description
- Retail sales data including sales, products, and customer information.
- Format: CSV / SQL tables
- Rows: ~3000, Columns: 17

## Business Questions & Insights
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

## Tools & Technologies
- MySQL
- SQL Workbench / VS Code
- Optional: Excel or visualization tools

## How to Run
1. Load the SQL files in your MySQL environment.
2. Execute queries in the order documented in `sql_scripts/`.
3. Check `reports/` folder for outputs and results.

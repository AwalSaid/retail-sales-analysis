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
## Project Structure
- [dataset/](dataset/) - Contains the retail sales datasets:
  - [retail_sales_raw.csv](dataset/retail_sales_raw.csv)  Original raw dataset.
  - [retail_sales_clean.csv](dataset/retail_sales_clean.csv)  Cleaned and preprocessed dataset.
- [retail_sales_analysis_queries.sql](retail_sales_analysis_queries.sql)  SQL queries used for analysis.
- [README.md](README.md) Detailed project documentation and instructions.



## Dataset Description
- Retail sales data including sales, products, and customer information.
- Format: CSV / SQL tables
- Rows: ~3000, Columns: 17

## Business Questions & Insights

1. **Which country orders the most products?**  
   **Answer:** USA has the highest number of orders.

2. **Which country generates the most revenue?**  
   **Answer:** USA contributes the highest total sales.

3. **Which product categories sell the most?**  
   **Answer:** Classic Cars, Motorcycles, and Trucks & Buses are the top-selling categories.

4. **How do sales change month by month?**  
   **Answer:** Sales increase in summer (June–August) and peak in December.

5. **Which order status occurs most frequently?**  
   **Answer:** Most orders are “Shipped”, followed by “Pending” and “Cancelled”.

6. **What is the average order size per product category?**  
   **Answer:** Motorcycles have the largest average order size, followed by Classic Cars.

7. **Which product categories are most profitable?**  
   **Answer:** Classic Cars and Motorcycles generate the highest profit; Ships and Trains generate the least.

8. **Who are the top customers by spending?**  
   **Answer:** Diego Freyre, Valarie Nelson, Peter Ferguson, and a few others are the top spenders.

9. **What is the company’s overall profit margin?**  
   **Answer:** Approximately 7.38% (total profit: 20,939.94).

10. **Are there any categories where cost exceeds revenue?**  
    **Answer:** No, all categories are profitable with cost lower than the unit price.


## Tools & Technologies
- MySQL
- SQL Workbench / VS Code
- Optional: Excel or visualization tools

## How to Run
1. Load the SQL files in your MySQL environment.
2. Execute queries in the order documented in `sql_scripts/`.
3. Check `reports/` folder for outputs and results.

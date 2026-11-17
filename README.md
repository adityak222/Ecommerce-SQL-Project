# E-commerce Customer Behaviour & Revenue Analysis

## Project Overview

This project analyses an e-commerce business using MySQL to understand sales performance, customer purchasing behaviour, product performance, and revenue trends.

The objective is to extract meaningful business insights from transactional data using SQL queries.

## Tools & Technologies

- MySQL 8.4
- Visual Studio Code
- SQLTools Extension

## Database Structure

The project contains four tables:

1. **Customers** – Customer details and locations.
2. **Products** – Product names, categories, and prices.
3. **Orders** – Customer orders and order dates.
4. **Order_Details** – Products purchased and quantities.

## SQL Concepts Used

- SELECT and WHERE
- INNER JOIN and LEFT JOIN
- GROUP BY and ORDER BY
- Aggregate Functions (SUM, COUNT, AVG)
- HAVING
- Subqueries
- DISTINCT
- Window Functions (RANK and PARTITION BY)
- Date Functions

## Business Analysis

The project covers 20 SQL analyses, including:

- Total revenue calculation
- Product-wise revenue
- Category-wise revenue
- Top-selling products
- Customer-wise spending
- Repeat customer analysis
- Monthly revenue trends
- Average order value
- Customers without orders
- Customer purchase frequency
- City-wise revenue
- Category revenue contribution
- Monthly order volume
- Average spending per customer
- Best-selling product by category
- Repeat purchase rate
- Overall business performance

## Key Business Insights

- Total revenue: ₹156,500
- Total orders: 8
- Unique purchasing customers: 6
- Average order value: ₹19,562.50
- Highest revenue-generating category: Electronics
- Highest revenue-generating city: Delhi
- Repeat purchase rate: 33.33%

## Project Folder Structure

```text
Ecommerce-SQL-Project/
│
├── 01_Database_Setup/
│   └── 01_create_database.sql
│
├── 02_Analysis_Queries/
│   └── 01_revenue_analysis.sql
│
├── 03_Business_Insights/
│   └── business_insights.md
│
└── README.md
```

## Conclusion

This project demonstrates the use of SQL to analyse e-commerce data and answer practical business questions.

It showcases database creation, data analysis, joins, aggregations, subqueries, and window functions to generate actionable business insights.

*Note: This project uses a sample dataset created for SQL learning and portfolio demonstration*
-- PROJECT: E-commerce Customer Behaviour & Revenue Analysis
-- ANALYSIS 1: Total Revenue
-- BUSINESS QUESTION: How much revenue has the business generated?

SELECT SUM(price * quantity) AS total_revenue
FROM Products
JOIN Order_Details
    ON Products.product_id = Order_Details.product_id;

--ANALYSIS 2: Product-wise Revenue

SELECT
    product_name,
    SUM(price * quantity) AS product_revenue
FROM Products
JOIN Order_Details
    USING (product_id)
GROUP BY product_id;

-- Analysis 3: Category-wise Revenue
-- Business Question: Which category generates the highest

SELECT
    p.category,
    SUM(p.price * o.quantity) AS category_revenue
FROM Products p
JOIN Order_Details o
    ON p.product_id = o.product_id
GROUP BY p.category;

-- ANALYSIS 4: Top-selling Products

SELECT
    p.product_name,
    SUM(o.quantity) AS total_qty_sold
FROM Products p
JOIN Order_Details o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_qty_sold DESC;

-- ANALYSIS 5: Customer-wise Spending

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_purchase
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Products p
    ON p.product_id = od.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;

-- ANALYSIS 6: Repeat Customer Analysis
-- BUSINESS QUESTION:
-- Which customers have placed more than one order?

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;

-- ANALYSIS 7: Monthly Revenue Trends
-- BUSINESS QUESTION: How does revenue change month by month?

SELECT
    MONTHNAME(o.order_date) AS month,
    SUM(p.price * od.quantity) AS revenue
FROM Orders o
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Products p
    ON p.product_id = od.product_id
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY MONTH(o.order_date);

-- ANALYSIS 8: Average Order Value
-- BUSINESS QUESTION: What is the average revenue generated per order?

SELECT
    AVG(total_sale) AS avg_order_value
FROM (
    SELECT
        o.order_id,
        SUM(p.price * od.quantity) AS total_sale
    FROM Orders o
    JOIN Order_Details od
        ON o.order_id = od.order_id
    JOIN Products p
        ON p.product_id = od.product_id
    GROUP BY o.order_id
) AS order_totals;

-- ANALYSIS 9: Customers Without Orders
-- BUSINESS QUESTION:
-- Which registered customers have never placed an order?

SELECT customer_name, city
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- ANALYSIS 10: Customer Order Count
-- BUSINESS QUESTION:
-- How many orders has each customer placed?

SELECT customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
    ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.customer_name
ORDER BY COUNT(o.order_id) DESC
LIMIT 1 OFFSET 0;

-- ANALYSIS 11: Repeat Customer Identification
-- BUSINESS QUESTION:
-- Which customers have placed at least 2 orders?

SELECT customer_name
FROM Customers c
JOIN Orders o
    ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.customer_name
HAVING COUNT(order_id) > 1;

-- ANALYSIS 12: Unique Customer Count
-- BUSINESS QUESTION:
-- How many unique customers have placed at least one order?

SELECT COUNT(DISTINCT o.customer_id) AS unique_customers
FROM Customers c
JOIN Orders o
    ON o.customer_id = c.customer_id;

-- ANALYSIS 13: Customer Purchase Frequency
-- BUSINESS QUESTION:
-- How many orders has each registered customer placed?

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

-- ANALYSIS 14: City-Wise Revenue Analysis
-- BUSINESS QUESTION:
-- Which cities generate the highest revenue?

SELECT
    c.city,
    SUM(p.price * od.quantity) AS revenue
FROM Customers c
JOIN Orders o
    ON o.customer_id = c.customer_id
JOIN Order_Details od
    ON od.order_id = o.order_id
JOIN Products p
    ON p.product_id = od.product_id
GROUP BY c.city
ORDER BY revenue DESC;

-- ANALYSIS 15: Category-Wise Revenue Contribution
-- BUSINESS QUESTION:
-- What percentage of total revenue does each product category contribute?

SELECT
    category,
    category_revenue,
    (category_revenue * 100 / total_revenue) AS revenue_percentage
FROM (
    SELECT
        category,
        SUM(price * quantity) AS category_revenue,
        SUM(SUM(price * quantity)) OVER () AS total_revenue
    FROM Order_Details od
    JOIN Products p
        ON p.product_id = od.product_id
    GROUP BY category
) AS category_summary
ORDER BY revenue_percentage DESC;

-- ANALYSIS 16: Monthly Order Volume
-- BUSINESS QUESTION:
-- How many orders were placed in each month?

SELECT
    MONTHNAME(order_date) AS month_name,
    COUNT(order_id) AS no_orders
FROM Orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- ANALYSIS 17: Average Spending per Customer
-- BUSINESS QUESTION:
-- What is the average revenue generated per customer?
-- ANALYSIS 17: Average Spending per Customer

SELECT
    SUM(p.price * od.quantity) /
    COUNT(DISTINCT o.customer_id) AS avg_revenue_per_customer
FROM Orders o
JOIN Order_Details od
    ON od.order_id = o.order_id
JOIN Products p
    ON p.product_id = od.product_id;

-- ANALYSIS 18: Best-Selling Product by Category
-- BUSINESS QUESTION:
-- Which product has the highest quantity sold in each category?

SELECT
    category,
    product_name,
    qty
FROM (
    SELECT
        p.category,
        p.product_name,
        SUM(od.quantity) AS qty,
        RANK() OVER (
            PARTITION BY p.category
            ORDER BY SUM(od.quantity) DESC
        ) AS product_rank
    FROM Products p
    JOIN Order_Details od
        ON p.product_id = od.product_id
    GROUP BY p.category, p.product_id, p.product_name
) AS ranked_products
WHERE product_rank = 1
ORDER BY category;

-- ANALYSIS 19: Customer Repeat Purchase Rate
-- BUSINESS QUESTION:
-- What percentage of purchasing customers have placed more than one order?

SELECT
    (customer_with_morethan1_orders * 100.0) / total_customers
    AS repeat_purchase_rate
FROM
(
    SELECT COUNT(*) AS customer_with_morethan1_orders
    FROM Orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS repeat_customers,
(
    SELECT COUNT(DISTINCT customer_id) AS total_customers
    FROM Orders
) AS all_customers;

-- ANALYSIS 20: Overall Business Performance
-- BUSINESS QUESTION:
-- What are the key performance indicators of the e-commerce business?

SELECT
    SUM(p.price * od.quantity) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM Orders o
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Products p
    ON p.product_id = od.product_id;
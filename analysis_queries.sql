-- Indian E-commerce Sales Analysis
-- Compatible with SQLite. Import data/ecommerce_sales.csv as ecommerce_sales.

-- Optional table definition
CREATE TABLE IF NOT EXISTS ecommerce_sales (
  Order_ID TEXT PRIMARY KEY, Order_Date DATE, Customer_ID TEXT, Region TEXT, State TEXT, City TEXT,
  Category TEXT, Product TEXT, Channel TEXT, Quantity INTEGER, Unit_Price_INR REAL, Discount_Pct INTEGER,
  Sales_INR REAL, Cost_INR REAL, Profit_INR REAL, Payment_Method TEXT, Delivery_Days INTEGER, Returned TEXT, Rating INTEGER
);

-- 1. Headline KPIs
SELECT COUNT(DISTINCT Order_ID) AS total_orders, ROUND(SUM(Sales_INR),2) AS total_sales,
       ROUND(SUM(Profit_INR),2) AS total_profit,
       ROUND(100.0*SUM(Profit_INR)/SUM(Sales_INR),2) AS profit_margin_pct,
       ROUND(AVG(Sales_INR),2) AS average_order_value
FROM ecommerce_sales;

-- 2. Monthly sales and month-over-month growth
WITH monthly AS (
 SELECT SUBSTR(Order_Date,1,7) AS month, SUM(Sales_INR) AS sales
 FROM ecommerce_sales GROUP BY SUBSTR(Order_Date,1,7)
), lagged AS (
 SELECT month, sales, LAG(sales) OVER (ORDER BY month) AS previous_sales FROM monthly
)
SELECT month, ROUND(sales,2) AS sales,
 ROUND(100.0*(sales-previous_sales)/previous_sales,2) AS mom_growth_pct
FROM lagged ORDER BY month;

-- 3. Category performance
SELECT Category, COUNT(*) AS orders, ROUND(SUM(Sales_INR),2) AS sales,
 ROUND(SUM(Profit_INR),2) AS profit, ROUND(100.0*SUM(Profit_INR)/SUM(Sales_INR),2) AS margin_pct
FROM ecommerce_sales GROUP BY Category ORDER BY sales DESC;

-- 4. Regional performance
SELECT Region, COUNT(*) AS orders, ROUND(SUM(Sales_INR),2) AS sales, ROUND(SUM(Profit_INR),2) AS profit
FROM ecommerce_sales GROUP BY Region ORDER BY sales DESC;

-- 5. Return rate by category
SELECT Category, COUNT(*) AS orders, SUM(CASE WHEN Returned='Yes' THEN 1 ELSE 0 END) AS returns,
 ROUND(100.0*SUM(CASE WHEN Returned='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS return_rate_pct
FROM ecommerce_sales GROUP BY Category ORDER BY return_rate_pct DESC;

-- 6. Delivery speed and returns
SELECT CASE WHEN Delivery_Days >= 7 THEN '7+ days' ELSE 'Under 7 days' END AS delivery_group,
 COUNT(*) AS orders, ROUND(AVG(Rating),2) AS avg_rating,
 ROUND(100.0*SUM(CASE WHEN Returned='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS return_rate_pct
FROM ecommerce_sales GROUP BY delivery_group;

-- 7. Top 10 products
SELECT Product, Category, ROUND(SUM(Sales_INR),2) AS sales, ROUND(SUM(Profit_INR),2) AS profit
FROM ecommerce_sales GROUP BY Product, Category ORDER BY sales DESC LIMIT 10;

-- 8. Channel analysis
SELECT Channel, COUNT(*) AS orders, ROUND(SUM(Sales_INR),2) AS sales,
 ROUND(AVG(Sales_INR),2) AS avg_order_value
FROM ecommerce_sales GROUP BY Channel ORDER BY sales DESC;

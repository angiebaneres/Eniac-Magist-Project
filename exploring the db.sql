USE magist;

SELECT
*
FROM
orders;
# 1. How many orders are there in the dataset? 
SELECT COUNT(*) AS total_orders
FROM
orders;
select count(distinct order_id) from order_items;

# 2. Are orders actually delivered?
SELECT
order_status,
COUNT(*) AS orders
FROM
orders
GROUP BY order_status;

# 3. Is Magist having user growth? 

SELECT
YEAR(order_purchase_timestamp) AS year_,
MONTH (order_purchase_timestamp) AS month_,
COUNT(customer_id)
FROM
orders
GROUP BY year_, month_
ORDER BY year_, month_;

# 4. How many products are there on the products table? 
SELECT COUNT(*) AS total_products
FROM
products;-- 

# 5. Which are the categories with the most products?
SELECT
product_category_name,
COUNT(distinct product_id) AS n_products
FROM
products
group by product_category_name
ORDER BY COUNT(product_id) DESC;

# 6. How many of those products were present in actual transactions?
SELECT 
count(distinct product_id) AS n_products
FROM
order_items;

# 7. What’s the price for the most expensive and cheapest products? 
SELECT 
MIN(price) AS cheapest,
MAX(price) AS most_expensive
FROM
order_items;

# 8. What are the highest and lowest payment values?
SELECT 
MAX(payment_value) as highest,
MIN(payment_value) as lowest
from
order_payments;

SELECT
SUM(payment_value) AS highest_order
FROM
order_payments
GROUP BY 
order_id
ORDER BY
highest_order DESC
LIMIT
1;





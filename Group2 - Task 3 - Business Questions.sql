-- select * from products -- 32951 entries
-- select distinct product_category_name from products -- 74 entries
-- select * from order_items -- 112650

-- select * from product_category_name_translation -- 74 
-- select distinct product_category_name from products -- 74 entries

-- 3.1. In relation to the products:
-- What categories of tech products does Magist have?
-- select * from product_category_name_translation
-- audio, cds_dvds_musicals, cine_photo, consoles_games, dvds_blu_ray, electronics, computers_accessories, pc_gamer, computers, tablets_printing_image, telephony,  fixed_telephony

-- How many products of these tech categories have been sold (within the time window of the database snapshot)? 
-- select * from order_items -- 12650
/*
select * from order_items as o 
left join products as p 
on o.product_id = p.product_id
left join product_category_name_translation as e
on p.product_category_name = e.product_category_name
where product_category_name_english in ("audio", "cds_dvds_musicals", "cine_photo", "consoles_games", "dvds_blu_ray", "electronics", "computers_accessories", "pc_gamer", "computers", "tablets_printing_image", "telephony", "fixed_telephony")
*/
-- What percentage does that represent from the overall number of products sold?
/*
WITH filtered_orders AS (
  SELECT DISTINCT order_id
  FROM order_items AS o
  LEFT JOIN products AS p ON o.product_id = p.product_id
  LEFT JOIN product_category_name_translation AS e ON p.product_category_name = e.product_category_name
  WHERE e.product_category_name_english IN ("audio", "cds_dvds_musicals", "cine_photo", "consoles_games", "dvds_blu_ray", "electronics", "computers_accessories", "pc_gamer", "computers", "tablets_printing_image", "telephony", "fixed_telephony")
),
total_orders AS (
  SELECT COUNT(DISTINCT order_id) AS num_of_orders
  FROM orders
)
SELECT f.*, ROUND((COUNT(*) / (SELECT num_of_orders FROM total_orders)) * 100, 2) AS percentage
FROM filtered_orders AS f
LEFT JOIN total_orders AS t ON TRUE
GROUP BY f.order_id, t.num_of_orders
ORDER BY percentage DESC;
*/

-- THIS RETURNS "15,5..."
WITH filtered_orders AS (
  SELECT DISTINCT order_id
  FROM order_items AS o
  LEFT JOIN products AS p ON o.product_id = p.product_id
  LEFT JOIN product_category_name_translation AS e ON p.product_category_name = e.product_category_name
  WHERE e.product_category_name_english IN ("audio", "cds_dvds_musicals", "cine_photo", "consoles_games", "dvds_blu_ray", "electronics", "computers_accessories", "pc_gamer", "computers", "tablets_printing_image", "telephony", "fixed_telephony")
),
total_orders AS (
    SELECT COUNT(DISTINCT order_id) AS num_of_orders
  FROM orders
),
aggregate_data AS (
  SELECT CAST(COUNT(*) OVER () AS float)/(SELECT num_of_orders FROM total_orders) * 100 AS percentage
  FROM filtered_orders
)
SELECT MIN(percentage) AS percentage
FROM aggregate_data;

-- What’s the average price of the products being sold?

-- Are expensive tech products popular? * TIP: Look at the function CASE WHEN to accomplish this task.

-- 3.2. In relation to the sellers:
-- How many months of data are included in the magist database?
-- How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
-- What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
-- Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?

-- 3.3. In relation to the delivery time:
-- What’s the average time between the order being placed and the product being delivered?
-- How many orders are delivered on time vs orders delivered with a delay?
-- Is there any pattern for delayed orders, e.g. big products being delayed more often?

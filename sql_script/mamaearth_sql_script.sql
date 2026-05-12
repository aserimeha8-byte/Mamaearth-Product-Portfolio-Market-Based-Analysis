-- ==========================================================
-- Project: MAMAEARTH Products Analysis using SQL
-- Author: MEHA ASERI
-- Tools Used: SQL
-- Dataset: MAMAEARTH Dummy Dataset (KAGGLE)
--
-- Objective:
-- To analyze product pricing, discount strategies, and
-- customer ratings across different categories in order
-- to uncover insights about product performance,
-- promotional strategies, and consumer preferences.

-- BEFORE ANALYSING THE DATASET USING SQL, CLEANING WAS NECESSARY AND WAS COMPLETED BY EXCEL.
-- ==========================================================
# maven_advanced_sql is already built as database in workbench so this will be used as database for this project.
USE  maven_advanced_sql;
# Right now table is not present in database. The next step will be of creating table named mamaearth.
# Creation of table schema in database namely maven_advanced_sql
create table if not exists mamaearth(
    product_name VARCHAR(255),
    rating varchar(30),
    mrp FLOAT,
    quantity int,
    unit VARCHAR(50),
    type VARCHAR(50),
    discount FLOAT,
    category VARCHAR(255),
    key_ingredients VARCHAR(255)
);
# Cleaned CSV was imported using Table Data Import Wizard option that can seamlessly upload csv file in sql workbench.
# Table Data Import Wizard option can be used by right clicking database in SCHEMAS and choosing this option.
SELECT *
FROM mamaearth;
SELECT COUNT(*) 
FROM mamaearth;
DESCRIBE mamaearth;
# Getting to know the dataset

# Finding out: how many unique products are present in the mamaearth brand?
SELECT DISTINCT product_name 
FROM mamaearth;
SELECT COUNT(DISTINCT product_name) 
FROM mamaearth;

# Finding out: How many distinct categories exist?
SELECT 
COUNT(DISTINCT category) 
FROM mamaearth
WHERE category <> "Unknown "; 

# Finding out: What is the distribution of products across categories?
SELECT category,
COUNT(DISTINCT product_name) as product_count 
FROM mamaearth
WHERE category <> "Unknown "
GROUP BY category
ORDER BY product_count DESC;

# Rating Analysis
# Finding out: What percentage of products have missing ratings?
SELECT ROUND(COUNT(product_name) * 100.0 /
 (SELECT COUNT(product_name) 
 FROM mamaearth),1) AS percentage
FROM mamaearth 
WHERE rating is null ;

# Finding out: What is the overall average rating of products?
SELECT ROUND(AVG(rating),2) 
FROM mamaearth;

## Dataset contains 165 products across 14 categories where face wash and hair shampoo takes lead, with an overall 
## average rating 4.95 and 42.4% products have missing rating.

# Product Category Analysis
# Finding out: Which categories contain the most products? 
SELECT category,
COUNT( DISTINCT product_name) AS pr_cnt
FROM mamaearth
WHERE category <> "Unknown " 
GROUP BY  category
ORDER BY pr_cnt DESC
LIMIT 1; 

# Finding out: Which categories have the highest average rating?
WITH cte AS(SELECT DISTINCT category,
ROUND(AVG(rating),2) AS avg_rating
FROM mamaearth
GROUP BY category)
SELECT category,
avg_rating
FROM cte
WHERE avg_rating = (SELECT MAX(avg_rating) FROM cte);

#Finding out: Which categories receive the largest discounts?
SELECT category
FROM mamaearth
WHERE discount = (SELECT MAX(discount) FROM mamaearth)
GROUP BY category;

#Finding out: Which categories contain the most premium products (high MRP)?
SELECT category
FROM mamaearth 
WHERE mrp = (SELECT MAX(mrp) FROM mamaearth);

#Finding out: Which categories have the lowest customer satisfaction?
WITH cte AS (SELECT category,
COUNT(category) AS cnt
FROM mamaearth 
WHERE rating IS NULL
GROUP BY category)
SELECT category,
cnt
FROM cte
WHERE cnt = (SELECT MAX(cnt) FROM cte);

# Pricing Analysis
# Finding out: What is the price distribution of products?
WITH cte AS (SELECT DISTINCT product_name,
mrp,
CASE WHEN mrp<250 THEN "0-250" 
WHEN mrp>=250 AND mrp<500 THEN "250-500"
WHEN mrp>=500 AND mrp<1000 THEN "500-1000"
WHEN mrp>=1000 THEN ">1000" 
END AS price
FROM mamaearth)
SELECT DISTINCT price,
COUNT(price) AS price_distribution
FROM cte 
GROUP BY price
ORDER BY price_distribution DESC ;

# Finding out: What is the average MRP per category?
SELECT category,
ROUND(AVG(mrp),2) AS avg_mrp
FROM mamaearth
GROUP BY category
ORDER BY avg_mrp DESC;

# Finding out: Which are the top 10 most expensive products?
SELECT product_name,
mrp
FROM mamaearth
WHERE
 mrp > (SELECT 
 AVG(mrp) + STDDEV(mrp)*2 
 FROM mamaearth)
ORDER BY mrp DESC
LIMIT 10;

# Finding out: Which categories dominate the low-price segment?
WITH cte AS (SELECT DISTINCT product_name,
category,
mrp,
CASE WHEN mrp<250 THEN "0-250" 
WHEN mrp>=250 AND mrp<500 THEN "250-500"
WHEN mrp>=500 AND mrp<1000 THEN "500-1000"
WHEN mrp>=1000 THEN ">1000" 
END AS price
FROM mamaearth) , 
cte2 AS (SELECT category, 
COUNT(category) AS cnt
FROM cte
WHERE price = "0-250" 
GROUP BY category)
SELECT category
FROM cte2
WHERE cnt = (SELECT MAX(cnt) FROM cte2);

#Finding out: What percentage of products fall into budget, mid-range, and premium tiers?
WITH cte AS (SELECT DISTINCT product_name,
CASE
WHEN mrp<500 THEN "Budget Tier" 
WHEN mrp>=500 AND mrp<1000 THEN "Mid-Range Tier"
WHEN mrp>=1000 THEN "Premium Tier"
END AS mrp_tiers
FROM mamaearth)
SELECT mrp_tiers,
ROUND(COUNT(product_name) * 100.0/ 
(SELECT 
COUNT(DISTINCT product_name) 
FROM mamaearth),2) AS percentage_products
FROM cte
GROUP BY mrp_tiers
ORDER BY mrp_tiers;

## Discount Analysis 
# Finding out: What is the average discount across products?
SELECT product_name,
ROUND(AVG((discount* 100.0)),2) as avg_discount
FROM mamaearth
GROUP BY product_name;

# Finding out: What is the number of discount and non-discount products?
SELECT 
CASE WHEN discount>0 THEN 'Discounted'
ELSE 'Non-Discounted' 
END AS discount_type,
COUNT(*) AS product_cnt
FROM mamaearth
GROUP BY discount_type;

# Finding out: Which categories receive the highest promotional discounts?
SELECT category,
ROUND(discount*100.0,2) as promotional_discount
FROM mamaearth
WHERE discount = (SELECT MAX(discount) FROM mamaearth)
LIMIT 1;

# Finding out: Do higher priced products receive higher discounts?
WITH cte AS (SELECT product_name,
discount,
CASE WHEN mrp<250 THEN "0-250" 
WHEN mrp>=250 AND mrp<500 THEN "250-500"
WHEN mrp>=500 AND mrp<1000 THEN "500-1000"
WHEN mrp>=1000 THEN ">1000" 
END AS price
FROM mamaearth)
SELECT 
    price,
    COUNT(*) AS product_count,
    ROUND(AVG(discount) * 100, 2) AS avg_discount,
    ROUND(MAX(discount * 100), 2) AS max_discount
FROM cte
GROUP BY price
ORDER BY price;

# Finding out: What proportion of products are sold without discounts?
SELECT CONCAT(ROUND(COUNT(product_name) *100.0 / 
(SELECT COUNT(product_name) 
FROM mamaearth),2),"%")
AS products_without_discount
FROM mamaearth 
WHERE discount = 0 ;

# Finding out: Which products combine high rating + high discount (best value)?
SELECT product_name,
ROUND(discount*100,2) AS discount,
rating
FROM mamaearth
WHERE
rating = (SELECT MAX(rating) 
FROM mamaearth) AND
discount = (SELECT MAX(discount) 
FROM mamaearth) ;

## Ingredient Analysis 
# Finding out: Which ingredients appear in top-rated products?
SELECT
DISTINCT key_ingredients, 
rating
FROM mamaearth
WHERE rating = 5 ;

#Finding out: What is price per gram/ml across products?
SELECT product_name,
CEIL(mrp/quantity) AS price_per_unit
FROM mamaearth
WHERE unit IS NOT NULL
AND quantity > 0
ORDER BY price_per_unit DESC;

#Which category offer best value for money?
WITH cte AS (SELECT product_name,
category,
unit,
CEIL(mrp/quantity) AS price_per_unit
FROM mamaearth
WHERE unit IS NOT NULL
AND quantity > 0 
ORDER BY price_per_unit)
SELECT
category,
COUNT(price_per_unit) AS price_per_unit
FROM cte
WHERE price_per_unit = 1
GROUP BY category
ORDER BY price_per_unit DESC
;

# Top Promotional Products
SELECT product_name,
discount,
rating
FROM mamaearth
WHERE (discount*100)>=20
AND rating >4
ORDER BY rating DESC;
# Category Market Share
SELECT 
category,
COUNT(*) AS product_count,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),2) AS market_share_percent
FROM mamaearth
where category <> 'Unknown '
GROUP BY category
ORDER BY product_count DESC;

# Correlation Analysis (PRICE & DISCOUNT)
SELECT 
ROUND(
( 
AVG(mrp * discount) - 
(AVG(mrp)*AVG(discount))
)
/
(
STDDEV(mrp) * STDDEV(discount)
),2)
AS discount_coefficient
FROM mamaearth
WHERE discount IS NOT NULL;
# A moderate positive correlation (0.65) was observed between product price and
# discount, suggesting that higher priced products are more likely to receive promotional discounts



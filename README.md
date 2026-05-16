# Mamaearth-Product-Portfolio-Market-Based-Analysis
<img width="3000" height="1250" alt="image" src="https://github.com/user-attachments/assets/ef7f3c5f-5625-45ad-9c68-45964dea6de3" />



## Exploratory Data Analysis Mamaearth's Product Analysis (Dummy Dataset from Kaggle) using SQL: Pricing Architecture, Category Dominance, and Consumer Sentiment Analysis

### 📊Project Overview: 
This project analyzes Mamaearth’s e-commerce containing **250+** entries footprint using Advanced SQL(**Joins, Window Functions, Subqueries, CTEs**). The goal was to solve a specific business challenge: Identifying the *Sweet Spot* in product pricing and category saturation to drive promotional growth. By querying a catalog of **160+** products across **10** categories, I mapped out the brand's product market positioning and identified untapped opportunities in their product mix.

### 🎯Business Objectives 
- 1.**Category Analysis**:Quantify SKU depth to identify "Hero" vs. "Under-leveraged" categories.
- 2.**Pricing Strategy**: Segment the portfolio into price buckets to understand the brand’s affordability index.
- 3.**Customer Sentiment**: Analyze rating distributions to find quality gaps and identify high-performing lines.
- 4.**Correlation Insights**: Statistically determine if premium-priced items correlate with higher customer satisfaction.
- 5.**Discount Analysis**: Evaluate the correlation between aggressive discounting and product ratings to measure promotional ROI.

### 📁 Project Structure/
```
mamaearth-sql-analysis/
│
├── data/
│   ├── mamaearth_raw.csv          # Raw data (Downloaded from KAGGLE and uploaded on EXCEL)
│   └── mamaearth_cleaned.csv      # Processed data (Data Cleaning via EXCEL before SQL ingestion)
│
├── sql_queries/
│   ├── 01_schema_setup.sql        # Database DDL & constraints
│   ├── 02_category_deepdive.sql   # SKU counts & category distribution
│   ├── 03_pricing_segments.sql    # CASE statements for market tiering
│   ├── 04_discount_segments.sql   # Ctes depicting discount analysis
│   └── 05_correlation_metrics.sql # Rating vs. Price correlation analysis
│
├── screenshots/                   # All 30 execution results showing queries & outputs
│
└── README.md                      # Business Case & Executive Summary
```
### 📝 Data Descrption:

#### The Kaggle dataset contains 260+ entries depicting 165 products in 10 categories. The following columns description:
1. **Product Name**: Product description of **165** products.
2. **Rating**: Column depicts rating provided by customer to the product which they bought. **NULL** values are present but they can have two meanings either rating is 0(NULL) or customer didn't provide any rating(NULL).
3. **MRP**: Price corresponding to products ranging from **149 to 1749**.
4. **Quantity**: Weight/Volumn ranging from **NULL to 400**. NULL means weight/volumn was not mentioned in the dataset.
5. **Unit**: Unit corresponds to quantity in gram or ml. NULL means weight/volumn was not mentioned in the dataset.
6. **Type**: Classification under weight/volumn or NULL
7. **Discount**: Discount provided to customers while they were buying certain products. Ranging from **0 to 28%**.
8. **Category**: Products are divided into **10** categories including Unknown.
9. **Key Ingredients**: Major ingredients that are present in making of the products.

### 🧹 Data Preprocessing Phase: 
#### Before Data Cleaning
<img width="1894" height="894" alt="image" src="https://github.com/user-attachments/assets/f008dbb0-621d-4de4-be3c-52333ab6cd6e" />

- **Handling Duplicates**: Removed redundant entries to ensure SKU counts and category metrics remained 100% accurate
- **Trim Whitespace**: Cleaned all categorical columns to prevent fragmentation during SQL GROUP BY operations.
- **Handling Missing Values**: Tagged incomplete categories as "Unknown" and isolated null ratings to avoid skewing mathematical averages.
- **Correcting Format**: Standardized MRP, Discount, and Rating into numeric formats and spellchecks for seamless compatibility with SQL math functions
- **Amending quantity**: Normalized inconsistent units (ml, g, packs) into a standardized scale for accurate price-per-unit comparisons.
#### After Data Cleaning
<img width="1902" height="704" alt="image" src="https://github.com/user-attachments/assets/ace582e6-ae29-4fdb-83a5-19ecc0295975" />

### 🤖 Prepping data in SQL:
- **Importing CSV**: Created the **mamaearth table** within the **maven_advanced_sql database**. Successfully migrated all **264** entries via the **Table Data Import Wizard** to establish a structured environment for querying.
<img width="1085" height="509" alt="Screenshot 2026-05-11 230517" src="https://github.com/user-attachments/assets/694a0637-02bb-46cf-b5d8-88477dd96249" />
<img width="1104" height="368" alt="Screenshot 2026-05-11 230532" src="https://github.com/user-attachments/assets/1e3fddd2-9d80-4e27-80e4-631eaa4ba08f" />

### **🔍 Project Deep-Dive: Key Queries & Analysis**:
- **Product & Category Analysis**:
```
BUSINESS QUESTION                           | SQL IMPLEMENTATION               | KEY INSIGHTS
How many unique products are there          | Select (Distinct)                | 165 unique products are there.
How many Distinct categories present        | Select COUNT(distinct)           | 10 different categories are present including unknown
Distribution of products across categories  | Select count(distinct) group by  | Facewash have major chunk and Body Wash have least number of products
```
- **Rating Analysis**:
```
BUSINESS QUESTION                     | SQL IMPLEMENTATION                          | KEY INSIGHTS
% of products have missing ratings?   | Select round(count()*100/subquery(count())  | 42.4% are missing & 57.6% present under 74.3% rated 5⭐           
Overall average rating of products?   | Select round(avg())                         | 4.95 is average rating of products.
```
- **Pricing Analysis**:
```
BUSINESS QUESTION                                           | SQL IMPLEMENTATION                              | KEY INSIGHTS
Price distribution of products?                             | With cte AS (case when then end)                | Rs500-Rs1000 have majority with 108 products
                                                              SELECT distinct() group by  
Average MRP per category?                                   | Select round(avg()) group by                    | Highest - Hair Kit(781.3) and lowest - Body lotion(424)
Top 10 most expensive products?                             | Select where subquery                           | Price distribution from 1749 to 1199
categories dominate the low-price segment?                  | With cte1 as (case when then end) cte2(count()  | Face wash dominates 0-250 segment
                                                              where group by select where subquery             
% of products fall into budget, mid-range, premium tiers?   | With cte as (case when then end) select         | Budget - 60.61%, Mid-range - 51.52%, 
                                                              select round(count()*100 / subquery                  Premium - 5.45%
                                                               group by order by                       
```
- **Category Analysis**:
```
BUSINESS QUESTION                                  | SQL IMPLEMENTATION                                      | KEY INSIGHTS
Categories contain the most products?              | Select count(distinct) where group by order by limit    | Face wash contains most products(34)
Categories have highest average rating?            | With cte as (select round(avg() group by)               | Body wash & body lotion  
                                                    select where subquery(max)        
Categories receive the largest discounts?          | Select where subquery(max) group by                     | Hair kit receive largest discount
Categories contain the most premium products?      | Select where subquery(max)                              | Unknown category have most premium products         
Categories have the lowest customer satisfaction?  | With cte as(select count() where group by)              | Facewash(20) have lowest customer satisfaction
                                                       select where subquery(max)                    
```
- **Discount Analysis**:
```
BUSINESS QUESTION                                    | SQL IMPLEMENTATION                            | KEY INSIGHTS
Average discount across products?                    | Select round(avg()) group by                  | Returns list of products with average discounts
Number of discount and non-discount products?        | Select (case when then else end)              | Non-discounted - 188 & Discounted - 76 
                                                          count() group by       
Categories receive highest promotional discounts?    | Select round() where subquery(max()) limit    | Hair kit(28%) 
Higher priced products = Higher discounts?           | With cte as(select (case when then end))      | Calculated product count, average discount & max discount   
                                                       select count() group by order by                     Yes, positive correlation is there.
% of Products sold without discounts?                | Select concat(round(count()                   | 71.21% product are sold without discount
                                                         /subquery (count()))) where
```
- **Ingredient Analysis**:
```
BUSINESS QUESTION                           | SQL IMPLEMENTATION                                | KEY INSIGHTS
Ingredients appear in top-rated products?   | Select distinct where                             | Turmeric, niacinamide and many more appears in top-rated products 
Price per gram/ml across products?          | Select ceil() where (is not null) order by desc   | Returns list of products mrp/quantity. Ranging from Rs340 to Rs1.
```
- **Best Value Analysis**:
```
* Best value = High rating + High Discount*
* Best value for Money = lowest price_per_unit (mrp/quantity)*
BUSINESS QUESTION                        | SQL IMPLEMENTATION                                     | KEY INSIGHTS
Products provides best value?            | Select round() where subquery1 (select Max())          | Vitamin C Body wash have highest discount(28%) & rating(5⭐)
                                            and subquery2 (select max())
Category offer best value for money?     | With cte as(select ceil() where(is not null)           | Body lotion offers best value for money
                                           order by) select count() where group by order by desc   
```
- **Top Promotional Products**: 
```
BUSINESS QUESTION                       | SQL IMPLEMENTATION                                    | KEY INSIGHTS
Products having minimum discount 20%    | Select where condition1 and condition2 order by desc  | Returns 17 prodcuts list for promotional content
and rating greater than 4⭐
```
- **Category Market Share**:
```
BUSINESS QUESTION            | SQL IMPLEMENTATION                           | KEY INSIGHTS
Categories market share ?    | Select round(100*count()/sum(count())        | Returns list with face wash(19.09%) highest market share and
                                 over()) where group by order by              body wash(5%) lowest market share
```
- **Correlation Analysis**:
```
*Price and discount*
BUSINESS QUESTION                 | SQL IMPLEMENTATION                          | KEY INSIGHTS
Determining relaionship between   | Select round(avg() - (avg()*avg()) /        | Moderate positive correlation (0.65) was observed between product price
price and discount                  Stddev()*Stddev() where(is not null)           & discount, suggesting that higher priced products are more likely                                                                                                             to receive promotional discounts                                             
```                 
### 🎯 Key Strategic Insights (The "So-What" Factor)
#### 💰 The Discount Lever: Strategic Scaling
- **Insight**: Data proves a $0.65$ correlation between price and discounts.
- **Takeaway**: Mamaearth doesn't discount for "affordability"—they discount for premium conversion. Budget items stay at full price to protect margins, while high-ticket items (Hair Kits) get up to 28% off to eliminate price as a barrier.
#### 📜 The Review Gap: The "Silent" Catalog
- **Insight**: 42.4% of products have zero customer ratings despite high inventory volume.
- **Takeaway**: The brand has a Social Proof Gap, not a quality problem. With an average rating of 4.95, the brand is sitting on "silent winners." Incentivizing reviews for these products is the fastest way to drive organic growth.
#### 🛒 Category Fatigue: The Face Wash Trap
- **Insight**: Face Wash is the market leader (19.09% share) but also shows the highest customer dissatisfaction.
- **Takeaway**: The category is over-saturated. Growth is stagnating here while Body Lotions are under-leveraged—boasting the highest "Value-for-Money" index and consistent 5-star ratings.
#### 🎖️ The Gateway Effect: The ₹250–₹500 Sweet Spot
- **Insight**: 60% of top-rated products sit in the Mid-Range tier.
- **Takeaway**: These are your "Acquisition Heroes." These products build trust with new customers and should be used as anchors in bundles to upsell higher-margin, premium items.

### 🚀 Strategic Recommendations: The "Blue Ocean" Move
#### Based on the Review Gap, Category Fatigue, and Discount Lever insights, here is how Mamaearth can leapfrog the competition:
##### The "Social Proof" Lottery (Fixing the 42% Review Gap)
- **The Move**: Launch a "Scan-to-Win" campaign exclusively for unrated products.
- **The Logic**: Since 42% of the catalog is "silent," Mamaearth should place high-value QR codes inside the packaging of only low-rated/unrated SKUs. Scanning the code and leaving a verified review enters the customer into a high-stakes lottery.
- **The Win**: This aggressively builds social proof for "invisible" products, turning them into "Hero" products overnight without spending a rupee on Instagram ads.

##### "Dynamic Pricing" Bundles (Leveraging the 0.65 Correlation)
- **The Move**: Implement an AOV (Average Order Value) Booster at checkout.
- **The Logic**: My analysis shows high-priced items (₹1000+) need deep discounts to move. Instead of a flat discount, offer a "Mystery Premium Add-on" for ₹499 when a customer buys a ₹250 Face Wash.
- **The Win**: You move the expensive inventory (Hair Kits) while keeping the customer's perceived value high, effectively clearing premium stock while protecting the "luxury" status of the brand.

##### Category Pivot: "Body Care as the New Face Care"
- **The Move**: Sunset the bottom 10% of underperforming Face Washes and launch "Clinical Body Serums."
- **The Logic**: The Face Wash market is saturated and satisfaction is dipping. However, Body Lotions have the highest "Value for Money" and satisfaction.
- **The Win**: By treating Body Care with the same "active ingredient" intensity as Face Care (Niacinamide/Vitamin C body serums), Mamaearth can own a new category before competitors like Wow or Plum catch up.

##### "Zero-Discount" Subscription Tiers
- **The Move**: Launch a "Mamaearth Prime" for the 71% of products sold without discounts.
- **The Logic**: 71% of customers already buy at full MRP. Instead of random sales, offer a subscription that provides "First Access" to new launches and "Free Samples" of the 42% unrated products.
- **The Win**: This creates recurring revenue and a "beta-testing" group that provides immediate ratings for every new SKU launched, ensuring no future product ever enters the "Review Gap."

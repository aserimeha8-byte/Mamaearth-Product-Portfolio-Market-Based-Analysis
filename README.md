# Mamaearth-Product-Portfolio-Market-Based-Analysis
<img width="3000" height="1250" alt="image" src="https://github.com/user-attachments/assets/ef7f3c5f-5625-45ad-9c68-45964dea6de3" />



## End-to-End SQL Project on Mamaearth brand Product Analysis (Dummy Dataset from Kaggle): Pricing Architecture, Category Dominance, and Consumer Sentiment Analysis

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
% of products fall into budget, mid-range, premium tiers?   | With cte as (case when the end) select          | Budget - 60.61%, Mid-range - 51.52%, 
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
BUSINESS QUESTION                                  | SQL IMPLEMENTATION                                      | KEY INSIGHTS
Categories contain the most products?              | Select count(distinct) where group by order by limit    | Face wash contains most products(34)
Categories have highest average rating?            | With cte as (select round(avg() group by)               | Body wash & body lotion  
                                                    select where subquery(max)        
Categories receive the largest discounts?          | Select where subquery(max) group by                     | Hair kit receive largest discount
Categories contain the most premium products?      | Select where subquery(max)                              | Unknown category have most premium products         
Products prvides best value?  | With cte as(select count() where group by)              | Facewash(20) have lowest customer satisfaction
                                                       select where subquery(max)                    
```

### 📈 Strategic Conclusion & Recommendations Deduction: 

Mamaearth has successfully democratized premium personal care. My analysis shows that their pricing model is extremely disciplined, with a heavy focus on the mass-middle segment (₹250-₹500). The most significant finding is that Premium Outliers (high-priced items) do not suffer from lower ratings, proving that customers are willing to pay more for Mamaearth's value proposition.
### Strategic Recommendations:
Inventory Expansion: Shift R&D from the saturated Face Wash category to Body Lotions and Sunscreens, which have high satisfaction but low SKU diversity.
Review Incentivization: Focus marketing efforts on the 42% of products without ratings. These products represent "silent inventory" that could be underperforming simply due to lack of social proof.
Tier-Based Bundling: Use the 4.9-rated budget heroes (₹250-₹300) as "Gateway Products" in bundles with premium outliers (₹600+) to increase the Average Order Value (AOV).

### 💡Key Results :
#### 📈 Volume Drivers: Face Wash (24 SKUs) and Hair Shampoo (18 SKUs) represent the core of the portfolio, accounting for the highest catalog density.
#### 💰 Pricing Sweet Spot: 60% of top-rated inventory is priced in the ₹250–₹500 range, proving it as the primary revenue engine.
#### ⭐ Brand Loyalty: The portfolio maintains a weighted average rating of 4.95, indicating extreme consistency in product quality.
#### 🔍 Data Opportunity: Discovered that 42.4% of products have missing ratings, flagging a major opportunity to implement review-collection automation.


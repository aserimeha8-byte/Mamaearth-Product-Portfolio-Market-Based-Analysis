# Mamaearth-Product-Portfolio-Market-Based-Analysis

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
### Data Descrption:
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

### Data Preprocessing Phase: 
#### Before Data Cleaning
<img width="1894" height="894" alt="image" src="https://github.com/user-attachments/assets/f008dbb0-621d-4de4-be3c-52333ab6cd6e" />

- **Handling Duplicates**: Removed redundant entries to ensure SKU counts and category metrics remained 100% accurate
- **Trim Whitespace**: Cleaned all categorical columns to prevent fragmentation during SQL GROUP BY operations.
- **Handling Missing Values**: Tagged incomplete categories as "Unknown" and isolated null ratings to avoid skewing mathematical averages.
- **Correcting Format**: Standardized MRP, Discount, and Rating into numeric formats and spellchecks for seamless compatibility with SQL math functions
- **Amending quantity**: Normalized inconsistent units (ml, g, packs) into a standardized scale for accurate price-per-unit comparisons.
#### After Data Cleaning
<img width="1902" height="704" alt="image" src="https://github.com/user-attachments/assets/ace582e6-ae29-4fdb-83a5-19ecc0295975" />



### 🔬 SQL Techniques Implemented
- Importing CSV: Database was already present called **maven_advanced_sql** for making table schema under database. Table schema was created namely - **mamaearth** with same schema for importing by table data import wizard (importing all 264 entries from csv to sql table schema by right clicking schema and opting table data import wizard which imports and inserts all entries in a particular schema)

Aggregations & Grouping: Used COUNT(DISTINCT) and GROUP BY to map inventory depth across 14 categories.
Market Segmentation: Built logic using CASE WHEN to bucket products into Budget (Entry), Mid-range (Volume), and Premium (AOV) tiers.
Statistical Profiling: Leveraged AVG() and STDDEV() to identify price outliers and average performance benchmarks.
Data Integrity: Implemented WHERE and IS NULL filters to isolate the 42.4% of products missing consumer data for clean reporting.
Complex Joins/Subqueries: Analyzed correlations between pricing tiers and rating averages to see if "Higher Price = Higher Quality" holds true.

### 📊 Findings & Data Analysis
Analysis AreaSQL Logic UsedKey Business InsightCategory SaturationGROUP BY categoryFace Wash is high-volume/high-competition; Body Lotion shows high ratings with low SKU count (Growth Area).Pricing ArchitectureCASE & CASE WHENMamaearth is a "Premium-Mass" brand. Entry is at ₹250, but the volume is at ₹399.Price-Rating CorrelationNested SubqueriesNo Quality Dilution: Products in the ₹500+ bracket maintain the same 4.9+ rating as the budget range.

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


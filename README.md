# Mamaearth-Product-Portfolio-Market-Based-Analysis

## End-to-End SQL Project on Mamaearth brand Product Analysis (Dummy Dataset from Kaggle): Pricing Architecture, Category Dominance, and Consumer Sentiment Analysis

### 📊Project Overview: 
This project analyzes Mamaearth’s e-commerce containing *250+* entries footprint using Advanced SQL(Joins, Window Functions, Subqueries, CTEs). The goal was to solve a specific business challenge: Identifying the *Sweet Spot* in product pricing and category saturation to drive promotional growth. By querying a catalog of *160+* products across *10* categories, I mapped out the brand's product market positioning and identified untapped opportunities in their product mix.

### 🎯Business Objectives 
#### Category Analysis:Quantify SKU depth to identify "Hero" vs. "Under-leveraged" categories.
#### Pricing Strategy: Segment the portfolio into price buckets to understand the brand’s affordability index.
#### Customer Sentiment: Analyze rating distributions to find quality gaps and identify high-performing lines.
#### Correlation Insights: Statistically determine if premium-priced items correlate with higher customer satisfaction.

### 💡Key Results :
#### 📈 Volume Drivers: Face Wash (24 SKUs) and Hair Shampoo (18 SKUs) represent the core of the portfolio, accounting for the highest catalog density.
#### 💰 Pricing Sweet Spot: 60% of top-rated inventory is priced in the ₹250–₹500 range, proving it as the primary revenue engine.
#### ⭐ Brand Loyalty: The portfolio maintains a weighted average rating of 4.95, indicating extreme consistency in product quality.
#### 🔍 Data Opportunity: Discovered that 42.4% of products have missing ratings, flagging a major opportunity to implement review-collection automation.

### 📁 Project StructurePlaintextmamaearth-sql-analysis/
│
├── data/
│   └── mamaearth_cleaned.csv      # Processed data (Handled via Excel before SQL ingestion)
│
├── sql_queries/
│   ├── 01_schema_setup.sql        # Database DDL & constraints
│   ├── 02_category_deepdive.sql   # SKU counts & category distribution
│   ├── 03_pricing_segments.sql    # CASE statements for market tiering
│   └── 04_correlation_metrics.sql # Rating vs. Price correlation analysis
│
├── screenshots/                   # All 18 execution results showing queries & outputs
│
└── README.md                      # Business Case & Executive Summary
🔬 SQL Techniques ImplementedAggregations & Grouping: Used COUNT(DISTINCT) and GROUP BY to map inventory depth across 14 categories.Market Segmentation: Built logic using CASE WHEN to bucket products into Budget (Entry), Mid-range (Volume), and Premium (AOV) tiers.Statistical Profiling: Leveraged AVG() and STDDEV() to identify price outliers and average performance benchmarks.Data Integrity: Implemented WHERE and IS NULL filters to isolate the 42.4% of products missing consumer data for clean reporting.Complex Joins/Subqueries: Analyzed correlations between pricing tiers and rating averages to see if "Higher Price = Higher Quality" holds true.📊 Findings & Data AnalysisAnalysis AreaSQL Logic UsedKey Business InsightCategory SaturationGROUP BY categoryFace Wash is high-volume/high-competition; Body Lotion shows high ratings with low SKU count (Growth Area).Pricing ArchitectureCASE & CASE WHENMamaearth is a "Premium-Mass" brand. Entry is at ₹250, but the volume is at ₹399.Price-Rating CorrelationNested SubqueriesNo Quality Dilution: Products in the ₹500+ bracket maintain the same 4.9+ rating as the budget range.📈 Strategic Conclusion & RecommendationsDeduction: Mamaearth has successfully democratized premium personal care. My analysis shows that their pricing model is extremely disciplined, with a heavy focus on the mass-middle segment (₹250-₹500). The most significant finding is that Premium Outliers (high-priced items) do not suffer from lower ratings, proving that customers are willing to pay more for Mamaearth's value proposition.Strategic Recommendations:Inventory Expansion: Shift R&D from the saturated Face Wash category to Body Lotions and Sunscreens, which have high satisfaction but low SKU diversity.Review Incentivization: Focus marketing efforts on the 42% of products without ratings. These products represent "silent inventory" that could be underperforming simply due to lack of social proof.Tier-Based Bundling: Use the 4.9-rated budget heroes (₹250-₹300) as "Gateway Products" in bundles with premium outliers (₹600+) to increase the Average Order Value (AOV).

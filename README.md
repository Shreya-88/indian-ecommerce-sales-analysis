# Indian E-commerce Sales Analysis

![Dashboard preview](images/dashboard_preview.png)

## Project overview
This **guided portfolio project** analyses a simulated Indian e-commerce dataset to help a retail manager understand sales, profitability, returns, and delivery performance. The data is synthetic and does not represent a real employer or customer.

## Business questions
1. How are sales and profit changing by month?
2. Which categories, regions, and channels contribute most?
3. Which categories have high return rates?
4. Does slower delivery relate to returns and ratings?
5. What actions could improve sales and customer experience?

## Tools used
- **Excel:** data review, summary tables, KPIs, and dashboard
- **SQL (SQLite):** aggregations, CASE statements, CTEs, and a window function
- **Power BI:** data model, DAX measures, interactive dashboard design

## Dataset
- 2,400 order-level records from January 2025 to June 2026
- 19 columns covering orders, geography, category, revenue, profit, delivery, returns, and ratings
- Reproducible synthetic data generated for learning
- See [`data/data_dictionary.csv`](data/data_dictionary.csv)

## Headline results
- Total sales: **₹6,598,858** across **2,400 orders**
- Total profit: **₹2,256,766**; profit margin: **34.2%**
- Average order value: **₹2,750**; return rate: **6.2%**
- **Electronics** generated the highest sales (**₹2,500,698**)
- **North** was the leading region (**₹1,905,174**)
- **Fashion** had the highest category return rate (**8.6%**)
- Orders taking 7+ days had a **12.8%** return rate, compared with **5.6%** for deliveries under 7 days

## Recommendations
1. Prioritise inventory and campaigns for the strongest categories, while tracking margin rather than sales alone.
2. Investigate product descriptions, sizing/quality feedback, and fulfilment for the highest-return category.
3. Set an alert for orders likely to exceed six delivery days and proactively update customers.
4. Compare channel acquisition costs before moving budget; order volume alone is not enough.

## Repository structure
```
├── data/
│   ├── ecommerce_sales.csv
│   └── data_dictionary.csv
├── excel/ecommerce_sales_analysis.xlsx
├── sql/analysis_queries.sql
├── powerbi/POWER_BI_BUILD_GUIDE.md
├── images/dashboard_preview.png
└── README.md
```

## How to reproduce
1. Download this repository.
2. Open the Excel workbook and review `Raw_Data`, `Analysis`, and `Dashboard`.
3. Import the CSV into SQLite (for example, SQLiteOnline) and run the SQL queries one at a time.
4. Follow the Power BI build guide to create an interactive dashboard.

## What I learned
- Structuring a business problem before building charts
- Checking field types and validating calculated metrics
- Writing SQL for KPIs, trends, segmentation, and return analysis
- Choosing visuals based on the decision each visual supports
- Translating analysis into concise business recommendations

## Important note
This is a guided, simulated portfolio project created for learning. I reviewed the data, reproduced the analysis, and can explain the calculations and recommendations.

# Power BI Build Guide (Beginner Friendly)

## 1. Import the data
1. Open **Power BI Desktop**.
2. Select **Home > Get data > Text/CSV**.
3. Choose `data/ecommerce_sales.csv` and click **Transform Data**.
4. In Power Query, confirm types: `Order_Date` = Date; quantity/days/rating/discount = Whole number; sales/cost/profit/unit price = Decimal number.
5. Rename the query **Sales** and choose **Close & Apply**.

## 2. Create a Date table
Go to **Modeling > New table** and enter:
```DAX
Date = CALENDAR(MIN(Sales[Order_Date]), MAX(Sales[Order_Date]))
```
Add columns with **New column**:
```DAX
Year = YEAR('Date'[Date])
Month Number = MONTH('Date'[Date])
Month = FORMAT('Date'[Date], "MMM")
Year Month = FORMAT('Date'[Date], "YYYY-MM")
```
In Model view, connect `Date[Date]` to `Sales[Order_Date]` (one-to-many). Sort `Month` by `Month Number`.

## 3. Create measures
Select the Sales table and create each measure separately:
```DAX
Total Sales = SUM(Sales[Sales_INR])
Total Profit = SUM(Sales[Profit_INR])
Total Orders = DISTINCTCOUNT(Sales[Order_ID])
Profit Margin % = DIVIDE([Total Profit], [Total Sales])
Average Order Value = DIVIDE([Total Sales], [Total Orders])
Returned Orders = CALCULATE([Total Orders], Sales[Returned] = "Yes")
Return Rate % = DIVIDE([Returned Orders], [Total Orders])
Average Delivery Days = AVERAGE(Sales[Delivery_Days])
Average Rating = AVERAGE(Sales[Rating])
Previous Month Sales = CALCULATE([Total Sales], DATEADD('Date'[Date], -1, MONTH))
MoM Growth % = DIVIDE([Total Sales] - [Previous Month Sales], [Previous Month Sales])
```
Format money measures as ₹ currency and rates as percentages.

## 4. Build the report page
Use a 16:9 page and add:
- Cards: Total Sales, Total Profit, Profit Margin %, Total Orders, Return Rate %
- Line chart: `Date[Year Month]` on X-axis and Total Sales as value
- Bar chart: Category and Total Sales
- Column chart: Region and Total Sales
- Donut chart: Channel and Total Orders
- Matrix: Product, Total Sales, Total Profit, Return Rate %
- Slicers: Date, Region, Category, Channel

## 5. Add a returns page
- Bar chart: Category vs Return Rate %
- Scatter plot: Average Delivery Days vs Return Rate %; Category as details
- Cards: Returned Orders, Return Rate %, Average Delivery Days, Average Rating
- Table: Product, orders, Return Rate %, Average Rating

## 6. Validate
Your overall cards should approximately show:
- Sales: ₹6,598,858
- Profit: ₹2,256,766
- Orders: 2,400
- Profit margin: 34.2%
- Return rate: 6.2%
If not, check data types and ensure Order_ID is not summarised as a number.

## 7. Save and document
Save as `ecommerce_sales_dashboard.pbix`. Take a screenshot, replace `images/dashboard_preview.png`, and update the README if your layout or findings differ.

#  Data Analytics — Project 3: SQL Data Analysis

> **Industrial Training Kit | Batch 2026 | Powered by DecodeLabs**

---

##  Project Overview

This project is part of the **DecodeLabs Industrial Training Programme**. The goal is to use SQL queries to extract actionable business intelligence from a raw e-commerce dataset.

Rather than simply viewing spreadsheets, this project focuses on **Querying for Truth** — using structured SQL to filter, group, and aggregate data into meaningful insights.

---

##  Objectives

- Write `SELECT` queries to retrieve and explore data
- Use `WHERE` and `AND` to filter rows by conditions
- Sort results with `ORDER BY`
- Group data using `GROUP BY`
- Perform aggregations with `COUNT()`, `SUM()`, and `AVG()`
- Filter grouped results using `HAVING`
- Extract date components with `YEAR()`

---

##  Dataset

| Property | Details |
|----------|---------|
| **File** | `Dataset_for_Data_Analytics.xlsx` |
| **Table Name** | `orders` |
| **Records** | 1,200 rows |
| **Columns** | 14 |
| **Tool** | MySQL Workbench 8.0 |
| **Database** | `decodelabs_` |

### Columns

| Column | Type | Description |
|--------|------|-------------|
| `OrderID` | VARCHAR(20) | Unique order identifier |
| `Date` | DATE | Order date |
| `CustomerID` | VARCHAR(20) | Unique customer ID |
| `Product` | VARCHAR(50) | Product name |
| `Quantity` | INT | Units ordered |
| `UnitPrice` | DECIMAL(10,2) | Price per unit |
| `ShippingAddress` | VARCHAR(100) | Delivery address |
| `PaymentMethod` | VARCHAR(50) | Payment type |
| `OrderStatus` | VARCHAR(50) | Shipped / Cancelled / Delivered / Returned / Pending |
| `TrackingNumber` | VARCHAR(50) | Shipment tracking reference |
| `ItemsInCart` | INT | Items in customer cart |
| `CouponCode` | VARCHAR(50) | Discount coupon used |
| `ReferralSource` | VARCHAR(50) | Marketing channel |
| `TotalPrice` | DECIMAL(10,2) | Total order value |

---

##  Setup

### 1. Create the Database & Table

```sql
CREATE DATABASE decodelabs_;
USE decodelabs_;

CREATE TABLE orders (
  OrderID VARCHAR(20),
  Date DATE,
  CustomerID VARCHAR(20),
  Product VARCHAR(50),
  Quantity INT,
  UnitPrice DECIMAL(10,2),
  ShippingAddress VARCHAR(100),
  PaymentMethod VARCHAR(50),
  OrderStatus VARCHAR(50),
  TrackingNumber VARCHAR(50),
  ItemsInCart INT,
  CouponCode VARCHAR(50),
  ReferralSource VARCHAR(50),
  TotalPrice DECIMAL(10,2)
);
```

### 2. Import Data

Convert the Excel file to CSV, then in MySQL Workbench:
- Right-click the `orders` table → **Table Data Import Wizard**
- Select the CSV file → Next → Next → Finish

---

##  SQL Queries

### Query 1 — View Data (SELECT + LIMIT)

```sql
SELECT * FROM orders LIMIT 10;
```
> Displays the first 10 rows to verify the data was imported correctly.

---

### Query 2 — Filter Cancelled Orders (WHERE)

```sql
SELECT * FROM orders
WHERE OrderStatus = 'Cancelled';
```
> Returns all 250 cancelled orders (20.8% of total).

---

### Query 3 — Sort by Price (ORDER BY)

```sql
SELECT * FROM orders
ORDER BY TotalPrice DESC;
```
> Lists all 1,200 orders from most to least expensive. Highest value: **$3,456.40**.

---

### Query 4 — Orders per Product (GROUP BY + COUNT)

```sql
SELECT Product, COUNT(*) AS Total_Orders
FROM orders
GROUP BY Product
ORDER BY Total_Orders DESC;
```

| Product | Total Orders |
|---------|-------------|
| Printer | 181 |
| Tablet | 179 |
| Chair | 178 |
| Laptop | 173 |
| Desk | 170 |
| Monitor | 163 |
| Phone | 156 |

---

### Query 5 — Revenue per Product (SUM + AVG)

```sql
SELECT Product,
       SUM(TotalPrice) AS Total_Sales,
       AVG(TotalPrice) AS Average_Sale
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC;
```

| Product | Total Sales ($) | Avg Sale ($) |
|---------|----------------|-------------|
| Chair | 195,620.11 | 1,098.99 |
| Printer | 195,612.61 | 1,080.73 |
| Laptop | 192,126.56 | 1,110.56 |
| Tablet | 186,568.95 | 1,042.28 |
| Monitor | 175,651.41 | 1,077.62 |
| Desk | 167,459.93 | 985.06 |
| Phone | 151,722.39 | 972.58 |

---

### Query 6 — High-Value Shipped Orders (WHERE + AND)

```sql
SELECT * FROM orders
WHERE OrderStatus = 'Shipped'
AND TotalPrice > 1000;
```
> Returns **102 orders** that were shipped and exceeded $1,000 in value.

---

### Query 7 — Orders by Payment Method (GROUP BY + COUNT)

```sql
SELECT PaymentMethod, COUNT(*) AS Total
FROM orders
GROUP BY PaymentMethod
ORDER BY Total DESC;
```

| Payment Method | Total | Share |
|---------------|-------|-------|
| Online | 258 | 21.5% |
| Cash | 246 | 20.5% |
| Credit Card | 234 | 19.5% |
| Debit Card | 232 | 19.3% |
| Gift Card | 230 | 19.2% |

---

### Query 8 — Best-Selling Product (SUM + LIMIT 1)

```sql
SELECT Product, SUM(TotalPrice) AS Total_Sales
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 1;
```
> **Chair** is the top revenue product with **$195,620.11** in total sales.

---

### Query 9 — Annual Sales Performance (YEAR + GROUP BY)

```sql
SELECT YEAR(Date) AS Year,
       COUNT(*) AS Orders,
       SUM(TotalPrice) AS Total_Sales
FROM orders
GROUP BY YEAR(Date)
ORDER BY Year;
```

| Year | Orders | Total Sales ($) |
|------|--------|----------------|
| 2023 | 510 | 552,643.24 |
| 2024 | 459 | 480,235.87 |
| 2025 | 231 | 231,882.85 |

---

### Query 10 — Products with 100+ Orders (HAVING)

```sql
SELECT Product, COUNT(*) AS Total_Orders
FROM orders
GROUP BY Product
HAVING Total_Orders > 100;
```
> All 7 products exceed 100 orders, confirming balanced demand across the catalogue.  
>  Note: `HAVING` filters on aggregated values — `WHERE` cannot be used here.

---

##  Key Business Insights

| # | Finding | Detail |
|---|---------|--------|
| 1 |  Highest Revenue | Chair — $195,620.11 |
| 2 |  Most Ordered | Printer — 181 orders |
| 3 |  Cancellation Rate | 20.8% (250 / 1,200 orders) |
| 4 |  Best Avg Sale | Laptop — $1,110.56 per order |
| 5 |  Top Payment Method | Online — 258 orders (21.5%) |
| 6 |  Best Year | 2023 — 510 orders, $552,643 revenue |
| 7 |  High-Value Fulfilled | 102 shipped orders above $1,000 |
| 8 |  Balanced Demand | All 7 products have 150+ orders |

---

##  Project Structure

```
project-3-sql-analysis/
│
├── README.md                          # This file
├── dataset/
│   └── Dataset_for_Data_Analytics.xlsx
├── queries/
│   └── project3_queries.sql           # All SQL queries
└── report/
    └── SQL_Data_Analysis_Report_Project3.docx
```

---

##  Tools Used

- **MySQL Workbench 8.0**
- **Microsoft Excel** (data source)
- **SQL** (MySQL dialect)

---

##  Author

**Farid oumnay**

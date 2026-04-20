# E-commerce SQL Analytics & Business Intelligence Project

## Project Overview
This project consists of a comprehensive suite of **50 SQL Business Intelligence queries** designed to analyze an e-commerce marketplace (based on the Olist Brazilian E-Commerce dataset). The project covers the entire analytical spectrum, from basic descriptive statistics to advanced predictive modeling and customer lifecycle analysis.

## Core Analytical Pillars

### 1. Customer Insights & Lifecycle
- **Retention & Churn:** Cohort analysis, retention matrices (people and revenue), and churn detection for customers inactive for 6+ months.
- **Segmentation:** Quartile-based spending analysis (NTILE), identifying "Whales" (top 10%), and segmenting high-value/low-frequency users.
- **Loyalty:** Calculating Customer Lifetime Value (CLV), identifying repeat purchasers, and measuring the "time-to-second-purchase."

### 2. Seller & Marketplace Performance
- **Diversification:** Identifying generalist vs. specialist sellers based on category counts.
- **Concentration:** Pareto analysis (80/20 rule) to determine how much revenue is driven by the top 20% of sellers.
- **Growth:** Ranking sellers by annual revenue and tracking month-over-month performance.

### 3. Logistics & Quality Assurance
- **Delivery Speed:** Regional analysis of delivery times and state-by-state logistics benchmarking.
- **Trust & Satisfaction:** Correlating delivery delays with review scores and tracking declining seller ratings over time.
- **Risk Management:** Analyzing refund and cancellation rates by product category.

### 4. Financial & Strategic Planning
- **Revenue Tracking:** Monthly growth percentages, running totals (cumulative revenue), and year-over-year comparisons.
- **Integrity:** Financial reconciliation between payment values and calculated order totals to detect glitches or fraud.
- **Seasonality:** Identifying monthly order patterns to inform inventory and marketing spend.

## Technical Skills Demonstrated
- **Window Functions:** `RANK()`, `DENSE_RANK()`, `NTILE()`, `LAG()`, `LEAD()`, `FIRST_VALUE()`, and `SUM() OVER`.
- **CTEs (Common Table Expressions):** Used extensively for multi-step logic and readability.
- **Aggregation & Filtering:** Complex `GROUP BY`, `HAVING`, and conditional logic (`CASE WHEN`).
- **Date Manipulation:** `DATEDIFF`, `DATEADD`, and `FORMAT` for time-series analysis.

## Business Impact
The queries in this repository provide actionable insights for:
- **Marketing:** To optimize acquisition budgets (CAC/CLV) and trigger win-back campaigns.
- **Operations:** To identify logistics bottlenecks and improve delivery estimation accuracy.
- **Finance:** To monitor growth velocity and ensure data integrity in payments.
- **Product:** To understand category performance and improve marketplace trust.

/*
This query is used for Cohort Acquisition Analysis and Customer Lifecycle Tracking. It marks the exact moment a prospect transitioned into a customer, which is the "Day Zero" for all future engagement metrics.

Why Analysts Use This Query:
Defining Acquisition Cohorts: This is the foundation for "Cohort Tables." By grouping customers by their first purchase month (e.g., the "January 2024 Cohort"), analysts can track how long that specific group stays active compared to customers who joined in other months.

Calculating Customer Age: Once you have the first purchase date, you can calculate how "old" a customer is. This helps in segmenting your database into "Newbies" (first 30 days), "Established" (1 year), and "Veterans."

Measuring Marketing Attribution: By matching this date with marketing spend data, the business can see which specific ad campaigns or seasonal promotions were responsible for bringing in the most new users.

Customer Lifetime Value (CLV) Baseline: You cannot calculate the "Lifetime" part of CLV without knowing when the lifetime started. This query provides the start date needed to measure how much revenue a customer generates over their entire duration with the brand.

Identifying Viral Loops: If a sudden surge of "First Purchases" happens in a specific region on a specific day, it helps analysts identify viral social media mentions or successful local referral programs.
*/

-- Question 32 Identify first purchase date for each customer.--
SELECT DISTINCT
    c.customer_unique_id,
    FIRST_VALUE(o.order_purchase_timestamp) 
        OVER (PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp) 
        AS first_purchase_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

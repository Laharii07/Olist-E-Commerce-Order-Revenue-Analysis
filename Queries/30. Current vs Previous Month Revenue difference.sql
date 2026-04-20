/*
This query is used for Absolute Variance Analysis. While the previous query looked at growth as a percentage, this one measures the actual dollar (or currency) amount gained or lost between consecutive months.

Why Analysts Use This Query:
Quantifying Financial Impact: It answers "Exactly how much more money did we bring in this month compared to last?" This is vital for cash flow management and understanding the scale of revenue shifts.

Budget Variance Tracking: If a company expected to increase revenue by $50,000 this month, this query provides the raw data to see if that specific target was met.

Spotting Operational Anomalies: Large, sudden drops in revenue_diff (e.g., losing $200,000 in a single month) are easier to spot and investigate than small percentage shifts, helping to identify systemic issues quickly.

Marketing Contribution: When a specific campaign costs $10,000, analysts look at the revenue_diff to see if the revenue increase exceeded the cost of the campaign.

Executive Summaries: High-level stakeholders often prefer "We made $20k more than last month" over "We grew by 4.2%," as raw numbers are often more tangible for immediate financial planning.
*/
-- Question 30 Find revenue difference between current and previous month.--
WITH monthly_revenue AS (
    SELECT 
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
)

SELECT *,
    revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_diff
FROM monthly_revenue;

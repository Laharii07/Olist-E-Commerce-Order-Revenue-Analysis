/*
This query is the definitive tool for Momentum Analysis. While raw revenue tells you how much money you made, Growth Percentage tells you the velocity of the business—whether you are accelerating, stabilizing, or shrinking.

Why Analysts Use This Query:
Measuring Business Momentum: It answers the critical question: "Are we doing better than last month?" A consistent positive percentage indicates healthy scaling, while negative percentages serve as an immediate "red flag" for management to investigate.

Seasonality Impact Analysis: By tracking MoM changes, analysts can quantify the impact of holidays or events. For example, you can see exactly what percentage revenue jumped during "Black Friday" compared to the previous month.

Marketing Effectiveness: If a major ad campaign was launched in a specific month, this growth percentage is the primary metric used to calculate the Return on Investment (ROI) and overall success of that campaign.

Investor and Stakeholder Reporting: Growth rate is often more important to investors than total profit. It demonstrates the "scalability" of the business model.

Budgeting and Forecasting: Analysts use historical growth percentages to predict future revenue. If the average MoM growth is 5%, they can project what the revenue will look like in 6 or 12 months.
*/

-- Question 29 Calculate month-over-month revenue growth % (use LAG). --
WITH monthly_revenue AS (
    SELECT 
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
)

SELECT *,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ((revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 
        / LAG(revenue) OVER (ORDER BY month)) AS growth_percentage
FROM monthly_revenue;

/*
This query calculates the Cohort Average Order Value (AOV) Trend. While previous queries focused on the total money or total people, this one zooms in on Customer Spending Behavior. It answers: "As a customer gets older, does their basket size get bigger or smaller?"

Why Analysts Use This Query:
Identifying Trust Maturity: Often, a customer's first order is small because they are "testing" the site. If the AOV increases in Month 2 and Month 3 for a specific cohort, it’s a sign that their trust in the platform is growing.

Monetization Strategy: If AOV drops significantly after the first month, it might suggest that customers only return for small, "top-up" purchases or when they have a coupon. This signals a need for better cross-selling or up-selling strategies.

Inflation and Pricing Impact: By comparing the Month 0 AOV of a 2023 cohort vs. a 2024 cohort, analysts can see how price increases or macroeconomic changes are affecting a new customer's "willingness to spend" right out of the gate.

Promotion Evaluation: If a cohort was acquired during a "Free Shipping" month, their AOV might be lower (since they feel free to place many small orders). This query helps quantify the actual cost of such promotions on basket health.

Predicting Future Margins: High AOVs usually lead to better margins because fixed costs (like advertising to get the customer there) are spread across more revenue.

Technical Insight: The "Order-Level" Aggregation
Your CTE is crucial here because it prevents a common mistake: The Double-Count.

Inside the CTE: You group by order_id first to get the total value of each specific "basket."

Outside the CTE: You average those totals.

If you averaged the order_items directly without grouping them into orders first, your AOV would be skewed toward the price of individual items, not the actual amount the customer paid at checkout.
*/

-- Question 40 Calculate average order value per cohort over time.--
WITH cohort_data AS (
    SELECT 
        c.customer_unique_id,
        FORMAT(MIN(o.order_purchase_timestamp) OVER 
            (PARTITION BY c.customer_unique_id), 'yyyy-MM') AS cohort_month,
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month,
        o.order_id,
        SUM(oi.price + oi.freight_value) AS order_value
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp
)

SELECT 
    cohort_month,
    order_month,
    AVG(order_value) AS avg_order_value
FROM cohort_data
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;

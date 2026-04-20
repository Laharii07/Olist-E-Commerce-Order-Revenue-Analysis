/*
This query calculates the Revenue Contribution of Loyalists. It is a fundamental metric for evaluating the sustainability of a business model. A business that relies 100% on new customers is essentially a "treadmill"—if the marketing budget stops, the revenue stops.

Why Analysts Use This Query:
Determining Business Maturity: Early-stage startups usually have a very low percentage here. As a company matures, this number should steadily rise, indicating that the brand is building a "moat" of loyal users.

Customer Acquisition Cost (CAC) vs. Retention: It costs significantly more to acquire a new customer than to keep an existing one. If a high percentage of revenue comes from repeat customers, the business is likely much more profitable because it’s not paying "new customer tax" on every dollar earned.

Platform Stickiness: This is the ultimate proof that the product is solving a real problem. If people come back and spend more money, the value proposition is confirmed.

Investor Confidence: High repeat revenue percentages are often rewarded with higher company valuations because the revenue is seen as "recurring" and predictable.

Risk Assessment: If this percentage is too low (e.g., < 5%), the business is highly vulnerable to changes in advertising costs (like a sudden spike in Google or Meta ad prices).
*/

-- Question 41 What % of total revenue comes from repeat customers? -- 
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)

SELECT 
    SUM(CASE WHEN order_count > 1 THEN revenue ELSE 0 END) * 100.0 
        / SUM(revenue) AS repeat_customer_revenue_pct
FROM customer_orders;

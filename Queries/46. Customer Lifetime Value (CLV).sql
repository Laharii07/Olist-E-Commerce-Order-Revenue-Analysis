/*
This query calculates Historical Customer Lifetime Value (CLV). While some advanced models use machine learning to predict future spending, this "Historical" approach is the essential first step—it tells you exactly how much actual cash each individual has brought into your business since day one.

Why Analysts Use This Query:
Determining Acquisition Budgets (CAC vs. CLV): This is the most critical calculation in marketing. If your average CLV is $150, you know you can spend up to (but ideally much less than) $150 to acquire a new customer and still eventually break even.

Tiered Customer Support: Businesses often use CLV to prioritize their service. A "High CLV" customer might get an immediate human agent, while a "Low CLV" customer is directed to a self-service FAQ.

Identifying the "Whales": By ordering by CLV, you find the elite customers who sustain the business. These are the individuals you feature in case studies or invite to focus groups.

Validating Business Health: Analysts track the Average CLV of the whole platform over time. If this number is growing, it means you are successfully getting people to spend more or stay longer.

Informing Product Pricing: If your CLV is lower than expected, it might indicate that your products are "one-and-done" and you need to introduce consumables, subscriptions, or accessories to drive repeat purchases.
*/


-- Question 46 Calculate Customer Lifetime Value (CLV).--
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price + oi.freight_value) AS total_revenue,
    AVG(oi.price + oi.freight_value) AS avg_order_value,
    SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id) AS clv
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY clv DESC;

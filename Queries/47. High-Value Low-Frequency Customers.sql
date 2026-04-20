/*

This query identifies "Potential Whales" or Big-Ticket Impulse Buyers. These are customers who have a high financial impact despite very few interactions. In retail analytics, this segment is often the most mysterious—they spend significantly, but they haven't yet built a "habit" of shopping on your platform.

Why Analysts Use This Query:
Conversion to Loyalists: This is a "Golden Opportunity" group. Because they’ve already demonstrated a willingness to spend large amounts, the marketing goal is to increase their order_count. Converting a "High-Value, Low-Frequency" customer into a "High-Value, High-Frequency" customer is the fastest way to grow revenue.

Identifying High-Ticket Categories: Analysts often look at what these people bought. Usually, this query reveals "Big Box" purchases like high-end electronics, furniture, or luxury appliances.

Predictive Upselling: Since these customers don't visit often, every touchpoint counts. This list is used to trigger "Premium" marketing—exclusive offers for high-end accessories that complement their expensive first purchase.

NPS & Satisfaction Monitoring: Because these customers spend so much in one go, a single bad experience (like a damaged delivery) is a massive financial risk. Customer success teams often prioritize these users for feedback surveys to ensure their "one big experience" was perfect.

Inventory Planning: If this segment is growing, it signals a shift in the marketplace from "everyday essentials" toward "discretionary luxury."
*/

-- Question 47 Identify high-value low-frequency customers.--
WITH customer_metrics AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(oi.price + oi.freight_value) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)

SELECT *
FROM customer_metrics
WHERE order_count <= 2
AND total_spent > (
    SELECT AVG(total_spent) FROM customer_metrics
)
ORDER BY total_spent DESC;


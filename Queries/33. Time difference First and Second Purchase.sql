/*
This query is used for Time-to-Second-Purchase Analysis, which is a critical metric for understanding Consumer Habits and Retention Speed. While many queries look at if a customer returns, this one focuses on how fast they return.

Why Analysts Use This Query:
Identifying the "Hook" Window: Most businesses have a "golden window." If a customer doesn't buy a second time within 30 or 60 days, the likelihood of them ever returning drops significantly. This query helps define that window.

Replenishment Cycle Mapping: For consumable goods (like vitamins, pet food, or coffee), this query reveals the natural consumption cycle. If the average time is 45 days, the marketing team can schedule an automated "Time to restock?" email at the 40-day mark.

Segmenting "Impulse" vs. "Steady" Buyers: Customers with a very low days_between_orders (e.g., 1–3 days) might have forgotten something or are "binge shopping," whereas those with a 90-day gap are likely "lifestyle shoppers."

Evaluating Onboarding Success: If a company introduces a new loyalty program or a "10% off your second order" coupon, analysts run this query to see if the average time between the first and second purchase decreases compared to the previous year.

Predicting Churn: This data creates a "normal" baseline. If a customer passes their usual 30-day return window and hits 60 days without an order, they can be flagged as "At Risk" of churning.

*/

-- Question 33 Calculate time difference between first and second purchase (use LEAD).--
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        o.order_purchase_timestamp,
        LEAD(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id 
            ORDER BY o.order_purchase_timestamp
        ) AS next_purchase
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
)

SELECT 
    customer_unique_id,
    DATEDIFF(day, order_purchase_timestamp, next_purchase) AS days_between_orders
FROM customer_orders
WHERE next_purchase IS NOT NULL;

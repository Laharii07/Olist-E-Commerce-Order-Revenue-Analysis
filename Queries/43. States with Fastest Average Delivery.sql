/*
This query is the cornerstone of Logistics and Supply Chain Optimization. In e-commerce, delivery speed is often the #1 driver of customer satisfaction and positive reviews. Identifying which states are "fast" and which are "slow" helps a business decide where to invest in new warehouses or which shipping partners to favor.

Why Analysts Use This Query:
Identifying Logistics Bottlenecks: If one state has an average delivery time of 3 days and another has 12, it reveals a geographical "blind spot." This data helps justify opening a new distribution center closer to the slower regions.

Managing Customer Expectations: Marketing teams use this to set accurate "Estimated Delivery" dates on the website. Under-promising and over-delivering leads to higher NPS (Net Promoter Scores).

Shipping Carrier Evaluation: Analysts can cross-reference these state averages with the specific carriers used. If a carrier is consistently slow in a specific region, the company might renegotiate contracts or switch to a local provider.

Promotional Targeting: You might run "Next-Day Delivery" promotions only in the states where you know your logistics network can actually support it, avoiding the "Customer Service nightmare" of missed deadlines.

Impact of Infrastructure: This query is often run after a major infrastructure change (like a new highway opening or a new partnership with a postal service) to measure the actual improvement in speed.

Technical Insight: The IS NOT NULL Filter
Your use of WHERE o.order_delivered_customer_date IS NOT NULL is vital.

The Trap: If you include orders that are still "Invoiced" or "Shipped" but not yet delivered, the DATEDIFF calculation would fail or return misleading zeros.

The Math: By only looking at completed deliveries, you are getting a "historical truth" of the actual transit time rather than a theoretical estimate.

*/

-- Question 43 Which states have fastest average delivery? --
SELECT 
    c.customer_state,
    AVG(DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date)) 
        AS avg_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days ASC;

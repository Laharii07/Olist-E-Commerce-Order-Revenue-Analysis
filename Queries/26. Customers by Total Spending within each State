/*
This query is a powerful tool for Regional Micro-Segmentation. Instead of looking at your customers as one giant group, it allows you to identify the "local heroes" or top influencers within every specific geographical area.

Why Analysts Use This Query:
Localized Marketing & Events: If you are planning a physical pop-up shop or an event in a specific state (e.g., California), this query gives you the exact list of VIPs in that area to invite or send exclusive early-access codes.

Regional Wealth Mapping: By comparing the spending of the "Rank 1" customer across different states, analysts can determine which states have the highest individual purchasing power, helping to adjust regional pricing or shipping strategies.

State-Specific Loyalty Programs: This allows the business to run "Local Leaderboard" competitions. For example, "Top 10 spenders in New York this month get a special gift," which gamifies the shopping experience at a local level.

Sales Territory Management: For B2B or high-touch retail, this data helps assign sales representatives. You can ensure your best account managers are assigned to the highest-ranking customers in their respective territories.

Addressing Regional Bias: It helps identify if your "Global Top 10" are all from the same city. If they are, this query helps you find the top customers in other states to understand how to better appeal to those different demographics.

*/
-- Question 26 Rank customers by total spending within each state.--
WITH customer_spending AS (
    SELECT 
        c.customer_unique_id,
        c.customer_state,
        SUM(oi.price + oi.freight_value) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id, c.customer_state
)

SELECT *,
    RANK() OVER (PARTITION BY customer_state ORDER BY total_spent DESC) AS state_rank
FROM customer_spending;

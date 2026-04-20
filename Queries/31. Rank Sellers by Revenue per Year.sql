/*
This query is used for Annual Marketplace Leaderboard Analysis. It provides a high-level view of seller performance that accounts for time, allowing you to see who dominated the market in specific years.

Why Analysts Use This Query:
Yearly Performance Awards: It identifies the "Seller of the Year." Many marketplaces use this data to send trophies, certificates, or badges to the top-ranking sellers, which boosts seller morale and platform loyalty.

Tracking Competitive Shifts: By looking at the ranks across multiple years, analysts can see if the same sellers stay at the top or if new "disruptors" are climbing the ranks. If the top 5 change every year, it indicates a dynamic, healthy marketplace with low barriers to entry.

Supplier Retention Strategy: If a seller who was #1 last year drops to #20 this year, it’s a major red flag. This query helps account managers proactively reach out to high-value partners who might be struggling or moving their inventory to a competitor's platform.

Macro-Trend Analysis: It helps distinguish between "market growth" and "seller growth." If a seller's revenue stayed the same but their rank dropped, it means the rest of the market is growing faster than they are.

Incentive Planning: Businesses use these annual ranks to set "stretch goals" for the following year (e.g., "Any seller in the Top 50 gets a 2% commission rebate next year").

*/

-- Question 31 Rank sellers by revenue per year.--
WITH seller_yearly_revenue AS (
    SELECT 
        oi.seller_id,
        YEAR(o.order_purchase_timestamp) AS yr,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    GROUP BY oi.seller_id, YEAR(o.order_purchase_timestamp)
)

SELECT *,
    RANK() OVER (PARTITION BY yr ORDER BY revenue DESC) AS seller_rank
FROM seller_yearly_revenue;

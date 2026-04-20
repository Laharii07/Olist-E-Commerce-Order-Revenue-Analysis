/*
This query is used for Strategic Supply-Side Analysis. It identifies the "engines" of your marketplace—the sellers who are performing above the mathematical mean and carrying the platform's growth.

Why Analysts Use This Query:
Marketplace Health Assessment: It identifies the "Middle Class" and "Elite" sellers. If only a tiny fraction of sellers are above average, the marketplace is top-heavy and risky; a more balanced distribution indicates a healthier ecosystem.

Incentive Targeting: These sellers are the best candidates for "Growth Programs." Since they already have proven traction, providing them with lower fees or better tools is more likely to yield a high return on investment (ROI).

Resource Prioritization: Account managers use this list to decide where to spend their time. An "Above Average" seller is worth more individual attention than a seller who only moves one item a month.

Benchmarking for Underperformers: This "Average Revenue" figure becomes a KPI for the sales team. Their goal is to move "Below Average" sellers into the "Above Average" category through coaching or optimization.

Churn Impact Modeling: This helps calculate the "Cost of Loss." If an above-average seller leaves the platform, the impact on total GMV (Gross Merchandise Volume) is significantly higher than the loss of a standard seller.
*/

-- Question 17 Identify sellers whose revenue is above average seller revenue.--
WITH seller_revenue AS (
    SELECT 
        seller_id,
        SUM(price + freight_value) AS total_revenue
    FROM order_items
    GROUP BY seller_id
)

SELECT *
FROM seller_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue) FROM seller_revenue
)
ORDER BY total_revenue DESC;

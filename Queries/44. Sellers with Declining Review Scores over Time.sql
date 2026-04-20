/*
This query is a Risk Mitigation and Quality Assurance tool. It acts as an early warning system to identify sellers who might be experiencing operational burnout, inventory issues, or a sudden drop in customer service quality before their overall lifetime rating is significantly damaged.

Why Analysts Use This Query:
Preventing "Account Decay": A seller might have a lifetime rating of 4.8, but if their last three months have been 4.5, 4.2, and 3.9, they are in a downward spiral. Analysts use this to catch the trend early and intervene with support or warnings.

Identifying Supply Chain Failures: Often, a declining score isn't about the seller's attitude, but a specific product batch or a new shipping partner. This query flags the moment the "vibe" changed, allowing the seller to pinpoint exactly what changed in their process that month.

Maintaining Marketplace Trust: High-performing marketplaces thrive on consistency. By identifying and coaching sellers with declining scores, the platform ensures that long-term buyers don't have a "bad experience" that stops them from coming back to the site entirely.

Incentive Eligibility: Many platforms offer "Top-Rated Seller" badges or lower commission rates. This query is used to automatically strip those benefits if a seller's performance begins to slip, ensuring only the best are rewarded.

Technical Insight: The "Lag" Logic
Your use of the LAG() function within a PARTITION BY seller_id is the correct way to handle time-series comparisons across multiple entities.

PARTITION BY seller_id: This ensures you aren't comparing Seller A's January score to Seller B's December score. It keeps the "look back" isolated to each individual seller's history.

The Limitation of the Result: Currently, this query returns every month where a score was lower than the month before. In a real-world scenario, scores fluctuate naturally.
*/


-- Question 44 Which sellers have declining review scores over time?--
WITH seller_reviews AS (
    SELECT 
        oi.seller_id,
        FORMAT(r.review_creation_date, 'yyyy-MM') AS review_month,
        AVG(r.review_score) AS avg_score
    FROM order_reviews r
    JOIN orders o ON r.order_id = o.order_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY oi.seller_id, FORMAT(r.review_creation_date, 'yyyy-MM')
),
trend AS (
    SELECT *,
        LAG(avg_score) OVER (PARTITION BY seller_id ORDER BY review_month) AS prev_score
    FROM seller_reviews
)

SELECT *
FROM trend
WHERE avg_score < prev_score;

/*
This query is used for Product Quality Control and Sentiment Analysis. 
It helps the business understand which product lines are satisfying customers and which are failing.
Quality Benchmarking: It identifies high-performing categories to use as models for success and
flags low-scoring categories that may need better quality control or new suppliers.
Customer Experience Audit: It reveals if specific types of products (e.g., fragile electronics or heavy furniture) 
consistently lead to poor reviews due to shipping damage or complex assembly.
Inventory Strategy: High-rated categories are safer bets for increased inventory investment, 
while low-rated categories might be phased out to protect the brand’s overall reputation.
Marketing & SEO: Categories with high average scores can be highlighted in "Top Rated"
marketing campaigns to build trust with new shoppers.
Root Cause Analysis: By comparing scores across categories,
analysts can determine if a drop in satisfaction is unique to one product type or a platform-wide issue.
*/

-- Question - 8 Calculate average review score per product category.--
SELECT 
    p.product_category_name,
    AVG(r.review_score) AS avg_review_score
FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_review_score DESC;

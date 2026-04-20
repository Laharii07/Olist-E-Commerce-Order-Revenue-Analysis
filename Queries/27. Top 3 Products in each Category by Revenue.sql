/*
This query is used for Competitive Product Assortment Analysis. While finding the #1 product is great for identifying a "hero" item, finding the Top 3 provides a deeper look at the variety and competitive landscape within each category.

Why Analysts Use This Query:
Identifying Market Dominance: If the "Rank 1" product has $10,000 in revenue and "Rank 2" only has $1,000, the category is dominated by a single winner. If the top 3 are close in revenue, it indicates a highly competitive and balanced market.

Merchandising Depth: When designing a "Best Sellers" page or a promotional flyer, one product isn't enough. This query provides the "Gold, Silver, and Bronze" items to ensure your marketing materials show a variety of popular options.

Stock-Out Protection: By knowing the top 3 items, the logistics team can prepare "substitute" items. If the #1 product goes out of stock, they know exactly which products (#2 and #3) should be promoted as the next-best alternatives.

Performance Stability: Analysts track the Top 3 to see how often they change. If the same three products stay at the top for a year, the category is "mature." If the Top 3 change every month, the category is "trendy" and requires more frequent inventory updates.

Optimizing Search Results: E-commerce sites often "boost" the top-performing products in their search algorithms. This query identifies the specific SKUs that should receive that organic boost to maximize conversion rates.
*/
-- Question 27 Find top 3 products in each category by revenue (use RANK/DENSE_RANK).--
WITH product_revenue AS (
    SELECT 
        p.product_id,
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.product_category_name
)

SELECT *
FROM (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY product_category_name 
            ORDER BY revenue DESC
        ) AS rnk
    FROM product_revenue
) t
WHERE rnk <= 3;

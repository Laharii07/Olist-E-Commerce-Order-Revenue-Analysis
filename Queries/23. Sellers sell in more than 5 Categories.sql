/*
This query is used for Seller Diversification and Specialization Analysis. It identifies "Generalist" sellers who cast a wide net across the marketplace rather than focusing on a single niche.

Why Analysts Use This Query:
Identifying Generalist vs. Specialist Sellers: This helps distinguish between niche experts (who might sell 100 items in just "Electronics") and "Department Store" sellers who manage a diverse portfolio. Generalists are often larger operations with more complex supply chains.

Marketplace Resilience: Sellers with more than 5 categories are less vulnerable to seasonal dips. If "Toys" are down in January, they might still be selling "Home Decor." Analysts monitor these sellers to ensure the platform has a stable backbone of revenue.

Inventory Risk Assessment: Managing 5+ categories is operationally difficult. Analysts use this list to keep a closer eye on quality; if a seller spreads themselves too thin, their "Average Review Score" or "Shipping Speed" might start to drop.

Cross-Category Insights: These sellers provide unique data on how different categories interact. For example, an analyst can see if customers who buy a "Kitchen" item from this seller are likely to return and buy a "Tool" from them as well.

Onboarding & Support Strategy: High-category sellers have different needs than specialists. They might require bulk-upload tools, multi-category advertising credits, or more advanced inventory management software integrations.
*/

-- Question 23 Find sellers who sell in more than 5 categories. --
SELECT 
    oi.seller_id,
    COUNT(DISTINCT p.product_category_name) AS category_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT p.product_category_name) > 5
ORDER BY category_count DESC;

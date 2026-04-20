/* 
This query is a sophisticated example of Category-Level Performance Benchmarking. It is used to identify the "Category Leaders"—the specific products that dominate their respective niches.

Why Analysts Use This Query:
Inventory Prioritization: It tells the business which specific SKU (Stock Keeping Unit) is the most critical for each department. If the "Top Product" in the Electronics category goes out of stock, it will have a much larger impact on revenue than any other item.

Merchandising & Placement: On an e-commerce website, these products are the "Best Sellers." Marketing teams use this list to decide which products should be featured on category landing pages or in "Recommended for You" carousels.

Competitive Intelligence: By identifying the top product, analysts can investigate why it is winning. Is it the price? The quality (reviews)? The shipping speed? These insights are then applied to other products in the same category to lift their performance.

Supplier Negotiations: If one product is generating the vast majority of revenue in a category, the business has significant leverage to negotiate better wholesale prices or exclusive deals with that specific supplier.

Price Elasticity Testing: Analysts often use these "top" products to test price changes. Since they have the highest volume, even a small price adjustment provides a large amount of data to see how sensitive customers are to cost.
*/

-- Question 20 Find top product in each category by revenue.--
WITH product_revenue AS (
    SELECT 
        p.product_id,
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.product_category_name
),
ranked_products AS (
    SELECT *,
        RANK() OVER (PARTITION BY product_category_name ORDER BY revenue DESC) AS rnk
    FROM product_revenue
)

SELECT *
FROM ranked_products
WHERE rnk = 1;

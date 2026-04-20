/*
This query is used for Premium Segment Identification. It allows a business to separate its "high-ticket" or "luxury" categories from its high-volume, low-margin products.

Why Analysts Use This Query:
Identifying Upscale Markets: It pinpoints which categories naturally command more money per transaction. This helps management decide where to focus "premium" branding efforts.

Shipping & Logistics Strategy: High AOV categories often involve heavier or more expensive items (like furniture or high-end electronics). Knowing these categories helps in planning specialized shipping insurance or white-glove delivery services.

Marketing Allocation: If a category has a much higher AOV than the average, the business can afford a higher Cost Per Acquisition (CPA). You can spend more on ads for a $500 category than a $20 category.

Discount Sensitivity: Categories with high AOVs are often less sensitive to small shipping costs but more sensitive to percentage-based discounts. This data helps in fine-tuning promotional offers.

Product Development: It provides a signal for expansion. If "Home Decor" has a high AOV, the company might decide to source more high-end sub-categories within that space.
*/
-- Question 21 Identify categories where average order value is higher than overall AOV.--
WITH category_aov AS (
    SELECT 
        t.product_category_name,
        AVG(order_total) AS category_avg_order_value
    FROM (
        SELECT 
            oi.order_id,
            p.product_category_name,
            SUM(oi.price + oi.freight_value) AS order_total
        FROM order_items oi
        JOIN products p ON oi.product_id = p.product_id
        GROUP BY oi.order_id, p.product_category_name
    ) t
    GROUP BY t.product_category_name
)

SELECT *
FROM category_aov
WHERE category_avg_order_value > (
    SELECT AVG(price + freight_value) FROM order_items
);
   

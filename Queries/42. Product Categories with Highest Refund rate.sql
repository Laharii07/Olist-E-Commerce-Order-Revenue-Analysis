/*
This query is used for Product Quality Control and Category Risk Management. In e-commerce, a "sale" isn't a success until the product stays in the customer's hands. Identifying categories with high cancellation or refund rates is essential for protecting your profit margins.

Why Analysts Use This Query:
Identifying "Problem" Products: High refund rates in specific categories often point to structural issues—like poor sizing charts in "Apparel," fragile items in "Home Decor" that break during shipping, or misleading product descriptions in "Electronics."

Optimizing Logistics: If certain categories are frequently canceled, it might indicate that the estimated delivery time is too long, causing "buyer's remorse" before the item even arrives.

Adjusting Insurance and Fees: Marketplaces often charge higher commission fees or require extra insurance for "high-risk" categories to cover the administrative costs of processing frequent returns and refunds.

Supplier Accountability: Analysts use this data to have "tough conversations" with sellers. If a seller’s products are consistently refunded, they may be flagged for removal to protect the platform's reputation.

Net Revenue Forecasting: Financial teams use these rates to calculate "Expected Net Revenue." If you sell $1M in "Watches" but the refund rate is 20%, you only actually have $800k to work with.

*/

-- Question 42 Which product categories have highest refund rate? --
WITH category_orders AS (
    SELECT 
        p.product_category_name,
        o.order_status
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
)

SELECT 
    product_category_name,
    COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) * 100.0 
        / COUNT(*) AS refund_rate
FROM category_orders
GROUP BY product_category_name
ORDER BY refund_rate DESC;

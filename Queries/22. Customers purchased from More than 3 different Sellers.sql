/* 
This query is used for E-commerce Platform Stickiness and Ecosystem Diversity Analysis. It identifies "Explorer" customers who aren't just loyal to one brand or shop, but are deeply integrated into your entire marketplace.

Why Analysts Use This Query:
Measuring Platform Trust: A customer who buys from four or more different sellers has high confidence in the platform itself. They trust your escrow, shipping, and dispute resolution systems regardless of who the individual merchant is.

Customer Loyalty vs. Brand Loyalty: It helps distinguish between someone who only buys from one specific store (Brand Loyal) and someone who uses your app as their primary shopping destination (Platform Loyal).

Recommendation Engine Validation: Analysts use this to check if their "Cross-Sellers" or "Discovery" algorithms are working. If this segment of customers is growing, it means your site is successfully encouraging users to explore new shops.

Risk Management: Customers who interact with many sellers provide a broad "stress test" for the platform. If these power users suddenly stop buying, it usually indicates a systemic issue with the app experience rather than a problem with one specific seller.

VIP Profiling: These are your most valuable users for feedback. Because they have experience with multiple sellers, they can provide the most accurate comparisons regarding shipping speeds and packaging quality across your ecosystem.
*/
-- Question 22 Find customers who purchased from more than 3 different sellers.--
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT oi.seller_id) AS seller_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT oi.seller_id) > 3
ORDER BY seller_count DESC;

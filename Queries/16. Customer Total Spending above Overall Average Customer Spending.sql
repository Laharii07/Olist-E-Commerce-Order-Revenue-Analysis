/*
This query is used for High-Value Segment Identification. It moves beyond looking at the "Top 10" and instead identifies the entire population of customers who contribute more than the "average" amount to your business.

Why Analysts Use This Query:
Defining the "Ideal" Customer: It creates a benchmark for success. Anyone in this list is considered a "better than average" customer, making them the primary target for retention campaigns.

Customer Tiering: This is the first step in creating a Gold/Silver/Bronze loyalty tier. Customers above the average are usually moved into the "Gold" or "Premier" bucket for special treatment.

Pareto Analysis: Analysts use this to see what percentage of the total customer base is "Above Average." In many businesses, only 20-30% of customers fall into this category, but they often generate 70-80% of the total revenue.

Marketing Focus: Marketing teams use this list for "Lookalike Modeling." By taking the emails of these high-spenders and feeding them into ad platforms (like Meta or Google), you can find new potential customers with similar profiles.

Revenue Concentration Risk: It helps the business understand how much it relies on its "big spenders." If the average is heavily skewed by a few massive spenders, the business might be too dependent on a small group.
*/

-- Question 16 Find customers whose total spending is above overall average customer spending.--
WITH customer_spending AS (
    SELECT 
        c.customer_unique_id,
        SUM(oi.price + oi.freight_value) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)

SELECT *
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent) FROM customer_spending
)
ORDER BY total_spent DESC;

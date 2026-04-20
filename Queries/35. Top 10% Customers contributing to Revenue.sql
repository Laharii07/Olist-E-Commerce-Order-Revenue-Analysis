/* 
This query is the classic implementation of the Pareto Principle (The 80/20 Rule). In almost every e-commerce business, a tiny fraction of the customer base generates a massive majority of the revenue. Finding that top 10% isn't just about data—it's about survival and growth.

Why Analysts Use This Query:
Protecting the "Core": This top 10% are your "VIPs." If even a handful of these customers stop shopping (churn), it has a much larger impact on your bank account than losing 1,000 customers from the bottom 10%. Analysts use this list to set up "Priority Support" for these users.

Customer Lifetime Value (CLV) Modeling: By studying the behavior of this specific group, analysts can identify the "pathway" to becoming a high-value customer. Did they start with a specific category? Did they use a specific payment method?

Whale Hunting (Marketing Strategy): Instead of spending marketing dollars on everyone, the "Growth Team" uses this list to create "Lookalike Audiences" on platforms like Facebook and Google. They tell the algorithm: "Find me more people who look and act exactly like these 10%."

Loyalty Program ROI: If you have a loyalty program, you run this query to see if the members of that program actually make it into the top 10%. If they don't, your loyalty incentives might be targeting the wrong behaviors.

Direct Feedback Loops: Product managers often reach out to this specific group for 1-on-1 interviews or beta testing. Their feedback is weighted more heavily because they are the ones actually funding the platform's operations.
*/

-- Question 35 Find top 10% customers contributing to revenue.--
WITH customer_spending AS (
    SELECT 
        c.customer_unique_id,
        SUM(oi.price + oi.freight_value) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
),
ranked_customers AS (
    SELECT *,
        NTILE(10) OVER (ORDER BY total_spent DESC) AS percentile_group
    FROM customer_spending
)

SELECT *
FROM ranked_customers
WHERE percentile_group = 1;

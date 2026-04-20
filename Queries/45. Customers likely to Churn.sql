/*
This query is a classic Win-Back Analysis. In e-commerce, it’s much cheaper to keep an existing customer than to acquire a new one. Identifying "dormant" users who haven't shopped in 180 days allows the marketing team to trigger automated re-engagement campaigns.

Why Analysts Use This Query:
Triggering Automated Email Flows: This list is usually synced with a CRM (like Braze or Klaviyo) to send "We miss you" emails, often containing a "personalized discount" to incentivize a return.

Predicting Future Revenue: By calculating the size of this "at-risk" group, finance teams can adjust their revenue projections. If a large portion of the active database is moving into the churned category, it’s a leading indicator of a future revenue dip.

Segmenting "Lost" vs. "Lapsed" Customers: Analysts often differentiate between those who haven't bought in 6 months (Lapsed) versus 2 years (Lost). The strategy for a 6-month churner is often a product reminder, while a 2-year churner might need a massive discount to re-introduce the brand.

Product Feedback Loops: If a specific group of customers all churned around the same time, analysts investigate: Did we change the UI? Did we increase shipping prices? Did a competitor launch a better service?

Technical Insight: The "Current Date" Logic
You used GETDATE() combined with DATEADD, which is the correct dynamic approach for a production environment.

MAX(order_purchase_timestamp): This ensures you are looking at the customer's most recent interaction.

The 6-Month Window: While 6 months is the industry standard for general retail, seasonal businesses (like swimwear or holiday decor) might use 12 months to avoid mislabeling "seasonal" shoppers as "churned."
*/

-- Question 45 Identify customers likely to churn (no purchase in last 6 months).--
WITH last_purchase AS (
    SELECT 
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_order_date
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT *
FROM last_purchase
WHERE last_order_date < DATEADD(month, -6, GETDATE());

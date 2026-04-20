/*
This query is used for Cohort Retention Analysis. In the world of growth hacking and marketing, this is the gold standard for measuring "Product-Market Fit." If people come back in a different month, you aren't just a one-time convenience—you are a habit.

Why Analysts Use This Query:
Measuring True Loyalty: Many customers place multiple orders in a single day (e.g., they forgot an item and went back to buy it). This query filters out those "one-day spikes" and identifies customers with a sustained, long-term relationship with the brand.

Calculating Retention Rate: This is the numerator for your Retention KPI. Analysts use this list to see what percentage of last month's customers returned this month.

Predicting Customer Lifetime Value (CLV): A "multi-month" customer is statistically more likely to keep spending in the future. Identifying them allows the finance team to build more accurate long-term revenue models.

Evaluating Marketing Campaigns: If you ran a "Welcome Discount" in January, you'd run this query in March to see if those new customers actually stuck around after the discount was gone.

Identifying "Power Users" for Referral Programs: Customers who shop across multiple months are the best candidates for "Refer a Friend" programs because they have enough experience with the platform to be credible advocates.
*/

-- Question 24 Identify repeat customers (ordered in more than 1 month). -- 
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT FORMAT(o.order_purchase_timestamp, 'yyyy-MM')) AS active_months
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT FORMAT(o.order_purchase_timestamp, 'yyyy-MM')) > 1
ORDER BY active_months DESC;

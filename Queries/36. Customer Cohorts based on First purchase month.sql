/*
This query is the fundamental "Source of Truth" for Retention and Lifetime Value (LTV) Analysis. By assigning every customer to a specific "birth month," you transition from looking at your business as a single mass to looking at it as a series of evolving generations.

Why Analysts Use This Query:
Measuring Acquisition Quality: Not all months are created equal. Customers who joined during a massive "50% Off" sale in November might behave differently (and spend less over time) than customers who joined organically in March. Cohorts allow you to compare these groups side-by-side.

Calculating Churn Rate: Once you have your cohorts, you can track them over time. If the "January 2024" cohort had 1,000 people and only 200 bought something in February, you have a clear starting point for calculating your monthly churn.

Forecasting Future Revenue: If you know that a typical cohort spend $5,000 in month one and $1,000 in month two, you can accurately predict your revenue for the next month based on the number of new sign-ups you have today.

Evaluating Product Changes: If you launched a major app redesign in June, you would compare the behavior of the "July Cohort" (new users) against the "May Cohort" (old users) to see if the changes actually improved long-term engagement.

Marketing Efficiency (CAC/LTV): By knowing which cohort a customer belongs to, you can link them back to the specific marketing spend of that month to see if you are actually making a profit on your acquisition costs.

*/
-- Question 36 Create customer cohorts based on first purchase month.--
WITH first_purchase AS (
    SELECT 
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_purchase_date
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT 
    customer_unique_id,
    FORMAT(first_purchase_date, 'yyyy-MM') AS cohort_month
FROM first_purchase
ORDER BY cohort_month;

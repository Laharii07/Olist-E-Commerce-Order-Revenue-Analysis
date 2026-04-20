/*
This query is the "Holy Grail" of Subscription and E-commerce Analytics. It moves beyond identifying who joined when and actually measures the survival rate of your customer base over time.

Why Analysts Use This Query:
Identifying the "Leaky Bucket": This query tells you exactly when customers stop coming back. If retention drops from 80% in Month 1 to 5% in Month 2, you have a massive "onboarding" problem that needs fixing.

Calculating Product-Market Fit: A "healthy" business eventually sees its retention rate flatten out (e.g., sticking at 10% indefinitely) rather than hitting zero. This "long tail" represents your core, loyal user base.

Comparing Marketing Quality: You can see if the "Christmas Cohort" (December) has better long-term retention than the "Black Friday Cohort" (November). This helps you decide which holiday promotions actually bring in "high-quality" customers versus "deal-hunters."

Determining LTV (Lifetime Value): By seeing the rate at which customers decay, finance teams can predict how much revenue a new customer will generate over their entire lifespan.

Measuring Feature Impact: If you launched a loyalty program in March, you would look at the April and May cohorts to see if their retention rates are higher than the January and February cohorts.
*/


-- Question 37 Calculate cohort retention rate month-by-month.--
WITH cohort_data AS (
    SELECT 
        c.customer_unique_id,
        FORMAT(MIN(o.order_purchase_timestamp) OVER 
            (PARTITION BY c.customer_unique_id), 'yyyy-MM') AS cohort_month,
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
),
cohort_counts AS (
    SELECT 
        cohort_month,
        order_month,
        COUNT(DISTINCT customer_unique_id) AS customers
    FROM cohort_data
    GROUP BY cohort_month, order_month
),
cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT customer_unique_id) AS total_customers
    FROM cohort_data
    WHERE cohort_month = order_month
    GROUP BY cohort_month
)

SELECT 
    cc.cohort_month,
    cc.order_month,
    cc.customers,
    cs.total_customers,
    cc.customers * 100.0 / cs.total_customers AS retention_rate
FROM cohort_counts cc
JOIN cohort_size cs 
    ON cc.cohort_month = cs.cohort_month
ORDER BY cc.cohort_month, cc.order_month;

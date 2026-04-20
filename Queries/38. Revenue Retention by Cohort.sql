/*

This query calculates Net Revenue Retention (NRR). While your previous query tracked people, this one tracks the money. In many ways, this is the more important metric for a CFO because it accounts for "expansion" (people spending more over time) versus "contraction" (people spending less).

Why Analysts Use This Query:
Measuring "Quality of Growth": You might have 100% customer retention, but if those customers are spending 50% less each month, your business is in trouble. This query reveals the actual financial health of each cohort.

Identifying High-Value Cohorts: Some months might bring in fewer customers, but those customers might be "high spenders" who retain a higher percentage of their initial revenue. This helps marketing shift focus from "quantity" to "quality."

Expansion Analysis: If your revenue_retention ever goes above 100%, you have achieved "Negative Churn." This means the existing customers in that cohort are increasing their spending so much that they are outperforming the revenue lost from customers who left.

Sustainability Modeling: This provides the data needed to calculate the LTV to CAC ratio. If you know a cohort retains 20% of its revenue for 2 years, you can determine exactly how much you can afford to spend to acquire those customers in the first place.

Investor Reporting: NRR is a primary metric for SaaS and e-commerce valuations. Investors look for stable or increasing revenue retention as a sign of a "sticky" product that provides long-term value.

Technical Insight: The "Money" vs. "Headcount"
This query follows the same logical structure as the customer retention query but swaps COUNT(DISTINCT ID) for SUM(revenue).

The Inclusion of Freight: By including freight_value, you are looking at Gross Revenue. If you wanted to look at Product Revenue, you would remove freight.

The Baseline (initial_revenue): This CTE isolates the "Day 0" revenue. It is the "100%" mark that every future month is compared against.

*/


-- Question 38 Calculate revenue retention by cohort.--
WITH cohort_data AS (
    SELECT 
        c.customer_unique_id,
        FORMAT(MIN(o.order_purchase_timestamp) OVER 
            (PARTITION BY c.customer_unique_id), 'yyyy-MM') AS cohort_month,
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month,
        oi.price + oi.freight_value AS revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
),
cohort_revenue AS (
    SELECT 
        cohort_month,
        order_month,
        SUM(revenue) AS total_revenue
    FROM cohort_data
    GROUP BY cohort_month, order_month
),
initial_revenue AS (
    SELECT 
        cohort_month,
        SUM(revenue) AS first_month_revenue
    FROM cohort_data
    WHERE cohort_month = order_month
    GROUP BY cohort_month
)

SELECT 
    cr.cohort_month,
    cr.order_month,
    cr.total_revenue,
    ir.first_month_revenue,
    cr.total_revenue * 100.0 / ir.first_month_revenue AS revenue_retention
FROM cohort_revenue cr
JOIN initial_revenue ir 
    ON cr.cohort_month = ir.cohort_month
ORDER BY cr.cohort_month, cr.order_month;

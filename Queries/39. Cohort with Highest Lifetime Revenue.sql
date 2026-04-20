/*
This query identifies the "Power Cohort." While retention and growth rates are important, this query tells you which specific month’s intake of new customers ultimately put the most total cash into the company's bank account.

Why Analysts Use This Query:
Identifying "Vintage" Quality: In business, some years or months are simply better than others. This query helps you look back at your "best" month and investigate what happened: Was it a legendary marketing campaign? A seasonal peak? Or a specific viral product that brought in high-spenders?

Long-Term Value Assessment: It measures the Cumulative Worth of a cohort. A cohort that started small but has high retention might eventually generate more lifetime revenue than a massive "one-hit wonder" cohort that churned immediately.

Budget Justification: If the marketing team spent $100k in January 2024 and that cohort shows up as the #1 lifetime revenue generator, they have clear evidence to justify similar budgets in the future.

Resource Prioritization: If you know certain "Vintages" (cohorts) are massive contributors to your bottom line, you might treat the surviving members of those cohorts with extra care (e.g., dedicated account managers or exclusive loyalty perks).

Historical Benchmarking: This becomes the "number to beat." Every new cohort's performance is measured against the record set by the all-time highest-grossing cohort.

Technical Insight: The "Time Bias" Warning
When interpreting this result, there is one major factor to keep in mind: Time.

The Advantage of Age: Older cohorts (e.g., from 2023) have had more months to spend money than a cohort that just started last month.

Interpretation: If a "young" cohort (only 3 months old) is already ranking near the top of the lifetime revenue list, it is an incredible signal that your acquisition quality or product-market fit has drastically improved.
*/


-- Question 39 Identify which cohort generated highest lifetime revenue.--
WITH cohort_data AS (
    SELECT 
        c.customer_unique_id,
        FORMAT(MIN(o.order_purchase_timestamp) OVER 
            (PARTITION BY c.customer_unique_id), 'yyyy-MM') AS cohort_month,
        oi.price + oi.freight_value AS revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
)

SELECT TOP 1
    cohort_month,
    SUM(revenue) AS lifetime_revenue
FROM cohort_data
GROUP BY cohort_month
ORDER BY lifetime_revenue DESC;

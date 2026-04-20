/*
This query is used for Cumulative Financial Tracking (Running Totals). It is one of the most important reports for leadership because it shows the "Year-to-Date" or "Lifetime" progress of the company rather than just isolated monthly performance.

Why Analysts Use This Query:
Pacing Toward Goals: Companies set annual revenue targets (e.g., "$10M in 2026"). This query allows stakeholders to see exactly how close they are to that target at any given moment in the year.

Visualizing Growth Curves: A cumulative revenue chart typically forms an "S-curve" or a steady upward slope. Analysts look for changes in the steepness of this curve—a steeper line indicates accelerating growth, while a flattening line signals a slowdown.

Burn Rate & Break-even Analysis: For startups or expanding businesses, comparing cumulative revenue against cumulative costs helps determine the "break-even point"—the exact month when the company finally made more money than it spent.

Investor Reporting: Investors rarely look at one month in isolation. They want to see the total "Gross Merchandise Volume" (GMV) the platform has processed over its lifetime to understand its scale and market share.

Seasonality Smoothing: While monthly revenue can be "noisy" (spiking in December and dropping in January), cumulative revenue provides a smoother view of the business's overall health and momentum.
*/

-- Question 28 Calculate running monthly revenue (cumulative revenue). --
WITH monthly_revenue AS (
    SELECT 
        YEAR(o.order_purchase_timestamp) AS yr,
        MONTH(o.order_purchase_timestamp) AS mn,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        YEAR(o.order_purchase_timestamp),
        MONTH(o.order_purchase_timestamp)
)

SELECT *,
    SUM(revenue) OVER (ORDER BY yr, mn) AS cumulative_revenue
FROM monthly_revenue
ORDER BY yr, mn;

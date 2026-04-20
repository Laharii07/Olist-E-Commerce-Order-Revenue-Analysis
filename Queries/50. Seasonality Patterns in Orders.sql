/*
This query is the foundation of Demand Forecasting and Operational Planning. Seasonality is the "heartbeat" of e-commerce; understanding these cyclical patterns allows a business to move from being reactive to being proactive.

Why Analysts Use This Query:
Inventory & Stock Planning: If the data shows a 40% spike every November (Black Friday/Cyber Monday), the purchasing team knows exactly when to ramp up inventory levels to avoid "Out of Stock" notices.

Staffing & Resource Allocation: Logistics centers and customer support teams use seasonality curves to plan their hiring. You don't want to be understaffed during the December rush or overstaffed during the "February Lull."

Marketing Budget Distribution: If certain months consistently underperform, a company might choose to either "lean in" with heavy promotions to bridge the gap or save their ad spend for high-conversion months to maximize ROAS (Return on Ad Spend).

Financial Goal Setting: Seasonality explains why a "dip" in sales from December to January isn't necessarily a sign of business failure, but rather a standard market correction. It helps stakeholders set realistic targets for each month.

Identifying External Anomalies: Once you know your "normal" seasonal pattern, you can easily spot "unnatural" spikes or dips caused by external events like a viral social media trend or a global supply chain disruption.
*/

-- Question 50 Detect seasonality patterns in orders.--
SELECT 
    FORMAT(order_purchase_timestamp, 'yyyy-MM') AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY FORMAT(order_purchase_timestamp, 'yyyy-MM')
ORDER BY month;

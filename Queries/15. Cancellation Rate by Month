/*
This query is used for Operational Health and Risk Monitoring. In e-commerce, a "canceled" order is more than just lost revenue; it often indicates a failure in the customer experience or a technical glitch.

Why Analysts Use This Query:
Identifying System Failures: A sudden spike in the cancellation rate in a specific month can signal a technical bug in the payment gateway or an inventory syncing error (selling items that are out of stock).

Assessing Marketing Quality: If cancellations rise during a big sale month, it may suggest that the marketing attracted "low-intent" users or that the discount codes were confusing.

Supply Chain Stress Testing: During peak seasons like Black Friday, this query monitors if the fulfillment team is overwhelmed, leading to orders being canceled due to long delays.

Fraud Detection: Abnormally high cancellation rates in certain periods can be a red flag for credit card testing or "bot" activity on the site.

Policy Impact Analysis: If the company changes its cancellation or return policy, this query acts as the "before and after" check to see how customer behavior responded.
*/
-- Question 15 Calculate cancellation rate by month.--
select
year(order_purchase_timestamp) as order_year,
month(order_purchase_timestamp) as order_month,
count(case when order_status = 'cancled' then 1 end ) *100.0/
	count(*) as cancellation_rate
from orders
group by
year(order_purchase_timestamp),
month(order_purchase_timestamp)
order by 
order_year,
order_month;

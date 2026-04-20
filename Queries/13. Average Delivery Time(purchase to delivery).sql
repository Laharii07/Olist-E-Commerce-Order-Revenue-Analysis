/*
This query calculates the Lead Time or Order-to-Delivery Cycle Time.
In the world of logistics, this is the most direct measurement of how "fast" your company actually is from the customer's perspective.
Why Analysts Use This Query:
Customer Satisfaction Benchmarking: Shipping speed is the #1 driver of positive reviews. Knowing the average allows the business to set "Expectation Management" goals (e.g., "Most orders arrive in 5 days").
Carrier Performance Evaluation: By breaking this down further, analysts can see which shipping companies are meeting their speed targets and which are causing bottlenecks.
Operational Health Check: If this average starts to rise, it acts as an early warning system for warehouse staffing issues, inventory mismanagement, or courier delays.
Competitive Analysis: Businesses compare this number against competitors (like Amazon’s 1-2 day standard) to determine if they need to invest more in localized distribution centers.
Marketing Accuracy: This data provides the "proof" for marketing claims. If you want to advertise "Fast Shipping," this query provides the factual evidence to back up that claim.

*/
-- Question 13 Calculate average delivery time (purchase to delivery). --
select 
avg(datediff(day, order_purchase_timestamp,  order_delivered_customer_date))
as avg_delivery_days
from orders
where order_delivered_customer_date is not null;

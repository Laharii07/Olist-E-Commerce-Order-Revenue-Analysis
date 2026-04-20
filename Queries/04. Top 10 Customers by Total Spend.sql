/* This query is used for Customer Segmentation and Value Analysis.

1. Identifying "Whales" (High-Value Customers)
In many businesses, the Pareto Principle (the 80/20 rule) applies: a small percentage of customers often account for a large portion of the revenue.
VIP Programs: Identifying these top 10 individuals allows a marketing team to enroll them in exclusive loyalty programs or offer personalized "concierge" services.
Retention: These are the customers you absolutely cannot afford to lose. Analysts use this list to monitor if these high-spenders stop purchasing (churn).

2. Understanding Purchasing Power
By looking at the total_spend, you can determine the upper limit of what your most loyal customers are willing to pay.
If the top spender has spent $10,000 while the average is $100, you have a highly skewed distribution that requires a different marketing strategy than a business where everyone spends roughly the same.

3. Customer Lifetime Value (CLV)
This query is the foundational step in calculating Customer Lifetime Value.
Total Spend is the "LTV" part of the equation.
By identifying who spends the most, you can look back at their history to see which acquisition channel brought them in (e.g., did they come from a Google Ad or an Organic search?). 
This helps determine which marketing channels produce the highest "quality" customers.

4. Data Validation and Outlier Detection
Sometimes, the top spenders aren't actually "customers" in the traditional sense. This query helps spot:
Resellers: If one "unique_id" has spent 50x more than the runner-up, they might be a B2B reseller rather than a standard consumer.
Data Errors: It can reveal testing accounts or system errors where a transaction was duplicated.

*/
-- Question -4 Find top 10 customers by total spend.--

Select top 10
	c.customer_unique_id,
	sum(oi.price + oi.freight_value) as total_spend
from orders o
join customers c
	on o.customer_id = c.customer_id
join order_items oi
	on o.order_id = oi.order_id
group by
	c.customer_unique_id
order by 
	total_spend desc;

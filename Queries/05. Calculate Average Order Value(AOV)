/* 
While total revenue tells you how much money is coming in, AOV tells you how much each individual transaction is worth.
1. Measuring Marketing Efficiency
AOV is a direct lever for profitability. If your Customer Acquisition Cost (CAC) is $20, but your AOV is only $15, you are losing money on every order.
The Goal: Analysts track AOV to ensure it stays significantly higher than the cost to get the customer through the door.

2. Evaluating Pricing and Upselling Strategies
This query serves as a "before and after" snapshot for business tactics:
Bundling: If you start offering "Buy 2, Get 10% Off," you would run this query to see if the AOV actually increases.
Free Shipping Thresholds: Many stores offer free shipping on orders over $50. 
This query helps you see if your current AOV is hovering just below that mark, 
suggesting you should move the threshold to nudge customers to add one more item to their cart.

3. Understanding Customer Behavior
A high AOV usually indicates one of two things:
You sell high-ticket luxury items.
Your customers are buying multiple items per transaction.
*/
-- Question -5 Calculate average order value (AOV).--

Select 
	avg(order_total) as avg_order_value
from (
	select
		order_id,
		sum(price + freight_value) as order_total
	from order_items
	group by order_id
) as order_values;

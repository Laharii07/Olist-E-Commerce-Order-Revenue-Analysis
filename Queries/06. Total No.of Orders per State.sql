/*
This query is used for Geographic Market Analysis to identify where your business is most successful. 
Here are the five key reasons why analysts use it:
Market Penetration: It identifies your strongest and weakest regions, showing where your brand has successfully captured the local market.
Logistics Optimization: High order volumes in specific states suggest where you should locate warehouses or distribution centers to reduce shipping times.
Targeted Marketing: It allows marketing teams to allocate ad spend more efficiently by targeting high-performing states or boosting underperforming ones.
Resource Allocation: It helps the business decide where to prioritize localized customer support, physical storefronts, or regional partnerships.
Policy & Tax Planning: Tracking order volume by state is essential for managing state-specific sales tax compliance and regional shipping regulations.
*/

-- Question -6 Find total number of orders per state.--
Select
	c.customer_state,
	count(distinct o.order_id) as total_orders
from orders o
join customers c
	 on o.customer_id = c.customer_id
group by c.customer_state
order by total_orders Desc;

/*
This query is used for Loyalty Identification and Heavy-User Profiling. 
While many customers are "one-and-done" shoppers,
this query extracts the core group of people who are truly committed to the brand.
Why Analysts Use This Query:
Identifying Power Users: It isolates your most loyal customer segment.
In e-commerce, these customers are often the "vocal minority" who provide the most feedback and drive organic word-of-mouth marketing.
Predicting Churn Risk: By identifying who should be ordering frequently, 
the business can set up alerts. If a customer who usually places 10 orders a year suddenly stops,
it’s a signal for the customer success team to reach out with a win-back offer.
Refining Customer Acquisition: Analysts look at these "5+ order" customers to see where they came from. 
If most loyalists were acquired via email marketing rather than social media ads, 
the company will shift its budget toward email.
Subscription Feasibility: If a large number of customers appear in this list, 
it provides a strong business case for launching a subscription model or a "Prime-style" membership.
Testing Loyalty Programs: This list serves as the "control group" or
the "invite list" for beta-testing new loyalty rewards or early access to sales.
*/
-- Question 12 Find customers who placed more than 5 orders.--
select
c.customer_unique_id,
count(o.order_id) as total_orders
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.customer_unique_id
having count(o.order_id) >5
order by total_orders desc;

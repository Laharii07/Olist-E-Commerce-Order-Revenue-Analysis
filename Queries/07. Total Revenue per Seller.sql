/*
This query is used for Marketplace Performance Auditing. In a multi-seller ecosystem, this is the primary way to evaluate the "supply side" of your business.
Here are the key reasons for running this analysis:
Identifying Key Partners: Much like finding your top customers, this identifies the "Power Sellers"
who generate the lion's share of your platform's revenue.
Commission & Payout Management: It serves as the basis for financial reconciliation, 
ensuring you know exactly how much gross volume each seller has moved for tax and payout purposes.
Seller Tiering: Businesses use this data to categorize sellers into tiers (e.g., Gold, Silver, Bronze), 
granting top performers perks like lower commission rates or better search visibility.
Risk Detection: If a single seller has an unnaturally high revenue compared to others, 
it can flag potential fraudulent activity or highlight a "single point of failure" in your supply chain.
Churn Prevention: By monitoring these totals over time, you can spot when a top-performing seller's revenue begins to drop,
allowing you to intervene before they leave the platform.

*/

-- Question -7 Find total revenue per seller.--

select 
	s.seller_id,
	sum(oi.price+oi.freight_value) as revenue
from order_items oi
join sellers s 
	on s.seller_id = oi.seller_id
group by 
	s.seller_id
order by 
	revenue desc;

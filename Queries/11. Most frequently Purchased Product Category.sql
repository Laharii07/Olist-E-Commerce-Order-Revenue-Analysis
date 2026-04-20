/*
This query is used for Product Demand Analysis and Inventory Planning.
While revenue tells you where the money is, "purchase count" tells you what your customers actually want most frequently.
Identifying "Hero" Products: It pinpoints your most popular category, 
which serves as the primary "entry point" for new customers coming to your platform.
Inventory & Stock Management: High-frequency categories require the most aggressive restocking schedules and
warehouse space to avoid "Out of Stock" scenarios.
Optimizing Logistics: Knowing your high-volume categories helps in organizing warehouse
layouts—placing these items closer to packing stations to reduce "pick-and-pack" time.
Marketing Focus: This identifies the best category for "top-of-funnel" advertisements, 
as it has the highest proven appeal to the general customer base.
Cross-Selling Opportunities: Once you know what people buy most, 
you can design "frequently bought together" bundles to move slower-selling items alongside these popular products.
*/

-- Question - 11 Find the most frequently purchased product category.--
select Top 1
	 p.product_category_name,
	 count(*) as purchase_count
from order_items oi
join products p
	on oi.product_id = p.product_id
group by
	p.product_category_name
order by
	purchase_count desc;

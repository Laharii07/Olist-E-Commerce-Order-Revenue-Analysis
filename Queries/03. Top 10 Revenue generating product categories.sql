/* Analyzing the top 10 revenue-generating product categories is a fundamental business strategy
used to maximize profitability, optimize resources, and drive strategic growth.
By focusing on the categories that drive the majority of income, businesses can gain actionable insights 
into customer demand, streamline operations, and make informed decisions about product mix, pricing, and marketing, often 
relying on the principle that a small percentage of products often generates the majority of sales (similar to the 80/20 rule)
*/

-- Find top 10 revenue-generating product categories.
Select 
  Top 10 sum(oi.price + oi.freight_value) as Revenue , 
  p.product_category_name
from order_items oi
join products p on oi.product_id = p.product_id
group by p.product_category_name
order by revenue desc


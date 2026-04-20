/* Monthly revenue Trend is a fundamental tool for Time-Series Analysis.Monthly Gross Revenue, 
which is one of the most critical Key Performance Indicators (KPIs) for any retail or e-commerce business.
--Identifying Seasonality and Trends
By grouping data by year and month, you can visualize how sales fluctuate over time.
-- Financial Health Monitoring
The calculation sum(oi.price + oi.freight_value) provides the Total Gross Revenue (product price plus shipping).
This helps the business understand:
Cash Flow: How much money is actually coming into the system each month.
Budgeting: Provides historical data to help departments set targets for the following year
-- Impact Assessment
This query allows analysts to see the "before and after" of specific business events.
--Data Preprocessing for Advanced Analytics
*/

-- Question -2 Calculate monthly revenue trend (year + month).--
select 
	year(o.order_purchase_timestamp) as order_year,
	month(o.order_purchase_timestamp) as order_month,
	sum(oi.price +oi.freight_value) as monthly_revenue
from orders o
join order_items oi
	on o.order_id = oi.order_id
group by 
	year(o.order_purchase_timestamp),
	month(o.order_purchase_timestamp)
order by 
	order_year,
	order_month;

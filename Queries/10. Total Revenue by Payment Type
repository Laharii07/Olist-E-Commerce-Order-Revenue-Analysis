/*
This query is used for Payment Method Analysis and Financial Strategy.
It helps the business understand the "how" behind customer transactions, which has significant implications for cash flow and fees.
Transaction Cost Optimization: Different payment methods (Credit Card, Boleto, Voucher)carry different processing fees; 
this query helps calculate the total cost of payments and identify opportunities to nudge users toward cheaper methods.
Cash Flow Forecasting: Some methods (like vouchers or "Boleto") may have different settlement times than credit cards; 
understanding the revenue split helps the finance team predict when cash will actually hit the bank account.
Customer Preference Mapping: It reveals the preferred financial habits of your audience,
allowing you to tailor the checkout experience to the most popular methods.
Marketing & Promotion Planning: If "Vouchers" are a large portion of revenue,
it indicates that your promotional discount strategy is a major driver of sales.
Checkout Friction Reduction: If a high-revenue category suddenly drops, 
it might signal a technical issue with that specific payment gateway or API.
*/
-- Question - 10 Calculate total revenue by payment type.--
select 
	payment_type,
	sum(payment_value)as total_revenue
from order_payments
group by payment_type
order by total_revenue desc;

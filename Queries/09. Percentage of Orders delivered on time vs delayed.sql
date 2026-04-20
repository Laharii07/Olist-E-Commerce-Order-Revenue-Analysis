/*
This query is used for Logistics and Operational Performance Analysis. It measures the reliability of your fulfillment process, which is a primary driver of customer satisfaction.

Service Level Agreement (SLA) Monitoring: It tracks how well the shipping department or third-party carriers are meeting the promises made to the customer at checkout.

Customer Retention Predictor: High delay percentages are a "red flag" because late deliveries are one of the most common reasons customers stop shopping with a brand.

Carrier Accountability: This data allows you to hold shipping partners accountable; if the "Delayed" percentage is high, you may need to renegotiate contracts or switch providers.

Expectation Management: If delays are consistent, analysts use this to suggest more realistic (longer) estimated delivery dates to improve the customer experience.

Bottleneck Identification: It acts as a high-level health check—if the "Delayed" percentage spikes, it signals a breakdown in the supply chain, warehouse efficiency, or last-mile delivery.
*/

-- Question - 9 Find percentage of orders delivered on time vs delayed.--
SELECT
    CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date 
        THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders 
                        WHERE order_delivered_customer_date IS NOT NULL) AS percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY 
    CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date 
        THEN 'On Time'
        ELSE 'Delayed'
    END;

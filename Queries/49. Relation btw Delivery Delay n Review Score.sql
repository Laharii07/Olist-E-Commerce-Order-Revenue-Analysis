/*
This query is used for Customer Satisfaction (CSAT) Driver Analysis. It quantifies the "Trust Penalty" associated with broken promises. In e-commerce, the estimated delivery date is a contract with the customer; this query measures the exact cost of breaking that contract in terms of brand reputation.

Why Analysts Use This Query:
Quantifying the "Late Penalty": Analysts use this to see exactly how many "stars" are lost when a package is late. Usually, the difference is dramatic (e.g., a 4.8 average for on-time vs. a 2.1 for delayed). This helps justify investments in faster shipping or more realistic estimations.

Setting Realistic Expectations: If the "On Time" score is also low, the problem isn't the delivery speed—it's likely the product quality. If the "On Time" score is high but the "Delayed" score is abysmal, the business knows it must prioritize logistics over product improvements.

Refining Estimation Algorithms: If delayed orders consistently result in 1-star reviews, the data science team might "pad" the estimated delivery dates on the website. It is better to promise 5 days and deliver in 4 than to promise 3 and deliver in 4.

Predicting Churn: Customers who experience a "Delayed" status are statistically less likely to return. This query identifies a "high-risk" cohort that might need an automated apology coupon to prevent them from leaving the platform.

Carrier Accountability: By breaking this down further by carrier, analysts can see which shipping partners are damaging the brand's reputation the most.

Technical Insight: The "Truth" in the Dates
Your use of order_estimated_delivery_date as the benchmark is the most accurate way to measure customer sentiment.

Perception vs. Reality: A package that takes 10 days might get a 5-star review if the estimate was 12 days. A package that takes 3 days might get a 1-star review if the estimate was 2 days. Satisfaction is relative to the expectation set at checkout.

Filtering Completed Orders: By excluding NULL delivery dates, you ensure the review score is actually based on the completed experience, not just frustration with an item that hasn't arrived yet.
*/

-- Question 49 Analyze relationship between delivery delay and review score.--
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status,
    AVG(r.review_score) AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 'Delayed'
        ELSE 'On Time'
    END;

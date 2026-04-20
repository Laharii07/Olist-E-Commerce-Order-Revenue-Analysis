/*
This query is used for Seller Quality Benchmarking and Reputation Management. In a marketplace, identifying your "star" sellers is just as important as finding your top earners.

Why Analysts Use This Query:
Identifying Best Practices: By finding the top 5 sellers, analysts can study their operations (e.g., their packaging, communication, or shipping speed) to create "Best Practice" guides for other sellers on the platform.

Rewarding Excellence: These sellers are often given "Top Rated" badges or prioritized in search results, which builds buyer trust and encourages other sellers to improve their service.

Improving Marketplace Trust: Keeping a pulse on high-rated sellers helps the platform ensure that the "face" of the brand—the people fulfilling the orders—is maintaining a high standard of quality.

Internal Promotion: Marketing teams use this list to select partners for "Featured Seller" spotlights or social media collaborations, knowing these sellers are unlikely to provide a bad experience for a new customer.

Incentive Programs: This data can be used to determine eligibility for reduced commission fees or other performance-based rewards.
*/
-- Question 14 Find top 5 sellers with highest average review score. --
select top 5 
s.seller_id,
avg(r.review_score) as avg_review_score
from order_reviews r
join orders o
on r.order_id = o.order_id
join order_items oi
on o.order_id = oi.order_id
join sellers s
on oi.seller_id = s.seller_id
group by s.seller_id
order by avg_review_score  Desc;

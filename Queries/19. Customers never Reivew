/*
This query is used for Engagement Gap Analysis. While your previous query looked for products without feedback, this one focuses on identifying the "Silent Majority" of your customer base.

Why Analysts Use This Query:
Sentiment Bias Correction: People are statistically more likely to leave a review when they are either extremely happy or extremely angry. By identifying those who never leave reviews, analysts find the "neutral" customers whose opinions are missing from the data.

Targeted Re-Engagement: Marketing teams use this list to send specific post-purchase surveys. Unlike a public review, a private survey might encourage these "silent" customers to provide honest feedback.

Trust Building: A customer who hasn't reviewed an item is a missed opportunity for "Social Proof." Identifying them allows the business to offer incentives (like a 10% discount on their next order) in exchange for their first review.

Analyzing Friction: If a specific segment of customers (e.g., those using a certain payment method or from a certain region) consistently fails to leave reviews, it might indicate a technical friction point in the app's review prompt system.

Customer Lifetime Value (CLV) Correlation: Analysts compare the spending habits of "Reviewers" vs. "Non-Reviewers." Often, customers who engage by leaving reviews have higher retention rates, so moving a customer from this list into the "Reviewer" category is a win for long-term growth.
*/
-- Question 19 Find customers who never left a review.--
SELECT DISTINCT c.customer_unique_id
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE r.review_id IS NULL;


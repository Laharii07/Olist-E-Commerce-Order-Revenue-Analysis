/*
This query is used for Financial Reconciliation and Data Integrity Auditing. In a healthy e-commerce system, the amount a customer is charged (payments) should exactly match the cost of the items and shipping (order totals). When they don't, it indicates a discrepancy that needs investigation.

Why Analysts Use This Query:
Identifying Technical Glitches: Discrepancies often reveal "bugs" in the checkout logic, such as tax not being calculated correctly, discounts being applied twice, or rounding errors in the database.

Detecting Fraud or Payment Issues: If paid_total is significantly lower than calculated_total, it could indicate a partial payment failure or an attempt to bypass full payment. If it's higher, it might signal an overcharge.

Voucher and Discount Accounting: Many systems record the "full price" in the items table but the "discounted price" in the payments table. This query helps accountants track the total value of coupons and vouchers used across the platform.

Interest and Installment Tracking: In some markets (like Brazil), customers pay in installments which may include interest. This query identifies orders where the payment includes those extra financial charges not captured in the base product price.

Ensuring Precise Bookkeeping: Before generating monthly financial statements, analysts run this to ensure every cent is accounted for. Large discrepancies can lead to legal or tax compliance issues.

*/
-- Question 25 Find orders where payment value differs from calculated order total.--
WITH order_total AS (
    SELECT 
        order_id,
        SUM(price + freight_value) AS calculated_total
    FROM order_items
    GROUP BY order_id
),
payment_total AS (
    SELECT 
        order_id,
        SUM(payment_value) AS paid_total
    FROM order_payments
    GROUP BY order_id
)

SELECT 
    o.order_id,
    ot.calculated_total,
    pt.paid_total
FROM orders o
JOIN order_total ot ON o.order_id = ot.order_id
JOIN payment_total pt ON o.order_id = pt.order_id
WHERE ABS(ot.calculated_total - pt.paid_total) > 0.01
ORDER BY o.order_id;

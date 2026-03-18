/* What is revenue?
Total income a business generates from selling goods or services before deducting any expenses 
Core formula:
          Gross Revenue: The total sales before any deductions
                     Gross Revenue = Total units sold * average price per unit
          Net revenue: The actual revenue earned after accounting for deductions
                     Gross Revenue -(Returns + Discounts + Allowances) 
- Goods returned by customers, reducing gross revenue    
- Reductions in price offered to customers, such as early payment discounts, will also affect 
- Allowance is a reduction in price due to minor product defects
- Money received for services not yet delivered is recorded as a liability, not revenue, until the work is done
** Revenue vs Profit ** 
Revenue is the total money in, while profit(bottom line) is what remains after all expenses, taxes, and 
Costs are deducted from revenue

Price is the cost of a good, and freight value is the total monetary cost charged for transporting goods.
including shipping rates, surcharges and insurance
*/


-- Question 1: Calculate the total revenue generated in the dataset. -- 

SELECT SUM(price+freight_value) AS Revenue 
FROM order_items

/* Calculating revenue helps to evaluate business performance and profitability.
for performance evaluation, customer segmentation, sales and product analysis, financial forecasting ,
pricing strategy optimisations
*/

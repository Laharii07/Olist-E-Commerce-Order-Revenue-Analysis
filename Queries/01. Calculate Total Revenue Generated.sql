/* what is revenue ?
Total income a business generates from selling goods or services before deducting any expenses 
Core formula:
           Revenue = Number of Units sold * Price per unit


-- Question 1 Calculate total revenue generated in the dataset. -- 

select sum(price+freight_value) as revenue 
from order_items

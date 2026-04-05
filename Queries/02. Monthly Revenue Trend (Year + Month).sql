

select 
   year(o.order_purchase_timestamp) as Order_year,
   month(o.order_purchase_timestamp) as Order_month,
   sum(oi.price +oi.freight_value) as monthly_revenue
  from orders o
  join order)items oi
     on order_id = oi.order_id
  group by 
     year(o.order_purchase_timestamp),
     month(o.order_purchase_timestamp)
  order by
    order_year,
    order_month;


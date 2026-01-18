select * from sales.payments
select * from customers.customers
select * from sales.orders

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'sales'
  AND table_name = 'payments';

select COLUMN_NAME,data_type from information_schema.columns where table_schema='customers' and table_name='customers'

select 
c.full_name,
c.city,
count(p.payment_id) as total_transactions,
sum(p.amount)  as total_spend,
round(avg(p.amount),2) as avg_transaction_value,
STRING_AGG(DISTINCT p.payment_mode,', ') AS payment_methods_used,
CASE
    WHEN SUM(p.amount) > 500000 THEN 'Platinum'
    WHEN SUM(p.amount) BETWEEN 200000 AND 500000 THEN 'Gold'
    ELSE 'Occasional'
END AS CUSTOMER_SEGMENT
from 
customers.customers c 
inner join sales.orders o on c.cust_id = o.cust_id 
inner join sales.payments p on p.order_id = o.order_id
group by c.full_name,c.city


select 
c.cust_id,
c.full_name,
c.city,
c.state,
count(o.order_id) as total_orders
from customers.customers c left join sales.orders o on c.cust_id = o.cust_id
group by
c.cust_id,
c.full_name,
c.city,
c.state
having count(o.order_id) <1

-- find all the products in the catalog that have never been ordered.This helps in identify the dead inventory
select *
from products.products p
left join sales.order_items oi on p.prod_id = oi.prod_id
where oi.prod_id is null;
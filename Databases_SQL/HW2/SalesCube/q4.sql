-- Question 4)

select distinct a.customer_id, a.customer_name, a.product_id, a.product_name,
case when b.quantity_sold is null then 0 else b.quantity_sold end as quantity_sold,
case when b.dollar_value is null then 0 else b.dollar_value end as dollar_value
from
(select c.customer_id, c.customer_name, p.product_id, p.product_name
from customer c, sale s, product p
where p.product_id = s.product_id) a
left join
(select s.customer_id, s.product_id, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from sale s
group by 1,2) b
on a.customer_id = b.customer_id and a.product_id = b.product_id
order by 1,6 desc
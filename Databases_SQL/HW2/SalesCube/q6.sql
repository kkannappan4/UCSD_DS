-- Question 6)
with t20_categories as
(select ca.category_id, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from sale s
join product p on s.product_id = p.product_id
join category ca on p.category_id = ca.category_id
group by 1
order by 3 desc
limit 20),
t20_customers as
(select s.customer_id, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from sale s
group by 1
order by 3 desc
limit 20)
select t20cat.category_id, t20cus.customer_id, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from sale s
join product p on s.product_id = p.product_id
join t20_categories t20cat on p.category_id = t20cat.category_id
join t20_customers t20cus on s.customer_id = t20cus.customer_id
group by 1,2
order by 1,2
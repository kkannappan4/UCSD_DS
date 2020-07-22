CREATE VIEW t20_customers as
select distinct customer_id from
(select   c.customer_id, 
	 sum(s.quantity) as quantity_sold, 
	 sum(s.quantity*s.price) as dollar_value
from    customer c left join sale s on c.customer_id = s.customer_id
group by 1
order by 3 desc
limit 20) a;

CREATE VIEW t20_categories as
select distinct category_id from
(select ca.category_id, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from sale s
join product p on s.product_id = p.product_id
join category ca on p.category_id = ca.category_id
group by 1
order by 3 desc
limit 20) a;

CREATE VIEW sales_master as
select	  c.customer_id, p.product_id, 
	  coalesce(sum(s.quantity), 0) as quantity_sold, 
	  coalesce(sum(s.quantity*s.price), 0.0) as dollar_value,
	  c.state_id, p.category_id
from  (customer c cross join product p) left join sale s 
	  on c.customer_id = s.customer_id and p.product_id = s.product_id
group by 1,2
order by 1,4 DESC;

CREATE MATERIALIZED VIEW q6_final as
select	  t20cat.category_id, t20cus.customer_id, 
	  sum(m.quantity_sold) as quantity_sold,
	  sum(m.dollar_value) as dollar_value
from      (t20_customers t20cus cross join t20_categories t20cat) left join sales_master m 
	  on m.customer_id = t20cus.customer_id and m.category_id = t20cat.category_id
group by 1,2
order by 1,2;
-- Question 1)

select s.customer_id,c.customer_name, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from customer c
join sale s on c.customer_id = s.customer_id
group by 1,2
order by 4 desc;
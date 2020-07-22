-- Question 2)

select st.state_id, st.state_name, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from state st
join customer c on st.state_id = c.state_id
join sale s on c.customer_id = s.customer_id
group by 1,2
order by 4 desc;

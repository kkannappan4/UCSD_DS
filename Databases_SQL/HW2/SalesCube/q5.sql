-- Question 5)

select ca.category_id, ca.category_name, st.state_id, st.state_name, 
sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
from sale s
join customer c on s.customer_id = c.customer_id
join state st on c.state_id = st.state_id
join product p on s.product_id = p.product_id
join category ca on p.category_id = ca.category_id
group by 1,2,3,4
order by 3,1
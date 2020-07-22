-- Question 3)

PREPARE Q3 (int) AS
    select s.product_id, sum(s.quantity) as quantity_sold, sum(s.price*s.quantity) as dollar_value
    from sale s
    where s.customer_id = $1
    and s.quantity is not null
    and s.price is not null
    group by 1
    order by 3 desc;
EXECUTE Q3 (13);
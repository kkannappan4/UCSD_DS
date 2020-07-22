CREATE VIEW likes_base AS
  select  l1.user_id as x, l2.user_id as y, 1 as like_calc
  from	  likes l1, likes l2
  where   l1.video_id = l2.video_id and 
   	   l1.user_id <> l2.user_id
union all
  select  u1.user_id as x, u2.user_id as y, 0 as like_calc
  from	   users u1, users u2
  where   u1.user_id <> u2.user_id;
   
CREATE VIEW inner_product_table AS
   select   x, y, sum(like_calc) as init_weight
   from     likes_base
   group by 1,2;

CREATE VIEW weighted_likes AS 
select  u.user_id, l.video_id, log(1+i.init_weight) as weight
from	users u, inner_product_table i, likes l
where   u.user_id = i.x and l.user_id = i.y;

CREATE MATERIALIZED VIEW precompute_likes AS
select user_id, video_id, sum(weight) as weight
from weighted_likes
where weight > 0
group by 1,2
order by 1,3 desc;

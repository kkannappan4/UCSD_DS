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

CREATE INDEX precompute_u_id_index on precompute_likes(user_id)

PREPARE Q5_pre_final(int) as
select video_id, weight
from precompute_likes p
where user_id = $1 and 
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = p.video_id) and
	not exists (select 1 from likes l where l.user_id = $1 and l.video_id = p.video_id)
limit 10;

EXPLAIN (ANALYZE, BUFFERS) EXECUTE Q5_pre_final(1);


-- Original

PREPARE Q5_best (int) as
with log_cats as (
select X.user_id, Y.user_id as o_user_id, log(1 + sum(Y.like_calc * X.like_calc)) as weight
from
(	select l1.video_id, 1 as like_calc, l1.user_id
    from likes l1
    where l1.user_id = $1) X, 
   (   	select l2.video_id, 1 as like_calc, l2.user_id
    	from likes l2
    	where l2.user_id NOT IN ($1)) Y
 where X.video_id = Y.video_id
 group by 1,2
 order by 1)
select l3.video_id, sum(log_cats.weight) as rank
from likes l3, log_cats
where log_cats.o_user_id = l3.user_id
and
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = l3.video_id) and
    not exists (select 1 from likes ll where ll.user_id = $1 and ll.video_id = l3.video_id)
group by 1
order by 2 desc, 1 desc
limit 10;

--EXPLAIN (ANALYZE, BUFFERS) 
EXECUTE Q5_best(1);
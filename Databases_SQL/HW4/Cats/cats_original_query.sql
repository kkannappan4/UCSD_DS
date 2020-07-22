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
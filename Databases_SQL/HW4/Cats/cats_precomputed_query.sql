
-- Precomputed Query
PREPARE Q5_pre_final(int) as
select video_id, weight
from precompute_likes p
where user_id = $1 and 
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = p.video_id) and
	not exists (select 1 from likes l where l.user_id = $1 and l.video_id = p.video_id)
limit 10;

--EXPLAIN (ANALYZE, BUFFERS) 
EXECUTE Q5_pre_final(1);
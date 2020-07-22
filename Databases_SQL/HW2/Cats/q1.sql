-- Question 1

PREPARE Q1 (int) AS
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id
group by 1
order by 2 desc, 1
limit 10;

EXECUTE Q1 (10);

-- Better:
PREPARE Q1_better (int) AS
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id
and 
	 not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id)
group by 1
order by 2 desc, 1
limit 10;

EXECUTE Q1_better (10);

-- Best:
PREPARE Q1_best (int) AS
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id
and 
	 not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id) and
	 not exists (select 1 from likes ll where ll.user_id = $1 and ll.video_id =v.video_id)
group by 1
order by 2 desc, 1
limit 10;

EXECUTE Q1_best (10);


-- Question 4
PREPARE Q4 (int) as
select 
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id and l.user_id IN (
    select distinct  u.user_id
	from users u, likes l, video v
	where u.user_id = l.user_id and l.video_id = v.video_id and u.user_id NOT IN ($1) AND l.video_id IN (
    	select v.video_id
	    from users u, likes l, video v
		where u.user_id = l.user_id and l.video_id = v.video_id and u.user_id = $1))
group by 1
order by 2 desc,1
limit 10;

EXECUTE Q4(1);

-- Better:
PREPARE Q4_better (int) as
select 
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id and l.user_id IN (
    select distinct  u.user_id
	from users u, likes l, video v
	where u.user_id = l.user_id and l.video_id = v.video_id and u.user_id NOT IN ($1) AND l.video_id IN (
    	select v.video_id
	    from users u, likes l, video v
		where u.user_id = l.user_id and l.video_id = v.video_id and u.user_id = $1))
and
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id)
group by 1
order by 2 desc,1
limit 10;

EXECUTE Q4_better(1);

-- Best:
PREPARE Q4_best (int) as
select 
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id and l.user_id IN (
    select distinct  u.user_id
	from users u, likes l, video v
	where u.user_id = l.user_id and l.video_id = v.video_id and u.user_id NOT IN ($1) AND l.video_id IN (
    	select v.video_id
	    from users u, likes l, video v
		where u.user_id = l.user_id and l.video_id = v.video_id and u.user_id = $1))
and
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id) and
    not exists (select 1 from likes ll where ll.user_id = $1 and ll.video_id = v.video_id)
group by 1
order by 2 desc,1
limit 10;

EXECUTE Q4_best(1);
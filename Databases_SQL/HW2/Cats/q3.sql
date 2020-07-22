-- Question 3
PREPARE Q3 (int) as
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id and l.user_id not in ($1) and l.user_id IN (
    (select distinct friend_id as user_id from friend
    where user_id = $1)
	UNION ALL
	(select f.friend_id as user_id
	from friend f
	where f.user_id IN (
    	select ff.friend_id as user_id
    	from friend ff
    	where ff.user_id = $1)))  
group by v.video_id
order by 2 desc,1
limit 10;

EXECUTE Q3(1);

-- Better:
PREPARE Q3_better (int) as
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id and l.user_id not in ($1) and l.user_id IN (
    (select distinct friend_id as user_id from friend
    where user_id = $1)
	UNION ALL
	(select f.friend_id as user_id
	from friend f
	where f.user_id IN (
    	select ff.friend_id as user_id
    	from friend ff
    	where ff.user_id = $1)))  
and
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id)
group by v.video_id
order by 2 desc,1
limit 10;

EXECUTE Q3_better(1);

-- Best:
PREPARE Q3_best (int) as
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id and l.user_id not in ($1) and l.user_id IN (
    (select distinct friend_id as user_id from friend
    where user_id = $1)
	UNION ALL
	(select f.friend_id as user_id
	from friend f
	where f.user_id IN (
    	select ff.friend_id as user_id
    	from friend ff
    	where ff.user_id = $1)))  
and
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id) and
    not exists (select 1 from likes ll where ll.user_id = $1 and ll.video_id = v.video_id)
group by v.video_id
order by 2 desc,1
limit 10;

EXECUTE Q3_best(1);
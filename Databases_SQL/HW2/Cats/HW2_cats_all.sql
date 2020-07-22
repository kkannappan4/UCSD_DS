drop table if exists "users" cascade;
CREATE TABLE users
(
  user_id serial primary key NOT NULL,
  user_name character varying(50) NOT NULL,
  facebook_id character varying(50) NOT NULL
);
drop table if exists "video" cascade;
CREATE TABLE video
(
  video_id serial primary key NOT NULL,
  video_name character varying(50) NOT NULL
);

drop table if exists "login" cascade;
CREATE TABLE login
(
  login_id serial primary key NOT NULL,
  user_id integer references "users" (user_id) NOT NULL,
  "time" timestamp without time zone NOT NULL
);

drop table if exists "watch" cascade;
CREATE TABLE watch
(
  watch_id serial primary key NOT NULL,
  video_id integer references video (video_id) NOT NULL,
  user_id integer references "users" (user_id) NOT NULL,
  "time" timestamp without time zone NOT NULL
);

drop table if exists "friend" cascade; 
CREATE TABLE friend
(
  user_id integer references "users" (user_id) NOT NULL,
  friend_id integer references "users" (user_id) NOT NULL
);



drop table if exists "suggestion" cascade;
CREATE TABLE suggestion
(
  suggestion_id serial primary key NOT NULL,
  login_id integer references login(login_id) NOT NULL,
  video_id integer references video (video_id) NOT NULL
);

INSERT INTO "users" VALUES (1,'Aaron','aaron');
INSERT INTO "users" VALUES (2,'Ben','ben');
INSERT INTO "users" VALUES (3,'Emily','emily');
INSERT INTO "users" VALUES (4,'Smily','smile');
INSERT INTO "users" VALUES (5,'Laura','lau');
INSERT INTO "users" VALUES (6,'John','jaw');
INSERT INTO "users" VALUES (7,'David','dave');
INSERT INTO "users" VALUES (8,'Sofia','sof');
INSERT INTO "users" VALUES (9,'Mike','mike');
INSERT INTO "users" VALUES (10,'Moana','moana');
INSERT INTO "users" VALUES (13,'Alin','alin');

INSERT INTO video VALUES (1,'AA');
INSERT INTO video VALUES (2,'BB');
INSERT INTO video VALUES (3,'CC');
INSERT INTO video VALUES (4,'DD');
INSERT INTO video VALUES (5,'EE');
INSERT INTO video VALUES (6,'FF');
INSERT INTO video VALUES (7,'GG');
INSERT INTO video VALUES (8,'HH');
INSERT INTO video VALUES (9,'II');
INSERT INTO video VALUES (10,'JJ');
INSERT INTO video VALUES (11,'KK');
INSERT INTO video VALUES (12,'LL');
INSERT INTO video VALUES (13,'MM');
INSERT INTO video VALUES (14,'NN');
INSERT INTO video VALUES (15,'OO');
INSERT INTO video VALUES (16,'PP');
INSERT INTO video VALUES (17,'QQ');
INSERT INTO video VALUES (18,'RR');
INSERT INTO video VALUES (19,'SS');
INSERT INTO video VALUES (20,'TT');
INSERT INTO video VALUES (21,'UU');
INSERT INTO video VALUES (22,'VV');
INSERT INTO video VALUES (23,'WW');
INSERT INTO video VALUES (24,'XX');
INSERT INTO video VALUES (25,'YY');
INSERT INTO video VALUES (26,'ZZ');
INSERT INTO video VALUES (27,'AAA');
INSERT INTO video VALUES (28,'BBB');
INSERT INTO video VALUES (29,'CCC');
INSERT INTO video VALUES (30,'DDD');


INSERT INTO friend VALUES (1,2);
INSERT INTO friend VALUES (2,1);
INSERT INTO friend VALUES (3,4);
INSERT INTO friend VALUES (4,3);
INSERT INTO friend VALUES (5,6);
INSERT INTO friend VALUES (6,5);
INSERT INTO friend VALUES (7,8);
INSERT INTO friend VALUES (8,7);
INSERT INTO friend VALUES (9,10);
INSERT INTO friend VALUES (10,9);
INSERT INTO friend VALUES (1,3);
INSERT INTO friend VALUES (1,4);
INSERT INTO friend VALUES (1,5);
INSERT INTO friend VALUES (3,1);
INSERT INTO friend VALUES (3,5);
INSERT INTO friend VALUES (5,1);
INSERT INTO friend VALUES (5,3);
INSERT INTO friend VALUES (5,7);
INSERT INTO friend VALUES (10,8);
INSERT INTO friend VALUES (10,7);
INSERT INTO friend VALUES (8,10);
INSERT INTO friend VALUES (8,6);

INSERT INTO friend VALUES (13,10);
INSERT INTO friend VALUES (13,8);
INSERT INTO friend VALUES (13,3);
INSERT INTO friend VALUES (13,5);
INSERT INTO friend VALUES (13,1);
INSERT INTO friend VALUES (13,6);
INSERT INTO friend VALUES (13,7);

drop table if exists "likes" cascade;
CREATE TABLE "likes"
(
  like_id serial primary key NOT NULL,
  user_id integer references "users" (user_id) NOT NULL,
  video_id integer references video (video_id) NOT NULL,
  "time" timestamp without time zone NOT NULL
);


INSERT INTO likes VALUES (1,1,17,'10/5/16 9:00');
INSERT INTO likes VALUES (2,2,18,'10/6/16 9:00');
INSERT INTO likes VALUES (3,3,1,'10/7/16 9:00');
INSERT INTO likes VALUES (4,4,9,'10/8/16 9:00');
INSERT INTO likes VALUES (5,4,3,'10/9/16 9:00');
INSERT INTO likes VALUES (6,6,4,'10/10/16 9:00');
INSERT INTO likes VALUES (7,7,5,'10/11/16 9:00');
INSERT INTO likes VALUES (8,8,6,'10/12/16 9:00');
INSERT INTO likes VALUES (9,9,7,'10/13/16 9:00');
INSERT INTO likes VALUES (10,10,8,'10/14/16 9:00');
INSERT INTO likes VALUES (11,1,9,'10/15/16 9:00');
INSERT INTO likes VALUES (12,2,10,'10/16/16 9:00');
INSERT INTO likes VALUES (13,3,11,'10/17/16 9:00');
INSERT INTO likes VALUES (14,5,12,'10/18/16 9:00');
INSERT INTO likes VALUES (15,5,13,'10/19/16 9:00');
INSERT INTO likes VALUES (16,6,14,'10/20/16 9:00');
INSERT INTO likes VALUES (17,7,15,'10/21/16 9:00');
INSERT INTO likes VALUES (18,8,16,'10/22/16 9:00');
INSERT INTO likes VALUES (19,9,19,'10/23/16 9:00');
INSERT INTO likes VALUES (20,10,20,'10/24/16 9:00');
INSERT INTO likes VALUES (21,1,11,'10/25/16 9:00');
INSERT INTO likes VALUES (22,2,12,'10/26/16 9:00');
INSERT INTO likes VALUES (23,3,13,'10/27/16 9:00');
INSERT INTO likes VALUES (24,4,14,'10/28/16 9:00');
INSERT INTO likes VALUES (25,1,15,'10/29/16 9:00');
INSERT INTO likes VALUES (26,6,16,'10/30/16 9:00');
INSERT INTO likes VALUES (27,7,17,'10/31/16 9:00');
INSERT INTO likes VALUES (28,8,18,'11/1/16 9:00');
INSERT INTO likes VALUES (29,9,1,'11/2/16 9:00');
INSERT INTO likes VALUES (30,10,2,'11/3/16 9:00');
INSERT INTO likes VALUES (31,3,21,'11/4/16 9:00');
INSERT INTO likes VALUES (32,4,21,'11/5/16 9:00');
INSERT INTO likes VALUES (33,1,22,'11/6/16 9:00');
INSERT INTO likes VALUES (34,6,23,'11/7/16 9:00');
INSERT INTO likes VALUES (35,7,24,'11/8/16 9:00');
INSERT INTO likes VALUES (36,6,25,'11/9/16 9:00');
INSERT INTO likes VALUES (37,7,26,'11/10/16 9:00');
INSERT INTO likes VALUES (38,8,27,'11/11/16 9:00');
INSERT INTO likes VALUES (39,9,28,'11/12/16 9:00');
INSERT INTO likes VALUES (40,10,29,'11/13/16 9:00');
INSERT INTO likes VALUES (41,9,30,'11/14/16 9:00');
INSERT INTO likes VALUES (42,10,21,'11/15/16 9:00');
INSERT INTO likes VALUES (43,3,25,'11/16/16 9:00');
INSERT INTO likes VALUES (44,4,26,'11/17/16 9:00');
INSERT INTO likes VALUES (45,1,27,'11/18/16 9:00');
INSERT INTO likes VALUES (46,6,28,'11/19/16 9:00');
INSERT INTO likes VALUES (47,6,29,'11/20/16 9:00');
INSERT INTO likes VALUES (48,7,30,'11/21/16 9:00');
INSERT INTO likes VALUES (49,8,22,'11/22/16 9:00');
INSERT INTO likes VALUES (50,1,30,'11/23/16 9:00');
INSERT INTO likes VALUES (51,5,5,'11/24/16 9:00');
INSERT INTO likes VALUES (52,6,3,'11/25/16 9:00');
INSERT INTO likes VALUES (53,7,4,'11/26/16 9:00');
INSERT INTO likes VALUES (54,8,5,'11/27/16 9:00');
INSERT INTO likes VALUES (55,3,15,'11/28/16 9:00');
INSERT INTO likes VALUES (56,4,15,'11/29/16 9:00');
INSERT INTO likes VALUES (57,5,3,'11/30/16 9:00');
INSERT INTO likes VALUES (58,6,21,'12/1/16 9:00');
INSERT INTO likes VALUES (59,7,21,'12/2/16 9:00');
INSERT INTO likes VALUES (60,8,1,'12/3/16 9:00');
INSERT INTO likes VALUES (61,8,30,'12/3/16 9:00');
INSERT INTO likes VALUES (62,8,1,'12/3/16 9:00');
INSERT INTO likes VALUES (63,8,3,'12/3/16 9:00');
INSERT INTO likes VALUES (64,8,5,'12/3/16 9:00');
INSERT INTO likes VALUES (65,8,9,'12/3/16 9:00');
INSERT INTO likes VALUES (66,9,9,'12/3/16 9:00');
INSERT INTO likes VALUES (67,8,22,'12/3/16 9:00');
INSERT INTO likes VALUES (68,8,22,'12/3/16 9:00');
INSERT INTO likes VALUES (69,9,17,'12/3/16 9:00');
INSERT INTO likes VALUES (70,8,11,'12/3/16 9:00');
INSERT INTO likes VALUES (71,10,17,'12/3/16 9:00');
INSERT INTO likes VALUES (72,2,17,'12/3/16 9:00');
INSERT INTO likes VALUES (73,3,11,'12/3/16 9:00');
INSERT INTO likes VALUES (74,4,26,'12/3/16 9:00');
INSERT INTO likes VALUES (75,4,28,'12/3/16 9:00');
INSERT INTO likes VALUES (76,4,22,'12/3/16 9:00');
INSERT INTO likes VALUES (77,4,1,'12/3/16 9:00');
INSERT INTO likes VALUES (78,4,15,'12/3/16 9:00');
INSERT INTO likes VALUES (79,4,11,'12/3/16 9:00');
INSERT INTO likes VALUES (80,5,9,'12/3/16 9:00');
INSERT INTO likes VALUES (81,4,30,'12/3/16 9:00');
INSERT INTO likes VALUES (82,5,21,'12/3/16 9:00');
INSERT INTO likes VALUES (83,5,3,'12/3/16 9:00');
INSERT INTO likes VALUES (84,5,17,'12/3/16 9:00');
INSERT INTO likes VALUES (85,5,26,'12/3/16 9:00');
INSERT INTO likes VALUES (86,6,26,'12/3/16 9:00');
INSERT INTO likes VALUES (87,5,11,'12/3/16 9:00');
INSERT INTO likes VALUES (88,6,22,'12/3/16 9:00');
INSERT INTO likes VALUES (89,8,22,'12/3/16 9:00');
INSERT INTO likes VALUES (90,5,22,'12/3/16 9:00');
INSERT INTO likes VALUES (91,4,11,'12/3/16 9:00');
INSERT INTO likes VALUES (92,5,9,'12/3/16 9:00');
INSERT INTO likes VALUES (93,5,26,'12/3/16 9:00');
INSERT INTO likes VALUES (94,5,21,'12/3/16 9:00');
INSERT INTO likes VALUES (95,5,30,'12/3/16 9:00');
INSERT INTO likes VALUES (96,6,15,'12/3/16 9:00');
INSERT INTO likes VALUES (97,5,3,'12/3/16 9:00');
INSERT INTO likes VALUES (98,6,17,'12/3/16 9:00');
INSERT INTO likes VALUES (99,8,1,'12/3/16 9:00');
INSERT INTO likes VALUES (100,5,5,'12/3/16 9:00');
INSERT INTO likes VALUES (101,6,28,'12/3/16 9:00');
INSERT INTO likes VALUES (102,8,18,'12/3/16 9:00');


INSERT INTO watch VALUES (1,9,10,'12/3/16 9:00');
INSERT INTO watch VALUES (2,11,1,'12/3/16 9:00');


-- users, video, login, watch, friend, suggestion, likes

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


-- Question 2
PREPARE Q2 (int) AS
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id
and l.user_id IN (select distinct friend_id as user_id from friend
where user_id = $1)
group by 1
order by 2 desc, 1
limit 10;

EXECUTE Q2 (1);

-- Better
PREPARE Q2_better (int) AS
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id
and l.user_id IN (select distinct friend_id as user_id from friend
where user_id = $1)
and 
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id)
group by 1
order by 2 desc, 1
limit 10;

EXECUTE Q2_better (1);

-- Best:
PREPARE Q2_best (int) AS
select
	v.video_id,
    count(v.video_id) as rank
from video v, likes l
where v.video_id = l.video_id
and l.user_id IN (select distinct friend_id as user_id from friend
where user_id = $1)
and 
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = v.video_id) and
	not exists (select 1 from likes ll where ll.user_id = $1 and ll.video_id =v.video_id)
group by 1
order by 2 desc, 1
limit 10;

EXECUTE Q2_best (1);

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

-- Question 5

PREPARE Q5 (int) as
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
group by 1
order by 2 desc, 1 desc
limit 10;

EXECUTE Q5(1);

EXPLAIN (ANALYZE, BUFFERS) EXECUTE Q5(1);
-- Better:

PREPARE Q5_better (int) as
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
    not exists (select 1 from watch w where w.user_id = $1 and w.video_id = l3.video_id)
group by 1
order by 2 desc, 1 desc
limit 10;

EXECUTE Q5_better(1);

-- Best:

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

EXECUTE Q5_best(1);

EXPLAIN (ANALYZE, BUFFERS) EXECUTE Q5_best(1);

select * from likes

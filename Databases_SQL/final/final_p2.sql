-- Problem 1
select sum(case when (hteam like '%San Diego%' and hscore > vscore)
           OR (vteam like '%San Diego%' and vscore > hscore) 
       then 1 else 0 end) as wins
from matches

-- Problem 2
select a.team, sum(points) as points
from
(select hteam as team, sum(case when hscore > vscore then 2
                       when hscore = vscore then 1 else 0 end)
              as points 
from matches
group by 1
union all
select vteam as team, sum(case when hscore < vscore then 3
                       when hscore = vscore then 1 else 0 end)
              as points 
from matches
group by 1) a
group by 1

-- Problem 3
select coach from teams
where name IN(
select distinct team from
(select hteam as team, sum(case when hscore >= vscore then 1 else 0 end) as win_draw, count(*) as games
 from matches
 group by 1
 having count(*) = sum(case when hscore >= vscore then 1 else 0 end)
 union all
 select vteam as team, sum(case when vscore >= hscore then 1 else 0 end) as win_draw, count(*) as games
 from matches
 group by 1
 having count(*) = sum(case when vscore >= hscore then 1 else 0 end)) a
)

-- Problem 4
-- Create leaderboard table
CREATE VIEW leaders(team, points, standing) as
    select aa.*, RANK() OVER (order by points desc) as standing
	from (select a.team, sum(points) as points
from
(select hteam as team, sum(case when hscore > vscore then 2
                       when hscore = vscore then 1 else 0 end)
              as points 
from matches
group by 1
union all
select vteam as team, sum(case when hscore < vscore then 3
                       when hscore = vscore then 1 else 0 end)
              as points 
from matches
group by 1) a
group by 1)aa;

select name
from teams
where name NOT IN (
 select distinct t.name
 from teams t, matches m
 where t.name = m.hteam
 and m.vscore > m.hscore
 and m.vteam NOT IN (
     select team
     from leaders
     where standing <= 1)
UNION ALL
 select t.name
 from teams t, matches m    
 where t.name = m.vteam
 and m.hscore > m.vscore
 and m.hteam NOT IN (
     select team
     from leaders
   	 where standing <= 1));

-- Problem 5
-- Could make the following indexes:
CREATE INDEX matches_hteam_index ON matches(hscore);
CREATE INDEX matches_vteam_index ON matches(vscore);
-- These indexes may help once many seasons of matches are inputted into the table
-- right now, however, the indexes may not provide much of a lift.
-- Both of these selections were made because we aggregate heavily on both
-- of those fields to yield the metrics/data we care about. The scores are counted
-- directly, and do not appear to be aggregated on, hence I felt that an
-- index on both would be of lesser importance.

-- Problem 6
CREATE TRIGGER scoreboard_team
AFTER INSERT ON teams
for each row
BEGIN
  INSERT INTO scoreboard VALUES (:new.name, 0);
END;

CREATE TRIGGER scoreboard_updater
AFTER INSERT ON matches
for each row
BEGIN
   IF :new.hscore < :new.vscore
   THEN
          UPDATE scoreboard
                SET points = points + 3
           where name = :new.vteam;
   ELSEIF :new.hscore > :new.vscore
   THEN
          UPDATE scoreboard
                SET points = points + 2
           where name = :new.hteam;
   ELSE
          UPDATE scoreboard
                SET points = points + 1
           where name = :new.vteam;
          UPDATE scoreboard
                SET points = points + 1
           where name = :new.hteam;
   END IF;
END;
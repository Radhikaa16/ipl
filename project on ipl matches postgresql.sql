
 /* Q1 create table for matches */
/* ans */
create table matches (
    id int ,
    city varchar(100),
    date date,
    player_of_match varchar(100),
    venue varchar(100),
    neutral_venue int,
    team1 varchar(100),
    team2 varchar(100),
    toss_winner varchar(100),
    toss_decision varchar(100),
    winner varchar(100),
    result varchar(100),
    result_margin int,
    eliminator varchar(100),
    method varchar(100),
    umpire1 varchar(100),
    umpire2 varchar(100)
);

/* Q2 import data from csv file */
/* ans */
 select * from matches

/* Q3 create table for deliveries */
/* ans */
 create table deliveries (
    id  int,
    inning int,
    over int,
    ball int,
    batsman varchar(100),
    non_striker varchar(100),
    bowler varchar(100),
    batsman_runs int,
    extra_runs int,
    total_runs int,
    is_wicket int,
    dismissal_kind varchar(100),
    player_dismissed varchar(100),
    fielder varchar(100),
    extras_type varchar(100),
    batting_team varchar(100),
    bowling_team varchar(100)
);

/* Q4 import data from deliveries csv */
/* ans */
 select * from deliveries

/* Q5 select top 20 rows from matches */
/* ans */
 select * from matches limit 20; 

/* Q6 select top 20 deliveries ordering by id,innings,over,ball in asc */
/* ans */
 select * from deliveries
 order by "id" asc, inning asc ,over asc, ball asc
 limit 20;

/* Q7 data from 2 may 2013 from matches */
/* ans */
 select * from matches
 where date = '2013-05-02' ;

/* Q8 result mode is runs and margin of victory more than 100 */
/* ans */
 select * from matches
 where result = 'runs' 
 and result_margin>100 ;

/* Q9 final score is tie arrange by date desc */
/* ans */
 select * from matches
 where result = 'tie'
 order by date desc ;

/* Q10 count of cities held match */
/* ans */
 select count (distinct city) as "cities" from matches

/* Q11 deliveries_v02 with extra column ball_result in deliveries */
/* ans */
 create table deliveries_v02 (
    id  int,
    inning int,
    over int,
    ball int,
    batsman varchar(100),
    non_striker varchar(100),
    bowler varchar(100),
    batsman_runs int,
    extra_runs int,
    total_runs int,
    is_wicket int,
    dismissal_kind varchar(100),
    player_dismissed varchar(100),
    fielder varchar(100),
    extras_type varchar(100),
    batting_team varchar(100),
    bowling_team varchar(100));

/* import from deliveries */
  select * from deliveries_v02
 
  alter table deliveries_v02 add column ball_result varchar;
  update deliveries_v02
  set ball_result = case when total_runs>=4 then'Boundary'
  when total_runs = 0 then 'dot'
  else 'other' 
  end;
 
 /* Q12 total no of boundaries and dot balls */
 /* ans */
  select count (*) as total_boundaries 
  from deliveries_v02
  where ball_result = 'Boundary';
  select count(*) as total_dot
  from deliveries_v02
  where ball_result = 'dot' ;
 
 /* Q13 boundaries by each team and order it desc */
 /* ans */
  select batting_team,
  count(*) as total_boundaries 
  from deliveries_v02
  where ball_result = 'Boundary'
  group by batting_team 
  order by total_boundaries desc;
  
 /* Q14 dot balls bowled by each team order it by desc */
 /* ans */
  select * from deliveries_v02
  select bowling_team,
  count(*)as total_dots
  from deliveries_v02
  where ball_result = 'dot'
  group by bowling_team
  order by total_dots desc;


/* Q15 total no of dismissalby dismissal kind which is not NA */
/* ans */
  select dismissal_kind,
  count(*)as total_non_NA
  from deliveries_v02
  where dismissal_kind <> 'NA'
  group by dismissal_kind
  order by dismissal_kind;
 


/* Q16 top 5 bowlers who conceded max extra runs */
/* ans */
  SELECT bowler, SUM(extra_runs) AS total_extra_runs
  FROM deliveries
  GROUP BY bowler
  ORDER BY total_extra_runs DESC
  LIMIT 5;

/* Q17 deliveries_v03 with venue and date from matches */
/* ans */
 create table deliveries_v03 as
select
 a.inning ,		
 a.over,
 a.ball,
 a.batsman,
 a.non_striker,
 a.bowler,
 a.batsman_runs,
 a.extra_runs,
 a.total_runs,
 a.is_wicket,
 a.dismissal_kind,
 a.player_dismissed,
 a.fielder,
 a.extras_type,
 a.batting_team,
 a.bowling_team,
 b.date,
 b.venue
 FROM deliveries_v02 AS a
 LEFT JOIN matches AS b
 ON a.id = b.id; 
select * from deliveries_v03
select * from matches

 /* Q18 total runs scored by each venue arrange by desc order of total runs*/
 /* ans */
  select 
   a.venue,
   sum(b.total_runs) as total_runs from deliveries_v02 b
   join matches a on b.id = a.id
   group by a.venue
   order by total_runs desc;
   
 /* Q19 year wise total_runs at eden garden order it total runs desc */
 /* ans */
 select extract (year from date) as year ,
 sum(total_runs) as runs
 from deliveries_v03
 where venue= 'Eden Gardens'
 group by extract (year FROM date)
 order by runs desc;
 
 
 

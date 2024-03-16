# 1 and 2
create materialized view highest_avg_time as 
select 
  t2.Zone as pu_zone, t3.Zone as do_zone,
  avg(tpep_dropoff_datetime - tpep_pickup_datetime) as avg_time,
  count(*) as cnt
from trip_data
join taxi_zone as t2
  ON trip_data.PULocationID = t2.location_id
join taxi_zone as t3
  ON trip_data.DOLocationID = t3.location_id
group by t2.Zone, t3.Zone
order by avg_time desc
limit 1;

# 3
WITH t AS (
    SELECT 
      MAX(tpep_pickup_datetime) AS finish, 
      MAX(tpep_pickup_datetime) - INTERVAL '17 HOURS' as start 
    FROM trip_data
)
select 
  t2.Zone as pu_zone,
  count(t2.Zone) as cnt
from t, trip_data
join taxi_zone as t2
  ON trip_data.PULocationID = t2.location_id
where tpep_pickup_datetime >= start and tpep_pickup_datetime <= finish
group by t2.Zone
order by cnt desc
limit 3;

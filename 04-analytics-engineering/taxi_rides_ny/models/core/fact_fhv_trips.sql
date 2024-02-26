{{ config(materialized='table') }}

with fhv_tripdata as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select t.*
from fhv_tripdata as t
inner join dim_zones as pickup_zone
on t.pulocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on t.dolocationid = dropoff_zone.locationid

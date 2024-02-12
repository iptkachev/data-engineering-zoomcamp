-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `certain-tangent-339418.nytaxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://2022-green-taxi-trip-location/raw-files/*']
);

CREATE OR REPLACE TABLE certain-tangent-339418.nytaxi.green_tripdata_non_partitoned AS
SELECT * FROM certain-tangent-339418.nytaxi.external_green_tripdata;

-- question 1
select count(*) from certain-tangent-339418.nytaxi.external_green_tripdata;

-- question 2
select distinct PULocationID from certain-tangent-339418.nytaxi.external_green_tripdata;
select distinct PULocationID from certain-tangent-339418.nytaxi.green_tripdata_non_partitoned;

-- question 3
select count(*) from certain-tangent-339418.nytaxi.green_tripdata_non_partitoned
where fare_amount = 0;

-- Question 4

-- question 5
CREATE OR REPLACE TABLE certain-tangent-339418.nytaxi.green_tripdata_partitoned
PARTITION BY DATE(lpep_pickup_datetime)
Cluster BY PUlocationID
AS
SELECT * FROM certain-tangent-339418.nytaxi.external_green_tripdata;

select distinct PULocationID from certain-tangent-339418.nytaxi.green_tripdata_non_partitoned
where DATE(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30';

select distinct PULocationID from certain-tangent-339418.nytaxi.green_tripdata_partitoned
where DATE(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30'

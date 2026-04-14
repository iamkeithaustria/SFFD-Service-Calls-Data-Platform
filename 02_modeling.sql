-- Step 1: Create Dimension for Locations
CREATE OR REPLACE TABLE `udemi-492914.sffd_service_calls_2020.dim_location`
AS
SELECT
  FARM_FINGERPRINT(
    CONCAT(
      IFNULL(neighborhood_name, ''),
      IFNULL(battalion, ''),
      IFNULL(CAST(zipcode_of_incident AS STRING), '')))
    AS location_key,
  neighborhood_name,
  battalion,
  city,
  zipcode_of_incident AS zipcode
FROM `udemi-492914.sffd_service_calls_2020.sffd_calls_master_raw`
GROUP BY 1, 2, 3, 4, 5;

-- Step 2: Create Dimension for Call Details
CREATE OR REPLACE TABLE `udemi-492914.sffd_service_calls_2020.dim_call_type`
AS
SELECT
  FARM_FINGERPRINT(CONCAT(IFNULL(call_type, ''), IFNULL(call_type_group, '')))
    AS call_type_key,
  call_type,
  call_type_group
FROM `udemi-492914.sffd_service_calls_2020.sffd_calls_master_raw`
GROUP BY 1, 2, 3;

-- Step 3: Create the Fact Table with Metrics
CREATE OR REPLACE TABLE `udemi-492914.sffd_service_calls_2020.fact_service_calls`
AS
SELECT
  call_number,
  call_date,
  -- Foreign Keys
  FARM_FINGERPRINT(
    CONCAT(
      IFNULL(neighborhood_name, ''),
      IFNULL(battalion, ''),
      IFNULL(CAST(zipcode_of_incident AS STRING), '')))
    AS location_key,
  FARM_FINGERPRINT(CONCAT(IFNULL(call_type, ''), IFNULL(call_type_group, '')))
    AS call_type_key,
  -- Metrics
  TIMESTAMP_DIFF(on_scene_timestamp, received_timestamp, SECOND)
    AS response_time_seconds,
  TIMESTAMP_DIFF(dispatch_timestamp, received_timestamp, SECOND)
    AS dispatch_delay_seconds,
  TIMESTAMP_DIFF(available_timestamp, received_timestamp, SECOND)
    AS total_incident_duration_seconds,
  number_of_alarms,
  als_unit
FROM `udemi-492914.sffd_service_calls_2020.sffd_calls_master_raw`;


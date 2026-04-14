CREATE OR REPLACE TABLE `udemi-492914.sffd_service_calls_2020.sffd_calls_master_raw`
AS
SELECT *
FROM
  (
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210102`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210103`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210104`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210105`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210106`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210107`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210108`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210109`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210110`
    UNION ALL
    SELECT
      * EXCEPT (fire_prevention_district, supervisor_district),
      CAST(fire_prevention_district AS STRING) AS fire_prevention_district,
      CAST(supervisor_district AS STRING) AS supervisor_district
    FROM `udemi-492914.sffd_service_calls_2020.sffd_service_calls_20210111`
  )
QUALIFY
  ROW_NUMBER() OVER (PARTITION BY call_number ORDER BY received_timestamp DESC)
  = 1;


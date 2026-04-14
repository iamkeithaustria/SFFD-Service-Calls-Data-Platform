SELECT 
  'Total Raw Records' as metric, 
  CAST(COUNT(*) AS STRING) as value 
FROM `udemi-492914.sffd_service_calls_2020.sffd_calls_master_raw`

UNION ALL

SELECT 
  'Total Fact Records (Deduplicated)', 
  CAST(COUNT(*) AS STRING) 
FROM `udemi-492914.sffd_service_calls_2020.fact_service_calls`

UNION ALL

SELECT 
  'Avg Response Time (Mins)', 
  CAST(ROUND(AVG(response_time_seconds/60), 2) AS STRING) 
FROM `udemi-492914.sffd_service_calls_2020.fact_service_calls`;

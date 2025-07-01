-- Pearson correlation preparation - composition of facts table which contains as columns user_pseudo_id (STRING), engagement_time (INTEGER), purchase_revenue (FLOAT) values, with exclusion of NULL values. In presented example it utilizes sample GA4 data from BigQuery Public Dataset


WITH aggregated_data as (SELECT distinct(user_pseudo_id), (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'engagement_time_msec') AS engagement_time, ecommerce.purchase_revenue
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` AS t WHERE event_name = "purchase")
  
  SELECT * FROM aggregated_data where engagement_time IS NOT NULL AND purchase_revenue IS NOT NULL 


-- Cramer V preparation - composition of facts table which contains as columns user_pseudo_id (STRING), device_type (STRING), traffic_source_medium (STRING), with exclusion of empty values. In presented example it utilizes sample GA4 data from BigQuery Public Dataset
WITH aggregated_data as (SELECT distinct(user_pseudo_id), device.category as device_category, traffic_source.medium as traffic_source_medium
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` AS t WHERE event_name = "purchase")
  
  SELECT * FROM aggregated_data where traffic_source_medium NOT IN ("(data deleted)", "(none)", "<Other>")

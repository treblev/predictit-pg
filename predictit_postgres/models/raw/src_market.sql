{{
    config( materialized = 'view')
}}

WITH raw_data AS (
    SELECT * 
    FROM {{ source('predictit', 'predictit_data_raw') }}
)
SELECT * FROM raw_data 
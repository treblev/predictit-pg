{{ config(materialized='table') }}

SELECT DISTINCT
    market_id,
    market_name
FROM {{ ref('src_market') }} 
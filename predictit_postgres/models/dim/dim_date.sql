{{ config(materialized='table') }}

SELECT DISTINCT
    TO_CHAR(timestamp, 'YYYYMMDD')::int AS date_id,
    DATE_TRUNC('day', timestamp) AS date,
    EXTRACT(HOUR FROM timestamp) AS hour,
    EXTRACT(DOW FROM timestamp) AS day_of_week
FROM {{ ref('src_market') }}
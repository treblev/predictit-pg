{{ config(materialized='table') }}

SELECT DISTINCT
    TO_CHAR(updated_at, 'YYYYMMDD')::int AS date_id,
    DATE_TRUNC('day', updated_at) AS date,
    EXTRACT(HOUR FROM updated_at) AS hour,
    EXTRACT(DOW FROM updated_at) AS day_of_week
FROM {{ ref('stg_predictit_raw') }}
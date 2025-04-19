{{ config(materialized='table') }}

SELECT DISTINCT
    contract_id,
    contract_name,
    short_name,
    market_id
FROM {{ ref('stg_predictit_raw') }}
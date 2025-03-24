{{ config(materialized='table') }}

SELECT DISTINCT
    contract_id,
    contract_name,
    market_id
FROM {{ ref('src_market') }}
{{ config(materialized='table') }}
WITH volume_data AS (
    SELECT
        market_id,
        contract_id,
        TO_CHAR(updated_at, 'YYYYMMDD')::int AS date_id,
        last_trade_price
    FROM {{ ref('stg_predictit_raw') }}
    GROUP BY market_id, contract_id, last_trade_price, date_id
)
SELECT
    market_id,
    contract_id,
    date_id,    
    SUM(last_trade_price) AS total_volume_traded
FROM volume_data
WHERE last_trade_price IS NOT NULL
GROUP BY market_id, contract_id, date_id 
ORDER BY market_id, contract_id, date_id 
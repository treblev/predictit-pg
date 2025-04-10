{{ config(materialized='table') }}

WITH price_trends AS (
    SELECT
        market_id,
        contract_id,
        last_trade_price,
        timestamp ,
        LAG(last_trade_price) OVER (PARTITION BY contract_id ORDER BY timestamp) AS prev_price,
        TO_CHAR(timestamp, 'YYYYMMDD')::int AS date_id
    FROM {{ ref('src_market') }}
)
SELECT
    market_id,
    contract_id,
    date_id,
    last_trade_price,
    prev_price,
    (last_trade_price - prev_price) AS price_change,
    CASE
        WHEN prev_price > 0 THEN ((last_trade_price - prev_price) / prev_price) * 100
        ELSE NULL
    END AS price_change_percent,
    COUNT(*) AS record_count
FROM price_trends
WHERE prev_price IS NOT NULL
GROUP BY market_id, contract_id, date_id, last_trade_price, prev_price
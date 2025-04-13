/* join fact_price_movements with dim_markets */
with facts as (
    SELECT * FROM {{ ref('fact_price_movements') }}
),
markets as (
    SELECT * FROM {{ ref('dim_markets') }}
),
contracts as (
    SELECT * FROM {{ ref('dim_contracts') }}
)
SELECT
    f.market_id,
    c.contract_name,
    f.date_id,
    f.last_trade_price,
    f.prev_price,
    f.price_change,
    f.price_change_percent,
    f.record_count,
    m.market_name
FROM facts f
JOIN markets m ON f.market_id = m.market_id
JOIN contracts c ON f.contract_id = c.contract_id
ORDER BY f.market_id, f.contract_id, f.date_id
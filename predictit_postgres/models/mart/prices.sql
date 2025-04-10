with facts as (
    SELECT * FROM {{ ref('fact_price_movements') }}
),
markets as (
    SELECT * FROM {{ ref('dim_markets') }}
)
SELECT
    f.market_id,
    f.contract_id,
    f.date_id,
    f.last_trade_price,
    f.prev_price,
    f.price_change,
    f.price_change_percent,
    f.record_count,
    m.market_name
FROM facts f
JOIN markets m ON f.market_id = m.market_id
ORDER BY f.market_id, f.contract_id, f.date_id
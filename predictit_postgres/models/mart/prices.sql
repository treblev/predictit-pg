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
    m.market_name,
    c.contract_name,
    f.date_id,
    f.last_trade_price,
    f.prev_price,
    sum(f.price_change) AS total_price_change,
    avg(f.price_change_percent) AS avg_price_change_percent,
    count(f.record_count) AS record_count    
FROM facts f
JOIN markets m ON f.market_id = m.market_id
JOIN contracts c ON f.contract_id = c.contract_id
GROUP BY f.market_id, m.market_name, c.contract_name, f.date_id, f.last_trade_price, f.prev_price
ORDER BY f.market_id, m.market_name, f.date_id
{{ config(materialized='view') }}

SELECT
    market_id::int,
    market_name,
    contract_id::int,
    contract_name,
    short_name,
    last_trade_price::float,
    best_buy_yes_price::float,
    best_sell_yes_price::float,
    timestamp::timestamp AS updated_at
FROM {{ source('predictit', 'predictit_data_raw')}}
WHERE last_trade_price IS NOT NULL 
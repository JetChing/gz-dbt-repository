WITH operation AS (
    SELECT 
        ma.orders_id
        ,ma.date_date
        ,ma.quantity
        ,ma.margin
        ,s.shipping_fee
        ,s.logcost
        ,s.ship_cost
    FROM {{ ref('int_orders_margin') }} AS ma
    LEFT JOIN {{ ref('stg_gz_raw_data__ship') }} AS s
    ON ma.orders_id = s.orders_id
)

SELECT 
    orders_id
    ,date_date
    ,ROUND(SUM(margin + shipping_fee - logcost - ship_cost),2) AS operational_margin
    ,SUM(quantity) AS quantity
FROM operation
GROUP BY orders_id, date_date
ORDER BY date_date DESC
WITH operation AS (
    SELECT 
        ma.orders_id
        ,ma.date_date
        ,ma.quantity
        ,ma.margin
        ,ma.revenue
        ,ma.purchase_cost
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
    ,SUM(revenue) AS revenue
    ,ROUND(SUM(margin + shipping_fee - logcost - ship_cost),2) AS operational_margin
    ,SUM(purchase_cost) AS purchase_cost
    ,SUM(shipping_fee) AS shipping_fee
    ,SUM(logcost) AS logcost
    ,SUM(quantity) AS quantity
FROM operation
GROUP BY orders_id, date_date
ORDER BY date_date DESC 
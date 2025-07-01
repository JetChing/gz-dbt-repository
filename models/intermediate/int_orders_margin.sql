WITH sa AS (
    SELECT *
    FROM {{ ref('stg_gz_raw_data__sales') }}
),

pro AS (
    SELECT *
    FROM {{ ref('stg_gz_raw_data__product') }} 
),

cost AS (
    SELECT 
        sa.*,
        pro.purchase_price
    FROM sa
    LEFT JOIN pro
        ON sa.products_id = pro.products_id
),

pur AS (
    SELECT
        *,
        purchase_price * quantity AS purchase_cost
    FROM cost
)

SELECT
    orders_id,
    date_date,
    ROUND(SUM(revenue),2) AS revenue,
    SUM(quantity) AS quantity,
    ROUND(SUM(purchase_cost),2) AS purchase_cost,
    ROUND(SUM(revenue - purchase_cost),2) AS margin
FROM pur
GROUP BY orders_id, date_date
ORDER BY date_date DESC
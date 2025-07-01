WITH sa AS (
    SELECT *
    FROM {{ ref('stg_gz_raw_data__sales') }}
),

 pro AS (
    SELECT *
    FROM {{ ref('stg_gz_raw_data__product') }} 
),

cost AS(
SELECT 
sa.*
,pro.purchase_price
FROM sa
LEFT JOIN pro
ON sa.products_id = pro.products_id),

pur AS (
SELECT
*,
cost.purchase_price * cost.quantity AS purchase_cost
FROM cost)

SELECT
*,
ROUND(revenue - purchase_cost,2) AS margin
FROM pur 




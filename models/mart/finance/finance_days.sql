WITH op_margin AS (
    SELECT 
        date_date
        ,orders_id 
        ,revenue
        ,operational_margin
        ,purchase_cost
        ,shipping_fee
        ,logcost
        ,quantity
    FROM {{ ref('int_orders_operational') }}
)

SELECT
    date_date
    ,COUNT(DISTINCT orders_id) AS total_numer_of_transactions
    ,ROUND(SUM(revenue),2) AS total_revenue
    ,ROUND(AVG(revenue),2) AS average_basket
    ,ROUND(SUM(operational_margin),2) AS operational_margin
    ,ROUND(SUM(purchase_cost),2) AS total_purchase_cost
    ,ROUND(SUM(shipping_fee),2) AS total_shipping_fees
    ,ROUND(SUM(logcost),2) AS total_log_costs
    ,SUM(quantity) AS total_quantity_of_products_sold
  FROM op_margin
  GROUP BY date_date
  ORDER BY date_date DESC
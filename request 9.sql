WITH sales_data AS (
    -- Calculate gross sales for each channel
    SELECT dc.channel, ROUND(SUM(fgp.gross_price * fsm.sold_quantity)) AS gross_sales_mln
    FROM fact_sales_monthly fsm
    JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code
    JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
    WHERE fsm.fiscal_year = 2021
    GROUP BY dc.channel
),
total_sales AS (
    -- Calculate total gross sales for 2021
    SELECT SUM(gross_sales_mln) AS total_gross_sales
    FROM sales_data
)
SELECT sd.channel,
       sd.gross_sales_mln,
       ROUND((sd.gross_sales_mln / ts.total_gross_sales) * 100, 2) AS percentage
FROM sales_data sd
CROSS JOIN total_sales ts
ORDER BY sd.gross_sales_mln DESC
;

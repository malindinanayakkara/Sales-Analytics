WITH product_sales AS (
    -- Calculate total sold quantity for each product in each division for 2021
    SELECT dp.division, fsm.product_code, dp.product, SUM(fsm.sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly fsm
    JOIN dim_product dp ON fsm.product_code = dp.product_code
    WHERE fsm.fiscal_year = 2021
    GROUP BY dp.division, fsm.product_code, dp.product
),
ranked_sales AS (
    -- Rank products within each division based on sold quantity
    SELECT ps.division, ps.product_code, ps.product, ps.total_sold_quantity,
           RANK() OVER (PARTITION BY ps.division ORDER BY ps.total_sold_quantity DESC) AS rank_order
    FROM product_sales ps
)

-- Retrieve the top 3 products per division
SELECT division,
       product_code,
       product,
       total_sold_quantity,
       rank_order
FROM ranked_sales
WHERE rank_order <= 3
ORDER BY division, rank_order;


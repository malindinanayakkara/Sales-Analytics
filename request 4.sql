WITH product_counts AS (
	SELECT dp.segment, COUNT(DISTINCT dp.product_code) AS product_count, fsm.fiscal_year
	FROM fact_sales_monthly fsm
    JOIN dim_product dp ON fsm.product_code = dp.product_code
    WHERE fiscal_year IN (2020,2021)
	GROUP BY dp.segment, fsm.fiscal_year
),
counts AS(
	SELECT segment,
		MAX(CASE WHEN fiscal_year = 2020 THEN product_count ELSE 0 END) AS product_count_2020,
		MAX(CASE WHEN fiscal_year = 2021 THEN product_count ELSE 0 END) AS product_count_2021
    FROM product_counts
    GROUP BY segment
)
SELECT segment,
       product_count_2020,
       product_count_2021,
       (product_count_2021 - product_count_2020) AS difference
FROM counts
ORDER BY difference DESC;
    

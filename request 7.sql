SELECT MONTH(fsm.date) AS month, YEAR(fsm.date) AS year,
       ROUND(SUM(fgp.gross_price * fsm.sold_quantity), 2) AS gross_sales_amount
FROM fact_sales_monthly fsm
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code
WHERE dc.customer = 'Atliq Exclusive'
GROUP BY YEAR(fsm.date), MONTH(fsm.date)
ORDER BY year, month;

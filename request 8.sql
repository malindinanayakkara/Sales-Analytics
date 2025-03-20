SELECT CASE 
           WHEN MONTH(fsm.date) IN (1, 2, 3) THEN 'Q1'
           WHEN MONTH(fsm.date) IN (4, 5, 6) THEN 'Q2'
           WHEN MONTH(fsm.date) IN (7, 8, 9) THEN 'Q3'
           WHEN MONTH(fsm.date) IN (10, 11, 12) THEN 'Q4'
       END AS quarter, 
       SUM(fsm.sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly fsm
WHERE fsm.fiscal_year = 2020
GROUP BY quarter
ORDER BY total_sold_quantity DESC;


       
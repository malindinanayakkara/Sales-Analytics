SELECT dc.customer_code, dc.customer, ROUND(AVG(fpd.pre_invoice_discount_pct), 2) AS average_discount_percentage 
FROM dim_customer AS dc
JOIN fact_pre_invoice_deductions AS fpd
ON dc.customer_code = fpd.customer_code
WHERE fpd.fiscal_year = 2021
  AND dc.market = 'India'
GROUP BY dc.customer_code, dc.customer
ORDER BY average_discount_percentage DESC
LIMIT 5;

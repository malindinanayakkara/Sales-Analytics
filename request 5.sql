SELECT dp.product_code, dp.product, fmc.manufacturing_cost
FROM dim_product AS dp
LEFT JOIN  fact_manufacturing_cost AS fmc
ON dp.product_code = fmc.product_code
WHERE fmc.manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost)
   OR fmc.manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost)
;
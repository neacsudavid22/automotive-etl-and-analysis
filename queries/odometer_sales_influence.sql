SELECT
    CASE 
        WHEN s.odometer BETWEEN 0 AND 10000 THEN '0-10k'
        WHEN s.odometer BETWEEN 10001 AND 20000 THEN '10k-20k'
        WHEN s.odometer BETWEEN 20001 AND 30000 THEN '20k-30k'
        WHEN s.odometer BETWEEN 30001 AND 50000 THEN '30k-50k'
        WHEN s.odometer BETWEEN 50001 AND 70000 THEN '50k-70k'
        WHEN s.odometer BETWEEN 70001 AND 100000 THEN '70k-100k'
        ELSE '100k+'
    END AS km_ran,
    ROUND(AVG(s.selling_price), 2) AS avg_price,
    DENSE_RANK() OVER (ORDER BY ROUND(AVG(s.selling_price), 2) DESC) AS avg_price_rank,
    ROUND(AVG(s.mmr), 2) AS  avg_estimated_market_value,
    DENSE_RANK() OVER (ORDER BY ROUND(AVG(s.mmr), 2) DESC) AS avg_estimated_market_value_rank,
    ROUND(AVG(s.selling_price - s.mmr), 2) AS avg_price_dev_from_market,
    DENSE_RANK() OVER (ORDER BY ROUND(AVG(s.selling_price - s.mmr), 2) DESC) AS avg_price_dev_from_market_rank,
    COUNT(*) AS sales_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS sales_count_rank
FROM vehicle_sales s
WHERE s.odometer IS NOT NULL
GROUP BY
    CASE 
        WHEN s.odometer BETWEEN 0 AND 10000 THEN '0-10k'
        WHEN s.odometer BETWEEN 10001 AND 20000 THEN '10k-20k'
        WHEN s.odometer BETWEEN 20001 AND 30000 THEN '20k-30k'
        WHEN s.odometer BETWEEN 30001 AND 50000 THEN '30k-50k'
        WHEN s.odometer BETWEEN 50001 AND 70000 THEN '50k-70k'
        WHEN s.odometer BETWEEN 70001 AND 100000 THEN '70k-100k'
        ELSE '100k+'
     END
ORDER BY avg_price_rank, avg_estimated_market_value_rank, avg_price_dev_from_market_rank, sales_count_rank;
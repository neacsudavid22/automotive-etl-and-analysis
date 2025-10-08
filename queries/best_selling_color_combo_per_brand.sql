SELECT  BRAND,
        "BEST INTERIOR-EXTERIOR COMBO",
        total_revenue,
        total_sales,
        avg_market_value,
        avg_selling_price
FROM (
    SELECT
        c.brand AS BRAND,
        s.color || '-' || s.interior AS "BEST INTERIOR-EXTERIOR COMBO",
        COUNT(*) AS total_sales,
        ROUND(AVG(s.mmr), 2) AS avg_market_value,
        ROUND(AVG(s.selling_price), 2) AS avg_selling_price,
        ROUND(SUM(s.selling_price), 2) AS total_revenue,
        RANK() OVER (
            PARTITION BY c.brand 
            ORDER BY SUM(s.selling_price) DESC
        ) AS total_revenue_rank_within_brand
    FROM vehicle_sales s
    JOIN vehicle_models m ON s.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    WHERE s.color IS NOT NULL AND s.interior IS NOT NULL
    GROUP BY c.brand, s.color, s.interior
)
WHERE total_revenue_rank_within_brand = 1
ORDER BY total_revenue;

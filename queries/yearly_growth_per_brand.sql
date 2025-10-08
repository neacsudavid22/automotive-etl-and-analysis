WITH revenue_lag AS (
    SELECT
        c.brand,
        s.sale_year,
        SUM(s.selling_price) AS total_revenue,
        LAG(SUM(s.selling_price)) OVER (
            PARTITION BY c.brand ORDER BY s.sale_year
        ) AS prev_year_revenue
    FROM vehicle_sales s
    JOIN vehicle_models m ON s.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    GROUP BY c.brand, s.sale_year
)
SELECT
    brand,
    sale_year,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(prev_year_revenue, 2) AS prev_year_revenue,
    ROUND(total_revenue - prev_year_revenue, 2) AS absolute_growth,
    ROUND(
        (total_revenue - prev_year_revenue)
        / NULLIF(prev_year_revenue, 0) * 100, 2
    ) AS yoy_growth_pct
FROM revenue_lag
ORDER BY brand, sale_year;
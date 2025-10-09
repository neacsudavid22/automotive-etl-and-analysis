WITH brand_revenue AS (
    SELECT c.brand, s.sale_year, SUM(s.selling_price) AS total_revenue
    FROM vehicle_sales s
    JOIN vehicle_models m ON s.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    GROUP BY c.brand, s.sale_year
)
SELECT
    brand,
    sale_year,
    total_revenue,
    LAG(total_revenue) OVER (PARTITION BY brand ORDER BY sale_year) AS prev_year_revenue
FROM brand_revenue;
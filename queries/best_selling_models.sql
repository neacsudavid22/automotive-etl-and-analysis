SELECT DISTINCT brand, model, total_sales
FROM (
    SELECT 
        c.brand as brand,
        m.model_name as model,
        SUM(s.selling_price) AS total_sales,
        RANK() OVER (PARTITION BY c.company_id ORDER BY SUM(s.selling_price) DESC) AS rang
    FROM vehicle_sales s
    JOIN vehicle_models m ON s.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    GROUP BY c.brand, c.company_id, m.model_name
)
WHERE rang = 1
ORDER BY total_sales DESC;
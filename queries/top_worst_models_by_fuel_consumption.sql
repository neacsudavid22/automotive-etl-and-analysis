SELECT * FROM (
    SELECT
        c.brand,
        m.model_name,
        ROUND(AVG(v.fuel_consumption), 2) AS avg_fuel_consumption
    FROM vehicle_versions v
    JOIN vehicle_models m ON v.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    WHERE v.fuel_consumption IS NOT NULL AND v.fuel_consumption > 0
    GROUP BY c.brand, m.model_name
    ORDER BY avg_fuel_consumption DESC
) WHERE ROWNUM <= 10;
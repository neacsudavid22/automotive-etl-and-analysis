WITH electric_avg AS (
    SELECT AVG(electric_range_km) AS avg_range
    FROM vehicle_versions
    WHERE LOWER(energy) LIKE '%electric%'
)
SELECT 
    c.constructor_name,
    m.model_name,
    v.version_code,
    MAX(v.electric_range_km) AS electric_range_km
FROM vehicle_versions v
JOIN vehicle_models m ON v.model_id = m.model_id
JOIN vehicle_companies c ON m.company_id = c.company_id
WHERE LOWER(v.energy) LIKE '%electric%'
GROUP BY c.constructor_name, m.model_name, v.version_code
HAVING MAX(v.electric_range_km) > (SELECT avg_range FROM electric_avg)
ORDER BY electric_range_km DESC;
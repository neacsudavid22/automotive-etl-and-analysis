WITH electric_avg AS (
    SELECT AVG(electric_range_km) AS avg_range
    FROM vehicle_versions
    WHERE LOWER(energy) LIKE '%electric%'
)
SELECT 
    c.constructor_name,
    m.model_name,
    v.version_code,
    v.electric_range_km
FROM vehicle_versions v
JOIN vehicle_models m ON v.model_id = m.model_id
JOIN vehicle_companies c ON m.company_id = c.company_id,
electric_avg ea
WHERE LOWER(v.energy) LIKE '%electric%'
  AND v.electric_range_km > ea.avg_range;
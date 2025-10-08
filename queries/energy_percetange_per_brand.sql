-- Procentul modelelor produse per tip de energie pentru fiecare brand în parte

SELECT
    c.brand,
    v.energy as CONSUMPTION_TYPE,
    ROUND(
        COUNT(DISTINCT m.model_name) * 100.0 
        / SUM(COUNT(DISTINCT m.model_name)) OVER (PARTITION BY c.brand),
        2
    ) || '%' AS BRAND_MODELS_RATIO,
     COUNT(DISTINCT m.model_name) AS nr_modele    
FROM vehicle_versions v
JOIN vehicle_models m ON v.model_id = m.model_id
JOIN vehicle_companies c ON m.company_id = c.company_id
GROUP BY c.brand, v.energy
ORDER BY c.brand, v.energy;
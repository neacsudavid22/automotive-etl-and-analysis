SELECT DISTINCT
    C.brand, M.model_name,
    ROUND(AVG(V.electric_range_km) OVER (PARTITION BY M.model_name), 2) AS Autonomie_medie_Km_Model,
    ROUND(STDDEV(V.electric_range_km) OVER (PARTITION BY M.model_name), 2) AS deviatia_standard_autonomie_Km_Model,
    COUNT(V.version_id) OVER (PARTITION BY M.model_name) AS nr_versiuni_model
FROM vehicle_versions V
JOIN vehicle_models M ON V.model_id = M.model_id
JOIN vehicle_companies C ON M.company_id = C.company_id
WHERE V.electric_range_km > 0 AND ENERGY = 'electric'
ORDER BY Autonomie_medie_Km_Model DESC;
-- media si deviatia standard a emisiilor de co2 a modelelor cu mai multe versiuni 

SELECT C.brand, M.model_name, M.category,
    ROUND(AVG(V.co2_wltp), 2) AS AVG_CO2_Model,
    ROUND(STDDEV(V.co2_wltp), 2) AS STDDEV_CO2_Model
FROM vehicle_versions V
JOIN vehicle_models M ON V.model_id = M.model_id
JOIN vehicle_companies C ON M.company_id = C.company_id
WHERE V.co2_wltp IS NOT NULL AND V.co2_wltp > 0  
GROUP BY C.brand, M.model_name, M.category
HAVING COUNT(V.version_id) >= 2 
ORDER BY STDDEV_CO2_Model DESC; 
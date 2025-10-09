SELECT 
    c.constructor_name,
    m.model_name,
    ROUND(AVG(v.kg_veh), 2) AS avg_weight,
    ROUND(AVG(s.selling_price), 2) AS avg_price,
    ROUND(AVG(s.selling_price)/NULLIF(AVG(v.kg_veh),0), 2) AS price_per_kg
FROM vehicle_sales s
JOIN vehicle_models m ON s.model_id = m.model_id
JOIN vehicle_versions v ON v.model_id = m.model_id
JOIN vehicle_companies c ON m.company_id = c.company_id
GROUP BY c.constructor_name, m.model_name
ORDER BY price_per_kg DESC;
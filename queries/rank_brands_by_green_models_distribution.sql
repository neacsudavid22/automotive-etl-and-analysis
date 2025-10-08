WITH modele_firma AS (
    SELECT
        c.brand,
        COUNT(DISTINCT v.model_id) AS total_modele,
        COUNT(DISTINCT CASE WHEN v.eco_innovation_program = 1 OR v.em_on_target = 1 THEN v.model_id END) AS modelele_verzi
    FROM vehicle_versions v
    JOIN vehicle_models m ON v.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    GROUP BY c.brand
)
SELECT
    brand,
    total_modele,
    modelele_verzi,
    ROUND(modelele_verzi * 100.0 / total_modele, 2) AS procent_modele_verzi,
    DENSE_RANK() OVER (ORDER BY modelele_verzi * 100.0 / total_modele DESC) AS rang_firma
FROM modele_firma
ORDER BY rang_firma;
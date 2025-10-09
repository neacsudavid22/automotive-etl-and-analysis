SELECT 
    LPAD(' ', LEVEL * 5) || name AS hierarchy_element, LEVEL, entity_type
FROM (
    SELECT 
        'C' || company_id AS id,
        NULL AS parent_id,
        brand AS name,
        'Company' AS entity_type
    FROM vehicle_companies
    UNION ALL
    SELECT 
        'M' || model_id AS id,
        'C' || company_id AS parent_id,
        model_name AS name,
        'Model' AS entity_type
    FROM vehicle_models
    UNION ALL
    SELECT 
        'V' || MAX(version_id) AS id,
        'M' || MAX(model_id) AS parent_id,
        version_code AS name,
        'Version' AS entity_type
    FROM vehicle_versions
    GROUP BY version_code
)
START WITH parent_id IS NULL
CONNECT BY PRIOR id = parent_id
ORDER SIBLINGS BY name;
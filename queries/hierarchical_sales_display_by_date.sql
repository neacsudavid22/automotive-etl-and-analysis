SELECT
    LPAD(' ', LEVEL * 5) || name AS hierarchy_element, entity_type, selling_price
FROM (
    SELECT
        'Y-' || sale_year AS id,
        NULL AS parent_id,
        TO_CHAR(sale_year) AS name,
        'Year' AS entity_type,
        NULL AS selling_price
    FROM vehicle_sales
    GROUP BY sale_year
    UNION ALL
    SELECT
        'YM-' || sale_year || '-' || sale_month AS id,
        'Y-' || sale_year AS parent_id,
        sale_month AS name,
        'Month' AS entity_type,
        NULL AS selling_price
    FROM vehicle_sales
    GROUP BY sale_year, sale_month
    UNION ALL
    SELECT
        'S-' || sale_id AS id,
        'YM-' || sale_year || '-' || sale_month AS parent_id,
        'Seller: ' || UPPER(seller) || 
        ' | Price: ' || selling_price || 
        ' | Car: ' || c.brand || ' ' || m.model_name AS name,
        'Sale' AS entity_type,
        selling_price
    FROM (
        SELECT vs.*,
               ROW_NUMBER() OVER (PARTITION BY sale_year, sale_month ORDER BY selling_price DESC) AS rn
        FROM vehicle_sales vs
    ) vs
    JOIN vehicle_models m ON vs.model_id = m.model_id
    JOIN vehicle_companies c ON m.company_id = c.company_id
    WHERE rn <= 5
)
START WITH parent_id IS NULL
CONNECT BY PRIOR id = parent_id
ORDER SIBLINGS BY selling_price DESC , ID ASC
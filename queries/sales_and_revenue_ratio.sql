SELECT 
    v.energy AS energy_type,
    COUNT(s.sale_id) AS total_sales,
    ROUND(COUNT(s.sale_id) * 100.0 / SUM(COUNT(s.sale_id)) OVER (), 2) AS sales_ratio_pct,
    ROUND(AVG(s.selling_price), 2) AS avg_selling_price,
    ROUND(AVG(s.mmr), 2) AS avg_market_price,
    ROUND(SUM(s.selling_price), 2) AS total_revenue,
    ROUND(SUM(s.selling_price) * 100.0 / SUM(SUM(s.selling_price)) OVER (), 2) AS revenue_ratio_pct
FROM vehicle_sales s
JOIN vehicle_models m ON s.model_id = m.model_id
JOIN vehicle_versions v ON v.model_id = m.model_id
GROUP BY v.energy
ORDER BY total_revenue DESC;

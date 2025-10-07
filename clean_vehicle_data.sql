CREATE TABLE clean_vehicle_data AS
SELECT DISTINCT
    UPPER(TRIM(constructor_name)) as constructor_name,
    vehicle_type,
    version,
    UPPER(TRIM(brand)) as brand,
    UPPER(TRIM(vehicle_model)) as vehicle_model,
    vehicle_category,
    kg_veh,
    test_mass,
    co2_wltp,
    wheelbase_mm,
    axle_width_steer_mm,
    axle_width_other_mm,
    energy,
    engine_cm3,
    power_kw,
    el_consumpt_whkm,
    year,
    fuel_consumption,
    electric_range_km,
    eco_innovation_program,
    em_on_target
FROM raw_vehicle_data;

SELECT 'rows inserted: ' || COUNT(*) AS message
FROM clean_vehicle_data;
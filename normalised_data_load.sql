INSERT INTO vehicle_companies (constructor_name, brand)
SELECT DISTINCT UPPER(TRIM(constructor_name)), UPPER(TRIM(brand))
FROM clean_vehicle_data;

INSERT INTO vehicle_models (company_id, model_name, vehicle_type, category)
SELECT DISTINCT 
    c.company_id,
    UPPER(TRIM(cl.vehicle_model)) AS model_name,
    cl.vehicle_type,
    cl.vehicle_category
FROM clean_vehicle_data cl
JOIN vehicle_companies c 
  ON UPPER(TRIM(c.constructor_name)) = UPPER(TRIM(cl.constructor_name))
  AND UPPER(TRIM(c.brand)) = UPPER(TRIM(cl.brand));

INSERT INTO vehicle_versions (
    model_id, version_code, kg_veh, test_mass, co2_wltp,
    wheelbase_mm, axle_width_steer_mm, axle_width_other_mm,
    energy, engine_cm3, power_kw, el_consumpt_whkm,
    year, fuel_consumption, electric_range_km,
    eco_innovation_program, em_on_target
)
SELECT 
    m.model_id, cl.version, cl.kg_veh, cl.test_mass, cl.co2_wltp,
    cl.wheelbase_mm, cl.axle_width_steer_mm, cl.axle_width_other_mm,
    cl.energy, cl.engine_cm3, cl.power_kw, cl.el_consumpt_whkm,
    cl.year, cl.fuel_consumption, cl.electric_range_km,
    cl.eco_innovation_program, cl.em_on_target
FROM clean_vehicle_data cl
JOIN vehicle_companies c
  ON UPPER(TRIM(c.constructor_name)) = UPPER(TRIM(cl.constructor_name))
  AND UPPER(TRIM(c.brand)) = UPPER(TRIM(cl.brand))
JOIN vehicle_models m
  ON m.company_id = c.company_id
  AND UPPER(TRIM(m.model_name)) = UPPER(TRIM(cl.vehicle_model))
  AND UPPER(TRIM(m.vehicle_type)) = UPPER(TRIM(cl.vehicle_type))
  AND UPPER(TRIM(m.category)) = UPPER(TRIM(cl.vehicle_category));
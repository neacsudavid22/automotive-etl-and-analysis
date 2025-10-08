CREATE TABLE vehicle_companies (
    company_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    constructor_name VARCHAR2(100),
    brand VARCHAR2(100)
);

CREATE TABLE vehicle_models (
    model_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id NUMBER,
    model_name VARCHAR2(100),
    vehicle_type VARCHAR2(50),
    category VARCHAR2(10),
    FOREIGN KEY (company_id) REFERENCES vehicle_companies(company_id)
);

CREATE TABLE vehicle_versions (
    version_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    model_id NUMBER,
    version_code VARCHAR2(50),
    kg_veh NUMBER,
    test_mass NUMBER,
    co2_wltp NUMBER,
    wheelbase_mm NUMBER,
    axle_width_steer_mm NUMBER,
    axle_width_other_mm NUMBER,
    energy VARCHAR2(50),
    engine_cm3 NUMBER,
    power_kw NUMBER,
    el_consumpt_whkm NUMBER,
    fuel_consumption NUMBER,
    electric_range_km NUMBER,
    eco_innovation_program NUMBER,
    em_on_target NUMBER,
    FOREIGN KEY (model_id) REFERENCES vehicle_models(model_id)
);

CREATE TABLE vehicle_sales (
    sale_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    model_id NUMBER,
    car_size VARCHAR2(50),
    transmission VARCHAR2(20),
    car_state VARCHAR2(10),
    car_condition VARCHAR2(10),
    odometer NUMBER,
    color VARCHAR2(30),
    interior VARCHAR2(30),
    seller VARCHAR2(100),
    mmr NUMBER,
    selling_price NUMBER,
    sale_day VARCHAR2(10),
    sale_month VARCHAR2(10),
    sale_year NUMBER,
    FOREIGN KEY (model_id) REFERENCES vehicle_models(model_id)
);
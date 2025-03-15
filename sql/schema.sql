CREATE SCHEMA crop;
comment ON schema crop IS 'Classification structure:
Group -> Class -> Subclass -> Order -> Crop -> {Cultivar | Rootstock}

Combination of:
- Indicative Crop Classification (ICC) 1.1
- World Census of Agriculture (WCA) Crop List of the Food and Agriculture Organization of the United Nations
- Fruit and Nut Cultivars Database (FNC)

https://www.fao.org/statistics/caliper/classifications/icc
https://www.fao.org/statistics/caliper/classifications/wca
https://www.fruitandnutlist.org/data/ajax-response';
CREATE TABLE crop.icc_group (icc_group_code TEXT PRIMARY KEY, icc_group_name TEXT NOT NULL);
comment ON TABLE crop.icc_group IS 'Table storing ICC group details';
comment ON COLUMN crop.icc_group.icc_group_code IS 'Unique code for each ICC group';
comment ON COLUMN crop.icc_group.icc_group_name IS 'Name of the ICC group';
CREATE TABLE crop.icc_class (
  icc_class_code TEXT PRIMARY KEY,
  icc_class_group_code TEXT NOT NULL REFERENCES crop.icc_group (icc_group_code) ON DELETE cascade,
  icc_class_name TEXT NOT NULL
);
comment ON TABLE crop.icc_class IS 'Table storing ICC class details';
comment ON COLUMN crop.icc_class.icc_class_code IS 'Unique code for each ICC class';
comment ON COLUMN crop.icc_class.icc_class_group_code IS 'Foreign key referencing icc_group_code';
comment ON COLUMN crop.icc_class.icc_class_name IS 'Name of the ICC class';
CREATE TABLE crop.icc_subclass (
  icc_subclass_code TEXT PRIMARY KEY,
  icc_subclass_class_code TEXT NOT NULL REFERENCES crop.icc_class (icc_class_code) ON DELETE cascade,
  icc_subclass_name TEXT NOT NULL
);
comment ON TABLE crop.icc_subclass IS 'Table storing ICC subclass details';
comment ON COLUMN crop.icc_subclass.icc_subclass_code IS 'Unique code for each ICC subclass';
comment ON COLUMN crop.icc_subclass.icc_subclass_class_code IS 'Foreign key referencing icc_class_code';
comment ON COLUMN crop.icc_subclass.icc_subclass_name IS 'Name of the ICC subclass';
CREATE TABLE crop.icc_order (
  icc_order_code TEXT PRIMARY KEY,
  icc_order_subclass_code TEXT NOT NULL REFERENCES crop.icc_subclass (icc_subclass_code) ON DELETE cascade,
  icc_order_name TEXT NOT NULL
);
comment ON TABLE crop.icc_order IS 'Table storing ICC order details';
comment ON COLUMN crop.icc_order.icc_order_code IS 'Unique code for each ICC order';
comment ON COLUMN crop.icc_order.icc_order_subclass_code IS 'Foreign key referencing icc_subclass_code';
comment ON COLUMN crop.icc_order.icc_order_name IS 'Name of the ICC order';
CREATE TABLE crop.wca_crop (
  wca_crop_code INT PRIMARY KEY,
  wca_crop_icc_code TEXT NOT NULL,
  wca_crop_name TEXT NOT NULL,
  wca_crop_scientific_name TEXT NOT NULL
);
comment ON TABLE crop.wca_crop IS 'Table representing WCA crop data, including both common and scientific names. Paired to an ICC code';
comment ON COLUMN crop.wca_crop.wca_crop_code IS 'Unique integer code identifying each WCA crop';
comment ON COLUMN crop.wca_crop.wca_crop_icc_code IS 'ICC code, linking WCA crops to the ICC classification system';
comment ON COLUMN crop.wca_crop.wca_crop_name IS 'Common name of the crop';
comment ON COLUMN crop.wca_crop.wca_crop_scientific_name IS 'Scientific name of the crop (e.g., genus and species)';
CREATE TABLE crop.cultivar (
  cultivar_code serial PRIMARY KEY,
  cultivar_wca_crop_code INT NOT NULL REFERENCES crop.wca_crop (wca_crop_code),
  cultivar_name TEXT NOT NULL,
  cultivar_fnc_crop_name TEXT NOT NULL,
  cultivar_description TEXT
);
comment ON TABLE crop.cultivar IS 'Table storing different cultivars (specific varieties) of crops';
comment ON COLUMN crop.cultivar.cultivar_code IS 'Unique identifier for each cultivar';
comment ON COLUMN crop.cultivar.cultivar_wca_crop_code IS 'Foreign key referencing wca_crop_code in the crops table, linking each cultivar to its parent crop';
comment ON COLUMN crop.cultivar.cultivar_name IS 'Name of the cultivar';
comment ON COLUMN crop.cultivar.cultivar_fnc_crop_name IS 'Imported FNC crop name';
comment ON COLUMN crop.cultivar.cultivar_description IS 'Optional description of the cultivar, providing more details about its characteristics or origin';
CREATE TABLE crop.cultivar_attribute (
  cultivar_attribute_id serial PRIMARY KEY,
  cultivar_attribute_cultivar_code INT NOT NULL REFERENCES crop.cultivar (cultivar_code),
  cultivar_attribute_name TEXT NOT NULL,
  cultivar_attribute_value TEXT NOT NULL
);
comment ON TABLE crop.cultivar_attribute IS 'Key-value pairs representing additional characteristics or traits for each cultivar';
comment ON COLUMN crop.cultivar_attribute.cultivar_attribute_id IS 'Unique identifier for each attribute entry';
comment ON COLUMN crop.cultivar_attribute.cultivar_attribute_cultivar_code IS 'Foreign key linking the attribute to a specific cultivar';
comment ON COLUMN crop.cultivar_attribute.cultivar_attribute_name IS 'Name of the attribute (e.g., "drought tolerance", "fruit size")';
comment ON COLUMN crop.cultivar_attribute.cultivar_attribute_value IS 'Value of the attribute (e.g., "high", "medium", "large")';
CREATE TABLE crop.rootstock (
  rootstock_code serial PRIMARY KEY,
  rootstock_wca_crop_code INT NOT NULL REFERENCES crop.wca_crop (wca_crop_code),
  rootstock_name TEXT NOT NULL,
  rootstock_fnc_crop_name TEXT NOT NULL,
  rootstock_description TEXT
);
comment ON TABLE crop.rootstock IS 'Table representing rootstocks — specialized plants used for grafting other crops';
comment ON COLUMN crop.rootstock.rootstock_code IS 'Unique identifier for each rootstock';
comment ON COLUMN crop.rootstock.rootstock_wca_crop_code IS 'Foreign key referencing wca_crop_code in the crops table, linking rootstock to its parent crop';
comment ON COLUMN crop.rootstock.rootstock_name IS 'Name of the rootstock';
comment ON COLUMN crop.rootstock.rootstock_fnc_crop_name IS 'Imported FNC crop name';
comment ON COLUMN crop.rootstock.rootstock_description IS 'Optional description of the rootstock, providing details like disease resistance or growth behavior';
CREATE TABLE crop.rootstock_attribute (
  rootstock_attribute_id serial PRIMARY KEY,
  rootstock_attribute_rootstock_code INT NOT NULL REFERENCES crop.rootstock (rootstock_code),
  rootstock_attribute_name TEXT NOT NULL,
  rootstock_attribute_value TEXT NOT NULL
);
comment ON TABLE crop.rootstock_attribute IS 'Key-value pairs representing additional characteristics or traits for each rootstock';
comment ON COLUMN crop.rootstock_attribute.rootstock_attribute_id IS 'Unique identifier for each rootstock attribute entry';
comment ON COLUMN crop.rootstock_attribute.rootstock_attribute_rootstock_code IS 'Foreign key linking the attribute to a specific rootstock';
comment ON COLUMN crop.rootstock_attribute.rootstock_attribute_name IS 'Name of the rootstock attribute (e.g., "growth rate", "disease resistance")';
comment ON COLUMN crop.rootstock_attribute.rootstock_attribute_value IS 'Value of the rootstock attribute (e.g., "vigorous", "high resistance")';

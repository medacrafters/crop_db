CREATE OR REPLACE VIEW crop.all_cultivars_with_all_data AS
SELECT
  cultivar.cultivar_name,
  cultivar.cultivar_fnc_crop_name,
  cultivar.cultivar_description,
  wca.icc_classification,
  wca.icc_code,
  wca.icc_level,
  wca.wca_crop_name,
  wca.wca_crop_code,
  wca.wca_crop_scientific_name,
  crop.all_cultivars_with_attributes.*
FROM
  crop.cultivar cultivar
  JOIN crop.all_crops_with_classifications wca ON cultivar.cultivar_wca_crop_code = wca.wca_crop_code
  LEFT JOIN crop.all_cultivars_with_attributes ON cultivar.cultivar_code = all_cultivars_with_attributes.cultivar_code
ORDER BY
  cultivar.cultivar_code ASC;
comment ON view crop.all_cultivars_with_all_data IS 'All cultivars with all data';

CREATE OR REPLACE VIEW crop.all_cultivars_with_crops AS
SELECT
  cultivar.cultivar_name,
  cultivar.cultivar_fnc_crop_name,
  cultivar.cultivar_description,
  wca.wca_crop_name,
  wca.wca_crop_scientific_name
FROM
  crop.cultivar cultivar
  JOIN crop.all_crops_with_classifications wca ON cultivar.cultivar_wca_crop_code = wca.wca_crop_code
ORDER BY
  cultivar.cultivar_code ASC;
comment ON view crop.all_cultivars_with_crops IS 'All cultivars with crops';

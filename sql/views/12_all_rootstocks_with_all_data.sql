CREATE OR REPLACE VIEW crop.all_rootstocks_with_all_data AS
SELECT
  rootstock.rootstock_name,
  rootstock.rootstock_fnc_crop_name,
  rootstock.rootstock_description,
  wca.icc_classification,
  wca.icc_code,
  wca.icc_level,
  wca.wca_crop_name,
  wca.wca_crop_code,
  wca.wca_crop_scientific_name,
  crop.all_rootstocks_with_attributes.*
FROM
  crop.rootstock rootstock
  JOIN crop.all_crops_with_classifications wca ON rootstock.rootstock_wca_crop_code = wca.wca_crop_code
  LEFT JOIN crop.all_rootstocks_with_attributes ON rootstock.rootstock_code = all_rootstocks_with_attributes.rootstock_code
ORDER BY
  rootstock.rootstock_code ASC;
comment ON view crop.all_rootstocks_with_all_data IS 'All rootstocks with all data';

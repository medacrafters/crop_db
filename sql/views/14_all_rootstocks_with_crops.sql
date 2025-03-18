CREATE OR REPLACE VIEW crop.all_rootstocks_with_crops AS
SELECT
  rootstock.rootstock_name,
  rootstock.rootstock_fnc_crop_name,
  rootstock.rootstock_description,
  wca.wca_crop_name,
  wca.wca_crop_scientific_name
FROM
  crop.rootstock rootstock
  JOIN crop.all_crops_with_classifications wca ON rootstock.rootstock_wca_crop_code = wca.wca_crop_code
ORDER BY
  rootstock.rootstock_code ASC;
comment ON view crop.all_rootstocks_with_crops IS 'All rootstocks with crops';

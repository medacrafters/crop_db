CREATE VIEW crop.all_crops_with_classifications AS
SELECT
  wca.wca_crop_icc_code AS icc_code,
  icc.level AS icc_level,
  icc.classification AS icc_classification,
  wca.wca_crop_code,
  wca.wca_crop_name,
  wca.wca_crop_scientific_name
FROM
  crop.wca_crop wca
  JOIN crop.all_icc_classifications icc ON wca.wca_crop_icc_code = icc.code
ORDER BY
  wca.wca_crop_code ASC;
comment ON view crop.all_crops_with_classifications IS 'All wca crops with their icc classifications';

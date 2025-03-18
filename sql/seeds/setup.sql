-- Schema setup
\i 'sql/schema.sql'

-- Data setup
\i 'sql/data/01_icc_classification_data.sql'
\i 'sql/data/02_wca_crop_data.sql'
\i 'sql/data/03_cultivar_data.sql'
\i 'sql/data/04_cultivar_attribute_data.sql'
\i 'sql/data/05_rootstock_data.sql'
\i 'sql/data/06_rootstock_attribute_data.sql'

-- Functions setup - not used in setup, but used to create queries we used to make some of the views
\i 'sql/functions/get_cultivar_attributes_query.sql'
\i 'sql/functions/get_rootstock_attributes_query.sql'

-- Views setup
\i 'sql/views/07_all_icc_classifications.sql'
\i 'sql/views/08_all_crops_with_classifications.sql'
\i 'sql/views/09_all_cultivars_with_attributes.sql'
\i 'sql/views/10_all_rootstocks_with_attributes.sql'
\i 'sql/views/11_all_cultivars_with_all_data.sql'
\i 'sql/views/12_all_rootstocks_with_all_data.sql'
\i 'sql/views/13_all_cultivars_with_crops.sql'
\i 'sql/views/14_all_rootstocks_with_crops.sql'

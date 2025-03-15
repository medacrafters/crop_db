CREATE VIEW crop.view_icc_classifications AS
SELECT
  'Group' AS level,
  icc_group_code AS code,
  icc_group_name AS name,
  NULL AS parent_code,
  NULL AS grandparent_code,
  NULL AS great_grandparent_code
FROM
  crop.icc_group
UNION ALL
SELECT
  'Class' AS level,
  icc_class_code AS code,
  icc_class_name AS name,
  icc_class_group_code AS parent_code,
  NULL AS grandparent_code,
  NULL AS great_grandparent_code
FROM
  crop.icc_class
UNION ALL
SELECT
  'Subclass' AS level,
  icc_subclass_code AS code,
  icc_subclass_name AS name,
  icc_subclass_class_code AS parent_code,
  crop.icc_class.icc_class_group_code AS grandparent_code,
  NULL AS great_grandparent_code
FROM
  crop.icc_subclass
  JOIN crop.icc_class ON icc_subclass_class_code = crop.icc_class.icc_class_code
UNION ALL
SELECT
  'Order' AS level,
  icc_order_code AS code,
  icc_order_name AS name,
  icc_order_subclass_code AS parent_code,
  crop.icc_subclass.icc_subclass_class_code AS grandparent_code,
  crop.icc_class.icc_class_group_code AS great_grandparent_code
FROM
  crop.icc_order
  JOIN crop.icc_subclass ON icc_order_subclass_code = crop.icc_subclass.icc_subclass_code
  JOIN crop.icc_class ON crop.icc_subclass.icc_subclass_class_code = crop.icc_class.icc_class_code
ORDER BY
  code ASC;
comment ON view crop.view_icc_classifications IS 'Union on Group, Class, Subclass, Order. Ordered by ICC code';
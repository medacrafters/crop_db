CREATE VIEW crop.all_rootstocks_with_attributes AS
SELECT
  rootstock.rootstock_code,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'origin' THEN attr.rootstock_attribute_value
    END
  ) AS origin,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'plant' THEN attr.rootstock_attribute_value
    END
  ) AS plant,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'rootstock_performance' THEN attr.rootstock_attribute_value
    END
  ) AS rootstock_performance,
  ARRAY_AGG(attr.rootstock_attribute_value) FILTER (
    WHERE
      attr.rootstock_attribute_name = 'alias'
      AND attr.rootstock_attribute_value IS NOT NULL
  ) AS alias,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'tree' THEN attr.rootstock_attribute_value
    END
  ) AS tree,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'fruit' THEN attr.rootstock_attribute_value
    END
  ) AS fruit,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'vine' THEN attr.rootstock_attribute_value
    END
  ) AS vine,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'leaves' THEN attr.rootstock_attribute_value
    END
  ) AS leaves,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'pit' THEN attr.rootstock_attribute_value
    END
  ) AS pit,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'flower' THEN attr.rootstock_attribute_value
    END
  ) AS flower,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'rootstock_traits' THEN attr.rootstock_attribute_value
    END
  ) AS rootstock_traits,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'nut' THEN attr.rootstock_attribute_value
    END
  ) AS nut,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'scion_performance' THEN attr.rootstock_attribute_value
    END
  ) AS scion_performance,
  MAX(
    CASE
      WHEN attr.rootstock_attribute_name = 'bush' THEN attr.rootstock_attribute_value
    END
  ) AS bush
FROM
  crop.rootstock rootstock
  LEFT JOIN crop.rootstock_attribute attr ON rootstock.rootstock_code = attr.rootstock_attribute_rootstock_code
GROUP BY
  rootstock.rootstock_code
ORDER BY
  rootstock.rootstock_code;
comment ON view crop.all_rootstocks_with_attributes IS 'All rootstocks with their attributes';

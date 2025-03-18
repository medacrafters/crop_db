CREATE VIEW crop.all_cultivars_with_attributes AS
SELECT
  cultivar.cultivar_code,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'fruit' THEN attr.cultivar_attribute_value
    END
  ) AS fruit,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'tree' THEN attr.cultivar_attribute_value
    END
  ) AS tree,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'origin' THEN attr.cultivar_attribute_value
    END
  ) AS origin,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'plant' THEN attr.cultivar_attribute_value
    END
  ) AS plant,
  ARRAY_AGG(attr.cultivar_attribute_value) FILTER (
    WHERE
      attr.cultivar_attribute_name = 'alias'
      AND attr.cultivar_attribute_value IS NOT NULL
  ) AS alias,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'nut' THEN attr.cultivar_attribute_value
    END
  ) AS nut,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'vine' THEN attr.cultivar_attribute_value
    END
  ) AS vine,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'cluster' THEN attr.cultivar_attribute_value
    END
  /* sql-formatter-disable */
  ) AS cluster,
  /* sql-formatter-enable */
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'berry' THEN attr.cultivar_attribute_value
    END
  ) AS berry,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'bush' THEN attr.cultivar_attribute_value
    END
  ) AS bush,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'flesh' THEN attr.cultivar_attribute_value
    END
  ) AS flesh,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'season' THEN attr.cultivar_attribute_value
    END
  ) AS season,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'skin' THEN attr.cultivar_attribute_value
    END
  ) AS skin,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'shape' THEN attr.cultivar_attribute_value
    END
  ) AS shape,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'weight' THEN attr.cultivar_attribute_value
    END
  ) AS weight,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'size' THEN attr.cultivar_attribute_value
    END
  ) AS size,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'kernel' THEN attr.cultivar_attribute_value
    END
  ) AS kernel,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'blossom' THEN attr.cultivar_attribute_value
    END
  ) AS blossom,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'flower' THEN attr.cultivar_attribute_value
    END
  ) AS flower,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'shell' THEN attr.cultivar_attribute_value
    END
  ) AS shell,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'bloom' THEN attr.cultivar_attribute_value
    END
  ) AS bloom,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'parentage' THEN attr.cultivar_attribute_value
    END
  ) AS parentage,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'bunch' THEN attr.cultivar_attribute_value
    END
  ) AS bunch,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'leaves' THEN attr.cultivar_attribute_value
    END
  ) AS leaves,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'pseudostem' THEN attr.cultivar_attribute_value
    END
  ) AS pseudostem,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'harvest' THEN attr.cultivar_attribute_value
    END
  ) AS harvest,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'bean' THEN attr.cultivar_attribute_value
    END
  ) AS bean,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'cyme' THEN attr.cultivar_attribute_value
    END
  ) AS cyme,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'wine' THEN attr.cultivar_attribute_value
    END
  ) AS wine,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'rootstock' THEN attr.cultivar_attribute_value
    END
  ) AS rootstock,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'pollination' THEN attr.cultivar_attribute_value
    END
  ) AS pollination,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'palm' THEN attr.cultivar_attribute_value
    END
  ) AS palm,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'note' THEN attr.cultivar_attribute_value
    END
  ) AS note,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'pit' THEN attr.cultivar_attribute_value
    END
  ) AS pit,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'storage' THEN attr.cultivar_attribute_value
    END
  ) AS storage,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'chilling_requirement' THEN attr.cultivar_attribute_value
    END
  ) AS chilling_requirement,
  MAX(
    CASE
      WHEN attr.cultivar_attribute_name = 'seed' THEN attr.cultivar_attribute_value
    END
  ) AS seed
FROM
  crop.cultivar cultivar
  LEFT JOIN crop.cultivar_attribute attr ON cultivar.cultivar_code = attr.cultivar_attribute_cultivar_code
GROUP BY
  cultivar.cultivar_code
ORDER BY
  cultivar.cultivar_code;
comment ON view crop.all_cultivars_with_attributes IS 'All cultivars with their attributes';

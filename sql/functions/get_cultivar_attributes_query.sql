/*
Generate cultivar with attributes query dynamically
*/
CREATE FUNCTION crop.get_cultivar_attributes_query () returns TEXT AS $$
DECLARE
  attr_list text;
  final_query text;
BEGIN
  -- Build the dynamic list of columns
  SELECT
    string_agg(
      CASE WHEN cultivar_attribute_name = 'alias' THEN
        -- alias gets ARRAY_AGG
        format('ARRAY_AGG(attr.cultivar_attribute_value)
          FILTER (WHERE attr.cultivar_attribute_name = %L AND attr.cultivar_attribute_value IS NOT NULL) AS %I', 'alias', 'alias')
      ELSE
        -- All other attributes use MAX()
        format('MAX(CASE WHEN attr.cultivar_attribute_name = %L THEN attr.cultivar_attribute_value END) AS %I', cultivar_attribute_name, cultivar_attribute_name)
      END, ', ') INTO attr_list
  FROM (
    -- Order attributes by count of how frequently they appear
    SELECT
      cultivar_attribute_name
    FROM
      crop.cultivar_attribute
    GROUP BY
      cultivar_attribute_name
    ORDER BY
      COUNT(*) DESC) sub;
  -- Final query using attr_list
  final_query := format('SELECT cultivar.cultivar_code, %s
    FROM crop.cultivar cultivar
    LEFT JOIN crop.cultivar_attribute attr ON cultivar.cultivar_code = attr.cultivar_attribute_cultivar_code
    GROUP BY cultivar.cultivar_code
    ORDER BY cultivar.cultivar_code;', attr_list);
  RETURN final_query;
END
$$ language plpgsql;

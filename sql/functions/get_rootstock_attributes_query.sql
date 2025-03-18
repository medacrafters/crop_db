/*
Generate rootstock with attributes query dynamically
*/
CREATE FUNCTION crop.get_rootstock_attributes_query () returns TEXT AS $$
DECLARE
  attr_list text;
  final_query text;
BEGIN
  -- Build the dynamic list of columns
  SELECT
    string_agg(
      CASE WHEN rootstock_attribute_name = 'alias' THEN
        -- alias gets ARRAY_AGG
        format('ARRAY_AGG(attr.rootstock_attribute_value)
          FILTER (WHERE attr.rootstock_attribute_name = %L AND attr.rootstock_attribute_value IS NOT NULL) AS %I', 'alias', 'alias')
      ELSE
        -- All other attributes use MAX()
        format('MAX(CASE WHEN attr.rootstock_attribute_name = %L THEN attr.rootstock_attribute_value END) AS %I', rootstock_attribute_name, rootstock_attribute_name)
      END, ', ') INTO attr_list
  FROM (
    -- Order attributes by count of how frequently they appear
    SELECT
      rootstock_attribute_name
    FROM
      crop.rootstock_attribute
    GROUP BY
      rootstock_attribute_name
    ORDER BY
      COUNT(*) DESC) sub;
  -- Final query using attr_list
  final_query := format('SELECT rootstock.rootstock_code, %s
    FROM crop.rootstock rootstock
    LEFT JOIN crop.rootstock_attribute attr ON rootstock.rootstock_code = attr.rootstock_attribute_rootstock_code
    GROUP BY rootstock.rootstock_code
    ORDER BY rootstock.rootstock_code;', attr_list);
  RETURN final_query;
END
$$ language plpgsql;

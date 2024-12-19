WITH parsed_wish_lists AS
(
  SELECT
    child_id,
  	wishes::json->>'first_choice' as primary_wish,
    wishes::json->>'second_choice' as backup_wish,
    (wishes::jsonb->'colors')->>0 as favorite_color,
    jsonb_array_length(wishes::jsonb->'colors') as color_count
  FROM wish_lists
)

SELECT
	name || ',' ||
    primary_wish || ',' ||
    backup_wish || ',' ||
    favorite_color || ',' ||
    color_count || ',' ||
    CASE 
    	WHEN difficulty_to_make = 1 THEN 'Simple Gift'
        WHEN difficulty_to_make = 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END || ',' ||
    CASE
    	WHEN category = 'outside' THEN 'Outside Workshop'
        WHEN category = 'educational' THEN 'Learning Workshop'
       	ELSE 'General Workshop'
    END AS csv_row
FROM parsed_wish_lists w 
JOIN children c ON w.child_id = c.child_id
JOIN toy_catalogue t ON t.toy_name = w.primary_wish
ORDER BY name
LIMIT 5;

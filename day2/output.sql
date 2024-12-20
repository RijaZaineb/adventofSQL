SELECT string_agg(character,'')
FROM 
(
  SELECT chr(value) as character
  FROM letters_a
  UNION ALL
  SELECT chr(value) 
  FROM letters_b
) AS sub
WHERE character ~* '[a-zA-Z!,-.:;?\s"()]';

SELECT * 
FROM (
	SELECT *
	FROM pet 
	ORDER BY birth) AS tab
LIMIT 2;

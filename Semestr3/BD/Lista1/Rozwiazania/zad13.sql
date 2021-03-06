SELECT name
FROM pet
WHERE  birth =  (SELECT MAX(birth) FROM pet) AND death IS NULL;


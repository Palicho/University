CREATE VIEW tab AS
SELECT pet.name FROM pet 
INNER JOIN event ON  event.name = pet.name 
WHERE event.type LIKE 'birthday';

SELECT owner, name 
FROM pet 
WHERE name NOT IN( SELECT * from tab)
ORDER BY name DESC; 
	

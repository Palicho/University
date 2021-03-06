CREATE VIEW t AS
SELECT DISTINCT owner, pet.name 
FROM pet INNER JOIN event ON pet.name = event.name
WHERE event.type = 'birthday';

SELECT DISTINCT owner FROM pet WHERE owner NOT IN ( SELECT owner FROM t);

DROP VIEW t;

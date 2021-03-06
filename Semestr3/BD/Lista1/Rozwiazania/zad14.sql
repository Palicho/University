SELECT DISTINCT owner FROM event INNER JOIN pet ON event.name= pet.name 
WHERE date <(SELECT MIN(date) FROM event WHERE name='Slim' AND type='vet'); 




UPDATE event
SET event.performer= (SELECT DISTINCT owner FROM pet WHERE event.name=pet.name) 
WHERE type NOT LIKE 'vet' AND type NOT LIKE 'litter';

UPDATE event 
SET performer = 'January'
WHERE performer IS NULL AND type LIKE 'vet';

UPDATE event 
SET performer = 'August'
WHERE performer IS NULL;

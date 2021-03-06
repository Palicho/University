SELECT species, COUNT(species) AS amount
FROM pet
GROUP BY species;


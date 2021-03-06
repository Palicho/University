SELECT DISTINCT a.owner, b.owner FROM pet a , pet b
WHERE a.species=b.species  AND a.owner < b.owner;


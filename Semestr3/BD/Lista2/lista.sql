#1
CREATE DATABASE IF NOT EXISTS hobby;

CREATE USER IF NOT EXISTS 'konrad'@'localhost';
SET PASSWORD FOR 'konrad'@'localhost' = PASSWORD('231052');


GRANT SELECT, INSERT, ALTER  ON  hobby.* TO 'konrad'@'localhost';

#2

CREATE TABLE IF NOT EXISTS  osoba(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	imie varchar(20) NOT NULL,
	dataUrodzenia date NOT NULL CHECK(  TIMESTAMPDIFF(YEAR, dataUrodzenia, '2019-11-18') >= 18  ),
	plec char(1) NOT NULL
);

 
CREATE TABLE IF NOT EXISTS  hobby(
	osoba int NOT NULL,
	id int NOT NULL ,
	typ ENUM('sport', 'nauka', 'inne')  NOT NULL,
	PRIMARY KEY (osoba, id , typ)
);

 

CREATE TABLE IF NOT EXISTS  inne(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nazwa varchar(20) NOT NULL,
	towarzysze boolean DEFAULT 1,
	lokacja varchar(20)
);

CREATE TABLE IF NOT EXISTS  nauka(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nazwa varchar(20) NOT NULL,
	lokacja varchar(20)
);

CREATE TABLE IF NOT EXISTS  sport(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nazwa varchar(20) NOT NULL,
	typ ENUM('indywidualny', 'druzynowy', 'mieszany') DEFAULT  'druzynowy',
	lokacja varchar(20)
);

#3
CREATE TABLE  IF NOT EXISTS zwierzak
(
  name    VARCHAR(20),
  owner   VARCHAR(20),
  species VARCHAR(20),
  sex     CHAR(1),
  birth   DATE,
  death   DATE
);


LOAD DATA LOCAL INFILE '/home/oleksy/Documents/University/Semestr3/BD/Lista1/pet.txt' INTO TABLE zwierzak;

UPDATE zwierzak 
SET sex='f'
WHERE name='Whistler';
DROP TABLE IF EXISTS pet;

INSERT INTO osoba (imie, dataUrodzenia,plec)
SELECT name, birth, sex
FROM zwierzak;



#4


ALTER TABLE osoba
ADD COLUMN nazwisko VARCHAR(50) AFTER imie;

ALTER TABLE zwierzak
DROP COLUMN owner;

ALTER TABLE zwierzak
ADD id int NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;


#5

ALTER TABLE hobby
ADD FOREIGN KEY (osoba) REFERENCES osoba(id)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE zwierzak
ADD FOREIGN KEY (id) REFERENCES osoba(id)
ON DELETE CASCADE
ON UPDATE CASCADE;


#6
ALTER TABLE inne AUTO_INCREMENT = 7000;PREPARE stmt FROM 
	'SELECT * FROM hobby';


PREPARE stmt FROM 
	'SELECT * FROM hobby';

#7
DELIMITER $$
CREATE PROCEDURE generuj (
    IN name VARCHAR(25),
	IN num INT
)
BEGIN
	DECLARE counter INT DEFAULT 0;
	DECLARE zajecie enum('sport', 'nauka', 'inne') DEFAULT 'sport';
	DECLARE zajecieID INT DEFAULT 0;
	DECLARE osobaID INT DEFAULT 0;
	countLoop: LOOP
		IF counter<num THEN
			IF name='osoba' THEN
				INSERT INTO osoba VALUES (NULL, LEFT(MD5(RAND()),6), LEFT(MD5(RAND()),6), (SELECT date FROM randomDate), ELT(FLOOR(RAND()*2)+1,'m','f'));
			ELSEIF name='sport' THEN
				INSERT INTO sport VALUES (NULL, LEFT(MD5(RAND()),6), ELT(FLOOR(RAND()*3),'indywidualny', 'druzynowy', 'mieszany'), LEFT(MD5(RAND()),6));
			ELSEIF name='nauka' THEN
				INSERT INTO nauka VALUES (NULL, LEFT(MD5(RAND()),6), LEFT(MD5(RAND()),6));
			ELSEIF name='inne' THEN
				INSERT INTO inne VALUES (NULL, LEFT(MD5(RAND()),6), LEFT(MD5(RAND()),6), ELT(FLOOR(RAND()*2)+1, TRUE, FALSE) );
			ELSEIF name='hobby' THEN
				SET zajecie = (SELECT ELT(FLOOR(RAND()*3)+1, 'sport', 'nauka', 'inne'));
				SET osobaID = (SELECT id FROM osoba ORDER BY RAND() LIMIT 1);
				
				IF zajecie='sport' THEN
					SET zajecieID = (SELECT id FROM sport ORDER BY RAND() LIMIT 1);
				ELSEIF zajecie='nauka' THEN
					SET zajecieID = (SELECT id FROM nauka ORDER BY RAND() LIMIT 1);
				ELSEIF zajecie='inne' THEN
					SET zajecieID = (SELECT id FROM inne ORDER BY RAND() LIMIT 1);
				END IF;
				INSERT INTO hobby VALUES (zajecieID,osobaID,zajecie);	
			END IF;
			SET counter = counter + 1;
			ITERATE countLoop;
		END IF;
		LEAVE countLoop;
	END LOOP countLoop;
END$$
DELIMITER ;		

CALL generuj("osoba", 1000);
CALL generuj("hobby", 1300);
CALL generuj("nauka", 300);
CALL generuj("sport", 300);
CALL generuj("inne", 550);

#8
DROP VIEW IF EXISTS nazwyHobby;
CREATE VIEW nazwyHobby AS
    SELECT osoba, nazwa, hobby.typ FROM hobby JOIN nauka ON nauka.id = hobby.id WHERE hobby.typ = 'nauka' UNION
    SELECT osoba, nazwa, hobby.typ FROM hobby JOIN sport ON sport.id = hobby.id WHERE hobby.typ = 'sport' UNION
    SELECT osoba, nazwa, hobby.typ FROM hobby JOIN inne ON inne.id = hobby.id WHERE hobby.typ = 'inne';

PREPARE wszytskieHobbyOsoby FROM 'SELECT nazwa FROM nazwyHobby WHERE osoba = ? AND typ = ?';

SET @id = 30;
SET @typ = 'sport';
EXECUTE wszytskieHobbyOsoby USING @id, @typ;


#9

DELIMITER //
DROP PROCEDURE IF EXISTS getHobbies 
CREATE PROCEDURE getHobbies (IN idOsoby INT )
BEGIN
	SELECT * FROM hobby WHERE id = idOsoby;
END //
DELIMITER ;
CALL getHobbies(21);

#10
DELIMITER $$
DROP PROCEDURE IF EXISTS allHobbies;
CREATE PROCEDURE allHobbies(IN idOsoby INT)
BEGIN
	SELECT nazwa FROM nazwyHobby WHERE osoba = idOsoby
	Union
	SElECT Distinct species FROM zwierzak WHERE ID = idOsoby;
END$$
DELIMITER ; 

CALL allHobbies(27);

#11

DELIMITER //
CREATE  TRIGGER TriggerHobbyInsert
AFTER INSERT ON hobby
FOR EACH ROW
BEGIN
	CASE new.typ
		WHEN "nauka" THEN

			IF NEW.id NOT IN (SELECT id FROM nauka) 
				THEN INSERT INTO nauka (id,nazwa) VALUES (NEW.id, "trigger");
			END IF;

		WHEN "sport" THEN
 
			IF NEW.id NOT IN (SELECT id FROM sport) 
				THEN INSERT INTO sport (id,nazwa,typ) VALUES (NEW.id, "trigger",'druzynowy');
			END IF;
		

		WHEN "inne" THEN 
		
			IF NEW.id NOT IN (SELECT id FROM inne) 
				THEN INSERT INTO inne (id,nazwa,towarzysze) VALUES (NEW.id, "trigger", 1);
			END IF;
	END CASE;
END//
DELIMITER;

#12
DROP TRIGGER TriggerSportDelet;
DELIMITER //
CREATE TRIGGER TriggerSportDelete
AFTER DELETE ON sport
FOR EACH ROW
BEGIN
	DELETE FROM hobby WHERE sport.id = hobby.id AND hobby.type='sport';
END//
DELIMITER;

#13
DELIMITER //
CREATE TRIGGER TriggerNaukaDelete
AFTER DELETE ON nauka
FOR EACH ROW
BEGIN
	DELETE FROM hobby WHERE OLD.id = hobby.id AND hobby.type='nauka';
END//

DELIMITER //
CREATE TRIGGER TriggerNaukaUpdate
AFTER UPDATE ON nauka
FOR EACH ROW
BEGIN
	IF (old.nazwa <> old.nazwa) THEN
		DELETE FROM hobby WHERE OLD.id = hobby.id AND hobby.type='nauka';
	END IF;
END //
DELIMITER ;

#14

DROP TRIGGER IF EXISTS TriggerOsobaDelete //

DELIMITER //

CREATE TRIGGER TriggerOsobaDelete AFTER DELETE ON osoba
FOR EACH ROW 
BEGIN
	DELETE FROM hobby WHERE hobby.osoba = OLD.id;
	UPDATE zwierzak SET ID = (SELECT ID FROM osoba LIMIT 1) WHERE ID = OLD.id;
END//

DELIMITER ;

#16
DROP VIEW IF EXISTS allHobbies;
CREATE VIEW allHobbies AS 
SELECT nazwa, osoba from nauka inner join hobby on nauka.id = hobby.id WHERE hobby.typ = "nauka"
UNION
SELECT nazwa, osoba from sport inner join hobby on sport.id = hobby.id WHERE hobby.typ = "sport"
UNION 
SELECT nazwa, osoba from inne inner join hobby on inne.id = hobby.id WHERE hobby.typ = "inne";

CREATE VIEW hobbiesPopularity AS
SELECT nazwa, COUNT(*) AS liczba FROM allHobbies
GROUP BY nazwa;

#17
CREATE VIEW personAndHobbyAndAnimals AS
SELECT imie, nazwisko, nazwa FROM osoba INNER JOIN nazwyHobby ON osoba.id = nazwyHobby.osoba
UNION 
SELECT imie, nazwisko, name AS nazwa FROM osoba INNER JOIN zwierzak ON osoba.id = zwierzak.ID; 


#18
DELIMITER //
DROP FUNCTION IF EXISTS mostIntrested;
DROP VIEW IF EXISTS personAndNumberOfHobbies;

CREATE VIEW personAndNumberOfHobbies AS 
SELECT osoba, COUNT(osoba) AS ilosc FROM hobby GROUP BY osoba; 

CREATE FUNCTION mostIntrested() RETURNS VARCHAR(50) READS SQL DATA
BEGIN 
	(Select imie, YEAR(CURDATE())-YEAR(dataUrodzenia) AS wiek INTO @Imie, @Wiek FROM personAndNumberOfHobbies INNER JOIN osoba ON osoba = osoba.id WHERE ilosc = (Select MAX(ilosc) FROM personAndNumberOfHobbies) );

	RETURN CONCAT("Imie: ", @Imie, ", Wiek: ", @Wiek);
END //

DELIMITER ;

SELECT mostIntrested();



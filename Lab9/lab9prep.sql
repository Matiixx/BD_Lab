-- TRANSAKCJE

CREATE TABLE if not exists osoba( pesel char(11) primary key, imie char(20), nazwisko char(30), adres_m char (30));

SELECT CAST(txid_current() AS text);


BEGIN;
  INSERT INTO osoba VALUES ('11111113', 'Tom', 'nazwisko', 'miasto1');
  SELECT * FROM osoba ;
  SELECT CAST(txid_current() AS text);
  SELECT xmin, xmax, * FROM osoba ;
ROLLBACK ; --odrzucenie
SELECT * FROM osoba ;

BEGIN;
  INSERT INTO osoba VALUES ('11111111', 'Ala', 'nazwisko1', 'miasto1');
  SELECT * FROM osoba ;
COMMIT ; --zatwierdzenie
SELECT * FROM osoba ;
SELECT xmin, xmax, * FROM osoba ;

CREATE TABLE if not exists person ( 
  id serial primary key,
  groups char(2),
  first_name varchar(40) NOT NULL,
  last_name varchar(40) NOT NULL
);


CREATE OR REPLACE FUNCTION valid_data_test ()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
  DECLARE
    var record;
  BEGIN
    SELECT * INTO var FROM person;--w tabeli bedzie nie wiecej niz jeden rekord
    RAISE NOTICE 'przed sprawdzeniem dlugosci nazwiska zawartosc tablicy person %', var;
    IF LENGTH(NEW.last_name) = 0 THEN
      RAISE EXCEPTION 'Nazwisko nie moze byc puste.';--ROLLBACK
    END IF;
    SELECT * INTO var FROM person;
    RAISE NOTICE 'po sprawdzeniu dlugosci nazwiska zawartosc tablicy person %', var;
    RETURN NEW;
  END; --COMMIT
$$;

CREATE TRIGGER person_valid 
  AFTER INSERT OR UPDATE ON person
  FOR EACH ROW EXECUTE PROCEDURE valid_data_test();

INSERT INTO person VALUES ( 12, 'AA', '','');   
SELECT * FROM person; 

INSERT INTO person VALUES ( 12, 'AA', '','nazwisko');  
SELECT * FROM person;   

DROP TRIGGER person_valid ON person; 
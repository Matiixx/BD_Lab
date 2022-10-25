CREATE TABLE IF NOT EXISTS kara
  (
     kara_id        SERIAL NOT NULL,
     opoznienie_min INTEGER NOT NULL,
     opoznienie_max INTEGER NOT NULL,
     CONSTRAINT kara_pk PRIMARY KEY(kara_id)
  );

CREATE TABLE IF NOT EXISTS czytelnik
  (
     czytelnik_id SERIAL NOT NULL,
     imie         VARCHAR(32) NOT NULL,
     nazwisko     VARCHAR(32) NOT NULL,
     CONSTRAINT czytelnik_pk PRIMARY KEY(czytelnik_id)
  );

CREATE TABLE IF NOT EXISTS ksiazka
  (
     ksiazka_id     SERIAL NOT NULL,
     tytul          VARCHAR(32) NOT NULL,
     nazwisko_autor VARCHAR(32) NOT NULL,
     rok_wydania    INTEGER NOT NULL,
     CONSTRAINT ksiazka_pk PRIMARY KEY(ksiazka_id)
  );

CREATE TABLE IF NOT EXISTS wypozyczenie
  (
     wypozyczenie_id SERIAL NOT NULL,
     czytelnik_id    INTEGER NOT NULL,
     data_pozyczenia DATE NOT NULL,
     data_zwrotu     DATE,
     CONSTRAINT wypozyczenie_pk PRIMARY KEY(wypozyczenie_id),
     CONSTRAINT wypozyczenie_czytelnik_id_fk FOREIGN KEY(czytelnik_id)
     REFERENCES czytelnik(czytelnik_id)
  );

CREATE TABLE IF NOT EXISTS asoc
  (
     asoc_id         SERIAL NOT NULL,
     wypozyczenie_id INTEGER NOT NULL,
     ksiazka_id      INTEGER NOT NULL,
     CONSTRAINT asoc_pk PRIMARY KEY(asoc_id),
     CONSTRAINT asoc_wypozyczenie_id_fk FOREIGN KEY(wypozyczenie_id) REFERENCES
     wypozyczenie(wypozyczenie_id),
     CONSTRAINT asoc_ksiazka_id_fk FOREIGN KEY(ksiazka_id) REFERENCES ksiazka(
     ksiazka_id)
  ); 

  --INSERT
DELETE FROM asoc;

DELETE FROM wypozyczenie;

DELETE FROM ksiazka;

DELETE FROM czytelnik;

DELETE FROM kara; 

INSERT into kara(kara_id, opoznienie_min, opoznienie_max) values(0,0,6);
INSERT into kara(kara_id,opoznienie_min, opoznienie_max) values(1,7,14);
INSERT into kara(kara_id,opoznienie_min, opoznienie_max) values(2,15,22);

INSERT into czytelnik(czytelnik_id,imie, nazwisko) values(1,'Jan', 'Kowalski');
INSERT into czytelnik(czytelnik_id,imie, nazwisko) values(2,'Janina', 'Kowalska');
INSERT into czytelnik(czytelnik_id,imie, nazwisko) values(3,'Kwabena', 'Hough');
INSERT into czytelnik(czytelnik_id,imie, nazwisko) values(4,'Darci', 'Moore');

INSERT into ksiazka(ksiazka_id, tytul, nazwisko_autor, rok_wydania) values(1,'Nowe opowiesci', 'Kowalski', 2022);
INSERT into ksiazka(ksiazka_id,tytul, nazwisko_autor, rok_wydania) values(2,'Stare opowiesci', 'Gunn', 2012);
INSERT into ksiazka(ksiazka_id,tytul, nazwisko_autor, rok_wydania) values(3,'Nowsze opowiesci', 'Arnold', 2020);
INSERT into ksiazka(ksiazka_id,tytul, nazwisko_autor, rok_wydania) values(4,'Starsze opowiesci', 'Munoz', 2015);


INSERT into wypozyczenie(wypozyczenie_id, czytelnik_id, data_pozyczenia) values(1,1, '2022-10-20');
INSERT into wypozyczenie(wypozyczenie_id,czytelnik_id, data_pozyczenia, data_zwrotu) values(2,2, '2022-10-20', '2022-10-23');
INSERT into wypozyczenie(wypozyczenie_id,czytelnik_id, data_pozyczenia) values(3,3, '2022-10-10');
INSERT into wypozyczenie(wypozyczenie_id,czytelnik_id, data_pozyczenia) values(4,3, '2022-10-10');

INSERT INTO asoc(wypozyczenie_id, ksiazka_id) values(1, 1);
INSERT INTO asoc(wypozyczenie_id, ksiazka_id) values(2, 2);
INSERT INTO asoc(wypozyczenie_id, ksiazka_id) values(3, 3);
INSERT INTO asoc(wypozyczenie_id, ksiazka_id) values(3, 4);

--ZADANIA
--3.1
SELECT c.nazwisko,
       w.wypozyczenie_id
FROM   czytelnik c
       JOIN wypozyczenie w
         ON c.czytelnik_id = w.czytelnik_id
ORDER  BY c.nazwisko ASC; 

--3.2
SELECT k.tytul,
       w.wypozyczenie_id
FROM   ksiazka k
       JOIN asoc a
         ON a.ksiazka_id = k.ksiazka_id
       JOIN wypozyczenie w
         ON w.wypozyczenie_id = a.wypozyczenie_id
WHERE  w.wypozyczenie_id = 3; 

--3.3
SELECT w.wypozyczenie_id,
       c.nazwisko,
       w.data_pozyczenia,
       (SELECT kara_id
        FROM   kara
        WHERE  opoznienie_min <= (SELECT Extract (day FROM
                                         Now() - w.data_pozyczenia))
               AND opoznienie_max >= (SELECT Extract (day FROM
                                             Now() - w.data_pozyczenia)))
FROM   wypozyczenie w
       JOIN czytelnik c
         ON w.czytelnik_id = c.czytelnik_id; 

--3.4
SELECT w.wypozyczenie_id,
       w.data_pozyczenia
FROM   wypozyczenie w
WHERE  (SELECT Extract (day FROM Now() - w.data_pozyczenia)) > 7;
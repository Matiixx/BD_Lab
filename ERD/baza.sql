DROP TABLE IF EXISTS rozklad;

DROP TABLE IF EXISTS odjazd;

DROP TABLE IF EXISTS trasa_przystanki;

DROP TABLE IF EXISTS tramwaj;

DROP TABLE IF EXISTS trasa;

DROP TABLE IF EXISTS przystanek;

CREATE TABLE IF NOT EXISTS przystanek
  (
     przystanek_id SERIAL NOT NULL,
     nazwa         VARCHAR(60),
     CONSTRAINT przystanek_pk PRIMARY KEY(przystanek_id)
  );

CREATE TABLE IF NOT EXISTS trasa
  (
     trasa_id             SERIAL NOT NULL,
     przystanek_start_id  INTEGER NOT NULL,
     przystanek_koniec_id INTEGER NOT NULL,
     CONSTRAINT trasa_pk PRIMARY KEY(trasa_id)
  );

CREATE TABLE IF NOT EXISTS tramwaj
  (
     tramwaj_id INT NOT NULL,
     trasa_id   INT NOT NULL,
     CONSTRAINT tramwaj_pk PRIMARY KEY(tramwaj_id),
     CONSTRAINT trasa_id_fk FOREIGN KEY(trasa_id) REFERENCES trasa(trasa_id) ON
     DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS trasa_przystanki
  (
     trasa_przystanki_id SERIAL NOT NULL,
     trasa_id            INTEGER NOT NULL,
     przystanek_id       INTEGER NOT NULL,
     kolejnosc           INTEGER NOT NULL,
     CONSTRAINT trasa_przystanki_pk PRIMARY KEY(trasa_przystanki_id),
     CONSTRAINT trasa_id_fk FOREIGN KEY(trasa_id) REFERENCES trasa(trasa_id) ON
     DELETE CASCADE,
     CONSTRAINT przystanek_id_fk FOREIGN KEY(przystanek_id) REFERENCES
     przystanek(przystanek_id) ON DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS odjazd
  (
     odjazd_id  SERIAL NOT NULL,
     tramwaj_id INTEGER NOT NULL,
     CONSTRAINT odjazd_pk PRIMARY KEY(odjazd_id),
     CONSTRAINT tramwaj_id_fk FOREIGN KEY(tramwaj_id) REFERENCES tramwaj(
     tramwaj_id) ON DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS rozklad
  (
     rozklad_id    SERIAL NOT NULL,
     odjazd_id     INTEGER NOT NULL,
     przystanek_id INTEGER NOT NULL,
     godzina       TIME NOT NULL,
     CONSTRAINT rozklad_pk PRIMARY KEY(rozklad_id),
     CONSTRAINT odjazd_id_fk FOREIGN KEY(odjazd_id) REFERENCES odjazd(odjazd_id)
     ON DELETE CASCADE,
     CONSTRAINT przystanek_id_fk FOREIGN KEY(przystanek_id) REFERENCES
     przystanek(przystanek_id) ON DELETE CASCADE
  );

INSERT INTO przystanek
            (nazwa)
VALUES      ('maly plaszow');

INSERT INTO przystanek
            (nazwa)
VALUES      ('rzebika');

INSERT INTO przystanek
            (nazwa)
VALUES      ('lipska');

INSERT INTO przystanek
            (nazwa)
VALUES      ('gromadzka');

INSERT INTO przystanek
            (nazwa)
VALUES      ('kuklinskiego');

INSERT INTO przystanek
            (nazwa)
VALUES      ('klimeckiego');

INSERT INTO przystanek
            (nazwa)
VALUES      ('zablocie');

INSERT INTO przystanek
            (nazwa)
VALUES      ('rondo grzegorzeckie');

INSERT INTO przystanek
            (nazwa)
VALUES      ('rondo mogilskie');

INSERT INTO przystanek
            (nazwa)
VALUES      ('lubicz');

INSERT INTO przystanek
            (nazwa)
VALUES      ('teatr slowackiego');

INSERT INTO przystanek
            (nazwa)
VALUES      ('stary kleparz');

INSERT INTO przystanek
            (nazwa)
VALUES      ('teatr bagatela');

INSERT INTO przystanek
            (nazwa)
VALUES      ('filharmonia');

INSERT INTO przystanek
            (nazwa)
VALUES      ('jubilat');

INSERT INTO przystanek
            (nazwa)
VALUES      ('komorowskiego');

INSERT INTO przystanek
            (nazwa)
VALUES      ('salwator');

INSERT INTO przystanek
            (nazwa)
VALUES      ('dworzec plaszów estakada');

INSERT INTO przystanek
            (nazwa)
VALUES      ('dworcowa');

INSERT INTO przystanek
            (nazwa)
VALUES      ('cmentarz podgórski');

INSERT INTO przystanek
            (nazwa)
VALUES      ('podgórze ska');

INSERT INTO przystanek
            (nazwa)
VALUES      ('limanowskiego');

INSERT INTO przystanek
            (nazwa)
VALUES      ('korona');

INSERT INTO przystanek
            (nazwa)
VALUES      ('smolki');

INSERT INTO przystanek
            (nazwa)
VALUES      ('rondo matecznego');

INSERT INTO przystanek
            (nazwa)
VALUES      ('rzemieslnicza');

INSERT INTO przystanek
            (nazwa)
VALUES      ('lagiewniki');

INSERT INTO trasa
            (przystanek_start_id,
             przystanek_koniec_id)
VALUES      (1,
             17);

INSERT INTO trasa
            (przystanek_start_id,
             przystanek_koniec_id)
VALUES      (1,
             27);

INSERT INTO tramwaj
            (tramwaj_id,
             trasa_id)
VALUES      (20,
             1);

INSERT INTO tramwaj
            (tramwaj_id,
             trasa_id)
VALUES      (6,
             2);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             1,
             1);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             2,
             2);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             3,
             3);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             4,
             4);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             5,
             5);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             6,
             6);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             7,
             7);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             8,
             8);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             9,
             9);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             10,
             10);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             11,
             11);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             12,
             12);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             13,
             13);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             14,
             14);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             15,
             15);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             16,
             16);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (1,
             17,
             17); 

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             1,
             1);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             2,
             2);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             3,
             3);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             18,
             4);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             19,
             5);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             20,
             6);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             21,
             7);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             22,
             8);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             23,
             9);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             24,
             10);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             25,
             11);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             26,
             12);

INSERT INTO trasa_przystanki
            (trasa_id,
             przystanek_id,
             kolejnosc)
VALUES      (2,
             27,
             13); 

INSERT INTO odjazd
            (tramwaj_id)
VALUES      (20);

INSERT INTO odjazd
            (tramwaj_id)
VALUES      (20);

INSERT INTO odjazd
            (tramwaj_id)
VALUES      (6);

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             1,
             '12:0:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             2,
             '12:2:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             3,
             '12:4:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             4,
             '12:6:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             5,
             '12:8:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             6,
             '12:10:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             7,
             '12:12:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             8,
             '12:14:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             9,
             '12:16:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             10,
             '12:18:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             11,
             '12:20:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             12,
             '12:22:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             13,
             '12:24:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             14,
             '12:26:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             15,
             '12:28:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             16,
             '12:30:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (1,
             17,
             '12:32:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             1,
             '13:0:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             2,
             '13:2:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             3,
             '13:4:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             4,
             '13:6:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             5,
             '13:8:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             6,
             '13:10:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             7,
             '13:12:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             8,
             '13:14:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             9,
             '13:16:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             10,
             '13:18:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             11,
             '13:20:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             12,
             '13:22:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             13,
             '13:24:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             14,
             '13:26:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             15,
             '13:28:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             16,
             '13:30:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (2,
             17,
             '13:32:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             1,
             '14:0:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             2,
             '14:02:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             3,
             '14:04:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             18,
             '14:6:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             19,
             '14:8:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             20,
             '14:10:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             21,
             '14:12:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             22,
             '14:14:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             23,
             '14:16:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             24,
             '14:18:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             25,
             '14:20:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             26,
             '14:22:00');

INSERT INTO rozklad
            (odjazd_id,
             przystanek_id,
             godzina)
VALUES      (3,
             27,
             '14:24:00');

--1
SELECT tp.tramwaj_id,
       p.nazwa
FROM   trasa_przystanki tp
       JOIN przystanek p
         ON p.przystanek_id = tp.przystanek_id
WHERE  p.nazwa = 'lipska';

--2
SELECT r.godzina,
       p.nazwa,
       o.tramwaj_id
FROM   rozklad r
       JOIN odjazd o
         ON r.odjazd_id = o.odjazd_id
       JOIN przystanek p
         ON p.przystanek_id = r.przystanek_id
WHERE  p.nazwa = 'lipska'
       AND o.tramwaj_id = 20;

--3
SELECT o.tramwaj_id,
       p.nazwa,
       r.godzina
FROM   rozklad r
       JOIN odjazd o
         ON r.odjazd_id = o.odjazd_id
       JOIN przystanek p
         ON p.przystanek_id = r.przystanek_id
WHERE  o.tramwaj_id = 6; 
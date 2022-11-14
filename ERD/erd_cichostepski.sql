--1
SELECT t.tramwaj_id,
       p.nazwa
FROM   przystanek p
       JOIN trasa_przystanki tp
         ON p.przystanek_id = tp.przystanek_id
       JOIN trasa tr
         ON tr.trasa_id = tp.trasa_id
       JOIN tramwaj t
         ON tr.trasa_id = t.trasa_id
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
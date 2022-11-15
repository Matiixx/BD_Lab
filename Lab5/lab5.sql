--1
SELECT
       (
                SELECT   Cast(Count(*) AS NUMERIC(7,0)) AS max_
                FROM     wypozyczenie
                GROUP BY czytelnik_id
                ORDER BY max_ DESC limit 1) -
       (
                SELECT   Cast(Count(*) AS NUMERIC(7,0)) AS min_
                FROM     wypozyczenie
                GROUP BY czytelnik_id
                ORDER BY min_ ASC limit 1) AS roznica
FROM   wypozyczenie limit 1;

--2
SELECT a1.wypozyczenie_id,
       k1.tytul
FROM   asoc a1
       JOIN ksiazka k1 using(ksiazka_id)
WHERE  a1.wypozyczenie_id IN (SELECT a2.wypozyczenie_id
                              FROM   asoc a2
                                     JOIN ksiazka k using(ksiazka_id)
                              WHERE  k.tytul = 'Nowsze opowiesci') ; 


--3 
SELECT DISTINCT cz.nazwisko
FROM   czytelnik cz
       JOIN wypozyczenie w using(czytelnik_id)
       JOIN asoc a using(wypozyczenie_id)
WHERE  a.ksiazka_id IN (SELECT a2.ksiazka_id
                        FROM   asoc a2
                               JOIN wypozyczenie w2 using(wypozyczenie_id)
                               JOIN czytelnik cz2 using(czytelnik_id)
                        WHERE  cz2.czytelnik_id = 2); 

--4
SELECT a.ksiazka_id,
       Count(a.ksiazka_id)
FROM   asoc a
       JOIN wypozyczenie w using(wypozyczenie_id)
GROUP  BY a.ksiazka_id,
          w.czytelnik_id; 
          
--5
SELECT w.czytelnik_id
FROM   wypozyczenie w
WHERE  w.wypozyczenie_id = (SELECT max_id
                            FROM   (SELECT a.wypozyczenie_id   AS max_id,
                                           Count(a.ksiazka_id) AS ilosc
                                    FROM   asoc a
                                    GROUP  BY a.wypozyczenie_id
                                    ORDER  BY ilosc DESC
                                    LIMIT  1) AS f1); 

--6

SELECT Cast(percent AS NUMERIC(7, 2))
FROM   (SELECT 100 * Cast(Count(*) AS NUMERIC) / (SELECT Count(*)
                                                  FROM   wypozyczenie) AS
               PERCENT
        FROM   wypozyczenie w
        WHERE  w.czytelnik_id = '3') AS p; 

--7
SELECT DISTINCT w.czytelnik_id,
                w.data_pozyczenia
FROM   wypozyczenie w
WHERE  ( Extract (day FROM Now() - w.data_pozyczenia) ) >
              (SELECT Avg(w2.data_zwrotu
                          - w2.data_pozyczenia)
                                                           FROM
              wypozyczenie w2
                                                           WHERE
              data_zwrotu IS NOT NULL)
       AND w.data_zwrotu IS NULL; 

--8
SELECT DISTINCT w.czytelnik_id,
                w.data_zwrotu - w.data_pozyczenia AS ilosc_dni
FROM   wypozyczenie w
WHERE  w.wypozyczenie_id IN (SELECT wypozyczenie_id_max
                             FROM   (SELECT w2.wypozyczenie_id
                                            AS
                                            wypozyczenie_id_max,
                                            w2.czytelnik_id,
                                            Max(w2.data_zwrotu -
                                                w2.data_pozyczenia) AS
                                            ilosc_dni
                                     FROM   wypozyczenie w2
                                     WHERE  w2.data_zwrotu IS NOT NULL
                                     GROUP  BY w2.wypozyczenie_id,
                                               w2.czytelnik_id
                                     ORDER  BY ilosc_dni DESC
                                     LIMIT  1) AS wmax); 

--9 

SELECT DISTINCT w.czytelnik_id
FROM   wypozyczenie w
WHERE  w.czytelnik_id NOT IN (SELECT w2.czytelnik_id
                              FROM   wypozyczenie w2
                              WHERE  w2.data_zwrotu - w2.data_pozyczenia > 7
                                     AND w2.data_zwrotu IS NOT NULL)
       AND w.data_zwrotu IS NOT NULL; 

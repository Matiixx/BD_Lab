
--1
SELECT Count(*),
       ksiazka.tytul
FROM   wypozyczenie
       JOIN asoc USING (wypozyczenie_id)
       JOIN ksiazka USING(ksiazka_id)
GROUP  BY ksiazka.tytul,
          ksiazka.tytul;

--2 
SELECT czytelnik.nazwisko,
       Count(asoc.*)
FROM   czytelnik
       JOIN wypozyczenie USING(czytelnik_id)
       JOIN asoc USING(wypozyczenie_id)
GROUP  BY czytelnik.nazwisko;

--3 
SELECT Avg(wypozyczenie.data_zwrotu - wypozyczenie.data_pozyczenia)
FROM   wypozyczenie
WHERE  wypozyczenie.data_zwrotu IS NOT NULL;

--4 
SELECT   (Max(Count(wypozyczenie.*)) OVER () - Min(Count(wypozyczenie.*)) OVER ()) AS roznica
FROM     czytelnik
JOIN     wypozyczenie
using   (czytelnik_id)
GROUP BY czytelnik_id
ORDER BY Count(wypozyczenie.*) DESC limit 1;

--5 
SELECT ( data_zwrotu - data_pozyczenia ) AS ilosc_dni,
       Count(*)
FROM   wypozyczenie
WHERE  data_zwrotu IS NOT NULL
       AND ( data_zwrotu - data_pozyczenia ) > 7
GROUP  BY ilosc_dni;

--6
SELECT ksiazka.tytul,
       Count(asoc.*) AS ilosc_wypozyczen
FROM   ksiazka
       JOIN asoc USING(ksiazka_id)
GROUP  BY ksiazka.ksiazka_id,
          ksiazka.tytul
ORDER  BY ilosc_wypozyczen DESC
LIMIT  1; 

--7
SELECT czytelnik.nazwisko,
       Sum(kara.kara_id) * 100 AS kara
FROM   (czytelnik
        JOIN wypozyczenie using(czytelnik_id)),
       kara
WHERE  data_zwrotu IS NOT NULL
       AND ( data_zwrotu - data_pozyczenia ) > 7
       AND ( kara.opoznienie_max >= ( data_zwrotu - data_pozyczenia )
             AND kara.opoznienie_min <= ( data_zwrotu - data_pozyczenia ) )
GROUP  BY czytelnik.nazwisko; 

--8
SELECT czytelnik.nazwisko,
       Count(kara.kara_id) AS ilosc_kar
FROM   (czytelnik
        JOIN wypozyczenie using(czytelnik_id)),
       kara
WHERE  data_zwrotu IS NOT NULL
       AND ( data_zwrotu - data_pozyczenia ) > 7
       AND ( kara.opoznienie_max >= ( data_zwrotu - data_pozyczenia )
             AND kara.opoznienie_min <= ( data_zwrotu - data_pozyczenia ) )
GROUP  BY czytelnik.czytelnik_id,
          czytelnik.nazwisko
HAVING Count(kara.kara_id) > 2; 

--9 
SELECT ksiazka.tytul,
       Count(DISTINCT wypozyczenie.czytelnik_id) AS ilosc_czytelnikow
FROM   ksiazka
       JOIN asoc using(ksiazka_id)
       JOIN wypozyczenie using(wypozyczenie_id)
GROUP  BY ksiazka.ksiazka_id,
          ksiazka.tytul
HAVING Count(wypozyczenie.czytelnik_id) >= 2; 

--10
SELECT kara.kara_id,
       Count(wypozyczenie.wypozyczenie_id)
FROM   kara,
       wypozyczenie
WHERE  wypozyczenie.data_zwrotu IS NOT NULL
       AND ( data_zwrotu - data_pozyczenia ) > 7
       AND ( kara.opoznienie_max >= ( data_zwrotu - data_pozyczenia )
             AND kara.opoznienie_min <= ( data_zwrotu - data_pozyczenia ) )
GROUP  BY kara.kara_id; 
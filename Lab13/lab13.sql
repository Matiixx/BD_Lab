--ZADANIE 1
SELECT nr_konta,
    typ,
    kategoria,
    sum(kwota)
FROM transakcje
GROUP BY ROLLUP (nr_konta, typ, kategoria)
ORDER BY nr_konta;
----------------------------------------------------
-- ZADANIE 2
----------------------------------------------------
SELECT nr_konta,
    typ,
    sum(kwota)
FROM transakcje
GROUP BY ROLLUP (nr_konta, typ)
ORDER BY nr_konta
LIMIT 9;
----------------------------------------------------
-- ZADANIE 3
----------------------------------------------------
SELECT nr_konta,
    typ,
    avg(kwota)
FROM transakcje
GROUP BY GROUPING SETS ((nr_konta, typ), (nr_konta), (typ), ())
ORDER BY nr_konta;
----------------------------------------------------
-- ZADANIE 4
----------------------------------------------------
SELECT RANK() OVER(
        PARTITION by kategoria
        ORDER BY kwota DESC
    ),
    DENSE_RANK() over (
        PARTITION by kategoria
        ORDER BY kwota DESC
    ),
    kategoria,
    data,
    kwota
FROM transakcje
WHERE nr_konta = '11-11111111'
ORDER BY kategoria,
    kwota DESC;
----------------------------------------------------
-- ZADANIE 5
----------------------------------------------------
SELECT kwota,
    data,
    nr_konta
FROM (
        SELECT ROW_NUMBER() over(
                ORDER BY kwota DESC
            ) AS num,
            kwota,
            data,
            nr_konta
        FROM transakcje
        ORDER BY kwota DESC
    ) licznik
WHERE num <= 3
ORDER BY kwota DESC;
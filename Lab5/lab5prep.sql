--Operatory zbiorowe
--1
SELECT film_id,
       title
FROM   film
UNION
SELECT inventory_id,
       title
FROM   inventory;

--2
SELECT film_id,
       title
FROM   film
EXCEPT
SELECT inventory_id,
       title
FROM   inventory;

--2.1
SELECT inventory_id,
       title
FROM   inventory
EXCEPT
SELECT film_id,
       title
FROM   film;

--3
SELECT film_id,
       title
FROM   film
INTERSECT
SELECT inventory_id,
       title
FROM   inventory;

--4
--Podzapytania
SELECT i1.description,
       i1.sell_price - (SELECT Cast(Avg(i2.sell_price) AS NUMERIC(7, 2)) AS
                               roznica
                        FROM   item i2)
FROM   item i1; 

--5
SELECT c.fname,
       c.lname
FROM   customer c
       JOIN orderinfo o using(customer_id)
WHERE  o.orderinfo_id IN (SELECT ol.orderinfo_id
                          FROM   orderline ol
                          WHERE  ol.item_id IN
                                 (SELECT i.item_id
                                  FROM   item i
                                  WHERE  i.description = 'Tissues')); 

--6 
SELECT *
FROM   orderinfo o
WHERE  o.customer_id IN (SELECT c.customer_id
                         FROM   customer c
                         WHERE  c.lname = 'Howard'); 

--7
SELECT *
FROM   orderinfo o
WHERE  o.customer_id IN (SELECT c.customer_id
                         FROM   customer c
                         WHERE  c.lname = 'Stones'); 

--8
SELECT c.fname,
       c.lname
FROM   customer c
WHERE  c.customer_id NOT IN (SELECT o.customer_id
                             FROM   orderinfo o); 

--9
SELECT s.item_id
FROM   stock s
WHERE  s.quantity IN (SELECT o.quantity
                      FROM   orderline o); 

--10
SELECT i1.description,
       i1.sell_price
FROM   item i1
WHERE  i1.sell_price > ALL (SELECT i2.sell_price
                            FROM   item i2
                                   JOIN stock s using(item_id)
                            WHERE  s.quantity < 9); 

--11
SELECT c.lname
       || ' '
       || c.fname                             AS klient,
       (SELECT Count(*)
        FROM   orderinfo o
        WHERE  o.customer_id = c.customer_id) AS ile_razy,
       (SELECT Count(*)
        FROM   orderinfo o,
               orderline ol
        WHERE  o.customer_id = c.customer_id
               AND o.orderinfo_id = ol.orderinfo_id
        GROUP  BY o.customer_id)              AS ile_kupil
FROM   customer c; 

--12
SELECT o.orderinfo_id,
       (SELECT c.lname
               || ' '
               || c.fname
        FROM   customer c
        WHERE  c.customer_id = o.customer_id) AS klient,
       (SELECT Count(*)
        FROM   orderline ol
        WHERE  o.orderinfo_id = ol.orderinfo_id
        GROUP  BY o.customer_id)              AS ile_kupil
FROM   orderinfo o; 

--13
SELECT *
FROM   item i
WHERE  EXISTS (SELECT *
               FROM   barcode b
               WHERE  b.item_id = i.item_id); 

--14
SELECT c1.customer_id,
       c1.fname,
       c1.lname
FROM   customer c1
WHERE  EXISTS (SELECT c2.customer_id
               FROM   customer c2
               WHERE  c1.lname = c2.lname
                      AND c1.customer_id <> c2.customer_id); 

--15
SELECT *
FROM   item i
WHERE  NOT EXISTS (SELECT *
                   FROM   barcode b
                   WHERE  b.item_id = i.item_id); 
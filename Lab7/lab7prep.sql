--Select customers from town
CREATE OR replace FUNCTION klienci_1(text) returns customer
AS
  $$
  SELECT *
  FROM   customer
  WHERE  town=$1;
  
  $$ LANGUAGE SQL;

SELECT klienci_1('Bingham');
SELECT * from klienci_1('Bingham');
SELECT lname(klienci_1('Bingham')) as customer;

--Area of circle
CREATE OR replace FUNCTION fun_1(float8) returns float8
AS
  $$
  DECLARE
    my_pi CONSTANT float8 = pi();
    r alias FOR $1;
  BEGIN
    RETURN my_pi * r * r;
  END;
  $$ LANGUAGE plpgsql;

SELECT fun_1(1);

CREATE OR replace FUNCTION getlnamefromid(INT) returns text
AS
  $$
  DECLARE
    id alias FOR $1;
    name customer.lname%TYPE;
  BEGIN
    SELECT
    INTO   name lname
    FROM   customer
    WHERE  customer_id = id;
    
    RETURN name;
  END;
  $$ LANGUAGE plpgsql;

SELECT getLnameFromId(10);

CREATE OR replace FUNCTION getcustomerfromid(INT) returns text
AS
  $$
  DECLARE
    id alias FOR $1;
    name customer%ROWTYPE;
  BEGIN
    SELECT *
    INTO   name
    FROM   customer
    WHERE  customer_id = id;
    
    RETURN name;
  END $$ LANGUAGE plpgsql;

SELECT getCustomerFromId(10);
CREATE OR replace FUNCTION getnamefromid(INT) returns text
AS
  $$
  DECLARE
    id alias FOR $1;
    name RECORD;
  BEGIN
    SELECT fname,
           lname
    INTO   name
    FROM   customer
    WHERE  customer_id = id;
    
    RETURN name.lname
    || ' '
    || name.fname;
  END;
  $$ LANGUAGE plpgsql;

SELECT getNameFromId(10);
CREATE OR replace FUNCTION getClientOrError(id INT) returns text
AS
  $$
  DECLARE
    rec_klient customer%ROWTYPE;
  BEGIN
    SELECT
    INTO   rec_klient *
    FROM   customer
    WHERE  customer_id = id;
    
    IF NOT FOUND THEN
      RAISE
    EXCEPTION
      'Klienta % nie ma w bazie', id;
    END IF;

    RETURN rec_klient.fname
    || ' '
    || rec_klient.lname;
  END;
  $$ LANGUAGE plpgsql;

Select getClientOrError(10);
Select getClientOrError(1310);

CREATE OR replace FUNCTION getCustomersLike(lname_pattern VARCHAR) 
returns TABLE (im VARCHAR, naz VARCHAR)
AS
  $$
BEGIN
  RETURN query
  SELECT fname,
         lname
  FROM   customer
  WHERE  lname LIKE lname_pattern;
END;
$$ LANGUAGE plpgsql;

SELECT getCustomersLike('H%');

CREATE or replace FUNCTION loopCustomerPattern(lname_pattern VARCHAR) 
returns table (im VARCHAR, naz VARCHAR)
AS
  $$
  DECLARE
    var_r RECORD;
  BEGIN
    FOR var_r IN
    (
           SELECT fname,
                  lname
           FROM   customer
           WHERE  lname LIKE lname_pattern)
    LOOP
      im := var_r.fname;
      naz := upper(var_r.lname);
      RETURN NEXT;
    END LOOP;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM loopCustomerPattern('H%');

CREATE or replace FUNCTION getSortedBoughtItems(sort_type char(1), n INTEGER)
returns table (im VARCHAR, naz VARCHAR, opis VARCHAR)
AS
  $$
    DECLARE
      rec RECORD;
      query text;
    BEGIN
      query := ' SELECT c.fname       AS im,
                        c.lname       AS naz,
                        i.description AS opis
                  FROM   customer c
                        join orderinfo oi USING (customer_id)
                        join orderline ol USING ( orderinfo_id )
                        join item i USING (item_id) ';
      if sort_type = 'U' THEN
        query := query || 'ORDER BY naz, opis ';
      elsif sort_type = 'I' THEN
        query := query || 'ORDER BY opis, naz ';
      else 
        RAISE EXCEPTION 'Niepoprawny typ sortowania %', sort_type;
      end if;

      query := query || 'LIMIT $1';
      for rec in execute query using n
      loop
        RAISE notice '% - %', n, rec.naz;
          im := rec.im;
          naz := rec.naz;
          opis := rec.opis;
          RETURN NEXT;
      end loop;
    END;
  $$ language plpgsql;

Select * from getSortedBoughtItems('U', 12);
Select * from getSortedBoughtItems('I', 3);

--ZADANIA

drop table stock;

create table stock
(
item_id integer not null,
 quantity integer not null,
 CONSTRAINT stock_pk PRIMARY KEY(item_id)
);

insert into stock(item_id, quantity) values(1,12);
insert into stock(item_id, quantity) values(2,2);
insert into stock(item_id, quantity) values(4,8);
insert into stock(item_id, quantity) values(5,3);
insert into stock(item_id, quantity) values(7,8);
insert into stock(item_id, quantity) values(8,18);
insert into stock(item_id, quantity) values(10,1);

drop table reorders;

CREATE TABLE IF NOT EXISTS reorders(item_id integer, message text);

-- Prosze napisać funkcję, która wypełnia tablicę reorders informacjami o produktach, których zaczyna brakować w magazynie.
-- Argumentam funkcji jest minimalna ilość, która powinna znajdować się w magazynie.
-- Funkcja ma zwracać ilosc towarów których zaczyna brakować.
-- W tablicy reorders ma się pojawić komunikat "brak" jeżeli w magazynie danego produktu jest 0 sztuk , lub tekst " zostalo jeszcze .... sztuk", gdy ilość w magazynie jest mniejsza niż okreslona w argumencie funkcji minimalna ilość. 
--
--  grazyna=> select * from item;
--   item_id |  description  | cost_price | sell_price
--  ---------+---------------+------------+------------
--         1 | Wood Puzzle   |      15.23 |      23.05
--         2 | Rubic Cube    |       7.45 |      12.06
--         3 | Linux CD      |       1.99 |       2.61
--         4 | Tissues       |       2.11 |       4.19
--         5 | Picture Frame |       7.54 |      10.45
--         6 | Fan Small     |       9.23 |      16.54
--         7 | Fan Large     |      13.36 |      20.95
--         8 | Toothbrush    |       0.75 |       1.52
--         9 | Roman Coin    |       2.34 |       2.57
--        10 | Carrier Bag   |       0.01 |       0.00
--        11 | Speakers      |      19.73 |      26.59
--  (11 rows)
--
--  grazyna=> select * from stock ;
--   item_id | quantity
--  ---------+----------
--         1 |       12
--         2 |        2
--         4 |        8
--         5 |        3
--         7 |        8
--         8 |       18
--        10 |        1
--  (7 rows)
--
--  grazyna=> select * from reorders (4);
--   reorders
--  ----------
--          3
--  (1 row)
--
--  grazyna=> select * from reorders ;
--   item_id |                     message
--  ---------+-----------------------------------------------
--         2 |  Zostalo jeszcze 2 sztuk Rubic Cube
--         5 |  Zostalo jeszcze 3 sztuk Picture Frame
--        10 |  Zostalo jeszcze 1 sztuk Carrier Bag
--  (3 rows)

CREATE OR replace FUNCTION reorders(min_quantity INT) returns INT
AS
  $$
  DECLARE
    item RECORD;
    message_text text DEFAULT '';
  BEGIN
    FOR item IN
    (
           SELECT *
           FROM   stock
           join   item
           USING (item_id))
    LOOP
      IF item.quantity < min_quantity THEN
        IF item.quantity = 0 THEN
         message_text := 'Brak';
        ELSE
          message_text := 'Zostalo jeszcze '
          || item.quantity
          || ' sztuk '
          || item.description;
        END IF;
        INSERT INTO reorders
                    (
                                item_id,
                                message
                    )
                    VALUES
                    (
                                item.item_id,
                                message_text
                    );
      
      END IF;
    END LOOP;
    RETURN count(item_id) FROM reorders;
  END;
  $$ LANGUAGE plpgsql;

select reorders(4);
select * from reorders;

-- Prosze napisać funkcję, która wypisze informacje o popularności poszczególnych towarów.
--
--  grazyna=> select * from fun_11 ();
--    item_id|  description  |    message
--  ---------+---------------+-----------------
--        10 | Carrier Bag   | kupiono 1 raz
--         2 | Rubic Cube    | kupiono 1 raz
--         1 | Wood Puzzle   | kupiono 3 razy
--         5 | Picture Frame | kupiono 1 raz
--         4 | Tissues       | kupiono 2 razy
--         7 | Fan Large     | kupiono 2 razy
--         9 | Roman Coin    | kupiono 1 raz
--         3 | Linux CD      | kupiono 1 raz
--  (8 rows)

create or replace function fun_11() 
  returns table(item_id int, description VARCHAR, message VARCHAR)
  as 
  $$
    DECLARE
      rec RECORD;
    BEGIN 
      for rec in (SELECT i.item_id, i.description, COUNT(i.item_id) as count_item FROM item i JOIN orderline USING (item_id) GROUP BY i.item_id, i.description)
      loop
        item_id := rec.item_id;
        description := rec.description;
        IF rec.count_item = 1 THEN
          message := 'Kupiono ' || rec.count_item || ' raz';
        ELSE
          message := 'Kupiono ' || rec.count_item || ' razy';
        END IF;
        RETURN NEXT;
      END loop;
    END;

  $$ language plpgsql;

select * from fun_11 ();


-- Proszę utworzyć funkcję tablicującą wartości funkcji y = A*x2+B*x+C dla wartości A,B,C podanych przez użytkownika i x w zakresie od xo co krok. Rezultat ma być zwracany w postaci trzykolumnowej (i numer rekordu, x oraz y wartość funkcji dla danego x).
--
-- select * from rownanie_tables(1,2,1,1,1,10);(A,B,C,xo,krok, ilość_rekordów)
-- 
--   i  | x  |  y
--  ----+----+-----
--  
--    1 |  1 |   4
--  
--    2 |  2 |   9
--  
--    3 |  3 |  16
--  
--    4 |  4 |  25
--  
--    5 |  5 |  36
--  
--    6 |  6 |  49
--  
--    7 |  7 |  64
--  
--    8 |  8 |  81
--  
--    9 |  9 | 100
--  
--   10 | 10 | 121
--  
--  (10 wierszy)

create or replace function rownanie_tables(A decimal, B decimal, C decimal, x0 decimal, krok decimal, ilosc_rekordow decimal) 
returns TABLE (i decimal, x decimal, y decimal)
as $$
  DECLARE
    n integer := 1;
    BEGIN
      LOOP
        exit when n > ilosc_rekordow;
        i := n;
        x := x0 + (i - 1) * krok;
        y := A * x * x + B * x + C;
        n := n + 1;
        RETURN NEXT;
      END LOOP;
    END;

$$ language plpgsql;

select * from rownanie_tables(1,2,1,1,1,10);

-- Proszę utworzyć funkcję rozwiązująca równanie kwadratowe
--
-- select rownanie_1(1,10,1); (A, B, C)
-- 
-- INFORMACJA:  DELTA = 96
-- 
-- INFORMACJA:  Rozwiazanie posiada dwa rzeczywiste pierwiastki
-- 
-- INFORMACJA:  x1 = -0.101020514433644
-- 
-- INFORMACJA:  x2 = -9.89897948556636
-- 
--                       equ_solve
-- 
-- ------------------------------------------------------
-- 
--  (x1 = -0.101020514433644 ),(x2 = -9.89897948556636 )
-- 
-- (1 wiersz)


create or replace function rownanie_1(A decimal, B decimal, C decimal) 
returns text
as $$
  DECLARE
    delta decimal;
    x1 float8;
    x2 float8;
    x1i float8;
    x2i float8;
    x1complexresult text;
    x2complexresult text;
  BEGIN
    delta := B * B - 4 * A * C;
    RAISE INFO 'DELTA = %', delta;
    IF delta > 0 THEN
      RAISE INFO 'Rozwiazanie posiada dwa rzeczywiste pierwiastki';
      x1 := (-B - sqrt(delta))/(2 * A);
      RAISE INFO 'x1 = %', x1;
      x2 := (-B + sqrt(delta))/(2 * A);
      RAISE INFO 'x2 = %', x2;
      RETURN '(x1 = ' || x1 || ' ),(x2 = ' || x2 || ' )';
    elsif delta = 0 THEN
      RAISE INFO 'Rozwiazanie posiada jeden rzeczywisty pierwiastek';
      x1 := (-B)/(2 * A);
      RAISE INFO 'x0 = %', x1;
      RETURN '(x0 = ' || x1;
    else 
      RAISE INFO 'Rozwiazanie w dziedzinie liczb zespolonych';
      x1 := (-B) / (2 * A);
      x2 := -B / (2 * A);
      x1i := sqrt(-delta) / (2 * A);
      x2i := -sqrt(-delta) / (2 * A);
      x1complexresult := CONCAT(x1, ' + ', x1i, 'i');
      x2complexresult := CONCAT(x2, ' + ', x2i, 'i');
      RAISE INFO 'x1 = %', x1complexresult;
      RAISE INFO 'x2 = %', x2complexresult;
      RETURN '(x1 = ' || x1complexresult || ' ),(x2 = ' || x2complexresult || ' )';
    END if;
  END;
$$ language plpgsql;

select rownanie_1(1,10,1);
select rownanie_1(10,5,1);
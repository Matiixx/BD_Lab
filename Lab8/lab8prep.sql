
-- CREATE Or Replace function audit_log()
--   returns Trigger
--   language plpgsql
--   as $$
--     begin
--       INSERT into audit (table_name, operation) values (TG_RELNAME, TG_OP);
--       return NEW;
--     End;
--   $$;

-- CREATE Trigger person_audit After insert or update or delete on person
--   for each row execute procedure audit_log();

-- INSERT INTO person VALUES ( 1, 'A', 'Adam', 'Abacki' )  ;

-- -- SELECT * FROM person ;
-- -- SELECT * FROM audit ;

-- CREATE or Replace function log_last_name_changes() returns trigger as $$
--   begin
--     if NEW.last_name <> OLD.last_name then
--       insert into change(person_id, last_name, changed_on) values (OLD.id, OLD.last_name, now());
--     end if;
--   return new;
--   End;
-- $$ language plpgsql;

-- CREATE trigger last_name_changes before update on person 
--   for each row execute procedure log_last_name_changes();

-- INSERT INTO person VALUES ( 2, 'B', 'Jan', 'Janecki' )  ;
-- INSERT INTO person VALUES ( 3, 'A', 'Anna', 'Adamska' )  ;

-- UPDATE person SET last_name = 'Kowalski' WHERE id = 2;

-- -- SELECT * FROM person ;
-- -- SELECT * FROM change ;


-- CREATE or Replace function valid_data() returns trigger 
--   as $$
--     begin
--       if length(NEW.last_name) = 0 then
--         raise exception 'Nazwisko nie moze byc puste';
--         return null;
--       end if;
--     return new;
--     end;
--   $$ language plpgsql;

-- CREATE trigger person_valid After insert or update on person
--   for each row execute procedure valid_data();


-- INSERT INTO person VALUES ( 12, 'AA', '','');    

-- DROP TRIGGER person_valid ON person; 

-- CREATE or Replace function norm_data() returns trigger
--   as $$
--     begin 
--       if NEW.last_name is not null then
--         NEW.last_name := lower(NEW.last_name);
--         NEW.last_name := initcap(NEW.last_name);
--       end if;
--       return new;
--     end;
--   $$ language plpgsql;

-- CREATE trigger person_norm before insert or update on person
--   for each row execute procedure norm_data();

-- INSERT INTO person VALUES
--       ( 6, 'bb', 'Adam','babacki'), 
--       ( 7, 'bb', 'Marek','cabacki'), 
--       ( 8, 'cc', 'Adam','kabacki'), 
--       ( 9, 'dd', 'Teresa','??ak'); 


-- CREATE or Replace function group_count() returns trigger
--   as $$
--     begin 
--       if exists(SELECT 1 from person_group WHERE name = NEW.groups and nc > (SELECT count(*) from person WHERE groups like NEW.groups)) then
--         return new;
--       else 
--         raise notice 'Za duzo osob w grupie %', NEW.groups;
--         return null;
--       end if;
--     end;
--   $$ language plpgsql;

-- CREATE trigger person_test_insert before insert or update on person
--   for each row execute procedure group_count();

-- INSERT INTO person VALUES ( 21, 'aa', 'Adam','Babacki'), 
--     ( 22, 'cc', 'Marek','Cabacki'), 
--     ( 23, 'aa', 'Adam','Babacki'), 
--     ( 24, 'a', 'Teresa','Dadacka');

-- DROP TRIGGER person_test_insert ON person;

-- CREATE or Replace function insert_data() returns trigger 
--   as $$
--     begin 
--       insert into person_data (id) values (NEW.id);
--       return new;
--     end;
--   $$ language plpgsql;

-- CREATE trigger person_insert After insert on person
--   for each row execute procedure insert_data();

-- INSERT INTO person VALUES ( 21, 'bb', 'Zygmunt','Bielecki');

-- -- SELECT * from person;
-- -- SELECT * FROM person_data;
-- -- SELECT * FROM audit;

-- CREATE or Replace function customer_magazine_trigger() returns trigger
--   as $$
--     declare
--       customer_record record;
--       item_record record;
--       cust integer;
--       max_orderinfo integer;
--       itemid integer;
--     begin
--       SELECT count(*) into cust from customer;
--       SELECT * into customer_record from customer;
--       SELECT * into item_record from item where substr(upper(description),1,7)=substr(upper(new.description),1,7);

--       for item_record in SELECT * from item where substr(upper(description),1,7)=substr(upper(new.description),1,7)
--         loop
--           itemid := item_record.item_id;
--         end loop;
      
--       SELECT max(orderinfo_id) into max_orderinfo from orderinfo;
--       if (cust > 0 and substr(upper(new.description),1,7)=upper(tg_argv[0])) then
--         raise notice 'Trzeba wyslac magazyn do % klientow', cust;
--         for customer_record in SELECT * from customer
--           loop
--             max_orderinfo = max_orderinfo + 1;
--             insert into orderinfo (orderinfo_id, customer_id, date_placed, shipping) 
--               values (max_orderinfo, customer_record.customer_id, now(), 0.0);
--             insert into orderline (orderinfo_id, item_id, quantity) 
--               values (max_orderinfo, itemid, 1);
--           end loop;
--       else 
--         if(cust = 0) then
--           raise notice 'Brak klientow do ktotych moznaby wyslac magazyn';
--         end if;
--       end if;
--       return new;
--     end;
--   $$ language plpgsql;

-- CREATE trigger trig_customer After insert on item 
--   for each row execute procedure customer_magazine_trigger(Magazyn);

-- drop trigger trig_customer on item;

-- INSERT INTO item (description, cost_price, sell_price) values('Magazyn - Luty', 0.1, 0.0);

-- ZADANIA

---------------------
---- ??wiczenie 1 ----
---------------------
-- Prosz?? skonstruowa?? trygger, kt??ry zrealizuje Wprowadzanie danych do tabel powi??zanych
-- Tabela reorders przechowywuje informacje o koneczno??ci zakupu towar??w - id towaru oraz komunikat informujacy o ilo??ci danego towaru w magazynie (??wiczenie_1 z poprzednich zaj????).
-- Nale??y skonstruowa?? wyzwalacz, kt??ry b??dzie uruchamiany po ka??dej zmianie w tabeli stock, kt??ry b??dzie aktualizowa?? tabel?? reorders
-- W pliku opr??cz funckji oraz definicji tryggera, prosz?? dopisa?? kwerendy pozwalaj??ce przetestow?? dzia??anie.

create or Replace function update_reorders() returns trigger
  as $$
    begin
      if ( NEW.quantity < CAST(TG_ARGV[0] as INTEGER)) then
        insert into reorders 
          values(NEW.item_id, 
          concat('Zostalo jeszcze ', NEW.quantity, ' sztuk ', (SELECT description FROM item i WHERE i.item_id = NEW.item_id)));
      else 
        delete from reorders r where r.item_id = NEW.item_id; 
      end if;
      return new;
    end;
  $$ language plpgsql;

create trigger reorder_update After insert or update on stock
  for each row execute procedure update_reorders(4);

INSERT INTO stock VALUES (3, 3);
INSERT INTO stock VALUES (6, 5);
SELECT * FROM reorders;
UPDATE stock SET quantity = 5 WHERE item_id = 3;
SELECT * FROM reorders;


DROP TRIGGER reorder_update ON stock;
DELETE FROM stock WHERE item_id IN (3, 6);

---------------------
---- ??wiczenie 2 ----
---------------------
-- Prosz?? skonstruowa?? trygger, kt??ry zapewnienia integralno??ci danych
-- Pr??ba usuni??cia klienta z tabeli customer w przypadku, gdy ma on niezrealizowane zam??wienie nie mo??e zostac zrealizowana. Gdy wszystkie jego zam??wienia zosta??y zrealizowane, usuwamy go wraz z ca???? jego histori?? zam??wie??.
-- W pliku opr??cz funckji oraz definicji tryggera, prosz?? dopisa?? kwerendy pozwalaj??ce przetestow?? dzia??anie.

create or Replace function customer_delete() returns trigger 
  as $$
    begin
      if exists(SELECT * from orderinfo oi where oi.customer_id = OLD.customer_id and oi.date_shipped is null) then
        raise warning 'Klient ma niedostarczone zamowienia';
        return null;
      else 
        delete from orderline ol where ol.orderinfo_id IN (SELECT oi.orderinfo_id from orderinfo oi where oi.customer_id = OLD.customer_id);
        delete from orderinfo oi where oi.customer_id = OLD.customer_id;
        return old;
      end if;
    end;
  $$ language plpgsql;

create trigger customer_integrity BEFORE DELETE ON customer
FOR EACH ROW EXECUTE PROCEDURE customer_delete();


INSERT INTO customer VALUES (DEFAULT, 'Mr', 'Testing', 'Guy', '1 Joestar Street', 'Morioh', '123 456', '123 4567');
INSERT INTO orderinfo (customer_id, date_placed, date_shipped, shipping) VALUES ((SELECT customer_id FROM customer WHERE fname = 'Testing'), '2000-08-12', NULL, 0.00);
DELETE FROM customer WHERE fname = 'Testing';
SELECT COUNT(customer_id) FROM customer WHERE fname = 'Testing';

DROP TRIGGER customer_integrity ON customer;
DELETE FROM orderline ol WHERE ol.orderinfo_id IN (SELECT oi.orderinfo_id FROM orderinfo oi WHERE oi.customer_id IN (SELECT customer_id FROM customer WHERE fname = 'Testing'));
DELETE FROM orderinfo oi WHERE oi.customer_id IN (SELECT customer_id FROM customer WHERE fname = 'Testing');
DELETE FROM customer WHERE fname = 'Testing';

---------------------
---- ??wiczenie 3 ----
---------------------
-- Prosz?? skonstruowa?? trygger, kt??ry wpisuje dane do tablicy asocjacyjnej
-- Chcemy wysy??a?? do wszystkich naszych klient??w darmowy magazyn reklamowy, 
-- za ka??dym razem kiedy tylko pojawi si?? jego nowe wydanie (czyli, kiedy zostanie dodana pozycja Magazyn... do tabeli item).
-- Dodajemy wtedy automatycznie zam??wienie do tabeli orderinfo (przy czym musimy uzupe??ni?? jeszcze tabel?? asocjacyjn?? orderline 
-- z liczb?? zam??wionych magazyn??w=1)

create or Replace function new_magazine() returns trigger 
  as $$
    declare
      c record;
    begin
      if NEW.description like 'Magazyn%' then
        for c in SELECT * from customer loop
          with oi as (insert into orderinfo values(DEFAULT, c.customer_id, now(), NULL, 0.00) returning orderinfo_id)
            insert into orderline values((SELECT orderinfo_id from oi), NEW.item_id, 1);
        end loop;
      end if;
      return new;
    end;
  $$ language plpgsql;

create trigger insert_magazines After insert on item 
  for each row execute procedure new_magazine();

INSERT INTO item VALUES (DEFAULT, 'Magazyn Lato 2000', 0.00, 0.00);
SELECT * FROM item WHERE description LIKE 'Magazyn%';
SELECT * FROM orderinfo WHERE orderinfo_id > 5;
SELECT * FROM orderline WHERE orderinfo_id > 5;

DROP TRIGGER insert_magazines ON item;
DELETE FROM orderline ol WHERE (SELECT description FROM item i WHERE i.item_id = ol.item_id) LIKE 'Magazyn%';
DELETE FROM orderinfo WHERE date_shipped IS NULL;
DELETE FROM item WHERE description LIKE 'Magazyn%';

---------------------
---- ??wiczenie 4 ----
---------------------
-- Do tabeli customer dodajemy kolumne discount, kt??ra przechowuje zni??k?? przys??uguj??c?? klientowi
ALTER TABLE customer ADD COLUMN discount REAL DEFAULT 0 CHECK (discount BETWEEN 0.0 AND 100.0);
-- Prosz?? skonstruowa?? trygger, kt??ry po ka??dych 10 zakupach dokonanych przez klienta zwi??kszy jego discount o 2%

create or Replace function check_discount() returns trigger
  AS $$
    declare
    disc integer := 0;
    begin
      disc := 2 * ((SELECT count(orderinfo_id) from orderinfo oi where oi.customer_id = NEW.customer_id) / 10);
      if disc > 100 then
        disc := 100;
      end if;
      update customer c set discount = disc where c.customer_id = NEW.customer_id;
      return new;
    end;
  $$ language plpgsql;

create trigger check_discount After insert or update on orderinfo
  for each row execute procedure check_discount();

CREATE OR REPLACE FUNCTION place_orders(INTEGER)
RETURNS REAL AS
$$
BEGIN
	FOR i IN 1..$1 LOOP
		INSERT INTO orderinfo VALUES (DEFAULT, 1, '2000-01-01', '2000-01-02', 4.99);
	END LOOP;
	RETURN (SELECT discount FROM customer WHERE customer_id = 1);
END;
$$
LANGUAGE 'plpgsql';

SELECT place_orders(10) AS discount;
SELECT place_orders(10) AS discount;
SELECT place_orders(1500) AS discount;


DROP TRIGGER check_discount ON orderinfo;
ALTER TABLE customer DROP COLUMN discount;
DELETE FROM orderinfo WHERE customer_id = 1;


---------------------
---- ??wiczenie 5 ----
---------------------
-- Prosz?? skonstruowa?? trygger, kt??ry anuluje op??at?? za dostarczenie zam??wienia je??eli czeka ono na realizacj?? d??u??ej ni?? 3 dni

create or Replace function refund_shipping() returns trigger 
  as $$
    begin
      if (NEW.date_shipped - NEW.date_placed) > 3 then 
        NEW.shipping := 0.00;
      end if;
      return new;
    end;
  $$ language plpgsql;

CREATE TRIGGER refund_shipping BEFORE INSERT OR UPDATE ON orderinfo
FOR EACH ROW EXECUTE PROCEDURE refund_shipping();

INSERT INTO orderinfo VALUES (DEFAULT, 1, '2000-01-01', '2000-01-05', 4.99);
SELECT * FROM orderinfo WHERE customer_id = 1;


DROP TRIGGER refund_shipping ON orderinfo;


---------------------
---- ??wiczenie 6 ----
---------------------
-- Zam??wienie nie mo??e zawiera?? wi??cej ni?? 10 sztuk -
-- Prosz?? skonstruowa?? trygger, kt??ry przy zam??wieniu sk??adaj??cym si?? z wiecej ni?? 10 sztuk towar??w 
-- (ze wszystkich zamawianych rzeczy, podzieli to zam??wienie na kilka (32 sztuki --> trzy zam??wienia po 10 sztuk, czwarte 2 sztuki)

create or Replace function max_quantity() returns trigger
  as $$
    declare 
    num integer;
    rec record;
    begin
      num := NEW.quantity;
      If num is not null then
        if(num <= 10) then
          return NEW;
        end if;

        SELECT * into rec from orderinfo oi where oi.orderinfo_id = NEW.orderinfo_id;
        
        while num > 10 loop
          with oi as (insert into orderinfo(orderinfo_id,customer_id,date_placed,date_shipped,shipping) 
            VALUES(DEFAULT, rec.customer_id, rec.date_placed, rec.date_shipped, rec.shipping) returning orderinfo_id)
            insert into orderline(orderinfo_id, item_id, quantity) values((SELECT orderinfo_id from oi), NEW.item_id, 10);
          num := num - 10;
        end loop;
        NEW.quantity := num;
        return NEW;
      end if;
      return NEW;

    end;
  $$ language plpgsql;

create trigger order_split before insert or update on orderline
  for each row execute procedure max_quantity();


delete from orderline where orderinfo_id = 99999; 
delete from orderinfo where orderinfo_id = 99999; 
delete from orderline where quantity = 10;

INSERT INTO orderinfo
            (orderinfo_id,
             customer_id,
             date_placed,
             date_shipped,
             shipping)
VALUES     (99999,
            8,
            '21-07-2000',
            '24-07-2000',
            0.00);

INSERT INTO orderline 
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (99999,
            114,
            32);

DROP TRIGGER order_split ON orderline;

SELECT * from orderline;
SELECT * from orderinfo;
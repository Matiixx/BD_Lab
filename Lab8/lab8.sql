-- ZADANIE 1

create or Replace function update_reorders() returns trigger 
    as $$
        begin
            if(NEW.quantity < Cast(TG_ARGV[0] as integer)) then
                if exists(SELECT * from reorders r where r.item_id=NEW.item_id ) then
                    update reorders r set message=concat('Zostalo jeszcze ', NEW.quantity, ' sztuk ', (SELECT description from item i where i.item_id=NEW.item_id ))
                        where r.item_id = NEW.item_id;
                else
                    insert into reorders values (NEW.item_id, concat('Zostalo jeszcze ', NEW.quantity, ' sztuk ', (SELECT description from item i where i.item_id=NEW.item_id )));
                end if;
            else 
                delete from reorders r where r.item_id = NEW.item_id; 
            end if;
            return NEW;
        end;
    $$ language plpgsql;

create trigger update_reorders after insert or update on reserve
    for each row execute procedure update_reorders(4);

INSERT INTO reserve VALUES (5, 2);
INSERT INTO reserve VALUES (3, 5);
update reserve set quantity=3 where item_id=3;
SELECT * FROM reorders;

drop trigger update_reorders on reserve;
delete from reserve where item_id in (3,6);

-- ZADANIE 2

ALTER TABLE customer ADD COLUMN discount REAL DEFAULT 0 CHECK (discount BETWEEN 0.0 AND 100.0);

create or Replace function add_discount() returns trigger
    as $$
        declare
            num_of_orders integer;
            discount_percentage float;
        begin
            SELECT count(orderinfo_id) into num_of_orders from orderinfo o where o.customer_id = NEW.customer_id;
            if num_of_orders >= 10 then
                discount_percentage := (num_of_orders / 10) * 2;
                if(discount_percentage > 100.0) then
                    discount_percentage := 100.0;
                end if;
                update customer c set discount = discount_percentage where c.customer_id = NEW.customer_id;
            else 
                update customer c set discount = 0 where c.customer_id = NEW.customer_id;
            end if;
            return NEW;
        end;
    $$ language plpgsql;

create trigger add_discount after insert or update or delete on orderinfo
    for each row execute procedure add_discount();

insert into orderinfo(customer_id, date_placed) values(1, '2022-12-06');
insert into orderinfo(customer_id, date_placed) values(1, '2022-12-06');
insert into orderinfo(customer_id, date_placed) values(1, '2022-12-06');
insert into orderinfo(customer_id, date_placed) values(1, '2022-12-06');
insert into orderinfo(customer_id, date_placed) values(1, '2022-12-06');
insert into orderinfo(customer_id, date_placed) values(1, '2022-12-06');

SELECT * from customer where customer_id=1; 
drop trigger add_discount on orderinfo;

-- ZADANIE 3
create or Replace function split_order() returns trigger
    as $$
        declare
            orders_to_split record;
            order_ record;
            id_item integer;
        BEGIN
            
            for orders_to_split IN SELECT orderinfo_id, count(orderinfo_id) from orderline ol where ol.orderinfo_id=NEW.orderinfo_id group by orderinfo_id having count(orderinfo_id) >= 2
                loop
                    raise info 'id: %', orders_to_split.orderinfo_id;
                    SELECT * into order_ from orderinfo oi where oi.orderinfo_id = orders_to_split.orderinfo_id;
                    SELECT item_id into id_item from orderline where orderinfo_id = orders_to_split.orderinfo_id;
                    raise info 'dsad: %', order_.customer_id;
                    with insert_order as (insert into orderinfo(orderinfo_id, customer_id, date_placed, date_shipped, shipping)
                        values(DEFAULT, order_.customer_id, order_.date_placed, order_.date_shipped, order_.shipping) returning orderinfo_id)
                        update orderline ol set orderinfo_id=(SELECT orderinfo_id from insert_order) 
                            where ol.orderinfo_id=orders_to_split.orderinfo_id and ol.item_id=id_item;
                end loop;
            return new;
        end;
    $$ language plpgsql;

create trigger split_order after insert or update on orderline
    for each row execute procedure split_order();


insert into orderline values(5, 11, 1);
SELECT * from orderline;
delete from orderline where orderinfo_id=5 and item_id=11;

drop trigger split_order on orderline;

-- ZADANIE 4

create or Replace function try_delete_customer() returns trigger
    as $$
        begin
            if exists(SELECT * from orderinfo oi where oi.customer_id=OLD.customer_id and oi.date_shipped is null) then
                raise warning 'Klient posiada niedostarczone zamowienia';
                return null;
            else 
                delete from orderline ol where ol.orderinfo_id in (SELECT orderinfo_id from orderinfo where customer_id=OLD.customer_id);
                delete from orderinfo o where o.customer_id = OLD.customer_id;
                return old;
            end if;
        end;
    $$ language plpgsql;

create trigger try_delete_customer before delete on customer
    for each row execute procedure try_delete_customer();

insert into orderinfo(orderinfo_id, customer_id, date_placed, date_shipped, shipping)
    values(9999, 1, now(), Null, 3.4);

delete from customer where customer_id = 1;

delete from orderinfo where orderinfo_id=9999;

drop trigger try_delete_customer on customer;


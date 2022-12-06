
-- Tabela person
CREATE TABLE if not exists person ( 
    id serial primary key,
    groups char(2),
    first_name varchar(40) NOT NULL,
    last_name varchar(40) NOT NULL);
      
--Tabela audit zapis operacji w bazie danych
CREATE TABLE if not exists audit (
    table_name varchar(15) not null,
    operation varchar,
    time_at timestamp not null default now(),
    userid name not null default session_user
);

CREATE TABLE if not exists change (
    id serial primary key,
    person_id int4 NOT NULL,
    last_name varchar(40) NOT NULL,
    changed_on timestamp(6) NOT NULL
);

CREATE TABLE if not exists person_group ( name varchar(15), nc int ) ;  --nazwa grupy; maksymalna ilosc osob w  grupie
delete from person_group;

INSERT INTO person_group VALUES ( 'aa', 2), ( 'bb', 3 ), ( 'cc', 4 ) ;

CREATE TABLE if not exists person_data ( id int, city varchar(30), email varchar(30), telefon varchar(15) );

ALTER TABLE person_data ADD PRIMARY KEY (id);
INSERT INTO person_data (id) SELECT id FROM person;
ALTER TABLE person_data ADD FOREIGN KEY (id) REFERENCES person(id); 


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
create table customer
(
    customer_id                     serial                        ,
    title                           char(4)                       ,
    fname                           varchar(32)                   ,
    lname                           varchar(32)           not null,
    addressline                     varchar(64)                   ,
    town                            varchar(32)                   ,
    zipcode                         char(10)              not null,
    phone                           varchar(16)                   ,
    CONSTRAINT                      customer_pk PRIMARY KEY(customer_id)
);
 
--tabela orderinfo
CREATE TABLE orderinfo( orderinfo_id serial, 
                        customer_id INTEGER NOT NULL REFERENCES customer(customer_id), 
                        date_placed DATE NOT NULL, 
                        date_shipped DATE,
                        shipping NUMERIC(7,2), 
                        CONSTRAINT orderinfo_pk PRIMARY KEY(orderinfo_id));
 
--tabela item
create table item
(
    item_id                         serial                        ,
    description                     varchar(64)           not null,
    cost_price                      numeric(7,2)                  ,
    sell_price                      numeric(7,2)                  ,
    CONSTRAINT                      item_pk PRIMARY KEY(item_id)
);
 
--tabela orderline
CREATE TABLE orderline( orderinfo_id INTEGER NOT NULL,
                        item_id INTEGER NOT NULL,
                        quantity INTEGER NOT NULL,
                        CONSTRAINT orderline_pk PRIMARY KEY(orderinfo_id, item_id),
                        CONSTRAINT orderline_orderinfo_id_fk FOREIGN KEY(orderinfo_id) REFERENCES orderinfo (orderinfo_id),
                        CONSTRAINT orderline_item_id_fk FOREIGN KEY(item_id) REFERENCES item (item_id));
 
 
---------WYPE£NIANIE
 
--tabela customer
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Miss','Jenny','Stones','27 Rowan Avenue','Hightown','NT2 1AQ','023 9876');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Andrew','Stones','52 The Willows','Lowtown','LT5 7RA','876 3527');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Miss','Alex','Matthew','4 The Street','Nicetown','NT2 2TX','010 4567');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Adrian','Matthew','The Barn','Yuleville','YV67 2WR','487 3871');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Simon','Cozens','7 Shady Lane','Oahenham','OA3 6QW','514 5926');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Neil','Matthew','5 Pasture Lane','Nicetown','NT3 7RT','267 1232');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Richard','Stones','34 Holly Way','Bingham','BG4 2WE','342 5982');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mrs','Ann','Stones','34 Holly Way','Bingham','BG4 2WE','342 5982');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mrs','Christine','Hickman','36 Queen Street','Histon','HT3 5EM','342 5432');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Mike','Howard','86 Dysart Street','Tibsville','TB3 7FG','505 5482');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Dave','Jones','54 Vale Rise','Bingham','BG3 8GD','342 8264');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Richard','Neill','42 Thached way','Winersby','WB3 6GQ','505 6482');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mrs','Laura','Hendy','73 Margeritta Way','Oxbridge','OX2 3HX','821 2335');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','Bill','ONeill','2 Beamer Street','Welltown','WT3 8GM','435 1234');
insert into customer(title, fname, lname, addressline, town, zipcode, phone) values('Mr','David','Hudson','4 The Square','Milltown','MT2 6RT','961 4526');
 
--tabela item
insert into item(description, cost_price, sell_price) values('Wood Puzzle', 15.23, 21.95);
insert into item(description, cost_price, sell_price) values('Rubic Cube', 7.45, 11.49);
insert into item(description, cost_price, sell_price) values('Linux CD', 1.99, 2.49);
insert into item(description, cost_price, sell_price) values('Tissues', 2.11, 3.99);
insert into item(description, cost_price, sell_price) values('Picture Frame', 7.54, 9.95);
insert into item(description, cost_price, sell_price) values('Fan Small', 9.23, 15.75);
insert into item(description, cost_price, sell_price) values('Fan Large', 13.36, 19.95);
insert into item(description, cost_price, sell_price) values('Toothbrush', 0.75, 1.45);
insert into item(description, cost_price, sell_price) values('Roman Coin', 2.34, 2.45);
insert into item(description, cost_price, sell_price) values('Carrier Bag', 0.01, 0.0);
insert into item(description, cost_price, sell_price) values('Speakers', 19.73, 25.32);
 
--tabela orderinfo
insert into orderinfo(customer_id, date_placed, date_shipped, shipping) values(3,'13-03-2000','17-03-2000', 2.99);
insert into orderinfo(customer_id, date_placed, date_shipped, shipping) values(8,'23-06-2000','24-06-2000', 0.00);
insert into orderinfo(customer_id, date_placed, date_shipped, shipping) values(15,'02-09-2000','12-09-2000', 3.99);
insert into orderinfo(customer_id, date_placed, date_shipped, shipping) values(13,'03-09-2000','10-09-2000', 2.99);
insert into orderinfo(customer_id, date_placed, date_shipped, shipping) values(8,'21-07-2000','24-07-2000', 0.00);
 
--tabela orderline
insert into orderline(orderinfo_id, item_id, quantity) values(1, 4, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(1, 7, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(1, 9, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(2, 1, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(2, 10, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(2, 7, 2);
insert into orderline(orderinfo_id, item_id, quantity) values(2, 4, 2);
insert into orderline(orderinfo_id, item_id, quantity) values(3, 2, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(3, 1, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(4, 5, 2);
insert into orderline(orderinfo_id, item_id, quantity) values(5, 1, 1);
insert into orderline(orderinfo_id, item_id, quantity) values(5, 3, 1);

create table stock
(
    item_id  integer   not null,
    quantity  integer  not null,
    CONSTRAINT stock_pk PRIMARY KEY(item_id)
);
 
insert into stock(item_id, quantity) values(1,12);
insert into stock(item_id, quantity) values(2,2);
insert into stock(item_id, quantity) values(4,8);
insert into stock(item_id, quantity) values(5,3);
insert into stock(item_id, quantity) values(7,8);
insert into stock(item_id, quantity) values(8,18);
insert into stock(item_id, quantity) values(10,1);
INSERT INTO stock(item_id, quantity) VALUES (15,1);
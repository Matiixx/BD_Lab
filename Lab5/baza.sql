--tabela customer
CREATE TABLE customer
  (
     customer_id SERIAL,
     title       CHAR(4),
     fname       VARCHAR(32),
     lname       VARCHAR(32) NOT NULL,
     addressline VARCHAR(64),
     town        VARCHAR(32),
     zipcode     CHAR(10) NOT NULL,
     phone       VARCHAR(16),
     CONSTRAINT customer_pk PRIMARY KEY(customer_id)
  );

--tabela orderinfo
CREATE TABLE orderinfo
  (
     orderinfo_id SERIAL,
     customer_id  INTEGER NOT NULL REFERENCES customer(customer_id),
     date_placed  DATE NOT NULL,
     date_shipped DATE,
     shipping     NUMERIC(7, 2),
     CONSTRAINT orderinfo_pk PRIMARY KEY(orderinfo_id)
  );

--tabela item
CREATE TABLE item
  (
     item_id     SERIAL,
     description VARCHAR(64) NOT NULL,
     cost_price  NUMERIC(7, 2),
     sell_price  NUMERIC(7, 2),
     CONSTRAINT item_pk PRIMARY KEY(item_id)
  );

--tabela orderline
CREATE TABLE orderline
  (
     orderinfo_id INTEGER NOT NULL,
     item_id      INTEGER NOT NULL,
     quantity     INTEGER NOT NULL,
     CONSTRAINT orderline_pk PRIMARY KEY(orderinfo_id, item_id),
     CONSTRAINT orderline_orderinfo_id_fk FOREIGN KEY(orderinfo_id) REFERENCES
     orderinfo (orderinfo_id),
     CONSTRAINT orderline_item_id_fk FOREIGN KEY(item_id) REFERENCES item (
     item_id)
  );

CREATE TABLE stock
  (
     item_id     INTEGER NOT NULL,
     description VARCHAR(64) NOT NULL,
     quantity    INTEGER NOT NULL,
     CONSTRAINT stock_pk PRIMARY KEY(item_id)
  );

---------WYPEŁNIANIE
--tabela customer
INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Miss',
            'Jenny',
            'Stones',
            '27 Rowan Avenue',
            'Hightown',
            'NT2 1AQ',
            '023 9876');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Andrew',
            'Stones',
            '52 The Willows',
            'Lowtown',
            'LT5 7RA',
            '876 3527');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Miss',
            'Alex',
            'Matthew',
            '4 The Street',
            'Nicetown',
            'NT2 2TX',
            '010 4567');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Adrian',
            'Matthew',
            'The Barn',
            'Yuleville',
            'YV67 2WR',
            '487 3871');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Simon',
            'Cozens',
            '7 Shady Lane',
            'Oahenham',
            'OA3 6QW',
            '514 5926');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Neil',
            'Matthew',
            '5 Pasture Lane',
            'Nicetown',
            'NT3 7RT',
            '267 1232');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Richard',
            'Stones',
            '34 Holly Way',
            'Bingham',
            'BG4 2WE',
            '342 5982');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mrs',
            'Ann',
            'Stones',
            '34 Holly Way',
            'Bingham',
            'BG4 2WE',
            '342 5982');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mrs',
            'Christine',
            'Hickman',
            '36 Queen Street',
            'Histon',
            'HT3 5EM',
            '342 5432');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Mike',
            'Howard',
            '86 Dysart Street',
            'Tibsville',
            'TB3 7FG',
            '505 5482');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Dave',
            'Jones',
            '54 Vale Rise',
            'Bingham',
            'BG3 8GD',
            '342 8264');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Richard',
            'Neill',
            '42 Thached way',
            'Winersby',
            'WB3 6GQ',
            '505 6482');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mrs',
            'Laura',
            'Hendy',
            '73 Margeritta Way',
            'Oxbridge',
            'OX2 3HX',
            '821 2335');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'Bill',
            'ONeill',
            '2 Beamer Street',
            'Welltown',
            'WT3 8GM',
            '435 1234');

INSERT INTO customer
            (title,
             fname,
             lname,
             addressline,
             town,
             zipcode,
             phone)
VALUES     ('Mr',
            'David',
            'Hudson',
            '4 The Square',
            'Milltown',
            'MT2 6RT',
            '961 4526');

--tabela item
INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Wood Puzzle',
            15.23,
            21.95);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Rubic Cube',
            7.45,
            11.49);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Linux CD',
            1.99,
            2.49);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Tissues',
            2.11,
            3.99);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Picture Frame',
            7.54,
            9.95);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Fan Small',
            9.23,
            15.75);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Fan Large',
            13.36,
            19.95);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Toothbrush',
            0.75,
            1.45);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Roman Coin',
            2.34,
            2.45);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Carrier Bag',
            0.01,
            0.0);

INSERT INTO item
            (description,
             cost_price,
             sell_price)
VALUES     ('Speakers',
            19.73,
            25.32);

--tabela stock
INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (1,
            'Wood Puzzle',
            12);

INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (2,
            'Rubic Cube',
            2);

INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (4,
            'Tissues',
            8);

INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (5,
            'Picture Frame',
            3);

INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (7,
            'Fan Large',
            8);

INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (8,
            'Toothbrush',
            18);

INSERT INTO stock
            (item_id,
             description,
             quantity)
VALUES     (10,
            'Carrier Bag',
            1);

--tabela orderinfo
INSERT INTO orderinfo
            (customer_id,
             date_placed,
             date_shipped,
             shipping)
VALUES     (3,
            '13-03-2000',
            '17-03-2000',
            2.99);

INSERT INTO orderinfo
            (customer_id,
             date_placed,
             date_shipped,
             shipping)
VALUES     (8,
            '23-06-2000',
            '24-06-2000',
            0.00);

INSERT INTO orderinfo
            (customer_id,
             date_placed,
             date_shipped,
             shipping)
VALUES     (15,
            '02-09-2000',
            '12-09-2000',
            3.99);

INSERT INTO orderinfo
            (customer_id,
             date_placed,
             date_shipped,
             shipping)
VALUES     (13,
            '03-09-2000',
            '10-09-2000',
            2.99);

INSERT INTO orderinfo
            (customer_id,
             date_placed,
             date_shipped,
             shipping)
VALUES     (8,
            '21-07-2000',
            '24-07-2000',
            0.00);

--tabela orderline
INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (1,
            4,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (1,
            7,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (1,
            9,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (2,
            1,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (2,
            10,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (2,
            7,
            2);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (2,
            4,
            2);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (3,
            2,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (3,
            1,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (4,
            5,
            2);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (5,
            1,
            1);

INSERT INTO orderline
            (orderinfo_id,
             item_id,
             quantity)
VALUES     (5,
            3,
            1);

--tabele
CREATE TABLE film
  (--filmy w wypozyczalni
     film_id      SERIAL PRIMARY KEY,
     title        CHARACTER VARYING(255) NOT NULL,
     release_year SMALLINT,
     language     VARCHAR,
     length       SMALLINT
  );

CREATE TABLE inventory
  (--filmy w magazynie
     inventory_id SERIAL PRIMARY KEY,
     title        CHARACTER VARYING(255) NOT NULL,
     store_id     SMALLINT NOT NULL
  );

--dane
INSERT INTO film
            (title,
             release_year,
             language,
             length)
VALUES      ('Kiler',
             1997,
             'polski',
             103);

INSERT INTO film
            (title,
             release_year,
             language,
             length)
VALUES      ('Ile waży koń trojański?',
             2008,
             'polski',
             118);

INSERT INTO film
            (title,
             release_year,
             language,
             length)
VALUES      ('Seksmisja',
             1983,
             'polski',
             116);

INSERT INTO film
            (title,
             release_year,
             language,
             length)
VALUES      ('Potop',
             1974,
             'polski',
             316);

INSERT INTO inventory
            (title,
             store_id)
VALUES      ('Vabank',
             12);

INSERT INTO inventory
            (title,
             store_id)
VALUES      ('Vabank II czyli riposta',
             14);

INSERT INTO inventory
            (title,
             store_id)
VALUES      ('Seksmisja',
             23);

INSERT INTO inventory
            (title,
             store_id)
VALUES      ('Potop',
             21); 
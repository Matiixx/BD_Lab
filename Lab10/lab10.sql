CREATE TABLE if not exists person
  (
     id SERIAL,
     fname VARCHAR(50),
     lname VARCHAR(60),
     CONSTRAINT person_pk PRIMARY KEY(id)
  );

insert into person(fname, lname) values('Janek', 'Kowalski');
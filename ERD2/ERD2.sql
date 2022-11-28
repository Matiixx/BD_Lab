DROP TABLE IF EXISTS zwiazek;

DROP TABLE IF EXISTS dziecko;

DROP TABLE IF EXISTS rodzic;

DROP TABLE IF EXISTS czlowiek;

CREATE TABLE IF NOT EXISTS czlowiek
  (
     czlowiek_id       SERIAL NOT NULL,
     imie              VARCHAR(30) NOT NULL,
     nazwisko          VARCHAR(50) NOT NULL,
     data_urodzenia    DATE NOT NULL,
     miejsce_urodzenia VARCHAR(50) NOT NULL,
     data_zgonu        DATE,
     CONSTRAINT czlowiek_pk PRIMARY KEY(czlowiek_id)
  );

CREATE TABLE IF NOT EXISTS rodzic
  (
     rodzic_id   SERIAL NOT NULL,
     czlowiek_id INTEGER NOT NULL,
     CONSTRAINT rodzic_pk PRIMARY KEY (rodzic_id),
     CONSTRAINT czlowiek_id_fk FOREIGN KEY(czlowiek_id) REFERENCES czlowiek(
     czlowiek_id) ON DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS dziecko
  (
     dziecko_id  SERIAL NOT NULL,
     rodzic_id INTEGER NOT NULL,
     czlowiek_id INTEGER NOT NULL,
     CONSTRAINT dziecko_pk PRIMARY KEY(dziecko_id),
     CONSTRAINT rodzic_id_fk FOREIGN KEY(rodzic_id) REFERENCES rodzic(
     rodzic_id) ON DELETE CASCADE,
     CONSTRAINT czlowiek_id_fk FOREIGN KEY(czlowiek_id) REFERENCES czlowiek(
     czlowiek_id) ON DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS zwiazek
  (
     zwiazek_id   SERIAL NOT NULL,
     czlowiek_id  INTEGER NOT NULL,
     czlowiek2_id INTEGER NOT NULL,
     CONSTRAINT czlowiek_id_fk FOREIGN KEY(czlowiek_id) REFERENCES czlowiek(
     czlowiek_id) ON DELETE CASCADE,
     CONSTRAINT czlowiek2_id_fk FOREIGN KEY(czlowiek_id) REFERENCES czlowiek(
     czlowiek_id) ON DELETE CASCADE
  ); 

INSERT into czlowiek VALUES (0, 'Maja', 'Michalak', '1946-11-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (1, 'Aurelia', 'Adamczyk', '1989-8-11', 'Krakow', NULL);
INSERT into czlowiek VALUES (2, 'Julian', 'Szulc', '2005-2-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (3, 'Albert', 'Adamczyk', '1917-8-12', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (4, 'Ewelina', 'Kowalczyk', '1996-7-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (5, 'Karina', 'Przybylska', '1926-9-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (6, 'Sylwia', 'Kwiatkowska', '1920-3-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (7, 'Fryderyk', 'Olszewski', '1970-8-6', 'Krakow', NULL);
INSERT into czlowiek VALUES (8, 'Tomasz', 'Wiśniewski', '1969-7-6', 'Krakow', NULL);
INSERT into czlowiek VALUES (9, 'Olga', 'Rutkowska', '1937-5-8', 'Krakow', NULL);
INSERT into czlowiek VALUES (10, 'Aniela', 'Bąk', '1987-10-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (11, 'Dariusz', 'Górski', '1965-2-3', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (12, 'Blanka', 'Grabowska', '1959-7-6', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (13, 'Matylda', 'Kalinowska', '1922-9-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (14, 'Stanisław', 'Grabowski', '2022-3-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (15, 'Marianna', 'Nowak', '1942-10-9', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (16, 'Laura', 'Krawczyk', '1911-6-11', 'Krakow', NULL);
INSERT into czlowiek VALUES (17, 'Amelia', 'Szymczak', '2018-6-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (18, 'Oskar', 'Wójcik', '1975-10-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (19, 'Aleks', 'Kaczmarek', '1914-9-4', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (20, 'Nataniel', 'Nowakowski', '1904-1-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (21, 'Sandra', 'Król', '1965-1-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (22, 'Zofia', 'Szulc', '1932-8-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (23, 'Grzegorz', 'Szczepański', '1977-1-8', 'Krakow', NULL);
INSERT into czlowiek VALUES (24, 'Ewelina', 'Gajewska', '1910-7-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (25, 'Filip', 'Jaworski', '2011-11-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (26, 'Róża', 'Wiśniewska', '1923-10-6', 'Krakow', NULL);
INSERT into czlowiek VALUES (27, 'Inga', 'Jaworska', '1930-1-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (28, 'Julita', 'Baran', '1913-9-3', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (29, 'Inga', 'Adamska', '1909-6-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (30, 'Ewelina', 'Dąbrowska', '1916-10-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (31, 'Marta', 'Przybylska', '1981-12-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (32, 'Mieszko', 'Kaczmarek', '1933-8-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (33, 'Julita', 'Krajewska', '1944-10-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (34, 'Hanna', 'Jaworska', '1967-12-12', 'Krakow', NULL);
INSERT into czlowiek VALUES (35, 'Marcelina', 'Jankowska', '2015-4-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (36, 'Aurelia', 'Kamińska', '1903-12-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (37, 'Sylwia', 'Zielińska', '1907-12-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (38, 'Sylwia', 'Kwiatkowska', '2011-12-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (39, 'Leonard', 'Kaczmarczyk', '2016-4-2', 'Krakow', NULL);
INSERT into czlowiek VALUES (40, 'Jędrzej', 'Kołodziej', '1917-5-9', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (41, 'Szymon', 'Zalewski', '1949-3-2', 'Krakow', NULL);
INSERT into czlowiek VALUES (42, 'Kajetan', 'Brzeziński', '2010-5-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (43, 'Antonina', 'Ostrowska', '1953-9-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (44, 'Izabela', 'Nowak', '1923-2-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (45, 'Kazimierz', 'Dąbrowski', '2003-12-6', 'Krakow', NULL);
INSERT into czlowiek VALUES (46, 'Filip', 'Ziółkowski', '1917-12-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (47, 'Marek', 'Włodarczyk', '2016-8-6', 'Krakow', NULL);
INSERT into czlowiek VALUES (48, 'Nadia', 'Wojciechowska', '1963-2-3', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (49, 'Jerzy', 'Król', '1927-4-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (50, 'Kornel', 'Górski', '1980-5-8', 'Krakow', NULL);
INSERT into czlowiek VALUES (51, 'Józef', 'Szymański', '1929-3-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (52, 'Patryk', 'Baranowski', '2000-11-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (53, 'Kajetan', 'Pawłowski', '1963-10-6', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (54, 'Maksymilian', 'Michalski', '1977-4-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (55, 'Joanna', 'Sokołowska', '1995-12-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (56, 'Kajetan', 'Włodarczyk', '1922-7-6', 'Krakow', NULL);
INSERT into czlowiek VALUES (57, 'Rafał', 'Borowski', '1941-11-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (58, 'Adrian', 'Jabłoński', '1921-9-2', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (59, 'Agata', 'Michalak', '1996-5-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (60, 'Kajetan', 'Szulc', '1959-1-12', 'Krakow', NULL);
INSERT into czlowiek VALUES (61, 'Stanisław', 'Duda', '1991-9-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (62, 'Miłosz', 'Zakrzewski', '1998-11-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (63, 'Roksana', 'Dudek', '1928-7-11', 'Krakow', NULL);
INSERT into czlowiek VALUES (64, 'Hubert', 'Kwiatkowski', '2017-9-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (65, 'Juliusz', 'Majewski', '1933-6-9', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (66, 'Pola', 'Jaworska', '1936-3-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (67, 'Nikodem', 'Makowski', '1993-9-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (68, 'Łucja', 'Nowicka', '1980-12-4', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (69, 'Natasza', 'Nowakowska', '1944-12-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (70, 'Fryderyk', 'Czarnecki', '1951-11-2', 'Krakow', NULL);
INSERT into czlowiek VALUES (71, 'Joanna', 'Baran', '1994-4-8', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (72, 'Damian', 'Laskowski', '1911-5-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (73, 'Barbara', 'Mazurek', '2021-1-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (74, 'Emil', 'Baran', '1995-3-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (75, 'Radosław', 'Kubiak', '1961-9-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (76, 'Andrzej', 'Malinowski', '1990-8-10', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (77, 'Jakub', 'Baranowski', '1946-7-12', 'Krakow', NULL);
INSERT into czlowiek VALUES (78, 'Agata', 'Kubiak', '2000-5-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (79, 'Juliusz', 'Kamiński', '1902-3-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (80, 'Liwia', 'Michalska', '1918-10-2', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (81, 'Malwina', 'Nowak', '1949-8-12', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (82, 'Hubert', 'Grabowski', '1996-9-8', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (83, 'Melania', 'Sadowska', '1929-12-6', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (84, 'Klara', 'Jankowska', '1938-3-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (85, 'Inga', 'Borkowska', '1909-5-11', 'Krakow', NULL);
INSERT into czlowiek VALUES (86, 'Maria', 'Michalska', '1953-2-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (87, 'Daniel', 'Urbański', '1931-1-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (88, 'Sara', 'Dąbrowska', '1925-10-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (89, 'Sara', 'Wiśniewska', '1919-3-3', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (90, 'Jędrzej', 'Marciniak', '1965-3-1', 'Krakow', NULL);
INSERT into czlowiek VALUES (91, 'Iwo', 'Kamiński', '1998-10-4', 'Krakow', NULL);
INSERT into czlowiek VALUES (92, 'Dawid', 'Woźniak', '1987-8-3', 'Krakow', NULL);
INSERT into czlowiek VALUES (93, 'Aniela', 'Andrzejewska', '1974-6-10', 'Krakow', NULL);
INSERT into czlowiek VALUES (94, 'Stanisław', 'Kaźmierczak', '1903-8-5', 'Krakow', NULL);
INSERT into czlowiek VALUES (95, 'Lidia', 'Brzezińska', '1905-5-2', 'Krakow', '2021-10-12');
INSERT into czlowiek VALUES (96, 'Adrian', 'Nowak', '1971-8-9', 'Krakow', NULL);
INSERT into czlowiek VALUES (97, 'Ewelina', 'Rutkowska', '1940-3-7', 'Krakow', NULL);
INSERT into czlowiek VALUES (98, 'Julita', 'Woźniak', '1934-11-11', 'Krakow', NULL);
INSERT into czlowiek VALUES (99, 'Hubert', 'Wysocki', '2019-2-7', 'Krakow', NULL);

INSERT into zwiazek VALUES(0,1,2);
INSERT into zwiazek VALUES(1,11,23);
INSERT into zwiazek VALUES(2,12,13);
INSERT into zwiazek VALUES(3,6,43);
INSERT into zwiazek VALUES(4,14,45);
INSERT into zwiazek VALUES(5,56,58);
INSERT into zwiazek VALUES(6,67,27);
INSERT into zwiazek VALUES(7,72,78);
INSERT into zwiazek VALUES(8,84,89);
INSERT into zwiazek VALUES(9,90,99);

INSERT into rodzic VALUES(0, 0);
INSERT into rodzic VALUES(1, 1);

INSERT into dziecko VALUES(0,0, 1);
INSERT into dziecko VALUES(1,0, 2);
INSERT into dziecko VALUES(2,0, 3);
INSERT into dziecko VALUES(3,1, 4);
INSERT into dziecko VALUES(4,1, 5);

--1
SELECT cz.* from czlowiek cz WHERE cz.czlowiek_id = 12;

--2
SELECT cz2.czlowiek_id, cz2.imie, cz2.nazwisko from czlowiek cz2 join rodzic r using(czlowiek_id) where r.rodzic_id in (SELECT d.rodzic_id from dziecko d join czlowiek cz using(czlowiek_id) where cz.czlowiek_id=4);

--3
SELECT cz.czlowiek_id, cz.imie, cz.nazwisko from dziecko d join rodzic r using(rodzic_id) join czlowiek cz on d.czlowiek_id=cz.czlowiek_id WHERE r.czlowiek_id = 0;
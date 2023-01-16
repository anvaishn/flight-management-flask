CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    origin VARCHAR NOT NULL,
    destination VARCHAR NOT NULL,
    duration INTEGER NOT NULL
);

INSERT INTO flights(origin, destination, duration) VALUES('New york', 'London', 415);
INSERT INTO flights(origin, destination, duration) VALUES('Shanghai', 'Paris', 760);
INSERT INTO flights(origin, destination, duration) VALUES('Istanbul', 'Tokyo', 700);
INSERT INTO flights(origin, destination, duration) VALUES('New york', 'Paris', 435);
INSERT INTO flights(origin, destination, duration) VALUES('Moscow', 'Paris', 245);
INSERT INTO flights(origin, destination, duration) VALUES('Lima', 'New York', 455);

SELECT origin, destination FROM flights; 

SELECT COUNT(*) FROM flights;

SELECT origin, COUNT(*) FROM flights GROUP BY origin;

CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    names VARCHAR NOT NULL,
    flight_id INTEGER REFERENCES flights
);

INSERT INTO passengers (names, flight_id) VALUES ('Alice',1);
INSERT INTO passengers (names, flight_id) VALUES ('Bob',1);
INSERT INTO passengers (names, flight_id) VALUES ('Charlie',2);
INSERT INTO passengers (names, flight_id) VALUES ('Dave',2);
INSERT INTO passengers (names, flight_id) VALUES ('Erin',4);
INSERT INTO passengers (names, flight_id) VALUES ('Frank',6);
INSERT INTO passengers (names, flight_id) VALUES ('Grace',6);


SELECT origin, destination, names FROM flights JOIN passengers ON flights.id = passengers.flight_id;

SELECT flight_id FROM passengers GROUP BY flight_id HAVING COUNT(*) >1;

SELECT * FROM flights WHERE id IN (SELECT flight_id FROM passengers GROUP BY flight_id HAVING COUNT(*) >1);
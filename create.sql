CREATE TABLE Person (
    id varchar(255) NOT NULL PRIMARY KEY,
    personal varchar(255),
    family varchar(255)
);

INSERT INTO Person VALUES ("dyer", "William", "Dyer");
INSERT INTO Person VALUES ("pb", "Frank", "Pabodie");
INSERT INTO Person VALUES ("am", "André", "Marasca");


CREATE TABLE Site (
    name varchar(255) NOT NULL PRIMARY KEY,
    lat Numeric(6,2),
    long Numeric(6,2)
);

INSERT INTO Site VALUES ("DR-1", -49.85, -128.57);
INSERT INTO Site VALUES ("DR-2", -42.45, -121.02);
INSERT INTO Site VALUES ("DR-3", -47.15, -126.72);
INSERT INTO Site VALUES ("DR-4", 0, 0);

CREATE TABLE Visited (
    id int NOT NULL PRIMARY KEY,
    site varchar(255),
    date varchar(255)
);

INSERT INTO Visited VALUES (619, "DR-1", "1927-02-08");
INSERT INTO Visited VALUES (622, "DR-1", "1927-02-10");
INSERT INTO Visited VALUES (800, "DR-2", "1929-02-10");
INSERT INTO Visited VALUES (801, "DR-2", "1929-02-12");
INSERT INTO Visited VALUES (802, "DR-3", "1929-02-12");
INSERT INTO Visited VALUES (803, "DR-3", "1929-02-12");

CREATE TABLE Survey (
    taken int,
    person varchar(255),
    quant varchar(255),
    reading float(255)
);

INSERT INTO Survey VALUES (619, "dyer", "rad", 9.82);
INSERT INTO Survey VALUES (619,	"dyer", "sal", 0.13);
INSERT INTO Survey VALUES (622,	"dyer", "rad", 7.8);
INSERT INTO Survey VALUES (803,	"am", "abc", 3.4);
INSERT INTO Survey VALUES (800,	"am", NULL, 7.23);
INSERT INTO Survey VALUES (801,	"am", NULL, 6.47);
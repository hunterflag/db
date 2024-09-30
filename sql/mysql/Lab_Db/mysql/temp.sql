INSERT INTO lab_db.account (name, password) VALUES ("test1", "test1");
SELECT * FROM lab_db.account;
SELECT "true" FROM lab_db.account WHERE name = "test";
SELECT name FROM lab_db.account WHERE name LIKE "%test%";

show variables;
show variables like "%version%";
show variables like "%admin%";
show open tables;
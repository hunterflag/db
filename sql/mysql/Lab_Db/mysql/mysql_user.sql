use lab_db;

--
SELECT * FROM mysql.user;

--
CREATE USER 'guest'@'localhost' IDENTIFIED BY 'guest';
INSERT INTO mysql.user (User, Host) VALUES ('test', '%');


-- 
DROP user 'guest'@'localhost';
DELETE FROM mysql.user WHERE user = 'guest' ;
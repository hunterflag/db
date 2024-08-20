USE lab_db;

/*
1.建立主表
2.建立異動紀錄表(歷史紀錄表) _history _log
*/
DROP TABLE IF EXISTS table_name;
CREATE TABLE IF NOT EXISTS table_name (
	serial_no 		INT 			PRIMARY KEY AUTO_INCREMENT,
	
    data_column		VARCHAR(100)	NOT NULL DEFAULT "default",
    -- ...
    deleted_flag	BOOLEAN 		NOT NULL DEFAULT FALSE,
    created_time 	DATETIME		NOT NULL DEFAULT now(),
    modified_time 	TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM table_name;

INSERT INTO table_name (data_column) VALUES ("aaa");
INSERT INTO table_name () VALUES ();
SELECT * FROM table_name;

UPDATE table_name 
SET data_column = 'NEW DATA' 
WHERE serial_no = 1 
;
SELECT * FROM table_name;

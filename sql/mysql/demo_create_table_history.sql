USE lab_db;

/*
1.建立主表 demo_create_table.sql
2.建立異動紀錄表(歷史紀錄表) _history _log
3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

*/
-- 1.建立主表 

-- 2.建立異動紀錄表(歷史紀錄表) _history _log
-- 2.1. 同時複製 主表 的 結構、紀錄
DROP TABLE IF EXISTS table_name_history;
CREATE TABLE IF NOT EXISTS table_name_history 
SELECT * FROM table_name
;

SELECT * FROM table_name;
SELECT * FROM table_name_history;


-- 3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

DELIMITER ||
DROP TRIGGER IF EXISTS table_name_after_insert ||
CREATE TRIGGER table_name_after_insert
AFTER INSERT
ON table_name FOR EACH ROW
BEGIN
	INSERT INTO table_name_history (serial_no, data_column, created_time, modified_time)
		values (NEW.serial_no, NEW.data_column, NEW.created_time, NEW.modified_time);
END 
||
DELIMITER ;

-- 在資料被刪除時, 仍可將異動記錄下來

DELIMITER ||
DROP TRIGGER IF EXISTS table_name_after_update ||
CREATE TRIGGER table_name_after_update
AFTER UPDATE
ON table_name FOR EACH ROW
BEGIN
	INSERT INTO table_name_history (serial_no, data_column, created_time, modified_time)
		values (NEW.serial_no, NEW.data_column, NEW.created_time, NEW.modified_time);
END
||
DELIMITER ;

-- 在資料被刪除時, 仍可將異動記錄下來

DROP TRIGGER IF EXISTS table_name_before_delete ;
DELIMITER ||
DROP TRIGGER IF EXISTS table_name_before_delete ||
CREATE TRIGGER table_name_before_delete
BEFORE DELETE
ON table_name FOR EACH ROW
BEGIN
    INSERT INTO table_name_history (serial_no, data_column, deleted_flag, created_time, modified_time)
		VALUE (OLD.serial_no, OLD.data_column, TRUE, OLD.created_time, now()) ;
END
||
DELIMITER ;

/* error: 1442, 因為 正在 update table 的當下, 表格鎖定, 不能再對該表 update, 只能 query
DELIMITER ||
DROP TRIGGER IF EXISTS table_name_after_delete ||
CREATE TRIGGER table_name_after_delete
AFTER DELETE
ON table_name FOR EACH ROW
BEGIN
	-- UPDATE table_name SET deleted_flag = TRUE WHERE serial_no = OLD.serial_no ;
    INSERT INTO table_name (serial_no, data_column, deleted_flag, created_time, modified_time)
	VALUE (OLD.serial_no, OLD.data_column, TRUE, OLD.created_time, now()) ;
END
||
DELIMITER ;

/* test
INSERT INTO table_name () value ();
SELECT * FROM table_name;
SELECT * FROM table_name_history;

SET SQL_SAFE_UPDATES = TRUE;
SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = FALSE;
SET SQL_SAFE_UPDATES = 0;

UPDATE table_name SET data_column = "upaadaddste" WHERE data_column = "default";
SELECT * FROM table_name;
SELECT * FROM table_name_history;

SELECT * 
FROM table_name_history
-- WHERE serial_no = 7  
ORDER BY serial_no, modified_time
;

SELECT * FROM table_name;
DELETE FROM table_name WHERE data_column = "default";
DELETE FROM table_name WHERE data_column = "upaadaddste";
*/

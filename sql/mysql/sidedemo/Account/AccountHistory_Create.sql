-- USE lab_db;

/*
1.建立主表 demo_create_table.sql
2.建立異動紀錄表(歷史紀錄表) _history _log
3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

*/
-- 1.建立主表 

-- 2.建立異動紀錄表(歷史紀錄表) _history _log
-- 2.1. 同時複製 主表 的 結構、紀錄

-- create table and initialize data
DROP TABLE IF EXISTS account_history;
CREATE TABLE IF NOT EXISTS account_history 
SELECT * FROM account
;

-- 2.2.2. 在 歷史表中加入序號欄位、並加上 PK 限制
ALTER TABLE account_history
-- drop primary key, 
-- drop constraint name, 
ADD `serial_no` INTEGER PRIMARY KEY AUTO_INCREMENT FIRST
;

SELECT * FROM account;
SELECT * FROM account_history;


-- 3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

DELIMITER ||
DROP TRIGGER IF EXISTS account_after_insert ||
CREATE TRIGGER account_after_insert
AFTER INSERT
ON account FOR EACH ROW
BEGIN
	INSERT INTO account_history (
			id, 
            name, 
            password, 
            modifiable_flag, 
            deleted_flag, 
            created_time, 
            modified_time
		) VALUES (
        	NEW.id, 
            NEW.name, 
            NEW.password, 
            NEW.modifiable_flag, 
            NEW.deleted_flag, 
            NEW.created_time, 
            NEW.modified_time
		);
END 
||
DELIMITER ;

DELIMITER ||
DROP TRIGGER IF EXISTS account_after_update ||
CREATE TRIGGER account_after_update
AFTER UPDATE
ON account FOR EACH ROW
BEGIN
	INSERT INTO account_history (
			id, 
            name, 
            password, 
            modifiable_flag, 
            deleted_flag, 
            created_time, 
            modified_time
		) VALUES (
        	NEW.id, 
            NEW.name, 
            NEW.password, 
            NEW.modifiable_flag, 
            NEW.deleted_flag, 
            NEW.created_time, 
            NEW.modified_time
		);
END
||
DELIMITER ;

-- 在資料被刪除時, 仍可將異動記錄下來
DROP TRIGGER IF EXISTS account_before_delete ;
DELIMITER ||
DROP TRIGGER IF EXISTS account_before_delete ||
CREATE TRIGGER account_before_delete
BEFORE DELETE
ON account FOR EACH ROW
BEGIN
	INSERT INTO account_history (
			id, 
            name, 
            password, 
            modifiable_flag, 
            deleted_flag, 
            created_time, 
            modified_time
		) VALUES (
        	OLD.id, 
            OLD.name, 
            OLD.password, 
            OLD.modifiable_flag, 
            TRUE, 
            OLD.created_time, 
            now()
		);
END
||
DELIMITER ;

/* test
*/
INSERT INTO account (name) value ("Hunter");
SELECT * FROM account;
SELECT * FROM account_history;

-- 測試前要解除安全更新模式
SET SQL_SAFE_UPDATES = TRUE;
SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = FALSE;
SET SQL_SAFE_UPDATES = 0;

UPDATE account SET password = "12345" WHERE name = "Hunter";
SELECT * FROM account;
SELECT * FROM account_history;

SELECT * 
FROM account_history
-- WHERE serial_no = 7  
ORDER BY serial_no, modified_time
;

SELECT * FROM account;

DELETE FROM account 
WHERE 1=1
	AND name IN ("Hunter")
-- 	AND id = 7;
;
/**/

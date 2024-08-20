USE lab_db;
 truncate table menu_history;
/*
1.建立主表 demo_create_table.sql
2.建立異動紀錄表(歷史紀錄表) _history _log
3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

*/
-- 1.建立主表 

-- 2.建立異動紀錄表(歷史紀錄表) _history _log
-- 2.1. 同時複製 主表 的 結構、紀錄

-- create table and initialize data
DROP TABLE IF EXISTS menu_history;
CREATE TABLE IF NOT EXISTS menu_history 
	SELECT * FROM menu
;

-- 2.2.2. 在 歷史表中加入序號欄位、並加上 PK 限制
ALTER TABLE menu_history
-- drop primary key, 
-- drop constraint name, 
ADD `serial_no` INTEGER PRIMARY KEY AUTO_INCREMENT FIRST
;

SELECT * FROM menu;
SELECT * FROM menu_history;


-- 3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

DELIMITER ||
DROP TRIGGER IF EXISTS menu_after_insert ||
CREATE TRIGGER menu_after_insert
AFTER INSERT
ON menu FOR EACH ROW
BEGIN
	INSERT INTO menu_history (
			type,
            id, 
            parent,
            name, 
            url,
            no,
            modifiable_flag, 
            disable_flag,
            created_time, 
            modified_time
		) VALUES (
        	NEW.type,
            NEW.id, 
            NEW.parent,
            NEW.name, 
            NEW.url,
            NEW.no,
            NEW.modifiable_flag, 
            NEW.disable_flag, 
            NEW.created_time, 
            NEW.modified_time
		);
END 
||
DELIMITER ;

DELIMITER ||
DROP TRIGGER IF EXISTS menu_after_update ||
CREATE TRIGGER menu_after_update
AFTER UPDATE
ON menu FOR EACH ROW
BEGIN
	INSERT INTO menu_history (
			type,
            id, 
            parent,
            name, 
            url,
            no,
            modifiable_flag, 
            disable_flag,
            created_time, 
            modified_time
		) VALUES (
        	NEW.type,
            NEW.id, 
            NEW.parent,
            NEW.name, 
            NEW.url,
            NEW.no,
            NEW.modifiable_flag, 
            NEW.disable_flag, 
            NEW.created_time, 
            NEW.modified_time
		);
END
||
DELIMITER ;

-- 在資料被刪除時, 仍可將異動記錄下來
DROP TRIGGER IF EXISTS menu_before_delete ;
DELIMITER ||
DROP TRIGGER IF EXISTS menu_before_delete ||
CREATE TRIGGER menu_before_delete
BEFORE DELETE
ON menu FOR EACH ROW
BEGIN
	INSERT INTO menu_history (
			type, 
            id, 
            parent,
            name, 
            url,
            no,
            modifiable_flag, 
            disable_flag,
            created_time, 
            modified_time
		) VALUES (
        	OLD.type,
            OLD.id, 
            OLD.parent,
            OLD.name, 
            OLD.url,
            OLD.no,
            OLD.modifiable_flag, 
            OLD.disable_flag, 
            OLD.created_time, 
            OLD.modified_time
		);
END
||
DELIMITER ;

/* test
*/
INSERT INTO menu (type, id, parent, name, url, modifiable_flag) VALUES ("test", "999", null, "使用者", null, false);
INSERT INTO menu (type, id, parent, name) 
	VALUES ("test", "003", "999", "登入")
		  ,("test", "002", "999", "註冊")
		  ,("test", "001", "999", "登出")
;

SELECT * FROM menu;
SELECT * FROM menu_history;

-- 測試前要解除安全更新模式
SET SQL_SAFE_UPDATES = TRUE;
SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = FALSE;
SET SQL_SAFE_UPDATES = 0;

UPDATE menu SET type = "new" WHERE type = "test";
SELECT * FROM menu;
SELECT * FROM menu_history;

SELECT * 
FROM menu_history
-- WHERE serial_no = 7  
ORDER BY no, serial_no, modified_time
;

SELECT * FROM menu;

/**/

/**
 *	1. 關鍵字不區分大小寫, 慣用小寫
 *  2. 自訂欄位名稱: 全小寫, 以 _ 分隔 (搭配 myBatis)
 */
/**
 *	目的：建立表格、與測試資料
 */
/**
 *	表格：account.帳號 
 *	
 * 	檔案修改紀錄
 * 	date 		version	crud	descriptin
 * 	2022-09-28	v0.0.0	c		初始化
 */

-- 0. 使用資料庫 -----------------
SELECT now();
USE lab_db;
SHOW TABLE STATUS;  -- 顯示 user table 的狀況


/* 
-- 2. 建立歷史表.xxx_history
-- 2.1. 同時複製 主表 的 結構、紀錄
-- 2.2. 修改 歷史表 的 結構: 
-- 2.2.1. 移除原主表欄位中的 PK、unique 限制 (其實不需要, 因為複製時, auto_increment、primary、unique 都不會複製)
-- 2.2.2. 在 歷史表中加入所需欄位、並加入 PK 限制
*/

-- 2.1. 同時複製 主表 的 結構、紀錄
DROP TABLE IF EXISTS account_history;

CREATE TABLE IF NOT EXISTS  account_history 
SELECT * FROM account
;

SELECT * FROM account;	
SELECT * FROM account_history;	

/*
-- 2.2. 修改 歷史表 的 結構: 
-- 2.2.1. 移除原主表欄位中的 PK、unique 限制
alter table account_history 
drop primary key, 
drop constraint name 
;
*/

-- 2.2.2. 在 歷史表中加入序號欄位、並加上 PK 限制
ALTER TABLE account_history
ADD no INTEGER PRIMARY KEY AUTO_INCREMENT FIRST
;

CREATE INDEX account_history_index
ON account_history (id, name)
;

SELECT * FROM account_history;

-- 3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內


delimiter ||
drop trigger if exists account_after_insert ||
create trigger account_after_insert
after insert
on account for each row
begin
	insert into account_history (name, password, id, created_time, modified_time)
		values (NEW.name, NEW.password, NEW.id, NEW.created_time, NEW.modified_time);
end 
||
delimiter ;

delimiter ||
drop trigger if exists account_after_update ||
create trigger account_after_update
after update
on account for each row
begin
	insert into account_history (name, password, id, created_time, modified_time)
		values (NEW.name, NEW.password, NEW.id, NEW.created_time, NEW.modified_time);
end
||
delimiter ;

select now() ;

/**
 * test for account and account_history
 */
SELECT * FROM account;
SELECT * FROM account_history;

INSERT INTO account (name, password) VALUES ("guest", "guest");
SELECT * FROM account;
SELECT * FROM account_history;

UPDATE account SET password = "12ss3456" WHERE name = "tester";
UPDATE account SET password = "12ss3456", name = "tester" WHERE id=3;
SELECT * FROM account;
SELECT * FROM account_history;

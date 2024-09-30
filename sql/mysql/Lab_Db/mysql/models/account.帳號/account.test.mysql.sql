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
use lab_db;
-- 1. 建立主表.xxx
DROP TABLE IF EXISTS account;
CREATE TABLE IF NOT EXISTS account (
    id		 		INTEGER 		NOT NULL PRIMARY KEY AUTO_INCREMENT,		
    name			VARCHAR(100) 	NOT NULL UNIQUE,
    password		VARCHAR(100)	NOT NULL DEFAULT "0000"
);

-- 2. 初始資料(測試用)
INSERT INTO account (name, password) 
	VALUES 	("admin", "admin")
			, ("developer", "developer")
			, ("tester", "tester")
            , ("guest", "guest")
;
-- 3. 顯示
SELECT * FROM account;

/*

TRUNCATE account;

CREATE UNIQUE INDEX name_index 
ON account (name)
;
truncate account;

alter table account
	  drop primary key
	, add constraint primary key (id)
	, add constraint unique (name)
    , change column id id integer not null comment '識別碼'
	, comment 'appＡ設定參數表'
;

*/

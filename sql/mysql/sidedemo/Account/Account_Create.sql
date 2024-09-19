-- CREATE DATABASE IF NOT EXISTS <資料庫名稱>;
CREATE DATABASE IF NOT EXISTS Lab_Db;
USE Sidedemo;
-- DROP DATABASE IF EXISTS <資料庫名稱> ;
-- DROP DATABASE IF EXISTS Lab_Db ;

/* 0. <codeStyle.編碼風格>.慣用:
	0.1. 關鍵字: 不區分大小寫, 慣用全大寫
    0.2. 表格名: 採大駝峰
    0.3. 欄位名稱: 全小寫, 單詞以 _ 連接、分隔單字 (搭配 myBatis)
    0.4. 其他名稱: 採小駝峰, <分類別><名稱>, 如函數、程序等
*/
-- ==========================================================================
-- --------------------------------------------------------------------------

/* 1. <mainTable.主表> 建立程序 & 注意事項:
2.建立異動紀錄表(歷史紀錄表) _history _log
帳號:
1.首字限定英文
2.可用字元: 
2.1.英文:區分大小寫
2.2.數字:
2.3.符號:
3.長度: 
密碼:


*/
-- 表格 ==========================================================================
-- 表格.建立
CREATE TABLE IF NOT EXISTS Account (
	no				INTEGER			PRIMARY KEY	AUTO_INCREMENT 	COMMENT "序號",
    name			VARCHAR(100) 	NOT NULL					COMMENT "名稱",
    password		VARCHAR(100)	NOT NULL	DEFAULT "0000"	COMMENT "密碼",

--    modifiable	    BOOLEAN			NOT NULL DEFAULT TRUE		COMMENT, name, password,  "可修改",
--    deleted         BOOLEAN 		NOT NULL DEFAULT FALSE		COMMENT "已刪除",

	created_time	DATETIME 		NOT NULL 	DEFAULT now()	COMMENT "建立時間",
    modified_time 	TIMESTAMP		NOT NULL 	DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "最後異動時間"
);

SELECT no, name, password, modifiable, deleted, created_time, modified_time FROM Account; 

-- 表格.刪除
DROP TABLE IF EXISTS Account;

-- 資料 ==========================================================================
-- 資料.新增
-- 資料.新增.initialize data 初始資料
INSERT INTO account (name, password, modifiable_flag) VALUES ("root", "root", FALSE);
INSERT INTO account (name, password, modifiable_flag) VALUES ("guest", "guest", FALSE);
INSERT INTO account (name, password) VALUES ("tester", "tester");
INSERT INTO account (name, password) VALUES ("developer", "developer");

-- 資料.新增.test data 測試資料
INSERT INTO account (name) VALUES ("John");
INSERT INTO account (name) VALUES ("Frank");
INSERT INTO account (name) VALUES ("Ken");

-- 資料.查詢
SELECT no 序號
	, name 名稱 
    , password 密碼
    , created_time 建立時間
    , modified_time 最後修改時間
--	, tA.*
FROM Account tA
;

-- 資料.更新
-- error.1175. 關閉
SET SQL_SAFE_UPDATES=0; 

UPDATE Account
SET password = '1234'
WHERE 1=1
	AND name IN ("John")
;
-- 結束後再開啟
SET SQL_SAFE_UPDATES=1;

-- 表格.重置資料.清除
TRUNCATE TABLE Account;

SELECT * FROM Account;

INSERT INTO Account VALUES (SELECT a.* FROM Account a);
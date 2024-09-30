-- 表格.建立 ==========================================================================
CREATE TABLE IF NOT EXISTS Account (
	no				INTEGER			PRIMARY KEY	AUTO_INCREMENT 	COMMENT "序號",
    name			VARCHAR(100) 	NOT NULL					COMMENT "名稱",
    password		VARCHAR(100)	NOT NULL	DEFAULT "0000"	COMMENT "密碼",

	created_time	DATETIME 		NOT NULL 	DEFAULT now()	COMMENT "建立時間",
    modified_time 	TIMESTAMP		NOT NULL 	DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "最後異動時間"
);

-- 資料 ==========================================================================
-- 資料.新增.test data 測試資料
INSERT INTO account (name) 
	VALUES ("John")
		, ("Frank")
        , ("Ken")
;

-- 資料.查詢 ==============================================================================
SELECT no 序號
	, name 名稱 
    , password 密碼
    , created_time 建立時間
    , modified_time 最後修改時間
--	, tA.*
FROM Account tA
;

/*
-- 表格.重置資料.清除
TRUNCATE TABLE Account;

DROP TABLE IF EXISTS Account;
*/

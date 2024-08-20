/*
	1. 關鍵字不區分大小寫, 慣用小寫
    2. 自訂欄位名稱: 全小寫, 以 _ 分隔 (搭配 myBatis)
*/
use labDB;

DROP TABLE IF EXISTS i18n;
CREATE TABLE IF NOT EXISTS i18n (
    
	key_name		VARCHAR(100) 	NOT null,
    language		VARCHAR(2)		NOT null DEFAULT "zh",
    country			VARCHAR(2)		NOT null DEFAULT "TW",
	key_value		VARCHAR(100)	NOT null ,
    
    serial_no 		INTEGER 		NOT null UNIQUE AUTO_INCREMENT,		
    created_time	DATETIME 		NOT null DEFAULT CURRENT_TIMESTAMP,
    modified_time	TIMESTAMP		NOT null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
    CONSTRAINT primary_key PRIMARY KEY (key_name, language, country)
);

INSERT INTO i18n (key_name, language, country, key_value) VALUE ("hello", "zh", "TW", "你好");

SELECT * FROM i18n;

TRUNCATE TABLE i18n;
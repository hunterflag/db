/*
 * ref: https://docs.oracle.com/javase/8/docs/api/index.html?java/util/Locale.html
*/
CREATE DATABASE IF NOT EXISTS labDB ;
use labDB;

DROP TABLE IF EXISTS i18n;
CREATE TABLE IF NOT EXISTS i18n (
	key_name		VARCHAR(100) 	NOT NULL	COMMENT "關鍵字",
    language		VARCHAR(2)		NULL 		COMMENT "語言",
    country			VARCHAR(2)		NULL 		COMMENT "國家",
	key_value		VARCHAR(100)	NULL 		COMMENT "內容",
    
    no 				INTEGER 		NOT NULL PRIMARY KEY AUTO_INCREMENT,		
    created_time	DATETIME 		NOT NULL DEFAULT now(),
    modified_time	TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    
--    , CONSTRAINT primary_key PRIMARY KEY (key_name, language, country)
    , CONSTRAINT unique_key UNIQUE KEY (key_name, language, country)
);

INSERT INTO i18n (key_name, language, country, key_value) 
VALUE ("developer", null, null, null)
    , ("developer", "en", null, "developer")
	, ("developer", "en", "US", "developer")
	, ("developer", "zh", "TW", "開發者")
	, ("developer", "zh", "CN", "开发人员")
;

INSERT INTO i18n (key_name, language, country, key_value) 
VALUE ("test", "zh", "TW", "測試")
	, ("test", "en", "US", "test")
    , ("check", "zh", "TW", "你好")
    ;
INSERT INTO i18n (key_name, language, country, key_value) 
VALUE ("test", "zh", "TW", "測試")
;

	, ("test", "en", "US", "test")
    , ("check", "zh", "TW", "你好")
;

SELECT * FROM i18n;

TRUNCATE TABLE i18n;
USE lab_db;

/*	menu.選單項目表
用來產生前端用的選單項目

欄位說明:
type: 選單分類
		預設為 main
        依需求, 自訂選單分類名稱
id:	選項代碼, 決定層級、顯示順序
	999 為預設根選項
    899	依百位數、十位數、個位數順序, 決定其次級選單的屬性與顯示
parent: 為上層選單之 id
name:	選項名稱 (要顯示的預設字串)

i18nCode:	
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
use test;

-- create table
DROP TABLE IF EXISTS menu;
CREATE TABLE IF NOT EXISTS menu (
	type		VARCHAR(100)	NOT NULL DEFAULT "main",
    id	 		VARCHAR(3) 		NOT NULL,
	parent		VARCHAR(3)		,
    name		VARCHAR(100)	NOT NULL DEFAULT "not assign",
    url			VARCHAR(100)	DEFAULT "localhost",
    
    no				int				NOT NULL UNIQUE AUTO_INCREMENT,
    modifiable_flag	BOOLEAN			NOT NULL DEFAULT TRUE,
    disabled_flag	BOOLEAN 		NOT NULL DEFAULT FALSE,
    created_time 	DATETIME		NOT NULL DEFAULT now(),
    modified_time 	TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
    CONSTRAINT PRIMARY KEY (type, id)
);

SELECT type, parent, id, m.* 
FROM menu m
WHERE disabled_flag = FALSE
ORDER BY type, id DESC
;

SELECT DISTINCT type FROM menu;

truncate table menu;
-- initialize data 初始資料
INSERT INTO menu (id, parent, name, url, modifiable_flag) VALUES ("999", null, "主功能", null, false);
INSERT INTO menu (id, parent, name) 
	VALUES ("199", "999", "lvl.1")
		  ,("299", "999", "lvl.2")
		  ,("210", "299", "lvl.2.1")
		  ,("220", "299", "lvl.2.2")
		  ,("230", "299", "lvl.2.3")
		  ,("399", "999", "lvl.3")
;

INSERT INTO menu (type, id, parent, name, url, modifiable_flag) VALUES ("user", "999", null, "使用者", null, false);
INSERT INTO menu (type, id, parent, name) 
	VALUES ("user", "003", "999", "登入")
		  ,("user", "002", "999", "註冊")
		  ,("user", "001", "999", "登出")
;


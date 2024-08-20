USE lab_db;

/*	menu.選單項目表
用來產生前端用的選單項目

欄位說明:
	結構欄位:
    type: 選單分類
			預設為 main
			依需求, 自訂選單分類名稱
	id:	選項代碼, 決定層級、顯示順序
		999 為預設根選項
		899	依百位數、十位數、個位數順序, 決定其次級選單的屬性與顯示
	parent: 為上層選單之 id
    
	name:	選項名稱 (要顯示的預設字串)
	url:	選項連結網址
	i18nCode: 保留

*/
use test;

-- create table
DROP TABLE IF EXISTS menu;
CREATE TABLE IF NOT EXISTS menu (
	-- st 欄位
    type		VARCHAR(100)	NOT NULL DEFAULT "main",
    id	 		VARCHAR(3) 		NOT NULL,
	parent		VARCHAR(3)		,
    
    -- data 欄位
    name		VARCHAR(100)	NOT NULL DEFAULT "not assign",
    url			VARCHAR(100)	DEFAULT "https://example.com/",
    
    -- db 欄位
    no				int				NOT NULL UNIQUE AUTO_INCREMENT,
    modifiable_flag	BOOLEAN			NOT NULL DEFAULT TRUE,
    disable_flag	BOOLEAN 		NOT NULL DEFAULT FALSE,
    created_time 	DATETIME		NOT NULL DEFAULT now(),
    modified_time 	TIMESTAMP 		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
    CONSTRAINT PRIMARY KEY (type, id)
);

SELECT type, parent, id, m.* 
FROM menu m
WHERE 1=1
	AND disable_flag = FALSE
ORDER BY type, id DESC
;

SELECT DISTINCT type 
FROM menu
-- WHERE parent IS NULL
;

truncate table menu; 
-- initialize data 初始資料
INSERT INTO menu (id, parent, name, url, modifiable_flag) VALUES ("999", null, "主功能", null, false);
INSERT INTO menu (id, parent, name) 
	VALUES ("399", "999", "觀點")
		  ,("299", "999", "技術")
		  ,("230", "299", "前端")
		  ,("220", "299", "後端")
		  ,("210", "299", "API")
		  ,("100", "999", "評論")
;

INSERT INTO menu (type, id, parent, name, url, modifiable_flag) VALUES ("user", "999", null, "使用者", null, false);
INSERT INTO menu (type, id, parent, name) 
	VALUES ("user", "003", "999", "登入")
		  ,("user", "002", "999", "註冊")
		  ,("user", "001", "999", "登出")
;


/*
	1. 關鍵字不區分大小寫, 慣用小寫
    2. 自訂欄位名稱: 全小寫, 以 _ 分隔 (搭配 myBatis)
*/
USE Lab_DB;
SET @tableName = "Test";
SELECT @tableName;
SELECT * FROM @tableName;

CREATE TABLE IF NOT EXISTS Test (
    name		VARCHAR(100) 	NOT NULL,
    value		VARCHAR(100)	NOT NULL	DEFAULT "0000",
    
    no 			Integer 		PRIMARY KEY AUTO_INCREMENT,
    created		DATETIME 		NOT NULL 	DEFAULT now()
);

INSERT Test (name, value)
	 -- VALUES ("nnn", "vvv"), ("nnn", "vvv")
     (SELECT "nnn", "vvv")
     ; 
 
 SELECT * FROM Test;
 TRUNCATE Test;
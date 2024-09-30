/*
# 變數的種類 SSL x3: 系統變數、自訂變數、區域變數
## 依生命週期分: system(server)、session、local (BEGIN...END)
### 系統內建變數： 以 @@ 開頭, read only, 不可新增
### 使用者自訂變數: 以 @ 開頭, 預設值為 null, 取用前未宣告, 會自動宣告
### local 變數
+ 區域變數： 在 BEGIN...END 範圍內; 使用前, 以 DECLARE 宣告
*/

-- system ========================================================
-- system.增 (不能) ----------------------------------------
-- SET GLOBAL new_connect = 20; 
-- system.刪 (不能) ----------------------------------------
-- SET GLOBAL connect_timeout = NULL; 
-- system.改 -----------------------------------------------------
SET GLOBAL connect_timeout = 10;
-- SET connect_timeout = 10;
-- SET SQL_SAFE_UPDATES = '1';     -- Error.1231 值 的 資料型別 與 變數 的 資料型別 不符
SET GLOBAL SQL_SAFE_UPDATES = 1;    -- 系統內建會分兩級 標準寫法
SET SESSION SQL_SAFE_UPDATES = 0;   -- 省略 SESSION
SET SQL_SAFE_UPDATES = 0;           -- 省略 SESSION
SET @SQL_SAFE_UPDATES = 1;           -- 省略 SESSION
SET SQL_SAFE_UPDATES = @SQL_SAFE_UPDATES; 

SELECT @@SQL_SAFE_UPDATES;          -- 調用時, 只取出有效值: SESSION > GLOBAL
SELECT @SQL_SAFE_UPDATES;          -- 調用時, 只取出有效值: SESSION > GLOBAL

-- SET @@connect_timeout = 20;  -- Error.1229
-- system.查/用 -----------------------------------------------------
SHOW VARIABLES;         -- 系統變數總表
SELECT @@connect_timeout;
-- SELECT * FROM mysql;

-- session ========================================================
-- session.增 --------------------------------------------------
SET @abc = "eee";
SET @abc := 123;
SET @abc = "eee", @abc := 123;   -- 一次設定多個變數
SET SESSION sss='ddd'; 
SET @abcd=@abc;     -- 在執行時, ＝右邊就已經取得結果, 而非保留運算式
-- session.刪
SET @abcd=null;     -- 
SET @abcd=NULL;
-- session.改 --------------------------------------------------
-- session.查/用 --------------------------------------------------
SELECT @abcd;
SELECT @ddd;        -- 變數不存在時, 直接給 NULL.空值

/*
*/
-- 字串 "NULL" 與 NULL.空值 顯示時的外觀不同
-- sql 的 identifier 不分大小寫, 顯示則以大寫為主, 故 null 都顯示為 NULL 
SELECT "", NULL, null, "NULL", "null" ;     
SELECT @abcd, @ddd;


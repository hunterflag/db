/* 內建函數
 * https://dev.mysql.com/doc/refman/8.0/en/functions.html
 */

CREATE DATABASE IF NOT EXISTS LAB_DB;
USE LAB_DB;

-- DROP DATABASE IF EXISTS LAB_DB; 

SELECT;
-- 字串
SELECT ascii("0");
SELECT ascii("01");

-- 日期時間 = 日期 ＋ 時間
SELECT system_date();
SELECT now() 日期時間
    , current_date() 日期
    , current_time() 時間;

-- flow control 
-- CASE ... WHEN ... THEN ... ELSE ... END
SELECT 
    CASE "cond-c" 
        WHEN "cond-a" THEN "return-a"
        WHEN "cond-b" THEN "return-b"
        ELSE "return_else"
    END
;
SELECT 
    CASE 
        WHEN 1=2 THEN "return-a"
        WHEN 1=2 THEN "return-b"
        ELSE "return_else"
    END
;




SELECT now();
SELECT 1+2 運算式;
SELECT decode(1, 1, true, "default");
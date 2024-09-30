/*
日期
字串
數值

轉換
進階
*/
-- 其它.
-- 其它.使用者
SELECT current_user();      -- 使用者@可用的主機名稱(原始字串)
SELECT user();              -- 使用者@連線進來的主機名稱
SELECT system_user();       -- 使用者@連線進來的主機名稱
SELECT session_user();      -- 使用者@連線進來的主機名稱

SELECT last_insert_id();
SELECT version();
SELECT database();
SELECT connection_id();

-- 其它.mull檢查
SELECT isnull(null);            -- 是 null 傳回 1, 否則傳 0
SELECT isnull("dd");

SELECT ifnull(null, "dd");      -- S0 不是 null, 直接傳 S0; 是 null, 改用 S1 代替傳回 
SELECT ifnull("ss", "dd");
SELECT ifnull(null, null);          -- 無意義, 但正確、可接受

-- 其它.比較    
SELECT if(1>0, "true", "false");                
SELECT nullif("ss", "ss");      -- 若 S0 = S1, 傳回 null, 否則傳S0; 
SELECT nullif("dd", "ss");
SELECT nullif("dd", null);
SELECT nullif(null, "ss");
SELECT nullif(12, 12);          -- 數值會先正規化
SELECT nullif(12.1, 12.10);
SELECT nullif(012, 12.0);
SELECT nullif("012", "12.0");
    -- 混合型別時, 1.數值先正規化 2.字串再數值(正規)化 
SELECT nullif("012", 12.0);         -- 12.0數值->正規化->12; "012" ->數值化-> 12
SELECT nullif(012, "12.0");         -- 012數值->正規化->12; "12.0" ->數值化-> 12
SELECT nullif(12, "ss");            -- 12數值->正規化->12->轉字串 "12"
SELECT nullif(012, "12");           
SELECT nullif("12", 012);            -- 012數值->正規化->12; "12" ->數值化-> 12

-- 其它.轉換.型別
SELECT cast();
-- 其它.轉換.數值系統 (1.由左讀到有效位數, 並解讀)
SELECT conv(15, 10, 2);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(15, 10, 8);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(15, 10, 16);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(15, 2, 10);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(105, 2, 10);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(1015, 2, 10);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv("15", 16, 16);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv("15", 16, 8);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv("abc", 16, 2);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(abc, 16, 2);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
SELECT conv(0xabc, 16, 2);     -- 將 S0, 以 S1進位 解讀, 再轉換為 S2進位  
-- 其它.轉換.字元編碼    
SELECT convert("說中文" USING gbk );           
SELECT charset("說中文");
SELECT charset(convert("說中文" USING gbk ));    
SELECT convert("說中文" USING ascii );    
SELECT charset(convert("說中文" USING ascii ));   

SELECT binary("abcde"); -- 轉乘 BLOB

-- 數值.進制.轉換
SELECT bin(10);
SELECT bin(-10);    -- 2's補數, 10反向+1
SELECT bin(10.1); -- 限定整數
SELECT bin(0xf);    
SELECT bin(0b1010);    -- 10進制 9
SELECT bin(0o1010);    -- 數值表示法不支援 8進制
SELECT bin(30);    -- 2進制
SELECT hex(30);    -- 16進制
SELECT oct(30);    -- 8進制

-- 數值.進制.手動任毅進制轉換
-- 1.格式 conv(數值, 原進制, 新進制)
-- 2.數值須符合原進制的限制, 否則只會採到到有效數字為止, 全無效則數值歸零
SELECT conv(32, 10, 2);
SELECT conv("32a", 10, 2);  -- 字串轉數值()
SELECT conv(32, 3, 2);
SELECT conv(23, 3, 2);

-- 轉換.型別
-- 1.表示式要正確
-- 2.表示式的結果值, 要能轉換過去
SELECT cast("123" AS DECIMAL);
SELECT cast("123ab" AS DECIMAL);
SELECT cast("0123ab" AS DECIMAL);
SELECT cast("0x123ab" AS DECIMAL);
SELECT cast("0x123ab" AS BINARY);
SELECT cast("0x123ab" AS TEXT);
SELECT cast(cast("0x123ab" AS BINARY) AS CHAR);
SELECT cast(0x11 AS DECIMAL);

SELECT 
    CASE 1+2+3                      -- 有運算式時,
        WHEN 1 THEN "result1"       -- 判斷式為 運算結果=狀態值, 就是 true, 為真即成立
        WHEN 2 THEN "result2"
        WHEN 3 THEN "result3"
        ELSE "resultN"           -- 預設值         
    END                             -- 無適當狀況, 就給 null
;
SELECT 
    CASE                            -- 無運算式時,
        WHEN 1=1 THEN "result1"       -- 各自準備判斷式, 為真即成立
        WHEN true THEN "result2"
        WHEN false THEN "result3"
        -- ELSE "resultN"           -- 預設值         
    END                             -- 無適當狀況, 就給 null
;
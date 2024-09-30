/*
日期
字串
數值

轉換
進階
*/
-- 日期、時間
SELECT now(), current_date(), current_time(), current_timestamp(), curtime();
SELECT now();                   -- 日期、時間
SELECT current_date();          -- 日期
SELECT current_time();          -- 時間 
SELECT current_timestamp();     -- 日期、時間
SELECT curtime();               -- 時間

-- 字串
-- ascii(...) 第一個字元的 ascii值
SELECT ascii(0), ascii(" "), ascii("0"), ascii("A"), ascii("a");
SELECT ascii(0), ascii(012);
SELECT ascii('0'), ascii('012');
SELECT ascii("A"), ascii("ABC");
SELECT ascii('A'), ascii('ABC');

-- 字串.長度.字元數 char_length("字串")
-- 字串.長度.byte數 length("字串")
SELECT char_length("123abc");
SELECT char_length("中文123abc");     -- utf8 字元, 中文也是1個字元
SELECT length("中文123abc");     	  -- 3 bytes/utf8字元
SELECT char_length("\t\n");     -- 控制字元也是1個
SELECT char_length("123     abc");  

SELECT char_length(123);                -- 需轉成字串
SELECT char_length(0123);               -- 先轉數值, 再轉字串
-- SELECT char_length(0123abc);         -- 轉數值就失敗

-- char_length("string") 相同於 character_length("string") 
SELECT character_length("123abc");
SELECT character_length("中文123abc");     -- utf8 字元, 中文也是1個字元

-- 以 第幾個分隔號 決定要取出的子字串; 
-- 正值: 從(頭)左邊數、取左字串(取到頭)
-- 負值: 從(尾)右邊數、取右字串(取到尾)
SELECT substring_index("123, 456, 789, abc, 123, 456, 789, abc", ",", 2);   -- 
SELECT substring_index("123, 456, 789, abc, 123, 456, 789, abc", ",", -2);   -- 

-- 字串.串接
SELECT concat("123", "ABC", "abc");
SELECT concat_ws("---", "123", "ABC", "abc");       --  中間加上分隔字串
SELECT char_length(concat("123", "ABC", "abc"));

-- 字串.S0字串 出現在 第幾個字串
SELECT field("",    "123", "ABC", "abc");
SELECT field("1",   "123", "ABC", "abc");
SELECT field("12",  "123", "ABC", "abc");
SELECT field("123", "123", "ABC", "abc");
-- 字串.S0字串 出現在 S1集合字串 中的 第幾個字串
SELECT find_in_set("123", "123, ABC, abc");
SELECT find_in_set("1", "中文123ABCabc");
-- 字串.S0字串 出現在 S1字串 中的 第幾個字元
-- locate("待搜字串", "被搜字串")
SELECT locate("s", "");                      -- 被搜字串為空字串時, 怎麼也找不到, 一律傳回 0
SELECT locate("", "中文123ABCabc");           -- 待搜字串是空字串, 一律傳回 1
SELECT locate("s", "中文123ABCabc");          -- 找不到, 就是 0 
SELECT locate("中", "中文123ABCabc");
SELECT locate("1", "中文123ABCabc");
SELECT locate("a", "中文123ABCabc");          -- 不分大小寫
SELECT locate("bca", "中文123ABCabc");

-- 字串.編輯.填空
SELECT lpad("123", 5, 'x');         -- 用指定字串, 將原字串填補到指定長度
-- 字串.編輯.取子字串
SELECT lower("ABCDE");
SELECT left("1234567890", 5);
SELECT right("1234567890", 5);
SELECT mid("1234567890", 5, 3);
SELECT substr("1234567890", 5, 3);
SELECT substring("1234567890", 5, 3);
-- 字串.編輯.
SELECT trim("  1234567890 1234567890 ");
SELECT ltrim("  1234567890 1234567890 ");
SELECT rtrim("  1234567890 1234567890 ");
-- 字串.編輯.
-- 字串.編輯.
-- 字串.編輯.
-- 字串.編輯.轉換
SELECT lcase("ABCDEabcde");
SELECT lower("ABCDEabcde");
SELECT ucase("ABCDEabcde");
SELECT upper("ABCDEabcde");
SELECT replace("123", '3', 'aaa');                  -- 將 S0字串 中的 S1字串, 用 S2字串 取代
SELECT reverse("1234567890");
SELECT concat("123", space(5), "abc");
SELECT position("345" IN "1234567890");

-- 字串.編輯
SELECT insert("1234567890", 5,3, "中文123ABCabc");    -- 從舊字串的第n個字開始、長度為m的子字串, 改以新字串來插入
SELECT insert("1234567890", 9,3, "中文123ABCabc");
SELECT find_in_set("", "中文123ABCabc");

-- 字串.格式化
SELECT format(123456.0987, 2);      -- 下一位要先四捨五入 
SELECT format(123456.7, 2);         -- 小數位數要留 0
SELECT format(123456.7, 3); 

-- 字串.比較
SELECT strcmp("1234567890", "123");
SELECT strcmp("123", "123");
SELECT strcmp("123", "1234567890");


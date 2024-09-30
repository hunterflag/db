/*
date
time
timestamp
datetime
year
*/

-- 日期.

-- 日期.取.自動
SELECT now(), current_timestamp();
SELECT curdate(), current_date();
SELECT curtime(), current_time();
SELECT curdate(), curtime();

-- 日期.取.手動
-- 日期.轉換.字串到日期
SELECT date("2022-02-20");                                  -- 日期字串 -> 日期
SELECT date("2022-02-20");
SELECT date("1899-12-20");
SELECT date("2022-02-29");                                  -- null, 不存在 或 非正確的日期字串
SELECT date("1967-22-20");
SELECT str_to_date("2022-02-20", "%Y-%m-%d");               -- 日期字串 -> 日期
SELECT time("13:23:33");                                    -- 時間字串 轉 時間    
SELECT timestamp("2023-01-30", "13:23:33");                 -- 錯誤時, 傳回 null  
SELECT timestamp("2023-01-30");                             -- 時間省略, 預設為 00:00:00            
SELECT timestamp("13:23:33");                               -- 日期不可省
SELECT timestamp("2023-01-30 10:10:10", "13:23:33");        -- 日期可加時間, 但以時間為準 
SELECT timestamp("2023-01-30 10:10:10");                    -- 日期可加時間, 沒有時間就直接採用 

-- 日期.轉換.日期到字串
SELECT date_format("1967-12-20", "%y/%m/%d %r");            -- 公元年末2位 
SELECT date_format("1967-12-20", "%Y/%M/%D %h:%m:%s");      -- 公元年完整4位 

SELECT time_format("13:23:33", "%r");
SELECT time_format("13:23:33", "%h:%:%s %p");                   -- 12時
SELECT time_format("13:23:33", "%H:%m:%s");                     -- 24時


-- 日期.抽
SELECT date("2023-02-28"),                      year(date("2023-02-28"));                         -- 該日期的年
SELECT date("2023-02-28 13:12:11.123456789"),   year(date("2023-02-28 13:12:11.123456789"));          -- 多出來的資訊, 被忽略不用
SELECT date("2023-02-28 13:12:11.123456789"),   year(date("2023-02-28 23:12:11.123456789"));          -- 多出來的資訊, 被忽略不用, 但還是要對; 錯了就是 null
SELECT date("2023-02-28"),                      month(date("2023-02-28"));                        -- 該日期的月
SELECT date("2023-02-28"),                      day(date("2023-02-28"));                          -- 該日期的日
SELECT date("2023-02-28 13:12:11.123456789"),   hour("2023-02-28 13:12:11.123456789");            -- 該日期的時
SELECT date("2023-02-28 13:12:11.123456789"),   minute("2023-02-28 13:12:11.123456789");          -- 該日期的分
SELECT date("2023-02-28 13:12:11.123456789"),   second("2023-02-28 13:12:11.6789");               -- 該日期的秒
SELECT date("2023-02-28 13:12:11.123456789"),   microsecond("2023-02-28 13:12:11.123456789");     -- 該日期的微秒 (取到第6位, 但第7位四捨五入)
    


SELECT date("2023-02-28"), dayofyear(date("2023-02-28"));     -- 該年的第幾天
SELECT date("2023-02-28"), dayofmonth(date("2023-02-28"));    -- 該月的第幾天
SELECT date("2023-02-28"), dayofweek(date("2023-02-28"));     -- 該週的第幾天, 周日起算 (1, 2, 3, ...)
SELECT date("2023-02-28"), dayname(date("2023-02-28"));       -- 該週的星期幾, 周日起算 (Sunday, Monday, ...)
SELECT date("2023-02-28"), weekday(date("2023-02-28"));       -- 該週的星期幾, 周一起算 (0, 1, 2, ...)
SELECT date("2023-02-28"), week(date("2023-02-28"));          -- 該日是第幾週
SELECT date("2023-02-28"), weekofyear(date("2023-02-28"));    -- 該日是第幾週
SELECT date("2023-02-28"), quarter(date("2023-02-28"));       -- 該日是第幾季

-- 日期.比較
SELECT diff();
SELECT datediff("2023-01-22", "2023-02-22");    -- D0 - D1
SELECT datediff("2023-02-22", "2023-02-29");    -- 任一日期不合法, 就是 null



-- 日期.計算
SELECT curdate(), adddate(curdate(), 3);
/* type: 可用的單位清單如下
MICROSECOND
SECOND
MINUTE
HOUR
DAY
WEEK
MONTH
QUARTER
YEAR
SECOND_MICROSECOND
MINUTE_MICROSECOND
MINUTE_SECOND
HOUR_MICROSECOND
HOUR_SECOND
HOUR_MINUTE
DAY_MICROSECOND
DAY_SECOND
DAY_MINUTE
DAY_HOUR
YEAR_MONTH
*/
SELECT curdate(), date_add(curdate(), INTERVAL 3 DAY_HOUR); -- 差別是???
SELECT curdate(), date_add(curdate(), INTERVAL 3 HOUR);

SELECT curdate(), date_add(curdate(), INTERVAL 3 DAY);
SELECT curdate(), date_add(curdate(), INTERVAL -3 DAY);     -- 加負值 ＝ 減
SELECT curdate(), date_sub(curdate(), INTERVAL 3 DAY);
SELECT curdate(), date_sub(curdate(), INTERVAL -3 DAY);     -- 減負值 ＝ 加
SELECT curtime(), addtime(curtime(), 3);                -- 以秒為單位

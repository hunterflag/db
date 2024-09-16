
/* 	日期時間

# 資料型態:	https://dev.mysql.com/doc/refman/8.4/en/date-and-time-types.html
+ DATE		'1000-01-01' to '9999-12-31'
+ TIME		'00:00:00' to '23:59:59'
+ DATETIME	'1000-01-01 00:00:00' to '9999-12-31 23:59:59'		是local時間 (沒有時區紀錄, 需手動處理)
+ TIMESTAMP	'1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' 	是UTC全球統一時間 (有時區紀錄, 可在顯示時, 據此自行調整)

# 概念:
## 日期、時間屬不同單位, 但常混用, 需視狀況分辨 (此處若未特別說明, 都是日期、時間)
+ 日期時間  = 日期  +  時間
+ 日期		= 日期 [+ 時間]
+ 時間 		= [日期 +] 時間

## 日期時間只有一種, 但呈現方式有多種
### 日期
+ 日期依曆法分, 且各國有自己的計算方式, 此稱為 local 
+ 電腦內部, 統一以公元來紀錄
### 時間
+ 電腦內部, 統一以 timestamp 來紀錄, 以 timezone 來輔助(轉換為 local)
+ 依時區各自分, 就是 local 
### 時間的種類:
+ UTC
+ GMT
+ local

# 函數	https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html
## 取當下時間
## 輸入時間
## 轉換
## 取時間的局部資訊
## 運算
## 顯示格式

# 常見錯誤:
-- SELECT system_date();

 */
/* 當下日期、時間
	now() 			指令下達的日期時間
    current_date()	指令下達的日期
    current_time()	指令下達的時間
    sysdate()		執行函數的日期時間
 */
 
-- 取當下時間的函數
SELECT now() 				指令執行的local日期時間
    , current_date() 		指令執行的local日期
    , curdate()
    , current_time() 		指令執行的local時間
    , curtime()
    , current_timestamp() 	指令執行的UTC時間戳 -- 顯示時已修正時區、並轉換成 local的日期時間
    , localtime()			指令執行的local時間
    , localtimestamp()		指令執行的local時間
	, sysdate() 			函數執行的日期時間
;

-- 取時間函數的差異比較
SET @delay_seconds=3;
select now()				, sleep(@delay_seconds)	, now();
select current_date()		, sleep(@delay_seconds)	, current_date();
select current_time()		, sleep(@delay_seconds)	, current_time();
select current_timestamp()	, sleep(@delay_seconds)	, current_timestamp();
select localtime()			, sleep(@delay_seconds)	, localtime();
select localtimestamp()		, sleep(@delay_seconds)	, localtimestamp();
select sysdate()			, sleep(@delay_seconds)	, sysdate();


SELECT date("2024-09-16") 	預設日期格式
	, date("2024/09/16")	常用日期格式
;

SELECT date("2024-09-01")						只輸入日期
	, timestamp(date("2024-09-01"))				時間自動補零 
	, timestamp(date("2024-09-01 12:34:56"))	輸入時間也無效 
;

-- SELECT date(2024, 09, 16);
SELECT date("2024/09/16 12:34:56");
SELECT time("12:34:56") 						只輸入時間
	, timestamp(time("12:34:56"))				自動補當天日期
	, timestamp(time("2024/09/18 12:34:56")) 	輸入日期也無效
;

SELECT timestamp(0);
SELECT timestamp(now());

SELECT timestamp(time("2024/09/18 12:34:56"));
SELECT timestamp(now())						預設沒有微秒
	, timestamp(time("12:34:56"))			沒有就不顯示	
	, timestamp(time("12:34:56.123456"))	有就顯示
    , timestamp(time("12:34:56.123456789"))	上限是6位數
    , timestamp(time("12:34:56.123456123"))	第7位四捨五入
;

select timestamp(time("12:34:56.123456"))				有微秒
	, second(timestamp(time("12:34:56.123456")))		取秒
	, microsecond(timestamp(time("12:34:56.123456")))	取微秒
;
SELECT second(time("2024/09/18 12:34:56"));
SELECT second(date("2024/09/16 12:34:56"));		-- 時間部分是 00:00:00
SELECT now()				當下
	, year(now())			年份
	, month(now())			月份
	, day(now())			日期
	, hour(now())			時
	, minute(now())			分
	, second(now())			秒
	, microsecond(now())	微秒
	, timestamp(now())
	, monthname(now())		月份名
	, dayname(now())		星期名
	, week(now())			週數
	, weekday(now())		`週序(日..六)(0-6)`
	, dayofweek(now())		`第?天(週)`	
	, dayofmonth(now())		`第?天(月)`
	, dayofyear(now())		`第?天(年)`
;

SELECT now(), unix_timestamp(now());
SELECT date("1970-07-01"), unix_timestamp(date("1970-07-01"));
SELECT date("1970-06-01"), unix_timestamp(date("1970-06-01"));
SELECT timestamp(date("1970-07-01"));
SELECT sec_to_time(15609600);
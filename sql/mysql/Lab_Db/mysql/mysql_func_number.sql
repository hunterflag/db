-- 數值.群組函數
/*
count()
sum()
avg()
SELECT min();
SELECT max();
*/
SELECT least(1,2,3,4,5);
SELECT greatest(1,2,3,4,5);

SELECT 1, 2, 3;

-- 數值.
SELECT sign(123);
-- 數值.
-- 數值.亂數
SELECT rand();
-- 數值.四捨五入
SELECT round(123456789.123456789,  4);  -- 正數：小數點右邊位數
SELECT round(123456789.123456789,  1);
SELECT round(123456789.123456789,  0);
SELECT round(123456789.56789);          -- 可省略, 就採預設值
SELECT round(123456789.56789,      0);  -- 0, 就是預設值, 整數 
SELECT round(123456789.123456789, -1);  -- 負數：小數點左邊位數; -1 等同於 1位整數, 就是預設值
SELECT round(123456789.123456789, -4);
SELECT truncate(123456789.1234567890, 4);
SELECT truncate(123456789.1234567890, 1);
-- SELECT truncate(123456789.1234567890);   -- 不能省
SELECT truncate(123456789.1234567890, 0);   -- 0, 整數, 
SELECT truncate(123456789.1234567890, -1);  -- -1 是1個零, 十位數
SELECT truncate(123456789.1234567890, -4);

-- 數值.

-- 數學.三角函數
SELECT pi();
SELECT degrees(radians(180));
SELECT radians();   -- 360 = 2 pi
/* 使用弧度 (非角度)
sin()
cos()
tan()
asin()
acos()
atan()
*/
-- 數學.
SELECT 5/2;             -- 商
SELECT 5 div 2;         -- 商
SELECT mod(5, 2);       -- 餘
SELECT pow(2,3);
SELECT power(2,3);
SELECT log(10, 10);
SELECT log(10, 100);
SELECT log(2, 2);
SELECT log10(10);
SELECT log2(10);
SELECT ln(10);
SELECT exp(1);
SELECT ln(exp(3));
/*
abs()
sqrt()
*/
-- 數學.
SELECT abs(-1);
SELECT ceil(3.4);       -- 4
SELECT ceiling(3.4);       -- 4
SELECT floor(3.4);      -- 3
SELECT ceil(-3.4);      -- -3
SELECT ceiling(-3.4);      -- -3
SELECT floor(-3.4);     -- -4

-- 數學.

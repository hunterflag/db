SET @strDigit = "1234567890";
SET @strDigitZh = "一二三四五六七八九十";
SET @strDigitMixed = concat(@strDigit, @strDigitZh) ;
SET @strAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
SET @strHexDigit = "0123456789ABCDEF";

-- 編輯類.插入
-- 編輯類.刪除
-- 編輯類.刪除.外側空白
SELECT concat("左[",                    @strDigitMixed         , "]右") "原始字串"
	, concat("左[",  trim(concat("   ", @strDigitMixed, "   ")), "]右")
	, concat("左[", ltrim(concat("   ", @strDigitMixed, "   ")), "]右")
	, concat("左[", rtrim(concat("   ", @strDigitMixed, "   ")), "]右")
;

-- 編輯類.取代

-- 尋找類.存在
-- 尋找類.位置
SELECT concat(@strDigitMixed, @strDigitMixed) "UTF-8原始字串"
	, instr(@strDigitMixed, "123")	-- "第一個位置"
	, instr(@strDigitMixed, "一二三")	
	, locate("123", @strDigitMixed) -- "主、搜順序相反"
	, locate("一二三", @strDigitMixed) 
	, locate("123", @strDigitMixed, 2) -- "從第?位開始"
	, locate("一二三", @strDigitMixed, 10)
;

-- 尋找類.取出
SELECT @strDigitMixed "原始字串"
	, left(@strDigitMixed, 13)
	, left(@strDigitMixed, 0)
	, left(@strDigitMixed, 1)
	, left(@strDigitMixed, -13)		-- 限正整數
	, right(@strDigitMixed, 13)
	, right(@strDigitMixed, -13)	-- 限正整數
	,    substr(@strDigitMixed, 13, 5)
	, substring(@strDigitMixed, 13, 5)
;
SELECT @strDigitMixed "原始字串"
	, left(@strDigitMixed, 13)
	, right(@strDigitMixed, 13)
	,    substr(@strDigitMixed, 13, 5)
	,    substr(@strDigitMixed, -13, 5)
	,    substr(@strDigitMixed, -13, -5)
	,    substr(@strDigitMixed, 13, -5)
	, substring(@strDigitMixed, 13, 5)
;

-- 編輯類.轉換 (轉換成同類型)
SELECT @strDigit "數字", @strAlpha "原始字串"
	, concat(@strDigit, " 可多個拼接 ", @strAlpha)	"拼接"
    , upper(@strAlpha) "轉大寫"
	, lower(@strAlpha) "轉小寫"
;
-- 轉型類 (轉換成不同類型)
-- 資訊類
SELECT @strHexDigit "原始字串"
	, length(@strHexDigit)	"bytes 大小"
	, char_length(@strHexDigit)	"字串長度"
;

SELECT @strDigitMixed "UTF-8原始字串"
	, length(@strDigitMixed)	"bytes大小"
	, char_length(@strDigitMixed)	"字串長度"
;

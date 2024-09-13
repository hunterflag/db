/* 變數.
-- 變數.等級 x3: local、user、global
-- 變數.等級.local 級
-- 變數.等級.local 級.定義
	在 BEGIN...END 中, 用 DECLARE <變數名> 宣告
-- 變數.等級.local 級.使用
 
-- 變數.等級.user/client/session 級
-- 變數.等級.user/client/session 級.定義
	SET @<變數名> = <值> ;
-- 變數.等級.user/client/session 級.查詢
-- 變數.等級.user/client/session 級.取用
	<SELECT-子句> SELECT @suerVar;

-- 變數.等級.user/client/session 級.刪除
	沒有 UNSET, 不是 DELETE
	SET @testVar = NULL;

-- 變數.等級.global/server/system 級
 */

-- 0.不存在
	SELECT @userVar;
-- 1.變數.等級.user/client/session 級.定義
	SET @useVar = 123;
-- 2.變數.等級.user/client/session 級.取用
	SELECT @userVar;
-- 3.變數.等級.user/client/session 級.刪除
	SET @userVar = NULL;

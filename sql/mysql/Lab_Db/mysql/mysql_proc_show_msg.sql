DROP PROCEDURE IF EXISTS show_msg;
DELIMITER $$
CREATE PROCEDURE show_msg(IN p_msg VARCHAR(4000))
COMMENT "開發顯示資訊用"
BEGIN
  -- 宣告區
  DECLARE l_var VARCHAR(4000) DEFAULT "default";
  -- 執行區
  SET @output_msg = concat(p_msg, "\n");
  SELECT @output_msg, l_var;				
END $$
DELIMITER ;

CALL show_msg("hddddddddello");
COMMIT;
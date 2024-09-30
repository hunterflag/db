DROP function IF EXISTS z_lab_func;

DELIMITER $$
CREATE function z_lab_func(p_i varchar(70)) RETURNS VARChar(300)
DETERMINISTIC
BEGIN
	DECLARE l_var VARCHAR(100) ;
    SET l_var = "asdf";
    -- CALL show_msg("123");
    SELECT "asd" INTO l_var;
    RETURN l_var;
END;
$$
DELIMITER ;

SELECT z_lab_func("dffg");

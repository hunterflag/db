USE LAB_DB;

-- 1. 建立主表.xxx
DROP TABLE IF EXISTS AppProperties;
CREATE TABLE IF NOT EXISTS AppProperties (    

	prefix			VARCHAR(200) 	NOT NULL DEFAULT "",	
	name			VARCHAR(200) 	NOT NULL ,
    suffix			VARCHAR(200) 	NOT NULL DEFAULT "",
    value			VARCHAR(200)	NULL,
    default_value	VARCHAR(200)	NULL, 
    
    no 				INTEGER 		PRIMARY KEY UNIQUE AUTO_INCREMENT,		
    created_time	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_time	TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
    CONSTRAINT unique_key UNIQUE KEY (prefix, name, suffix)
);

INSERT INTO AppProperties (name, value)
	VALUES ("title", "demo title")
		 , ("author", "Hunter Chen")
         , ("company", "Subway Studio")
         , ("support", "地鐵工坊")
;

INSERT INTO AppProperties (name, value)	VALUES ("title", "demo title") ;


SELECT * FROM AppProperties;

TRUNCATE AppProperties;

DROP TABLE IF EXISTS AppProperties;

INSERT INTO AppProperties (name, value)		 VALUES("app.db.user", "developer");
INSERT INTO AppProperties (name, value)		 VALUES("app.db.password", "developer");
INSERT INTO AppProperties (name, value)		 VALUES("app.user", "123");
INSERT INTO AppProperties (name, value)		 VALUES("app.password", "123");
INSERT INTO AppProperties (prefix, name, value) VALUES("developer.hunter", "app.db.user", "developer");
INSERT INTO AppProperties (prefix, name, value) VALUES("developer.hunter", "app.db.password", "developer");
INSERT INTO AppProperties (prefix, name, value) VALUES("developer.hunter", "app.user", "123");
INSERT INTO AppProperties (prefix, name, value) VALUES("developer.hunter", "app.password", "123");


select * 
from app_config
-- order by serial_no
;


update app_config 
set value = "1234567", scope="email"
where 1=1
	and scope = "email"
    and name = "key"
;

select * from app_config;
select * from app_config_history;

/* 
-- 2. 建立歷史表.xxx_history
-- 2.1. 同時複製 主表 的 結構、紀錄
-- 2.2. 修改 歷史表 的 結構: 
-- 2.2.1. 移除原主表欄位中的 PK、unique 限制 (其實不需要, 因為複製時, auto_increment、primary、unique 都不會複製)
-- 2.2.2. 在 歷史表中加入所需欄位、並加入 PK 限制
*/

-- 2.1. 同時複製 主表 的 結構、紀錄
drop table if exists app_config_history;
create table if not exists app_config_history 
select * from app_config
;


select * 
from app_config_history
where 1=1
-- 	and scope="email"
--     and name="key"
;	
select * from app_config_history;	

-- 2.2. 修改 歷史表 的 結構: 
-- 2.2.1. 移除原主表欄位中的 PK、unique 限制
/*
alter table app_config_history 
drop primary key, 
drop constraint name 
;
*/
-- 2.2.2. 在 歷史表中加入序號欄位、並加上 PK 限制
alter table app_config_history
add `serial_no` integer primary key  auto_increment first
;

-- 3. 主表異動時, 同時將新紀錄, 從主表複製到歷史表內

delimiter ||
drop trigger if exists app_config_after_insert ||
create trigger app_config_after_insert
after insert
on app_config for each row
begin
	insert into app_config_history (scope, name, value, serial_no, created_time, modified_time)
		values (NEW.scope, NEW.name, NEW.value, NEW.serial_no, NEW.created_time, NEW.modified_time);
end 
||
-- delimiter ;

-- delimiter ||
drop trigger if exists app_config_after_update ||
create trigger app_config_after_update
after update
on app_config for each row
begin
	insert into app_config_history (scope, name, value, serial_no, created_time, modified_time)
		values (NEW.scope, NEW.name, NEW.value, NEW.serial_no, NEW.created_time, NEW.modified_time);
end
||
delimiter ;

select now() ;

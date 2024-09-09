USE labDB;

-- 1. 建立主表.xxx
DROP TABLE IF EXISTS AppConfig;
CREATE TABLE IF NOT EXISTS AppConfig (    
    tag				VARCHAR(100)	NULL,
	key_name		VARCHAR(100) 	NOT NULL,
    key_value		VARCHAR(100)	NULL,
    default_value	VARCHAR(100)	NULL, 
    
    no 				INTEGER 		PRIMARY KEY UNIQUE AUTO_INCREMENT,		
    created_time	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_time	TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
    CONSTRAINT unique_key UNIQUE KEY (tag, key_name)
);





alter table app_config
	  drop primary key
	, add constraint primary key (id)
	, add constraint unique (key_name)
    , change column id id integer not null comment '識別碼'
	, comment 'appＡ設定參數表'
;




INSERT INTO AppConfig (key_name, key_value)		 VALUES("app.db.user", "developer");
INSERT INTO AppConfig (key_name, key_value)		 VALUES("app.db.password", "developer");
INSERT INTO AppConfig (key_name, key_value)		 VALUES("app.user", "123");
INSERT INTO AppConfig (key_name, key_value)		 VALUES("app.password", "123");
INSERT INTO AppConfig (tag, key_name, key_value) VALUES("developer.hunter", "app.db.user", "developer");
INSERT INTO AppConfig (tag, key_name, key_value) VALUES("developer.hunter", "app.db.password", "developer");
INSERT INTO AppConfig (tag, key_name, key_value) VALUES("developer.hunter", "app.user", "123");
INSERT INTO AppConfig (tag, key_name, key_value) VALUES("developer.hunter", "app.password", "123");


select * 
from app_config
-- order by serial_no
;


update app_config 
set key_value = "1234567", scope="email"
where 1=1
	and scope = "email"
    and key_name = "key"
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
--     and key_name="key"
;	
select * from app_config_history;	

-- 2.2. 修改 歷史表 的 結構: 
-- 2.2.1. 移除原主表欄位中的 PK、unique 限制
/*
alter table app_config_history 
drop primary key, 
drop constraint key_name 
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
	insert into app_config_history (scope, key_name, key_value, serial_no, created_time, modified_time)
		values (NEW.scope, NEW.key_name, NEW.key_value, NEW.serial_no, NEW.created_time, NEW.modified_time);
end 
||
-- delimiter ;

-- delimiter ||
drop trigger if exists app_config_after_update ||
create trigger app_config_after_update
after update
on app_config for each row
begin
	insert into app_config_history (scope, key_name, key_value, serial_no, created_time, modified_time)
		values (NEW.scope, NEW.key_name, NEW.key_value, NEW.serial_no, NEW.created_time, NEW.modified_time);
end
||
delimiter ;

select now() ;

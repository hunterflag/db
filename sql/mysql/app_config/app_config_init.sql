use labDB;



-- 1. 建立主表.xxx
drop table if exists app_config;
create table if not exists app_config (
    
    scope			varchar(100)	default "",
	key_name		varchar(100) 	not null,
    key_value		varchar(100)	not null default "",
    
    serial_no 		integer 		not null UNIQUE auto_increment,		
    created_time	datetime 		not null DEFAULT CURRENT_TIMESTAMP,
    modified_time	timestamp		not null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
    constraint primary_key primary key (scope, key_name)
);

alter table app_config
	  drop primary key
	, add constraint primary key (id)
	, add constraint unique (key_name)
    , change column id id integer not null comment '識別碼'
	, comment 'appＡ設定參數表'
;




insert into app_config (key_name, key_value) values("app.db.user", "developer");
insert into app_config (key_name, key_value) values("app.db.password", "developer");
insert into app_config (key_name, key_value) values("app.user", "123");
insert into app_config (key_name, key_value) values("app.password", "123");
insert into app_config (scope, key_name, key_value) values("developer.hunter", "app.db.user", "developer");
insert into app_config (scope, key_name, key_value) values("developer.hunter", "app.db.password", "developer");
insert into app_config (scope, key_name, key_value) values("developer.hunter", "app.user", "123");
insert into app_config (scope, key_name, key_value) values("developer.hunter", "app.password", "123");


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

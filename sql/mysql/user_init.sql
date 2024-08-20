/*
	1. 關鍵字不區分大小寫, 慣用小寫
    2. 自訂欄位名稱: 全小寫, 以 _ 分隔 (搭配 myBatis)
*/
use labDB;
drop table if exists user;
create table user (
    id 				integer 		primary key 		auto_increment,	
    name			varchar(100) 	not null unique,
    password		varchar(100)	not null			default "0000",
	created_time	datetime 		not null 			default now(),
    modified_time 	timestamp		not null 			default now()
);

truncate table user;
insert into user (name) 
values ('John')
	, ('Ford')
    , ('Ken')
;

select id, name, password, created_time, modified_time from user;
select * from user;
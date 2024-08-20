use labDB;
drop table if exists country;
create table if not exists country (
    id 			integer 		primary key auto_increment,	
    country_name	varchar(100) 	null,
    country_code	varchar(100)	null
);

insert into country (country_name, country_code)
values 	('China', 'CN'),
		('America', 'US')
;

select * from country;
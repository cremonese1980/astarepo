-- ==================================================================
-- Initialize objetcs for database 'gpdDB'
-- Execute by using 'gpd_own' user
-- ==================================================================
-- mysql --host=mysql1001.mochahost.com --user=cremo80_asta_own --password=asta_123 cremo80_astadb
-- mysql --host=198.38.90.184 --user=cremo80_asta_own --password=asta_123 cremo80_astadb

-- mysqldump --host=mysql1001.mochahost.com --user=cremo80_asta_own --password=asta_123 cremo80_astadb > /home/cremo80/*******.sql

-- TO IMPORT
-- mysql -u username -p -h localhost DATA-BASE-NAME < data.sql

-- update configuration set value = 'birra,fiorentina,g4br13l3,cazzola' where name = 'secret.words';
-- commit;

-- IP nuovo db 198.38.90.184

use cremo80_astadb;

--
-- sets
--

set storage_engine = InnoDB;

--
-- create tables
--

create table users (
	username varchar(50) not null,
	password varchar(50) not null,
	id_type varchar(20) not null,
	enabled bit(1) not null,	
	name varchar (50),
	last_name varchar (50),
	last_login datetime ,
	email varchar(100) not null,
	primary key (username)
);

create table authorities (
	username varchar(50) not null,
	authority varchar(50) not null,
	primary key (username)
);


create table item (
	id int unsigned not null auto_increment,
	id_status varchar(20) not null,
	name varchar(100) not null,
	description varchar(250) not null,
	base_auction_price DECIMAL(10,2) not null,
	expiring_date datetime not null,
	from_date datetime not null,
	id_best_relaunch int unsigned,
	primary key (id)
);

create table relaunch (
	id int unsigned not null auto_increment,
	amount DECIMAL(10,2),
	id_item int unsigned not null,
	username varchar(100) not null,
	date datetime not null,
	primary key (id)
);


create table item_image (
	id int unsigned not null auto_increment,
	id_item int unsigned not null,
	name varchar(100) not null,
	thumb_name varchar(100),
	path varchar(200),
	description varchar(250),
	image LONGBLOB,
	primary key (id)
);

create table configuration (
	name varchar(100) not null,
	value varchar(100) not null,
	type varchar(50) ,	
	primary key (name)
);
/*
 * Dopo asta test
 */
create table item_news (
	id int unsigned not null auto_increment,
	id_item int unsigned not null,
	id_status int not null default 0,
	sent_date datetime,	
	cc_list varchar(2000),
	primary key (id)
);

/*
 * FOREIGN KEYS
 */
alter table item_image
	add constraint image_fk_item
	foreign key(id_item)
	references item(id);
	
alter table relaunch
	add constraint relaunch_fk_item
	foreign key(id_item)
	references item(id);
	
/*
 * Dopo asta test
 */
	alter table item_news
	add constraint news_fk_item
	foreign key(id_item)
	references item(id);
	
	alter table item
	add constraint item_fk_bestrelaunch
	foreign key(id_best_relaunch)
	references relaunch(id);
	

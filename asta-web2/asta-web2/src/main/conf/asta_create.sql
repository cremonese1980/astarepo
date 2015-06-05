-- ==================================================================
-- Initialize objetcs for database 'gpdDB'
-- Execute by using 'gpd_own' user
-- ==================================================================


use cremo80_astadb;

--
-- sets
--

set storage_engine = InnoDB;

--
-- create tables

CREATE TABLE `student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dateOfBirth` datetime NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `password` varchar(8) NOT NULL,
  `userName` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
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
	best_relaunch DECIMAL(10,2),
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
	

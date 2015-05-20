-- ==================================================================
-- Initialize objetcs for database 'gpdDB'
-- Execute by using 'gpd_own' user
-- ==================================================================


use astadb;

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
	enabled bit(1) not null,	
	name varchar (50),
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
	name varchar(100) not null,
	description varchar(250) not null,
	base_auction_price DECIMAL(10,2) not null,
	expiring_date datetime not null,
	primary key (id)
);
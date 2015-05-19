-- ==================================================================
-- Create schema and users
-- Require the connection as root:
-- $ mysql --user=root --password mysql
-- ==================================================================


--
-- create database
--

drop database if exists astadb;

create database astadb default character set utf8;



--
-- create user
--

drop user 'astadb_own'@'%';
drop user 'astadb_usr'@'%';

create user 'astadb_own'@'%' identified by 'astadb_123';
create user 'astadb_usr'@'%' identified by 'astadb_123';

grant all privileges
	on astadb.*
	to 'astadb_own'@'%'
	with grant option;
grant select,insert,update,delete
	on astadb.*
	to 'astadb_usr'@'%';

flush privileges;

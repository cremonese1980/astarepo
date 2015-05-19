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

drop user 'asta_own'@'%';
drop user 'asta_usr'@'%';

create user 'asta_own'@'%' identified by 'asta_123';
create user 'asta_usr'@'%' identified by 'asta_123';

grant all privileges
	on astadb.*
	to 'asta_own'@'%'
	with grant option;
grant select,insert,update,delete
	on astadb.*
	to 'asta_usr'@'%';

flush privileges;

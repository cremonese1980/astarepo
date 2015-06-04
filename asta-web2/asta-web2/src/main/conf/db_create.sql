-- ==================================================================
-- Create schema and users
-- Require the connection as root:
-- $ mysql --user=root --password mysql
-- ==================================================================


--
-- create database
--

drop database if exists cremo80_astadb;

create database cremo80_astadb default character set utf8;



--
-- create user
--

drop user 'cremo80_asta_own'@'%';
drop user 'cremo80_asta_usr'@'%';

create user 'cremo80_asta_own'@'%' identified by 'asta_123';
create user 'cremo80_asta_usr'@'%' identified by 'asta_123';

grant all privileges
	on cremo80_astadb.*
	to 'cremo80_asta_own'@'%'
	with grant option;
grant select,insert,update,delete
	on cremo80_astadb.*
	to 'cremo80_asta_usr'@'%';

flush privileges;

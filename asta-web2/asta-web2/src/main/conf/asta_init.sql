use astadb;

insert into users(username, password, enabled, name,email, id_type) values ('cremo','cremo',true,'gabri','cremonese1980@gmail.com', '0');
insert into users(username, password, enabled, name,email, id_type) values ('super','cazzola',true,'sarah','chevuoi@hotmail.com', '1');

insert into configuration(name, value) values ('max.upload.size', '1999999');
insert into configuration(name, value) values('base.directory', '/home/asta/store/img');
insert into configuration(name, value) values('min.sell.time.hour', '168');


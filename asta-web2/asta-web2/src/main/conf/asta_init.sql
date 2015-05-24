use astadb;

insert into users(username, password, enabled, name,email) values ('cremo','cremo',true,'gabri','cremonese1980@gmail.com');
insert into users(username, password, enabled, name,email) values ('super','cazzola',true,'sarah','chevuoi@hotmail.com');

insert into configuration(name, value) values ('max.upload.size', '1999999');
insert into configuration(name, value) values('base.directory', '/home/asta/store/img');


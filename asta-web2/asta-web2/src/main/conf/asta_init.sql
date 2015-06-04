use cremo80_astadb;

insert into users(username, password, enabled, name,email, id_type) values ('cremo','cremo',true,'gabri','cremonese1980@gmail.com', '0');
insert into users(username, password, enabled, name,email, id_type) values ('super','cazzola',true,'sarah','chevuoi@hotmail.com', '1');

insert into configuration(name, value) values ('max.upload.size', '2999999');
insert into configuration(name, value) values('base.directory', '/home/asta/store/img');
insert into configuration(name, value) values('min.sell.time.hour', '168');
insert into configuration(name, value) values('relaunch.postpone.seconds', '180');

insert into configuration(name, value) values('mail.sender.host', 'smtp.gmail.com');
insert into configuration(name, value) values('mail.sender.port', '465');
insert into configuration(name, value) values('mail.sender.protocol', 'smtp');
insert into configuration(name, value) values('mail.sender.username', 'astaweb.server@gmail.com');
insert into configuration(name, value) values('mail.sender.password', 'r1l4nc10');
insert into configuration(name, value) values('mail.smtp.auth', 'true');
insert into configuration(name, value) values('mail.smtp.starttls.enable', 'true');
insert into configuration(name, value) values('mail.sender.from', 'astaweb.server@gmail.com');
insert into configuration(name, value) values('mail.sender.cc', '');
insert into configuration(name, value) values('mail.sender.to', 'cremonese1980@gmail.com,chevuoi@hotmail.com');
insert into configuration(name, value) values('mail.sender.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
insert into configuration(name, value) values('secret.words', 'birra,fiorentina');





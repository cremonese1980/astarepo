use cremo80_astadb;

create table item_news (
	id int unsigned not null auto_increment,
	id_item int unsigned not null,
	id_status int not null default 0,
	sent_date datetime,	
	cc_list varchar(2000),
	primary key (id)
);
alter table item_news
	add constraint news_fk_item
	foreign key(id_item)
	references item(id);
	
alter table item drop column best_relaunch;
alter table item add column id_best_relaunch int unsigned;
alter table item
	add constraint item_fk_bestrelaunch
	foreign key(id_best_relaunch)
	references relaunch(id);

insert into configuration (name,value) value ('bc.list.base', 'cremonese1980@gmail.com,chevuoi@hotmail.com');

Update
  item as i
  inner join (
    select id, id_item from relaunch where (id_item, amount) in(
select id_item, max(amount)
from relaunch
group by id_item)
  ) as Arturo on i.id = Arturo.id_item
set i.id_best_relaunch = Arturo.id;

INSERT INTO item_news (id_item, cc_list)
  SELECT
    /* Literal number values with column aliases */
    id AS id_item,
    'cremonese1980@gmail.com,chevuoi@hotmail.com' AS cc_list
  FROM item;


commit;
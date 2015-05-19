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
--

create table users (
	IdOperatore int unsigned not null,
	username varchar(90) not null,
	password varchar(90) not null,
	enabled bit(1) not null,	
	IdSedeDownload int (11),
	IdStato int (11),
	IdSede int (11),
	Sito varchar (90),
	Nome varchar (150),
	Cessato int (11),
	MatricolaArca varchar (21),
	NomeApollo varchar (150),
	IdOpOmis int (11),
	Visibile int (11),
	IdQualifica int (11),
	LastLogin datetime ,
	LastChange datetime ,
	LimApp int (11),
	Debug bit (1),
	IdDealerIns int (11),
	DataCessazione datetime,
	primary key (username)
);


create table authorities (
	username varchar(50) not null,
	authority varchar(50) not null,
	primary key (username)
);




create table stored_email (
  id int unsigned not null auto_increment,
  cod_conformita varchar(4) not null,
  mittente varchar(45) NULL,
  destinatario varchar(45) NULL,
  oggetto varchar(45) not NULL,
  corpo varchar(255) NULL,
  cod_ol varchar(6),
  cod_tipo_email varchar(1),
  dt_ricezione datetime,
  primary key(id)
);


create table attivita (
  id int unsigned not null auto_increment,	
  id_stored_email int unsigned not null,
  id_pratica int unsigned not null,
  cod_tipo_attivita varchar(6) not null,
  cod_stato_attivita varchar(4) not null,
  des varchar(255),
  oggetto varchar(255),
  acquirente varchar(15), -- TODO:  Delete this column
  dt_inizio_prevista datetime,
  dt_inizio_effettiva datetime,
  dt_fine_effettiva datetime,
  dt_inserimento datetime not null,
  usr_inserimento varchar(15) not null,
  dt_aggiornamento datetime,
  usr_aggiornamento varchar(15),
  primary key(id)
);

-- 
-- Allegato attivita
--
create table allegato_attivita(
	id int unsigned not null auto_increment,
	id_documento int unsigned,
	id_attivita int unsigned not null,
	mime_type varchar(255) not null,
	des varchar(255) default '',
	nome_file varchar(128) not null,
	dt_inserimento datetime not null,
	usr_inserimento varchar(15) not null,
	primary key(id)
);



create table tipo_attivita (
  cod_tipo varchar(6) not null,
  des_tipo varchar(128) not null,
  des_breve_tipo varchar(32),
  durata_standard int unsigned,
  primary key (cod_tipo)
);

create table stato_attivita (
  cod_stato varchar(4) not null,
  des_stato varchar(255) not null,
  primary key (cod_stato)
);


create table conformita_email(
	cod varchar(4) not null,
	des varchar(255) not null,
	primary key(cod)
);


create table tipo_ol(
	cod varchar(6) not null,
	des varchar(255) not null,
	primary key(cod)
);

create table tipo_vettore(
	cod varchar(4) not null,
	des varchar(255) not null,
	primary key(cod)
);

create table tipo_nmu_prodotto(
	cod varchar(4) not null,
	des varchar(255) not null,
	primary key(cod)
);

create table provincia (
  cod varchar(2) not null,
  nome varchar(50) not null,
  primary key  (cod)
) ;



create table stato_imei (
	id int unsigned NOT NULL ,
	stato varchar (50)  NULL ,
	icon_name varchar (50)  NULL ,
	primary key (id)
);

-- VECCHIO DB, PARO PARO COM'ERA

CREATE TABLE Lav_PratSin (
	IdLavPratSin int unsigned not null auto_increment ,
	IdPartner int unsigned NULL ,
	Protocollo varchar (50)  NULL ,
	DataProtocollo varchar (50)  NULL ,
	IdEsitoTot int unsigned NULL ,
	DataIns datetime NULL ,
	NumAll_A int unsigned NULL ,
	NumAll_B int unsigned NULL ,
	NomeFileWord varchar (50)  NULL ,
	NomeFileExcel varchar (50)  NULL ,
	NomeFilePDF1 varchar (50)  NULL ,
	NomeFilePDF2 varchar (50)  NULL ,
	NomeFilePDF3 varchar (50)  NULL ,
	NomeFilePDF4 varchar (50)  NULL ,
	IdEsitoMail_A int unsigned NULL ,
	IdEsitoMail_B int unsigned NULL ,
	IdOkTempoRic_A int unsigned NULL ,
	IdOkTempoRic_B int unsigned NULL ,
	DataAssegnazione datetime NULL ,
	DataChiusuraA datetime NULL ,
	IdOperatore int unsigned NULL ,
	DataRicMailA datetime NULL ,
	DataRicMailB datetime NULL ,
	Note varchar (300)  NULL ,
	DataChiusuraB datetime NULL ,
	DataRichSblocco datetime NULL ,
	DataChSblocco datetime NULL ,
	IdControllato int unsigned NULL ,
	IdIntegraz int unsigned NULL ,
	nSlaMailA int unsigned NULL ,
	nSlaMailB int unsigned NULL ,
	nSlaLavA int unsigned NULL ,
	nSlaLavB int unsigned NULL,
	idAfro int unsigned NULL,
	idCcdt int unsigned NULL,
	idBcod int unsigned NULL,
	idDpli int unsigned NULL,
	idEden int unsigned NULL,
	idFldr int unsigned NULL,
	primary key (IdLavPratSin)
) ;

create table Lst_IMEI (
	IdIMEI int unsigned not null auto_increment ,
	IdLavPratSin int unsigned NULL ,
	TipoIMEI varchar (50)  NULL ,
	FurtSmarr varchar (50)  NULL ,
	IdPMM int unsigned NULL ,
	DataIns datetime NULL ,
	OkLuhn int unsigned NULL ,
	OkPacking int unsigned NULL ,
	OkTAC int unsigned NULL ,
	idStato int unsigned NULL ,
	IdStatoBloccoEIR int unsigned NULL ,
	Codice varchar (50)  NULL ,
	MNUProdotto varchar (50)  NULL ,
	DescProdotto varchar (50)  NULL ,
	DataUscitaMag varchar (50)  NULL ,
	NumDDT varchar (50)  NULL ,
	NumConsSAP varchar (50)  NULL ,
	IdXML varchar (50)  NULL,
	primary key (IdIMEI)
) ;

create table Lav_Anagrafiche (
	IdLavAnagrafica int unsigned not null auto_increment,
	DataIns datetime NULL ,
	IdLavPratSin int unsigned NULL ,
	PD varchar (50)  NULL ,
	IMEIPres varchar (50)  NULL ,
	LuogoEv varchar (50)  NULL ,
	DataEv varchar (50)  NULL ,
	OraEv varchar (50)  NULL ,
	RifSped varchar (50)  NULL ,
	DDT varchar (50)  NULL ,
	DDTDay varchar (50)  NULL ,
	Colli varchar (50)  NULL ,
	Peso varchar (50)  NULL ,
	OrdineTI varchar (50)  NULL ,
	DataSped varchar (50)  NULL ,
	Vettore varchar (50)  NULL ,
	Destinatario varchar (50)  NULL ,
	RagSoc varchar (50)  NULL ,
	IndCons varchar (50)  NULL ,
	CittaCons varchar (50)  NULL ,
	ProvCons varchar (50)  NULL ,
	Responsabile varchar (150)  NULL ,
	Referente varchar (50)  NULL ,
	CelRef varchar (50)  NULL ,
	MailRef varchar (50)  NULL ,
	FaxRef varchar (50)  NULL ,
	IdPacchetto varchar (50)  NULL,
	primary key (IdLavAnagrafica)
);

CREATE TABLE Lst_MnuProd (
	IdMNUProd int unsigned not null auto_increment ,
	IdLavPratSin int unsigned NULL ,
	IdPMM int unsigned NULL ,
	CodMNU varchar (50)  NULL ,
	DescProd varchar (50)  NULL ,
	PesoUni varchar (50)  NULL ,
	PMM varchar (50)  NULL ,
	Qta varchar (50)  NULL ,
	ValSin varchar (50)  NULL ,
	PesoSin varchar (50)  NULL ,
	DataIns datetime NULL,
	primary key (IdMNUProd)
) ;

CREATE TABLE Lav_Anomalie (
	IdAnomalia INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	Oggetto VARCHAR (150)  NULL ,
	DataRicezione DATETIME NULL ,
	IdEsito INT NULL ,
	DataInserimento DATETIME NULL ,
	IdPartner INT NULL ,
	IdVisibile INT NULL,
	PRIMARY KEY (IdAnomalia)
) ;

-- Nell'import ci sono dei campi vuoti per IdEsito che sono messi a Zero (da lavorare) e non v� bene
-- Prevedere un vlore dui default diverso da 0
CREATE TABLE Lav_Tracker (
	IdTracker INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	TipoTracker VARCHAR (15)  NULL ,
	IdEsito INT NULL ,
	DataChiusura DATETIME NULL ,
	IdOperatore INT NULL ,
	IdPratica INT NULL ,
	DataIns DATETIME NULL,
	PRIMARY KEY (IdTracker) 
) ;

CREATE TABLE Lst_EsitiGDO (
	IdEsito int unsigned not null auto_increment ,
	Esito varchar (50)  NULL,
	primary key (IdEsito)
) ;

CREATE TABLE Lst_EsitiMail (
	IdEsitoMail int NOT NULL ,
	Esito varchar (50)  NULL ,
	IdMarcoEsito int NULL,
	primary key (IdEsitoMail)
) ;


CREATE TABLE Lst_EsitiMain (
	IdEsitoMain int NOT NULL ,
	Esito varchar (150)  NULL,
	primary key (IdEsitoMain) 
) ;

CREATE TABLE Lst_MailAbilitate (
	IdMailAbilitata int unsigned not null auto_increment ,
	Mail varchar (150)  NULL ,
	Attivo int NULL ,
	IdPartner int NULL ,
	DataIns datetime NULL,
	primary key (IdMailAbilitata) 
) ;

CREATE TABLE Lst_MailRic (
	IdMailRic int unsigned not null auto_increment ,
	IdLavPratSin int unsigned NULL ,
	Oggetto varchar (50)  NULL ,
	DataRic varchar (50)  NULL ,
	DataInvio varchar (50)  NULL ,
	TipoMailRic int NULL ,
	DataIns datetime NULL,
	primary key (IdMailRic)
) ;

CREATE TABLE Lst_PMMFisso (
	IdPMM INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	MA VARCHAR (25)  NULL ,
	DE NVARCHAR (255)  NULL ,
	PMM_PERIODO DECIMAL(10,4) NULL ,
	PESO DECIMAL(10,3) NULL ,
	TipoCanale VARCHAR (15)  NULL ,
	DallaDATA DATE NULL ,
	AllaDATA DATE NULL,
	PRIMARY KEY (IdPMM) 
) ;

CREATE TABLE Lst_Partner (
	IdPartner int NOT NULL ,
	Partner varchar (50)  NULL 
) ;

CREATE TABLE Lst_Report (
	IdReport int NOT NULL ,
	Report varchar (25)  NULL 
) ;

CREATE TABLE Lst_TipologiaTerminali (
	TAC int NULL ,
	DESCRMARCA varchar (255)  NULL ,
	DESCRMODELLO varchar (255)  NULL 
) ;

CREATE TABLE BCKOLD_PratSin (
	IdLavPratSin INT NOT NULL ,
	IdPartner INT NULL ,
	Protocollo VARCHAR (50)  NULL ,
	DataProtocollo VARCHAR (50)  NULL ,
	IdEsitoTot INT NULL ,
	DataIns DATETIME NULL ,
	NumAll_A INT NULL ,
	NumAll_B INT NULL ,
	NomeFileWord VARCHAR (50)  NULL ,
	NomeFileExcel VARCHAR (50)  NULL ,
	NomeFilePDF1 VARCHAR (50)  NULL ,
	NomeFilePDF2 VARCHAR (50)  NULL ,
	NomeFilePDF3 VARCHAR (50)  NULL ,
	NomeFilePDF4 VARCHAR (50)  NULL ,
	IdEsitoMail_A INT NULL ,
	IdEsitoMail_B INT NULL ,
	IdOkTempoRic_A INT NULL ,
	IdOkTempoRic_B INT NULL ,
	DataAssegnazione DATETIME NULL ,
	DataChiusuraA DATETIME NULL ,
	IdOperatore INT NULL ,
	DataRicMailA DATETIME NULL ,
	DataRicMailB DATETIME NULL ,
	Note VARCHAR (300)  NULL ,
	DataChiusuraB DATETIME NULL ,
	DataRichSblocco DATETIME NULL ,
	DataChSblocco DATETIME NULL ,
	IdControllato INT NULL ,
	IdIntegraz INT NULL ,
	nSlaMailA INT NULL ,
	nSlaMailB INT NULL ,
	nSlaLavA INT NULL ,
	nSlaLavB INT NULL 
) ;


CREATE TABLE Bck_IMEI (
	IdBckIMEI INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	IdInsBck DATETIME NULL ,
	IdIMEI INT NOT NULL ,
	IdLavPratSin INT NULL ,
	OkLuhn INT NULL ,
	OkPacking INT NULL ,
	OkTAC INT NULL ,
	DataIns DATETIME NULL ,
	IdOperatore CHAR (10)  NULL ,
	IdStatoBloccoEIR INT NULL ,
	Codice VARCHAR (50)  NULL ,
	MNUProdotto VARCHAR (50)  NULL ,
	DescProdotto VARCHAR (50)  NULL ,
	DataUscitaMag VARCHAR (50)  NULL ,
	NumConsSAP VARCHAR (50)  NULL ,
	IdXML VARCHAR (50)  NULL ,
	FurtSmarr VARCHAR (50)  NULL,
	PRIMARY KEY (IdBckIMEI) 
) ;

--
-- Creazione FK
--
alter table stored_email
	add constraint stored_email_fk_conformita_email
	foreign key(cod_conformita)
	references conformita_email(cod);

alter table stored_email
	add constraint stored_email_fk_tipo_ol
	foreign key(cod_ol)
	references tipo_ol(cod);

alter table attivita
	add constraint allegato_attivita_fk_store_email
	foreign key(id_stored_email)
	references stored_email(id);

alter table attivita
	add constraint attivita_fk_tipo_attivita
	foreign key(cod_tipo_attivita)
	references tipo_attivita(cod_tipo);

alter table attivita
	add constraint attivita_fk_stato_attivita
	foreign key(cod_stato_attivita)
	references stato_attivita(cod_stato);
	
alter table attivita
	add constraint attivita_fk_id_pratica
	foreign key(id_pratica)
	references Lav_PratSin(IdLavPratSin);

alter table allegato_attivita
	add constraint allegato_attivita_fk_attivita
	foreign key(id_attivita)
	references attivita(id);	
	
alter table authorities
	add constraint authorities_fk00
	foreign key (username)
	references users (username);
	
--
--	LavPratSin
--
alter table Lav_PratSin
	add constraint pratica_fk_afro
	foreign key(idAfro)
	references allegato_attivita(id);
	
alter table Lav_PratSin
	add constraint pratica_fk_bcod
	foreign key(idBcod)
	references allegato_attivita(id);
alter table Lav_PratSin
	add constraint pratica_fk_dpli
	foreign key(idDpli)
	references allegato_attivita(id);
alter table Lav_PratSin
	add constraint pratica_fk_ccdt
	foreign key(idCcdt)
	references allegato_attivita(id);
alter table Lav_PratSin
	add constraint pratica_fk_eden
	foreign key(idEden)
	references allegato_attivita(id);
alter table Lav_PratSin
	add constraint pratica_fk_fldr
	foreign key(idFldr)
	references allegato_attivita(id);
--
-- create indexes
--



--
-- grant
--


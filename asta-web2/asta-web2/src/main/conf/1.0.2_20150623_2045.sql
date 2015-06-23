-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (i686)
--
-- Host: 198.38.90.184    Database: cremo80_astadb
-- ------------------------------------------------------
-- Server version	5.5.40-cll

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration` (
  `name` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES ('base.directory','/home/cremo80/asta/store/img',NULL),('bc.list.base','cremonese1980@gmail.com,chevuoi@hotmail.com',NULL),('live.env','false',NULL),('mail.sender.cc','',NULL),('mail.sender.from','astaweb.server@gmail.com',NULL),('mail.sender.host','smtp.gmail.com',NULL),('mail.sender.password','r1l4nc10',NULL),('mail.sender.port','465',NULL),('mail.sender.protocol','smtp',NULL),('mail.sender.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory',NULL),('mail.sender.to','cremonese1980@gmail.com,chevuoi@hotmail.com',NULL),('mail.sender.username','astaweb.server@gmail.com',NULL),('mail.smtp.auth','true',NULL),('mail.smtp.starttls.enable','true',NULL),('max.upload.size','2999999',NULL),('min.sell.time.hour','24',NULL),('relaunch.max.abs','100',NULL),('relaunch.max.rel','10',NULL),('relaunch.min','5',NULL),('relaunch.postpone.seconds','180',NULL),('secret.words','g4br13l3,cazzola,frittella,rigger',NULL);
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_status` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(250) NOT NULL,
  `base_auction_price` decimal(10,2) NOT NULL,
  `expiring_date` datetime NOT NULL,
  `from_date` datetime NOT NULL,
  `id_best_relaunch` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_fk_bestrelaunch` (`id_best_relaunch`),
  CONSTRAINT `item_fk_bestrelaunch` FOREIGN KEY (`id_best_relaunch`) REFERENCES `relaunch` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (13,'1','Moschettone acciaio','Vintage',10.00,'2015-07-09 21:00:00','2015-06-23 18:21:00',NULL),(14,'1','Gancio alluminio','Salewa',30.00,'2015-07-10 21:10:00','2015-06-23 18:21:00',NULL),(15,'1','Fettuccia Petzl Anneau','C40 120cm. Scadenza aprile 2018',10.00,'2015-07-09 21:10:00','2015-06-23 18:21:00',NULL),(16,'1','Protraxion petzl','',60.00,'2015-07-11 20:40:00','2015-06-23 18:21:00',262),(17,'1','Fettuccia Mammut','40-80cm vintage',5.00,'2015-07-09 20:00:00','2015-06-23 18:21:00',NULL),(18,'1','Kleintool','',100.00,'2015-07-11 21:10:00','2015-06-23 18:21:00',263),(19,'1','i D petzl','',100.00,'2015-07-11 21:20:00','2015-06-23 18:21:00',264),(20,'1','Ancoretta','',15.00,'2015-07-10 20:20:00','2015-06-23 18:21:00',265),(21,'1','Imbrago Petzl','navaho bod fast. Scadenza marzo 2019',80.00,'2015-07-11 20:50:00','2015-06-23 18:21:00',NULL),(22,'1','Stopfor k Tractel','',40.00,'2015-07-11 20:10:00','2015-06-23 18:21:00',NULL),(23,'1','Fettuccia Kong','80cm vintage',5.00,'2015-07-09 20:10:00','2015-06-23 18:21:00',NULL),(24,'1','Fettuccia Mammut','40-80 cm vintage',5.00,'2015-07-09 20:20:00','2015-06-23 18:21:00',267),(25,'1','Fettuccia rainbow','',5.00,'2015-07-09 20:30:00','2015-06-23 18:21:00',270),(26,'1','Fettuccia Tiger','vintage 50cm',5.00,'2015-07-09 20:40:00','2015-06-23 18:21:00',271),(27,'1','Cador Petzl acciaio','',20.00,'2015-07-10 20:40:00','2015-06-23 18:21:00',272),(28,'1','Fettuccia Petzl Anneau','C40 60cm. Scadenza agosto 2015',10.00,'2015-07-09 21:20:00','2015-06-23 18:21:00',NULL),(29,'1','William Petzl','24kn',15.00,'2015-07-10 20:30:00','2015-06-23 18:21:00',273),(30,'1','Swivel S Petzl','',30.00,'2015-07-10 21:20:00','2015-06-23 18:21:00',274),(31,'1','Metro','Vintage',5.00,'2015-07-09 20:50:00','2015-06-23 18:21:00',275),(32,'1','Serie di moschettoni alluminio','',50.00,'2015-07-11 20:30:00','2015-06-23 18:21:00',277),(34,'1','Assorbitore','Absorbica ymgolc9 Sscadenza novembre 2017',50.00,'2015-07-11 20:20:00','2015-06-23 18:21:00',NULL),(35,'1','Grillon Petzl','con cordino jane 2mt - Scad marzo 2018',80.00,'2015-07-11 21:00:00','2015-06-23 18:21:00',278),(36,'1','Maniglia dx Petzl','',30.00,'2015-07-10 21:30:00','2015-06-23 18:21:00',NULL),(37,'1','Otto 2','',10.00,'2015-07-09 21:30:00','2015-06-23 18:21:00',NULL),(38,'1','Otto','',10.00,'2015-07-09 21:40:00','2015-06-23 18:21:00',NULL),(39,'1','Otto pirana','',10.00,'2015-07-09 21:50:00','2015-06-23 18:21:00',279),(40,'1','Otto corna','',10.00,'2015-07-10 20:00:00','2015-06-23 18:21:00',281),(41,'1','Carrucola grande Petzl','32kn',30.00,'2015-07-10 21:40:00','2015-06-23 18:21:00',282),(42,'1','Carrucola grande','cmt 28kn',30.00,'2015-07-10 21:50:00','2015-06-23 18:21:00',283),(43,'1','Doppia carrucola Petzl','24 kn',30.00,'2015-07-11 20:00:00','2015-06-23 18:21:00',284),(44,'1','Carrucola Camp','22 kn',20.00,'2015-07-10 20:50:00','2015-06-23 18:21:00',285),(45,'1','Carrucola Petzl','22 kn',20.00,'2015-07-10 21:00:00','2015-06-23 18:21:00',286),(46,'1','Leica Disto','classic 5 200mt',100.00,'2015-07-11 21:30:00','2015-06-23 18:21:00',287),(47,'1','ROCCOPULLEY','Carr. navale con meccanismo di freno',50.00,'2015-07-11 22:00:00','2015-06-23 18:21:00',291),(48,'1','Moschettone alluminio viola','',10.00,'2015-07-10 20:10:00','2015-06-23 18:21:00',276);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_image`
--

DROP TABLE IF EXISTS `item_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_item` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `thumb_name` varchar(100) DEFAULT NULL,
  `path` varchar(200) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `image` longblob,
  PRIMARY KEY (`id`),
  KEY `image_fk_item` (`id_item`),
  CONSTRAINT `image_fk_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_image`
--

LOCK TABLES `item_image` WRITE;
/*!40000 ALTER TABLE `item_image` DISABLE KEYS */;
INSERT INTO `item_image` VALUES (15,13,'15_Moschettone_acciaio.jpg','15_Moschettone_acciaio_thumb.jpg','/home/cremo80/asta/store/img/13/','Vintage',NULL),(16,14,'16_Gancio_alluminio.jpg','16_Gancio_alluminio_thumb.jpg','/home/cremo80/asta/store/img/14/','Salewa',NULL),(17,15,'17_Fettuccia_Petzl_Anneau.jpg','17_Fettuccia_Petzl_Anneau_thumb.jpg','/home/cremo80/asta/store/img/15/','C40 120cm. Scadenza aprile 2018',NULL),(18,16,'18_Protraxion_petzl.jpg','18_Protraxion_petzl_thumb.jpg','/home/cremo80/asta/store/img/16/','',NULL),(19,17,'19_Fettuccia_Mammut.jpg','19_Fettuccia_Mammut_thumb.jpg','/home/cremo80/asta/store/img/17/','40-80cm vintage',NULL),(20,18,'20_Kleintool.jpg','20_Kleintool_thumb.jpg','/home/cremo80/asta/store/img/18/','',NULL),(21,19,'21_i_D_petzl.jpg','21_i_D_petzl_thumb.jpg','/home/cremo80/asta/store/img/19/','',NULL),(22,20,'22_Ancoretta.jpg','22_Ancoretta_thumb.jpg','/home/cremo80/asta/store/img/20/','',NULL),(23,21,'23_Imbrago_Petzl.jpg','23_Imbrago_Petzl_thumb.jpg','/home/cremo80/asta/store/img/21/','navaho bod fast. Scadenza marzo 2019',NULL),(24,22,'24_Stopfor_k_Tractel.jpg','24_Stopfor_k_Tractel_thumb.jpg','/home/cremo80/asta/store/img/22/','',NULL),(25,23,'25_Fettuccia_Kong.jpg','25_Fettuccia_Kong_thumb.jpg','/home/cremo80/asta/store/img/23/','80cm vintage',NULL),(26,24,'26_Fettuccia_Mammut.jpg','26_Fettuccia_Mammut_thumb.jpg','/home/cremo80/asta/store/img/24/','40-80 cm vintage',NULL),(27,25,'27_Fettuccia_rainbow.jpg','27_Fettuccia_rainbow_thumb.jpg','/home/cremo80/asta/store/img/25/','',NULL),(28,26,'28_Fettuccia_Tiger.jpg','28_Fettuccia_Tiger_thumb.jpg','/home/cremo80/asta/store/img/26/','vintage 50cm',NULL),(29,27,'29_Cador_Petzl_acciaio.jpg','29_Cador_Petzl_acciaio_thumb.jpg','/home/cremo80/asta/store/img/27/','',NULL),(30,28,'30_Fettuccia_Petzl_Anneau.jpg','30_Fettuccia_Petzl_Anneau_thumb.jpg','/home/cremo80/asta/store/img/28/','C40 60cm. Scadenza agosto 2015',NULL),(31,29,'31_William_Petzl.jpg','31_William_Petzl_thumb.jpg','/home/cremo80/asta/store/img/29/','24kn',NULL),(32,30,'32_Swivel_S_Petzl.jpg','32_Swivel_S_Petzl_thumb.jpg','/home/cremo80/asta/store/img/30/','',NULL),(33,31,'33_Metro.jpg','33_Metro_thumb.jpg','/home/cremo80/asta/store/img/31/','Vintage',NULL),(35,34,'35_Assorbitore.jpg','35_Assorbitore_thumb.jpg','/home/cremo80/asta/store/img/34/','',NULL),(36,35,'36_Grillon_Petzl.jpg','36_Grillon_Petzl_thumb.jpg','/home/cremo80/asta/store/img/35/','',NULL),(37,36,'37_Maniglia_dx_Petzl.jpg','37_Maniglia_dx_Petzl_thumb.jpg','/home/cremo80/asta/store/img/36/','',NULL),(38,37,'38_Otto_2.jpg','38_Otto_2_thumb.jpg','/home/cremo80/asta/store/img/37/','',NULL),(39,38,'39_Otto.jpg','39_Otto_thumb.jpg','/home/cremo80/asta/store/img/38/','',NULL),(40,39,'40_Otto_pirana.jpg','40_Otto_pirana_thumb.jpg','/home/cremo80/asta/store/img/39/','',NULL),(41,40,'41_Otto_corna.jpg','41_Otto_corna_thumb.jpg','/home/cremo80/asta/store/img/40/','',NULL),(42,41,'42_Carrucola_grande_Petzl.jpg','42_Carrucola_grande_Petzl_thumb.jpg','/home/cremo80/asta/store/img/41/','32kn',NULL),(43,42,'43_Carrucola_grande.jpg','43_Carrucola_grande_thumb.jpg','/home/cremo80/asta/store/img/42/','',NULL),(44,43,'44_Doppia_carrucola_Petzl.jpg','44_Doppia_carrucola_Petzl_thumb.jpg','/home/cremo80/asta/store/img/43/','24 kn',NULL),(45,44,'45_Carrucola_Camp.jpg','45_Carrucola_Camp_thumb.jpg','/home/cremo80/asta/store/img/44/','',NULL),(46,45,'46_Carrucola_Petzl.jpg','46_Carrucola_Petzl_thumb.jpg','/home/cremo80/asta/store/img/45/','',NULL),(47,46,'47_Leica_Disto.jpg','47_Leica_Disto_thumb.jpg','/home/cremo80/asta/store/img/46/','classic 5 200mt',NULL),(48,47,'48_ROCCOPULLEY.jpg','48_ROCCOPULLEY_thumb.jpg','/home/cremo80/asta/store/img/47/','Carr. navale con meccanismo di freno',NULL),(49,32,'49_Serie_di_moschettoni_alluminio.jpg','49_Serie_di_moschettoni_alluminio_thumb.jpg','/home/cremo80/asta/store/img/32/','',NULL),(50,48,'50_Moschettone_alluminio_viola.jpg','50_Moschettone_alluminio_viola_thumb.jpg','/home/cremo80/asta/store/img/48/','',NULL);
/*!40000 ALTER TABLE `item_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_news`
--

DROP TABLE IF EXISTS `item_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_item` int(10) unsigned NOT NULL,
  `id_status` int(11) NOT NULL DEFAULT '0',
  `sent_date` datetime DEFAULT NULL,
  `cc_list` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `news_fk_item` (`id_item`),
  CONSTRAINT `news_fk_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_news`
--

LOCK TABLES `item_news` WRITE;
/*!40000 ALTER TABLE `item_news` DISABLE KEYS */;
INSERT INTO `item_news` VALUES (47,13,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(48,14,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(49,15,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(50,16,2,'2015-06-23 18:36:40','cremonese1980@gmail.com,chevuoi@hotmail.com'),(51,17,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(52,18,2,'2015-06-23 18:45:40','cremonese1980@gmail.com,chevuoi@hotmail.com'),(53,19,2,'2015-06-23 18:51:40','cremonese1980@gmail.com,chevuoi@hotmail.com'),(54,20,2,'2015-06-23 18:57:40','cremonese1980@gmail.com,chevuoi@hotmail.com'),(55,21,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(56,22,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(57,23,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(58,24,2,'2015-06-23 19:01:40','cremonese1980@gmail.com,chevuoi@hotmail.com'),(59,25,2,'2015-06-23 20:00:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(60,26,2,'2015-06-23 20:03:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(61,27,2,'2015-06-23 20:03:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(62,28,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(63,29,2,'2015-06-23 20:06:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(64,30,2,'2015-06-23 20:06:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(65,31,2,'2015-06-23 20:09:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(66,32,2,'2015-06-23 20:09:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(67,34,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(68,35,2,'2015-06-23 20:12:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(69,36,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(70,37,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(71,38,1,NULL,'cremonese1980@gmail.com,chevuoi@hotmail.com'),(72,39,2,'2015-06-23 20:12:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(73,40,2,'2015-06-23 20:12:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(74,41,2,'2015-06-23 20:12:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(75,42,2,'2015-06-23 20:15:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(76,43,2,'2015-06-23 20:15:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(77,44,2,'2015-06-23 20:18:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(78,45,2,'2015-06-23 20:18:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(79,46,2,'2015-06-23 20:18:09','cremonese1980@gmail.com,chevuoi@hotmail.com'),(80,47,2,'2015-06-23 20:41:06','cremonese1980@gmail.com,chevuoi@hotmail.com'),(81,48,2,'2015-06-23 20:09:09','cremonese1980@gmail.com,chevuoi@hotmail.com');
/*!40000 ALTER TABLE `item_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relaunch`
--

DROP TABLE IF EXISTS `relaunch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relaunch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) DEFAULT NULL,
  `id_item` int(10) unsigned NOT NULL,
  `username` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relaunch_fk_item` (`id_item`),
  CONSTRAINT `relaunch_fk_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaunch`
--

LOCK TABLES `relaunch` WRITE;
/*!40000 ALTER TABLE `relaunch` DISABLE KEYS */;
INSERT INTO `relaunch` VALUES (262,65.00,16,'Davide Cusumano','2015-06-23 18:35:53'),(263,150.00,18,'Matteo Maternini','2015-06-23 18:45:16'),(264,105.00,19,'Paolo Testa','2015-06-23 18:51:25'),(265,75.00,20,'Matteo Maternini','2015-06-23 18:56:47'),(267,20.00,24,'Luca Giuliani','2015-06-23 19:01:25'),(270,70.00,25,'Simone Grolli','2015-06-23 19:57:05'),(271,25.00,26,'Luca Broggi','2015-06-23 20:00:25'),(272,20.00,27,'Stefano Panni','2015-06-23 20:02:22'),(273,15.00,29,'Gianluca Contaldi','2015-06-23 20:04:07'),(274,80.00,30,'Andrea Quintarelli','2015-06-23 20:05:10'),(275,20.00,31,'Franco Mazzoni','2015-06-23 20:06:55'),(276,10.00,48,'Alessio Romano','2015-06-23 20:08:07'),(277,60.00,32,'Andrea Franceschetti','2015-06-23 20:08:47'),(278,100.00,35,'Ruggero Livio','2015-06-23 20:09:28'),(279,20.00,39,'Stefano Martinelli','2015-06-23 20:10:05'),(281,125.00,40,'Luca Meacci','2015-06-23 20:10:47'),(282,30.00,41,'Andrea Di Lenardo','2015-06-23 20:11:50'),(283,30.00,42,'Alessio Romano','2015-06-23 20:13:38'),(284,50.00,43,'Alex Pozzi','2015-06-23 20:14:16'),(285,30.00,44,'Matteo Cavenaghi','2015-06-23 20:16:24'),(286,30.00,45,'Matteo Cavenaghi','2015-06-23 20:16:46'),(287,100.00,46,'Stefano Panni','2015-06-23 20:17:33'),(291,200.00,47,'Alessio Romano','2015-06-23 20:40:04');
/*!40000 ALTER TABLE `relaunch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `id_type` varchar(20) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('cremo','g4br13l3','0','','Gabriele','Cremonese','2015-06-23 20:38:08','cremonese1980@gmail.com'),('super','cazzola','1','','Sarah','Falasconi','2015-06-23 13:40:53','chevuoi@hotmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-23 20:44:34

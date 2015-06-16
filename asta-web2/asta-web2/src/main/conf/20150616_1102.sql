-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: mysql1001.mochahost.com    Database: cremo80_astadb
-- ------------------------------------------------------
-- Server version	5.5.36-cll-lve

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
INSERT INTO `configuration` VALUES ('base.directory','/home/cremo80/asta/store/img',NULL),('bc.list.base','cremonese1980@gmail.com,chevuoi@hotmail.com',NULL),('live.env','false',NULL),('mail.sender.cc','',NULL),('mail.sender.from','astaweb.server@gmail.com',NULL),('mail.sender.host','smtp.gmail.com',NULL),('mail.sender.password','r1l4nc10',NULL),('mail.sender.port','465',NULL),('mail.sender.protocol','smtp',NULL),('mail.sender.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory',NULL),('mail.sender.to','cremonese1980@gmail.com,chevuoi@hotmail.com',NULL),('mail.sender.username','astaweb.server@gmail.com',NULL),('mail.smtp.auth','true',NULL),('mail.smtp.starttls.enable','true',NULL),('max.upload.size','2999999',NULL),('min.sell.time.hour','1',NULL),('relaunch.max.abs','50',NULL),('relaunch.max.rel','3',NULL),('relaunch.postpone.seconds','180',NULL),('secret.words','birra,fiorentina,g4br13l3,cazzola,frittella',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (13,'1','Moschettone acciaio','Vintage',10.00,'2015-06-16 21:00:00','2015-06-09 20:00:00',248),(14,'1','Gancio alluminio','Salewa',30.00,'2015-06-16 20:55:00','2015-06-09 20:05:00',244),(15,'2','Fettuccia Petzl Anneau','C40 120cm. Scadenza aprile 2018',10.00,'2015-06-15 20:30:00','2015-06-09 20:10:00',194),(16,'1','Protraxion petzl','',60.00,'2015-06-16 21:00:00','2015-06-09 21:30:00',246),(17,'2','Fettuccia Mammut','40-80cm vintage',5.00,'2015-06-15 20:00:00','2015-06-10 20:00:00',240),(18,'1','Kleintool','',100.00,'2015-06-16 21:30:00','2015-06-10 21:00:00',247),(19,'2','i D petzl','',100.00,'2015-06-14 23:00:00','2015-06-11 18:00:00',229),(20,'2','Ancoretta','',3.15,'2015-06-15 21:32:07','2015-06-12 10:00:00',241),(21,'2','Imbrago Petzl','navaho bod fast. Scadenza marzo 2019',80.00,'2015-06-13 14:00:00','2015-06-09 20:15:00',198),(22,'1','Stopfor k Tractel','',40.00,'2015-06-16 21:00:00','2015-06-09 20:20:00',68),(23,'2','Fettuccia Kong','80cm vintage',5.00,'2015-06-10 00:47:00','2015-06-09 20:25:00',170),(24,'2','Fettuccia Mammut','40-80 cm vintage',3.20,'2015-06-09 23:55:17','2015-06-09 20:30:00',130),(25,'2','Fettuccia rainbow','',5.00,'2015-06-09 22:03:00','2015-06-09 20:30:00',39),(26,'2','Fettuccia Tiger','vintage 50cm',4.00,'2015-06-09 22:36:17','2015-06-09 20:25:00',42),(27,'2','Cador Petzl acciaio','',20.00,'2015-06-09 22:51:00','2015-06-09 21:25:00',73),(28,'2','Fettuccia Petzl Anneau','C40 60cm. Scadenza agosto 2015',10.00,'2015-06-13 14:00:00','2015-06-10 21:00:00',221),(29,'2','William Petzl','24kn',12.00,'2015-06-09 23:38:17','2015-06-09 21:00:00',115),(30,'2','Swivel S Petzl','',30.00,'2015-06-09 23:35:00','2015-06-09 22:25:00',91),(31,'1','Metro','Vintage',5.00,'2015-06-16 21:00:00','2015-06-09 20:30:00',253),(32,'2','Serie di moschettoni alluminio','',50.00,'2015-06-15 20:00:00','2015-06-09 21:00:00',202),(34,'2','Assorbitore','Absorbica ymgolc9 Sscadenza novembre 2017',50.00,'2015-06-11 00:10:00','2015-06-10 22:36:00',219),(35,'2','Grillon Petzl','con cordino jane 2mt - Scad marzo 2018',80.00,'2015-06-11 00:20:00','2015-06-10 22:38:00',220);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_image`
--

LOCK TABLES `item_image` WRITE;
/*!40000 ALTER TABLE `item_image` DISABLE KEYS */;
INSERT INTO `item_image` VALUES (15,13,'15_Moschettone_acciaio.jpg','15_Moschettone_acciaio_thumb.jpg','/home/cremo80/asta/store/img/13/','Vintage',NULL),(16,14,'16_Gancio_alluminio.jpg','16_Gancio_alluminio_thumb.jpg','/home/cremo80/asta/store/img/14/','Salewa',NULL),(17,15,'17_Fettuccia_Petzl_Anneau.jpg','17_Fettuccia_Petzl_Anneau_thumb.jpg','/home/cremo80/asta/store/img/15/','C40 120cm. Scadenza aprile 2018',NULL),(18,16,'18_Protraxion_petzl.jpg','18_Protraxion_petzl_thumb.jpg','/home/cremo80/asta/store/img/16/','',NULL),(19,17,'19_Fettuccia_Mammut.jpg','19_Fettuccia_Mammut_thumb.jpg','/home/cremo80/asta/store/img/17/','40-80cm vintage',NULL),(20,18,'20_Kleintool.jpg','20_Kleintool_thumb.jpg','/home/cremo80/asta/store/img/18/','',NULL),(21,19,'21_i_D_petzl.jpg','21_i_D_petzl_thumb.jpg','/home/cremo80/asta/store/img/19/','',NULL),(22,20,'22_Ancoretta.jpg','22_Ancoretta_thumb.jpg','/home/cremo80/asta/store/img/20/','',NULL),(23,21,'23_Imbrago_Petzl.jpg','23_Imbrago_Petzl_thumb.jpg','/home/cremo80/asta/store/img/21/','navaho bod fast. Scadenza marzo 2019',NULL),(24,22,'24_Stopfor_k_Tractel.jpg','24_Stopfor_k_Tractel_thumb.jpg','/home/cremo80/asta/store/img/22/','',NULL),(25,23,'25_Fettuccia_Kong.jpg','25_Fettuccia_Kong_thumb.jpg','/home/cremo80/asta/store/img/23/','80cm vintage',NULL),(26,24,'26_Fettuccia_Mammut.jpg','26_Fettuccia_Mammut_thumb.jpg','/home/cremo80/asta/store/img/24/','40-80 cm vintage',NULL),(27,25,'27_Fettuccia_rainbow.jpg','27_Fettuccia_rainbow_thumb.jpg','/home/cremo80/asta/store/img/25/','',NULL),(28,26,'28_Fettuccia_Tiger.jpg','28_Fettuccia_Tiger_thumb.jpg','/home/cremo80/asta/store/img/26/','vintage 50cm',NULL),(29,27,'29_Cador_Petzl_acciaio.jpg','29_Cador_Petzl_acciaio_thumb.jpg','/home/cremo80/asta/store/img/27/','',NULL),(30,28,'30_Fettuccia_Petzl_Anneau.jpg','30_Fettuccia_Petzl_Anneau_thumb.jpg','/home/cremo80/asta/store/img/28/','C40 60cm. Scadenza agosto 2015',NULL),(31,29,'31_William_Petzl.jpg','31_William_Petzl_thumb.jpg','/home/cremo80/asta/store/img/29/','24kn',NULL),(32,30,'32_Swivel_S_Petzl.jpg','32_Swivel_S_Petzl_thumb.jpg','/home/cremo80/asta/store/img/30/','',NULL),(33,31,'33_Metro.jpg','33_Metro_thumb.jpg','/home/cremo80/asta/store/img/31/','Vintage',NULL),(34,32,'34_Serie_di_moschettoni_alluminio.jpg','34_Serie_di_moschettoni_alluminio_thumb.jpg','/home/cremo80/asta/store/img/32/','',NULL),(35,34,'35_Assorbitore.jpg','35_Assorbitore_thumb.jpg','/home/cremo80/asta/store/img/34/','',NULL),(36,35,'36_Grillon_Petzl.jpg','36_Grillon_Petzl_thumb.jpg','/home/cremo80/asta/store/img/35/','',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_news`
--

LOCK TABLES `item_news` WRITE;
/*!40000 ALTER TABLE `item_news` DISABLE KEYS */;
INSERT INTO `item_news` VALUES (1,17,2,'2015-06-15 20:01:37','cremonese1980@gmail.com,chevuoi@hotmail.com'),(2,18,2,'2015-06-15 23:44:49','cremonese1980@gmail.com,chevuoi@hotmail.com'),(3,19,2,'2015-06-14 23:01:52','cremonese1980@gmail.com,chevuoi@hotmail.com'),(4,20,2,'2015-06-15 21:33:37','cremonese1980@gmail.com,chevuoi@hotmail.com'),(5,28,2,'2015-06-13 14:01:26','cremonese1980@gmail.com,chevuoi@hotmail.com,Mcr.lombardi@gmail.com '),(6,25,2,'2015-06-10 01:39:28','cremonese1980@gmail.com,chevuoi@hotmail.com'),(7,26,2,'2015-06-10 01:39:31','cremonese1980@gmail.com,chevuoi@hotmail.com'),(8,14,2,'2015-06-15 21:44:37','cremonese1980@gmail.com,chevuoi@hotmail.com'),(9,22,2,'2015-06-10 01:39:33','cremonese1980@gmail.com,chevuoi@hotmail.com'),(10,27,2,'2015-06-10 01:39:35','cremonese1980@gmail.com,chevuoi@hotmail.com'),(11,30,2,'2015-06-10 01:39:36','cremonese1980@gmail.com,chevuoi@hotmail.com'),(12,13,2,'2015-06-15 23:46:49','cremonese1980@gmail.com,chevuoi@hotmail.com'),(13,29,2,'2015-06-10 01:39:43','cremonese1980@gmail.com,chevuoi@hotmail.com'),(14,24,2,'2015-06-10 01:39:45','cremonese1980@gmail.com,chevuoi@hotmail.com'),(15,16,2,'2015-06-15 23:42:49','cremonese1980@gmail.com,chevuoi@hotmail.com'),(16,31,2,'2015-06-16 00:11:21','cremonese1980@gmail.com,chevuoi@hotmail.com,sarahfalasconi@gmail.com'),(17,21,2,'2015-06-13 14:01:41','cremonese1980@gmail.com,chevuoi@hotmail.com,Sara_sacchi@hotmail.com'),(18,32,2,'2015-06-15 20:01:37','cremonese1980@gmail.com,chevuoi@hotmail.com'),(19,15,2,'2015-06-15 20:31:37','cremonese1980@gmail.com,chevuoi@hotmail.com'),(20,23,2,'2015-06-10 01:39:52','cremonese1980@gmail.com,chevuoi@hotmail.com'),(33,34,2,'2015-06-11 00:11:33','cremonese1980@gmail.com,chevuoi@hotmail.com,alessandrogandini@hotmail.com,Mcr.lombardi@gmail.com '),(34,35,2,'2015-06-11 00:21:33','cremonese1980@gmail.com,chevuoi@hotmail.com,cremonese1980@hotmail.com,Mcr.lombardi@gmail.com ');
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
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaunch`
--

LOCK TABLES `relaunch` WRITE;
/*!40000 ALTER TABLE `relaunch` DISABLE KEYS */;
INSERT INTO `relaunch` VALUES (26,35.00,14,'Pippo Pluto','2015-06-09 20:11:10'),(27,36.00,14,'Pippo Pluto','2015-06-09 20:11:51'),(28,13.00,13,'raffaele mastrangelo','2015-06-09 20:14:15'),(29,100.00,21,'sarah falasconi','2015-06-09 20:25:14'),(30,20.00,13,'sarah falasconi','2015-06-09 20:26:11'),(31,110.00,21,'paola romagnoli','2015-06-09 20:27:14'),(32,50.00,14,'sarah falasconi','2015-06-09 20:27:36'),(33,51.00,14,'Gabriele Cremonese','2015-06-09 20:36:10'),(34,15.00,31,'Mariacristina Lombardi','2015-06-09 21:53:22'),(35,115.00,21,'Mariacristina Lombardi','2015-06-09 21:54:18'),(36,55.00,14,'Mariacristina Lombardi','2015-06-09 21:54:54'),(37,25.00,13,'Mariacristina Lombardi','2015-06-09 21:55:29'),(38,15.00,15,'Mariacristina Lombardi','2015-06-09 21:56:56'),(39,7.00,25,'Mariacristina Lombardi','2015-06-09 21:57:57'),(40,4.00,26,'Giuseppe Molinaro','2015-06-09 22:14:32'),(41,5.00,26,'Gabriele Cremonese','2015-06-09 22:15:50'),(42,7.00,26,'Mariacristina Lombardi','2015-06-09 22:18:24'),(43,52.00,32,'sara sacchi','2015-06-09 22:28:13'),(44,22.00,27,'Mariacristina Lombardi','2015-06-09 22:28:25'),(45,20.00,31,'sara sacchi','2015-06-09 22:29:24'),(46,23.00,27,'sara sacchi','2015-06-09 22:32:26'),(47,54.00,32,'Mariacristina Lombardi','2015-06-09 22:34:17'),(48,24.00,27,'Mariacristina Lombardi','2015-06-09 22:35:00'),(49,27.00,27,'sara sacchi','2015-06-09 22:36:14'),(50,59.00,32,'sara sacchi','2015-06-09 22:38:31'),(51,35.00,27,'sarah falasconi','2015-06-09 22:38:43'),(52,15.00,29,'sarah falasconi','2015-06-09 22:39:11'),(53,130.00,21,'sarah falasconi','2015-06-09 22:39:43'),(54,37.00,27,'Mariacristina Lombardi','2015-06-09 22:39:45'),(55,38.00,27,'sara sacchi','2015-06-09 22:39:48'),(56,75.00,14,'sarah falasconi','2015-06-09 22:40:38'),(57,40.00,27,'Mariacristina Lombardi','2015-06-09 22:41:03'),(58,31.00,30,'sarah falasconi','2015-06-09 22:41:13'),(59,17.00,29,'Mariacristina Lombardi','2015-06-09 22:41:17'),(60,4.00,24,'Mariacristina Lombardi','2015-06-09 22:41:51'),(61,5.00,24,'sarah falasconi','2015-06-09 22:41:54'),(62,51.00,27,'sara sacchi','2015-06-09 22:42:25'),(63,70.00,16,'sarah falasconi','2015-06-09 22:42:49'),(64,65.00,32,'Massimo Da Ros','2015-06-09 22:42:52'),(65,45.00,22,'sarah falasconi','2015-06-09 22:43:19'),(66,75.00,16,'Massimo Da Ros','2015-06-09 22:44:09'),(67,6.00,24,'Mariacristina Lombardi','2015-06-09 22:44:48'),(68,48.00,22,'Massimo Da Ros','2015-06-09 22:44:53'),(69,52.00,27,'Mariacristina Lombardi','2015-06-09 22:45:07'),(70,77.00,16,'Mariacristina Lombardi','2015-06-09 22:45:36'),(71,135.00,21,'Massimo Da Ros','2015-06-09 22:46:20'),(72,53.00,27,'sara sacchi','2015-06-09 22:46:37'),(73,55.00,27,'Mariacristina Lombardi','2015-06-09 22:47:41'),(74,5.50,23,'sara sacchi','2015-06-09 22:48:10'),(75,21.11,31,'Massimo Da Ros','2015-06-09 22:48:48'),(76,6.67,23,'Massimo Da Ros','2015-06-09 22:51:53'),(77,7.00,23,'Mariacristina Lombardi','2015-06-09 22:55:04'),(78,22.00,31,'Mariacristina Lombardi','2015-06-09 22:57:31'),(79,23.45,31,'sara sacchi','2015-06-09 22:58:26'),(80,7.76,24,'Massimo Da Ros','2015-06-09 22:59:40'),(81,19.00,29,'sarah falasconi','2015-06-09 22:59:45'),(82,32.56,30,'Massimo Da Ros','2015-06-09 23:00:36'),(83,21.00,29,'sara sacchi','2015-06-09 23:02:06'),(84,22.00,29,'Mariacristina Lombardi','2015-06-09 23:02:25'),(85,33.00,30,'Mariacristina Lombardi','2015-06-09 23:03:02'),(86,8.00,24,'Mariacristina Lombardi','2015-06-09 23:03:19'),(87,23.00,29,'sara sacchi','2015-06-09 23:04:34'),(88,34.56,30,'Massimo Da Ros','2015-06-09 23:05:17'),(89,24.00,31,'Mariacristina Lombardi','2015-06-09 23:05:17'),(90,24.00,29,'Mariacristina Lombardi','2015-06-09 23:05:41'),(91,35.00,30,'Mariacristina Lombardi','2015-06-09 23:07:23'),(92,25.78,29,'sara sacchi','2015-06-09 23:07:43'),(93,26.00,29,'Mariacristina Lombardi','2015-06-09 23:07:58'),(94,27.00,29,'sara sacchi','2015-06-09 23:08:39'),(95,30.00,29,'Mariacristina Lombardi','2015-06-09 23:09:18'),(96,32.00,29,'sara sacchi','2015-06-09 23:11:36'),(97,33.00,29,'Mariacristina Lombardi','2015-06-09 23:12:02'),(98,37.00,29,'sara sacchi','2015-06-09 23:12:20'),(99,38.00,29,'Mariacristina Lombardi','2015-06-09 23:14:39'),(100,39.00,29,'paola montalto','2015-06-09 23:15:26'),(101,40.00,29,'Mariacristina Lombardi','2015-06-09 23:16:35'),(102,80.00,32,'paola montalto','2015-06-09 23:16:48'),(103,41.00,29,'sara sacchi','2015-06-09 23:18:06'),(104,26.50,13,'paola montalto','2015-06-09 23:18:23'),(105,42.00,29,'Mariacristina Lombardi','2015-06-09 23:18:24'),(106,47.00,29,'sara sacchi','2015-06-09 23:19:30'),(107,50.00,29,'Mariacristina Lombardi','2015-06-09 23:20:35'),(108,51.00,29,'alessandro gandini','2015-06-09 23:23:29'),(109,52.00,29,'Mariacristina Lombardi','2015-06-09 23:24:00'),(110,53.00,29,'alessandro gandini','2015-06-09 23:27:16'),(111,54.00,29,'Mariacristina Lombardi','2015-06-09 23:30:12'),(112,56.00,29,'alessandro gandini','2015-06-09 23:31:47'),(113,81.00,32,'alessandro gandini','2015-06-09 23:32:26'),(114,25.00,31,'alessandro gandini','2015-06-09 23:33:01'),(115,58.00,29,'Mariacristina Lombardi','2015-06-09 23:33:02'),(116,9.10,24,'alessandro gandini','2015-06-09 23:36:35'),(117,10.00,24,'Mariacristina Lombardi','2015-06-09 23:37:26'),(118,8.00,23,'alessandro gandini','2015-06-09 23:39:26'),(119,9.00,23,'alessandro gandini','2015-06-09 23:39:56'),(120,11.00,24,'alessandro gandini','2015-06-09 23:41:03'),(121,136.00,21,'alessandro gandini','2015-06-09 23:41:21'),(122,82.00,32,'alessandro gandini','2015-06-09 23:41:36'),(123,16.00,15,'alessandro gandini','2015-06-09 23:41:54'),(124,12.00,24,'Mariacristina Lombardi','2015-06-09 23:42:49'),(125,13.00,24,'alessandro gandini','2015-06-09 23:44:09'),(126,14.02,24,'Mariacristina Lombardi','2015-06-09 23:44:24'),(127,15.00,24,'alessandro gandini','2015-06-09 23:46:31'),(128,17.00,24,'Mariacristina Lombardi','2015-06-09 23:49:08'),(129,18.00,24,'alessandro gandini','2015-06-09 23:49:48'),(130,19.00,24,'Mariacristina Lombardi','2015-06-09 23:51:54'),(131,79.00,16,'alessandro gandini','2015-06-10 00:00:19'),(132,27.00,31,'Marco Brioschi','2015-06-10 00:03:37'),(133,29.00,31,'Marco Brioschi','2015-06-10 00:04:06'),(134,10.00,23,'Mariacristina Lombardi','2015-06-10 00:04:53'),(135,11.00,23,'alessandro gandini','2015-06-10 00:07:01'),(136,20.00,23,'Mariacristina Lombardi','2015-06-10 00:07:28'),(137,21.00,23,'alessandro gandini','2015-06-10 00:11:24'),(138,22.50,23,'Mariacristina Lombardi','2015-06-10 00:11:56'),(139,30.00,31,'Marco Brioschi','2015-06-10 00:13:08'),(140,30.00,31,'Marco Brioschi','2015-06-10 00:13:08'),(141,30.00,31,'Marco Brioschi','2015-06-10 00:13:08'),(142,31.00,31,'Marco Brioschi','2015-06-10 00:13:30'),(143,23.00,23,'alessandro gandini','2015-06-10 00:13:56'),(144,32.00,31,'Marco Brioschi','2015-06-10 00:14:00'),(145,24.00,23,'Mariacristina Lombardi','2015-06-10 00:16:01'),(146,25.00,23,'alessandro gandini','2015-06-10 00:17:44'),(147,26.20,23,'Mariacristina Lombardi','2015-06-10 00:18:36'),(148,27.00,23,'alessandro gandini','2015-06-10 00:19:01'),(149,29.00,23,'Mariacristina Lombardi','2015-06-10 00:20:05'),(150,30.12,23,'alessandro gandini','2015-06-10 00:21:02'),(151,31.00,23,'Mariacristina Lombardi','2015-06-10 00:22:36'),(152,32.00,23,'alessandro gandini','2015-06-10 00:25:36'),(153,50.00,23,'Mariacristina Lombardi','2015-06-10 00:26:03'),(154,51.00,23,'alessandro gandini','2015-06-10 00:26:25'),(155,52.00,23,'Mariacristina Lombardi','2015-06-10 00:29:20'),(156,53.00,23,'alessandro gandini','2015-06-10 00:31:48'),(157,54.00,23,'Mariacristina Lombardi','2015-06-10 00:32:15'),(158,55.00,23,'alessandro gandini','2015-06-10 00:32:35'),(159,56.00,23,'Mariacristina Lombardi','2015-06-10 00:33:12'),(160,57.00,23,'Gabriele Cremonese','2015-06-10 00:35:31'),(161,58.00,23,'Mariacristina Lombardi','2015-06-10 00:35:57'),(162,59.10,23,'alessandro gandini','2015-06-10 00:36:19'),(163,61.16,23,'Mariacristina Lombardi','2015-06-10 00:36:58'),(164,137.00,21,'Mariacristina Lombardi','2015-06-10 00:38:15'),(165,83.00,32,'Mariacristina Lombardi','2015-06-10 00:38:43'),(166,17.00,15,'Mariacristina Lombardi','2015-06-10 00:39:09'),(167,62.00,23,'alessandro gandini','2015-06-10 00:39:21'),(168,63.36,23,'Mariacristina Lombardi','2015-06-10 00:39:42'),(169,65.00,23,'alessandro gandini','2015-06-10 00:42:30'),(170,66.66,23,'Mariacristina Lombardi','2015-06-10 00:42:44'),(171,140.00,21,'sarah falasconi','2015-06-10 07:38:49'),(172,35.00,31,'Andrea Sironi','2015-06-10 08:27:51'),(173,80.00,16,'Mariacristina Lombardi','2015-06-10 09:13:09'),(174,85.00,32,'sara sacchi','2015-06-10 09:45:42'),(175,85.00,32,'sara sacchi','2015-06-10 09:45:59'),(176,85.00,32,'sara sacchi','2015-06-10 09:45:59'),(177,85.00,32,'sara sacchi','2015-06-10 09:45:59'),(178,85.00,32,'sara sacchi','2015-06-10 09:45:58'),(179,85.00,32,'sara sacchi','2015-06-10 09:45:57'),(180,85.00,32,'sara sacchi','2015-06-10 09:45:56'),(181,85.00,32,'sara sacchi','2015-06-10 09:45:54'),(182,85.00,32,'sara sacchi','2015-06-10 09:45:54'),(183,85.00,32,'sara sacchi','2015-06-10 09:45:54'),(184,85.00,32,'sara sacchi','2015-06-10 09:45:49'),(185,28.00,13,'sara sacchi','2015-06-10 09:46:33'),(186,37.00,31,'sara sacchi','2015-06-10 09:47:08'),(187,86.15,32,'Mariacristina Lombardi','2015-06-10 11:29:35'),(188,30.00,13,'Mariacristina Lombardi','2015-06-10 11:30:15'),(189,87.16,32,'sara sacchi','2015-06-10 12:55:08'),(190,31.00,13,'sara sacchi','2015-06-10 12:55:29'),(191,88.18,32,'Gabriele Cremonese','2015-06-10 15:01:37'),(192,89.19,32,'sara sacchi','2015-06-10 16:37:25'),(193,83.00,16,'sara sacchi','2015-06-10 16:37:50'),(194,18.89,15,'sara sacchi','2015-06-10 16:38:09'),(195,91.00,32,'davide viganò','2015-06-10 21:46:10'),(196,11.00,28,'Mariacristina Lombardi','2015-06-10 21:54:10'),(197,13.00,28,'sarah falasconi','2015-06-10 22:15:09'),(198,141.00,21,'sara sacchi','2015-06-10 22:35:43'),(199,59.00,34,'sara sacchi','2015-06-10 22:36:40'),(200,60.00,34,'alessandro gandini','2015-06-10 22:52:41'),(201,81.00,35,'alessandro gandini','2015-06-10 22:53:09'),(202,92.00,32,'alessandro gandini','2015-06-10 22:56:24'),(203,101.00,18,'alessandro gandini','2015-06-10 22:56:52'),(204,82.00,35,'Palmiro Togliatti','2015-06-10 23:03:04'),(205,65.00,34,'sara sacchi','2015-06-10 23:04:07'),(206,15.00,28,'Mariacristina Lombardi','2015-06-10 23:05:07'),(207,66.00,34,'Mariacristina Lombardi','2015-06-10 23:06:29'),(208,83.00,35,'Mariacristina Lombardi','2015-06-10 23:08:26'),(209,67.00,34,'Giuseppe Molinaro','2015-06-10 23:14:46'),(210,68.00,34,'Mariacristina Lombardi','2015-06-10 23:18:51'),(211,16.00,28,'alessandro gandini','2015-06-10 23:40:03'),(212,69.00,34,'alessandro gandini','2015-06-10 23:40:38'),(213,70.00,34,'alessandro gandini','2015-06-10 23:40:44'),(214,71.00,34,'alessandro gandini','2015-06-10 23:40:49'),(215,72.00,34,'alessandro gandini','2015-06-10 23:40:55'),(216,73.00,34,'alessandro gandini','2015-06-10 23:41:01'),(217,84.00,35,'alessandro gandini','2015-06-10 23:46:06'),(218,7.00,17,'alessandro gandini','2015-06-10 23:46:23'),(219,80.00,34,'Mariacristina Lombardi','2015-06-10 23:50:48'),(220,90.00,35,'Mariacristina Lombardi','2015-06-10 23:51:08'),(221,18.00,28,'Mariacristina Lombardi','2015-06-11 23:26:59'),(222,19.00,28,'Sarah Falasconi','2015-06-12 02:50:03'),(223,20.00,28,'Gabriele Cremonese','2015-06-12 15:53:59'),(224,21.00,28,'Sarah Falasconi','2015-06-12 22:30:53'),(225,8.00,20,'Gabriele Cremonese','2015-06-14 20:28:25'),(226,100.00,19,'Gabriele Cremonese','2015-06-14 21:20:53'),(227,101.00,19,'Gabriele Cremonese','2015-06-14 21:21:13'),(228,109.00,19,'sara sacchi','2015-06-14 22:28:40'),(229,110.00,19,'Gabriele Cremonese','2015-06-14 22:43:12'),(230,9.00,17,'Sarah Falasconi','2015-06-14 23:46:10'),(231,10.00,17,'Gabriele Cremonese','2015-06-14 23:47:07'),(232,11.00,17,'Gabriele Cremonese','2015-06-15 15:41:20'),(233,12.00,17,'Gabriele Cremonese','2015-06-15 15:42:40'),(234,13.00,17,'Gabriele Cremonese','2015-06-15 15:45:48'),(235,14.00,17,'Sarah Falasconi','2015-06-15 15:48:59'),(236,15.00,17,'Palmiro Togliatti','2015-06-15 15:51:47'),(237,16.00,17,'Sarah Falasconi','2015-06-15 15:51:59'),(238,17.00,17,'Palmiro Togliatti','2015-06-15 15:53:44'),(239,18.00,17,'Palmiro Togliatti','2015-06-15 15:59:31'),(240,19.00,17,'Gabriele Cremonese','2015-06-15 19:32:14'),(241,4.00,20,'Gabriele Cremonese','2015-06-15 20:47:28'),(242,85.00,14,'simonetta ratti','2015-06-15 21:42:47'),(243,90.00,14,'sarah falasconi','2015-06-15 21:44:15'),(244,105.00,14,'simonetta ratti','2015-06-15 21:44:35'),(245,38.00,31,'Gabriele Cremonese','2015-06-15 23:32:07'),(246,84.00,16,'Mario Cipollini','2015-06-15 23:42:37'),(247,102.00,18,'Mario Cipollini','2015-06-15 23:44:42'),(248,32.00,13,'San Pei','2015-06-15 23:46:33'),(249,45.00,31,'sarah falasconi','2015-06-15 23:56:46'),(250,46.00,31,'Palmiro Togliatti','2015-06-15 23:57:04'),(251,53.00,31,'sarah falasconi','2015-06-15 23:59:23'),(252,54.00,31,'sarah falasconi','2015-06-16 00:04:15'),(253,55.00,31,'Palmiro Togliatti','2015-06-16 00:10:34');
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
INSERT INTO `users` VALUES ('cremo','g4br13l3','0','','Gabriele','Cremonese','2015-06-16 10:18:59','cremonese1980@gmail.com'),('super','cazzola','1','','Sarah','Falasconi','2015-06-15 23:30:04','chevuoi@hotmail.com');
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

-- Dump completed on 2015-06-16 11:02:45

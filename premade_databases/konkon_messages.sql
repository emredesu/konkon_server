-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: konkon_messages
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chatroom_2`
--

DROP TABLE IF EXISTS `chatroom_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_2` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_2`
--

LOCK TABLES `chatroom_2` WRITE;
/*!40000 ALTER TABLE `chatroom_2` DISABLE KEYS */;
INSERT INTO `chatroom_2` VALUES (15,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','testaccount',1620236390),(16,'this is a very long message!!!!!!!!!!!!!!!','testaccount',1620494187),(17,'delimiter in message body test \r\n\r\n','testaccount',1620494262),(18,'testing sending message with enter','testaccount',1620573552),(19,'testing sending message with enter','testaccount',1620573554),(20,'testing sending message with enter','testaccount',1620573555),(21,'testing sending message with enter','testaccount',1620573555),(22,'testing sending message with enter','testaccount',1620573555),(23,'testing sending message with enter','testaccount',1620573555),(24,'testing sending message with enter','testaccount',1620573556),(25,'testing sending message with enter','testaccount',1620573556),(26,'testing sending message with enter','testaccount',1620573556),(27,'testing sending message with enter','testaccount',1620573557),(28,'testing sending message with enter','testaccount',1620573572),(29,'testing sending message with enter','testaccount',1620573572),(30,'oh it did work after all','testaccount',1620573678),(31,'final enter test','testaccount',1620574050),(32,'final numpad enter test','testaccount',1620574056),(33,'hello fren','testaccount',1620840672),(34,'hello to you too -w-','testaccount2',1620841513),(35,'you are stupid','testaccount',1620841682),(36,'wtf','testaccount2',1620841689),(37,'time to get the bug poggers','testaccount2',1620934929),(38,'testt','testaccount2',1620935759),(39,'it works now?','testaccount2',1620935765),(40,'dsadasd','testaccount2',1620935771),(41,'que?','testaccount2',1620935805),(42,'why does this happen though','testaccount2',1620935822),(43,'it is so random','testaccount2',1620935828),(44,'wakaranai','testaccount2',1620935836),(45,'adasdsad','testaccount2',1620936404),(46,'test','testaccount2',1620936843),(47,'yes','testaccount2',1620936845),(48,'no','testaccount2',1620936846),(49,'maybe','testaccount2',1620936847),(50,'yess','testaccount2',1620936848),(51,'fixed','testaccount2',1620936849),(52,'8);','testaccount2',1620936850),(53,'8','testaccount2',1620936851),(54,'8)','testaccount2',1620936852),(55,'well hello','testaccount',1620936959),(56,'quotation mark in message body test \'','testaccount',1620939140),(57,'double quotation mark in message body test \"','testaccount',1620939158),(58,'well cool','testaccount',1620939164),(59,'asd','testaccount',1620939170),(60,'asdasd','testaccount2',1620939173),(61,'xd','testaccount',1621527346),(62,'test','testaccount2',1621527691),(63,'test','testaccount2',1621527751),(64,'test','testaccount2',1621527770),(65,'test','testaccount2',1621527919),(66,'test','testaccount',1621614252),(67,'test','testaccount',1621614278),(68,'test','testaccount',1621614301),(69,'test','testaccount',1621614330),(70,'asd','testaccount',1621962208),(71,'dsa','testaccount',1621962256),(72,'asds','testaccount',1621962257),(73,'asd','testaccount',1622038403),(74,'asd','testaccount2',1622217062);
/*!40000 ALTER TABLE `chatroom_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatroom_3`
--

DROP TABLE IF EXISTS `chatroom_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_3` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_3`
--

LOCK TABLES `chatroom_3` WRITE;
/*!40000 ALTER TABLE `chatroom_3` DISABLE KEYS */;
INSERT INTO `chatroom_3` VALUES (11,'test','testaccount',1620148912),(12,'test2','testaccount',1620148914),(13,'test3','testaccount',1620148915),(14,'hewwo','testaccount3',1620840936),(15,'hi there','testaccount',1620840982),(16,'testtttt','testaccount3',1620841293),(17,'test123','testaccount3',1620841297),(18,'notice me senpai','testaccount3',1620841302),(19,'hello :D','testaccount',1620841747),(20,'hello qt','testaccount3',1620841749),(21,'nice it works','testaccount',1620841753),(22,'yeah!','testaccount3',1620841755),(23,'sfx test!','testaccount3',1620842940),(24,'sfx test attempt 2!','testaccount',1620843208),(25,'test','testaccount',1621528118),(26,'test','testaccount',1621528138),(27,'test','testaccount3',1621528511),(28,'hello','testaccount3',1621529892),(29,'test','testaccount',1621529935),(30,'test','testaccount',1621530067),(31,'test','testaccount',1621530114),(32,'a','testaccount',1621530447),(33,'a','testaccount',1621530605),(34,'test','testaccount',1621612636),(35,'test','testaccount',1621612671),(36,'test','testaccount3',1621612673),(37,'test','testaccount3',1621612679),(38,'test','testaccount',1621612766),(39,'test','testaccount3',1621612850),(40,'test','testaccount3',1621612863),(41,'test','testaccount3',1621613051),(42,'test','testaccount3',1621613339),(43,'test','testaccount',1621613779),(44,'test','testaccount',1621613840),(45,'test','testaccount',1621613917),(46,'test','testaccount',1621614019),(47,'test','testaccount',1621614351),(48,'test','testaccount',1621614578),(49,'test','testaccount',1621614713),(50,'test','testaccount',1621614882),(51,'get trolled','testaccount3',1621707251),(52,'test','testaccount3',1621707390),(53,'test','testaccount3',1621708398),(54,'test','testaccount3',1621708408),(55,'finally fixed :D','testaccount',1621708422),(56,'uh oh','testaccount',1621708439),(57,'test','testaccount3',1621783841),(58,'ye','testaccount3',1621783850),(59,'sadasd','testaccount',1621783857),(60,'test','testaccount3',1621785193),(61,'xd','testaccount',1621785382),(62,'test','testaccount3',1621785504),(63,'finally! :D','testaccount',1621785513),(64,'test','testaccount',1621786485),(65,'test','testaccount3',1621786512),(66,'test','testaccount3',1621786533),(67,'test','testaccount3',1621786575),(68,'test','testaccount3',1621786576),(69,'test','testaccount3',1621786577),(70,'tes','testaccount3',1621786578),(71,'tes','testaccount3',1621786579),(72,'test','testaccount3',1621786580),(73,'test','testaccount3',1621786804),(74,'test','testaccount',1621787105),(75,'test','testaccount',1621787632),(76,'test','testaccount',1621787786),(77,'test','testaccount',1621872859),(78,'test','testaccount',1621873070),(79,'asdasawsd','testaccount',1621873098),(80,'xdxdd','testaccount',1621873380),(81,'123','testaccount',1621873620),(82,'dxsqxd2312c3','testaccount',1621873624),(83,'sadasd23v12c3121x','testaccount',1621873658),(84,'fixed! :D','testaccount',1621873661),(85,'\'\'\' \"\"\"','testaccount',1621873664),(86,'yay','testaccount',1621873666),(87,'test','testaccount3',1621873678),(88,'','testaccount3',1621874358),(89,'','testaccount',1621874367),(90,'s','testaccount',1621875743),(91,'asd','testaccount3',1622036983),(92,'asd','testaccount3',1622037000),(93,'asd','testaccount3',1622037009),(94,'test','testaccount3',1622037106),(95,'yay','testaccount3',1622037118),(96,'asd','testaccount',1622038416),(97,'a','testaccount',1622134811),(98,'a','testaccount',1622134812),(99,'a','testaccount',1622134813),(100,'a','testaccount',1622134814),(101,'a','testaccount',1622134814),(102,'a','testaccount',1622134815),(103,'a','testaccount',1622134815),(104,'a','testaccount',1622134815),(105,'a','testaccount',1622134815),(106,'a','testaccount',1622134816),(107,'a','testaccount',1622134816),(108,'a','testaccount',1622134816),(109,'a','testaccount',1622134816),(110,'a','testaccount',1622134816),(111,'a','testaccount',1622134817),(112,'a','testaccount',1622134817),(113,'a','testaccount',1622134817),(114,'a','testaccount',1622134817),(115,'a','testaccount',1622134817),(116,'a','testaccount',1622134817),(117,'a','testaccount',1622134818),(118,'a','testaccount',1622134818),(119,'a','testaccount',1622134818),(120,'a','testaccount',1622134818),(121,'a','testaccount',1622134818),(122,'a','testaccount',1622134819),(123,'a','testaccount',1622134819),(124,'asd','testaccount3',1622134820),(125,'asd','testaccount3',1622134821),(126,'asd','testaccount3',1622134821),(127,'asd','testaccount3',1622134822),(128,'asd','testaccount3',1622134823),(129,'asd','testaccount3',1622134823),(130,'asd','testaccount3',1622134824),(131,'asd','testaccount3',1622134824),(132,'poggers','testaccount',1622134826),(133,'poggers indeed!','testaccount3',1622134829),(134,'aa','testaccount',1622134985),(135,'a','testaccount',1622134986),(136,'sadasd','testaccount3',1622134987),(137,'xd','testaccount',1622134989),(138,'asd','testaccount3',1622134990),(139,'ye','testaccount3',1622134991),(140,'asd','testaccount',1622134992),(141,'pog','testaccount3',1622134994),(142,'pog','testaccount',1622134995),(143,'test','testaccount',1622213419),(144,'asd','testaccount',1622213518),(145,'ye','testaccount',1622213542),(146,'nice','testaccount3',1622213544),(147,'test','testaccount',1622214195),(148,'well that\'s it','testaccount3',1622214200),(149,'can\'t believe it\'s actually complete :\')','testaccount',1622214207),(150,'same here...','testaccount3',1622214210);
/*!40000 ALTER TABLE `chatroom_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatroom_4`
--

DROP TABLE IF EXISTS `chatroom_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_4` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_4`
--

LOCK TABLES `chatroom_4` WRITE;
/*!40000 ALTER TABLE `chatroom_4` DISABLE KEYS */;
INSERT INTO `chatroom_4` VALUES (1,'test','testaccount',1622213266);
/*!40000 ALTER TABLE `chatroom_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatroom_5`
--

DROP TABLE IF EXISTS `chatroom_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_5` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_5`
--

LOCK TABLES `chatroom_5` WRITE;
/*!40000 ALTER TABLE `chatroom_5` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatroom_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatroom_6`
--

DROP TABLE IF EXISTS `chatroom_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_6` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_6`
--

LOCK TABLES `chatroom_6` WRITE;
/*!40000 ALTER TABLE `chatroom_6` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatroom_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatroom_7`
--

DROP TABLE IF EXISTS `chatroom_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_7` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_7`
--

LOCK TABLES `chatroom_7` WRITE;
/*!40000 ALTER TABLE `chatroom_7` DISABLE KEYS */;
INSERT INTO `chatroom_7` VALUES (1,'you are wrong','animesucks123',1622388535),(2,'no you!!!! >_<','anime_is_cool_123',1622388544);
/*!40000 ALTER TABLE `chatroom_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatroom_8`
--

DROP TABLE IF EXISTS `chatroom_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_8` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_content` varchar(2000) DEFAULT NULL,
  `sent_by` varchar(32) DEFAULT NULL,
  `sent_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatroom_8`
--

LOCK TABLES `chatroom_8` WRITE;
/*!40000 ALTER TABLE `chatroom_8` DISABLE KEYS */;
INSERT INTO `chatroom_8` VALUES (1,'asd','testaccount',1622388617);
/*!40000 ALTER TABLE `chatroom_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_id_holder`
--

DROP TABLE IF EXISTS `room_id_holder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_id_holder` (
  `participant_a` varchar(32) NOT NULL,
  `participant_b` varchar(32) NOT NULL,
  `room_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_id_holder`
--

LOCK TABLES `room_id_holder` WRITE;
/*!40000 ALTER TABLE `room_id_holder` DISABLE KEYS */;
INSERT INTO `room_id_holder` VALUES ('testaccount','testaccount2',2),('testaccount','testaccount3',3),('testaccount','',4),('testaccount4','testaccount2',5),('testaccount4','testaccount3',6),('animesucks123','anime_is_cool_123',7),('testaccount','animesucks123',8);
/*!40000 ALTER TABLE `room_id_holder` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-30 18:44:35

-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: konkon
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
-- Table structure for table `cookies`
--

DROP TABLE IF EXISTS `cookies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cookies` (
  `username` varchar(32) DEFAULT NULL,
  `cookie` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cookies`
--

LOCK TABLES `cookies` WRITE;
/*!40000 ALTER TABLE `cookies` DISABLE KEYS */;
INSERT INTO `cookies` VALUES ('animesucks123','_HxKsMOkV_d4LE1C3WlwiRvv2prUz18vXPnC33-eEVs'),('testaccount','jSkPPFG3JRWjEfkWw9-17O6v83so1NG1hgM5FofIojM');
/*!40000 ALTER TABLE `cookies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `friends` json DEFAULT NULL,
  `friend_requests` json DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'testaccount','$argon2id$v=19$m=102400,t=2,p=8$v5iDoqWzL9KS7Kk9IwVZmQ$HvkDvNa70ZvNIwD3dPfX1A','2021-03-15 20:18:35','{\"friends\": [\"testaccount2\", \"testaccount3\", \"animesucks123\"]}','{\"friend_requests\": []}'),(2,'japanesepasswordtestaccount','$argon2id$v=19$m=102400,t=2,p=8$hpC5yTosci0MP41SiKcEMw$h9K591PDCauXecYBD+9TEA','2021-03-15 20:33:10','{\"friends\": []}','{\"friend_requests\": []}'),(4,'dbclasstest','$argon2id$v=19$m=102400,t=2,p=8$WtHH8gq1wX/LJb7EaHMCaQ$kgFyvRE4vsqsVXprYR16gw','2021-03-18 19:46:04','{\"friends\": []}','{\"friend_requests\": []}'),(6,'testaccount2','$argon2id$v=19$m=102400,t=2,p=8$qpaQHeEhQ8oV84qcYNsLDA$kWC78FgCYniOkcDQTGb3sg','2021-04-11 18:11:08','{\"friends\": [\"testaccount\"]}','{\"friend_requests\": []}'),(7,'testaccount3','$argon2id$v=19$m=102400,t=2,p=8$9EXLiQIg7lDFmCQ3X5RBLw$yuylxLPYNXBTn9lBemjzZA','2021-05-02 20:39:31','{\"friends\": [\"testaccount\"]}','{\"friend_requests\": []}'),(8,'testaccount4','$argon2id$v=19$m=102400,t=2,p=8$kPWnEwXj5x+MqzbPkGEXXQ$WNKF/FBuH1cJQcrPleY+OQ','2021-05-23 18:53:41','{\"friends\": []}','{\"friend_requests\": []}'),(9,'animesucks123','$argon2id$v=19$m=102400,t=2,p=8$IwbryezBQpDxiNXefta6hQ$vBwuC4yo1EFKQ8+jiWhg3w','2021-05-30 18:26:30','{\"friends\": [\"anime_is_cool_123\", \"testaccount\"]}','{\"friend_requests\": []}'),(10,'anime_is_cool_123','$argon2id$v=19$m=102400,t=2,p=8$Hls4SiM2c5YvEVQY2VC2jA$dutTYkvmKPyOE2l/OZvPqg','2021-05-30 18:27:35','{\"friends\": [\"animesucks123\"]}','{\"friend_requests\": []}');
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

-- Dump completed on 2021-05-30 18:42:44

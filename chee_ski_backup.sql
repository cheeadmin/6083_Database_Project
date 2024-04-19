-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

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
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `contactInfo` varchar(255) DEFAULT NULL,
  `paymentDetails` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Customer_user_id_b3dbf5c1` (`user_id`),
  CONSTRAINT `Customer_user_id_b3dbf5c1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (7,'Chee Hou','asdasd','9293864489','Cash',5),(8,'Chee Hou','Hon','9293864489','Cash',6),(18,'test_user3','test_user3','3332221111','Credit Card',7),(19,'test_user111','test_user111','1112223333','Credit Card',7),(21,'Chee Hou','Hon','9293864489','Credit Card',16);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `CustomerLessonBookings`
--

DROP TABLE IF EXISTS `CustomerLessonBookings`;
/*!50001 DROP VIEW IF EXISTS `CustomerLessonBookings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CustomerLessonBookings` AS SELECT 
 1 AS `customer_id`,
 1 AS `lessonID`,
 1 AS `difficultyLevel`,
 1 AS `duration`,
 1 AS `sport`,
 1 AS `age`,
 1 AS `bookingDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `DailyLessonCount`
--

DROP TABLE IF EXISTS `DailyLessonCount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DailyLessonCount` (
  `Date` date NOT NULL,
  `LessonCount` int DEFAULT '0',
  PRIMARY KEY (`Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DailyLessonCount`
--

LOCK TABLES `DailyLessonCount` WRITE;
/*!40000 ALTER TABLE `DailyLessonCount` DISABLE KEYS */;
INSERT INTO `DailyLessonCount` VALUES ('2024-04-02',1),('2024-04-05',1),('2024-04-07',1),('2024-04-08',1),('2024-04-09',2),('2024-04-10',1),('2024-04-12',1),('2024-04-16',2),('2024-04-23',1),('2024-04-26',1),('2024-05-01',1),('2024-05-03',1),('2024-05-17',1),('2024-05-21',1),('2024-06-11',1);
/*!40000 ALTER TABLE `DailyLessonCount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Equipment`
--

DROP TABLE IF EXISTS `Equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Equipment` (
  `equipmentID` int NOT NULL AUTO_INCREMENT,
  `Brand` varchar(45) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `typeID` int DEFAULT NULL,
  `Availability` tinyint(1) NOT NULL DEFAULT '1',
  `LastMaintenance` date DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`equipmentID`),
  KEY `fk_Equipment_EquipmentType1_idx` (`typeID`),
  CONSTRAINT `fk_Equipment_EquipmentType1` FOREIGN KEY (`typeID`) REFERENCES `EquipmentType` (`typeID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=505 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Equipment`
--

LOCK TABLES `Equipment` WRITE;
/*!40000 ALTER TABLE `Equipment` DISABLE KEYS */;
INSERT INTO `Equipment` VALUES (403,'Blizzard','Backcountry Ski Set',1,0,'2024-02-02',48.73,'161'),(404,'Burton','Freestyle Board',2,0,'2024-01-17',61.28,'155'),(405,'Nordica','Competition Grade Ski',1,0,'2024-02-19',89.24,'176'),(406,'Patagonia','Powder Snow Snowboard',2,0,'2024-02-06',74.21,'159'),(407,'Yonex','Pro Model Snowboard',2,0,'2024-03-14',68.78,'158'),(408,'Salomon','Competition Grade Ski',1,0,'2024-02-18',69.76,'181'),(409,'Armada','Youth Ski',1,0,'2024-01-22',60.38,'134'),(410,'Bataleon','Pro Model Snowboard',2,0,'2024-03-31',60.51,'141'),(411,'Dakine','Recreational Snowboard',2,0,'2024-02-03',62.02,'140'),(412,'Atomic','Competition Grade Ski',1,0,'2024-03-04',69.15,'149'),(413,'Patagonia','Freestyle Board',2,0,'2024-01-10',48.78,'158'),(414,'Armada','Pro Model Ski',1,0,'2024-02-29',59.63,'161'),(415,'Jones','Freestyle Board',2,0,'2024-01-03',66.43,'148'),(416,'Rossignol','Backcountry Ski Set',1,0,'2024-02-23',80.44,'180'),(417,'Nordica','Competition Grade Ski',1,0,'2024-03-13',60.57,'185'),(418,'K2 Sports','Advanced Freeride Ski',1,0,'2024-02-26',47.47,'168'),(419,'Jones','Competition Grade Snowboard',2,0,'2024-03-25',86.63,'157'),(420,'Crapsack','All Mountain Snowboard',2,0,'2024-01-04',80.46,'161'),(421,'Nordica','Recreational Ski',1,0,'2024-01-12',60.51,'184'),(422,'Yonex','Advanced Freeride Board',2,0,'2024-01-25',45.43,'158'),(423,'Volkl','Freestyle Ski',1,0,'2024-02-10',78.39,'182'),(424,'Volkl','Park & Pipe Ski',1,0,'2024-03-08',52.33,'186'),(425,'Atomic','Youth Ski',1,0,'2024-01-02',65.59,'135'),(426,'Nordica','Youth Ski',1,0,'2024-01-02',49.89,'161'),(427,'Rossignol','Recreational Ski',1,0,'2024-02-01',63.83,'137'),(428,'Nidecker','Youth Snowboard',2,0,'2024-03-22',50.28,'162'),(429,'Armada','Youth Ski',1,0,'2024-03-17',73.68,'168'),(430,'K2 Sports','Freestyle Ski',1,0,'2024-03-09',63.48,'169'),(431,'Salomon','Youth Ski',1,0,'2024-01-14',89.87,'161'),(432,'Bataleon','Freestyle Board',2,0,'2024-02-06',83.95,'160'),(433,'K2 Sports','Youth Ski',1,0,'2024-03-03',54.89,'137'),(434,'Volkl','Competition Grade Ski',1,0,'2024-02-04',65.70,'156'),(435,'Blizzard','Competition Grade Ski',1,0,'2024-03-26',81.88,'167'),(436,'Bataleon','Backcountry Snowboard Set',2,0,'2024-02-20',87.79,'159'),(437,'Rossignol','Pro Model Ski',1,0,'2024-03-26',57.46,'148'),(438,'Atomic','Competition Grade Ski',1,0,'2024-03-13',72.13,'178'),(439,'Nordica','Youth Ski',1,0,'2024-03-17',89.17,'143'),(440,'Dakine','Competition Grade Snowboard',2,0,'2024-02-19',47.13,'155'),(441,'Volkl','Pro Model Ski',1,0,'2024-01-11',59.64,'181'),(442,'Bataleon','Competition Grade Snowboard',2,0,'2024-02-16',46.03,'149'),(443,'Atomic','Pro Model Ski',1,0,'2024-01-03',42.00,'161'),(444,'Patagonia','Backcountry Snowboard Set',2,0,'2024-02-20',73.88,'149'),(445,'Patagonia','Competition Grade Snowboard',2,0,'2024-03-18',42.90,'155'),(446,'Blizzard','Pro Model Ski',1,1,'2024-03-02',52.67,'183'),(447,'Bataleon','Recreational Snowboard',2,0,'2024-01-09',53.30,'158'),(448,'Nordica','Park & Pipe Ski',1,0,'2024-01-16',75.42,'145'),(449,'Yonex','Powder Snow Snowboard',2,1,'2024-02-03',71.17,'162'),(450,'Salomon','Advanced Freeride Ski',1,1,'2024-02-19',56.56,'182'),(451,'Patagonia','Recreational Snowboard',2,0,'2024-01-15',67.12,'140'),(452,'Nidecker','Competition Grade Snowboard',2,1,'2024-02-03',84.98,'155'),(453,'Armada','Competition Grade Ski',1,0,'2024-02-06',66.54,'153'),(454,'Patagonia','Pro Model Snowboard',2,0,'2024-02-04',75.31,'147'),(455,'Salomon','Recreational Ski',1,0,'2024-03-02',78.71,'180'),(456,'CamelBak','Youth Snowboard',2,0,'2024-02-05',70.27,'162'),(457,'Armada','Pro Model Ski',1,0,'2024-01-09',66.31,'156'),(458,'Capita','Park & Pipe Snowboard',2,0,'2024-01-11',77.20,'162'),(459,'Burton','Advanced Freeride Board',2,0,'2024-03-11',47.36,'142'),(460,'K2 Sports','Youth Ski',1,0,'2024-02-13',68.21,'193'),(461,'Rossignol','Competition Grade Ski',1,1,'2024-01-23',74.71,'160'),(462,'Jones','All Mountain Snowboard',2,0,'2024-03-28',67.36,'146'),(463,'Capita','Backcountry Snowboard Set',2,0,'2024-01-19',71.62,'153'),(464,'Yonex','Youth Snowboard',2,0,'2024-03-01',65.47,'160'),(465,'Nordica','All Mountain Ski',1,0,'2024-02-16',63.87,'181'),(466,'Salomon','Youth Ski',1,0,'2024-01-06',82.61,'158'),(467,'CamelBak','Park & Pipe Snowboard',2,0,'2024-04-01',66.32,'151'),(468,'Volkl','Park & Pipe Ski',1,0,'2024-02-19',71.69,'177'),(469,'Bataleon','Advanced Freeride Board',2,0,'2024-01-16',48.08,'149'),(470,'Atomic','Powder Snow Ski',1,0,'2024-03-06',54.52,'157'),(471,'Rossignol','Recreational Ski',1,0,'2024-03-05',57.12,'178'),(472,'Nordica','Freestyle Ski',1,0,'2024-03-06',46.45,'177'),(473,'Dakine','Backcountry Snowboard Set',2,0,'2024-03-14',79.67,'152'),(474,'Volkl','Competition Grade Ski',1,1,'2024-03-07',66.89,'156'),(475,'Salomon','Recreational Ski',1,0,'2024-02-09',73.86,'184'),(476,'Capita','Competition Grade Snowboard',2,0,'2024-02-26',42.99,'159'),(477,'Jones','Freestyle Board',2,0,'2024-01-08',56.54,'154'),(478,'CamelBak','Recreational Snowboard',2,0,'2024-01-04',51.33,'140'),(479,'Salomon','Recreational Ski',1,0,'2024-03-27',55.72,'164'),(480,'Burton','Advanced Freeride Board',2,0,'2024-04-01',65.06,'140'),(481,'Dakine','Pro Model Snowboard',2,0,'2024-01-31',72.04,'148'),(482,'Patagonia','Powder Snow Snowboard',2,0,'2024-01-20',42.97,'160'),(483,'Nidecker','Backcountry Snowboard Set',2,1,'2024-03-13',54.23,'154'),(484,'Yonex','Competition Grade Snowboard',2,1,'2024-01-05',61.05,'140'),(485,'Crapsack','Recreational Snowboard',2,0,'2024-02-04',61.82,'159'),(486,'Capita','Recreational Snowboard',2,0,'2024-02-18',84.91,'156'),(487,'Dakine','All Mountain Snowboard',2,0,'2024-02-22',85.32,'153'),(488,'Dakine','Competition Grade Snowboard',2,0,'2024-02-15',43.15,'142'),(489,'CamelBak','Recreational Snowboard',2,1,'2024-03-05',75.83,'160'),(490,'Jones','Advanced Freeride Board',2,1,'2024-03-03',89.04,'154'),(491,'Rossignol','Pro Model Ski',1,0,'2024-02-19',85.05,'135'),(492,'Jones','Park & Pipe Snowboard',2,0,'2024-02-19',48.88,'155'),(493,'Bataleon','Backcountry Snowboard Set',2,1,'2024-03-24',89.16,'148'),(494,'Bataleon','Freestyle Board',2,1,'2024-03-05',88.40,'158'),(495,'Volkl','Recreational Ski',1,0,'2024-03-23',40.11,'151'),(496,'Salomon','Pro Model Ski',1,1,'2024-01-11',82.51,'156'),(497,'Yonex','Recreational Snowboard',2,1,'2024-03-17',48.09,'146'),(498,'Patagonia','All Mountain Snowboard',2,0,'2024-03-22',76.01,'145'),(499,'Bataleon','Advanced Freeride Board',2,0,'2024-01-20',71.46,'146'),(500,'Nidecker','Recreational Snowboard',2,1,'2024-01-21',66.59,'150'),(501,'Jones1','asdasdas',1,0,'2024-04-17',111.00,'111'),(504,'112233','112233',1,1,'2024-04-11',11.00,'112233');
/*!40000 ALTER TABLE `Equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EquipmentMaintenance`
--

DROP TABLE IF EXISTS `EquipmentMaintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EquipmentMaintenance` (
  `maintenanceID` int NOT NULL AUTO_INCREMENT,
  `maintenanceDate` date DEFAULT NULL,
  `maintenanceType` varchar(100) DEFAULT NULL,
  `equipmentID` int NOT NULL,
  PRIMARY KEY (`maintenanceID`,`equipmentID`),
  KEY `fk_EquipmentMaintenance_Equipment1_idx` (`equipmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EquipmentMaintenance`
--

LOCK TABLES `EquipmentMaintenance` WRITE;
/*!40000 ALTER TABLE `EquipmentMaintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `EquipmentMaintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EquipmentType`
--

DROP TABLE IF EXISTS `EquipmentType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EquipmentType` (
  `typeID` int NOT NULL,
  `typeName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EquipmentType`
--

LOCK TABLES `EquipmentType` WRITE;
/*!40000 ALTER TABLE `EquipmentType` DISABLE KEYS */;
INSERT INTO `EquipmentType` VALUES (1,'Ski'),(2,'Snowboard');
/*!40000 ALTER TABLE `EquipmentType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Instructors`
--

DROP TABLE IF EXISTS `Instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Instructors` (
  `instructorID` int NOT NULL AUTO_INCREMENT,
  `staffID` int DEFAULT NULL,
  PRIMARY KEY (`instructorID`),
  KEY `Instructors_staffID_5a7ff981_fk_Staff_staffID` (`staffID`),
  CONSTRAINT `Instructors_staffID_5a7ff981_fk_Staff_staffID` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Instructors`
--

LOCK TABLES `Instructors` WRITE;
/*!40000 ALTER TABLE `Instructors` DISABLE KEYS */;
INSERT INTO `Instructors` VALUES (11,22),(12,23),(14,27),(15,29),(16,31),(17,33),(18,35),(19,37),(20,39),(21,41),(22,43);
/*!40000 ALTER TABLE `Instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LessonBookings`
--

DROP TABLE IF EXISTS `LessonBookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LessonBookings` (
  `bookingID` int NOT NULL AUTO_INCREMENT,
  `bookingDate` date DEFAULT NULL,
  `customer_id` int NOT NULL,
  `instructor_id` int DEFAULT NULL,
  `lesson_id` int NOT NULL,
  PRIMARY KEY (`bookingID`),
  KEY `fk_LessonBookings_Customer1_idx` (`customer_id`),
  KEY `fk_LessonBookings_Instructors1_idx` (`instructor_id`),
  KEY `fk_LessonBookings_Lessons1_idx` (`lesson_id`),
  CONSTRAINT `LessonBookings_instructor_id_bb658942_fk_Instructo` FOREIGN KEY (`instructor_id`) REFERENCES `Instructors` (`instructorID`),
  CONSTRAINT `LessonBookings_lesson_id_5adb90ce_fk_Lessons_lessonID` FOREIGN KEY (`lesson_id`) REFERENCES `Lessons` (`lessonID`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LessonBookings`
--

LOCK TABLES `LessonBookings` WRITE;
/*!40000 ALTER TABLE `LessonBookings` DISABLE KEYS */;
INSERT INTO `LessonBookings` VALUES (43,'2024-04-04',5,20,5),(44,'2024-04-11',6,14,3),(45,'2024-04-08',6,16,4),(46,'2024-04-04',5,17,4),(47,'2024-04-05',5,16,5),(52,'2024-04-07',8,20,5),(53,'2024-04-02',8,16,8),(54,'2024-04-09',8,18,4),(55,'2024-04-10',8,20,7),(64,'2024-05-03',21,19,4),(66,'2024-05-01',21,19,3),(67,'2024-06-11',21,20,4);
/*!40000 ALTER TABLE `LessonBookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AfterLessonBooking` AFTER INSERT ON `LessonBookings` FOR EACH ROW BEGIN
  IF EXISTS (SELECT * FROM DailyLessonCount WHERE Date = NEW.bookingDate) THEN
    UPDATE DailyLessonCount 
    SET LessonCount = LessonCount + 1 
    WHERE Date = NEW.bookingDate;
  ELSE
    INSERT INTO DailyLessonCount (Date, LessonCount) VALUES (NEW.bookingDate, 1);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `LogLessonCancellation` AFTER DELETE ON `LessonBookings` FOR EACH ROW BEGIN
    INSERT INTO `LessonCancellationLog` (`bookingID`, `cancellationDate`, `reason`)
    VALUES (OLD.`bookingID`, CURDATE(), 'Cancelled by customer');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LessonCancellationLog`
--

DROP TABLE IF EXISTS `LessonCancellationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LessonCancellationLog` (
  `logID` int NOT NULL AUTO_INCREMENT,
  `bookingID` int DEFAULT NULL,
  `cancellationDate` date DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`logID`),
  KEY `LessonCancellationLog_ibfk_1` (`bookingID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LessonCancellationLog`
--

LOCK TABLES `LessonCancellationLog` WRITE;
/*!40000 ALTER TABLE `LessonCancellationLog` DISABLE KEYS */;
INSERT INTO `LessonCancellationLog` VALUES (31,61,'2024-04-18','Cancelled by customer'),(32,62,'2024-04-18','Cancelled by customer'),(33,63,'2024-04-18','Cancelled by customer'),(34,56,'2024-04-19','Cancelled by customer'),(35,65,'2024-04-19','Cancelled by customer');
/*!40000 ALTER TABLE `LessonCancellationLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lessons`
--

DROP TABLE IF EXISTS `Lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lessons` (
  `lessonID` int NOT NULL AUTO_INCREMENT,
  `difficultyLevel` varchar(50) DEFAULT NULL,
  `duration` varchar(8) DEFAULT NULL,
  `sport` varchar(10) DEFAULT NULL,
  `age` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`lessonID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lessons`
--

LOCK TABLES `Lessons` WRITE;
/*!40000 ALTER TABLE `Lessons` DISABLE KEYS */;
INSERT INTO `Lessons` VALUES (3,'Expert','Half Day','Ski','Adult'),(4,'Beginner','Full Day','Snowboard','Adult'),(5,'Intermediate','Half Day','Snowboard','Adult'),(6,'Expert','Full Day','Snowboard','Adult'),(7,'Beginner','Half Day','Ski','Kid'),(8,'Intermediate','Full Day','Ski','Kid'),(9,'Expert','Half Day','Ski','Kid'),(10,'Beginner','Full Day','Snowboard','Kid'),(11,'Intermediate','Half Day','Snowboard','Kid'),(12,'Expert','Full Day','Snowboard','Kid'),(14,'Beginner','Half Day','Ski','Adult');
/*!40000 ALTER TABLE `Lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `MonthlyRentalRevenue`
--

DROP TABLE IF EXISTS `MonthlyRentalRevenue`;
/*!50001 DROP VIEW IF EXISTS `MonthlyRentalRevenue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `MonthlyRentalRevenue` AS SELECT 
 1 AS `Month`,
 1 AS `RentalRevenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Rental`
--

DROP TABLE IF EXISTS `Rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rental` (
  `rentalID` int NOT NULL AUTO_INCREMENT,
  `rentalDate` date DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `equipmentID` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  PRIMARY KEY (`rentalID`),
  KEY `fk_Rental_Equipment1_idx` (`equipmentID`),
  KEY `fk_Rental_Customer1_idx` (`customerId`),
  CONSTRAINT `fk_Rental_Equipment1` FOREIGN KEY (`equipmentID`) REFERENCES `Equipment` (`equipmentID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rental`
--

LOCK TABLES `Rental` WRITE;
/*!40000 ALTER TABLE `Rental` DISABLE KEYS */;
INSERT INTO `Rental` VALUES (4,'2024-04-09','2024-04-10',59.64,441,8),(10,'2024-04-16','2024-04-17',68.78,407,10),(11,'2024-04-16','2024-04-17',47.13,440,10),(12,'2024-04-16','2024-04-17',46.03,442,10),(13,'2024-04-16','2024-04-17',47.36,459,10),(14,'2024-04-16','2024-04-17',56.54,477,10),(15,'2024-04-17','2024-04-18',50.28,428,10),(16,'2024-04-17','2024-04-18',73.88,444,10),(17,'2024-04-17','2024-04-18',75.31,454,10),(18,'2024-04-17','2024-04-18',66.32,467,10),(19,'2024-04-17','2024-04-18',83.95,432,10),(21,'2024-04-18','2024-04-19',57.12,471,21),(22,'2024-04-19','2024-04-20',63.87,465,21),(23,'2024-04-19','2024-04-20',71.62,463,21),(24,'2024-04-19','2024-04-20',48.08,469,21),(25,'2024-04-19','2024-04-20',65.06,480,21),(26,'2024-04-19','2024-04-20',61.82,485,21),(27,'2024-04-19','2024-04-20',85.32,487,21),(28,'2024-04-19','2024-04-20',73.86,475,21);
/*!40000 ALTER TABLE `Rental` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `staffID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `contactDetails` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`staffID`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `Staff_user_id_e5c5c721_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (22,'Chee Hou','Hon','Instructor','asdasdasdasd@gagasfasfs',14),(23,'asdasdasdas','asdasdasda','Instructor','123123123',15),(24,'John','Doe','associate','john.doe@example.com',NULL),(26,'Mike','Smith','associate','mike.smith@example.com',NULL),(27,'Anna','Brown','instructor','anna.brown@example.com',NULL),(28,'Chris','Davis','associate','chris.davis@example.com',NULL),(29,'Patricia','Martinez','instructor','patricia.martinez@example.com',NULL),(30,'Linda','Garcia','associate','linda.garcia@example.com',NULL),(31,'Barbara','Wilson','instructor','barbara.wilson@example.com',NULL),(32,'Elizabeth','Anderson','associate','elizabeth.anderson@example.com',NULL),(33,'Jennifer','Taylor','instructor','jennifer.taylor@example.com',NULL),(34,'Maria','Thomas','associate','maria.thomas@example.com',NULL),(35,'Susan','Hernandez','instructor','susan.hernandez@example.com',NULL),(36,'Margaret','Moore','associate','margaret.moore@example.com',NULL),(37,'Dorothy','Jackson','instructor','dorothy.jackson@example.com',NULL),(38,'Lisa','Martin','associate','lisa.martin@example.com',NULL),(39,'Nancy','Lee','instructor','nancy.lee@example.com',NULL),(40,'Karen','Perez','associate','karen.perez@example.com',NULL),(41,'Betty','Thompson','instructor','betty.thompson@example.com',NULL),(42,'Helen','White','associate','helen.white@example.com',NULL),(43,'Sandra','Harris','instructor','sandra.harris@example.com',NULL);
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add customer',7,'add_customer'),(26,'Can change customer',7,'change_customer'),(27,'Can delete customer',7,'delete_customer'),(28,'Can view customer',7,'view_customer'),(29,'Can add equipment type',8,'add_equipmenttype'),(30,'Can change equipment type',8,'change_equipmenttype'),(31,'Can delete equipment type',8,'delete_equipmenttype'),(32,'Can view equipment type',8,'view_equipmenttype'),(33,'Can add rental',9,'add_rental'),(34,'Can change rental',9,'change_rental'),(35,'Can delete rental',9,'delete_rental'),(36,'Can view rental',9,'view_rental'),(37,'Can add equipment',10,'add_equipment'),(38,'Can change equipment',10,'change_equipment'),(39,'Can delete equipment',10,'delete_equipment'),(40,'Can view equipment',10,'view_equipment'),(41,'Can add instructor',11,'add_instructor'),(42,'Can change instructor',11,'change_instructor'),(43,'Can delete instructor',11,'delete_instructor'),(44,'Can view instructor',11,'view_instructor'),(45,'Can add lesson',12,'add_lesson'),(46,'Can change lesson',12,'change_lesson'),(47,'Can delete lesson',12,'delete_lesson'),(48,'Can view lesson',12,'view_lesson'),(49,'Can add staff',13,'add_staff'),(50,'Can change staff',13,'change_staff'),(51,'Can delete staff',13,'delete_staff'),(52,'Can view staff',13,'view_staff'),(53,'Can add lesson booking',14,'add_lessonbooking'),(54,'Can change lesson booking',14,'change_lessonbooking'),(55,'Can delete lesson booking',14,'delete_lessonbooking'),(56,'Can view lesson booking',14,'view_lessonbooking'),(57,'Can add customer',15,'add_customer'),(58,'Can change customer',15,'change_customer'),(59,'Can delete customer',15,'delete_customer'),(60,'Can view customer',15,'view_customer'),(61,'Can add staff',16,'add_staff'),(62,'Can change staff',16,'change_staff'),(63,'Can delete staff',16,'delete_staff'),(64,'Can view staff',16,'view_staff'),(65,'Can add equipment',17,'add_equipment'),(66,'Can change equipment',17,'change_equipment'),(67,'Can delete equipment',17,'delete_equipment'),(68,'Can view equipment',17,'view_equipment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (5,'pbkdf2_sha256$720000$zW4rKBmOMRstZTPaiRp4lS$lgSlvBV+DAoSwEl6QWOCwBfA73QQnP9Jhr2/WqE+n34=','2024-04-19 17:34:53.247462',0,'cheehon2','','','cheehouhon@gmail.com',0,1,'2024-03-26 03:45:30.652675'),(6,'pbkdf2_sha256$720000$KZ84sd3qrpnhHP6d6loJYE$G1VRUHiQP+rbmqbjb7tpV8i0AN9xG/BdFJQNZNBVOfI=','2024-04-18 01:22:46.022129',0,'cheehon3','','','honcheehou@gmail.com',0,1,'2024-03-26 03:48:18.169356'),(7,'pbkdf2_sha256$720000$YT89aqnmUr2aRsddYBAfJL$evEIcin/siH/cIPyjkAsd0fRbaulBbCvuMYhiEfGCuA=','2024-04-06 03:39:57.689372',0,'test_user','','','test_user@gmail.com',0,1,'2024-04-06 03:38:40.034474'),(8,'pbkdf2_sha256$720000$7zVezgMGFZDQvrqk0v1OwS$zvaFVBGcbFv3y9rK/ibKIBexvNSD9SwGjNALbLThPJ8=','2024-04-19 17:16:02.692222',1,'cheeadmin','','','cheehouhon@gmail.com',1,1,'2024-04-12 01:40:34.421162'),(13,'pbkdf2_sha256$720000$iLANGy0ake3F7iEfRHHpIM$WSdyekvP3Gz1799UldlssUEIAW4jAuiE0gf75zHAEyM=',NULL,0,'cheehonasdasdasd','CINDYasdasd','WANGasdasdasd','gasociashiop@gmail.com',1,1,'2024-04-13 17:18:21.000000'),(14,'pbkdf2_sha256$720000$yrf3ZUGgnIElLn6tRxLPtB$kW5Mfb2WlwoD25vExR7YMlEHAmY5sIqrJ+KeWlX3nAA=','2024-04-13 18:37:16.585616',0,'cheeadmin222a','Chee Hou','Hon','asdasdasdasd@gagasfasfs',1,1,'2024-04-13 18:37:09.000000'),(15,'pbkdf2_sha256$720000$Lmplq8Xx3oDeng3YH5Kfgd$nXwODhYqmt7/flvbUMlGXmP5cG0NpkXNK+53Pt04hfw=','2024-04-15 02:00:42.069884',0,'cheeadmin2222','asdasdasdas','asdasdasda','123123123@asdasd',1,1,'2024-04-13 18:44:56.000000'),(16,'pbkdf2_sha256$720000$5NKLtknSOxD6OrSNohW2hJ$0UhR/CbMafvJp5A0xjVSLUUq3k5HKDmci03VCzmVu/g=','2024-04-19 14:07:32.605536',0,'cheehon','','','cheehon@asda.com',0,1,'2024-04-18 01:34:22.097858');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chee_equipment_equipment`
--

DROP TABLE IF EXISTS `chee_equipment_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chee_equipment_equipment` (
  `equipmentID` int NOT NULL AUTO_INCREMENT,
  `brand` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `typeID` int DEFAULT NULL,
  `availability` tinyint(1) NOT NULL,
  `lastMaintenance` date DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`equipmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chee_equipment_equipment`
--

LOCK TABLES `chee_equipment_equipment` WRITE;
/*!40000 ALTER TABLE `chee_equipment_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `chee_equipment_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chee_lessons_customer`
--

DROP TABLE IF EXISTS `chee_lessons_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chee_lessons_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chee_lessons_customer_user_id_fcd38713_fk_auth_user_id` (`user_id`),
  CONSTRAINT `chee_lessons_customer_user_id_fcd38713_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chee_lessons_customer`
--

LOCK TABLES `chee_lessons_customer` WRITE;
/*!40000 ALTER TABLE `chee_lessons_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `chee_lessons_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chee_rental_equipment`
--

DROP TABLE IF EXISTS `chee_rental_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chee_rental_equipment` (
  `equipmentID` int NOT NULL AUTO_INCREMENT,
  `Brand` varchar(45) DEFAULT NULL,
  `Condition` varchar(45) DEFAULT NULL,
  `typeID_id` int DEFAULT NULL,
  PRIMARY KEY (`equipmentID`),
  KEY `chee_rental_equipmen_typeID_id_28a9301c_fk_chee_rent` (`typeID_id`),
  CONSTRAINT `chee_rental_equipmen_typeID_id_28a9301c_fk_chee_rent` FOREIGN KEY (`typeID_id`) REFERENCES `chee_rental_equipmenttype` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chee_rental_equipment`
--

LOCK TABLES `chee_rental_equipment` WRITE;
/*!40000 ALTER TABLE `chee_rental_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `chee_rental_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chee_rental_equipmenttype`
--

DROP TABLE IF EXISTS `chee_rental_equipmenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chee_rental_equipmenttype` (
  `typeID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chee_rental_equipmenttype`
--

LOCK TABLES `chee_rental_equipmenttype` WRITE;
/*!40000 ALTER TABLE `chee_rental_equipmenttype` DISABLE KEYS */;
/*!40000 ALTER TABLE `chee_rental_equipmenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chee_rental_rental`
--

DROP TABLE IF EXISTS `chee_rental_rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chee_rental_rental` (
  `rentalID` int NOT NULL AUTO_INCREMENT,
  `rentalDate` date NOT NULL,
  `returnDate` date NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `customerId_id` bigint DEFAULT NULL,
  `equipmentID_id` int DEFAULT NULL,
  PRIMARY KEY (`rentalID`),
  KEY `chee_rental_rental_customerId_id_c378e1fd_fk_Customer_id` (`customerId_id`),
  KEY `chee_rental_rental_equipmentID_id_7444465f_fk_chee_rent` (`equipmentID_id`),
  CONSTRAINT `chee_rental_rental_customerId_id_c378e1fd_fk_Customer_id` FOREIGN KEY (`customerId_id`) REFERENCES `Customer` (`id`),
  CONSTRAINT `chee_rental_rental_equipmentID_id_7444465f_fk_chee_rent` FOREIGN KEY (`equipmentID_id`) REFERENCES `chee_rental_equipment` (`equipmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chee_rental_rental`
--

LOCK TABLES `chee_rental_rental` WRITE;
/*!40000 ALTER TABLE `chee_rental_rental` DISABLE KEYS */;
/*!40000 ALTER TABLE `chee_rental_rental` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-04-18 01:34:00.599771','4','cheehon',3,'',4,8);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(17,'chee_equipment','equipment'),(7,'chee_home','customer'),(16,'chee_home','staff'),(15,'chee_lessons','customer'),(11,'chee_lessons','instructor'),(12,'chee_lessons','lesson'),(14,'chee_lessons','lessonbooking'),(13,'chee_lessons','staff'),(10,'chee_rental','equipment'),(8,'chee_rental','equipmenttype'),(9,'chee_rental','rental'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-03-13 23:37:58.906519'),(2,'auth','0001_initial','2024-03-13 23:37:59.924523'),(3,'admin','0001_initial','2024-03-13 23:38:00.095945'),(4,'admin','0002_logentry_remove_auto_add','2024-03-13 23:38:00.107378'),(5,'admin','0003_logentry_add_action_flag_choices','2024-03-13 23:38:00.117001'),(6,'contenttypes','0002_remove_content_type_name','2024-03-13 23:38:00.210138'),(7,'auth','0002_alter_permission_name_max_length','2024-03-13 23:38:00.279636'),(8,'auth','0003_alter_user_email_max_length','2024-03-13 23:38:00.357195'),(9,'auth','0004_alter_user_username_opts','2024-03-13 23:38:00.366926'),(10,'auth','0005_alter_user_last_login_null','2024-03-13 23:38:00.420986'),(11,'auth','0006_require_contenttypes_0002','2024-03-13 23:38:00.425888'),(12,'auth','0007_alter_validators_add_error_messages','2024-03-13 23:38:00.436475'),(13,'auth','0008_alter_user_username_max_length','2024-03-13 23:38:00.504943'),(14,'auth','0009_alter_user_last_name_max_length','2024-03-13 23:38:00.583896'),(15,'auth','0010_alter_group_name_max_length','2024-03-13 23:38:00.650947'),(16,'auth','0011_update_proxy_permissions','2024-03-13 23:38:00.662184'),(17,'auth','0012_alter_user_first_name_max_length','2024-03-13 23:38:00.744381'),(18,'sessions','0001_initial','2024-03-13 23:38:00.790986'),(19,'chee_home','0001_initial','2024-03-26 01:26:22.757031'),(20,'chee_home','0002_alter_customer_user','2024-03-26 01:59:30.602678'),(21,'chee_rental','0001_initial','2024-03-31 23:48:22.010145'),(22,'chee_lessons','0001_initial','2024-04-07 19:48:25.294664'),(23,'chee_lessons','0002_staff_instructor_staff','2024-04-07 19:56:50.549745'),(24,'chee_lessons','0003_remove_lesson_price_lesson_duration_lesson_sport','2024-04-07 22:59:41.226963'),(25,'chee_lessons','0004_remove_lesson_description_lesson_age','2024-04-07 23:15:46.943462'),(26,'chee_lessons','0005_lessonbooking','2024-04-09 01:51:50.027038'),(27,'chee_lessons','0006_alter_lessonbooking_customer_and_more','2024-04-09 01:55:51.123035'),(28,'chee_lessons','0007_alter_lessonbooking_customer_and_more','2024-04-09 02:01:10.522331'),(29,'chee_lessons','0008_alter_lessonbooking_bookingdate_and_more','2024-04-09 03:21:52.273513'),(30,'chee_lessons','0009_alter_lessonbooking_customer_and_more','2024-04-09 03:23:11.390915'),(31,'chee_lessons','0010_customer','2024-04-09 03:33:55.542214'),(32,'chee_home','0003_staff','2024-04-12 01:40:17.107729'),(33,'chee_home','0004_delete_staff','2024-04-12 02:41:40.921662'),(34,'chee_lessons','0007_staff_user','2024-04-12 02:45:19.302979'),(35,'chee_equipment','0001_initial','2024-04-14 18:41:25.559928');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('69poh68xakq85e7yk4ubyy1iixuagb92','e30:1robPd:7uteydwe-T51rVS4w1vdxg3zI5DrlWTQOcAYtoIbghU','2024-04-08 03:54:17.513827'),('928vx50qhql6gj26hxoje6aws9nxbnh6','.eJxVjDsOwyAQBe9CHSGxgDEu0-cMaPlscBLZEuDK8t2DJRdJOzPv7czh1rLbaipujmximt1-mcfwTssp4guX58rDurQye34m_LKVP9aYPver_TvIWHNfQ4x2IEE2BmkNgDFkUGlLxhNYHWwQ0JGUCrRW5CEZFAoI5JBGP6Z-GrA0Nu3H8QUaojro:1rxs8l:mQfhCLrfKD1svRmduhLwdKIe1QvHJuKcWDNXx8eHJ7Q','2024-05-03 17:35:11.800843'),('c0ya1sod6gwb7jdck8dlhko4xr1znxgy','.eJxVjbsOgzAMRf_FM4pCSCAwVl069BuQ7biFtgLEY6gQ_94gMdDJ0j3nXq9Q4zI39TLJWLcBKrCQnDNCfku3g_DC7tkr7rt5bEntijropO59kM_lcP8GGpya2EZrSDLvUx2wzFkCpUYXVFJOzmLMS3KP1GeFZi4pFIYLEQ5svHeeHcZRxnGGagXr9H7m7yC3K1RpAsPYssQnLlcuhy0Ba_xZMSdFq8i2bfsBsM1OBg:1rwaEp:PxeIQ_xljO3sx_Ib3m61kAmTbsmanjB-ex1udcI6Iz8','2024-04-30 04:16:07.742958'),('ce63sq9czo50255gtck4kpql964d30b4','.eJxVjEEOwiAQRe_C2pAwQCku3XsGMjCMVA0kpV013t026UK3773_NxFwXUpYe57DROIqrLj8sojplesh6In10WRqdZmnKI9EnrbLe6P8vp3t30HBXvY1EPmBFXtK2jsA59ihsZ5dZPA2-aRgR1obsNZwhOxQGWDQQx7jmMXnC9-xN5w:1rxCq1:aeHJnkbB4RKKUTJIk8-jOIfrAFgLmx45c1666I0PZcs','2024-05-01 21:29:05.004310'),('clcv2hu5kmduhue2yzssqkzmmpf73vmd','.eJxVjEEOwiAQRe_C2pAwQCku3XsGMjCMVA0kpV013t026UK3773_NxFwXUpYe57DROIqrLj8sojplesh6In10WRqdZmnKI9EnrbLe6P8vp3t30HBXvY1EPmBFXtK2jsA59ihsZ5dZPA2-aRgR1obsNZwhOxQGWDQQx7jmMXnC9-xN5w:1rvhEN:MrszAC9RS4z7V8pHfB4q2z3Qmd7Abj-qaC8AeqvnuEA','2024-04-27 17:31:59.548764'),('gzbibfda65u400717t2iqmvg14wspwig','.eJxVjDsOwyAQRO9CHSFgjWFTpvcZ0PILTiKQjF1FuXtsyUVSzrw382aOtrW4rafFzZFdGbDLb-cpPFM9QHxQvTceWl2X2fND4SftfGoxvW6n-3dQqJd9PYphIEIJpCGmrCyoPWeyApIxEjH4DEpLbXC0JktvLMaMwXotrMLIPl_R_Tde:1robv9:naLPj3KFp_4bNjmoXe2XJq7oHIRrp3WcxdL6mysoVuE','2024-04-08 04:26:51.125797'),('n07kcddn91tiuwcsc2jjqvmtstxep7ub','.eJxVjDkOwjAUBe_iGlmxE8fflPScIfobOIBsKUuFuDuJlALamXnvbQZclzyss07DKOZsOnP6ZYT81LILeWC5V8u1LNNIdk_sYWd7raKvy9H-HWSc87bGzpO2AK4RTD2rkPNNpEQ9hQ43nijcHLSxYU4k0XNUZWEPEIADms8X8P84aw:1rvj5u:hieyLfUxHQSCT_RYL9dZ8Dnd76YysiIWfS72kuiS8Fk','2024-04-27 19:31:22.448251'),('nkqw3zkwguufe0gcaa14yg7rvl1tr3b7','.eJxVjDkOgzAUBe_iOrKMbb6BMn3OgP5iB5LIllgqxN0DEkXSzsx7m-pxXYZ-nePUj6I6VYG6_UJCfsd8GnlhfhbNJS_TSPpM9GVn_SgSP_er_TsYcB6ONaBrjIdIMYTgDaXaJ1e10SCDPZCpxSaoHLViQ-PZkW8xJStAjon8cco4Larb9v0LNp07Vw:1rxf2Z:96IHosgiyAGr-SzUDvuiaK0H638IMzQlpqDSP4B2h1E','2024-05-03 03:35:55.736477'),('pi1brml1mdpwi54oi10bk0ku63vygg1n','.eJxVjEEOwiAQRe_C2pAwQCku3XsGMjCMVA0kpV013t026UK3773_NxFwXUpYe57DROIqrLj8sojplesh6In10WRqdZmnKI9EnrbLe6P8vp3t30HBXvY1EPmBFXtK2jsA59ihsZ5dZPA2-aRgR1obsNZwhOxQGWDQQx7jmMXnC9-xN5w:1rwqNF:DHZpkHlzXS3Xx5N2ITogSD6MB4u8b3IjWTFIvi7l6A4','2024-04-30 21:29:53.880637'),('q32v1n2ci7i3w1q488r5lt464x3dap6f','.eJxVjDsOwjAQBe_iGlmxsRObkp4zRM-7axJAtpRPhbg7iZQC2jcz7616rMvQr7NM_cjqooxXp98xgZ5SdsIPlHvVVMsyjUnvij7orG-V5XU93L-DAfOw1SEypOkcBW4ynE2tIecCmxBTxNmJR0uZBb7rkgEaeLJZ7GaS5Bbq8wUkFzlK:1rwBeE:cNqbCxSWuagPoTjPRxX4mruO3P1QfaOMSpWWeP7PcHE','2024-04-29 02:00:42.078765'),('sjojmgyxg79sjzydm6geoxx5f56b3z9x','.eJxVjMsOwiAQRf-FtSEgDA-X7vsNZIBBqgaS0q6M_65NutDtPefcFwu4rTVsg5YwZ3Zhjp1-t4jpQW0H-Y7t1nnqbV3myHeFH3TwqWd6Xg_376DiqN9aFQDnjfEebSGVKRMBaCO1LjYWZSBpZQmSRBQSXEYltdc2CvRCniV7fwDhLDdT:1rw933:WOVok1vMza8qKBb9jZu0GyanvRWYtXlCoqm9PLnEkmw','2024-04-28 23:14:09.354825'),('v764b2xk5oub53t58e0gk8x2g2tf912u','.eJxVjMsOwiAQRf-FtSEgDA-X7vsNZIBBqgaS0q6M_65NutDtPefcFwu4rTVsg5YwZ3Zhjp1-t4jpQW0H-Y7t1nnqbV3myHeFH3TwqWd6Xg_376DiqN9aFQDnjfEebSGVKRMBaCO1LjYWZSBpZQmSRBQSXEYltdc2CvRCniV7fwDhLDdT:1rxrqE:jJsQ71sJhj__KjoHEN7JRYmptq_hj33RLLAZdHvEKgs','2024-05-03 17:16:02.700116'),('vttw6od8hep1q32qhsg4u4d8c2xvwzoo','e30:1robLB:GvMMjkfXungLux_qWFjPT4YRDObY2MYG9F4AebKgkMw','2024-04-08 03:49:41.623330'),('x4yqrtzbtjkngg84pygnhfcu93ovx2kv','e30:1robNr:jRa5gpw40JyiYrNwIsXuRIG3y2BscHtCiUkFlF2sef4','2024-04-08 03:52:27.178618'),('xatk1zi0uzn71440dq6zue3fafw7dkng','.eJxVjDkOgzAUBe_iOrKMbb6BMn3OgP5iB5LIllgqxN0DEkXSzsx7m-pxXYZ-nePUj6I6VYG6_UJCfsd8GnlhfhbNJS_TSPpM9GVn_SgSP_er_TsYcB6ONaBrjIdIMYTgDaXaJ1e10SCDPZCpxSaoHLViQ-PZkW8xJStAjon8cco4Larb9v0LNp07Vw:1rxJkL:2lVOKXepSU99GSyNPes53zwmDubw1Wh11rTk2Tii_d4','2024-05-02 04:51:41.520363'),('zszwfyu8ar16hhc5t2hqt5ptnx0zanmc','e30:1robOb:wY9Enqz8XgQE-YfcaS75ZgoVzXYedzUutPjmzdISAyw','2024-04-08 03:53:13.647382');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `CustomerLessonBookings`
--

/*!50001 DROP VIEW IF EXISTS `CustomerLessonBookings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `CustomerLessonBookings` AS select `lb`.`customer_id` AS `customer_id`,`l`.`lessonID` AS `lessonID`,`l`.`difficultyLevel` AS `difficultyLevel`,`l`.`duration` AS `duration`,`l`.`sport` AS `sport`,`l`.`age` AS `age`,`lb`.`bookingDate` AS `bookingDate` from (`LessonBookings` `lb` join `Lessons` `l` on((`lb`.`lesson_id` = `l`.`lessonID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MonthlyRentalRevenue`
--

/*!50001 DROP VIEW IF EXISTS `MonthlyRentalRevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `MonthlyRentalRevenue` AS select date_format(`Rental`.`rentalDate`,'%Y-%m') AS `Month`,sum(`Rental`.`Price`) AS `RentalRevenue` from `Rental` group by `Month` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-19 17:37:13

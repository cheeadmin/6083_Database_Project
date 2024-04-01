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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (7,'Chee Hou','asdasd','9293864489','Cash',5),(8,'Chee Hou','Hon','9293864489','Cash',6),(10,'Chee Hou','Hon','19293864489','Cash',4),(11,'Chee Hou','Hon','92938644891','Cash',4),(12,'Chee Hou','Hon','9294563864489','Cash',4),(13,'asdasd','asdasd','121212121','Cash',4);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Equipment`
--

LOCK TABLES `Equipment` WRITE;
/*!40000 ALTER TABLE `Equipment` DISABLE KEYS */;
INSERT INTO `Equipment` VALUES (301,'Jones','Powder Snow Snowboard',2,0,'2024-01-07',51.16,'153'),(302,'Patagonia','Pro Model Snowboard',2,0,'2024-01-03',78.78,'147'),(303,'Blizzard','Backcountry Ski Set',1,0,'2024-02-02',48.73,'161'),(304,'Burton','Freestyle Board',2,1,'2024-01-17',61.28,'155'),(305,'Nordica','Competition Grade Ski',1,0,'2024-02-19',89.24,'176'),(306,'Patagonia','Powder Snow Snowboard',2,1,'2024-02-06',74.21,'159'),(307,'Yonex','Pro Model Snowboard',2,1,'2024-03-14',68.78,'158'),(308,'Salomon','Competition Grade Ski',1,0,'2024-02-18',69.76,'181'),(309,'Armada','Youth Ski',1,0,'2024-01-22',60.38,'134'),(310,'Bataleon','Pro Model Snowboard',2,1,'2024-03-31',60.51,'141'),(311,'Dakine','Recreational Snowboard',2,0,'2024-02-03',62.02,'140'),(312,'Atomic','Competition Grade Ski',1,0,'2024-03-04',69.15,'149'),(313,'Patagonia','Freestyle Board',2,1,'2024-01-10',48.78,'158'),(314,'Armada','Pro Model Ski',1,1,'2024-02-29',59.63,'161'),(315,'Jones','Freestyle Board',2,0,'2024-01-03',66.43,'148'),(316,'Rossignol','Backcountry Ski Set',1,0,'2024-02-23',80.44,'180'),(317,'Nordica','Competition Grade Ski',1,0,'2024-03-13',60.57,'185'),(318,'K2 Sports','Advanced Freeride Ski',1,1,'2024-02-26',47.47,'168'),(319,'Jones','Competition Grade Snowboard',2,1,'2024-03-25',86.63,'157'),(320,'Crapsack','All Mountain Snowboard',2,1,'2024-01-04',80.46,'161'),(321,'Nordica','Recreational Ski',1,1,'2024-01-12',60.51,'184'),(322,'Yonex','Advanced Freeride Board',2,0,'2024-01-25',45.43,'158'),(323,'Volkl','Freestyle Ski',1,1,'2024-02-10',78.39,'182'),(324,'Volkl','Park & Pipe Ski',1,1,'2024-03-08',52.33,'186'),(325,'Atomic','Youth Ski',1,0,'2024-01-02',65.59,'135'),(326,'Nordica','Youth Ski',1,0,'2024-01-02',49.89,'161'),(327,'Rossignol','Recreational Ski',1,1,'2024-02-01',63.83,'137'),(328,'Nidecker','Youth Snowboard',2,1,'2024-03-22',50.28,'162'),(329,'Armada','Youth Ski',1,0,'2024-03-17',73.68,'168'),(330,'K2 Sports','Freestyle Ski',1,0,'2024-03-09',63.48,'169'),(331,'Salomon','Youth Ski',1,0,'2024-01-14',89.87,'161'),(332,'Bataleon','Freestyle Board',2,1,'2024-02-06',83.95,'160'),(333,'K2 Sports','Youth Ski',1,0,'2024-03-03',54.89,'137'),(334,'Volkl','Competition Grade Ski',1,0,'2024-02-04',65.70,'156'),(335,'Blizzard','Competition Grade Ski',1,0,'2024-03-26',81.88,'167'),(336,'Bataleon','Backcountry Snowboard Set',2,0,'2024-02-20',87.79,'159'),(337,'Rossignol','Pro Model Ski',1,0,'2024-03-26',57.46,'148'),(338,'Atomic','Competition Grade Ski',1,0,'2024-03-13',72.13,'178'),(339,'Nordica','Youth Ski',1,0,'2024-03-17',89.17,'143'),(340,'Dakine','Competition Grade Snowboard',2,1,'2024-02-19',47.13,'155'),(341,'Volkl','Pro Model Ski',1,1,'2024-01-11',59.64,'181'),(342,'Bataleon','Competition Grade Snowboard',2,1,'2024-02-16',46.03,'149'),(343,'Atomic','Pro Model Ski',1,0,'2024-01-03',42.00,'161'),(344,'Patagonia','Backcountry Snowboard Set',2,1,'2024-02-20',73.88,'149'),(345,'Patagonia','Competition Grade Snowboard',2,0,'2024-03-18',42.90,'155'),(346,'Blizzard','Pro Model Ski',1,1,'2024-03-02',52.67,'183'),(347,'Bataleon','Recreational Snowboard',2,0,'2024-01-09',53.30,'158'),(348,'Nordica','Park & Pipe Ski',1,0,'2024-01-16',75.42,'145'),(349,'Yonex','Powder Snow Snowboard',2,1,'2024-02-03',71.17,'162'),(350,'Salomon','Advanced Freeride Ski',1,1,'2024-02-19',56.56,'182'),(351,'Patagonia','Recreational Snowboard',2,0,'2024-01-15',67.12,'140'),(352,'Nidecker','Competition Grade Snowboard',2,1,'2024-02-03',84.98,'155'),(353,'Armada','Competition Grade Ski',1,0,'2024-02-06',66.54,'153'),(354,'Patagonia','Pro Model Snowboard',2,1,'2024-02-04',75.31,'147'),(355,'Salomon','Recreational Ski',1,0,'2024-03-02',78.71,'180'),(356,'CamelBak','Youth Snowboard',2,0,'2024-02-05',70.27,'162'),(357,'Armada','Pro Model Ski',1,0,'2024-01-09',66.31,'156'),(358,'Capita','Park & Pipe Snowboard',2,0,'2024-01-11',77.20,'162'),(359,'Burton','Advanced Freeride Board',2,1,'2024-03-11',47.36,'142'),(360,'K2 Sports','Youth Ski',1,0,'2024-02-13',68.21,'193'),(361,'Rossignol','Competition Grade Ski',1,1,'2024-01-23',74.71,'160'),(362,'Jones','All Mountain Snowboard',2,0,'2024-03-28',67.36,'146'),(363,'Capita','Backcountry Snowboard Set',2,1,'2024-01-19',71.62,'153'),(364,'Yonex','Youth Snowboard',2,0,'2024-03-01',65.47,'160'),(365,'Nordica','All Mountain Ski',1,1,'2024-02-16',63.87,'181'),(366,'Salomon','Youth Ski',1,0,'2024-01-06',82.61,'158'),(367,'CamelBak','Park & Pipe Snowboard',2,1,'2024-04-01',66.32,'151'),(368,'Volkl','Park & Pipe Ski',1,0,'2024-02-19',71.69,'177'),(369,'Bataleon','Advanced Freeride Board',2,1,'2024-01-16',48.08,'149'),(370,'Atomic','Powder Snow Ski',1,0,'2024-03-06',54.52,'157'),(371,'Rossignol','Recreational Ski',1,1,'2024-03-05',57.12,'178'),(372,'Nordica','Freestyle Ski',1,0,'2024-03-06',46.45,'177'),(373,'Dakine','Backcountry Snowboard Set',2,0,'2024-03-14',79.67,'152'),(374,'Volkl','Competition Grade Ski',1,1,'2024-03-07',66.89,'156'),(375,'Salomon','Recreational Ski',1,1,'2024-02-09',73.86,'184'),(376,'Capita','Competition Grade Snowboard',2,0,'2024-02-26',42.99,'159'),(377,'Jones','Freestyle Board',2,1,'2024-01-08',56.54,'154'),(378,'CamelBak','Recreational Snowboard',2,0,'2024-01-04',51.33,'140'),(379,'Salomon','Recreational Ski',1,0,'2024-03-27',55.72,'164'),(380,'Burton','Advanced Freeride Board',2,1,'2024-04-01',65.06,'140'),(381,'Dakine','Pro Model Snowboard',2,0,'2024-01-31',72.04,'148'),(382,'Patagonia','Powder Snow Snowboard',2,0,'2024-01-20',42.97,'160'),(383,'Nidecker','Backcountry Snowboard Set',2,1,'2024-03-13',54.23,'154'),(384,'Yonex','Competition Grade Snowboard',2,1,'2024-01-05',61.05,'140'),(385,'Crapsack','Recreational Snowboard',2,1,'2024-02-04',61.82,'159'),(386,'Capita','Recreational Snowboard',2,0,'2024-02-18',84.91,'156'),(387,'Dakine','All Mountain Snowboard',2,1,'2024-02-22',85.32,'153'),(388,'Dakine','Competition Grade Snowboard',2,0,'2024-02-15',43.15,'142'),(389,'CamelBak','Recreational Snowboard',2,1,'2024-03-05',75.83,'160'),(390,'Jones','Advanced Freeride Board',2,1,'2024-03-03',89.04,'154'),(391,'Rossignol','Pro Model Ski',1,0,'2024-02-19',85.05,'135'),(392,'Jones','Park & Pipe Snowboard',2,0,'2024-02-19',48.88,'155'),(393,'Bataleon','Backcountry Snowboard Set',2,1,'2024-03-24',89.16,'148'),(394,'Bataleon','Freestyle Board',2,1,'2024-03-05',88.40,'158'),(395,'Volkl','Recreational Ski',1,0,'2024-03-23',40.11,'151'),(396,'Salomon','Pro Model Ski',1,1,'2024-01-11',82.51,'156'),(397,'Yonex','Recreational Snowboard',2,1,'2024-03-17',48.09,'146'),(398,'Patagonia','All Mountain Snowboard',2,0,'2024-03-22',76.01,'145'),(399,'Bataleon','Advanced Freeride Board',2,0,'2024-01-20',71.46,'146'),(400,'Nidecker','Recreational Snowboard',2,1,'2024-01-21',66.59,'150');
/*!40000 ALTER TABLE `Equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EquipmentMaintenance`
--

DROP TABLE IF EXISTS `EquipmentMaintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EquipmentMaintenance` (
  `maintenanceID` int NOT NULL,
  `maintenanceDate` date DEFAULT NULL,
  `maintenanceType` varchar(100) DEFAULT NULL,
  `equipmentID` int NOT NULL,
  PRIMARY KEY (`maintenanceID`,`equipmentID`),
  KEY `fk_EquipmentMaintenance_Equipment1_idx` (`equipmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
  `instructorID` int NOT NULL,
  `staffID` int DEFAULT NULL,
  PRIMARY KEY (`instructorID`),
  KEY `fk_Instructors_Staff1_idx` (`staffID`),
  CONSTRAINT `fk_Instructors_Staff1` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Instructors`
--

LOCK TABLES `Instructors` WRITE;
/*!40000 ALTER TABLE `Instructors` DISABLE KEYS */;
/*!40000 ALTER TABLE `Instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LessonBookings`
--

DROP TABLE IF EXISTS `LessonBookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LessonBookings` (
  `bookingID` int NOT NULL,
  `bookingDate` date DEFAULT NULL,
  `customerId` int NOT NULL,
  `instructorID` int NOT NULL,
  `lessonID` int NOT NULL,
  PRIMARY KEY (`bookingID`,`lessonID`,`instructorID`,`customerId`),
  KEY `fk_LessonBookings_Customer1_idx` (`customerId`),
  KEY `fk_LessonBookings_Instructors1_idx` (`instructorID`),
  KEY `fk_LessonBookings_Lessons1_idx` (`lessonID`),
  CONSTRAINT `fk_LessonBookings_Instructors1` FOREIGN KEY (`instructorID`) REFERENCES `Instructors` (`instructorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_LessonBookings_Lessons1` FOREIGN KEY (`lessonID`) REFERENCES `Lessons` (`lessonID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LessonBookings`
--

LOCK TABLES `LessonBookings` WRITE;
/*!40000 ALTER TABLE `LessonBookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `LessonBookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lessons`
--

DROP TABLE IF EXISTS `Lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lessons` (
  `lessonID` int NOT NULL,
  `description` text,
  `difficultyLevel` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`lessonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lessons`
--

LOCK TABLES `Lessons` WRITE;
/*!40000 ALTER TABLE `Lessons` DISABLE KEYS */;
/*!40000 ALTER TABLE `Lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rental`
--

DROP TABLE IF EXISTS `Rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rental` (
  `rentalID` int NOT NULL,
  `rentalDate` date DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `equipmentID` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  PRIMARY KEY (`rentalID`),
  KEY `fk_Rental_Equipment1_idx` (`equipmentID`),
  KEY `fk_Rental_Customer1_idx` (`customerId`),
  CONSTRAINT `fk_Rental_Equipment1` FOREIGN KEY (`equipmentID`) REFERENCES `Equipment` (`equipmentID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rental`
--

LOCK TABLES `Rental` WRITE;
/*!40000 ALTER TABLE `Rental` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rental` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `staffID` int NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `Role` varchar(100) DEFAULT NULL,
  `contactDetails` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add customer',7,'add_customer'),(26,'Can change customer',7,'change_customer'),(27,'Can delete customer',7,'delete_customer'),(28,'Can view customer',7,'view_customer'),(29,'Can add equipment type',8,'add_equipmenttype'),(30,'Can change equipment type',8,'change_equipmenttype'),(31,'Can delete equipment type',8,'delete_equipmenttype'),(32,'Can view equipment type',8,'view_equipmenttype'),(33,'Can add rental',9,'add_rental'),(34,'Can change rental',9,'change_rental'),(35,'Can delete rental',9,'delete_rental'),(36,'Can view rental',9,'view_rental'),(37,'Can add equipment',10,'add_equipment'),(38,'Can change equipment',10,'change_equipment'),(39,'Can delete equipment',10,'delete_equipment'),(40,'Can view equipment',10,'view_equipment');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (4,'pbkdf2_sha256$720000$gxLmeFnrMY5nEzSBNoce4W$8DgXd3aWJzaCYOHAruIU3uhJLPG2lwMWGYpy1xcJGaA=','2024-03-26 21:48:59.371119',0,'cheehon','','','honcheehou@gmail.com',0,1,'2024-03-25 23:59:33.464537'),(5,'pbkdf2_sha256$720000$zW4rKBmOMRstZTPaiRp4lS$lgSlvBV+DAoSwEl6QWOCwBfA73QQnP9Jhr2/WqE+n34=','2024-04-01 01:32:01.118723',0,'cheehon2','','','cheehouhon@gmail.com',0,1,'2024-03-26 03:45:30.652675'),(6,'pbkdf2_sha256$720000$KZ84sd3qrpnhHP6d6loJYE$G1VRUHiQP+rbmqbjb7tpV8i0AN9xG/BdFJQNZNBVOfI=','2024-03-26 03:48:19.065981',0,'cheehon3','','','honcheehou@gmail.com',0,1,'2024-03-26 03:48:18.169356');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'chee_home','customer'),(10,'chee_rental','equipment'),(8,'chee_rental','equipmenttype'),(9,'chee_rental','rental'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-03-13 23:37:58.906519'),(2,'auth','0001_initial','2024-03-13 23:37:59.924523'),(3,'admin','0001_initial','2024-03-13 23:38:00.095945'),(4,'admin','0002_logentry_remove_auto_add','2024-03-13 23:38:00.107378'),(5,'admin','0003_logentry_add_action_flag_choices','2024-03-13 23:38:00.117001'),(6,'contenttypes','0002_remove_content_type_name','2024-03-13 23:38:00.210138'),(7,'auth','0002_alter_permission_name_max_length','2024-03-13 23:38:00.279636'),(8,'auth','0003_alter_user_email_max_length','2024-03-13 23:38:00.357195'),(9,'auth','0004_alter_user_username_opts','2024-03-13 23:38:00.366926'),(10,'auth','0005_alter_user_last_login_null','2024-03-13 23:38:00.420986'),(11,'auth','0006_require_contenttypes_0002','2024-03-13 23:38:00.425888'),(12,'auth','0007_alter_validators_add_error_messages','2024-03-13 23:38:00.436475'),(13,'auth','0008_alter_user_username_max_length','2024-03-13 23:38:00.504943'),(14,'auth','0009_alter_user_last_name_max_length','2024-03-13 23:38:00.583896'),(15,'auth','0010_alter_group_name_max_length','2024-03-13 23:38:00.650947'),(16,'auth','0011_update_proxy_permissions','2024-03-13 23:38:00.662184'),(17,'auth','0012_alter_user_first_name_max_length','2024-03-13 23:38:00.744381'),(18,'sessions','0001_initial','2024-03-13 23:38:00.790986'),(19,'chee_home','0001_initial','2024-03-26 01:26:22.757031'),(20,'chee_home','0002_alter_customer_user','2024-03-26 01:59:30.602678'),(21,'chee_rental','0001_initial','2024-03-31 23:48:22.010145');
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
INSERT INTO `django_session` VALUES ('69poh68xakq85e7yk4ubyy1iixuagb92','e30:1robPd:7uteydwe-T51rVS4w1vdxg3zI5DrlWTQOcAYtoIbghU','2024-04-08 03:54:17.513827'),('gzbibfda65u400717t2iqmvg14wspwig','.eJxVjDsOwyAQRO9CHSFgjWFTpvcZ0PILTiKQjF1FuXtsyUVSzrw382aOtrW4rafFzZFdGbDLb-cpPFM9QHxQvTceWl2X2fND4SftfGoxvW6n-3dQqJd9PYphIEIJpCGmrCyoPWeyApIxEjH4DEpLbXC0JktvLMaMwXotrMLIPl_R_Tde:1robv9:naLPj3KFp_4bNjmoXe2XJq7oHIRrp3WcxdL6mysoVuE','2024-04-08 04:26:51.125797'),('nmtsw1ryjhelfp5sw4ogd0p2hh4zpohm','.eJxVjEEOwiAQRe_C2pAwQCku3XsGMjCMVA0kpV013t026UK3773_NxFwXUpYe57DROIqrLj8sojplesh6In10WRqdZmnKI9EnrbLe6P8vp3t30HBXvY1EPmBFXtK2jsA59ihsZ5dZPA2-aRgR1obsNZwhOxQGWDQQx7jmMXnC9-xN5w:1rr6Wn:FilTCqlEXcafSYLnrrrorSIDg2QVYAZf83kwSOKtiDE','2024-04-15 01:32:01.126187'),('vttw6od8hep1q32qhsg4u4d8c2xvwzoo','e30:1robLB:GvMMjkfXungLux_qWFjPT4YRDObY2MYG9F4AebKgkMw','2024-04-08 03:49:41.623330'),('x4yqrtzbtjkngg84pygnhfcu93ovx2kv','e30:1robNr:jRa5gpw40JyiYrNwIsXuRIG3y2BscHtCiUkFlF2sef4','2024-04-08 03:52:27.178618'),('zszwfyu8ar16hhc5t2hqt5ptnx0zanmc','e30:1robOb:wY9Enqz8XgQE-YfcaS75ZgoVzXYedzUutPjmzdISAyw','2024-04-08 03:53:13.647382');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-01  3:37:31

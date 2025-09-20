-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: team_project
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_class`
--

DROP TABLE IF EXISTS `app_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_class` (
  `acno` int NOT NULL AUTO_INCREMENT,
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` char(1) NOT NULL DEFAULT 'E',
  `uno` int DEFAULT NULL,
  `cno` int DEFAULT NULL,
  PRIMARY KEY (`acno`),
  KEY `uno` (`uno`),
  KEY `cno` (`cno`),
  CONSTRAINT `app_class_ibfk_1` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`),
  CONSTRAINT `app_class_ibfk_2` FOREIGN KEY (`cno`) REFERENCES `class` (`cno`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_class`
--

LOCK TABLES `app_class` WRITE;
/*!40000 ALTER TABLE `app_class` DISABLE KEYS */;
INSERT INTO `app_class` VALUES (1,'2024-11-05 15:00:00','E',2,11),(2,'2024-11-05 15:00:00','E',3,11),(3,'2024-11-05 15:00:00','E',4,11),(4,'2024-11-05 15:00:00','E',5,11),(5,'2024-11-06 15:00:00','E',6,11),(6,'2024-11-06 15:00:00','E',7,11),(7,'2024-06-01 15:00:00','E',13,16),(8,'2024-06-01 15:00:00','E',14,16),(9,'2024-06-01 15:00:00','E',15,16),(10,'2024-06-08 15:00:00','E',16,16),(11,'2024-06-04 15:00:00','E',17,16),(12,'2024-06-12 15:00:00','E',18,16),(13,'2024-06-06 15:00:00','E',19,16),(14,'2024-06-09 15:00:00','E',20,16),(15,'2024-11-05 08:11:54','E',10,12),(16,'2024-11-05 08:52:31','E',10,13),(17,'2024-11-06 09:10:40','E',28,12),(18,'2024-11-12 00:20:37','E',30,24);
/*!40000 ALTER TABLE `app_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `ano` int NOT NULL AUTO_INCREMENT,
  `attendance` varchar(10) NOT NULL DEFAULT '출석',
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` char(1) NOT NULL DEFAULT 'E',
  `uno` int DEFAULT NULL,
  `cno` int DEFAULT NULL,
  PRIMARY KEY (`ano`),
  KEY `uno` (`uno`),
  KEY `cno` (`cno`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`),
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`cno`) REFERENCES `class` (`cno`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (-1,'조퇴','2024-11-07 15:00:00','E',NULL,16),(1,'지각','2024-07-21 23:52:00','E',13,16),(2,'출석','2024-07-21 23:52:00','E',14,16),(3,'출석','2024-07-21 23:52:00','E',15,16),(4,'출석','2024-07-22 00:00:00','E',16,16),(5,'지각','2024-07-22 01:52:00','E',17,16),(6,'병결','2024-07-22 09:00:00','E',18,16),(7,'출석','2024-07-22 00:00:00','E',19,16),(8,'출석','2024-07-22 00:01:00','E',20,16),(9,'출석','2024-11-01 00:00:00','E',13,16),(10,'출석','2024-11-01 00:00:00','E',14,16),(11,'출석','2024-11-01 00:00:00','E',15,16),(12,'출석','2024-11-01 00:00:00','E',16,16),(13,'지각','2024-11-01 00:30:00','E',17,16),(14,'출석','2024-11-01 00:00:00','E',18,16),(15,'출석','2024-11-01 00:00:00','E',19,16),(16,'출석','2024-11-01 00:00:00','E',20,16),(17,'출석','2024-11-02 00:00:00','E',14,16),(18,'출석','2024-11-01 23:50:00','E',15,16),(19,'출석','2024-11-02 00:00:00','E',16,16),(20,'출석','2024-11-02 00:00:00','E',17,16),(21,'출석','2024-11-02 00:00:00','E',18,16),(22,'출석','2024-11-02 00:00:00','E',19,16),(23,'출석','2024-11-02 00:00:00','E',20,16),(24,'출석','2024-11-02 00:00:00','E',13,16),(25,'지각','2024-11-03 00:30:00','E',13,16),(26,'출석','2024-11-03 00:00:00','E',14,16),(27,'출석','2024-11-03 00:00:00','E',15,16),(28,'출석','2024-11-03 00:00:00','E',16,16),(29,'지각','2024-11-03 00:30:00','E',17,16),(30,'병결','2024-11-03 09:00:00','E',18,16),(31,'출석','2024-11-03 00:00:00','E',19,16),(32,'출석','2024-11-03 00:00:00','E',20,16),(33,'출석','2024-11-04 00:00:00','E',13,16),(34,'출석','2024-11-04 00:00:00','E',14,16),(35,'출석','2024-11-04 00:00:00','E',15,16),(36,'출석','2024-11-04 00:00:00','E',16,16),(37,'지각','2024-11-04 00:30:00','E',17,16),(38,'출석','2024-11-04 00:00:00','E',18,16),(39,'출석','2024-11-04 00:00:00','E',19,16),(40,'출석','2024-11-04 00:00:00','E',20,16),(41,'지각','2024-11-05 00:00:00','E',13,16),(42,'출석','2024-11-05 00:00:00','E',14,16),(43,'출석','2024-11-05 00:00:00','E',15,16),(44,'출석','2024-11-05 00:00:00','E',16,16),(45,'출석','2024-11-05 00:30:00','E',17,16),(46,'출석','2024-11-05 00:00:00','E',18,16),(47,'출석','2024-11-05 00:00:00','E',19,16),(48,'출석','2024-11-05 00:00:00','E',20,16),(49,'지각','2024-11-08 06:00:51','E',13,16),(51,'지각','2024-11-11 02:11:25','E',13,16),(52,'지각','2024-11-12 00:24:52','E',30,24);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `cno` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `subject` varchar(10) DEFAULT NULL,
  `state` char(1) NOT NULL DEFAULT 'E',
  `difficult` char(1) DEFAULT NULL,
  `book` varchar(100) DEFAULT NULL,
  `duringclass` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_duringclass` timestamp NULL DEFAULT NULL,
  `jdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_jdate` timestamp NULL DEFAULT NULL,
  `rdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL,
  `orgfilename` varchar(260) DEFAULT NULL,
  `class_start` timestamp NULL DEFAULT NULL,
  `class_late` timestamp NULL DEFAULT NULL,
  `hit` int DEFAULT '0',
  `uno` int DEFAULT NULL,
  `random_number` varchar(10) DEFAULT NULL,
  `newfilename` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`cno`),
  KEY `uno` (`uno`),
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'현우진의 미적분','미적분','E','상','EBS수능특강수학영역미적분','2024-02-29 15:00:00','2024-05-27 15:00:00','2024-01-31 15:00:00','2024-02-19 15:00:00','2024-01-26 06:36:24','현우진',NULL,'2024-03-01 00:00:00','2024-03-01 09:00:00',0,26,NULL,NULL),(2,'정승제의 수1','수1','E','상','EBS수능특강수학영역수1','2024-02-29 15:00:00','2024-05-27 15:00:00','2024-01-31 15:00:00','2024-02-19 15:00:00','2024-01-25 15:00:00','정승제',NULL,'2024-03-01 00:00:00','2024-03-01 03:00:00',0,11,NULL,NULL),(3,'정승제의 수2','수2','E','중','EBS수능특강수학영역수2','2024-02-29 15:00:00','2024-05-27 15:00:00','2024-01-31 15:00:00','2024-02-24 15:00:00','2024-01-19 15:00:00','정승제',NULL,'2024-03-01 04:00:00','2024-03-01 09:00:00',0,11,NULL,NULL),(4,'정승제의 미적분','미적분','E','상','EBS수능특강수학영역미적분','2024-04-30 15:00:00','2024-07-19 15:00:00','2024-03-31 15:00:00','2024-04-19 15:00:00','2024-03-24 15:00:00','정승제',NULL,'2024-05-01 00:00:00','2024-05-01 03:00:00',0,11,NULL,NULL),(5,'정승제의 확률과통계','확률과통계','E','상','EBS수능특강수학영역확률과통계','2024-04-30 15:00:00','2024-07-19 15:00:00','2024-03-31 15:00:00','2024-04-19 15:00:00','2024-03-19 15:00:00','정승제',NULL,'2024-05-01 04:00:00','2024-05-01 09:00:00',0,11,NULL,NULL),(6,'현우진의 수1','수1','E','상','EBS수능특강수학영역수1','2023-11-27 15:00:00','2024-02-27 15:00:00','2023-11-09 15:00:00','2023-11-19 15:00:00','2023-10-26 15:00:00','현우진',NULL,'2023-11-28 00:00:00','2023-11-28 09:00:00',0,26,NULL,NULL),(8,'최서희의 문학','문학','E','상','EBS수능특강국어영역문학','2023-11-27 15:00:00','2024-02-27 15:00:00','2023-11-09 15:00:00','2023-11-19 15:00:00','2023-11-19 15:00:00','최서희',NULL,'2023-11-28 00:00:00','2023-11-28 03:00:00',0,12,NULL,NULL),(9,'최서희의 비문학','비문학','E','중','EBS수능특강국어영역비문학','2023-11-27 15:00:00','2024-02-27 15:00:00','2023-11-05 07:01:55','2023-11-19 15:00:00','2023-11-20 07:01:55','최서희',NULL,'2023-11-28 04:00:00','2023-11-28 09:00:00',0,12,NULL,NULL),(10,'정승제의 수1','수1','E','상','EBS수능특강수학영역수1','2023-11-27 15:00:00','2024-02-27 15:00:00','2023-11-05 07:12:30','2023-11-19 15:00:00','2023-11-20 07:12:30','정승제',NULL,'2023-11-28 00:00:00','2023-11-28 03:00:00',0,11,NULL,NULL),(11,'정승제의 수1','수학','D',NULL,'EBS수능특강수학영역수1','2024-11-10 15:00:00','2024-11-14 15:00:00','2024-11-04 15:00:00','2024-11-07 15:00:00','2024-08-31 15:00:00','정승제','강사사진1.png','2024-11-01 00:00:00','2024-11-01 03:00:00',0,11,NULL,''),(12,'정승제의 수2','수학','E','하','EBS수능특강수학영역수2','2024-11-10 15:00:00','2024-11-14 15:00:00','2024-11-05 15:00:00','2024-11-07 15:00:00','2024-08-31 15:00:00','정승제','강사사진3.png','2024-11-01 04:00:00','2024-11-01 09:00:00',0,11,NULL,'ab706e40-4c49-41e5-82bd-406f0cbfac31'),(13,'현우진의 확률과통계','확률과통계','E','상','EBS수능특강수학영역확률과통계','2024-10-31 15:00:00','2024-11-05 15:00:00','2024-09-30 15:00:00','2024-10-19 15:00:00','2024-08-31 15:00:00','현우진',NULL,'2024-11-01 00:00:00','2024-11-01 03:00:00',0,26,NULL,NULL),(14,'현우진의 기하','기하','E','중','EBS수능특강수학영역기하','2024-10-31 15:00:00','2025-01-05 15:00:00','2024-09-30 15:00:00','2024-10-19 15:00:00','2024-08-31 15:00:00','현우진','','2024-11-01 04:00:00','2024-11-01 09:00:00',0,26,NULL,NULL),(15,'정승제의 미적분','미적분','E','상','EBS수능특강수학영역미적분','2024-07-21 15:00:00','2024-12-19 15:00:00','2024-05-31 15:00:00','2024-06-19 15:00:00','2024-05-26 15:00:00','정승제',NULL,'2024-07-22 00:00:00','2024-07-22 03:00:00',0,11,NULL,NULL),(16,'정승제의 기학','기하','E','중','EBS수능특강수학영역기하','2024-07-21 15:00:00','2024-12-19 15:00:00','2024-05-31 15:00:00','2024-06-19 15:00:00','2024-05-26 15:00:00','정승제',NULL,'2024-07-22 04:00:00','2024-07-22 09:00:00',0,11,'816095',NULL),(17,'[2025] 1차 프로젝트 등록','국어','E','하','3번째 테스트입니다','2024-11-10 15:00:00','2024-11-14 15:00:00','2024-11-06 15:00:00','2024-11-07 15:00:00','2024-11-07 00:35:52','김길동','로고1.png',NULL,NULL,0,1,NULL,'d908c63b-a9cf-4912-9135-ba7602eb734b'),(18,'[2025] 1차 프로젝트 등록','국어','E','하','3번째 테스트입니다','2024-11-10 15:00:00','2024-11-14 15:00:00','2024-11-06 15:00:00','2024-11-07 15:00:00','2024-11-07 00:37:00','김길동','로고1.png',NULL,NULL,0,1,NULL,'16011c32-c709-4d49-8744-d4d64ab2492e'),(19,'등록후 페이지이동 테스트','국어','E','중','4번째 테스트','2024-11-10 15:00:00','2024-11-14 15:00:00','2024-11-06 15:00:00','2024-11-07 15:00:00','2024-11-07 00:47:21','고길동','강사사진4.png',NULL,NULL,0,1,NULL,'f4c08cba-c49e-4fb3-a670-ce24e2d4df66'),(20,'[2024] 1차 팀프로젝트 테스트','국어','E','상','4번째 테스트','2024-11-10 15:00:00','2024-11-14 15:00:00','2024-11-06 15:00:00','2024-11-07 15:00:00','2024-11-07 03:42:07','강길동','강사사진1.png','2024-11-07 00:10:00','2024-11-07 09:01:00',0,1,NULL,'80edf0ea-88cf-4686-9fd2-d88370e57e5f'),(21,'[2025 수능완성] 국어의 퀀텀점프 화법과 작문','국어','E','상','EBS 2025학년도 FINAL 실전모의고사 사회탐구영역 사회ㆍ문화','2024-11-10 15:00:00','2024-11-28 15:00:00','2024-11-14 15:00:00','2024-11-14 15:00:00','2024-11-11 02:36:15','제임스','강사사진1.png','2024-11-29 00:00:00','2024-11-22 09:00:00',0,1,NULL,'e5d17f42-63b1-42d9-bac8-575275589d52'),(22,'[2025 수능완성] 영어의 새로운 정의','영어','E','중','EBS 2025학년도 FINAL 실전모의고사 사회탐구영역 사회ㆍ문화','2024-11-17 15:00:00','2024-11-28 15:00:00','2024-11-10 15:00:00','2024-11-21 15:00:00','2024-11-11 02:37:33','크루즈','강사사진3.png','2024-11-18 00:00:00','2024-11-29 09:00:00',0,1,NULL,'5b102746-cb3f-4a21-97f5-2e8dd340587c'),(23,'[2025 수능완성] 개념 설명 맛집 화법과 작문','국어','E','상','EBS 2025학년도 FINAL 실전모의고사 사회탐구영역 사회ㆍ문화','2024-11-17 15:00:00','2024-11-28 15:00:00','2024-11-10 15:00:00','2024-11-21 15:00:00','2024-11-11 02:40:02','다니엘','강사사진2.png','2024-11-11 00:00:00','2024-11-29 09:00:00',0,1,NULL,'b876aae5-9593-49ab-8a9a-e56b480869e4'),(24,'[2025 수능완성] 실력 도약의 발판 생명과학','과학탐구','E','하','EBS 2025학년도 FINAL 실전모의고사 사회탐구영역 사회ㆍ문화','2024-11-17 15:00:00','2024-11-28 15:00:00','2024-11-10 15:00:00','2024-11-21 15:00:00','2024-11-11 02:41:04','줄리엣','강사사진4.png','2024-11-11 00:00:00','2024-11-28 21:00:00',0,1,'440239','aef74c93-5417-4d21-96c1-bec1febf2f97');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `fno` int NOT NULL AUTO_INCREMENT,
  `orgFileName` varchar(260) NOT NULL,
  `newFileName` varchar(64) NOT NULL,
  `lno` int DEFAULT NULL,
  `cno` int DEFAULT NULL,
  PRIMARY KEY (`fno`),
  KEY `lno` (`lno`),
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`lno`) REFERENCES `library` (`lno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES (1,'화면 캡처 2024-10-23 162026.png','19871277-71b9-46bb-b97f-df14287996b8',1,NULL),(2,'404.png','aba1da8a-0007-405d-8bb9-15b31210d394',2,NULL);
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library` (
  `lno` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hit` int NOT NULL DEFAULT '0',
  `state` char(1) NOT NULL DEFAULT 'E',
  `uno` int DEFAULT NULL,
  PRIMARY KEY (`lno`),
  KEY `uno` (`uno`),
  CONSTRAINT `library_ibfk_1` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library`
--

LOCK TABLES `library` WRITE;
/*!40000 ALTER TABLE `library` DISABLE KEYS */;
INSERT INTO `library` VALUES (1,'1','1','2024-11-05 09:06:02',1,'E',11),(2,'안녕하세요 첫번재  자료실 테스트 입니다','안녕하세요 첫번재  자료실 테스트 입니다 안녕하세요 첫번재  자료실 테스트 입니다 안녕하세요 첫번재  자료실 테스트 입니다','2024-11-09 00:38:59',9,'E',11);
/*!40000 ALTER TABLE `library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice_board`
--

DROP TABLE IF EXISTS `notice_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_board` (
  `nno` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hit` int NOT NULL DEFAULT '0',
  `state` char(1) NOT NULL DEFAULT 'E',
  `topYn` char(1) DEFAULT 'D',
  `uno` int DEFAULT NULL,
  PRIMARY KEY (`nno`),
  KEY `uno` (`uno`),
  CONSTRAINT `notice_board_ibfk_1` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_board`
--

LOCK TABLES `notice_board` WRITE;
/*!40000 ALTER TABLE `notice_board` DISABLE KEYS */;
INSERT INTO `notice_board` VALUES (1,'공지사항 첫번째 입니다.','공지사항 첫번째 입니다.','2024-11-05 04:00:00',0,'E','N',1),(2,'공지사항 두번째 입니다.','공지사항 두번째 입니다.','2024-11-05 04:00:01',0,'E','N',1),(3,'공지사항 두번째 입니다.','공지사항 두번째 입니다.','2024-11-05 04:00:02',0,'E','N',1),(4,'공지사항 두번째 입니다.','공지사항 두번째 입니다.','2024-11-05 04:00:03',0,'E','N',1),(5,'공지사항 두번째 입니다.','공지사항 두번째 입니다.','2024-11-05 04:00:04',0,'E','N',1),(6,'공지사항 두번째 입니다.','공지사항 두번째 입니다.','2024-11-05 04:00:05',2,'E','N',1),(9,'첫번재 테스트입니다','첫번재 테스트입니다','2024-11-08 09:33:44',3,'E','D',1);
/*!40000 ALTER TABLE `notice_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna_board`
--

DROP TABLE IF EXISTS `qna_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna_board` (
  `qno` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `hit` int NOT NULL DEFAULT '0',
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` char(1) NOT NULL DEFAULT 'E',
  `uno` int DEFAULT NULL,
  PRIMARY KEY (`qno`),
  KEY `uno` (`uno`),
  CONSTRAINT `qna_board_ibfk_1` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_board`
--

LOCK TABLES `qna_board` WRITE;
/*!40000 ALTER TABLE `qna_board` DISABLE KEYS */;
INSERT INTO `qna_board` VALUES (1,'첫번째 질문입니다.첫번째 질문입니다.','첫번째 질문입니다.',0,'2024-11-05 04:00:00','E',1),(2,'첫번째 질문입니다.첫번째 질문입니다.','첫번째 질문입니다.',0,'2024-11-05 04:00:01','E',1),(3,'첫번째 질문입니다.첫번째 질문입니다.','첫번째 질문입니다.',0,'2024-11-05 04:00:02','E',1),(4,'첫번째 질문입니다.첫번째 질문입니다.','첫번째 질문입니다.',2,'2024-11-05 04:00:02','E',1),(5,'안녕하세요 첫번재 테스트 입니다','안녕하세요 첫번재 테스트 입니다 안녕하세요 첫번재 테스트 입니다 안녕하세요 첫번재 테스트 입니다',10,'2024-11-09 00:36:36','E',10);
/*!40000 ALTER TABLE `qna_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qnacomment`
--

DROP TABLE IF EXISTS `qnacomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qnacomment` (
  `qcno` int NOT NULL AUTO_INCREMENT,
  `content` varchar(100) NOT NULL,
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` char(1) NOT NULL DEFAULT 'E',
  `qno` int DEFAULT NULL,
  `uno` int DEFAULT NULL,
  PRIMARY KEY (`qcno`),
  KEY `qno` (`qno`),
  KEY `uno` (`uno`),
  CONSTRAINT `qnacomment_ibfk_1` FOREIGN KEY (`qno`) REFERENCES `qna_board` (`qno`),
  CONSTRAINT `qnacomment_ibfk_2` FOREIGN KEY (`uno`) REFERENCES `user` (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qnacomment`
--

LOCK TABLES `qnacomment` WRITE;
/*!40000 ALTER TABLE `qnacomment` DISABLE KEYS */;
INSERT INTO `qnacomment` VALUES (1,'첫번재 댓글 테스트 입니다 수정본','2024-11-09 00:36:57','E',5,10),(2,'안녕하세요 첫번재  댓글 테스트 입니다 안녕하세요 첫번재  댓글 테스트 입니다 안녕하세요 첫번재  댓글 테스트 입니다','2024-11-09 00:37:23','E',5,10);
/*!40000 ALTER TABLE `qnacomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uno` int NOT NULL AUTO_INCREMENT,
  `id` varchar(200) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` char(11) NOT NULL,
  `email` varchar(320) NOT NULL,
  `name` varchar(50) NOT NULL,
  `state` char(1) NOT NULL DEFAULT 'E',
  `authorization` char(1) NOT NULL DEFAULT 'S',
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','1234','1234','1234','어드민','E','A','2023-10-01 01:00:00'),(2,'test002','1234','1234','1234','이광수','E','S','2023-11-05 05:58:18'),(3,'test003','1234','1234','1234','지석진','E','S','2023-11-05 05:58:36'),(4,'test015','1234','1234','1234','송지효','E','S','2023-11-05 05:58:55'),(5,'test016','1234','1234','1234','김종국','E','S','2023-11-05 05:59:11'),(6,'test017','1234','1234','1234','정소민','E','S','2023-11-05 05:59:24'),(7,'test018','1234','1234','1234','앙세찬','E','S','2023-11-05 05:59:40'),(8,'honggildong001','hong1234','01011111111','hong@test.com','홍길동','E','T','2023-10-05 06:07:22'),(9,'kimkim001','kimkkkk','01011112222','kim@test.com','한병훈','E','T','2023-10-05 06:07:25'),(10,'test004','1234','01023247674','test4@test.com','테스터4','E','S','2023-11-05 06:07:28'),(11,'test005','1234','01033333333','test5@test.com','정승제','E','T','2023-10-05 06:07:31'),(12,'test006','1234','01022223333','test5@test.com','최서희','E','T','2023-10-05 06:07:35'),(13,'test007','1234','01033334444','test5@test.com','정길동','E','S','2023-11-05 06:07:37'),(14,'test008','1234','01033335555','test5@test.com','박길동','E','S','2023-11-05 06:07:40'),(15,'test009','1234','01033336666','test5@test.com','장길동','E','S','2023-11-05 06:07:43'),(16,'test010','1234','01033334455','test10@test.com','유재석','E','S','2023-11-04 15:00:00'),(17,'test011','1234','01022222222','test11@test.com','박명수','E','S','2023-11-04 15:00:00'),(18,'test012','1234','01023234545','test12@test.com','정준하','E','S','2023-11-04 15:00:00'),(19,'test013','1234','01025822582','test13@test.com','하하','E','S','2023-11-09 15:00:00'),(20,'test014','1234','01012345678','test14@test.com','황광희','E','S','2023-11-11 15:00:00'),(21,'test019','1234','01055555555','test19@test.com','배수지','E','S','2023-11-11 15:00:00'),(22,'test020','1234','01044447777','test20@test.com','지예은','E','S','2023-11-09 15:00:00'),(23,'test021','1234','00000000000','test21@test.com','조정식','E','T','2023-10-04 15:00:00'),(24,'test022','1234','01032323232','test22@test.com','박소현','E','T','2023-10-04 15:00:00'),(25,'test023','1234','01066667777','test23@test.com','오지훈','E','T','2023-11-04 15:00:00'),(26,'test024','1234','01088889999','test24@test.com','현우진','E','T','2023-11-04 15:00:00'),(27,'123','123','01001001001','test24@test.com','관리자2','E','A','2023-11-04 15:00:00'),(28,'test111','1234','01081688794','test111@test.com','가길동','E','S','2024-11-05 15:00:00'),(29,'honggildong123','jj798465','01011111111','ezen@ezen.com','홍길동','E','T','2024-11-11 02:00:47'),(30,'q123456','qq12345678','01011122223','aaaa1234@gmail.com','감길동','E','S','2024-11-12 00:19:34'),(31,'q1234','q1234','01022235554','aaa123@gmail.com','줄리엣','E','T','2024-11-12 00:22:30');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-12 14:02:54

CREATE DATABASE  IF NOT EXISTS `taobao` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `taobao`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: taobao
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `admin_info`
--

DROP TABLE IF EXISTS `admin_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_info` (
  `adminId` varchar(20) NOT NULL,
  `adminPassword` varchar(20) NOT NULL,
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_info`
--

LOCK TABLES `admin_info` WRITE;
/*!40000 ALTER TABLE `admin_info` DISABLE KEYS */;
INSERT INTO `admin_info` VALUES ('admin','admin');
/*!40000 ALTER TABLE `admin_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_info`
--

DROP TABLE IF EXISTS `cart_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_info` (
  `cartId` varchar(20) NOT NULL,
  `cartItem` varchar(50) NOT NULL,
  `cartNum` int(11) DEFAULT NULL,
  `cartPrice` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cartId`,`cartItem`),
  KEY `IXFK_cart_info_product_info` (`cartItem`),
  KEY `IXFK_cart_info_user_info` (`cartId`),
  CONSTRAINT `FK_cart_info_product_info` FOREIGN KEY (`cartItem`) REFERENCES `product_info` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cart_info_user_info` FOREIGN KEY (`cartId`) REFERENCES `user_info` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_info`
--

LOCK TABLES `cart_info` WRITE;
/*!40000 ALTER TABLE `cart_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_info` (
  `orderId` varchar(50) NOT NULL,
  `orderStatus` int(11) DEFAULT NULL,
  `orderTotal` double(10,2) DEFAULT NULL,
  `orderAddress` varchar(50) DEFAULT NULL,
  `orderUser` varchar(20) DEFAULT NULL,
  `orderTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderId`),
  KEY `IXFK_order_info_user_info` (`orderUser`),
  CONSTRAINT `FK_order_info_user_info` FOREIGN KEY (`orderUser`) REFERENCES `user_info` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `ItemId` varchar(50) NOT NULL,
  `itemShop` varchar(20) DEFAULT NULL,
  `itemNum` int(11) DEFAULT NULL,
  `itemProduct` varchar(50) DEFAULT NULL,
  `itemImg` varchar(50) DEFAULT NULL,
  `itemName` varchar(50) DEFAULT NULL,
  `itemPrice` double(10,2) DEFAULT NULL,
  `itemTotal` double(10,2) DEFAULT NULL,
  `itemOrder` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ItemId`),
  KEY `IXFK_order_item_order_info` (`itemOrder`),
  KEY `IXFK_order_item_product_info` (`itemProduct`),
  KEY `IXFK_order_item_shop_info` (`itemShop`),
  CONSTRAINT `FK_order_item_order_info` FOREIGN KEY (`itemOrder`) REFERENCES `order_info` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_item_product_info` FOREIGN KEY (`itemProduct`) REFERENCES `product_info` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_item_shop_info` FOREIGN KEY (`itemShop`) REFERENCES `shop_info` (`shopId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_info`
--

DROP TABLE IF EXISTS `product_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_info` (
  `productId` varchar(50) NOT NULL,
  `productName` varchar(50) NOT NULL,
  `productPrice` double(6,2) NOT NULL,
  `productLeft` int(11) DEFAULT NULL,
  `productSale` int(11) DEFAULT '0',
  `productImg` varchar(50) DEFAULT NULL,
  `shopId` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`productId`),
  KEY `IXFK_product_info_shop_info` (`shopId`),
  CONSTRAINT `FK_product_info_shop_info` FOREIGN KEY (`shopId`) REFERENCES `shop_info` (`shopId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_info`
--

LOCK TABLES `product_info` WRITE;
/*!40000 ALTER TABLE `product_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_info`
--

DROP TABLE IF EXISTS `shop_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_info` (
  `shopId` varchar(20) NOT NULL,
  `shopName` varchar(50) NOT NULL,
  `shopQQ` varchar(20) NOT NULL,
  `shopStart` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`shopId`),
  KEY `IXFK_shop_info_user_info` (`shopId`),
  CONSTRAINT `FK_shop_info_user_info` FOREIGN KEY (`shopId`) REFERENCES `user_info` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_info`
--

LOCK TABLES `shop_info` WRITE;
/*!40000 ALTER TABLE `shop_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_address`
--

DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_address` (
  `userId` varchar(20) NOT NULL,
  `addrPath` varchar(50) NOT NULL,
  `addrName` varchar(20) DEFAULT NULL,
  `addrPhone` varchar(30) NOT NULL,
  `addrDefault` int(11) NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `IXFK_user_address_user_info` (`userId`),
  CONSTRAINT `FK_user_address_user_info` FOREIGN KEY (`userId`) REFERENCES `user_info` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_address`
--

LOCK TABLES `user_address` WRITE;
/*!40000 ALTER TABLE `user_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `userId` varchar(20) NOT NULL,
  `userPassword` varchar(20) NOT NULL,
  `userImg` varchar(50) DEFAULT NULL,
  `userNickname` varchar(20) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `userSex` int(11) NOT NULL,
  `userBirth` date DEFAULT NULL,
  `userPhone` varchar(30) DEFAULT NULL,
  `userMail` varchar(20) DEFAULT NULL,
  `userIsShop` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-12 15:06:56

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
  `cartNum` int(11) NOT NULL,
  `cartPrice` double(6,2) NOT NULL,
  `cartImg` varchar(50) NOT NULL,
  `cartName` varchar(50) NOT NULL,
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
INSERT INTO `cart_info` VALUES ('Test1','228B3A2ABFDA4E9B9DD1BB61179FB977',1,998.88,'/images/1/10/D7574813276C4F1C9E0916D7D8B39EFE.jpg','吹风筒'),('Test1','6B6886A67771412F8442BE1B6996D796',1,5.50,'/images/0/7/E220F74F994D4E02822CAF8267EB4657.jpg','测试4'),('Test1','A738130583794647899EA9356EB9D911',1,300.00,'/images/15/0/407D153676224E2AA65F4C0FF000B07A.jpg','测试5');
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
  `orderStatus` int(11) NOT NULL,
  `orderTotal` double(10,2) NOT NULL,
  `orderAddress` varchar(50) NOT NULL,
  `orderUser` varchar(20) NOT NULL,
  `orderTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orderShop` varchar(20) NOT NULL,
  PRIMARY KEY (`orderId`),
  KEY `IXFK_order_info_user_info` (`orderUser`),
  KEY `FK_order_info_shop_info_idx` (`orderShop`),
  CONSTRAINT `FK_order_info_shop_info` FOREIGN KEY (`orderShop`) REFERENCES `shop_info` (`shopId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES ('20D37DD0A2FC4FC0A98B833F9FBEFB08',4,3638.64,'江苏省 盐城市 盐都区 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-28 16:03:25','Test1'),('52E6CC4D2F984721A44403C06CD6B67A',4,12.00,'内蒙古自治区 兴安盟 科尔沁右翼中旗 ','Test1','2017-05-28 16:11:03','Test2'),('7A4EED6A60404B08ABE1497FDE8D4B87',5,62.50,'广东省 广州市 海珠区 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-26 19:44:20','Test1'),('81C41CCC12234145948E36BC8D2B5FE1',4,24.00,'广东省 广州市 海珠区 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-26 19:42:23','Test2'),('8974A9EED7CA498C93B602E34B5608EB',2,102.00,'河南省 信阳市 商城县 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-28 18:28:24','Test1'),('8CBD155A45EF416A89331EFB66F9F75B',4,62.50,'广东省 广州市 海珠区 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-26 19:42:23','Test1'),('A444A804181F43F4BE502E6DB3AA7486',4,824.35,'内蒙古自治区 兴安盟 科尔沁右翼中旗 ','Test1','2017-05-28 16:11:03','Test1'),('B4B1411EF34744339342E0B9BF1BD277',4,24.00,'江苏省 盐城市 盐都区 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-28 16:03:25','Test2'),('C8C427B7E38C4DB6A58E08745592B394',4,24.00,'广东省 广州市 海珠区 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-26 19:44:20','Test2'),('E9D0276BFD074E9A8F72E40E98E91453',1,1080.50,'河南省 信阳市 固始县 滨江街道 仲恺路 500号 某某 18812245587','Test1','2017-05-28 18:25:27','Test1');
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
  CONSTRAINT `FK_order_item_order_info` FOREIGN KEY (`itemOrder`) REFERENCES `order_info` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_item_product_info` FOREIGN KEY (`itemProduct`) REFERENCES `product_info` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES ('0169EE69601A4F778A5FE3367F6C7054',5,'1D9FDEA64E6B4DF3B52D2869AAEE33E0','/images/15/15/A215D3B8F95C45D0BCC32769FB69B691.jpg','橙子',12.50,62.50,'8CBD155A45EF416A89331EFB66F9F75B'),('18A992AAD399485FAD00121851ED13E2',1,'2003808CAECC47C89D592EF10CD80721','/images/10/3/4B9A882EEFF04957B16F849B4901B3F7.jpg','测试3',102.00,102.00,'8974A9EED7CA498C93B602E34B5608EB'),('1C11F455772D4E6BB15279B3397E9C39',2,'A738130583794647899EA9356EB9D911','/images/15/0/407D153676224E2AA65F4C0FF000B07A.jpg','测试5',300.00,600.00,'A444A804181F43F4BE502E6DB3AA7486'),('2D925086688148D48E59CF857F300ED9',2,'6BD1E543E4CD4156B02286E361E04822','/images/3/6/8DE4DD34C51C4EE7B51054E2EAE68F2F.jpg','测试2',12.00,24.00,'B4B1411EF34744339342E0B9BF1BD277'),('3D80E4AF121C43E2A69759367BB6A74B',13,'1D9FDEA64E6B4DF3B52D2869AAEE33E0','/images/15/15/A215D3B8F95C45D0BCC32769FB69B691.jpg','橙子',12.50,162.50,'E9D0276BFD074E9A8F72E40E98E91453'),('4475FBA3D2C34E278DCE5A8922E467ED',3,'228B3A2ABFDA4E9B9DD1BB61179FB977','/images/1/10/D7574813276C4F1C9E0916D7D8B39EFE.jpg','吹风筒',998.88,2996.64,'20D37DD0A2FC4FC0A98B833F9FBEFB08'),('5E0050EA84624C4DA1FD5664A4F08BB7',5,'1D9FDEA64E6B4DF3B52D2869AAEE33E0','/images/15/15/A215D3B8F95C45D0BCC32769FB69B691.jpg','橙子',12.50,62.50,'7A4EED6A60404B08ABE1497FDE8D4B87'),('607D05D317814F568E1D4BC237217022',1,'6BD1E543E4CD4156B02286E361E04822','/images/3/6/8DE4DD34C51C4EE7B51054E2EAE68F2F.jpg','测试2',12.00,12.00,'52E6CC4D2F984721A44403C06CD6B67A'),('7620301918CB4E379EFEA7358F1CAD3E',2,'6BD1E543E4CD4156B02286E361E04822','/images/3/6/8DE4DD34C51C4EE7B51054E2EAE68F2F.jpg','测试2',12.00,24.00,'C8C427B7E38C4DB6A58E08745592B394'),('9427B309EE124E93AD63F6C004445198',26,'1D9FDEA64E6B4DF3B52D2869AAEE33E0','/images/15/15/A215D3B8F95C45D0BCC32769FB69B691.jpg','橙子',12.50,325.00,'20D37DD0A2FC4FC0A98B833F9FBEFB08'),('94C1136D9B2F4A4EB83873CE7D747BC2',9,'2003808CAECC47C89D592EF10CD80721','/images/10/3/4B9A882EEFF04957B16F849B4901B3F7.jpg','测试3',102.00,918.00,'E9D0276BFD074E9A8F72E40E98E91453'),('A4F814584465454DB3811680AF8A8BD1',2,'2003808CAECC47C89D592EF10CD80721','/images/10/3/4B9A882EEFF04957B16F849B4901B3F7.jpg','测试3',102.00,204.00,'A444A804181F43F4BE502E6DB3AA7486'),('E0B38B29A86F4D40BDF6C69F1EB0A931',2,'6B6886A67771412F8442BE1B6996D796','/images/0/7/E220F74F994D4E02822CAF8267EB4657.jpg','测试4',5.50,11.00,'20D37DD0A2FC4FC0A98B833F9FBEFB08'),('E27C21A50DF44F20873C351B74F39662',3,'2003808CAECC47C89D592EF10CD80721','/images/10/3/4B9A882EEFF04957B16F849B4901B3F7.jpg','测试3',102.00,306.00,'20D37DD0A2FC4FC0A98B833F9FBEFB08'),('F3396E0D155A4EEFA912C7EEFC14E6F1',2,'6BD1E543E4CD4156B02286E361E04822','/images/3/6/8DE4DD34C51C4EE7B51054E2EAE68F2F.jpg','测试2',12.00,24.00,'81C41CCC12234145948E36BC8D2B5FE1'),('F9347D68A87E4E439DC9130C3541D1D2',1,'840C6E9BD014475D8D2E6D24048C3D34','/images/15/7/AC45801C1ED3444A8B12DC9B8B6326D5.jpg','测试',20.35,20.35,'A444A804181F43F4BE502E6DB3AA7486');
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
INSERT INTO `product_info` VALUES ('1D9FDEA64E6B4DF3B52D2869AAEE33E0','橙子',12.50,404,0,'/images/15/15/A215D3B8F95C45D0BCC32769FB69B691.jpg','Test1'),('2003808CAECC47C89D592EF10CD80721','测试3',102.00,22,2,'/images/10/3/4B9A882EEFF04957B16F849B4901B3F7.jpg','Test1'),('228B3A2ABFDA4E9B9DD1BB61179FB977','吹风筒',998.88,5,0,'/images/1/10/D7574813276C4F1C9E0916D7D8B39EFE.jpg','Test1'),('6B6886A67771412F8442BE1B6996D796','测试4',5.50,158,0,'/images/0/7/E220F74F994D4E02822CAF8267EB4657.jpg','Test1'),('6BD1E543E4CD4156B02286E361E04822','测试2',12.00,13,5,'/images/3/6/8DE4DD34C51C4EE7B51054E2EAE68F2F.jpg','Test2'),('840C6E9BD014475D8D2E6D24048C3D34','测试',20.35,21,1,'/images/15/7/AC45801C1ED3444A8B12DC9B8B6326D5.jpg','Test1'),('A738130583794647899EA9356EB9D911','测试5',300.00,33,2,'/images/15/0/407D153676224E2AA65F4C0FF000B07A.jpg','Test1');
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
  `shopStart` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
INSERT INTO `shop_info` VALUES ('Test1','测试店铺','111','2017-05-18 14:05:19'),('Test2','13313213','2132132','2017-05-18 15:56:23'),('Test3','我的店铺','123','2017-05-20 07:01:24'),('Test4','测试店铺','123123123123','2017-05-20 08:04:36'),('Test5','我的店铺','123456789','2017-05-18 15:20:44');
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
  `userIsShop` int(11) DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES ('lcr123','123',NULL,'lcr123',NULL,0,NULL,'','',NULL),('Test1','123','/images/11/13/C81D3AD8B12142E8AFE82916DBEEF88C.jpg','骆成锐','张翼德',1,'2004-12-11','123456','312@23.com',1),('Test2','123','/images/4/10/365A6ADCFB77404B9F764269212F0A45.jpg','曹操','曹孟德',1,'2014-12-11','00000000','55555@88888.com',1),('Test3','123',NULL,'测试3','张三',0,'2014-12-11','123456','312@23.com',1),('Test4','123',NULL,'测试4','张三',0,'2014-12-11','123456','312@23.com',1),('Test5','123',NULL,'李四',NULL,-1,'2017-03-01','123456','123@456.com',1),('Test6','123',NULL,'心累',NULL,1,'2017-05-16','123456','123@456.com',0);
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

-- Dump completed on 2017-05-29 22:28:37

-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: django_mgj
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add goods',7,'add_goods'),(20,'Can change goods',7,'change_goods'),(21,'Can delete goods',7,'delete_goods'),(22,'Can add productdetail',8,'add_productdetail'),(23,'Can change productdetail',8,'change_productdetail'),(24,'Can delete productdetail',8,'delete_productdetail'),(25,'Can add user',9,'add_user'),(26,'Can change user',9,'change_user'),(27,'Can delete user',9,'delete_user'),(28,'Can add cart',10,'add_cart'),(29,'Can change cart',10,'change_cart'),(30,'Can delete cart',10,'delete_cart'),(31,'Can add orderproduct',11,'add_orderproduct'),(32,'Can change orderproduct',11,'change_orderproduct'),(33,'Can delete orderproduct',11,'delete_orderproduct'),(34,'Can add order',12,'add_order'),(35,'Can change order',12,'change_order'),(36,'Can delete order',12,'delete_order');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(10,'mgj','cart'),(7,'mgj','goods'),(12,'mgj','order'),(11,'mgj','orderproduct'),(8,'mgj','productdetail'),(9,'mgj','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-03-14 11:38:23.095400'),(2,'auth','0001_initial','2019-03-14 11:38:24.940855'),(3,'admin','0001_initial','2019-03-14 11:38:25.374310'),(4,'admin','0002_logentry_remove_auto_add','2019-03-14 11:38:25.525119'),(5,'contenttypes','0002_remove_content_type_name','2019-03-14 11:38:25.724634'),(6,'auth','0002_alter_permission_name_max_length','2019-03-14 11:38:25.890110'),(7,'auth','0003_alter_user_email_max_length','2019-03-14 11:38:26.032689'),(8,'auth','0004_alter_user_username_opts','2019-03-14 11:38:26.060825'),(9,'auth','0005_alter_user_last_login_null','2019-03-14 11:38:26.129952'),(10,'auth','0006_require_contenttypes_0002','2019-03-14 11:38:26.133323'),(11,'auth','0007_alter_validators_add_error_messages','2019-03-14 11:38:26.161602'),(12,'auth','0008_alter_user_username_max_length','2019-03-14 11:38:26.927789'),(13,'sessions','0001_initial','2019-03-14 11:38:27.007337'),(14,'mgj','0001_initial','2019-03-14 11:46:24.322455'),(15,'mgj','0002_productdetail','2019-03-14 12:10:26.192098'),(16,'mgj','0003_productdetail_status','2019-03-14 12:19:14.370841'),(17,'mgj','0004_user','2019-03-15 03:03:46.395944'),(18,'mgj','0005_auto_20190315_0634','2019-03-15 06:35:03.421593'),(19,'mgj','0006_cart','2019-03-15 07:58:32.674269'),(20,'mgj','0007_productdetail_type','2019-03-15 11:32:11.662198'),(21,'mgj','0008_order_orderproduct','2019-03-16 06:40:06.287415'),(22,'mgj','0009_auto_20190316_0956','2019-03-16 09:57:04.410965'),(23,'mgj','0010_order_ordermoney','2019-03-16 14:48:24.516582');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7pjnsl5arq2v18tod3fl4dp14rbkfh0g','YWY1Yjc2MTkyYTNmMDUzYTAzNjk2YjBlYTllYzcyYmViYWRmNjMyNDp7InRva2VuIjoiYTY2MmZjOTRhNDA4YzQ1MDE0YjQzNjMyYjlmN2I4ODQifQ==','2019-04-01 06:24:34.111754'),('ikp03yrwwbrjiuttge08pt4zx89168r5','ZjQyYjZhZWQwYzdlNTc2NDFjN2ZiOTI1ZDQzZWVjMzA4MGJhYmRlYzp7InRva2VuIjoiODExNmU0ZDc3ZWJhZTA3YWRjYWM0NWU5YWU2NTNlNTMifQ==','2019-03-30 14:52:06.883917');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mgj_cart`
--

DROP TABLE IF EXISTS `mgj_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mgj_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productnumber` int(11) NOT NULL,
  `isselect` tinyint(1) NOT NULL,
  `isdelete` tinyint(1) NOT NULL,
  `productdetail_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mgj_cart_productdetail_id_1d5e101e_fk_mgj_productdetail_id` (`productdetail_id`),
  KEY `mgj_cart_user_id_33455171_fk_mgj_user_id` (`user_id`),
  CONSTRAINT `mgj_cart_productdetail_id_1d5e101e_fk_mgj_productdetail_id` FOREIGN KEY (`productdetail_id`) REFERENCES `mgj_productdetail` (`id`),
  CONSTRAINT `mgj_cart_user_id_33455171_fk_mgj_user_id` FOREIGN KEY (`user_id`) REFERENCES `mgj_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mgj_cart`
--

LOCK TABLES `mgj_cart` WRITE;
/*!40000 ALTER TABLE `mgj_cart` DISABLE KEYS */;
INSERT INTO `mgj_cart` VALUES (5,2,1,0,8,3);
/*!40000 ALTER TABLE `mgj_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mgj_goods`
--

DROP TABLE IF EXISTS `mgj_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mgj_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `decription` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mgj_goods`
--

LOCK TABLES `mgj_goods` WRITE;
/*!40000 ALTER TABLE `mgj_goods` DISABLE KEYS */;
INSERT INTO `mgj_goods` VALUES (1,'static/img/youxuan1.jpg','蘑菇优选','优质生活 值得更好'),(2,'static/img/youxuan2.jpg','品质精选','9月暖心好物推荐'),(3,'static/img/youxuan3.jpg','品质热卖','亲肤毛巾 超强吸水'),(4,'static/img/nvzhuang01.jpg','潮流女装','新款秋装火热购'),(5,'static/img/nvzhuang05.jpg','时尚套装','超值时髦搭配'),(6,'static/img/xiezi02.jpg','女鞋强新','秋款10000双'),(7,'static/img/xiezi04.jpg','运动鞋','39元起'),(8,'static/img/boy04.jpg','裤装','腿长出天际');
/*!40000 ALTER TABLE `mgj_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mgj_order`
--

DROP TABLE IF EXISTS `mgj_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mgj_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `status` int(11) NOT NULL,
  `orderid` varchar(256) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ordermoney` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mgj_order_user_id_8ed0b463_fk_mgj_user_id` (`user_id`),
  CONSTRAINT `mgj_order_user_id_8ed0b463_fk_mgj_user_id` FOREIGN KEY (`user_id`) REFERENCES `mgj_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mgj_order`
--

LOCK TABLES `mgj_order` WRITE;
/*!40000 ALTER TABLE `mgj_order` DISABLE KEYS */;
INSERT INTO `mgj_order` VALUES (1,'2019-03-16 09:58:20.161438','2019-03-18 06:38:47.287332',0,'15527303002608',2,55),(2,'2019-03-16 11:14:54.215757','2019-03-18 06:38:47.293318',0,'15527348941672',2,49.9),(5,'2019-03-16 13:43:29.101530','2019-03-18 06:38:47.304812',0,'15527438096169',2,9.9),(6,'2019-03-18 06:15:02.396711','2019-03-18 06:38:47.314388',0,'15528897025041',2,39.8);
/*!40000 ALTER TABLE `mgj_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mgj_orderproduct`
--

DROP TABLE IF EXISTS `mgj_orderproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mgj_orderproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mgj_orderproduct_order_id_81337210_fk_mgj_order_id` (`order_id`),
  KEY `mgj_orderproduct_products_id_1b7f2bf6_fk_mgj_productdetail_id` (`products_id`),
  CONSTRAINT `mgj_orderproduct_order_id_81337210_fk_mgj_order_id` FOREIGN KEY (`order_id`) REFERENCES `mgj_order` (`id`),
  CONSTRAINT `mgj_orderproduct_products_id_1b7f2bf6_fk_mgj_productdetail_id` FOREIGN KEY (`products_id`) REFERENCES `mgj_productdetail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mgj_orderproduct`
--

LOCK TABLES `mgj_orderproduct` WRITE;
/*!40000 ALTER TABLE `mgj_orderproduct` DISABLE KEYS */;
INSERT INTO `mgj_orderproduct` VALUES (1,1,1,8),(2,1,2,6),(3,1,5,5),(4,2,6,4);
/*!40000 ALTER TABLE `mgj_orderproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mgj_productdetail`
--

DROP TABLE IF EXISTS `mgj_productdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mgj_productdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(100) NOT NULL,
  `smallImg` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` double NOT NULL,
  `sales` varchar(100) NOT NULL,
  `oldprice` double NOT NULL,
  `store` int(11) NOT NULL,
  `background` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mgj_productdetail`
--

LOCK TABLES `mgj_productdetail` WRITE;
/*!40000 ALTER TABLE `mgj_productdetail` DISABLE KEYS */;
INSERT INTO `mgj_productdetail` VALUES (4,'newImg/pic4.jpg','newImg/pic4.jpg','【买一送五】韩国爱丽小屋眉笔防水防汗不晕染不脱色一字眉带眉刷',19.9,'27990',29.7,301,'newImg/background04.jpg','','眉笔'),(5,'newImg/pic5.jpg','newImg/pic5.jpg','番茄派山羊奶滋润护手霜80g*2 清爽滋润保湿补水',9.9,'97990',19.7,3021,'newImg/background05.jpg','','护手霜'),(6,'newImg/pic7.jpg','newImg/pic7.jpg','雪纺防晒衫女长袖夏季中长款防晒衣雪纺开衫透明防晒服披肩薄外套',49.9,'17990',69.7,321,'newImg/background07.jpg','热卖','防晒衣'),(7,'newImg/pic8.jpg','newImg/pic8.jpg','【套装】新款时尚连帽卫衣显瘦金丝绒韩版休闲裤运动服两件套装',77,'1090',89.7,31,'newImg/background08.jpg','良品','运动服'),(8,'newImg/pic9.jpg','newImg/pic9.jpg','秋季新款 复古文艺 棉麻宽松口袋长袖粉色衬衫女',55,'1090',59.7,2021,'newImg/background09.jpg','热卖','衬衫');
/*!40000 ALTER TABLE `mgj_productdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mgj_user`
--

DROP TABLE IF EXISTS `mgj_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mgj_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mgj_user`
--

LOCK TABLES `mgj_user` WRITE;
/*!40000 ALTER TABLE `mgj_user` DISABLE KEYS */;
INSERT INTO `mgj_user` VALUES (1,'a123','a12345'),(2,'aaa','0b4e7a0e5fe84ad35fb5f95b9ceeac79'),(3,'aaaa','0b4e7a0e5fe84ad35fb5f95b9ceeac79');
/*!40000 ALTER TABLE `mgj_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-18  0:07:46

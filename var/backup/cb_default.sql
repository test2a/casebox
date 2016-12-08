-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: ecmrs
-- ------------------------------------------------------
-- Server version	5.5.53-0ubuntu0.14.04.1

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
-- Table structure for table `action_log`
--

DROP TABLE IF EXISTS `action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `object_pid` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `action_type` enum('create','update','delete','complete','completion_decline','completion_on_behalf','close','rename','reopen','status_change','overdue','comment','comment_update','move','password_change','permissions','user_delete','user_create','login','login_fail','file_upload','file_update') NOT NULL,
  `action_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` mediumtext,
  `activity_data_db` mediumtext,
  `activity_data_solr` mediumtext,
  PRIMARY KEY (`id`),
  KEY `FK_action_log__object_id` (`object_id`),
  KEY `FK_action_log__object_pid` (`object_pid`),
  KEY `FK_action_log__user_id` (`user_id`),
  KEY `IDX_action_time` (`action_time`),
  CONSTRAINT `FK_action_log__object_id` FOREIGN KEY (`object_id`) REFERENCES `tree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_action_log__object_pid` FOREIGN KEY (`object_pid`) REFERENCES `tree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_action_log__user_id` FOREIGN KEY (`user_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1766 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_log`
--

LOCK TABLES `action_log` WRITE;
/*!40000 ALTER TABLE `action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `param` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `order` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=664 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (104,NULL,'project_name_en','ECMRS - Electronic Case Record Management System',NULL),(105,NULL,'templateIcons','\nfa fa-arrow-circle-left fa-fl\nfa fa-arrow-circle-o-left fa-fl\nfa fa-arrow-circle-o-right fa-fl\nfa fa-arrow-circle-right fa-fl\nfa fa-arrow-left fa-fl\nfa fa-arrow-right fa-fl\nfa fa-book fa-fl\nfa fa-bookmark fa-fl\nfa fa-bookmark-o fa-fl\nfa fa-briefcase fa-fl\nfa fa-bug fa-fl\nfa fa-building fa-fl\nfa fa-building-o fa-fl\nfa fa-calendar-o fa-fl\nfa fa-camera fa-fl\nfa fa-comment fa-fl\nfa fa-comment-o fa-fl\nfa fa-commenting fa-fl\nfa fa-commenting-o fa-fl\nfa fa-comments fa-fl\nfa fa-comments-o fa-fl\nfa fa-envelope fa-fl\nfa fa-envelope-o fa-fl\nfa fa-external-link fa-fl\nfa fa-external-link-square  fa-fl\nfa fa-file fa-fl\nfa fa-file-archive-o fa-fl\nfa fa-file-audio-o fa-fl\nfa fa-file-code-o fa-fl\nfa fa-file-excel-o fa-fl\nfa fa-file-image-o fa-fl\nfa fa-file-movie-o fa-fl\nfa fa-file-o fa-fl\nfa fa-file-pdf-o fa-fl\nfa fa-file-photo-o fa-fl\nfa fa-file-picture-o fa-fl\nfa fa-file-powerpoint-o fa-fl\nfa fa-file-sound-o fa-fl\nfa fa-file-text fa-fl\nfa fa-file-text-o fa-fl\nfa fa-file-video-o fa-fl\nfa fa-file-word-o fa-fl\nfa fa-file-zip-o fa-fl\nfa fa-files-o fa-fl\nfa fa-film fa-fl\nfa fa-flash fa-fl\nfa fa-folder fa-fl\nfa fa-folder-o fa-fl\nfa fa-folder-open fa-fl\nfa fa-folder-open-o fa-fl\nfa fa-foursquare fa-fl\nfa fa-gavel fa-fl\nfa fa-gear fa-fl\nfa fa-gears fa-fl\nfa fa-info fa-fl\nfa fa-info-circle fa-fl\nfa fa-institution fa-fl\nfa fa-link fa-fl\nfa fa-print fa-fl\nfa fa-stack-exchange fa-fl\nfa fa-sticky-note fa-fl\nfa fa-sticky-note-o fa-fl\nfa fa-suitcase fa-fl\nfa fa-tasks fa-fl\nfa fa-university fa-fl\nfa fa-unlink fa-fl\nfa fa-user fa-fl\nfa fa-user-md fa-fl\nfa fa-user-plus fa-fl\nfa fa-user-secret fa-fl\nfa fa-user-times fa-fl\nfa fa-users fa-fl\nfa fa-warning fa-fl\nfa fa-wpforms fa-fl',NULL),(106,NULL,'folder_templates','5,11,100',NULL),(107,NULL,'default_folder_template','5',NULL),(108,NULL,'default_file_template','6',NULL),(109,NULL,'default_task_template','7',NULL),(110,NULL,'default_language','en',NULL),(111,NULL,'languages','en',NULL),(112,NULL,'object_type_plugins','{\r\n  \"object\": [\"objectProperties\", \"files\", \"tasks\", \"contentItems\", \"comments\", \"systemProperties\"]\r\n  ,\"case\": [\"objectProperties\", \"files\", \"tasks\", \"contentItems\", \"comments\", \"systemProperties\"]\r\n  ,\"task\": [\"objectProperties\", \"files\", \"contentItems\", \"comments\", \"systemProperties\"]\r\n  ,\"file\": [\"thumb\", \"meta\", \"versions\", \"tasks\", \"comments\", \"systemProperties\"]\r\n}',NULL),(113,NULL,'treeNodes','',NULL),(114,113,'Tasks','{\n    \"pid\": 1\n}',1),(115,113,'Dbnode','[]',2),(116,113,'RecycleBin','{\r\n    \"pid\": \"1\",\r\n    \"facets\": [\r\n        \"did\"\r\n    ],\r\n    \"DC\": {\r\n        \"nid\": {}\r\n        ,\"name\": {}\r\n        ,\"cid\": {}\r\n        ,\"ddate\": {\r\n            \"solr_column_name\": \"ddate\"\r\n        }\r\n    }\r\n}',3),(117,NULL,'default_object_plugins','{\n\"objectProperties\": {\n\"visibility\": {\n\"!context\": \"window\"\n,\"!template_type\": \"file\"\n}\n,\"order\": 0\n}\n,\"files\": {\n\"visibility\": {\n\"template_type\": \"object,search,case,task\"\n}\n,\"order\": 2\n}\n,\"tasks\": {\n\"visibility\": {\n\"template_type\": \"object,search,case,task\"\n}\n,\"order\": 3\n}\n,\"contentItems\": {\n\"visibility\": {\n\"!template_type\": \"file,time_tracking\"\n}\n,\"order\": 4\n}\n,\"thumb\": {\n\"visibility\": {\n\"!context\": \"window\"\n,\"template_type\": \"file\"\n}\n,\"order\": 5\n}\n,\"currentVersion\": {\n\"visibility\": {\n\"context\": \"window\"\n,\"template_type\": \"file\"\n}\n,\"order\": 6\n}\n,\"versions\": {\n\"visibility\": {\n\"template_type\": \"file\"\n}\n,\"order\": 7\n}\n,\"meta\": {\n\"visibility\": {\n\"template_type\": \"file\"\n}\n,\"order\": 8\n}\n,\"comments\": {\n\"order\": 9\n,\"visibility\": {\n\"!template_type\": \"time_tracking\"\n}\n\n}\n}',NULL),(118,NULL,'files','{\r\n  \"max_versions\": \"*:1;php,odt,doc,docx,xls,xlsx:20;pdf:5;png,gif,jpg,jpeg,tif,tiff:2;\"\r\n\r\n  ,\"edit\" : {\r\n    \"text\": \"txt,php,js,xml,csv\"\r\n    ,\"html\": \"html,htm\"\r\n    ,\"webdav\": \"doc,docx,ppt,dot,dotx,xls,xlsm,xltx,ppt,pot,pps,pptx,odt,ott,odm,ods,odg,otg,odp,odf,odb\"\r\n  }\r\n\r\n  ,\"webdav_url\": \"https://webdav.host.com/{core_name}/edit-{node_id}/{name}\"\r\n}',NULL),(119,NULL,'timezone','UTC',NULL),(120,NULL,'language_en','{\r\n\"name\": \"English\"\r\n,\"locale\": \"en_US\"\r\n,\"long_date_format\": \"%F %j, %Y\"\r\n,\"short_date_format\": \"%m/%d/%Y\"\r\n,\"time_format\": \"%H:%i\"\r\n}',NULL),(121,NULL,'language_fr','{\r\n\"name\": \"French\"\r\n,\"locale\": \"fr_FR\"\r\n,\"long_date_format\": \"%j %F %Y\"\r\n,\"short_date_format\": \"%d.%m.%Y\"\r\n,\"time_format\": \"%H:%i\"\r\n}\r\n',NULL),(122,NULL,'language_ru','{\r\n\"name\": \"Русский\"\r\n,\"locale\": \"ru_RU\"\r\n,\"long_date_format\": \"%j %F %Y\"\r\n,\"short_date_format\": \"%d.%m.%Y\"\r\n,\"time_format\": \"%H:%i\"\r\n}',NULL),(123,NULL,'default_facet_configs','{\r\n  \"template_type\": {\r\n    \"title\": \"[Type]\"\r\n    ,\"type\": \"objectTypes\"\r\n  }\r\n  ,\"template\": {\r\n    \"title\": \"[Template]\"\r\n    ,\"field\": \"template_id\"\r\n    ,\"type\": \"objects\"\r\n  }\r\n  ,\"creator\": {\r\n    \"title\": \"[Creator]\"\r\n    ,\"field\": \"cid\"\r\n    ,\"type\": \"users\"\r\n  }\r\n  ,\"owner\": {\r\n    \"title\": \"[Owner]\"\r\n    ,\"field\": \"oid\"\r\n    ,\"type\": \"users\"\r\n  }\r\n  ,\"updater\": {\r\n    \"title\": \"Updater\"\r\n    ,\"field\": \"uid\"\r\n    ,\"type\": \"users\"\r\n  }\r\n  ,\"date\": {\r\n    \"title\": \"[Date]\"\r\n    ,\"facet\": \"query\"\r\n    ,\"type\": \"dates\"\r\n    ,\"manualPeriod\": true\r\n    ,\"queries\": [\r\n      \"today\"\r\n      ,\"yesterday\"\r\n      ,\"week\"\r\n      ,\"month\"\r\n    ]\r\n    ,\"boolMode\": true\r\n  }\r\n  ,\"date_end\": {\r\n    \"title\": \"End date\"\r\n    ,\"facet\": \"query\"\r\n    ,\"type\": \"dates\"\r\n    ,\"queries\": [\r\n      \"today\"\r\n      ,\"week\"\r\n      ,\"next7days\"\r\n      ,\"next31days\"\r\n      ,\"month\"\r\n    ]\r\n    ,\"boolMode\": true\r\n  }\r\n  ,\"status\": {\r\n    \"title\": \"[Status]\"\r\n    ,\"type\": \"objects\"\r\n }\r\n  ,\"task_status\": {\r\n    \"title\": \"[Status]\"\r\n    ,\"type\": \"taskStatuses\"\r\n }\r\n  ,\"assigned\": {\r\n    \"title\": \"[TaskAssigned]\"\r\n    ,\"field\": \"task_u_assignee\"\r\n    ,\"type\": \"users\"\r\n    ,\"boolMode\": true\r\n  }, \"client_status\": {\r\n\"field\": \"client_status_i\"\r\n,\"title\": \"Client Status\"\r\n,\"type\": \"objects\"\r\n}, \"lat_lon\": {\r\n\"field\": \"latlon_d\"\r\n,\"title\": \"Lat/Lon\"\r\n,\"type\": \"objects\"\r\n},\r\n\"fema_tier\": {\r\n\"field\": \"fema_tier_i\"\r\n,\"title\": \"FEMA Tier\"\r\n,\"type\": \"objects\"\r\n}\r\n}',NULL),(124,NULL,'node_facets','{\r\n\"1\" : [\r\n  \"template_type\"\r\n  ,\"creator\"\r\n  ,\"template\"\r\n  ,\"date\"\r\n  ,\"status\"\r\n  ,\"assigned\"\r\n],\r\n\"150\" : [\r\n \"client_status\"\r\n]\r\n\r\n}',NULL),(125,NULL,'default_object_plugins','{\r\n  \"objectProperties\": {\r\n    \"visibility\": {\r\n      \"!context\": \"window\"\r\n      ,\"!template_type\": \"file\"\r\n    }\r\n    ,\"order\": 0\r\n  }\r\n  ,\"files\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"object,search,case,task\"\r\n    }\r\n    ,\"order\": 2\r\n  }\r\n  ,\"tasks\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"object,search,case,task\"\r\n    }\r\n    ,\"order\": 3\r\n  }\r\n  ,\"contentItems\": {\r\n    \"visibility\": {\r\n      \"!template_type\": \"file,time_tracking\"\r\n    }\r\n    ,\"order\": 4\r\n  }\r\n  ,\"thumb\": {\r\n    \"visibility\": {\r\n      \"!context\": \"window\"\r\n      ,\"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 5\r\n  }\r\n  ,\"currentVersion\": {\r\n    \"visibility\": {\r\n      \"context\": \"window\"\r\n      ,\"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 6\r\n  }\r\n  ,\"versions\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 7\r\n  }\r\n  ,\"meta\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 8\r\n  }\r\n  ,\"comments\": {\r\n    \"order\": 9\r\n    ,\"visibility\": {\r\n      \"!template_type\": \"time_tracking\"\r\n    }\r\n\r\n  }\r\n}',NULL),(126,NULL,'images_display_size','512000',NULL),(127,NULL,'default_DC','{\r\n\"nid\": {}\r\n,\"name\": {\r\n  \"solr_column_name\": \"name\"\r\n}\r\n,\"cid\": {\r\n  \"solr_column_name\": \"cid\"\r\n}\r\n,\"oid\": {\r\n  \"solr_column_name\": \"oid\"\r\n}\r\n,\"cdate\": {\r\n  \"solr_column_name\": \"cdate\"\r\n}\r\n,\"udate\": {\r\n  \"solr_column_name\": \"udate\"\r\n}\r\n}',NULL),(128,NULL,'default_availableViews','grid,charts,pivot,activityStream,calendar',NULL),(129,NULL,'DCConfigs','',NULL),(130,129,'dc_tasks','{\r\n    \"nid\":[]\r\n    ,\"name\":[]\r\n    ,\"importance\":{\"solr_column_name\":\"task_importance\"}\r\n    ,\"order\":{\r\n        \"solr_column_name\":\"task_order\"\r\n        ,\"sortType\":\"asInt\"\r\n        ,\"align\":\"center\"\r\n        ,\"columnWidth\":\"10\"\r\n    }\r\n    ,\"time_estimated\":{\r\n        \"width\":\"20px\"\r\n        ,\"format\":\"H:i\"\r\n    }\r\n    ,\"phase\": {\r\n        \"solr_column_name\": \"task_phase\"\r\n    }\r\n    ,\"project\": {\r\n        \"solr_column_name\": \"task_projects\"\r\n    }\r\n    ,\"cid\":[]\r\n    ,\"assigned\":[]\r\n    ,\"comment_user_id\":[]\r\n    ,\"comment_date\":[]\r\n    ,\"cdate\":[]\r\n}',NULL),(131,129,'dc_tasks_closed','{\r\n    \"nid\":[]\r\n    ,\"name\":[]\r\n    ,\"importance\":{\"solr_column_name\":\"task_importance\"}\r\n    ,\"order\":{\"solr_column_name\":\"task_order\"\r\n        ,\"sortType\":\"asInt\"\r\n        ,\"align\":\"center\"\r\n        ,\"columnWidth\":\"10\"\r\n    }\r\n    ,\"project\": {\r\n        \"solr_column_name\": \"task_projects\"\r\n    }    \r\n    ,\"time_completed\":{\r\n        \"columnWidth\":\"20\"\r\n        ,\"format\":\"H:i\"\r\n    }\r\n    ,\"time_estimated\":{\r\n        \"width\":\"20px\"\r\n        ,\"format\":\"H:i\"\r\n    }\r\n    ,\"task_d_closed\":{\r\n        \"solr_column_name\":\"task_d_closed\"\r\n        ,\"xtype\":\"datecolumn\"\r\n        ,\"format\":\"Y-m-d\"\r\n        ,\"title\":\"Closed date\"\r\n    }\r\n    ,\"cid\":[]\r\n    ,\"cdate\":[]\r\n    ,\"assigned\":[]\r\n    ,\"comment_user_id\":[]\r\n    ,\"comment_date\":[]\r\n}',NULL),(132,NULL,'geoMapping','true',NULL),(152,113,'This','{\n\"pid\": 150\n}',NULL),(288,113,'CasesByStatus','{\n\"class\": \"CB\\\\TreeNode\\\\FacetNav\",\n\"pid\": 1,\n\"iconCls\": \"icon-case\",\n\"title_en\": \"Clients By Status\",\n\"fq\": [\n\"template_id: 141\"\n],\n\"level_fields\": \"client_status, fema_tier\",\n\"facets\": [\n\"client_status\",\n\"fema_tier\"\n],\n\"sort\": {\n\"property\": \"_lastname\",\n\"direction\": \"DESC\"\n},\n\"view\": \"grid\",\n\"show_count\": true,\n\"show_in_tree\": true\n}',NULL),(663,129,'dc_cases_fema','{\n\"nid\":[]\n,\"name\":[]\n,\"importance\":{\"solr_column_name\":\"fema_tier_i\"}\n,\"order\":{\n\"solr_column_name\":\"task_order\"\n,\"sortType\":\"asInt\"\n,\"align\":\"center\"\n,\"columnWidth\":\"10\"\n}\n,\"time_estimated\":{\n\"width\":\"20px\"\n,\"format\":\"H:i\"\n}\n,\"phase\": {\n\"solr_column_name\": \"task_phase\"\n}\n,\"project\": {\n\"solr_column_name\": \"task_projects\"\n}\n,\"cid\":[]\n,\"assigned\":[]\n,\"comment_user_id\":[]\n,\"comment_date\":[]\n,\"cdate\":[]\n}\n\n',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crons`
--

DROP TABLE IF EXISTS `crons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cron_id` varchar(30) DEFAULT NULL,
  `cron_file` varchar(500) DEFAULT NULL,
  `last_start_time` timestamp NULL DEFAULT NULL,
  `last_end_time` timestamp NULL DEFAULT NULL,
  `execution_info` longtext,
  `last_action` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crons`
--

LOCK TABLES `crons` WRITE;
/*!40000 ALTER TABLE `crons` DISABLE KEYS */;
/*!40000 ALTER TABLE `crons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `node_id` varchar(20) DEFAULT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_previews`
--

DROP TABLE IF EXISTS `file_previews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_previews` (
  `id` bigint(20) unsigned NOT NULL,
  `group` varchar(20) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 - ok, 1 - on queue, 2 - processing, 3 - processed',
  `filename` varchar(100) DEFAULT NULL,
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ladate` timestamp NULL DEFAULT NULL COMMENT 'last access date',
  PRIMARY KEY (`id`),
  KEY `tree_previews__status_group` (`group`,`status`),
  CONSTRAINT `FK_file_previews_content_id` FOREIGN KEY (`id`) REFERENCES `files_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_previews`
--

LOCK TABLES `file_previews` WRITE;
/*!40000 ALTER TABLE `file_previews` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_previews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` bigint(20) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `cid` int(10) unsigned NOT NULL DEFAULT '1',
  `uid` int(10) unsigned NOT NULL DEFAULT '1',
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `udate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `FK_files__content_id` (`content_id`),
  CONSTRAINT `FK_files__content_id` FOREIGN KEY (`content_id`) REFERENCES `files_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_files__id` FOREIGN KEY (`id`) REFERENCES `tree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=889 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_ai` AFTER INSERT ON `files` FOR EACH ROW BEGIN

	UPDATE tree SET

		`name` = new.name

		, `date` = COALESCE(new.date, new.cdate)

		, cid = new.cid

		, cdate = new.cdate

		, uid = new.uid

		, udate = new.udate

		, size = (SELECT size FROM files_content WHERE id = new.content_id)

	WHERE id = new.id;

	if(new.content_id is not null) THEN

		update files_content set ref_count = ref_count + 1 where id = new.content_id;

	end if;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_au` AFTER UPDATE ON `files` FOR EACH ROW BEGIN

	UPDATE tree SET

		`name` = new.name

		, `date` = coalesce(new.date, new.cdate)

		, date_end = COALESCE(new.date, new.cdate)

		, cid = new.cid

		, cdate = new.cdate

		, uid = new.uid

		, udate = new.udate

		, updated = (updated | 1)

		, size = (select size from files_content where id = new.content_id)

	WHERE id = new.id;

	if(coalesce(old.content_id, 0) <> coalesce(new.content_id, 0) ) then

		IF(old.content_id IS NOT NULL) THEN

			UPDATE files_content SET ref_count = ref_count - 1 WHERE id = old.content_id;

		END IF;

		IF(new.content_id IS NOT NULL) THEN

			UPDATE files_content SET ref_count = ref_count + 1 WHERE id = new.content_id;

		END IF;

	end if;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_ad` AFTER DELETE ON `files` FOR EACH ROW BEGIN

	IF(old.content_id IS NOT NULL) THEN

		UPDATE files_content SET ref_count = ref_count - 1 WHERE id = old.content_id;

	END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `files_content`
--

DROP TABLE IF EXISTS `files_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_content` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `size` bigint(20) unsigned DEFAULT NULL,
  `pages` int(11) unsigned DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `path` varchar(250) DEFAULT NULL,
  `ref_count` int(11) NOT NULL DEFAULT '0',
  `parse_status` tinyint(1) unsigned DEFAULT NULL,
  `skip_parsing` tinyint(1) NOT NULL DEFAULT '0',
  `md5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_md5` (`md5`),
  KEY `idx_size` (`size`),
  KEY `idx_parse_status` (`parse_status`),
  KEY `idx_skip_parsing` (`skip_parsing`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_content`
--

LOCK TABLES `files_content` WRITE;
/*!40000 ALTER TABLE `files_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `files_content` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_content_bi` BEFORE INSERT ON `files_content` FOR EACH ROW BEGIN

	if( (coalesce(new.size, 0) = 0) or (new.type like 'image%') ) THEN

		set new.skip_parsing = 1;

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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_content_au` AFTER UPDATE ON `files_content` FOR EACH ROW BEGIN

	update tree, files set tree.updated = (tree.updated | 1) where files.content_id = NEW.id and files.id = tree.id;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `files_versions`
--

DROP TABLE IF EXISTS `files_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_versions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) unsigned NOT NULL,
  `content_id` bigint(20) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `cid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `udate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_file_id` (`file_id`),
  KEY `FK_content_id` (`content_id`),
  CONSTRAINT `FK_content_id` FOREIGN KEY (`content_id`) REFERENCES `files_content` (`id`),
  CONSTRAINT `FK_file_id` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_versions`
--

LOCK TABLES `files_versions` WRITE;
/*!40000 ALTER TABLE `files_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `files_versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_versions_ai` AFTER INSERT ON `files_versions` FOR EACH ROW BEGIN

	if(new.content_id is not null) THEN

		update files_content set ref_count = ref_count + 1 where id = new.content_id;

	end if;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_versions_au` AFTER UPDATE ON `files_versions` FOR EACH ROW BEGIN

	if(coalesce(old.content_id, 0) <> coalesce(new.content_id, 0) ) then

		IF(old.content_id IS NOT NULL) THEN

			UPDATE files_content SET ref_count = ref_count - 1 WHERE id = old.content_id;

		END IF;

		IF(new.content_id IS NOT NULL) THEN

			UPDATE files_content SET ref_count = ref_count + 1 WHERE id = new.content_id;

		END IF;

	end if;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `files_versions_ad` AFTER DELETE ON `files_versions` FOR EACH ROW BEGIN

	IF(old.content_id IS NOT NULL) THEN

		UPDATE files_content SET ref_count = ref_count - 1 WHERE id = old.content_id;

	END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `guids`
--

DROP TABLE IF EXISTS `guids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guids` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guids_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guids`
--

LOCK TABLES `guids` WRITE;
/*!40000 ALTER TABLE `guids` DISABLE KEYS */;
INSERT INTO `guids` VALUES (6,'CasesByStatus'),(2,'Dbnode'),(4,'Person'),(3,'RecycleBin'),(1,'Tasks'),(5,'This');
/*!40000 ALTER TABLE `guids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned DEFAULT NULL COMMENT 'think to remove it (doubles field from action_log)',
  `action_id` bigint(20) unsigned NOT NULL,
  `action_ids` mediumtext COMMENT 'list of last action ids for same grouped action',
  `action_type` enum('create','update','delete','complete','completion_decline','completion_on_behalf','close','rename','reopen','status_change','overdue','comment','comment_update','move','password_change','permissions','user_delete','user_create','login','login_fail','file_upload','file_update') NOT NULL,
  `action_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'think to remove it (doubles field from action_log)',
  `prev_action_ids` text COMMENT 'previous action ids(for same obj, action type, user) that have not yet been read',
  `from_user_id` int(11) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `read` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'notification has been read in CB',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_notifications` (`object_id`,`action_type`,`from_user_id`,`user_id`),
  KEY `FK_notifications__action_id` (`action_id`),
  KEY `FK_notifications_user_id` (`user_id`),
  KEY `IDX_notifications_seen` (`seen`),
  CONSTRAINT `FK_notifications_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_notifications__action_id` FOREIGN KEY (`action_id`) REFERENCES `action_log` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data` mediumtext,
  `sys_data` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'{\"_title\":\"Tree\",\"en\":\"Tree\"}',NULL),(2,'{\"_title\":\"System\",\"en\":\"System\"}',NULL),(3,'{\"_title\":\"Templates\",\"en\":\"Templates\"}',NULL),(4,'{\"_title\":\"Thesauri Item\"}','{\"wu\":[],\"solr\":{\"content\":\"Thesauri Item\\n\"},\"lastAction\":{\"type\":\"update\",\"time\":\"2016-10-03T14:14:04Z\",\"users\":{\"1\":\"298\"}}}'),(5,'{\"_title\":\"folder\",\"en\":\"Folder\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-folder\",\"cfg\":\"{\\\"createMethod\\\":\\\"inline\\\",\\n  \\\"DC\\\": {\\n    \\\"nid\\\": {},\\n    \\\"name\\\": {},\\n    \\\"oid\\\": { \\\"title\\\": \\\"Case Manager\\\"},\\n    \\\"cid\\\": { \\\"title\\\": \\\"Entered By\\\"},\\n    \\\"cdate\\\": { \\\"title\\\": \\\"Entered Date\\\"}\\n  },\\n  \\\"object_plugins\\\":\\n      [\\\"comments\\\",\\n       \\\"systemProperties\\\"\\n      ]\\n\\n}\",\"title_template\":\"{name}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1195\"},\"time\":\"2016-10-21T16:13:42Z\"},\"solr\":{\"content\":\"folder\\nFolder\\nobject\\n1\\nicon-folder\\n{\\\"createMethod\\\":\\\"inline\\\",\\n  \\\"DC\\\": {\\n    \\\"nid\\\": {},\\n    \\\"name\\\": {},\\n    \\\"oid\\\": { \\\"title\\\": \\\"Case Manager\\\"},\\n    \\\"cid\\\": { \\\"title\\\": \\\"Entered By\\\"},\\n    \\\"cdate\\\": { \\\"title\\\": \\\"Entered Date\\\"}\\n  },\\n  \\\"object_plugins\\\":\\n      [\\\"comments\\\",\\n       \\\"systemProperties\\\"\\n      ]\\n\\n}\\n{name}\\n\"},\"wu\":[]}'),(6,'{\"_title\":\"file_template\",\"en\":\"File\",\"type\":\"file\",\"visible\":1,\"iconCls\":\"fa fa-file fa-fl\",\"title_template\":\"{name}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"4\"},\"time\":\"2016-06-09T13:50:28Z\"},\"solr\":{\"content\":\"file_template\\nFile\\nfile\\n1\\nfa fa-file fa-fl\\n{name}\\n\"},\"wu\":[]}'),(7,'{\"_title\":\"task\",\"en\":\"Task\",\"type\":\"task\",\"visible\":1,\"iconCls\":\"icon-task\",\"title_template\":\"{name}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"234\"},\"time\":\"2016-09-29T20:17:28Z\"},\"solr\":{\"content\":\"task\\nTask\\ntask\\n1\\nicon-task\\n{name}\\n\"},\"wu\":[]}'),(8,'{\"_title\":\"Thesauri Item\",\"en\":\"Thesauri Item\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"fa fa-sticky-note fa-fl\",\"title_template\":\"{en}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"6\"},\"time\":\"2016-06-09T13:52:05Z\"},\"solr\":{\"content\":\"Thesauri Item\\nThesauri Item\\nobject\\n1\\nfa fa-sticky-note fa-fl\\n{en}\\n\"},\"wu\":[]}'),(9,'{\"_title\":\"Comment\",\"en\":\"Comment\",\"type\":\"comment\",\"visible\":1,\"iconCls\":\"fa fa-comment fa-fl\",\"cfg\":\"{\\n  \\\"systemType\\\": 2\\n}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"7\"},\"time\":\"2016-06-09T13:52:26Z\"},\"solr\":{\"content\":\"Comment\\nComment\\ncomment\\n1\\nfa fa-comment fa-fl\\n{\\n  \\\"systemType\\\": 2\\n}\\n\"},\"wu\":[]}'),(10,'{\"_title\":\"User\",\"en\":\"User\",\"type\":\"user\",\"visible\":1,\"iconCls\":\"fa fa-user fa-fl\",\"cfg\":\"{\\\"files\\\":\\\"1\\\",\\\"main_file\\\":\\\"1\\\"}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"8\"},\"time\":\"2016-06-09T13:52:43Z\"},\"solr\":{\"content\":\"User\\nUser\\nuser\\n1\\nfa fa-user fa-fl\\n{\\\"files\\\":\\\"1\\\",\\\"main_file\\\":\\\"1\\\"}\\n\"},\"wu\":[]}'),(11,'{\"_title\":\"Template\",\"en\":\"Template\",\"type\":\"template\",\"visible\":1,\"iconCls\":\"fa fa-file-code-o fa-fl\",\"cfg\":\"{\\n\\\"DC\\\": {\\n  \\\"nid\\\": {},\\n  \\\"name\\\": {},\\n  \\\"type\\\": {},\\n  \\\"cfg\\\": {},\\n  \\\"order\\\": {\\n     \\\"sortType\\\": \\\"asInt\\\"\\n     ,\\\"solr_column_name\\\": \\\"order\\\"\\n  }\\n}\\n}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"16\"},\"time\":\"2016-06-09T13:56:21Z\"},\"solr\":{\"content\":\"Template\\nTemplate\\ntemplate\\n1\\nfa fa-file-code-o fa-fl\\n{\\n\\\"DC\\\": {\\n  \\\"nid\\\": {},\\n  \\\"name\\\": {},\\n  \\\"type\\\": {},\\n  \\\"cfg\\\": {},\\n  \\\"order\\\": {\\n     \\\"sortType\\\": \\\"asInt\\\"\\n     ,\\\"solr_column_name\\\": \\\"order\\\"\\n  }\\n}\\n}\\n\"},\"wu\":[]}'),(12,'{\"_title\":\"Field\",\"en\":\"Field\",\"type\":\"field\",\"visible\":1,\"iconCls\":\"fa fa-foursquare fa-fl\",\"cfg\":\"[]\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"9\"},\"time\":\"2016-06-09T13:53:18Z\"},\"solr\":{\"content\":\"Field\\nField\\nfield\\n1\\nfa fa-foursquare fa-fl\\n[]\\n\"},\"wu\":[],\"solrConfigUpdated\":true}'),(13,'{\"_title\":\"en\",\"en\":\"Full name (en)\",\"type\":\"varchar\",\"order\":\"1\"}','[]'),(14,'{\"en\":\"Initials\",\"ru\":\"Initiales\",\"_title\":\"initials\",\"type\":\"varchar\",\"order\":\"4\"}','[]'),(15,'{\"en\":\"Sex\",\"ru\":\"Sexe\",\"_title\":\"sex\",\"type\":\"_sex\",\"order\":\"5\",\"cfg\":\"{\\\"thesauriId\\\":\\\"90\\\"}\"}','[]'),(16,'{\"en\":\"Position\",\"ru\":\"Titre\",\"_title\":\"position\",\"type\":\"combo\",\"order\":\"7\",\"cfg\":\"{\\\"thesauriId\\\":\\\"362\\\"}\"}','[]'),(17,'{\"en\":\"E-mail\",\"ru\":\"E-mail\",\"_title\":\"email\",\"type\":\"varchar\",\"order\":\"9\",\"cfg\":\"{\\\"maxInstances\\\":\\\"3\\\"}\"}','[]'),(18,'{\"en\":\"Language\",\"ru\":\"Langue\",\"_title\":\"language_id\",\"type\":\"_language\",\"order\":\"11\"}','[]'),(19,'{\"en\":\"Date format\",\"ru\":\"Format de date\",\"_title\":\"short_date_format\",\"type\":\"_short_date_format\",\"order\":\"12\"}','[]'),(20,'{\"en\":\"Description\",\"ru\":\"Description\",\"_title\":\"description\",\"type\":\"varchar\",\"order\":\"13\"}','[]'),(21,'{\"en\":\"Room\",\"ru\":\"Salle\",\"_title\":\"room\",\"type\":\"varchar\",\"order\":\"8\"}','[]'),(22,'{\"en\":\"Phone\",\"ru\":\"T','[]'),(23,'{\"en\":\"Location\",\"ru\":\"Emplacement\",\"_title\":\"location\",\"type\":\"combo\",\"order\":\"6\",\"cfg\":\"{\\\"thesauriId\\\":\\\"394\\\"}\"}','[]'),(24,'{\"en\":\"Program\",\"ru\":\"Program\",\"_title\":\"program\",\"type\":\"_objects\",\"order\":\"1\",\"cfg\":\"{\\r\\n\\\"source\\\":\\\"thesauri\\\"\\r\\n,\\\"thesauriId\\\": \\\"715\\\"\\r\\n,\\\"multiValued\\\": true\\r\\n,\\\"autoLoad\\\": true\\r\\n,\\\"editor\\\":\\\"form\\\"\\r\\n,\\\"renderer\\\": \\\"listGreenIcons\\\"\\r\\n,\\\"faceting\\\": true\\r\\n}\",\"solr_column_name\":\"category_id\"}','[]'),(25,'{\"_title\":\"_title\",\"en\":\"Name\",\"ru\":\"Name\",\"type\":\"varchar\",\"cfg\":\"{\\\"showIn\\\":\\\"top\\\"}\"}','[]'),(26,'{\"en\":\"Type\",\"ru\":\"Type\",\"_title\":\"type\",\"type\":\"_fieldTypesCombo\",\"order\":\"5\",\"cfg\":\"[]\"}','[]'),(27,'{\"_title\":\"order\",\"en\":\"Order\",\"type\":\"int\",\"order\":\"6\",\"cfg\":\"{\\n  \\\"indexed\\\": true\\n}\",\"solr_column_name\":\"order\"}','{\"wu\":[],\"solr\":{\"content\":\"order\\nOrder\\nint\\n6\\n{\\n  \\\"indexed\\\": true\\n}\\norder\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"17\"},\"time\":\"2016-06-09T13:57:55Z\"}}'),(28,'{\"_title\":\"cfg\",\"en\":\"Config\",\"ru\":\"Config\",\"type\":\"memo\",\"order\":\"7\",\"cfg\":\"{\\\"height\\\":100}\"}','[]'),(29,'{\"en\":\"Solr column name\",\"ru\":\"Solr column name\",\"_title\":\"solr_column_name\",\"type\":\"varchar\",\"order\":\"8\",\"cfg\":\"[]\"}','[]'),(30,'{\"en\":\"Title (en)\",\"ru\":\"Title (en)\",\"_title\":\"en\",\"type\":\"varchar\",\"order\":\"1\",\"cfg\":\"[]\"}','[]'),(31,'{\"_title\":\"_title\",\"en\":\"Name\",\"ru\":\"Name\",\"type\":\"varchar\",\"cfg\":\"{\\\"showIn\\\":\\\"top\\\",\\\"rea-dOnly\\\":true}\"}','[]'),(32,'{\"en\":\"Type\",\"ru\":\"Type\",\"_title\":\"type\",\"type\":\"_templateTypesCombo\",\"order\":\"5\",\"cfg\":\"[]\"}','[]'),(33,'{\"en\":\"Active\",\"ru\":\"Active\",\"_title\":\"visible\",\"type\":\"checkbox\",\"order\":\"6\",\"cfg\":\"{\\\"showIn\\\":\\\"top\\\"}\"}','[]'),(34,'{\"en\":\"Icon class\",\"ru\":\"Icon class\",\"_title\":\"iconCls\",\"type\":\"iconcombo\",\"order\":\"7\",\"cfg\":\"[]\"}','[]'),(35,'{\"en\":\"Config\",\"ru\":\"Config\",\"_title\":\"cfg\",\"type\":\"text\",\"order\":\"8\",\"cfg\":\"{\\\"height\\\":100}\"}','[]'),(36,'{\"en\":\"Title template\",\"ru\":\"Title template\",\"_title\":\"title_template\",\"type\":\"text\",\"order\":\"9\",\"cfg\":\"{\\\"height\\\":50}\"}','[]'),(37,'{\"en\":\"Info template\",\"ru\":\"Info template\",\"_title\":\"info_template\",\"type\":\"text\",\"order\":\"10\",\"cfg\":\"{\\\"height\\\":50}\"}','[]'),(38,'{\"en\":\"Title (en)\",\"ru\":\"Title (en)\",\"_title\":\"en\",\"type\":\"varchar\",\"order\":\"1\",\"cfg\":\"[]\"}','[]'),(39,'{\"_title\":\"iconCls\",\"en\":\"Icon class\",\"type\":\"iconcombo\",\"order\":5}','{\"solr\":[]}'),(40,'{\"_title\":\"visible\",\"en\":\"Visible\",\"type\":\"checkbox\",\"order\":6}','{\"solr\":[]}'),(41,'{\"_title\":\"order\",\"en\":\"Order\",\"type\":\"int\",\"order\":7,\"cfg\":\"{\\n\\\"indexed\\\": true\\n}\",\"solr_column_name\":\"order\"}','{\"solr\":[]}'),(42,'{\"_title\":\"en\",\"en\":\"Title\",\"type\":\"varchar\",\"order\":0,\"cfg\":\"{\\\"showIn\\\":\\\"top\\\"}\"}','{\"solr\":[]}'),(43,'{\"_title\":\"ru\",\"type\":\"varchar\",\"order\":1,\"cfg\":{\"showIn\":\"top\"}}','[]'),(44,'{\"_title\":\"_title\",\"en\":\"Title\",\"type\":\"varchar\",\"order\":1,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','[]'),(45,'{\"_title\":\"assigned\",\"en\":\"Assigned\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n  \\\"editor\\\": \\\"form\\\"\\n  ,\\\"source\\\": \\\"users\\\"\\n  ,\\\"renderer\\\": \\\"listObjIcons\\\"\\n  ,\\\"autoLoad\\\": true\\n  ,\\\"multiValued\\\": true\\n  ,\\\"hidePreview\\\": true\\n}\"}','[]'),(46,'{\"_title\":\"importance\",\"en\":\"Importance\",\"type\":\"_objects\",\"order\":8,\"cfg\":\"{\\n  \\\"scope\\\": 53,\\n  \\\"value\\\": 54,\\n  \\\"faceting\\\": true\\n}\"}','[]'),(47,'{\"_title\":\"description\",\"en\":\"Description\",\"type\":\"memo\",\"order\":10,\"cfg\":\"{\\n  \\\"height\\\": 100\\n  ,\\\"noHeader\\\": true\\n  ,\\\"hidePreview\\\": true\\n  ,\\\"linkRenderer\\\": \\\"user,object,url\\\"\\n}\"}','[]'),(48,'{\"_title\":\"_title\",\"en\":\"Name\",\"ru\":\"????????\",\"type\":\"varchar\",\"order\":1}','[]'),(49,'{\"_title\":\"_title\",\"en\":\"Text\",\"ru\":\"?????\",\"type\":\"memo\",\"order\":0,\"cfg\":\"{\\n\\\"height\\\": 100\\n}\",\"solr_column_name\":\"content\"}','[]'),(50,'{\"_title\":\"due_date\",\"en\":\"Due date\",\"type\":\"date\",\"order\":5,\"cfg\":\"{\\n\\\"hidePreview\\\": true\\n}\"}','[]'),(51,'{\"_title\":\"due_time\",\"en\":\"Due time\",\"type\":\"time\",\"order\":6,\"cfg\":\"{\\n\\\"hidePreview\\\": true\\n}\"}','[]'),(52,'{\"_title\":\"task\"}','[]'),(53,'{\"_title\":\"Importance\"}','[]'),(54,'{\"en\":\"Low\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":1}','[]'),(55,'{\"en\":\"Medium\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":2}','[]'),(56,'{\"en\":\"High\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":3}','[]'),(57,'{\"en\":\"CRITICAL\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":4}','[]'),(58,'{\"_title\":\"shortcut\",\"en\":\"Shortcut\",\"type\":\"shortcut\",\"visible\":1,\"iconCls\":\"fa fa-external-link-square  fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"shortcut\\nShortcut\\nshortcut\\n1\\nfa fa-external-link-square  fa-fl\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"10\"},\"time\":\"2016-06-09T13:53:35Z\"},\"wu\":[]}'),(59,'{\"_title\":\"Menu\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":1},\"time\":\"2015-09-07T12:32:02Z\"}}'),(60,'{\"_title\":\"Menus\"}','{\"fu\":[],\"solr\":[]}'),(61,'{\"_title\":\"- Menu separator -\",\"en\":\"- Menu separator -\",\"type\":\"object\",\"visible\":1}','{\"fu\":[1],\"solr\":[]}'),(62,'{\"_title\":\"Menu rule\",\"en\":\"Menu rule\",\"type\":\"menu\",\"visible\":1}','{\"fu\":[1],\"solr\":[]}'),(63,'{\"name\":\"_title\",\"en\":\"Title\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(64,'{\"name\":\"node_ids\",\"en\":\"Nodes\",\"type\":\"_objects\",\"order\":2,\"cfg\":\"{\\\"multiValued\\\":true,\\\"editor\\\":\\\"form\\\",\\\"renderer\\\":\\\"listObjIcons\\\"}\"}','{\"fu\":[1],\"solr\":[]}'),(65,'{\"name\":\"template_ids\",\"en\":\"Templates\",\"type\":\"_objects\",\"order\":3,\"cfg\":\"{\\\"templates\\\":\\\"11\\\",\\\"editor\\\":\\\"form\\\",\\\"multiValued\\\":true,\\\"renderer\\\":\\\"listObjIcons\\\"}\"}','{\"fu\":[1],\"solr\":[]}'),(66,'{\"name\":\"user_group_ids\",\"en\":\"Users\\/Groups\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\\"source\\\":\\\"usersgroups\\\",\\\"multiValued\\\":true}\"}','{\"fu\":[1],\"solr\":[]}'),(67,'{\"name\":\"menu\",\"en\":\"Menu\",\"type\":\"_objects\",\"order\":5,\"cfg\":\"{\\\"templates\\\":\\\"11\\\",\\\"multiValued\\\":true,\\\"editor\\\":\\\"form\\\",\\\"allowValueSort\\\":true,\\\"renderer\\\":\\\"listObjIcons\\\"}\"}','{\"fu\":[1],\"solr\":[]}'),(68,'{\"_title\":\"Global Menu\",\"menu\":\"141,669,61,5,7\"}','{\"fu\":[1],\"solr\":{\"content\":\"Global Menu\\n141,669,61,5,7\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"714\"},\"time\":\"2016-10-14T04:01:39Z\"},\"wu\":[]}'),(69,'{\"_title\":\"System Templates\",\"node_ids\":\"3\",\"template_ids\":null,\"user_group_ids\":null,\"menu\":\"11,5\"}','{\"fu\":[1],\"solr\":[]}'),(70,'{\"_title\":\"System Templates SubMenu\",\"node_ids\":null,\"template_ids\":\"11\",\"user_group_ids\":null,\"menu\":\"12\"}','{\"fu\":[1],\"solr\":[]}'),(71,'{\"_title\":\"System Fields\",\"node_ids\":null,\"template_ids\":\"12\",\"user_group_ids\":null,\"menu\":\"12\"}','{\"fu\":[1],\"solr\":[]}'),(72,'{\"_title\":\"System Thesauri\",\"node_ids\":\"4\",\"template_ids\":\"5\",\"user_group_ids\":null,\"menu\":\"8,61,5\"}','{\"fu\":[1],\"solr\":[]}'),(73,'{\"_title\":\"Create menu rules in this folder\",\"node_ids\":60,\"menu\":62}','{\"fu\":[1],\"solr\":[]}'),(74,'{\"_title\":\"link\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:15:55Z\",\"users\":{\"1\":1}}}'),(75,'{\"_title\":\"Type\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:16:08Z\",\"users\":{\"1\":2}}}'),(76,'{\"en\":\"Article\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":1}','{\"fu\":[1],\"solr\":{\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:17:46Z\",\"users\":{\"1\":3}}}'),(77,'{\"en\":\"Document\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":2}','{\"fu\":[1],\"solr\":{\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:18:06Z\",\"users\":{\"1\":4}}}'),(78,'{\"en\":\"Image\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":3}','{\"fu\":[1],\"solr\":{\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:18:24Z\",\"users\":{\"1\":5}}}'),(79,'{\"en\":\"Sound\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":4}','{\"fu\":[1],\"solr\":{\"order\":4},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:18:42Z\",\"users\":{\"1\":6}}}'),(80,'{\"en\":\"Video\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":5}','{\"fu\":[1],\"solr\":{\"order\":5},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:19:03Z\",\"users\":{\"1\":7}}}'),(81,'{\"en\":\"Website\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":6}','{\"fu\":[1],\"solr\":{\"order\":6},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:19:25Z\",\"users\":{\"1\":8}}}'),(82,'{\"_title\":\"Tags\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:19:43Z\",\"users\":{\"1\":9}}}'),(83,'{\"_title\":\"link\",\"en\":\"Link\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"fa fa-external-link fa-fl\",\"title_template\":\"{url}\"}','{\"fu\":[1],\"solr\":{\"content\":\"link\\nLink\\nobject\\n1\\nfa fa-external-link fa-fl\\n{url}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"11\"},\"time\":\"2016-06-09T13:53:47Z\"},\"wu\":[]}'),(84,'{\"_title\":\"type\",\"en\":\"Type\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"scope\\\": 75 \\n}\"}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:25:21Z\",\"users\":{\"1\":11}}}'),(85,'{\"_title\":\"url\",\"en\":\"URL\",\"type\":\"varchar\",\"order\":2}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:25:59Z\",\"users\":{\"1\":12}}}'),(86,'{\"_title\":\"description\",\"en\":\"Description\",\"type\":\"varchar\",\"order\":3}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:26:29Z\",\"users\":{\"1\":13}}}'),(87,'{\"_title\":\"tags\",\"en\":\"Tags\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n\\\"scope\\\": 82\\n,\\\"editor\\\": \\\"tagField\\\"\\n}\"}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":16},\"time\":\"2015-09-01T07:30:36Z\"}}'),(88,'{\"_title\":\"Built-in\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-02T13:45:53Z\",\"users\":{\"1\":17}}}'),(89,'{\"_title\":\"Config\"}','{\"fu\":[],\"solr\":[]}'),(90,'{\"_title\":\"Config\"}','{\"fu\":[],\"solr\":[]}'),(91,'{\"_title\":\"Config int option\",\"en\":\"Config int option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gear fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config int option\\nConfig int option\\nconfig\\n1\\nfa fa-gear fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"12\"},\"time\":\"2016-06-09T13:54:28Z\"}}'),(92,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(93,'{\"name\":\"value\",\"en\":\"Value\",\"type\":\"int\",\"order\":2}','{\"fu\":[1],\"solr\":[]}'),(94,'{\"_title\":\"Config varchar option\",\"en\":\"Config varchar option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gear fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config varchar option\\nConfig varchar option\\nconfig\\n1\\nfa fa-gear fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"13\"},\"time\":\"2016-06-09T13:54:40Z\"}}'),(95,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(96,'{\"name\":\"value\",\"en\":\"Value\",\"type\":\"varchar\",\"order\":2}','{\"fu\":[1],\"solr\":[]}'),(97,'{\"_title\":\"Config text option\",\"en\":\"Config text option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gear fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config text option\\nConfig text option\\nconfig\\n1\\nfa fa-gear fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"14\"},\"time\":\"2016-06-09T13:54:50Z\"}}'),(98,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(99,'{\"name\":\"value\",\"en\":\"Value\",\"type\":\"text\",\"order\":2}','{\"fu\":[1],\"solr\":[]}'),(100,'{\"_title\":\"Config json option\",\"en\":\"Config json option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gears fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config json option\\nConfig json option\\nconfig\\n1\\nfa fa-gears fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"15\"},\"time\":\"2016-06-09T13:55:06Z\"}}'),(101,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(102,'{\"en\":\"Value\",\"type\":\"text\",\"order\":2,\"cfg\":\"{\\n\\\"editor\\\":\\\"ace\\\",\\n\\\"format\\\":\\\"json\\\",\\n\\\"validator\\\":\\\"json\\\"\\n}\"}','{\"fu\":[1],\"solr\":{\"content\":\"Value\\ntext\\n2\\n{\\n\\\"editor\\\":\\\"ace\\\",\\n\\\"format\\\":\\\"json\\\",\\n\\\"validator\\\":\\\"json\\\"\\n}\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"7\"},\"time\":\"2016-04-29T08:00:26Z\"}}'),(103,'{\"name\":\"order\",\"en\":\"Order\",\"type\":\"int\",\"order\":3,\"solr_column_name\":\"order\",\"cfg\":\"{\\\"indexed\\\":true}\"}','{\"fu\":[1],\"solr\":[]}'),(104,'{\"_title\":\"project_name_en\",\"value\":\"ECMRS - Electronic Case Record Management System\"}','{\"fu\":[1],\"solr\":{\"content\":\"project_name_en\\nECMRS - Electronic Case Record Management System\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1\"},\"time\":\"2016-08-08T00:34:11Z\"}}'),(105,'{\"_title\":\"templateIcons\",\"value\":\"\\nfa fa-arrow-circle-left fa-fl\\nfa fa-arrow-circle-o-left fa-fl\\nfa fa-arrow-circle-o-right fa-fl\\nfa fa-arrow-circle-right fa-fl\\nfa fa-arrow-left fa-fl\\nfa fa-arrow-right fa-fl\\nfa fa-book fa-fl\\nfa fa-bookmark fa-fl\\nfa fa-bookmark-o fa-fl\\nfa fa-briefcase fa-fl\\nfa fa-bug fa-fl\\nfa fa-building fa-fl\\nfa fa-building-o fa-fl\\nfa fa-calendar-o fa-fl\\nfa fa-camera fa-fl\\nfa fa-comment fa-fl\\nfa fa-comment-o fa-fl\\nfa fa-commenting fa-fl\\nfa fa-commenting-o fa-fl\\nfa fa-comments fa-fl\\nfa fa-comments-o fa-fl\\nfa fa-envelope fa-fl\\nfa fa-envelope-o fa-fl\\nfa fa-external-link fa-fl\\nfa fa-external-link-square  fa-fl\\nfa fa-file fa-fl\\nfa fa-file-archive-o fa-fl\\nfa fa-file-audio-o fa-fl\\nfa fa-file-code-o fa-fl\\nfa fa-file-excel-o fa-fl\\nfa fa-file-image-o fa-fl\\nfa fa-file-movie-o fa-fl\\nfa fa-file-o fa-fl\\nfa fa-file-pdf-o fa-fl\\nfa fa-file-photo-o fa-fl\\nfa fa-file-picture-o fa-fl\\nfa fa-file-powerpoint-o fa-fl\\nfa fa-file-sound-o fa-fl\\nfa fa-file-text fa-fl\\nfa fa-file-text-o fa-fl\\nfa fa-file-video-o fa-fl\\nfa fa-file-word-o fa-fl\\nfa fa-file-zip-o fa-fl\\nfa fa-files-o fa-fl\\nfa fa-film fa-fl\\nfa fa-flash fa-fl\\nfa fa-folder fa-fl\\nfa fa-folder-o fa-fl\\nfa fa-folder-open fa-fl\\nfa fa-folder-open-o fa-fl\\nfa fa-foursquare fa-fl\\nfa fa-gavel fa-fl\\nfa fa-gear fa-fl\\nfa fa-gears fa-fl\\nfa fa-info fa-fl\\nfa fa-info-circle fa-fl\\nfa fa-institution fa-fl\\nfa fa-link fa-fl\\nfa fa-print fa-fl\\nfa fa-stack-exchange fa-fl\\nfa fa-sticky-note fa-fl\\nfa fa-sticky-note-o fa-fl\\nfa fa-suitcase fa-fl\\nfa fa-tasks fa-fl\\nfa fa-university fa-fl\\nfa fa-unlink fa-fl\\nfa fa-user fa-fl\\nfa fa-user-md fa-fl\\nfa fa-user-plus fa-fl\\nfa fa-user-secret fa-fl\\nfa fa-user-times fa-fl\\nfa fa-users fa-fl\\nfa fa-warning fa-fl\\nfa fa-wpforms fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"templateIcons\\n\\nfa fa-arrow-circle-left fa-fl\\nfa fa-arrow-circle-o-left fa-fl\\nfa fa-arrow-circle-o-right fa-fl\\nfa fa-arrow-circle-right fa-fl\\nfa fa-arrow-left fa-fl\\nfa fa-arrow-right fa-fl\\nfa fa-book fa-fl\\nfa fa-bookmark fa-fl\\nfa fa-bookmark-o fa-fl\\nfa fa-briefcase fa-fl\\nfa fa-bug fa-fl\\nfa fa-building fa-fl\\nfa fa-building-o fa-fl\\nfa fa-calendar-o fa-fl\\nfa fa-camera fa-fl\\nfa fa-comment fa-fl\\nfa fa-comment-o fa-fl\\nfa fa-commenting fa-fl\\nfa fa-commenting-o fa-fl\\nfa fa-comments fa-fl\\nfa fa-comments-o fa-fl\\nfa fa-envelope fa-fl\\nfa fa-envelope-o fa-fl\\nfa fa-external-link fa-fl\\nfa fa-external-link-square  fa-fl\\nfa fa-file fa-fl\\nfa fa-file-archive-o fa-fl\\nfa fa-file-audio-o fa-fl\\nfa fa-file-code-o fa-fl\\nfa fa-file-excel-o fa-fl\\nfa fa-file-image-o fa-fl\\nfa fa-file-movie-o fa-fl\\nfa fa-file-o fa-fl\\nfa fa-file-pdf-o fa-fl\\nfa fa-file-photo-o fa-fl\\nfa fa-file-picture-o fa-fl\\nfa fa-file-powerpoint-o fa-fl\\nfa fa-file-sound-o fa-fl\\nfa fa-file-text fa-fl\\nfa fa-file-text-o fa-fl\\nfa fa-file-video-o fa-fl\\nfa fa-file-word-o fa-fl\\nfa fa-file-zip-o fa-fl\\nfa fa-files-o fa-fl\\nfa fa-film fa-fl\\nfa fa-flash fa-fl\\nfa fa-folder fa-fl\\nfa fa-folder-o fa-fl\\nfa fa-folder-open fa-fl\\nfa fa-folder-open-o fa-fl\\nfa fa-foursquare fa-fl\\nfa fa-gavel fa-fl\\nfa fa-gear fa-fl\\nfa fa-gears fa-fl\\nfa fa-info fa-fl\\nfa fa-info-circle fa-fl\\nfa fa-institution fa-fl\\nfa fa-link fa-fl\\nfa fa-print fa-fl\\nfa fa-stack-exchange fa-fl\\nfa fa-sticky-note fa-fl\\nfa fa-sticky-note-o fa-fl\\nfa fa-suitcase fa-fl\\nfa fa-tasks fa-fl\\nfa fa-university fa-fl\\nfa fa-unlink fa-fl\\nfa fa-user fa-fl\\nfa fa-user-md fa-fl\\nfa fa-user-plus fa-fl\\nfa fa-user-secret fa-fl\\nfa fa-user-times fa-fl\\nfa fa-users fa-fl\\nfa fa-warning fa-fl\\nfa fa-wpforms fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1\"},\"time\":\"2016-06-09T13:48:36Z\"}}'),(106,'{\"_title\":\"folder_templates\",\"value\":\"5,11,100\"}','{\"fu\":[1],\"solr\":[]}'),(107,'{\"_title\":\"default_folder_template\",\"value\":\"5\"}','{\"fu\":[1],\"solr\":[]}'),(108,'{\"_title\":\"default_file_template\",\"value\":\"6\"}','{\"fu\":[1],\"solr\":[]}'),(109,'{\"_title\":\"default_task_template\",\"value\":\"7\"}','{\"fu\":[1],\"solr\":[]}'),(110,'{\"_title\":\"default_language\",\"value\":\"en\"}','{\"fu\":[1],\"solr\":[]}'),(111,'{\"_title\":\"languages\",\"value\":\"en\"}','{\"fu\":[1],\"solr\":[]}'),(112,'{\"_title\":\"object_type_plugins\",\"value\":\"{\\r\\n  \\\"object\\\": [\\\"objectProperties\\\", \\\"files\\\", \\\"tasks\\\", \\\"contentItems\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n  ,\\\"case\\\": [\\\"objectProperties\\\", \\\"files\\\", \\\"tasks\\\", \\\"contentItems\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n  ,\\\"task\\\": [\\\"objectProperties\\\", \\\"files\\\", \\\"contentItems\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n  ,\\\"file\\\": [\\\"thumb\\\", \\\"meta\\\", \\\"versions\\\", \\\"tasks\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n}\"}','{\"fu\":[1],\"solr\":[]}'),(113,'{\"_title\":\"treeNodes\",\"value\":\"\"}','{\"fu\":[1],\"solr\":[]}'),(114,'{\"_title\":\"Tasks\",\"value\":\"{\\n    \\\"pid\\\": 1\\n}\",\"order\":1}','{\"fu\":[1],\"solr\":{\"order\":1}}'),(115,'{\"_title\":\"Dbnode\",\"value\":\"[]\",\"order\":2}','{\"fu\":[1],\"solr\":{\"order\":2}}'),(116,'{\"_title\":\"RecycleBin\",\"value\":\"{\\r\\n    \\\"pid\\\": \\\"1\\\",\\r\\n    \\\"facets\\\": [\\r\\n        \\\"did\\\"\\r\\n    ],\\r\\n    \\\"DC\\\": {\\r\\n        \\\"nid\\\": {}\\r\\n        ,\\\"name\\\": {}\\r\\n        ,\\\"cid\\\": {}\\r\\n        ,\\\"ddate\\\": {\\r\\n            \\\"solr_column_name\\\": \\\"ddate\\\"\\r\\n        }\\r\\n    }\\r\\n}\",\"order\":3}','{\"fu\":[1],\"solr\":{\"order\":3},\"wu\":[1],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":1},\"time\":\"2015-11-25T13:52:47Z\"}}'),(117,'{\"_title\":\"Create config options rule\",\"node_ids\":90,\"menu\":\"91,94,97,100\"}','{\"fu\":[1],\"solr\":[]}'),(118,'{\"_title\":\"files\",\"value\":\"{\\r\\n  \\\"max_versions\\\": \\\"*:1;php,odt,doc,docx,xls,xlsx:20;pdf:5;png,gif,jpg,jpeg,tif,tiff:2;\\\"\\r\\n\\r\\n  ,\\\"edit\\\" : {\\r\\n    \\\"text\\\": \\\"txt,php,js,xml,csv\\\"\\r\\n    ,\\\"html\\\": \\\"html,htm\\\"\\r\\n    ,\\\"webdav\\\": \\\"doc,docx,ppt,dot,dotx,xls,xlsm,xltx,ppt,pot,pps,pptx,odt,ott,odm,ods,odg,otg,odp,odf,odb\\\"\\r\\n  }\\r\\n\\r\\n  ,\\\"webdav_url\\\": \\\"https:\\/\\/webdav.host.com\\/{core_name}\\/edit-{node_id}\\/{name}\\\"\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"files\\n{\\r\\n  \\\"max_versions\\\": \\\"*:1;php,odt,doc,docx,xls,xlsx:20;pdf:5;png,gif,jpg,jpeg,tif,tiff:2;\\\"\\r\\n\\r\\n  ,\\\"edit\\\" : {\\r\\n    \\\"text\\\": \\\"txt,php,js,xml,csv\\\"\\r\\n    ,\\\"html\\\": \\\"html,htm\\\"\\r\\n    ,\\\"webdav\\\": \\\"doc,docx,ppt,dot,dotx,xls,xlsm,xltx,ppt,pot,pps,pptx,odt,ott,odm,ods,odg,otg,odp,odf,odb\\\"\\r\\n  }\\r\\n\\r\\n  ,\\\"webdav_url\\\": \\\"https:\\/\\/webdav.host.com\\/{core_name}\\/edit-{node_id}\\/{name}\\\"\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:53:55Z\",\"users\":{\"1\":\"1\"}}}'),(119,'{\"_title\":\"timezone\",\"value\":\"UTC\"}','{\"wu\":[],\"solr\":{\"content\":\"timezone\\nUTC\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:55:28Z\",\"users\":{\"1\":\"2\"}}}'),(120,'{\"_title\":\"language_en\",\"value\":\"{\\r\\n\\\"name\\\": \\\"English\\\"\\r\\n,\\\"locale\\\": \\\"en_US\\\"\\r\\n,\\\"long_date_format\\\": \\\"%F %j, %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%m\\/%d\\/%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"language_en\\n{\\r\\n\\\"name\\\": \\\"English\\\"\\r\\n,\\\"locale\\\": \\\"en_US\\\"\\r\\n,\\\"long_date_format\\\": \\\"%F %j, %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%m\\/%d\\/%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:56:08Z\",\"users\":{\"1\":\"3\"}}}'),(121,'{\"_title\":\"language_fr\",\"value\":\"{\\r\\n\\\"name\\\": \\\"French\\\"\\r\\n,\\\"locale\\\": \\\"fr_FR\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\r\\n\"}','{\"wu\":[],\"solr\":{\"content\":\"language_fr\\n{\\r\\n\\\"name\\\": \\\"French\\\"\\r\\n,\\\"locale\\\": \\\"fr_FR\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\r\\n\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:56:40Z\",\"users\":{\"1\":\"4\"}}}'),(122,'{\"_title\":\"language_ru\",\"value\":\"{\\r\\n\\\"name\\\": \\\"???????\\\"\\r\\n,\\\"locale\\\": \\\"ru_RU\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"language_ru\\n{\\r\\n\\\"name\\\": \\\"???????\\\"\\r\\n,\\\"locale\\\": \\\"ru_RU\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:57:06Z\",\"users\":{\"1\":\"5\"}}}'),(123,'{\"_title\":\"default_facet_configs\",\"value\":\"{\\r\\n  \\\"template_type\\\": {\\r\\n    \\\"title\\\": \\\"[Type]\\\"\\r\\n    ,\\\"type\\\": \\\"objectTypes\\\"\\r\\n  }\\r\\n  ,\\\"template\\\": {\\r\\n    \\\"title\\\": \\\"[Template]\\\"\\r\\n    ,\\\"field\\\": \\\"template_id\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n  }\\r\\n  ,\\\"creator\\\": {\\r\\n    \\\"title\\\": \\\"[Creator]\\\"\\r\\n    ,\\\"field\\\": \\\"cid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"owner\\\": {\\r\\n    \\\"title\\\": \\\"[Owner]\\\"\\r\\n    ,\\\"field\\\": \\\"oid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"updater\\\": {\\r\\n    \\\"title\\\": \\\"Updater\\\"\\r\\n    ,\\\"field\\\": \\\"uid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"date\\\": {\\r\\n    \\\"title\\\": \\\"[Date]\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"manualPeriod\\\": true\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"yesterday\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"date_end\\\": {\\r\\n    \\\"title\\\": \\\"End date\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"next7days\\\"\\r\\n      ,\\\"next31days\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n }\\r\\n  ,\\\"task_status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"taskStatuses\\\"\\r\\n }\\r\\n  ,\\\"assigned\\\": {\\r\\n    \\\"title\\\": \\\"[TaskAssigned]\\\"\\r\\n    ,\\\"field\\\": \\\"task_u_assignee\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }, \\\"client_status\\\": {\\r\\n\\\"field\\\": \\\"client_status_i\\\"\\r\\n,\\\"title\\\": \\\"Client Status\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}, \\\"lat_lon\\\": {\\r\\n\\\"field\\\": \\\"latlon_d\\\"\\r\\n,\\\"title\\\": \\\"Lat\\/Lon\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"fema_tier\\\": {\\r\\n\\\"field\\\": \\\"fema_tier_i\\\"\\r\\n,\\\"title\\\": \\\"FEMA Tier\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"default_facet_configs\\n{\\r\\n  \\\"template_type\\\": {\\r\\n    \\\"title\\\": \\\"[Type]\\\"\\r\\n    ,\\\"type\\\": \\\"objectTypes\\\"\\r\\n  }\\r\\n  ,\\\"template\\\": {\\r\\n    \\\"title\\\": \\\"[Template]\\\"\\r\\n    ,\\\"field\\\": \\\"template_id\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n  }\\r\\n  ,\\\"creator\\\": {\\r\\n    \\\"title\\\": \\\"[Creator]\\\"\\r\\n    ,\\\"field\\\": \\\"cid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"owner\\\": {\\r\\n    \\\"title\\\": \\\"[Owner]\\\"\\r\\n    ,\\\"field\\\": \\\"oid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"updater\\\": {\\r\\n    \\\"title\\\": \\\"Updater\\\"\\r\\n    ,\\\"field\\\": \\\"uid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"date\\\": {\\r\\n    \\\"title\\\": \\\"[Date]\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"manualPeriod\\\": true\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"yesterday\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"date_end\\\": {\\r\\n    \\\"title\\\": \\\"End date\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"next7days\\\"\\r\\n      ,\\\"next31days\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n }\\r\\n  ,\\\"task_status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"taskStatuses\\\"\\r\\n }\\r\\n  ,\\\"assigned\\\": {\\r\\n    \\\"title\\\": \\\"[TaskAssigned]\\\"\\r\\n    ,\\\"field\\\": \\\"task_u_assignee\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }, \\\"client_status\\\": {\\r\\n\\\"field\\\": \\\"client_status_i\\\"\\r\\n,\\\"title\\\": \\\"Client Status\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}, \\\"lat_lon\\\": {\\r\\n\\\"field\\\": \\\"latlon_d\\\"\\r\\n,\\\"title\\\": \\\"Lat\\/Lon\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"fema_tier\\\": {\\r\\n\\\"field\\\": \\\"fema_tier_i\\\"\\r\\n,\\\"title\\\": \\\"FEMA Tier\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"867\"},\"time\":\"2016-10-20T21:42:06Z\"}}'),(124,'{\"_title\":\"node_facets\",\"value\":\"{\\r\\n\\\"1\\\" : [\\r\\n  \\\"template_type\\\"\\r\\n  ,\\\"creator\\\"\\r\\n  ,\\\"template\\\"\\r\\n  ,\\\"date\\\"\\r\\n  ,\\\"status\\\"\\r\\n  ,\\\"assigned\\\"\\r\\n],\\r\\n\\\"150\\\" : [\\r\\n \\\"client_status\\\"\\r\\n]\\r\\n\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"node_facets\\n{\\r\\n\\\"1\\\" : [\\r\\n  \\\"template_type\\\"\\r\\n  ,\\\"creator\\\"\\r\\n  ,\\\"template\\\"\\r\\n  ,\\\"date\\\"\\r\\n  ,\\\"status\\\"\\r\\n  ,\\\"assigned\\\"\\r\\n],\\r\\n\\\"150\\\" : [\\r\\n \\\"client_status\\\"\\r\\n]\\r\\n\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"859\"},\"time\":\"2016-10-20T21:00:44Z\"}}'),(125,'{\"_title\":\"default_object_plugins\",\"value\":\"{\\r\\n  \\\"objectProperties\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"!template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 0\\r\\n  }\\r\\n  ,\\\"files\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 2\\r\\n  }\\r\\n  ,\\\"tasks\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 3\\r\\n  }\\r\\n  ,\\\"contentItems\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"file,time_tracking\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 4\\r\\n  }\\r\\n  ,\\\"thumb\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 5\\r\\n  }\\r\\n  ,\\\"currentVersion\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 6\\r\\n  }\\r\\n  ,\\\"versions\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 7\\r\\n  }\\r\\n  ,\\\"meta\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 8\\r\\n  }\\r\\n  ,\\\"comments\\\": {\\r\\n    \\\"order\\\": 9\\r\\n    ,\\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"time_tracking\\\"\\r\\n    }\\r\\n\\r\\n  }\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"default_object_plugins\\n{\\r\\n  \\\"objectProperties\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"!template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 0\\r\\n  }\\r\\n  ,\\\"files\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 2\\r\\n  }\\r\\n  ,\\\"tasks\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 3\\r\\n  }\\r\\n  ,\\\"contentItems\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"file,time_tracking\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 4\\r\\n  }\\r\\n  ,\\\"thumb\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 5\\r\\n  }\\r\\n  ,\\\"currentVersion\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 6\\r\\n  }\\r\\n  ,\\\"versions\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 7\\r\\n  }\\r\\n  ,\\\"meta\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 8\\r\\n  }\\r\\n  ,\\\"comments\\\": {\\r\\n    \\\"order\\\": 9\\r\\n    ,\\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"time_tracking\\\"\\r\\n    }\\r\\n\\r\\n  }\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"13\"},\"time\":\"2016-04-29T08:15:53Z\"}}'),(126,'{\"_title\":\"images_display_size\",\"value\":512000}','{\"wu\":[],\"solr\":{\"content\":\"images_display_size\\n512000\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:11:54Z\",\"users\":{\"1\":\"10\"}}}'),(127,'{\"_title\":\"default_DC\",\"value\":\"{\\r\\n\\\"nid\\\": {}\\r\\n,\\\"name\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"name\\\"\\r\\n}\\r\\n,\\\"cid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cid\\\"\\r\\n}\\r\\n,\\\"oid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"oid\\\"\\r\\n}\\r\\n,\\\"cdate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cdate\\\"\\r\\n}\\r\\n,\\\"udate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"udate\\\"\\r\\n}\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"default_DC\\n{\\r\\n\\\"nid\\\": {}\\r\\n,\\\"name\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"name\\\"\\r\\n}\\r\\n,\\\"cid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cid\\\"\\r\\n}\\r\\n,\\\"oid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"oid\\\"\\r\\n}\\r\\n,\\\"cdate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cdate\\\"\\r\\n}\\r\\n,\\\"udate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"udate\\\"\\r\\n}\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1170\"},\"time\":\"2016-10-21T16:03:08Z\"}}'),(128,'{\"_title\":\"default_availableViews\",\"value\":\"grid,charts,pivot,activityStream,calendar\"}','{\"wu\":[],\"solr\":{\"content\":\"default_availableViews\\ngrid,charts,pivot,activityStream,calendar\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1171\"},\"time\":\"2016-10-21T16:03:19Z\"}}'),(129,'{\"_title\":\"DCConfigs\"}','{\"wu\":[],\"solr\":{\"content\":\"DCConfigs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:17:58Z\",\"users\":{\"1\":\"14\"}}}'),(130,'{\"_title\":\"dc_tasks\",\"value\":\"{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"phase\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_phase\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"dc_tasks\\n{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"phase\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_phase\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:18:25Z\",\"users\":{\"1\":\"15\"}}}'),(131,'{\"_title\":\"dc_tasks_closed\",\"value\":\"{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }    \\r\\n    ,\\\"time_completed\\\":{\\r\\n        \\\"columnWidth\\\":\\\"20\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"task_d_closed\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_d_closed\\\"\\r\\n        ,\\\"xtype\\\":\\\"datecolumn\\\"\\r\\n        ,\\\"format\\\":\\\"Y-m-d\\\"\\r\\n        ,\\\"title\\\":\\\"Closed date\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"dc_tasks_closed\\n{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }    \\r\\n    ,\\\"time_completed\\\":{\\r\\n        \\\"columnWidth\\\":\\\"20\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"task_d_closed\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_d_closed\\\"\\r\\n        ,\\\"xtype\\\":\\\"datecolumn\\\"\\r\\n        ,\\\"format\\\":\\\"Y-m-d\\\"\\r\\n        ,\\\"title\\\":\\\"Closed date\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:20:59Z\",\"users\":{\"1\":\"16\"}}}'),(132,'{\"_title\":\"geoMapping\",\"value\":\"true\"}','{\"wu\":[],\"solr\":{\"content\":\"geoMapping\\ntrue\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2\"},\"time\":\"2016-08-08T00:34:42Z\"}}'),(133,'{\"_title\":\"Test Task\",\"due_date\":\"2016-08-31T00:00:00Z\",\"due_time\":\"02:45:00\",\"assigned\":\"1\",\"importance\":56,\"description\":\"Test\",\"sys_data\":[]}','{\"task_due_date\":\"2016-08-31T00:00:00Z\",\"task_due_time\":\"02:45:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[1],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"Test Task\\n2016-08-31T00:00:00Z\\n02:45:00\\n1\\n56\\nTest\\n\",\"\":56,\"task_status\":2,\"task_u_assignee\":[1],\"task_u_all\":[1],\"task_u_ongoing\":[1],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"24\"},\"time\":\"2016-08-08T01:25:52Z\"}}'),(134,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1757\"},\"time\":\"2016-12-08T17:47:48Z\"}}'),(135,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1758\"},\"time\":\"2016-12-08T17:47:51Z\"}}'),(136,'{\"_title\":\"Client\"}','{\"wu\":[],\"solr\":{\"content\":\"Client\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"159\"},\"time\":\"2016-09-29T15:47:22Z\"}}'),(137,'{\"en\":\"FEMA Tier\",\"iconCls\":\"fa fa-building-o fa-fl\",\"visible\":1,\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Tier\\nfa fa-building-o fa-fl\\n1\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1669\"},\"time\":\"2016-12-06T17:07:06Z\"}}'),(138,'{\"en\":\"Tier 3: Significant Unmet Needs\",\"iconCls\":\"fa fa-warning fa-fl\",\"visible\":1,\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Tier 3: Significant Unmet Needs\\nfa fa-warning fa-fl\\n1\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"631\"},\"time\":\"2016-10-03T19:19:31Z\"}}'),(139,'{\"en\":\"Tier 4: Immediate and Long-Term Unmet Needs\",\"iconCls\":\"fa fa-external-link-square  fa-fl\",\"visible\":1,\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Tier 4: Immediate and Long-Term Unmet Needs\\nfa fa-external-link-square  fa-fl\\n1\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"632\"},\"time\":\"2016-10-03T19:20:01Z\"}}'),(140,'{\"_title\":\"Custom\"}','{\"wu\":[],\"solr\":{\"content\":\"Custom\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"13\"},\"time\":\"2016-08-08T00:44:41Z\"}}'),(141,'{\"_title\":\"Client\",\"en\":\"Client\",\"type\":\"case\",\"visible\":1,\"iconCls\":\"icon-case\",\"cfg\":\"{\\n\\\"system_folders\\\":\\\"952\\\",\\n\\\"DC\\\": {\\n\\\"nid\\\": {},\\n\\\"name\\\": {},\\n\\\"cid\\\":{\\\"title\\\": \\\"Entered By\\\"},\\n\\\"cdate\\\":{\\\"title\\\": \\\"Entered Date\\\"}\\n}\\n}\",\"title_template\":\"{_firstname}  {_lastname}\"}','{\"wu\":[],\"solr\":{\"content\":\"Client\\nClient\\ncase\\n1\\nicon-case\\n{\\n\\\"system_folders\\\":\\\"952\\\",\\n\\\"DC\\\": {\\n\\\"nid\\\": {},\\n\\\"name\\\": {},\\n\\\"cid\\\":{\\\"title\\\": \\\"Entered By\\\"},\\n\\\"cdate\\\":{\\\"title\\\": \\\"Entered Date\\\"}\\n}\\n}\\n{_firstname}  {_lastname}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1629\"},\"time\":\"2016-11-14T20:43:34Z\"}}'),(142,'{\"_title\":\"_firstname\",\"en\":\"First Name\",\"type\":\"varchar\",\"order\":1,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_firstname\\nFirst Name\\nvarchar\\n1\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1248\"},\"time\":\"2016-10-22T01:14:13Z\"}}'),(143,'{\"_title\":\"_lastname\",\"en\":\"Last Name\",\"type\":\"varchar\",\"order\":3,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_lastname\\nLast Name\\nvarchar\\n3\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1249\"},\"time\":\"2016-10-22T01:14:29Z\"}}'),(144,'{\"_title\":\"_header\",\"en\":\"Client Information\",\"type\":\"H\",\"order\":0}','{\"wu\":[],\"solr\":{\"content\":\"_header\\nClient Information\\nH\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"214\"},\"time\":\"2016-09-29T19:09:13Z\"}}'),(145,'{\"_title\":\"_femacategory\",\"en\":\"FEMA Category\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n  \\\"scope\\\": 137,\\n  \\\"value\\\": 138,\\n  \\\"faceting\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_femacategory\\nFEMA Category\\n_objects\\n4\\n{\\n  \\\"scope\\\": 137,\\n  \\\"value\\\": 138,\\n  \\\"faceting\\\": true\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"122\"},\"time\":\"2016-09-29T15:20:38Z\"}}'),(146,'{\"_title\":\"Person SubMenu\",\"template_ids\":\"7\",\"menu\":\"141\"}','{\"wu\":[],\"solr\":{\"content\":\"Person SubMenu\\n7\\n141\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"48\"},\"time\":\"2016-08-08T02:05:50Z\"}}'),(147,'{\"_title\":\"Person SubMenu\",\"template_ids\":\"141\",\"menu\":\"141\"}','{\"wu\":[],\"solr\":{\"content\":\"Person SubMenu\\n141\\n141\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"67\"},\"time\":\"2016-08-08T09:42:46Z\"}}'),(149,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1762\"},\"time\":\"2016-12-08T17:48:09Z\"}}'),(150,'{\"_title\":\"Clients\"}','{\"wu\":[3,1,6],\"solr\":{\"content\":\"Clients\\n\",\"comment_user_id\":6,\"comment_date\":\"2016-10-17T19:47:06Z\"},\"lastAction\":{\"type\":\"comment\",\"users\":{\"1\":\"726\",\"6\":\"727\"},\"time\":\"2016-10-17T19:47:06Z\"},\"lastComment\":{\"user_id\":6,\"date\":\"2016-10-17T19:47:06Z\"}}'),(152,'{\"_title\":\"This\",\"value\":\"{\\n\\\"pid\\\": 150\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"This\\n{\\n\\\"pid\\\": 150\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-08-08T01:41:35Z\",\"users\":{\"1\":\"32\"}}}'),(156,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1759\"},\"time\":\"2016-12-08T17:47:56Z\"}}'),(157,'{\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[3],\"solr\":{\"content\":\"54\\n\",\"\":54,\"task_status\":2,\"task_u_all\":[\"3\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"3\":\"41\"},\"time\":\"2016-08-08T01:46:56Z\"}}'),(160,'{\"_title\":\"Test\",\"assigned\":\"3\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[3],\"task_status\":2,\"wu\":[1,3],\"solr\":{\"content\":\"Test\\n3\\n54\\n\",\"\":54,\"task_status\":2,\"task_u_assignee\":[3],\"task_u_all\":[3,\"1\"],\"task_u_ongoing\":[3],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"719\"},\"time\":\"2016-10-17T19:28:32Z\"}}'),(161,'{\"_title\":\"Something\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[3],\"solr\":{\"content\":\"Something\\n54\\n\",\"\":54,\"task_status\":2,\"task_u_all\":[\"3\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"3\":\"51\"},\"time\":\"2016-08-08T02:09:48Z\"}}'),(167,'{\"en\":\"Gender\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Gender\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"126\"},\"time\":\"2016-09-29T15:26:30Z\"}}'),(168,'{\"_title\":\"System folders\"}','{\"wu\":[],\"solr\":{\"content\":\"System folders\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1764\"},\"time\":\"2016-12-08T17:48:17Z\"}}'),(169,'{\"_title\":\"Surveys\"}','{\"wu\":[],\"solr\":{\"content\":\"Surveys\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-08-08T09:38:36Z\",\"users\":{\"1\":\"62\"}}}'),(170,'{\"_title\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-08-08T09:38:43Z\",\"users\":{\"1\":\"63\"}}}'),(172,'{\"_title\":\"TransportationAssessment\",\"en\":\"Transportation Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-transportation\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Transportation Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"TransportationAssessment\\nTransportation Assessment\\nobject\\n1\\nicon-assessment-transportation\\n{\\n\\\"leaf\\\":true\\n}\\nTransportation Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1570\"},\"time\":\"2016-11-14T15:26:18Z\"}}'),(173,'{\"_title\":\"Client SubMenu\",\"template_ids\":\"141\",\"menu\":\"527,289,311,607,61,510,533,553,482,455,505,559,489,440,656,467,651,172\"}','{\"wu\":[],\"solr\":{\"content\":\"Client SubMenu\\n141\\n527,289,311,607,61,510,533,553,482,455,505,559,489,440,656,467,651,172\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1667\"},\"time\":\"2016-12-05T21:41:45Z\"}}'),(182,'{\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[3],\"solr\":{\"content\":\"54\\n\",\"\":54,\"task_status\":2,\"task_u_all\":[\"3\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"804\"},\"time\":\"2016-10-18T20:03:46Z\"}}'),(201,'{\"_title\":\"Folder\"}','{\"wu\":[],\"solr\":{\"content\":\"Folder\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1760\"},\"time\":\"2016-12-08T17:48:00Z\"}}'),(205,'{\"_title\":\"Case\",\"en\":\"Case\",\"type\":\"case\",\"visible\":1,\"iconCls\":\"icon-briefcase\",\"title_template\":\"{name}\"}','{\"wu\":[],\"solr\":{\"content\":\"Case\\nCase\\ncase\\n1\\nicon-briefcase\\n{name}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1754\"},\"time\":\"2016-12-08T17:47:37Z\"}}'),(206,'{\"_title\":\"contacts\",\"type\":\"_objects\",\"cfg\":\"{\\\"source\\\":\\\"tree\\\",\\\"multiValued\\\":true}\"}','{\"wu\":[],\"solr\":{\"content\":\"contacts\\n_objects\\n{\\\"source\\\":\\\"tree\\\",\\\"multiValued\\\":true}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"116\"},\"time\":\"2016-09-20T20:21:21Z\"}}'),(207,'{\"_title\":\"Contact\",\"en\":\"Contact\",\"type\":\"object\",\"visible\":\"Generic-2\"}','{\"wu\":[],\"solr\":{\"content\":\"Contact\\nContact\\nobject\\nGeneric-2\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1755\"},\"time\":\"2016-12-08T17:47:41Z\"}}'),(208,'{\"_title\":\"FirstName\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"FirstName\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-20T20:17:59Z\",\"users\":{\"1\":\"115\"}}}'),(209,'{\"_title\":\"_middlename\",\"en\":\"Middle Name\",\"type\":\"varchar\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"_middlename\\nMiddle Name\\nvarchar\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1250\"},\"time\":\"2016-10-22T01:14:40Z\"}}'),(210,'{\"_title\":\"_birthdate\",\"en\":\"Birth Date\",\"type\":\"date\",\"order\":4,\"cfg\":\"{ \\n\\\"generateAge\\\": \\\"Client Age\\\" \\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_birthdate\\nBirth Date\\ndate\\n4\\n{ \\n\\\"generateAge\\\": \\\"Client Age\\\" \\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1675\"},\"time\":\"2016-12-06T17:10:30Z\"}}'),(211,'{\"_title\":\"_clientage\",\"en\":\"Client Age\",\"type\":\"int\",\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"_clientage\\nClient Age\\nint\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"197\"},\"time\":\"2016-09-29T16:22:42Z\"}}'),(212,'{\"_title\":\"_gender\",\"en\":\"Gender\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\" : 167,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"gender_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_gender\\nGender\\n_objects\\n6\\n{\\n\\\"scope\\\" : 167,\\n\\\"faceting\\\":true\\n}\\ngender_i\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1230\"},\"time\":\"2016-10-21T19:25:02Z\"}}'),(213,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"131\"},\"time\":\"2016-09-29T15:28:48Z\"}}'),(214,'{\"en\":\"Male\",\"iconCls\":\"fa fa-user-secret fa-fl\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Male\\nfa fa-user-secret fa-fl\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"129\"},\"time\":\"2016-09-29T15:28:12Z\"}}'),(215,'{\"en\":\"Female\"}','{\"wu\":[],\"solr\":{\"content\":\"Female\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:28:40Z\",\"users\":{\"1\":\"130\"}}}'),(216,'{\"en\":\"Transgendered Female to Male\"}','{\"wu\":[],\"solr\":{\"content\":\"Transgendered Female to Male\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1074\"},\"time\":\"2016-10-21T15:04:24Z\"}}'),(217,'{\"en\":\"Transgendered Male to Female\"}','{\"wu\":[],\"solr\":{\"content\":\"Transgendered Male to Female\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1073\"},\"time\":\"2016-10-21T15:04:20Z\"}}'),(218,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:29:36Z\",\"users\":{\"1\":\"134\"}}}'),(219,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:29:45Z\",\"users\":{\"1\":\"135\"}}}'),(220,'{\"en\":\"Data Not Collected\"}','{\"wu\":[],\"solr\":{\"content\":\"Data Not Collected\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:29:56Z\",\"users\":{\"1\":\"136\"}}}'),(221,'{\"en\":\"Contact Method\"}','{\"wu\":[],\"solr\":{\"content\":\"Contact Method\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"142\"},\"time\":\"2016-09-29T15:33:06Z\"}}'),(222,'{\"en\":\"Phone\"}','{\"wu\":[],\"solr\":{\"content\":\"Phone\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:30:35Z\",\"users\":{\"1\":\"138\"}}}'),(223,'{\"en\":\"Email\"}','{\"wu\":[],\"solr\":{\"content\":\"Email\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:30:44Z\",\"users\":{\"1\":\"139\"}}}'),(224,'{\"en\":\"Mail\"}','{\"wu\":[],\"solr\":{\"content\":\"Mail\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:30:56Z\",\"users\":{\"1\":\"140\"}}}'),(225,'{\"en\":\"SMS\"}','{\"wu\":[],\"solr\":{\"content\":\"SMS\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:31:04Z\",\"users\":{\"1\":\"141\"}}}'),(226,'{\"en\":\"Ethnicity\"}','{\"wu\":[],\"solr\":{\"content\":\"Ethnicity\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:39:06Z\",\"users\":{\"1\":\"143\"}}}'),(227,'{\"en\":\"Race\"}','{\"wu\":[],\"solr\":{\"content\":\"Race\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:39:18Z\",\"users\":{\"1\":\"144\"}}}'),(228,'{\"en\":\"Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:39:34Z\",\"users\":{\"1\":\"145\"}}}'),(229,'{\"en\":\"Hispanic\\/Latino\"}','{\"wu\":[],\"solr\":{\"content\":\"Hispanic\\/Latino\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:40:13Z\",\"users\":{\"1\":\"146\"}}}'),(230,'{\"en\":\"Non Hispanic\\/Latino\"}','{\"wu\":[],\"solr\":{\"content\":\"Non Hispanic\\/Latino\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:40:25Z\",\"users\":{\"1\":\"147\"}}}'),(231,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:40:39Z\",\"users\":{\"1\":\"148\"}}}'),(232,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:40:52Z\",\"users\":{\"1\":\"149\"}}}'),(233,'{\"en\":\"Data Not Collected\"}','{\"wu\":[],\"solr\":{\"content\":\"Data Not Collected\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:41:04Z\",\"users\":{\"1\":\"150\"}}}'),(234,'{\"en\":\"American Indian Native or Alaska Native\"}','{\"wu\":[],\"solr\":{\"content\":\"American Indian Native or Alaska Native\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:45:29Z\",\"users\":{\"1\":\"151\"}}}'),(235,'{\"en\":\"Asian\"}','{\"wu\":[],\"solr\":{\"content\":\"Asian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:45:39Z\",\"users\":{\"1\":\"152\"}}}'),(236,'{\"en\":\"Black or African American\"}','{\"wu\":[],\"solr\":{\"content\":\"Black or African American\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:45:56Z\",\"users\":{\"1\":\"153\"}}}'),(237,'{\"en\":\"Native Hawaiian or Other Pacific Islander\"}','{\"wu\":[],\"solr\":{\"content\":\"Native Hawaiian or Other Pacific Islander\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:16Z\",\"users\":{\"1\":\"154\"}}}'),(238,'{\"en\":\"White\"}','{\"wu\":[],\"solr\":{\"content\":\"White\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:26Z\",\"users\":{\"1\":\"155\"}}}'),(239,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:41Z\",\"users\":{\"1\":\"156\"}}}'),(240,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:52Z\",\"users\":{\"1\":\"157\"}}}'),(241,'{\"en\":\"Data Not Collected\"}','{\"wu\":[],\"solr\":{\"content\":\"Data Not Collected\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:47:08Z\",\"users\":{\"1\":\"158\"}}}'),(242,'{\"en\":\"English\"}','{\"wu\":[],\"solr\":{\"content\":\"English\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:47:42Z\",\"users\":{\"1\":\"160\"}}}'),(243,'{\"en\":\"Spanish\"}','{\"wu\":[],\"solr\":{\"content\":\"Spanish\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:47:55Z\",\"users\":{\"1\":\"161\"}}}'),(244,'{\"en\":\"French\"}','{\"wu\":[],\"solr\":{\"content\":\"French\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:52:24Z\",\"users\":{\"1\":\"162\"}}}'),(245,'{\"en\":\"German\"}','{\"wu\":[],\"solr\":{\"content\":\"German\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:52:37Z\",\"users\":{\"1\":\"163\"}}}'),(246,'{\"en\":\"Italian\"}','{\"wu\":[],\"solr\":{\"content\":\"Italian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:09Z\",\"users\":{\"1\":\"164\"}}}'),(247,'{\"en\":\"Polish\"}','{\"wu\":[],\"solr\":{\"content\":\"Polish\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:19Z\",\"users\":{\"1\":\"165\"}}}'),(248,'{\"en\":\"Portuguese\"}','{\"wu\":[],\"solr\":{\"content\":\"Portuguese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:35Z\",\"users\":{\"1\":\"166\"}}}'),(249,'{\"en\":\"Russian\"}','{\"wu\":[],\"solr\":{\"content\":\"Russian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:47Z\",\"users\":{\"1\":\"167\"}}}'),(250,'{\"en\":\"Arabic\"}','{\"wu\":[],\"solr\":{\"content\":\"Arabic\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:00Z\",\"users\":{\"1\":\"168\"}}}'),(251,'{\"en\":\"Armenian\"}','{\"wu\":[],\"solr\":{\"content\":\"Armenian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:11Z\",\"users\":{\"1\":\"169\"}}}'),(252,'{\"en\":\"Farsi\"}','{\"wu\":[],\"solr\":{\"content\":\"Farsi\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:22Z\",\"users\":{\"1\":\"170\"}}}'),(253,'{\"en\":\"Hebrew\"}','{\"wu\":[],\"solr\":{\"content\":\"Hebrew\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:32Z\",\"users\":{\"1\":\"171\"}}}'),(254,'{\"en\":\"Turkish\"}','{\"wu\":[],\"solr\":{\"content\":\"Turkish\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:46Z\",\"users\":{\"1\":\"172\"}}}'),(255,'{\"en\":\"Cantonese\"}','{\"wu\":[],\"solr\":{\"content\":\"Cantonese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:55:04Z\",\"users\":{\"1\":\"173\"}}}'),(256,'{\"en\":\"Mandarin\"}','{\"wu\":[],\"solr\":{\"content\":\"Mandarin\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:55:18Z\",\"users\":{\"1\":\"174\"}}}'),(257,'{\"en\":\"Mien\"}','{\"wu\":[],\"solr\":{\"content\":\"Mien\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"177\"},\"time\":\"2016-09-29T15:55:51Z\"}}'),(258,'{\"en\":\"American Sign Language\"}','{\"wu\":[],\"solr\":{\"content\":\"American Sign Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:55:38Z\",\"users\":{\"1\":\"176\"}}}'),(259,'{\"en\":\"Cambodian\"}','{\"wu\":[],\"solr\":{\"content\":\"Cambodian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:56:46Z\",\"users\":{\"1\":\"178\"}}}'),(260,'{\"en\":\"Other Chinese Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Chinese Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:57:06Z\",\"users\":{\"1\":\"179\"}}}'),(261,'{\"en\":\"Hmong\"}','{\"wu\":[],\"solr\":{\"content\":\"Hmong\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:57:16Z\",\"users\":{\"1\":\"180\"}}}'),(262,'{\"en\":\"Lao\"}','{\"wu\":[],\"solr\":{\"content\":\"Lao\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:57:26Z\",\"users\":{\"1\":\"181\"}}}'),(263,'{\"en\":\"Thai\"}','{\"wu\":[],\"solr\":{\"content\":\"Thai\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:59:44Z\",\"users\":{\"1\":\"182\"}}}'),(264,'{\"en\":\"Vietnamese\"}','{\"wu\":[],\"solr\":{\"content\":\"Vietnamese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:59:54Z\",\"users\":{\"1\":\"183\"}}}'),(265,'{\"en\":\"Tagalog\"}','{\"wu\":[],\"solr\":{\"content\":\"Tagalog\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:04Z\",\"users\":{\"1\":\"184\"}}}'),(266,'{\"en\":\"Ilocano\"}','{\"wu\":[],\"solr\":{\"content\":\"Ilocano\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:15Z\",\"users\":{\"1\":\"185\"}}}'),(267,'{\"en\":\"Japanese\"}','{\"wu\":[],\"solr\":{\"content\":\"Japanese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:25Z\",\"users\":{\"1\":\"186\"}}}'),(268,'{\"en\":\"Korean\"}','{\"wu\":[],\"solr\":{\"content\":\"Korean\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:38Z\",\"users\":{\"1\":\"187\"}}}'),(269,'{\"en\":\"Samoan\"}','{\"wu\":[],\"solr\":{\"content\":\"Samoan\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:53Z\",\"users\":{\"1\":\"188\"}}}'),(270,'{\"en\":\"Other Sign Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Sign Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:01:08Z\",\"users\":{\"1\":\"189\"}}}'),(271,'{\"en\":\"Other Non English\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Non English\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:01:22Z\",\"users\":{\"1\":\"190\"}}}'),(272,'{\"_title\":\"_emailaddress\",\"en\":\"Email Address\",\"type\":\"varchar\",\"order\":7}','{\"wu\":[],\"solr\":{\"content\":\"_emailaddress\\nEmail Address\\nvarchar\\n7\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"198\"},\"time\":\"2016-09-29T18:56:31Z\"}}'),(274,'{\"_title\":\"_ethnicity\",\"en\":\"Ethnicity\",\"type\":\"_objects\",\"order\":9,\"cfg\":\"{\\n\\\"scope\\\" : 226\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_ethnicity\\nEthnicity\\n_objects\\n9\\n{\\n\\\"scope\\\" : 226\\n}\\n\",\"order\":9},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1198\"},\"time\":\"2016-10-21T16:27:58Z\"}}'),(275,'{\"_title\":\"_race\",\"en\":\"Race\",\"type\":\"_objects\",\"order\":8,\"cfg\":\"{\\n\\\"scope\\\" : 227\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_race\\nRace\\n_objects\\n8\\n{\\n\\\"scope\\\" : 227\\n}\\n\",\"order\":8},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1199\"},\"time\":\"2016-10-21T16:28:07Z\"}}'),(276,'{\"_title\":\"_primarylanguage\",\"en\":\"Primary Language\",\"type\":\"_objects\",\"order\":10,\"cfg\":\"{\\n\\\"scope\\\" : 228\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_primarylanguage\\nPrimary Language\\n_objects\\n10\\n{\\n\\\"scope\\\" : 228\\n}\\n\",\"order\":10},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"212\"},\"time\":\"2016-09-29T19:08:58Z\"}}'),(277,'{\"_title\":\"_limitedenglish\",\"en\":\"Limited English\",\"type\":\"varchar\",\"order\":11}','{\"wu\":[],\"solr\":{\"content\":\"_limitedenglish\\nLimited English\\nvarchar\\n11\\n\",\"order\":11},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T19:03:14Z\",\"users\":{\"1\":\"203\"}}}'),(278,'{\"_title\":\"_specialatrisk\",\"en\":\"Special\\/At-Risk Populations\",\"type\":\"H\",\"order\":12}','{\"wu\":[],\"solr\":{\"content\":\"_specialatrisk\\nSpecial\\/At-Risk Populations\\nH\\n12\\n\",\"order\":12},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"213\"},\"time\":\"2016-09-29T19:09:06Z\"}}'),(279,'{\"_title\":\"_disabilities\",\"en\":\"Individuals with Disabilities and\\/or Special Needs\",\"type\":\"varchar\",\"order\":13}','{\"wu\":[],\"solr\":{\"content\":\"_disabilities\\nIndividuals with Disabilities and\\/or Special Needs\\nvarchar\\n13\\n\",\"order\":13},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"209\"},\"time\":\"2016-09-29T19:06:59Z\"}}'),(280,'{\"_title\":\"_domestic\",\"en\":\"Individuals Affected by Domestic Violence\",\"type\":\"varchar\",\"order\":14}','{\"wu\":[],\"solr\":{\"content\":\"_domestic\\nIndividuals Affected by Domestic Violence\\nvarchar\\n14\\n\",\"order\":14},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"210\"},\"time\":\"2016-09-29T19:07:14Z\"}}'),(286,'{\"_title\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"Test\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"227\"},\"time\":\"2016-09-29T19:51:59Z\"}}'),(287,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"229\"},\"time\":\"2016-09-29T19:52:15Z\"}}'),(288,'{\"_title\":\"CasesByStatus\",\"value\":\"{\\n\\\"class\\\": \\\"CB\\\\\\\\TreeNode\\\\\\\\FacetNav\\\",\\n\\\"pid\\\": 1,\\n\\\"iconCls\\\": \\\"icon-case\\\",\\n\\\"title_en\\\": \\\"Clients By Status\\\",\\n\\\"fq\\\": [\\n\\\"template_id: 141\\\"\\n],\\n\\\"level_fields\\\": \\\"client_status, fema_tier\\\",\\n\\\"facets\\\": [\\n\\\"client_status\\\",\\n\\\"fema_tier\\\"\\n],\\n\\\"sort\\\": {\\n\\\"property\\\": \\\"_lastname\\\",\\n\\\"direction\\\": \\\"DESC\\\"\\n},\\n\\\"view\\\": \\\"grid\\\",\\n\\\"show_count\\\": true,\\n\\\"show_in_tree\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"CasesByStatus\\n{\\n\\\"class\\\": \\\"CB\\\\\\\\TreeNode\\\\\\\\FacetNav\\\",\\n\\\"pid\\\": 1,\\n\\\"iconCls\\\": \\\"icon-case\\\",\\n\\\"title_en\\\": \\\"Clients By Status\\\",\\n\\\"fq\\\": [\\n\\\"template_id: 141\\\"\\n],\\n\\\"level_fields\\\": \\\"client_status, fema_tier\\\",\\n\\\"facets\\\": [\\n\\\"client_status\\\",\\n\\\"fema_tier\\\"\\n],\\n\\\"sort\\\": {\\n\\\"property\\\": \\\"_lastname\\\",\\n\\\"direction\\\": \\\"DESC\\\"\\n},\\n\\\"view\\\": \\\"grid\\\",\\n\\\"show_count\\\": true,\\n\\\"show_in_tree\\\": true\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"661\"},\"time\":\"2016-10-04T02:24:14Z\"}}'),(289,'{\"_title\":\"FamilyMember\",\"en\":\"Family Member\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-object4\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"{_firstname} {_lastname}\"}','{\"wu\":[],\"solr\":{\"content\":\"FamilyMember\\nFamily Member\\nobject\\n1\\nicon-object4\\n{\\n\\\"leaf\\\":true\\n}\\n{_firstname} {_lastname}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1559\"},\"time\":\"2016-11-14T15:24:41Z\"}}'),(290,'{\"_title\":\"_firstname\",\"en\":\"First Name\",\"type\":\"varchar\",\"order\":1,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_firstname\\nFirst Name\\nvarchar\\n1\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"240\"},\"time\":\"2016-10-03T13:26:58Z\"}}'),(291,'{\"_title\":\"_lastname\",\"en\":\"Last Name\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_lastname\\nLast Name\\nvarchar\\n2\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"241\"},\"time\":\"2016-10-03T13:27:06Z\"}}'),(292,'{\"_title\":\"_birthdate\",\"en\":\"Birth Date\",\"type\":\"date\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"_birthdate\\nBirth Date\\ndate\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"247\"},\"time\":\"2016-10-03T13:30:30Z\"}}'),(293,'{\"_title\":\"_age\",\"en\":\"Age\",\"type\":\"int\",\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"_age\\nAge\\nint\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"266\"},\"time\":\"2016-10-03T13:37:16Z\"}}'),(294,'{\"_title\":\"_gender\",\"en\":\"Gender\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\" : 167\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_gender\\nGender\\n_objects\\n6\\n{\\n\\\"scope\\\" : 167\\n}\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1446\"},\"time\":\"2016-11-02T19:37:16Z\"}}'),(295,'{\"_title\":\"_relationship\",\"en\":\"Relationship to Head of Household\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n\\\"scope\\\" : 299\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_relationship\\nRelationship to Head of Household\\n_objects\\n7\\n{\\n\\\"scope\\\" : 299\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"265\"},\"time\":\"2016-10-03T13:37:05Z\"}}'),(296,'{\"_title\":\"_middlename\",\"en\":\"Middle Name\",\"type\":\"varchar\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"_middlename\\nMiddle Name\\nvarchar\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:30:21Z\",\"users\":{\"1\":\"246\"}}}'),(297,'{\"_title\":\"_race\",\"en\":\"Race\",\"type\":\"_objects\",\"order\":8,\"cfg\":\"{\\n\\\"scope\\\" : 227\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_race\\nRace\\n_objects\\n8\\n{\\n\\\"scope\\\" : 227\\n}\\n\",\"order\":8},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"268\"},\"time\":\"2016-10-03T13:37:32Z\"}}'),(298,'{\"_title\":\"_ethnicity\",\"en\":\"Ethnicity\",\"type\":\"_objects\",\"order\":9,\"cfg\":\"{\\n\\\"scope\\\" : 226\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_ethnicity\\nEthnicity\\n_objects\\n9\\n{\\n\\\"scope\\\" : 226\\n}\\n\",\"order\":9},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1197\"},\"time\":\"2016-10-21T16:25:13Z\"}}'),(299,'{\"en\":\"Relationship\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Relationship\\n1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:33:36Z\",\"users\":{\"1\":\"252\"}}}'),(300,'{\"en\":\"Parent\"}','{\"wu\":[],\"solr\":{\"content\":\"Parent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:33:55Z\",\"users\":{\"1\":\"253\"}}}'),(301,'{\"en\":\"Son\"}','{\"wu\":[],\"solr\":{\"content\":\"Son\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:02Z\",\"users\":{\"1\":\"254\"}}}'),(302,'{\"en\":\"Daughter\"}','{\"wu\":[],\"solr\":{\"content\":\"Daughter\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:11Z\",\"users\":{\"1\":\"255\"}}}'),(303,'{\"en\":\"Dependent Child\"}','{\"wu\":[],\"solr\":{\"content\":\"Dependent Child\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:26Z\",\"users\":{\"1\":\"256\"}}}'),(304,'{\"en\":\"Grandparent\"}','{\"wu\":[],\"solr\":{\"content\":\"Grandparent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:37Z\",\"users\":{\"1\":\"257\"}}}'),(305,'{\"en\":\"Guardian\"}','{\"wu\":[],\"solr\":{\"content\":\"Guardian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:46Z\",\"users\":{\"1\":\"258\"}}}'),(306,'{\"en\":\"Spouse\"}','{\"wu\":[],\"solr\":{\"content\":\"Spouse\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:53Z\",\"users\":{\"1\":\"259\"}}}'),(307,'{\"en\":\"Other Family Member\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Family Member\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:02Z\",\"users\":{\"1\":\"260\"}}}'),(308,'{\"en\":\"Other Non-Family\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Non-Family\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:11Z\",\"users\":{\"1\":\"261\"}}}'),(309,'{\"en\":\"Other Caretaker\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Caretaker\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:19Z\",\"users\":{\"1\":\"262\"}}}'),(310,'{\"en\":\"Ex Spouse\"}','{\"wu\":[],\"solr\":{\"content\":\"Ex Spouse\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:26Z\",\"users\":{\"1\":\"263\"}}}'),(311,'{\"_title\":\"Address\",\"en\":\"Address\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-object8\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Address\"}','{\"wu\":[],\"solr\":{\"content\":\"Address\\nAddress\\nobject\\n1\\nicon-object8\\n{\\n\\\"leaf\\\":true\\n}\\nAddress\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1553\"},\"time\":\"2016-11-14T15:22:24Z\"}}'),(312,'{\"_title\":\"_addresstype\",\"en\":\"Address Type\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"scope\\\" : 321\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_addresstype\\nAddress Type\\n_objects\\n1\\n{\\n\\\"scope\\\" : 321\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"294\"},\"time\":\"2016-10-03T13:55:49Z\"}}'),(313,'{\"_title\":\"_addressone\",\"en\":\"Address One\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"addressone_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_addressone\\nAddress One\\nvarchar\\n2\\n{\\n\\\"faceting\\\":true\\n}\\naddressone_s\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1251\"},\"time\":\"2016-10-22T02:20:48Z\"}}'),(314,'{\"_title\":\"_addresstwo\",\"en\":\"Apt\\/Suite\",\"type\":\"varchar\",\"order\":3,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"undefined\"}','{\"wu\":[],\"solr\":{\"content\":\"_addresstwo\\nApt\\/Suite\\nvarchar\\n3\\n{\\n\\\"faceting\\\":true\\n}\\nundefined\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"982\"},\"time\":\"2016-10-21T13:42:18Z\"}}'),(315,'{\"_title\":\"_city\",\"en\":\"City\",\"type\":\"varchar\",\"order\":4,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"city_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_city\\nCity\\nvarchar\\n4\\n{\\n\\\"faceting\\\":true\\n}\\ncity_s\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"892\"},\"time\":\"2016-10-20T22:17:34Z\"}}'),(316,'{\"_title\":\"_state\",\"en\":\"State\",\"type\":\"varchar\",\"order\":4,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"state_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_state\\nState\\nvarchar\\n4\\n{\\n\\\"faceting\\\":true\\n}\\nstate_s\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"921\"},\"time\":\"2016-10-21T01:45:36Z\"}}'),(317,'{\"_title\":\"_zip\",\"en\":\"Zip code\",\"type\":\"int\",\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"_zip\\nZip code\\nint\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:50:40Z\",\"users\":{\"1\":\"278\"}}}'),(318,'{\"_title\":\"_begindate\",\"en\":\"Begin Date\",\"type\":\"date\",\"order\":6}','{\"wu\":[],\"solr\":{\"content\":\"_begindate\\nBegin Date\\ndate\\n6\\n\",\"order\":6},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:51:11Z\",\"users\":{\"1\":\"279\"}}}'),(319,'{\"_title\":\"_enddate\",\"en\":\"End Date\",\"type\":\"date\",\"order\":7}','{\"wu\":[],\"solr\":{\"content\":\"_enddate\\nEnd Date\\ndate\\n7\\n\",\"order\":7},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:51:48Z\",\"users\":{\"1\":\"280\"}}}'),(320,'{\"_title\":\"_primaryphone\",\"en\":\"Primary Phone\",\"type\":\"varchar\",\"order\":8}','{\"wu\":[],\"solr\":{\"content\":\"_primaryphone\\nPrimary Phone\\nvarchar\\n8\\n\",\"order\":8},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:52:12Z\",\"users\":{\"1\":\"281\"}}}'),(321,'{\"en\":\"AddressType\"}','{\"wu\":[],\"solr\":{\"content\":\"AddressType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:52:35Z\",\"users\":{\"1\":\"282\"}}}'),(322,'{\"en\":\"Current Mailing\"}','{\"wu\":[],\"solr\":{\"content\":\"Current Mailing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:09Z\",\"users\":{\"1\":\"283\"}}}'),(323,'{\"en\":\"Temporary\"}','{\"wu\":[],\"solr\":{\"content\":\"Temporary\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:17Z\",\"users\":{\"1\":\"284\"}}}'),(324,'{\"en\":\"Summer\"}','{\"wu\":[],\"solr\":{\"content\":\"Summer\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:24Z\",\"users\":{\"1\":\"285\"}}}'),(325,'{\"en\":\"Previous Mailing\"}','{\"wu\":[],\"solr\":{\"content\":\"Previous Mailing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:33Z\",\"users\":{\"1\":\"286\"}}}'),(326,'{\"en\":\"Emergency\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:42Z\",\"users\":{\"1\":\"287\"}}}'),(327,'{\"en\":\"Business Address\\/Place of Employment\"}','{\"wu\":[],\"solr\":{\"content\":\"Business Address\\/Place of Employment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:54Z\",\"users\":{\"1\":\"288\"}}}'),(328,'{\"en\":\"Residential\"}','{\"wu\":[],\"solr\":{\"content\":\"Residential\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:04Z\",\"users\":{\"1\":\"289\"}}}'),(329,'{\"en\":\"Transitional\"}','{\"wu\":[],\"solr\":{\"content\":\"Transitional\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:14Z\",\"users\":{\"1\":\"290\"}}}'),(330,'{\"en\":\"Last Permanent Address\"}','{\"wu\":[],\"solr\":{\"content\":\"Last Permanent Address\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:26Z\",\"users\":{\"1\":\"291\"}}}'),(331,'{\"en\":\"Permanent Supportive\"}','{\"wu\":[],\"solr\":{\"content\":\"Permanent Supportive\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:38Z\",\"users\":{\"1\":\"292\"}}}'),(332,'{\"en\":\"Homeless in Area of Disaster\"}','{\"wu\":[],\"solr\":{\"content\":\"Homeless in Area of Disaster\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:51Z\",\"users\":{\"1\":\"293\"}}}'),(333,'{\"_title\":\"Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"299\"},\"time\":\"2016-10-03T14:14:18Z\"}}'),(334,'{\"en\":\"LivingArrangement\",\"visible\":\"Generic-4\"}','{\"wu\":[],\"solr\":{\"content\":\"LivingArrangement\\nGeneric-4\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:14:42Z\",\"users\":{\"1\":\"300\"}}}'),(335,'{\"en\":\"Owned house\\/condominium\"}','{\"wu\":[],\"solr\":{\"content\":\"Owned house\\/condominium\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:14:58Z\",\"users\":{\"1\":\"301\"}}}'),(336,'{\"en\":\"Rental house\"}','{\"wu\":[],\"solr\":{\"content\":\"Rental house\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:07Z\",\"users\":{\"1\":\"302\"}}}'),(337,'{\"en\":\"Rental apartment\"}','{\"wu\":[],\"solr\":{\"content\":\"Rental apartment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:18Z\",\"users\":{\"1\":\"303\"}}}'),(338,'{\"en\":\"Staying with friends\\/family\"}','{\"wu\":[],\"solr\":{\"content\":\"Staying with friends\\/family\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:30Z\",\"users\":{\"1\":\"304\"}}}'),(339,'{\"en\":\"Shelter (domestic violence, homeless, runaway and youth)\"}','{\"wu\":[],\"solr\":{\"content\":\"Shelter (domestic violence, homeless, runaway and youth)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:51Z\",\"users\":{\"1\":\"305\"}}}'),(340,'{\"en\":\"Military Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Military Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:01Z\",\"users\":{\"1\":\"306\"}}}'),(341,'{\"en\":\"Student dormitory\"}','{\"wu\":[],\"solr\":{\"content\":\"Student dormitory\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:11Z\",\"users\":{\"1\":\"307\"}}}'),(342,'{\"en\":\"Group home or nursing home\"}','{\"wu\":[],\"solr\":{\"content\":\"Group home or nursing home\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:23Z\",\"users\":{\"1\":\"308\"}}}'),(343,'{\"en\":\"Subsidized housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Subsidized housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:33Z\",\"users\":{\"1\":\"309\"}}}'),(344,'{\"en\":\"Homeless\"}','{\"wu\":[],\"solr\":{\"content\":\"Homeless\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:42Z\",\"users\":{\"1\":\"310\"}}}'),(345,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:49Z\",\"users\":{\"1\":\"311\"}}}'),(346,'{\"en\":\"YesNoRefused\"}','{\"wu\":[],\"solr\":{\"content\":\"YesNoRefused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:17:10Z\",\"users\":{\"1\":\"312\"}}}'),(347,'{\"en\":\"Yes\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Yes\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"641\"},\"time\":\"2016-10-03T19:40:45Z\"}}'),(348,'{\"en\":\"No\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"No\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"642\"},\"time\":\"2016-10-03T19:40:59Z\"}}'),(349,'{\"en\":\"Don''t know\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Don''t know\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"643\"},\"time\":\"2016-10-03T19:41:12Z\"}}'),(350,'{\"en\":\"Refused\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"644\"},\"time\":\"2016-10-03T19:41:24Z\"}}'),(351,'{\"en\":\"InspectingAgent\"}','{\"wu\":[],\"solr\":{\"content\":\"InspectingAgent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:08Z\",\"users\":{\"1\":\"317\"}}}'),(352,'{\"en\":\"By an insurance adjustor\"}','{\"wu\":[],\"solr\":{\"content\":\"By an insurance adjustor\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:25Z\",\"users\":{\"1\":\"318\"}}}'),(353,'{\"en\":\"By a FEMA official\"}','{\"wu\":[],\"solr\":{\"content\":\"By a FEMA official\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:36Z\",\"users\":{\"1\":\"319\"}}}'),(354,'{\"en\":\"By a local government official\"}','{\"wu\":[],\"solr\":{\"content\":\"By a local government official\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:48Z\",\"users\":{\"1\":\"320\"}}}'),(355,'{\"en\":\"DamageRating\"}','{\"wu\":[],\"solr\":{\"content\":\"DamageRating\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:13Z\",\"users\":{\"1\":\"321\"}}}'),(356,'{\"en\":\"Not Damaged\"}','{\"wu\":[],\"solr\":{\"content\":\"Not Damaged\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:31Z\",\"users\":{\"1\":\"322\"}}}'),(357,'{\"en\":\"Minor\"}','{\"wu\":[],\"solr\":{\"content\":\"Minor\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:38Z\",\"users\":{\"1\":\"323\"}}}'),(358,'{\"en\":\"Major\"}','{\"wu\":[],\"solr\":{\"content\":\"Major\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:44Z\",\"users\":{\"1\":\"324\"}}}'),(359,'{\"en\":\"Destroyed\"}','{\"wu\":[],\"solr\":{\"content\":\"Destroyed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:53Z\",\"users\":{\"1\":\"325\"}}}'),(360,'{\"en\":\"Client doesn''t know\"}','{\"wu\":[],\"solr\":{\"content\":\"Client doesn''t know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:04Z\",\"users\":{\"1\":\"326\"}}}'),(361,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:11Z\",\"users\":{\"1\":\"327\"}}}'),(362,'{\"en\":\"Utilities\"}','{\"wu\":[],\"solr\":{\"content\":\"Utilities\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"332\"},\"time\":\"2016-10-03T14:21:29Z\"}}'),(363,'{\"en\":\"Electrical power\"}','{\"wu\":[],\"solr\":{\"content\":\"Electrical power\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:45Z\",\"users\":{\"1\":\"329\"}}}'),(364,'{\"en\":\"Phone\"}','{\"wu\":[],\"solr\":{\"content\":\"Phone\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:56Z\",\"users\":{\"1\":\"330\"}}}'),(365,'{\"en\":\"Water\"}','{\"wu\":[],\"solr\":{\"content\":\"Water\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:21:06Z\",\"users\":{\"1\":\"331\"}}}'),(366,'{\"en\":\"Gas\"}','{\"wu\":[],\"solr\":{\"content\":\"Gas\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:21:41Z\",\"users\":{\"1\":\"333\"}}}'),(367,'{\"en\":\"Internet access\"}','{\"wu\":[],\"solr\":{\"content\":\"Internet access\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:21:52Z\",\"users\":{\"1\":\"334\"}}}'),(368,'{\"en\":\"Propane\"}','{\"wu\":[],\"solr\":{\"content\":\"Propane\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:02Z\",\"users\":{\"1\":\"335\"}}}'),(369,'{\"en\":\"Fuel oil\"}','{\"wu\":[],\"solr\":{\"content\":\"Fuel oil\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:12Z\",\"users\":{\"1\":\"336\"}}}'),(370,'{\"en\":\"Steam heat\"}','{\"wu\":[],\"solr\":{\"content\":\"Steam heat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:21Z\",\"users\":{\"1\":\"337\"}}}'),(371,'{\"en\":\"Sewer and Sanitation\"}','{\"wu\":[],\"solr\":{\"content\":\"Sewer and Sanitation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:33Z\",\"users\":{\"1\":\"338\"}}}'),(372,'{\"en\":\"InsuranceStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"InsuranceStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:56Z\",\"users\":{\"1\":\"339\"}}}'),(373,'{\"en\":\"Client owned home and had homeowner''s insurance\"}','{\"wu\":[],\"solr\":{\"content\":\"Client owned home and had homeowner''s insurance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:23:36Z\",\"users\":{\"1\":\"340\"}}}'),(374,'{\"en\":\"Client rented home and had renter''s insurance\"}','{\"wu\":[],\"solr\":{\"content\":\"Client rented home and had renter''s insurance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:23:49Z\",\"users\":{\"1\":\"341\"}}}'),(375,'{\"en\":\"Client had hazard-specific insurance for disaster type (food, fire, earthquake)\"}','{\"wu\":[],\"solr\":{\"content\":\"Client had hazard-specific insurance for disaster type (food, fire, earthquake)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:09Z\",\"users\":{\"1\":\"342\"}}}'),(376,'{\"en\":\"Lack of appropriate Insurance Coverage\"}','{\"wu\":[],\"solr\":{\"content\":\"Lack of appropriate Insurance Coverage\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:22Z\",\"users\":{\"1\":\"343\"}}}'),(377,'{\"en\":\"Client does not know insurance status\"}','{\"wu\":[],\"solr\":{\"content\":\"Client does not know insurance status\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:34Z\",\"users\":{\"1\":\"344\"}}}'),(378,'{\"en\":\"Client was insured but does not have insurance policy information\"}','{\"wu\":[],\"solr\":{\"content\":\"Client was insured but does not have insurance policy information\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:49Z\",\"users\":{\"1\":\"345\"}}}'),(379,'{\"en\":\"Client was uninsured\"}','{\"wu\":[],\"solr\":{\"content\":\"Client was uninsured\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:58Z\",\"users\":{\"1\":\"346\"}}}'),(380,'{\"en\":\"HousingServiceType\"}','{\"wu\":[],\"solr\":{\"content\":\"HousingServiceType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:31:51Z\",\"users\":{\"1\":\"347\"}}}'),(381,'{\"en\":\"Emergency Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:03Z\",\"users\":{\"1\":\"348\"}}}'),(382,'{\"en\":\"Housing Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:14Z\",\"users\":{\"1\":\"349\"}}}'),(383,'{\"en\":\"Housing Bednight\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Bednight\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:25Z\",\"users\":{\"1\":\"350\"}}}'),(384,'{\"en\":\"Housing Placement\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Placement\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:36Z\",\"users\":{\"1\":\"351\"}}}'),(385,'{\"en\":\"Housing Reservation\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Reservation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:50Z\",\"users\":{\"1\":\"352\"}}}'),(386,'{\"en\":\"Tarp \\/ Blue Roof\"}','{\"wu\":[],\"solr\":{\"content\":\"Tarp \\/ Blue Roof\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:33:02Z\",\"users\":{\"1\":\"353\"}}}'),(387,'{\"en\":\"Temporary Housing and Other Financial Aid\"}','{\"wu\":[],\"solr\":{\"content\":\"Temporary Housing and Other Financial Aid\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:33:21Z\",\"users\":{\"1\":\"354\"}}}'),(388,'{\"en\":\"Transitional Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Transitional Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:33:33Z\",\"users\":{\"1\":\"355\"}}}'),(389,'{\"en\":\"IncomeGroup\"}','{\"wu\":[],\"solr\":{\"content\":\"IncomeGroup\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:34:58Z\",\"users\":{\"1\":\"356\"}}}'),(390,'{\"en\":\"Cash Income\"}','{\"wu\":[],\"solr\":{\"content\":\"Cash Income\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:35:08Z\",\"users\":{\"1\":\"357\"}}}'),(391,'{\"en\":\"Non-cash benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Non-cash benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:35:17Z\",\"users\":{\"1\":\"358\"}}}'),(392,'{\"en\":\"TransportationMode\"}','{\"wu\":[],\"solr\":{\"content\":\"TransportationMode\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:41:42Z\",\"users\":{\"1\":\"359\"}}}'),(393,'{\"en\":\"Privately owned vehicle or motorcycle\"}','{\"wu\":[],\"solr\":{\"content\":\"Privately owned vehicle or motorcycle\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:00Z\",\"users\":{\"1\":\"360\"}}}'),(394,'{\"en\":\"Public Transit\"}','{\"wu\":[],\"solr\":{\"content\":\"Public Transit\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:10Z\",\"users\":{\"1\":\"361\"}}}'),(395,'{\"en\":\"Paratransit\"}','{\"wu\":[],\"solr\":{\"content\":\"Paratransit\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:18Z\",\"users\":{\"1\":\"362\"}}}'),(396,'{\"en\":\"Carshare\"}','{\"wu\":[],\"solr\":{\"content\":\"Carshare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:26Z\",\"users\":{\"1\":\"363\"}}}'),(397,'{\"en\":\"Ride with friends\\/family\"}','{\"wu\":[],\"solr\":{\"content\":\"Ride with friends\\/family\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:36Z\",\"users\":{\"1\":\"364\"}}}'),(398,'{\"en\":\"Bike\"}','{\"wu\":[],\"solr\":{\"content\":\"Bike\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:43Z\",\"users\":{\"1\":\"365\"}}}'),(399,'{\"en\":\"Walk\"}','{\"wu\":[],\"solr\":{\"content\":\"Walk\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:50Z\",\"users\":{\"1\":\"366\"}}}'),(400,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:58Z\",\"users\":{\"1\":\"367\"}}}'),(401,'{\"en\":\"TransportationNeed\"}','{\"wu\":[],\"solr\":{\"content\":\"TransportationNeed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:21Z\",\"users\":{\"1\":\"368\"}}}'),(402,'{\"en\":\"Vehicle lost\\/destroyed\"}','{\"wu\":[],\"solr\":{\"content\":\"Vehicle lost\\/destroyed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:37Z\",\"users\":{\"1\":\"369\"}}}'),(403,'{\"en\":\"Public transit not working\"}','{\"wu\":[],\"solr\":{\"content\":\"Public transit not working\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:46Z\",\"users\":{\"1\":\"370\"}}}'),(404,'{\"en\":\"Paratransit not working\\/accessible\"}','{\"wu\":[],\"solr\":{\"content\":\"Paratransit not working\\/accessible\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:58Z\",\"users\":{\"1\":\"371\"}}}'),(405,'{\"en\":\"Road closure\\/damage\"}','{\"wu\":[],\"solr\":{\"content\":\"Road closure\\/damage\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:07Z\",\"users\":{\"1\":\"372\"}}}'),(406,'{\"en\":\"Unable to afford gas\"}','{\"wu\":[],\"solr\":{\"content\":\"Unable to afford gas\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:17Z\",\"users\":{\"1\":\"373\"}}}'),(407,'{\"en\":\"Unable to afford transit fare\"}','{\"wu\":[],\"solr\":{\"content\":\"Unable to afford transit fare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:29Z\",\"users\":{\"1\":\"374\"}}}'),(408,'{\"en\":\"Unable to afford gas dependably\"}','{\"wu\":[],\"solr\":{\"content\":\"Unable to afford gas dependably\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:51Z\",\"users\":{\"1\":\"375\"}}}'),(409,'{\"en\":\"Accessible vehicle not available\"}','{\"wu\":[],\"solr\":{\"content\":\"Accessible vehicle not available\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:45:06Z\",\"users\":{\"1\":\"376\"}}}'),(410,'{\"en\":\"PaymentStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"PaymentStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:01Z\",\"users\":{\"1\":\"377\"}}}'),(411,'{\"en\":\"EmploymentTenure\"}','{\"wu\":[],\"solr\":{\"content\":\"EmploymentTenure\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"392\"},\"time\":\"2016-10-03T14:52:51Z\"}}'),(412,'{\"en\":\"Received Payment\"}','{\"wu\":[],\"solr\":{\"content\":\"Received Payment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:21Z\",\"users\":{\"1\":\"379\"}}}'),(413,'{\"en\":\"Denied\"}','{\"wu\":[],\"solr\":{\"content\":\"Denied\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:29Z\",\"users\":{\"1\":\"380\"}}}'),(414,'{\"en\":\"Pending Payment\"}','{\"wu\":[],\"solr\":{\"content\":\"Pending Payment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:39Z\",\"users\":{\"1\":\"381\"}}}'),(415,'{\"en\":\"Pending Decision\"}','{\"wu\":[],\"solr\":{\"content\":\"Pending Decision\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:49Z\",\"users\":{\"1\":\"382\"}}}'),(416,'{\"en\":\"InsuranceType\"}','{\"wu\":[],\"solr\":{\"content\":\"InsuranceType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:12Z\",\"users\":{\"1\":\"383\"}}}'),(417,'{\"en\":\"Private\"}','{\"wu\":[],\"solr\":{\"content\":\"Private\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:23Z\",\"users\":{\"1\":\"384\"}}}'),(418,'{\"en\":\"Medicare\"}','{\"wu\":[],\"solr\":{\"content\":\"Medicare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:31Z\",\"users\":{\"1\":\"385\"}}}'),(419,'{\"en\":\"Medicaid\"}','{\"wu\":[],\"solr\":{\"content\":\"Medicaid\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:41Z\",\"users\":{\"1\":\"386\"}}}'),(420,'{\"en\":\"State Children''s Health Insurance Program S-CHIP\"}','{\"wu\":[],\"solr\":{\"content\":\"State Children''s Health Insurance Program S-CHIP\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:55Z\",\"users\":{\"1\":\"387\"}}}'),(421,'{\"en\":\"Military Insurance\"}','{\"wu\":[],\"solr\":{\"content\":\"Military Insurance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:49:04Z\",\"users\":{\"1\":\"388\"}}}'),(422,'{\"en\":\"Other Public\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Public\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:49:13Z\",\"users\":{\"1\":\"389\"}}}'),(423,'{\"en\":\"CaseNoteType\"}','{\"wu\":[],\"solr\":{\"content\":\"CaseNoteType\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"391\"},\"time\":\"2016-10-03T14:51:31Z\"}}'),(424,'{\"en\":\"Permanent\"}','{\"wu\":[],\"solr\":{\"content\":\"Permanent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:25Z\",\"users\":{\"1\":\"393\"}}}'),(425,'{\"en\":\"Temporary\"}','{\"wu\":[],\"solr\":{\"content\":\"Temporary\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:34Z\",\"users\":{\"1\":\"394\"}}}'),(426,'{\"en\":\"Seasonal\"}','{\"wu\":[],\"solr\":{\"content\":\"Seasonal\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:42Z\",\"users\":{\"1\":\"395\"}}}'),(427,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:50Z\",\"users\":{\"1\":\"396\"}}}'),(428,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:57Z\",\"users\":{\"1\":\"397\"}}}'),(429,'{\"en\":\"AssessmentOrder\"}','{\"wu\":[],\"solr\":{\"content\":\"AssessmentOrder\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:54:31Z\",\"users\":{\"1\":\"398\"}}}'),(430,'{\"en\":\"Pre-Disaster\"}','{\"wu\":[],\"solr\":{\"content\":\"Pre-Disaster\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:54:53Z\",\"users\":{\"1\":\"399\"}}}'),(431,'{\"en\":\"Post-Disaster\"}','{\"wu\":[],\"solr\":{\"content\":\"Post-Disaster\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:55:02Z\",\"users\":{\"1\":\"400\"}}}'),(432,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1322\"},\"time\":\"2016-10-28T19:48:28Z\"}}'),(433,'{\"_title\":\"_primarymode\",\"en\":\"What was the client''s primary mode of transportation prior to the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 392\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_primarymode\\nWhat was the client''s primary mode of transportation prior to the disaster?\\n_objects\\n{\\n\\\"scope\\\": 392\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1659\"},\"time\":\"2016-11-14T20:56:51Z\"}}'),(434,'{\"_title\":\"_methodworking\",\"en\":\"Is this method of transportation still working for the client post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_methodworking\\nIs this method of transportation still working for the client post-disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1550\"},\"time\":\"2016-11-10T16:30:25Z\"}}'),(435,'{\"_title\":\"_ifnotworking\",\"en\":\"If the client''s primary mode of transportation prior to the disaster is a privately owned vehicle or motorcycle and the method of transportation is not working post-disaster, answer the following:\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_ifnotworking\\nIf the client''s primary mode of transportation prior to the disaster is a privately owned vehicle or motorcycle and the method of transportation is not working post-disaster, answer the following:\\nH\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1660\"},\"time\":\"2016-11-14T20:57:08Z\"}}'),(436,'{\"_title\":\"_insured\",\"en\":\"Was it insured?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insured\\nWas it insured?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:04:59Z\",\"users\":{\"1\":\"406\"}}}'),(437,'{\"_title\":\"_receivedpayment\",\"en\":\"Have you received payments or been denied by your insurer?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_receivedpayment\\nHave you received payments or been denied by your insurer?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:05:32Z\",\"users\":{\"1\":\"407\"}}}'),(438,'{\"_title\":\"_damagedindisaster\",\"en\":\"Was your vehicle damaged in the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_damagedindisaster\\nWas your vehicle damaged in the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:06:11Z\",\"users\":{\"1\":\"408\"}}}'),(439,'{\"_title\":\"_transportationneeds\",\"en\":\"Transportation Needs\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 401\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_transportationneeds\\nTransportation Needs\\n_objects\\n{\\n\\\"scope\\\": 401\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"670\"},\"time\":\"2016-10-08T23:59:11Z\"}}'),(440,'{\"_title\":\"HousingAssessment\",\"en\":\"Housing Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-object8\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Housing Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"HousingAssessment\\nHousing Assessment\\nobject\\n1\\nicon-object8\\n{\\n\\\"leaf\\\":true\\n}\\nHousing Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1564\"},\"time\":\"2016-11-14T15:25:24Z\"}}'),(441,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1318\"},\"time\":\"2016-10-28T19:47:52Z\"}}'),(442,'{\"_title\":\"_predisasterliving\",\"en\":\"Where did the client live pre-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":334\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_predisasterliving\\nWhere did the client live pre-disaster?\\n_objects\\n{\\n\\\"scope\\\":334\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:32:29Z\",\"users\":{\"1\":\"413\"}}}'),(443,'{\"_title\":\"_damagedhouse\",\"en\":\"In the disaster, was client home damaged or affected?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_damagedhouse\\nIn the disaster, was client home damaged or affected?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:33:27Z\",\"users\":{\"1\":\"414\"}}}'),(444,'{\"_title\":\"_inspectedhouse\",\"en\":\"If client home was damaged, has the home been inspected?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\t\\\"scope\\\": 351\\n\\t,\\\"dependency\\\": {\\n\\t\\t\\\"pidValues\\\": [347]\\n\\t}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_inspectedhouse\\nIf client home was damaged, has the home been inspected?\\n_objects\\n{\\n\\t\\\"scope\\\": 351\\n\\t,\\\"dependency\\\": {\\n\\t\\t\\\"pidValues\\\": [347]\\n\\t}\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1490\"},\"time\":\"2016-11-04T14:56:02Z\"}}'),(445,'{\"_title\":\"_accessiblehouse\",\"en\":\"Is the client able to access the home?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_accessiblehouse\\nIs the client able to access the home?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"419\"},\"time\":\"2016-10-03T15:36:03Z\"}}'),(446,'{\"_title\":\"_livablehouse\",\"en\":\"Does client consider home livable or inhabitable?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_livablehouse\\nDoes client consider home livable or inhabitable?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"418\"},\"time\":\"2016-10-03T15:35:52Z\"}}'),(447,'{\"_title\":\"_clientdamagerating\",\"en\":\"Client Damage Rating\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 355\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientdamagerating\\nClient Damage Rating\\n_objects\\n{\\n\\\"scope\\\": 355\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:36:30Z\",\"users\":{\"1\":\"420\"}}}'),(448,'{\"_title\":\"_clientrelocated\",\"en\":\"Was client relocated\\/evacuated?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientrelocated\\nWas client relocated\\/evacuated?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:37:06Z\",\"users\":{\"1\":\"421\"}}}'),(449,'{\"_title\":\"_planstoreturn\",\"en\":\"If yes, what are client''s plan to return home?\",\"type\":\"text\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n   \\t\\\"pidValues\\\": [347]\\n    }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_planstoreturn\\nIf yes, what are client''s plan to return home?\\ntext\\n{\\n   \\\"dependency\\\": {\\n   \\t\\\"pidValues\\\": [347]\\n    }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1656\"},\"time\":\"2016-11-14T20:55:02Z\"}}'),(450,'{\"_title\":\"_utilitieswork\",\"en\":\"Do all of client''s utilities work?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_utilitieswork\\nDo all of client''s utilities work?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1654\"},\"time\":\"2016-11-14T20:53:58Z\"}}'),(451,'{\"_title\":\"_utilitiesnotworking\",\"en\":\"If no, please select utilities that do not work\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 362\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_utilitiesnotworking\\nIf no, please select utilities that do not work\\n_objects\\n{\\n   \\\"scope\\\": 362\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1487\"},\"time\":\"2016-11-04T14:52:53Z\"}}'),(452,'{\"_title\":\"_disasterImpacts\",\"en\":\"Details of Disaster Impacts to Home\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_disasterImpacts\\nDetails of Disaster Impacts to Home\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:39:23Z\",\"users\":{\"1\":\"425\"}}}'),(453,'{\"_title\":\"_predisasterinsurance\",\"en\":\"Pre-disaster housing insurance status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 372\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_predisasterinsurance\\nPre-disaster housing insurance status\\n_objects\\n{\\n\\\"scope\\\": 372\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:40:02Z\",\"users\":{\"1\":\"426\"}}}'),(454,'{\"_title\":\"_insurancedetails\",\"en\":\"Details of insurance information\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_insurancedetails\\nDetails of insurance information\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:40:35Z\",\"users\":{\"1\":\"427\"}}}'),(455,'{\"_title\":\"FinancialAssessment\",\"en\":\"Financial Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-echr_complaint\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Financial Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"FinancialAssessment\\nFinancial Assessment\\nobject\\n1\\nicon-echr_complaint\\n{\\n\\\"leaf\\\":true\\n}\\nFinancial Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1560\"},\"time\":\"2016-11-14T15:24:50Z\"}}'),(456,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1315\"},\"time\":\"2016-10-28T19:47:12Z\"}}'),(457,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1652\"},\"time\":\"2016-11-14T20:51:48Z\"}}'),(458,'{\"_title\":\"_incomereceived\",\"en\":\"Income Received?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_incomereceived\\nIncome Received?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1651\"},\"time\":\"2016-11-14T20:51:27Z\"}}'),(459,'{\"_title\":\"_noncashbenefits\",\"en\":\"Non-cash Benefits?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_noncashbenefits\\nNon-cash Benefits?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1650\"},\"time\":\"2016-11-14T20:51:03Z\"}}'),(460,'{\"_title\":\"_incomeGroup\",\"en\":\"Income Group\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 389\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_incomeGroup\\nIncome Group\\n_objects\\n{\\n\\\"scope\\\": 389\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:44:54Z\",\"users\":{\"1\":\"433\"}}}'),(461,'{\"_title\":\"_noncashbenefits\",\"en\":\"If Income or Non-cash Benefits received, enter income\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_noncashbenefits\\nIf Income or Non-cash Benefits received, enter income\\nH\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:46:01Z\",\"users\":{\"1\":\"434\"}}}'),(462,'{\"_title\":\"_earnedIncome\",\"en\":\"Earned income (i.e. employment income)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_earnedIncome\\nEarned income (i.e. employment income)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:46:26Z\",\"users\":{\"1\":\"435\"}}}'),(463,'{\"_title\":\"_unemploymentinsurance\",\"en\":\"Unemployment Insurance\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_unemploymentinsurance\\nUnemployment Insurance\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:46:56Z\",\"users\":{\"1\":\"436\"}}}'),(464,'{\"_title\":\"_ssi\",\"en\":\"Supplemental Security Income (SSI)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_ssi\\nSupplemental Security Income (SSI)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:47:26Z\",\"users\":{\"1\":\"437\"}}}'),(465,'{\"_title\":\"_ssdi\",\"en\":\"Social Security Disability Income (SSDI)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_ssdi\\nSocial Security Disability Income (SSDI)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:47:49Z\",\"users\":{\"1\":\"438\"}}}'),(466,'{\"_title\":\"_veteransdisability\",\"en\":\"Veterans Disability Payment\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_veteransdisability\\nVeterans Disability Payment\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:48:24Z\",\"users\":{\"1\":\"439\"}}}'),(467,'{\"_title\":\"MonthlyExpensesAssessment\",\"en\":\"Monthly Expenses Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-echr_complaint\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Monthly Expenses Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"MonthlyExpensesAssessment\\nMonthly Expenses Assessment\\nobject\\n1\\nicon-echr_complaint\\n{\\n\\\"leaf\\\":true\\n}\\nMonthly Expenses Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1566\"},\"time\":\"2016-11-14T15:25:42Z\"}}'),(468,'{\"_title\":\"_assessmentorder\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentorder\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"442\"},\"time\":\"2016-10-03T15:51:19Z\"}}'),(469,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1320\"},\"time\":\"2016-10-28T19:48:10Z\"}}'),(470,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1658\"},\"time\":\"2016-11-14T20:56:05Z\"}}'),(471,'{\"_title\":\"_rent\",\"en\":\"Rent\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\" : \\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_rent\\nRent\\nfloat\\n{ \\n\\\"totalValue\\\" : \\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1689\"},\"time\":\"2016-12-06T17:33:16Z\"}}'),(472,'{\"_title\":\"_mortgage\",\"en\":\"Mortgage\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_mortgage\\nMortgage\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1680\"},\"time\":\"2016-12-06T17:23:15Z\"}}'),(473,'{\"_title\":\"_maintenance\",\"en\":\"Maintenance\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_maintenance\\nMaintenance\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1681\"},\"time\":\"2016-12-06T17:23:49Z\"}}'),(474,'{\"_title\":\"_carpayment\",\"en\":\"Car Payment\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_carpayment\\nCar Payment\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1687\"},\"time\":\"2016-12-06T17:26:31Z\"}}'),(475,'{\"_title\":\"_carinsurance\",\"en\":\"Car Insurance\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_carinsurance\\nCar Insurance\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1686\"},\"time\":\"2016-12-06T17:26:22Z\"}}'),(476,'{\"_title\":\"_gasoline\",\"en\":\"Gasoline\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_gasoline\\nGasoline\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1685\"},\"time\":\"2016-12-06T17:26:15Z\"}}'),(477,'{\"_title\":\"_medical\",\"en\":\"Medical\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_medical\\nMedical\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1684\"},\"time\":\"2016-12-06T17:26:06Z\"}}'),(478,'{\"_title\":\"_food\",\"en\":\"Food\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_food\\nFood\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1683\"},\"time\":\"2016-12-06T17:25:58Z\"}}'),(479,'{\"_title\":\"_miscellaneous\",\"en\":\"Miscellaneous\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_miscellaneous\\nMiscellaneous\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1682\"},\"time\":\"2016-12-06T17:25:49Z\"}}'),(480,'{\"_title\":\"_totalExpenses\",\"en\":\"Number of Expenses\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_totalExpenses\\nNumber of Expenses\\nint\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1678\"},\"time\":\"2016-12-06T17:22:20Z\"}}'),(481,'{\"_title\":\"_totalmonthlyamount\",\"en\":\"Total monthly amount\",\"type\":\"float\",\"cfg\":\"{\\n\\\"readonly\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_totalmonthlyamount\\nTotal monthly amount\\nfloat\\n{\\n\\\"readonly\\\":true\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1677\"},\"time\":\"2016-12-06T17:21:36Z\"}}'),(482,'{\"_title\":\"EmploymentAssessment\",\"en\":\"Employment Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-employment\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Employment Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"EmploymentAssessment\\nEmployment Assessment\\nobject\\n1\\nicon-assessment-employment\\n{\\n\\\"leaf\\\":true\\n}\\nEmployment Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1558\"},\"time\":\"2016-11-14T15:24:30Z\"}}'),(483,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1314\"},\"time\":\"2016-10-28T19:46:56Z\"}}'),(484,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1648\"},\"time\":\"2016-11-14T20:50:31Z\"}}'),(485,'{\"_title\":\"_employed\",\"en\":\"Employed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_employed\\nEmployed?\\n_objects\\n{\\n\\\"scope\\\":346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1445\"},\"time\":\"2016-11-02T19:37:01Z\"}}'),(486,'{\"_title\":\"_hoursworked\",\"en\":\"Hours worked last week\",\"type\":\"int\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_hoursworked\\nHours worked last week\\nint\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1536\"},\"time\":\"2016-11-04T17:34:56Z\"}}'),(487,'{\"_title\":\"_employmenttenure\",\"en\":\"Employment Tenure\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 411\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_employmenttenure\\nEmployment Tenure\\n_objects\\n{\\n   \\\"scope\\\": 411\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1538\"},\"time\":\"2016-11-04T17:35:48Z\"}}'),(488,'{\"_title\":\"_additionalemployment\",\"en\":\"Looking for additional employment\\/increased hours?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_additionalemployment\\nLooking for additional employment\\/increased hours?\\n_objects\\n{\\n\\\"scope\\\":346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1444\"},\"time\":\"2016-11-02T19:36:55Z\"}}'),(489,'{\"_title\":\"HealthInsurance\",\"en\":\"Access to Health Care\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-case_card\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Health Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"HealthInsurance\\nAccess to Health Care\\nobject\\n1\\nicon-case_card\\n{\\n\\\"leaf\\\":true\\n}\\nHealth Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1563\"},\"time\":\"2016-11-14T15:25:16Z\"}}'),(490,'{\"_title\":\"_assessmentdate\",\"en\":\"Date Added\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nDate Added\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:03:59Z\",\"users\":{\"1\":\"466\"}}}'),(491,'{\"_title\":\"_insuranceType\",\"en\":\"Insurance Type\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 416\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insuranceType\\nInsurance Type\\n_objects\\n{\\n\\\"scope\\\": 416\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:05:05Z\",\"users\":{\"1\":\"467\"}}}'),(492,'{\"_title\":\"_isPrimary\",\"en\":\"Is Primary?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_isPrimary\\nIs Primary?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1454\"},\"time\":\"2016-11-02T19:39:54Z\"}}'),(493,'{\"_title\":\"_medscovered\",\"en\":\"Meds Covered?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_medscovered\\nMeds Covered?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1453\"},\"time\":\"2016-11-02T19:39:48Z\"}}'),(494,'{\"_title\":\"_dmecovered\",\"en\":\"Durable Medical Equipment (DME) covered?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_dmecovered\\nDurable Medical Equipment (DME) covered?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1456\"},\"time\":\"2016-11-02T19:40:12Z\"}}'),(495,'{\"_title\":\"_insurancestatus\",\"en\":\"Status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 501\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insurancestatus\\nStatus\\n_objects\\n{\\n\\\"scope\\\": 501\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"481\"},\"time\":\"2016-10-03T16:12:39Z\"}}'),(496,'{\"_title\":\"_insurancelostdisaster\",\"en\":\"Was this insurance lost as a result of the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insurancelostdisaster\\nWas this insurance lost as a result of the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1455\"},\"time\":\"2016-11-02T19:40:05Z\"}}'),(497,'{\"_title\":\"_whatcausedinsuranceloss\",\"en\":\"What caused the insurance coverage to be lost?\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_whatcausedinsuranceloss\\nWhat caused the insurance coverage to be lost?\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:08:52Z\",\"users\":{\"1\":\"473\"}}}'),(498,'{\"_title\":\"_startdate\",\"en\":\"Start Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_startdate\\nStart Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:09:06Z\",\"users\":{\"1\":\"474\"}}}'),(499,'{\"_title\":\"_enddate\",\"en\":\"End Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_enddate\\nEnd Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:09:19Z\",\"users\":{\"1\":\"475\"}}}'),(500,'{\"_title\":\"_appliedfordate\",\"en\":\"Applied For Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_appliedfordate\\nApplied For Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:09:34Z\",\"users\":{\"1\":\"476\"}}}'),(501,'{\"en\":\"InsuranceStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"InsuranceStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:11:50Z\",\"users\":{\"1\":\"477\"}}}'),(502,'{\"en\":\"Pending\\/Applied\"}','{\"wu\":[],\"solr\":{\"content\":\"Pending\\/Applied\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:12:04Z\",\"users\":{\"1\":\"478\"}}}'),(503,'{\"en\":\"Active\"}','{\"wu\":[],\"solr\":{\"content\":\"Active\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:12:12Z\",\"users\":{\"1\":\"479\"}}}'),(504,'{\"en\":\"Inactive\"}','{\"wu\":[],\"solr\":{\"content\":\"Inactive\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:12:19Z\",\"users\":{\"1\":\"480\"}}}'),(505,'{\"_title\":\"FoodAssessment\",\"en\":\"Food Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-food\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Food Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"FoodAssessment\\nFood Assessment\\nobject\\n1\\nicon-assessment-food\\n{\\n\\\"leaf\\\":true\\n}\\nFood Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1561\"},\"time\":\"2016-11-14T15:24:58Z\"}}'),(506,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1316\"},\"time\":\"2016-10-28T19:47:21Z\"}}'),(507,'{\"_title\":\"_enoughfood\",\"en\":\"Does client have enough food to feed all members of the household?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_enoughfood\\nDoes client have enough food to feed all members of the household?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1449\"},\"time\":\"2016-11-02T19:38:22Z\"}}'),(508,'{\"_title\":\"_predisasterassistance\",\"en\":\"Pre-Disaster, was client or any household member receiving food assistance?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 516\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_predisasterassistance\\nPre-Disaster, was client or any household member receiving food assistance?\\n_objects\\n{\\n\\\"scope\\\": 516\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1448\"},\"time\":\"2016-11-02T19:38:16Z\"}}'),(509,'{\"_title\":\"_requestedfood\",\"en\":\"Since the disaster, has client requested help with food from anyone?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_requestedfood\\nSince the disaster, has client requested help with food from anyone?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1447\"},\"time\":\"2016-11-02T19:38:01Z\"}}'),(510,'{\"_title\":\"BehavioralHealthAssessment\",\"en\":\"Behavioral Health Advocacy Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-behavioral\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Behavioral Health Advocacy Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"BehavioralHealthAssessment\\nBehavioral Health Advocacy Assessment\\nobject\\n1\\nicon-assessment-behavioral\\n{\\n\\\"leaf\\\":true\\n}\\nBehavioral Health Advocacy Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1554\"},\"time\":\"2016-11-14T15:23:32Z\"}}'),(511,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1311\"},\"time\":\"2016-10-28T19:46:20Z\"}}'),(512,'{\"_title\":\"_indistress\",\"en\":\"Is client or anyone in the household in distress?\",\"type\":\"_objects\",\"order\":2,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_indistress\\nIs client or anyone in the household in distress?\\n_objects\\n2\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1421\"},\"time\":\"2016-11-02T18:56:35Z\"}}'),(513,'{\"_title\":\"_liketospeak\",\"en\":\"Would client or anyone in the household like to speak to someone about coping with disaster-related stress?\",\"type\":\"_objects\",\"order\":3,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_liketospeak\\nWould client or anyone in the household like to speak to someone about coping with disaster-related stress?\\n_objects\\n3\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1419\"},\"time\":\"2016-11-02T18:56:15Z\"}}'),(514,'{\"_title\":\"_feelsafe\",\"en\":\"Do you feel safe at home?\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_feelsafe\\nDo you feel safe at home?\\n_objects\\n4\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1423\"},\"time\":\"2016-11-02T18:56:51Z\"}}'),(515,'{\"_title\":\"_hurtingyourselfothers\",\"en\":\"Have you felt like hurting yourself or others?\",\"type\":\"_objects\",\"order\":5,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_hurtingyourselfothers\\nHave you felt like hurting yourself or others?\\n_objects\\n5\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1422\"},\"time\":\"2016-11-02T18:56:43Z\"}}'),(516,'{\"en\":\"FoodHelp\"}','{\"wu\":[],\"solr\":{\"content\":\"FoodHelp\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:24:25Z\",\"users\":{\"1\":\"493\"}}}'),(517,'{\"en\":\"Woman Infants & Children (WIC) Benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Woman Infants & Children (WIC) Benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:24:50Z\",\"users\":{\"1\":\"494\"}}}'),(518,'{\"en\":\"Supplemental Nutrition Assistance Program (SNAP)\"}','{\"wu\":[],\"solr\":{\"content\":\"Supplemental Nutrition Assistance Program (SNAP)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:06Z\",\"users\":{\"1\":\"495\"}}}'),(519,'{\"en\":\"Assistance from local food pantries\\/food banks\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance from local food pantries\\/food banks\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:22Z\",\"users\":{\"1\":\"496\"}}}'),(520,'{\"en\":\"Meals on wheels\"}','{\"wu\":[],\"solr\":{\"content\":\"Meals on wheels\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:32Z\",\"users\":{\"1\":\"497\"}}}'),(521,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:41Z\",\"users\":{\"1\":\"498\"}}}'),(522,'{\"en\":\"CaseNoteType\"}','{\"wu\":[],\"solr\":{\"content\":\"CaseNoteType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:34:42Z\",\"users\":{\"1\":\"499\"}}}'),(523,'{\"en\":\"Education\"}','{\"wu\":[],\"solr\":{\"content\":\"Education\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:34:53Z\",\"users\":{\"1\":\"500\"}}}'),(524,'{\"en\":\"Employment\"}','{\"wu\":[],\"solr\":{\"content\":\"Employment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:35:01Z\",\"users\":{\"1\":\"501\"}}}'),(525,'{\"en\":\"Skills Building\"}','{\"wu\":[],\"solr\":{\"content\":\"Skills Building\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:35:12Z\",\"users\":{\"1\":\"502\"}}}'),(526,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:35:23Z\",\"users\":{\"1\":\"503\"}}}'),(527,'{\"_title\":\"CaseNote\",\"en\":\"Case Note\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-committee-phase\",\"cfg\":\"{\\n    \\\"acceptChildren\\\": false\\n    ,\\\"leaf\\\":true\\n}\",\"title_template\":\"Case Note\"}','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1555\"},\"time\":\"2016-11-14T15:23:55Z\"}}'),(528,'{\"_title\":\"_entrydate\",\"en\":\"Entry Date\",\"type\":\"datetime\",\"cfg\":\"{\\n\\\"value\\\": \\\"2016-10-24\\\"\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_entrydate\\nEntry Date\\ndatetime\\n{\\n\\\"value\\\": \\\"2016-10-24\\\"\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1272\"},\"time\":\"2016-10-24T14:23:31Z\"}}'),(529,'{\"_title\":\"_regarding\",\"en\":\"Regarding\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_regarding\\nRegarding\\nvarchar\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"513\"},\"time\":\"2016-10-03T16:54:37Z\"}}'),(530,'{\"_title\":\"_regarding\",\"en\":\"Regarding\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_regarding\\nRegarding\\nvarchar\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"741\"},\"time\":\"2016-10-18T16:16:46Z\"}}'),(531,'{\"_title\":\"_notetype\",\"en\":\"Note Type\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 522,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"notetype_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_notetype\\nNote Type\\n_objects\\n{\\n\\\"scope\\\": 522,\\n\\\"faceting\\\":true\\n}\\nnotetype_i\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1694\"},\"time\":\"2016-12-07T05:23:15Z\"}}'),(532,'{\"_title\":\"_casenote\",\"en\":\"Case Note\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_casenote\\nCase Note\\ntext\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"512\"},\"time\":\"2016-10-03T16:54:20Z\"}}'),(533,'{\"_title\":\"ChildAssesment\",\"en\":\"Children and Youth Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-child\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Children and Youth Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"ChildAssesment\\nChildren and Youth Assessment\\nobject\\n1\\nicon-assessment-child\\n{\\n\\\"leaf\\\":true\\n}\\nChildren and Youth Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1556\"},\"time\":\"2016-11-14T15:24:05Z\"}}'),(534,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1312\"},\"time\":\"2016-10-28T19:46:35Z\"}}'),(535,'{\"_title\":\"_childrenunder18\",\"en\":\"Do you have children under the age of 18 in your household?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childrenunder18\\nDo you have children under the age of 18 in your household?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:57:02Z\",\"users\":{\"1\":\"516\"}}}'),(536,'{\"_title\":\"_fostercare\",\"en\":\"Are any of the children in the household placements from Foster Care\",\"type\":\"_objects\"}','{\"wu\":[],\"solr\":{\"content\":\"_fostercare\\nAre any of the children in the household placements from Foster Care\\n_objects\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"991\"},\"time\":\"2016-10-21T14:00:50Z\"}}'),(537,'{\"_title\":\"_fostercare\",\"en\":\"Are any of the children in the household placements from Foster Care?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_fostercare\\nAre any of the children in the household placements from Foster Care?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1653\"},\"time\":\"2016-11-14T20:53:16Z\"}}'),(538,'{\"_title\":\"_headstart\",\"en\":\"Prior to the disaster, was the client''s child in a child care or Head Start Program?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_headstart\\nPrior to the disaster, was the client''s child in a child care or Head Start Program?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1513\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(539,'{\"_title\":\"_servicesdisrupted\",\"en\":\"If yes, were the services disrupted as a result of the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_servicesdisrupted\\nIf yes, were the services disrupted as a result of the disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1496\"},\"time\":\"2016-11-04T17:17:08Z\"}}'),(540,'{\"_title\":\"_childcareneed\",\"en\":\"Does client currently have a need for child care?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childcareneed\\nDoes client currently have a need for child care?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1514\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(541,'{\"_title\":\"_priorvoucher\",\"en\":\"Prior to the disaster, did client get voucher assistance for child care?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_priorvoucher\\nPrior to the disaster, did client get voucher assistance for child care?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1504\"},\"time\":\"2016-11-04T17:23:02Z\"}}'),(542,'{\"_title\":\"_barrierstochildcare\",\"en\":\"If child care is needed but child is not getting it, what are the barriers?\",\"type\":\"varchar\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_barrierstochildcare\\nIf child care is needed but child is not getting it, what are the barriers?\\nvarchar\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1663\"},\"time\":\"2016-11-15T14:23:50Z\"}}'),(543,'{\"_title\":\"_childsupportpre\",\"en\":\"Was client receiving child support payments before the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childsupportpre\\nWas client receiving child support payments before the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1626\"},\"time\":\"2016-11-14T20:40:49Z\"}}'),(544,'{\"_title\":\"_responsibleforchildsupoprt\",\"en\":\"Is the client the individual responsible for paying support?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_responsibleforchildsupoprt\\nIs the client the individual responsible for paying support?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1426\"},\"time\":\"2016-11-02T18:57:42Z\"}}'),(545,'{\"_title\":\"_paymentsdelayed\",\"en\":\"Have payments been delayed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_paymentsdelayed\\nHave payments been delayed?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1428\"},\"time\":\"2016-11-02T18:58:03Z\"}}'),(546,'{\"_title\":\"_childsupportpost\",\"en\":\"Is the client receiving child support payments post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childsupportpost\\nIs the client receiving child support payments post-disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1627\"},\"time\":\"2016-11-14T20:41:01Z\"}}'),(547,'{\"_title\":\"_kidsinschool\",\"en\":\"Are the client''s kids currently in school?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_kidsinschool\\nAre the client''s kids currently in school?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1515\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(548,'{\"_title\":\"_sameschoolpostdisaster\",\"en\":\"If client''s kids currently in school, are they in the same school district post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_sameschoolpostdisaster\\nIf client''s kids currently in school, are they in the same school district post-disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1500\"},\"time\":\"2016-11-04T17:18:54Z\"}}'),(549,'{\"_title\":\"_needhelpregistering\",\"en\":\"If client''s kids not currently in school, does client need help registering their children for school?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_needhelpregistering\\nIf client''s kids not currently in school, does client need help registering their children for school?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1499\"},\"time\":\"2016-11-04T17:18:44Z\"}}'),(550,'{\"_title\":\"_missedimmunizations\",\"en\":\"Since the disaster, has your child missed any scheduled check ups or immunizations?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_missedimmunizations\\nSince the disaster, has your child missed any scheduled check ups or immunizations?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1516\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(551,'{\"_title\":\"_copingconcerns\",\"en\":\"Does client have concerns about how his\\/her child is coping post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_copingconcerns\\nDoes client have concerns about how his\\/her child is coping post-disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1517\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(552,'{\"_title\":\"_copingexplanations\",\"en\":\"If yes, please explain in detail\",\"type\":\"text\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_copingexplanations\\nIf yes, please explain in detail\\ntext\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1493\"},\"time\":\"2016-11-04T17:15:24Z\"}}'),(553,'{\"_title\":\"ClothingAssessment\",\"en\":\"Clothing Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-clothing\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Clothing Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"ClothingAssessment\\nClothing Assessment\\nobject\\n1\\nicon-assessment-clothing\\n{\\n\\\"leaf\\\":true\\n}\\nClothing Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1557\"},\"time\":\"2016-11-14T15:24:21Z\"}}'),(554,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1313\"},\"time\":\"2016-10-28T19:46:46Z\"}}'),(555,'{\"_title\":\"_anyoneloseclothing\",\"en\":\"Did any of the household members lose clothing as a result of the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_anyoneloseclothing\\nDid any of the household members lose clothing as a result of the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1443\"},\"time\":\"2016-11-02T19:36:37Z\"}}'),(556,'{\"_title\":\"_usableclothing\",\"en\":\"Does client\\/family have useable clothing and shoes for work or school?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_usableclothing\\nDoes client\\/family have useable clothing and shoes for work or school?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1440\"},\"time\":\"2016-11-02T19:36:08Z\"}}'),(557,'{\"_title\":\"_coldweather\",\"en\":\"Does client\\/family have cold-weather clothing (e.g.,coats, hats, gloves)?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_coldweather\\nDoes client\\/family have cold-weather clothing (e.g.,coats, hats, gloves)?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1442\"},\"time\":\"2016-11-02T19:36:30Z\"}}'),(558,'{\"_title\":\"_makeclaim\",\"en\":\"Did client claim for the clothes with the insurance company?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_makeclaim\\nDid client claim for the clothes with the insurance company?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1473\"},\"time\":\"2016-11-04T13:21:45Z\"}}'),(559,'{\"_title\":\"FurnitureAndAppliancesAssessment\",\"en\":\"Furniture and Appliances Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-appliances\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Furniture and Appliances Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"FurnitureAndAppliancesAssessment\\nFurniture and Appliances Assessment\\nobject\\n1\\nicon-assessment-appliances\\n{\\n\\\"leaf\\\":true\\n}\\nFurniture and Appliances Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1562\"},\"time\":\"2016-11-14T15:25:06Z\"}}'),(560,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1317\"},\"time\":\"2016-10-28T19:47:31Z\"}}'),(561,'{\"_title\":\"_anythingdestroyed\",\"en\":\"Did client have furniture or home appliances destroyed in the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_anythingdestroyed\\nDid client have furniture or home appliances destroyed in the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1451\"},\"time\":\"2016-11-02T19:38:57Z\"}}'),(562,'{\"_title\":\"_refrigerator\",\"en\":\"Refrigerator\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_refrigerator\\nRefrigerator\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1527\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(563,'{\"_title\":\"_stove\",\"en\":\"Stove\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_stove\\nStove\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1528\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(564,'{\"_title\":\"_beds\",\"en\":\"Bed(s)\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_beds\\nBed(s)\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1529\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(565,'{\"_title\":\"_numberofbeds\",\"en\":\"If bed(s) destroyed, specify number of bed(s)\",\"type\":\"int\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_numberofbeds\\nIf bed(s) destroyed, specify number of bed(s)\\nint\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1524\"},\"time\":\"2016-11-04T17:31:30Z\"}}'),(566,'{\"_title\":\"_numberofbeds\",\"en\":\"If bed(s) destroyed, specify number of bed(s)\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_numberofbeds\\nIf bed(s) destroyed, specify number of bed(s)\\nint\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1010\"},\"time\":\"2016-10-21T14:38:10Z\"}}'),(567,'{\"_title\":\"_claimforfurniture\",\"en\":\"Did client have a claim for the furniture and appliance with your insurance?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_claimforfurniture\\nDid client have a claim for the furniture and appliance with your insurance?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1530\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(568,'{\"_title\":\"_replacementitemsreceived\",\"en\":\"Did client get replacement items from any nonprofit organizations?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_replacementitemsreceived\\nDid client get replacement items from any nonprofit organizations?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1531\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(569,'{\"_title\":\"_abletoinstall\",\"en\":\"Was client able to install replacement furniture and appliances in the home?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_abletoinstall\\nWas client able to install replacement furniture and appliances in the home?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1532\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(570,'{\"en\":\"ReferralService\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"ReferralService\\n1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:30:29Z\",\"users\":{\"1\":\"552\"}}}'),(571,'{\"en\":\"Assistance identifying private legal counsel\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance identifying private legal counsel\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:32:25Z\",\"users\":{\"1\":\"553\"}}}'),(572,'{\"en\":\"Assistance with D-Snap application\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with D-Snap application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:32:38Z\",\"users\":{\"1\":\"554\"}}}'),(573,'{\"en\":\"Assistance with insurance claim\\/appeal\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with insurance claim\\/appeal\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:32:52Z\",\"users\":{\"1\":\"555\"}}}'),(574,'{\"en\":\"Bus Tokens\"}','{\"wu\":[],\"solr\":{\"content\":\"Bus Tokens\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:02Z\",\"users\":{\"1\":\"556\"}}}'),(575,'{\"en\":\"Counseling-Alcohol\"}','{\"wu\":[],\"solr\":{\"content\":\"Counseling-Alcohol\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:19Z\",\"users\":{\"1\":\"557\"}}}'),(576,'{\"en\":\"Emergency Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:44Z\",\"users\":{\"1\":\"558\"}}}'),(577,'{\"en\":\"Laundry Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Laundry Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:58Z\",\"users\":{\"1\":\"559\"}}}'),(578,'{\"en\":\"Referral to community organizations for food needs\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to community organizations for food needs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:13Z\",\"users\":{\"1\":\"560\"}}}'),(579,'{\"en\":\"Referral to faith-based\\/community organizations for clothing\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to faith-based\\/community organizations for clothing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:29Z\",\"users\":{\"1\":\"561\"}}}'),(580,'{\"en\":\"Rental Assitance\"}','{\"wu\":[],\"solr\":{\"content\":\"Rental Assitance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:40Z\",\"users\":{\"1\":\"562\"}}}'),(581,'{\"en\":\"Social Services for WIC\\/SNAP\"}','{\"wu\":[],\"solr\":{\"content\":\"Social Services for WIC\\/SNAP\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:51Z\",\"users\":{\"1\":\"563\"}}}'),(582,'{\"en\":\"Assistance with accessing VA benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with accessing VA benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:36:49Z\",\"users\":{\"1\":\"564\"}}}'),(583,'{\"en\":\"Assistance with FEMA ONA\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with FEMA ONA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:00Z\",\"users\":{\"1\":\"565\"}}}'),(584,'{\"en\":\"Bus Pass\"}','{\"wu\":[],\"solr\":{\"content\":\"Bus Pass\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:07Z\",\"users\":{\"1\":\"566\"}}}'),(585,'{\"en\":\"Case Management\"}','{\"wu\":[],\"solr\":{\"content\":\"Case Management\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:16Z\",\"users\":{\"1\":\"567\"}}}'),(586,'{\"en\":\"Disaster Case Management\"}','{\"wu\":[],\"solr\":{\"content\":\"Disaster Case Management\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:30Z\",\"users\":{\"1\":\"568\"}}}'),(587,'{\"en\":\"Healthcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Healthcare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:41Z\",\"users\":{\"1\":\"569\"}}}'),(588,'{\"en\":\"Prenatal Care\"}','{\"wu\":[],\"solr\":{\"content\":\"Prenatal Care\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:50Z\",\"users\":{\"1\":\"570\"}}}'),(589,'{\"en\":\"Referral to faith-based\\/community organizations for replacement\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to faith-based\\/community organizations for replacement\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:38:10Z\",\"users\":{\"1\":\"571\"}}}'),(590,'{\"en\":\"Referral to mass care for immediate food needs\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to mass care for immediate food needs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:38:40Z\",\"users\":{\"1\":\"572\"}}}'),(591,'{\"en\":\"Restoration of pre-disaster Meals on Wheels services\"}','{\"wu\":[],\"solr\":{\"content\":\"Restoration of pre-disaster Meals on Wheels services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:38:54Z\",\"users\":{\"1\":\"573\"}}}'),(592,'{\"en\":\"Transportation\"}','{\"wu\":[],\"solr\":{\"content\":\"Transportation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:39:02Z\",\"users\":{\"1\":\"574\"}}}'),(593,'{\"en\":\"ReferralStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"ReferralStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:39:27Z\",\"users\":{\"1\":\"575\"}}}'),(594,'{\"en\":\"Referral Made\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral Made\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"579\"},\"time\":\"2016-10-03T18:40:33Z\"}}'),(595,'{\"en\":\"Not Eligible\"}','{\"wu\":[],\"solr\":{\"content\":\"Not Eligible\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:40:08Z\",\"users\":{\"1\":\"577\"}}}'),(596,'{\"en\":\"Resources Not Available\"}','{\"wu\":[],\"solr\":{\"content\":\"Resources Not Available\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:40:20Z\",\"users\":{\"1\":\"578\"}}}'),(597,'{\"en\":\"ReferralResult\"}','{\"wu\":[],\"solr\":{\"content\":\"ReferralResult\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:02Z\",\"users\":{\"1\":\"580\"}}}'),(598,'{\"en\":\"ServiceProvided\"}','{\"wu\":[],\"solr\":{\"content\":\"ServiceProvided\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:18Z\",\"users\":{\"1\":\"581\"}}}'),(599,'{\"en\":\"Information Only\"}','{\"wu\":[],\"solr\":{\"content\":\"Information Only\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:26Z\",\"users\":{\"1\":\"582\"}}}'),(600,'{\"en\":\"Rejected\"}','{\"wu\":[],\"solr\":{\"content\":\"Rejected\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:34Z\",\"users\":{\"1\":\"583\"}}}'),(601,'{\"en\":\"No Show\"}','{\"wu\":[],\"solr\":{\"content\":\"No Show\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:43Z\",\"users\":{\"1\":\"584\"}}}'),(602,'{\"en\":\"UnitOfMeasure\"}','{\"wu\":[],\"solr\":{\"content\":\"UnitOfMeasure\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:48:39Z\",\"users\":{\"1\":\"585\"}}}'),(603,'{\"en\":\"Dollars\"}','{\"wu\":[],\"solr\":{\"content\":\"Dollars\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:48:57Z\",\"users\":{\"1\":\"586\"}}}'),(604,'{\"en\":\"Minutes\"}','{\"wu\":[],\"solr\":{\"content\":\"Minutes\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:49:07Z\",\"users\":{\"1\":\"587\"}}}'),(605,'{\"en\":\"Count\"}','{\"wu\":[],\"solr\":{\"content\":\"Count\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:49:14Z\",\"users\":{\"1\":\"588\"}}}'),(606,'{\"en\":\"Hours\"}','{\"wu\":[],\"solr\":{\"content\":\"Hours\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:49:21Z\",\"users\":{\"1\":\"589\"}}}'),(607,'{\"_title\":\"Referral\",\"en\":\"Referral\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-arrow-right-medium\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Referral\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral\\nReferral\\nobject\\n1\\nicon-arrow-right-medium\\n{\\n\\\"leaf\\\":true\\n}\\nReferral\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1567\"},\"time\":\"2016-11-14T15:25:51Z\"}}'),(608,'{\"_title\":\"_referraldate\",\"en\":\"Referral Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_referraldate\\nReferral Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:50:22Z\",\"users\":{\"1\":\"591\"}}}'),(609,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":570\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"scope\\\":570\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"619\"},\"time\":\"2016-10-03T19:13:00Z\"}}'),(610,'{\"_title\":\"_provider\",\"en\":\"Refer to Provider\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_provider\\nRefer to Provider\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:51:40Z\",\"users\":{\"1\":\"593\"}}}'),(611,'{\"_title\":\"_provider\",\"en\":\"Refer to Provider\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_provider\\nRefer to Provider\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:52:15Z\",\"users\":{\"1\":\"594\"}}}'),(612,'{\"_title\":\"_streetaddress\",\"en\":\"Street Address\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_streetaddress\\nStreet Address\\nvarchar\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"596\"},\"time\":\"2016-10-03T18:52:47Z\"}}'),(613,'{\"_title\":\"_zipcode\",\"en\":\"Zip Code\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_zipcode\\nZip Code\\nint\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:53:04Z\",\"users\":{\"1\":\"597\"}}}'),(614,'{\"_title\":\"_city\",\"en\":\"City\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_city\\nCity\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:53:13Z\",\"users\":{\"1\":\"598\"}}}'),(615,'{\"_title\":\"_state\",\"en\":\"State\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_state\\nState\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:53:37Z\",\"users\":{\"1\":\"599\"}}}'),(616,'{\"_title\":\"_geocode\",\"en\":\"Geopoint\",\"type\":\"geoPoint\"}','{\"wu\":[],\"solr\":{\"content\":\"_geocode\\nGeopoint\\ngeoPoint\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:53:53Z\",\"users\":{\"1\":\"600\"}}}'),(617,'{\"_title\":\"_referralstatus\",\"en\":\"Status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":593\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralstatus\\nStatus\\n_objects\\n{\\n\\\"scope\\\":593\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"620\"},\"time\":\"2016-10-03T19:13:16Z\"}}'),(618,'{\"_title\":\"_comments\",\"en\":\"Comments\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_comments\\nComments\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:54:58Z\",\"users\":{\"1\":\"602\"}}}'),(619,'{\"_title\":\"_associatedneed\",\"en\":\"Associated Need\\/Barrier\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_associatedneed\\nAssociated Need\\/Barrier\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:55:23Z\",\"users\":{\"1\":\"603\"}}}'),(620,'{\"_title\":\"_voucherinformation\",\"en\":\"Voucher Information - Please complete the following information if your organization has authorized a voucher for this service\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_voucherinformation\\nVoucher Information - Please complete the following information if your organization has authorized a voucher for this service\\nH\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:59:04Z\",\"users\":{\"1\":\"604\"}}}'),(621,'{\"_title\":\"_vouchernumber\",\"en\":\"Voucher Number\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_vouchernumber\\nVoucher Number\\nint\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:59:25Z\",\"users\":{\"1\":\"605\"}}}'),(622,'{\"_title\":\"_voucheruom\",\"en\":\"Units of Measure\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":602\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_voucheruom\\nUnits of Measure\\n_objects\\n{\\n\\\"scope\\\":602\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"621\"},\"time\":\"2016-10-03T19:13:42Z\"}}'),(623,'{\"_title\":\"_voucherunits\",\"en\":\"Units\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_voucherunits\\nUnits\\nint\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:02:32Z\",\"users\":{\"1\":\"607\"}}}'),(624,'{\"_title\":\"_unitvalue\",\"en\":\"Unit Value ($)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_unitvalue\\nUnit Value ($)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:02:52Z\",\"users\":{\"1\":\"608\"}}}'),(625,'{\"_title\":\"_vouchertotal\",\"en\":\"Total($)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_vouchertotal\\nTotal($)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:03:27Z\",\"users\":{\"1\":\"609\"}}}'),(626,'{\"_title\":\"_informationrelease\",\"en\":\"Information release - if the client has authorized that his\\/her information can be released to the provider, please indicate this below.  Doing so will cause an email to be automatically generated and sent to this provider with information regarding the referral\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_informationrelease\\nInformation release - if the client has authorized that his\\/her information can be released to the provider, please indicate this below.  Doing so will cause an email to be automatically generated and sent to this provider with information regarding the referral\\nH\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:05:33Z\",\"users\":{\"1\":\"610\"}}}'),(627,'{\"_title\":\"_emailauthorized\",\"en\":\"Email Authorized\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_emailauthorized\\nEmail Authorized\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:05:53Z\",\"users\":{\"1\":\"611\"}}}'),(628,'{\"_title\":\"_referraloutcome\",\"en\":\"Referral Outcome - Enter the date acknowledged by the referral recipient, appointment date and time, result date, and result.\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_referraloutcome\\nReferral Outcome - Enter the date acknowledged by the referral recipient, appointment date and time, result date, and result.\\nH\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:06:59Z\",\"users\":{\"1\":\"612\"}}}'),(629,'{\"_title\":\"_dateacknowledged\",\"en\":\"Date Acknowledged\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_dateacknowledged\\nDate Acknowledged\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:07:22Z\",\"users\":{\"1\":\"613\"}}}'),(630,'{\"_title\":\"_appointmentdate\",\"en\":\"Appointment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_appointmentdate\\nAppointment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:07:37Z\",\"users\":{\"1\":\"614\"}}}'),(631,'{\"_title\":\"_appointmentdate\",\"en\":\"Appointment Date\\/Time\",\"type\":\"datetime\"}','{\"wu\":[],\"solr\":{\"content\":\"_appointmentdate\\nAppointment Date\\/Time\\ndatetime\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:07:50Z\",\"users\":{\"1\":\"615\"}}}'),(632,'{\"_title\":\"_resultdate\",\"en\":\"Result Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_resultdate\\nResult Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:08:06Z\",\"users\":{\"1\":\"616\"}}}'),(633,'{\"_title\":\"_result\",\"en\":\"Result\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":597\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_result\\nResult\\n_objects\\n{\\n\\\"scope\\\":597\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"618\"},\"time\":\"2016-10-03T19:12:37Z\"}}'),(634,'{\"_title\":\"_fematier\",\"en\":\"FEMA Tier\",\"type\":\"_objects\",\"order\":15,\"cfg\":\"{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\":137,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"fema_tier_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_fematier\\nFEMA Tier\\n_objects\\n15\\n{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\":137,\\n\\\"faceting\\\":true\\n}\\nfema_tier_i\\n\",\"order\":15},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1672\"},\"time\":\"2016-12-06T17:08:47Z\"}}'),(635,'{\"en\":\"Tier 1: Immediate Needs Met\"}','{\"wu\":[],\"solr\":{\"content\":\"Tier 1: Immediate Needs Met\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:18:21Z\",\"users\":{\"1\":\"628\"}}}'),(636,'{\"en\":\"Tier 2: Some Remaining Unmet Needs or in Current Rebuild\\/Repair Status\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Tier 2: Some Remaining Unmet Needs or in Current Rebuild\\/Repair Status\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"630\"},\"time\":\"2016-10-03T19:18:53Z\"}}'),(642,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1763\"},\"time\":\"2016-12-08T17:48:12Z\"}}'),(643,'{\"_title\":\"_clientstatus\",\"en\":\"Client Status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\": 644,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"client_status_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientstatus\\nClient Status\\n_objects\\n{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\": 644,\\n\\\"faceting\\\":true\\n}\\nclient_status_i\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1671\"},\"time\":\"2016-12-06T17:08:43Z\"}}'),(644,'{\"en\":\"ClientStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"ClientStatus\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1670\"},\"time\":\"2016-12-06T17:07:20Z\"}}'),(645,'{\"en\":\"Open\"}','{\"wu\":[],\"solr\":{\"content\":\"Open\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-04T02:13:28Z\",\"users\":{\"1\":\"656\"}}}'),(646,'{\"en\":\"Closed\"}','{\"wu\":[],\"solr\":{\"content\":\"Closed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-04T02:13:33Z\",\"users\":{\"1\":\"657\"}}}'),(651,'{\"_title\":\"SeniorServicesAssessment\",\"en\":\"Senior Services Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-assessment-senior-services\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Senior Services Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"SeniorServicesAssessment\\nSenior Services Assessment\\nobject\\n1\\nicon-assessment-senior-services\\n{\\n\\\"leaf\\\":true\\n}\\nSenior Services Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1568\"},\"time\":\"2016-11-14T15:26:00Z\"}}'),(652,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1321\"},\"time\":\"2016-10-28T19:48:18Z\"}}'),(653,'{\"_title\":\"_priorseniorliving\",\"en\":\"Prior to the disaster, was anyone in the household living in senior housing, assisted living, or in a nursing home?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_priorseniorliving\\nPrior to the disaster, was anyone in the household living in senior housing, assisted living, or in a nursing home?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1459\"},\"time\":\"2016-11-02T19:41:54Z\"}}'),(654,'{\"_title\":\"_clientdisplaced\",\"en\":\"If yes, was the client displaced following the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientdisplaced\\nIf yes, was the client displaced following the disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1477\"},\"time\":\"2016-11-04T13:26:19Z\"}}'),(655,'{\"_title\":\"_explaincircumstances\",\"en\":\"If yes, please explain the circumstances\",\"type\":\"varchar\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_explaincircumstances\\nIf yes, please explain the circumstances\\nvarchar\\n{\\n   \\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1478\"},\"time\":\"2016-11-04T13:26:37Z\"}}'),(656,'{\"_title\":\"LanguageAssessment\",\"en\":\"Language Assessment\",\"iconCls\":\"icon-assessment-language\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Language Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"LanguageAssessment\\nLanguage Assessment\\nicon-assessment-language\\n{\\n\\\"leaf\\\":true\\n}\\nLanguage Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1565\"},\"time\":\"2016-11-14T15:25:32Z\"}}'),(657,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1319\"},\"time\":\"2016-10-28T19:48:00Z\"}}'),(658,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"683\"},\"time\":\"2016-10-09T00:13:04Z\"}}'),(659,'{\"_title\":\"_priorlanguage\",\"en\":\"Pre-Disaster, was client receiving language services?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_priorlanguage\\nPre-Disaster, was client receiving language services?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"684\"},\"time\":\"2016-10-09T00:13:22Z\"}}'),(660,'{\"_title\":\"_currentlyhavinglanguage\",\"en\":\"Is client currently having difficulty accessing services due to language concerns?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_currentlyhavinglanguage\\nIs client currently having difficulty accessing services due to language concerns?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1458\"},\"time\":\"2016-11-02T19:41:16Z\"}}'),(661,'{\"_title\":\"_lostlanguageservices\",\"en\":\"As a result of the disaster, client lost language services?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_lostlanguageservices\\nAs a result of the disaster, client lost language services?\\n_objects\\n{\\n\\\"scope\\\":346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1457\"},\"time\":\"2016-11-02T19:40:55Z\"}}'),(663,'{\"_title\":\"dc_cases_fema\",\"value\":\"{\\n\\\"nid\\\":[]\\n,\\\"name\\\":[]\\n,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"fema_tier_i\\\"}\\n,\\\"order\\\":{\\n\\\"solr_column_name\\\":\\\"task_order\\\"\\n,\\\"sortType\\\":\\\"asInt\\\"\\n,\\\"align\\\":\\\"center\\\"\\n,\\\"columnWidth\\\":\\\"10\\\"\\n}\\n,\\\"time_estimated\\\":{\\n\\\"width\\\":\\\"20px\\\"\\n,\\\"format\\\":\\\"H:i\\\"\\n}\\n,\\\"phase\\\": {\\n\\\"solr_column_name\\\": \\\"task_phase\\\"\\n}\\n,\\\"project\\\": {\\n\\\"solr_column_name\\\": \\\"task_projects\\\"\\n}\\n,\\\"cid\\\":[]\\n,\\\"assigned\\\":[]\\n,\\\"comment_user_id\\\":[]\\n,\\\"comment_date\\\":[]\\n,\\\"cdate\\\":[]\\n}\\n\\n\"}','{\"wu\":[],\"solr\":{\"content\":\"dc_cases_fema\\n{\\n\\\"nid\\\":[]\\n,\\\"name\\\":[]\\n,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"fema_tier_i\\\"}\\n,\\\"order\\\":{\\n\\\"solr_column_name\\\":\\\"task_order\\\"\\n,\\\"sortType\\\":\\\"asInt\\\"\\n,\\\"align\\\":\\\"center\\\"\\n,\\\"columnWidth\\\":\\\"10\\\"\\n}\\n,\\\"time_estimated\\\":{\\n\\\"width\\\":\\\"20px\\\"\\n,\\\"format\\\":\\\"H:i\\\"\\n}\\n,\\\"phase\\\": {\\n\\\"solr_column_name\\\": \\\"task_phase\\\"\\n}\\n,\\\"project\\\": {\\n\\\"solr_column_name\\\": \\\"task_projects\\\"\\n}\\n,\\\"cid\\\":[]\\n,\\\"assigned\\\":[]\\n,\\\"comment_user_id\\\":[]\\n,\\\"comment_date\\\":[]\\n,\\\"cdate\\\":[]\\n}\\n\\n\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-09T21:01:34Z\",\"users\":{\"1\":\"688\"}}}'),(665,'{\"_title\":\"Will Goes to Hollywood\",\"due_date\":\"2016-10-17T00:00:00Z\",\"due_time\":\"08:15:00\",\"assigned\":\"6\",\"importance\":54,\"description\":\"Hey, can you do this test item?\",\"sys_data\":[]}','{\"task_due_date\":\"2016-10-17T00:00:00Z\",\"task_due_time\":\"08:15:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[6],\"task_status\":2,\"wu\":[1,6],\"solr\":{\"content\":\"Will Goes to Hollywood\\n2016-10-17T00:00:00Z\\n08:15:00\\n6\\n54\\nHey, can you do this test item?\\n\",\"\":54,\"task_status\":2,\"task_u_assignee\":[6],\"task_u_all\":[6,\"1\"],\"task_u_ongoing\":[6],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"718\"},\"time\":\"2016-10-17T19:28:27Z\"}}'),(666,'{\"_title\":\"FEMA Tier 1\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Tier 1\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1756\"},\"time\":\"2016-12-08T17:47:44Z\"}}'),(667,'{\"_title\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"Test\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1765\"},\"time\":\"2016-12-08T17:48:20Z\"}}'),(668,'{\"_title\":\"Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Services\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"997\"},\"time\":\"2016-10-21T14:17:09Z\"}}'),(669,'{\"_title\":\"Service\",\"en\":\"Service\",\"type\":\"object\",\"iconCls\":\"icon-case_card\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"{_name}\"}','{\"wu\":[],\"solr\":{\"content\":\"Service\\nService\\nobject\\nicon-case_card\\n{\\n\\\"leaf\\\":true\\n}\\n{_name}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1569\"},\"time\":\"2016-11-14T15:26:10Z\"}}'),(670,'{\"_title\":\"_name\",\"en\":\"Name\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_name\\nName\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-14T03:59:37Z\",\"users\":{\"1\":\"711\"}}}'),(671,'{\"_title\":\"_address\",\"en\":\"Address\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_address\\nAddress\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-14T03:59:53Z\",\"users\":{\"1\":\"712\"}}}'),(672,'{\"_title\":\"_notes\",\"en\":\"Notes\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_notes\\nNotes\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-14T04:00:19Z\",\"users\":{\"1\":\"713\"}}}'),(674,'{\"_title\":\"Backup\"}','{\"wu\":[],\"solr\":{\"content\":\"Backup\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1753\"},\"time\":\"2016-12-08T17:47:34Z\"}}'),(678,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"768\"},\"time\":\"2016-10-18T17:49:28Z\"}}'),(679,'{\"_title\":\"Test2\"}','{\"wu\":[],\"solr\":{\"content\":\"Test2\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"767\"},\"time\":\"2016-10-18T17:49:26Z\"}}'),(680,'{\"_title\":\"Sup\"}','{\"wu\":[],\"solr\":{\"content\":\"Sup\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"6\":\"1196\"},\"time\":\"2016-10-21T16:23:15Z\"}}'),(681,'{\"_title\":\"Will Test\",\"due_date\":\"2016-10-17T00:00:00Z\",\"due_time\":\"01:45:00\",\"assigned\":\"6\",\"importance\":56,\"description\":\"Dksljaf;lkdjsaf\",\"sys_data\":[]}','{\"task_due_date\":\"2016-10-17T00:00:00Z\",\"task_due_time\":\"01:45:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[6],\"task_status\":1,\"wu\":[1,6],\"solr\":{\"content\":\"Will Test\\n2016-10-17T00:00:00Z\\n01:45:00\\n6\\n56\\nDksljaf;lkdjsaf\\n\",\"\":56,\"task_status\":1,\"task_u_assignee\":[6],\"task_u_all\":[6,\"1\"],\"task_u_ongoing\":[6],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"836\"},\"time\":\"2016-10-20T16:03:33Z\"}}'),(683,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1166\"},\"time\":\"2016-10-21T15:51:40Z\"}}'),(684,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1081\"},\"time\":\"2016-10-21T15:20:05Z\"}}'),(685,'{\"en\":\"YesNo\",\"visible\":\"Generic-1\"}','{\"wu\":[],\"solr\":{\"content\":\"YesNo\\nGeneric-1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-18T13:46:08Z\",\"users\":{\"1\":\"733\"}}}'),(686,'{\"en\":\"Yes\"}','{\"wu\":[],\"solr\":{\"content\":\"Yes\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-18T13:46:22Z\",\"users\":{\"1\":\"734\"}}}'),(687,'{\"en\":\"No\"}','{\"wu\":[],\"solr\":{\"content\":\"No\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-18T13:46:29Z\",\"users\":{\"1\":\"735\"}}}'),(703,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"757\"},\"time\":\"2016-10-18T16:42:52Z\"}}'),(704,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1761\"},\"time\":\"2016-12-08T17:48:03Z\"}}'),(706,'{\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"54\\n\",\"\":54,\"task_status\":2,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"900\"},\"time\":\"2016-10-21T00:37:42Z\"}}'),(708,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"521728\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"770\"},\"time\":\"2016-10-18T17:54:33Z\"}}'),(713,'{\"_title\":\"Will\",\"due_date\":\"2016-10-18T00:00:00Z\",\"due_time\":\"00:45:00\",\"assigned\":\"1,8,3,5,7,6\",\"importance\":54,\"description\":\"Test\",\"sys_data\":[]}','{\"task_due_date\":\"2016-10-18T00:00:00Z\",\"task_due_time\":\"00:45:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[1,8,3,5,7,6],\"task_status\":1,\"wu\":{\"0\":1,\"2\":8,\"3\":3,\"4\":5,\"5\":7,\"6\":6},\"solr\":{\"content\":\"Will\\n2016-10-18T00:00:00Z\\n00:45:00\\n1,8,3,5,7,6\\n54\\nTest\\n\",\"\":54,\"task_status\":1,\"task_u_assignee\":[1,8,3,5,7,6],\"task_u_all\":[1,8,3,5,7,6],\"task_u_ongoing\":[1,8,3,5,7,6],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"899\"},\"time\":\"2016-10-21T00:37:42Z\"}}'),(718,'{\"_title\":\"_name\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"_name\\nName\\nvarchar\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"970\"},\"time\":\"2016-10-21T12:56:47Z\"}}'),(721,'{\"_title\":\"Test Task\",\"due_date\":\"2016-10-20T00:00:00Z\",\"due_time\":\"01:15:00\",\"assigned\":\"3\",\"importance\":56,\"description\":\"Testdsafdsadsafdsafdsagdsagdsag\",\"sys_data\":[]}','{\"task_due_date\":\"2016-10-20T00:00:00Z\",\"task_due_time\":\"01:15:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[3],\"task_status\":1,\"wu\":[1,3,5,8],\"solr\":{\"content\":\"Test Task\\n2016-10-20T00:00:00Z\\n01:15:00\\n3\\n56\\nTestdsafdsadsafdsafdsagdsagdsag\\n\",\"\":56,\"task_status\":1,\"task_u_assignee\":[3],\"task_u_all\":[3,\"1\"],\"task_u_ongoing\":[3],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"901\"},\"time\":\"2016-10-21T00:37:42Z\"}}'),(722,'{\"_title\":\"_latlon\",\"en\":\"Latitude\\/Longitude\",\"type\":\"geoPoint\",\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"latlon_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_latlon\\nLatitude\\/Longitude\\ngeoPoint\\n{\\n\\\"faceting\\\":true\\n}\\nlatlon_s\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"891\"},\"time\":\"2016-10-20T22:17:20Z\"}}'),(732,'{\"_title\":\"dsafdsaf\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[3],\"solr\":{\"content\":\"dsafdsaf\\n54\\n\",\"\":54,\"task_status\":2,\"task_u_all\":[\"3\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-21T00:36:55Z\",\"users\":{\"3\":\"897\"}}}'),(733,'{\"_title\":\"test\",\"due_date\":\"2016-10-20T00:00:00Z\",\"assigned\":\"3\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":\"2016-10-20T00:00:00Z\",\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[3],\"task_status\":1,\"wu\":[1,3],\"solr\":{\"content\":\"test\\n2016-10-20T00:00:00Z\\n3\\n54\\n\",\"\":54,\"task_status\":1,\"task_u_assignee\":[3],\"task_u_all\":[3,\"1\"],\"task_u_ongoing\":[3],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-21T00:38:18Z\",\"users\":{\"1\":\"904\"}}}'),(845,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n6\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1165\"},\"time\":\"2016-10-21T15:51:31Z\"}}'),(846,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n7\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1128\"},\"time\":\"2016-10-21T15:42:12Z\"}}'),(847,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1130\"},\"time\":\"2016-10-21T15:42:49Z\"}}'),(848,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1178\"},\"time\":\"2016-10-21T16:08:10Z\"}}'),(849,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1180\"},\"time\":\"2016-10-21T16:09:08Z\"}}'),(850,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1190\"},\"time\":\"2016-10-21T16:12:46Z\"}}'),(851,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1135\"},\"time\":\"2016-10-21T15:44:56Z\"}}'),(852,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1144\"},\"time\":\"2016-10-21T15:46:57Z\"}}'),(853,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1183\"},\"time\":\"2016-10-21T16:10:14Z\"}}'),(854,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1192\"},\"time\":\"2016-10-21T16:13:08Z\"}}'),(855,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1185\"},\"time\":\"2016-10-21T16:11:06Z\"}}'),(856,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1172\"},\"time\":\"2016-10-21T16:05:15Z\"}}'),(857,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1188\"},\"time\":\"2016-10-21T16:11:51Z\"}}'),(858,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1148\"},\"time\":\"2016-10-21T15:48:02Z\"}}'),(859,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1179\"},\"time\":\"2016-10-21T16:08:23Z\"}}'),(860,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1181\"},\"time\":\"2016-10-21T16:09:19Z\"}}'),(861,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1191\"},\"time\":\"2016-10-21T16:12:59Z\"}}'),(862,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1154\"},\"time\":\"2016-10-21T15:49:41Z\"}}'),(863,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": false\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": false\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1184\"},\"time\":\"2016-10-21T16:10:31Z\"}}'),(864,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1193\"},\"time\":\"2016-10-21T16:13:18Z\"}}'),(865,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1186\"},\"time\":\"2016-10-21T16:11:22Z\"}}'),(866,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1173\"},\"time\":\"2016-10-21T16:05:48Z\"}}'),(867,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1189\"},\"time\":\"2016-10-21T16:12:04Z\"}}'),(870,'{\"_title\":\"TestReferral\",\"en\":\"TestReferral\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"TestReferral\\nTestReferral\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1140\"},\"time\":\"2016-10-21T15:45:54Z\"}}'),(879,'{\"_title\":\"Test\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[10],\"solr\":{\"content\":\"Test\\n54\\n\",\"\":54,\"task_status\":2,\"task_u_all\":[\"10\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-24T13:46:45Z\",\"users\":{\"10\":\"1258\"}}}'),(896,'{\"_title\":\"Test Task\",\"due_date\":\"2016-10-26T00:00:00Z\",\"due_time\":\"03:00:00\",\"assigned\":\"10\",\"importance\":54,\"description\":\"Test\",\"sys_data\":[]}','{\"task_due_date\":\"2016-10-26T00:00:00Z\",\"task_due_time\":\"03:00:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[10],\"task_status\":2,\"wu\":[10],\"solr\":{\"content\":\"Test Task\\n2016-10-26T00:00:00Z\\n03:00:00\\n10\\n54\\nTest\\n\",\"\":54,\"task_status\":2,\"task_u_assignee\":[10],\"task_u_all\":[10],\"task_u_ongoing\":[10],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-24T15:10:05Z\",\"users\":{\"10\":\"1284\"}}}'),(897,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"10\":\"1286\"},\"time\":\"2016-10-24T15:11:36Z\"}}'),(937,'{\"_title\":\"Test\",\"assigned\":\"6\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[6],\"task_status\":2,\"wu\":[6],\"solr\":{\"content\":\"Test\\n6\\n54\\n\",\"\":54,\"task_status\":2,\"task_u_assignee\":[6],\"task_u_all\":[6],\"task_u_ongoing\":[6],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-02T19:52:28Z\",\"users\":{\"6\":\"1461\"}}}'),(938,'{\"en\":\"Yes\",\"visible\":\"Generic-1\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Yes\\nGeneric-1\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:07Z\",\"users\":{\"1\":\"1467\"}}}'),(939,'{\"en\":\"No\",\"visible\":\"Generic-2\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"No\\nGeneric-2\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:18Z\",\"users\":{\"1\":\"1468\"}}}'),(940,'{\"en\":\"Don''t know\",\"visible\":\"Generic-3\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Don''t know\\nGeneric-3\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:42Z\",\"users\":{\"1\":\"1469\"}}}'),(941,'{\"en\":\"Refused\",\"visible\":\"Generic-4\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\nGeneric-4\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:56Z\",\"users\":{\"1\":\"1470\"}}}'),(952,'{\"_title\":\"System folders\"}','{\"wu\":[],\"solr\":{\"content\":\"System folders\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1572\"},\"time\":\"2016-11-14T15:30:00Z\"}}'),(953,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T15:30:26Z\",\"users\":{\"1\":\"1573\"}}}'),(954,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1576\"},\"time\":\"2016-11-14T15:31:08Z\"}}'),(955,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T15:30:59Z\",\"users\":{\"1\":\"1575\"}}}'),(962,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1590\"},\"time\":\"2016-11-14T17:55:07Z\"}}'),(963,'{\"_title\":\"AssessmentMenu\",\"template_ids\":\"972\",\"menu\":\"510,533,553,482,455,505,559,489,440,656,467,651,172\"}','{\"wu\":[],\"solr\":{\"content\":\"AssessmentMenu\\n972\\n510,533,553,482,455,505,559,489,440,656,467,651,172\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1613\"},\"time\":\"2016-11-14T20:18:41Z\"}}'),(970,'{\"_title\":\"AssessmentsTest\",\"en\":\"Test\",\"type\":\"object\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"AssessmentsTest\\nTest\\nobject\\n1\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1752\"},\"time\":\"2016-12-08T17:47:23Z\"}}'),(972,'{\"_title\":\"Assessments\",\"en\":\"Assessments\",\"type\":\"object\",\"visible\":1,\"title_template\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\nAssessments\\nobject\\n1\\nAssessments\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1615\"},\"time\":\"2016-11-14T20:28:22Z\"}}'),(973,'{\"_title\":\"Assessment Start\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessment Start\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:15:12Z\",\"users\":{\"1\":\"1609\"}}}'),(976,'{\"_title\":\"ClientIntake\",\"en\":\"Client Intake\",\"type\":\"object\",\"visible\":\"Generic-1\",\"title_template\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"ClientIntake\\nClient Intake\\nobject\\nGeneric-1\\nClient Intake\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:28:53Z\",\"users\":{\"1\":\"1616\"}}}'),(977,'{\"_title\":\"_startdate\",\"en\":\"Start Date\",\"type\":\"datetime\"}','{\"wu\":[],\"solr\":{\"content\":\"_startdate\\nStart Date\\ndatetime\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:29:21Z\",\"users\":{\"1\":\"1617\"}}}'),(978,'{\"_title\":\"ClientIntakeMenu\",\"template_ids\":\"976\",\"menu\":\"311,489,289\"}','{\"wu\":[],\"solr\":{\"content\":\"ClientIntakeMenu\\n976\\n311,489,289\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:33:05Z\",\"users\":{\"1\":\"1618\"}}}');
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varbinary(100) NOT NULL,
  `pid` varbinary(100) DEFAULT NULL COMMENT 'parrent session id',
  `last_action` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires` timestamp NULL DEFAULT NULL COMMENT 'expire could be null for non expiring sessions',
  `user_id` int(10) unsigned NOT NULL,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `idx_expires` (`expires`),
  KEY `idx_last_action` (`last_action`),
  KEY `idx_pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `is_folder` tinyint(1) unsigned DEFAULT '0',
  `type` enum('case','object','file','task','user','email','template','field','search','comment','shortcut','menu','config') DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `l1` varchar(100) DEFAULT NULL,
  `l2` varchar(100) DEFAULT NULL,
  `l3` varchar(250) DEFAULT NULL,
  `l4` varchar(100) DEFAULT NULL,
  `order` int(11) unsigned DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `iconCls` varchar(50) DEFAULT NULL,
  `default_field` varchar(50) DEFAULT NULL,
  `cfg` text,
  `title_template` text,
  `info_template` text,
  PRIMARY KEY (`id`),
  KEY `FK_templates__pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=977 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (5,88,0,'object','folder','Folder','Folder','Folder','Folder',5,1,'icon-folder',NULL,'{\"createMethod\":\"inline\",\n  \"DC\": {\n    \"nid\": {},\n    \"name\": {},\n    \"oid\": { \"title\": \"Case Manager\"},\n    \"cid\": { \"title\": \"Entered By\"},\n    \"cdate\": { \"title\": \"Entered Date\"}\n  },\n  \"object_plugins\":\n      [\"comments\",\n       \"systemProperties\"\n      ]\n\n}','{name}',NULL),(6,88,0,'file','file_template','File','File','File','File',6,1,'fa fa-file fa-fl',NULL,NULL,'{name}',NULL),(7,88,0,'task','task','Task','Task','Task','Task',3,1,'icon-task',NULL,NULL,'{name}',NULL),(8,88,0,'object','Thesauri Item','Thesauri item','Thesauri item','Thesauri item','Thesauri item',0,1,'fa fa-sticky-note fa-fl',NULL,NULL,'{en}',NULL),(9,88,0,'comment','Comment',NULL,NULL,NULL,NULL,0,1,'fa fa-comment fa-fl',NULL,'{\n  \"systemType\": 2\n}',NULL,NULL),(10,88,0,'user','User','User',NULL,'Пользователь',NULL,1,1,'fa fa-user fa-fl',NULL,'{\"files\":\"1\",\"main_file\":\"1\"}',NULL,NULL),(11,88,0,'template','Template','Template','Template','Template','Template',0,1,'fa fa-file-code-o fa-fl',NULL,'{\n\"DC\": {\n  \"nid\": {},\n  \"name\": {},\n  \"type\": {},\n  \"cfg\": {},\n  \"order\": {\n     \"sortType\": \"asInt\"\n     ,\"solr_column_name\": \"order\"\n  }\n}\n}',NULL,NULL),(12,88,0,'field','Field','Field','Field','Field','Field',0,1,'fa fa-foursquare fa-fl',NULL,'[]',NULL,NULL),(58,88,0,'shortcut','shortcut','Shortcut',NULL,NULL,NULL,0,1,'fa fa-external-link-square  fa-fl',NULL,NULL,NULL,NULL),(61,59,0,'object','- Menu separator -','- Menu separator -',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(62,59,0,'menu','Menu rule','Menu rule',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(83,88,0,'object','link','Link',NULL,NULL,NULL,0,1,'fa fa-external-link fa-fl',NULL,NULL,'{url}',NULL),(91,89,0,'config','Config int option','Config int option',NULL,NULL,NULL,0,1,'fa fa-gear fa-fl',NULL,NULL,NULL,NULL),(94,89,0,'config','Config varchar option','Config varchar option',NULL,NULL,NULL,0,1,'fa fa-gear fa-fl',NULL,NULL,NULL,NULL),(97,89,0,'config','Config text option','Config text option',NULL,NULL,NULL,0,1,'fa fa-gear fa-fl',NULL,NULL,NULL,NULL),(100,89,0,'config','Config json option','Config json option',NULL,NULL,NULL,0,1,'fa fa-gears fa-fl',NULL,NULL,NULL,NULL),(141,140,0,'case','Client',NULL,NULL,NULL,NULL,0,1,'icon-case',NULL,'{\n\"system_folders\":\"952\",\n\"DC\": {\n\"nid\": {},\n\"name\": {},\n\"cid\":{\"title\": \"Entered By\"},\n\"cdate\":{\"title\": \"Entered Date\"}\n}\n}','{_firstname}  {_lastname}',NULL),(172,140,0,'object','TransportationAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-transportation',NULL,'{\n\"leaf\":true\n}','Transportation Assessment',NULL),(205,3,0,'case','Case',NULL,NULL,NULL,NULL,0,0,'icon-briefcase',NULL,NULL,'{name}',NULL),(207,3,0,'object','Contact',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(289,140,0,'object','FamilyMember',NULL,NULL,NULL,NULL,0,1,'icon-object4',NULL,'{\n\"leaf\":true\n}','{_firstname} {_lastname}',NULL),(311,140,0,'object','Address',NULL,NULL,NULL,NULL,0,1,'icon-object8',NULL,'{\n\"leaf\":true\n}','Address',NULL),(440,140,0,'object','HousingAssessment',NULL,NULL,NULL,NULL,0,1,'icon-object8',NULL,'{\n\"leaf\":true\n}','Housing Assessment',NULL),(455,140,0,'object','FinancialAssessment',NULL,NULL,NULL,NULL,0,1,'icon-echr_complaint',NULL,'{\n\"leaf\":true\n}','Financial Assessment',NULL),(467,140,0,'object','MonthlyExpensesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-echr_complaint',NULL,'{\n\"leaf\":true\n}','Monthly Expenses Assessment',NULL),(482,140,0,'object','EmploymentAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-employment',NULL,'{\n\"leaf\":true\n}','Employment Assessment',NULL),(489,140,0,'object','HealthInsurance',NULL,NULL,NULL,NULL,0,1,'icon-case_card',NULL,'{\n\"leaf\":true\n}','Health Assessment',NULL),(505,140,0,'object','FoodAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-food',NULL,'{\n\"leaf\":true\n}','Food Assessment',NULL),(510,140,0,'object','BehavioralHealthAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-behavioral',NULL,'{\n\"leaf\":true\n}','Behavioral Health Advocacy Assessment',NULL),(527,140,0,'object','CaseNote',NULL,NULL,NULL,NULL,0,1,'icon-committee-phase',NULL,'{\n    \"acceptChildren\": false\n    ,\"leaf\":true\n}','Case Note',NULL),(533,140,0,'object','ChildAssesment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-child',NULL,'{\n\"leaf\":true\n}','Children and Youth Assessment',NULL),(553,140,0,'object','ClothingAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-clothing',NULL,'{\n\"leaf\":true\n}','Clothing Assessment',NULL),(559,140,0,'object','FurnitureAndAppliancesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-appliances',NULL,'{\n\"leaf\":true\n}','Furniture and Appliances Assessment',NULL),(607,140,0,'object','Referral',NULL,NULL,NULL,NULL,0,1,'icon-arrow-right-medium',NULL,'{\n\"leaf\":true\n}','Referral',NULL),(651,140,0,'object','SeniorServicesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-senior-services',NULL,'{\n\"leaf\":true\n}','Senior Services Assessment',NULL),(656,140,0,'template','LanguageAssessment',NULL,NULL,NULL,NULL,0,0,'icon-assessment-language',NULL,'{\n\"leaf\":true\n}','Language Assessment',NULL),(669,140,0,'object','Service',NULL,NULL,NULL,NULL,0,0,'icon-case_card',NULL,'{\n\"leaf\":true\n}','{_name}',NULL),(750,734,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(751,734,0,'template','Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(767,755,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(768,755,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(782,772,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(801,787,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(830,821,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(832,772,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(840,838,0,NULL,'New Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(913,869,0,NULL,'Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(933,918,0,NULL,'Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(950,869,0,NULL,'Language Assessment',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(970,140,0,'object','AssessmentsTest',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(972,140,0,'object','Assessments',NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'Assessments',NULL),(976,140,0,'object','ClientIntake',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,'Client Intake',NULL);
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates_structure`
--

DROP TABLE IF EXISTS `templates_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates_structure` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `template_id` int(11) unsigned NOT NULL,
  `tag` varchar(30) DEFAULT NULL,
  `level` smallint(6) unsigned DEFAULT '0',
  `name` varchar(1000) NOT NULL,
  `l1` varchar(1000) DEFAULT NULL,
  `l2` varchar(1000) DEFAULT NULL,
  `l3` varchar(1000) DEFAULT NULL,
  `l4` varchar(1000) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL COMMENT 'varchar,date,time,int,bool,text,combo,popup_list',
  `order` smallint(6) unsigned DEFAULT '0',
  `cfg` text,
  `solr_column_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `templates_structure_pid` (`pid`),
  KEY `templates_structure_template_id` (`template_id`),
  KEY `idx_templates_structure_type` (`type`),
  CONSTRAINT `FK_templates_structure__template_id` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=978 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates_structure`
--

LOCK TABLES `templates_structure` WRITE;
/*!40000 ALTER TABLE `templates_structure` DISABLE KEYS */;
INSERT INTO `templates_structure` VALUES (13,10,10,'f',0,'en','Full name (en)',NULL,NULL,NULL,'varchar',1,NULL,NULL),(14,10,10,'f',0,'initials','Initials','Initiales','Инициалы',NULL,'varchar',4,'[]',NULL),(15,10,10,'f',0,'sex','Sex','Sexe','Пол',NULL,'_sex',5,'{\"thesauriId\":\"90\"}',NULL),(16,10,10,'f',0,'position','Position','Titre','Должность',NULL,'_objects',7,'{\"source\":\"tree\",\"scope\":24340,\"oldThesauriId\":\"362\"}',NULL),(17,10,10,'f',0,'email','E-mail','E-mail','E-mail',NULL,'varchar',9,'{\"maxInstances\":\"3\"}',NULL),(18,10,10,'f',0,'language_id','Language','Langue','Язык',NULL,'_language',11,'[]',NULL),(19,10,10,'f',0,'short_date_format','Date format','Format de date','Формат даты',NULL,'_short_date_format',12,'[]',NULL),(20,10,10,'f',0,'description','Description','Description','Примечание',NULL,'varchar',13,'[]',NULL),(21,10,10,'f',0,'room','Room','Salle','Кабинет',NULL,'varchar',8,'[]',NULL),(22,10,10,'f',0,'phone','Phone','Téléphone','Телефон',NULL,'varchar',10,'{\"maxInstances\":\"10\"}',NULL),(23,10,10,'f',0,'location','Location','Emplacement','Расположение',NULL,'_objects',6,'{\"source\":\"tree\",\"scope\":24373,\"oldThesauriId\":\"394\"}',NULL),(24,6,6,'f',0,'program','Program','Program','Program','Program','_objects',1,'{\"source\":\"tree\",\"multiValued\":true,\"autoLoad\":true,\"editor\":\"form\",\"renderer\":\"listGreenIcons\",\"faceting\":true,\"scope\":24265,\"oldThesauriId\":\"715\"}',NULL),(25,12,12,NULL,0,'_title','Name','Name','Name','Name','varchar',NULL,'{\"showIn\":\"top\"}',NULL),(26,12,12,NULL,0,'type','Type','Type','Type','Type','_fieldTypesCombo',5,'[]',NULL),(27,12,12,NULL,0,'order','Order','Order','Order','Order','field',6,'{\n  \"indexed\": true\n}','order'),(28,12,12,NULL,0,'cfg','Config','Config','Config','Config','memo',7,'{\"height\":100}',NULL),(29,12,12,NULL,0,'solr_column_name','Solr column name','Solr column name','Solr column name','Solr column name','varchar',8,'[]',NULL),(30,12,12,NULL,0,'en','Title (en)','Title (en)','Title (en)','Title (en)','varchar',1,'[]',NULL),(31,11,11,NULL,0,'_title','Name','Name','Name','Name','varchar',NULL,'{\"showIn\":\"top\",\"rea-dOnly\":true}',NULL),(32,11,11,NULL,0,'type','Type','Type','Type','Type','_templateTypesCombo',5,'[]',NULL),(33,11,11,NULL,0,'visible','Active','Active','Active','Active','checkbox',6,'{\"showIn\":\"top\"}',NULL),(34,11,11,NULL,0,'iconCls','Icon class','Icon class','Icon class','Icon class','iconcombo',7,'[]',NULL),(35,11,11,NULL,0,'cfg','Config','Config','Config','Config','text',8,'{\"height\":100}',NULL),(36,11,11,NULL,0,'title_template','Title template','Title template','Title template','Title template','text',9,'{\"height\":50}',NULL),(37,11,11,NULL,0,'info_template','Info template','Info template','Info template','Info template','text',10,'{\"height\":50}',NULL),(38,11,11,NULL,0,'en','Title (en)','Title (en)','Title (en)','Title (en)','varchar',1,'[]',NULL),(39,8,8,NULL,0,'iconCls','Icon class',NULL,NULL,NULL,'iconcombo',5,NULL,NULL),(40,8,8,NULL,0,'visible','Visible',NULL,NULL,NULL,'checkbox',6,NULL,NULL),(41,8,8,NULL,0,'order','Order',NULL,NULL,NULL,'int',7,'{\n\"indexed\": true\n}','order'),(42,8,8,NULL,0,'en','Title',NULL,NULL,NULL,'varchar',0,'{\"showIn\":\"top\"}',NULL),(43,8,8,NULL,0,'ru','Title (ru)','Title (ru)','Title (ru)','Title (ru)','varchar',1,'{\"showIn\":\"top\"}',NULL),(44,7,7,NULL,0,'_title','Title',NULL,NULL,NULL,'varchar',1,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(45,7,7,NULL,0,'assigned','Assigned',NULL,NULL,NULL,'_objects',7,'{\n  \"editor\": \"form\"\n  ,\"source\": \"users\"\n  ,\"renderer\": \"listObjIcons\"\n  ,\"autoLoad\": true\n  ,\"multiValued\": true\n  ,\"hidePreview\": true\n}',NULL),(46,7,7,NULL,0,'importance','Importance',NULL,NULL,NULL,'_objects',8,'{\n  \"scope\": 53,\n  \"value\": 54,\n  \"faceting\": true\n}',NULL),(47,7,7,NULL,0,'description','Description',NULL,NULL,NULL,'memo',10,'{\n  \"height\": 100\n  ,\"noHeader\": true\n  ,\"hidePreview\": true\n  ,\"linkRenderer\": \"user,object,url\"\n}',NULL),(48,5,5,NULL,0,'_title','Name','Название',NULL,NULL,'varchar',1,NULL,NULL),(49,9,9,NULL,0,'_title','Text','Текст',NULL,NULL,'memo',0,'{\n\"height\": 100\n}','content'),(50,7,7,NULL,0,'due_date','Due date',NULL,NULL,NULL,'date',5,'{\n\"hidePreview\": true\n}',NULL),(51,7,7,NULL,0,'due_time','Due time',NULL,NULL,NULL,'time',6,'{\n\"hidePreview\": true\n}',NULL),(63,62,62,NULL,0,'_title','Title',NULL,NULL,NULL,'varchar',1,NULL,NULL),(64,62,62,NULL,0,'node_ids','Nodes',NULL,NULL,NULL,'_objects',2,'{\"multiValued\":true,\"editor\":\"form\",\"renderer\":\"listObjIcons\"}',NULL),(65,62,62,NULL,0,'template_ids','Templates',NULL,NULL,NULL,'_objects',3,'{\"templates\":\"11\",\"editor\":\"form\",\"multiValued\":true,\"renderer\":\"listObjIcons\"}',NULL),(66,62,62,NULL,0,'user_group_ids','Users/Groups',NULL,NULL,NULL,'_objects',4,'{\"source\":\"usersgroups\",\"multiValued\":true}',NULL),(67,62,62,NULL,0,'menu','Menu',NULL,NULL,NULL,'_objects',5,'{\"templates\":\"11\",\"multiValued\":true,\"editor\":\"form\",\"allowValueSort\":true,\"renderer\":\"listObjIcons\"}',NULL),(84,83,83,NULL,0,'type','Type',NULL,NULL,NULL,'_objects',1,'{\n\"scope\": 75 \n}',NULL),(85,83,83,NULL,0,'url','URL',NULL,NULL,NULL,'varchar',2,NULL,NULL),(86,83,83,NULL,0,'description','Description',NULL,NULL,NULL,'varchar',3,NULL,NULL),(87,83,83,NULL,0,'tags','Tags',NULL,NULL,NULL,'_objects',4,'{\n\"scope\": 82\n,\"editor\": \"tagField\"\n}',NULL),(92,91,91,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(93,91,91,NULL,0,'value','Value',NULL,NULL,NULL,'int',2,NULL,NULL),(95,94,94,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(96,94,94,NULL,0,'value','Value',NULL,NULL,NULL,'varchar',2,NULL,NULL),(98,97,97,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(99,97,97,NULL,0,'value','Value',NULL,NULL,NULL,'text',2,NULL,NULL),(101,100,100,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(102,100,100,NULL,0,'value','Value',NULL,NULL,NULL,'field',2,'{\n\"editor\":\"ace\",\n\"format\":\"json\",\n\"validator\":\"json\"\n}',NULL),(103,100,100,NULL,0,'order','Order',NULL,NULL,NULL,'int',3,'{\"indexed\":true}','order'),(142,141,141,NULL,0,'_firstname',NULL,NULL,NULL,NULL,'field',1,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(143,141,141,NULL,0,'_lastname',NULL,NULL,NULL,NULL,'field',3,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(144,141,141,NULL,0,'_header',NULL,NULL,NULL,NULL,'field',0,NULL,NULL),(145,141,141,NULL,0,'_femacategory',NULL,NULL,NULL,NULL,'field',4,'{\n  \"scope\": 137,\n  \"value\": 138,\n  \"faceting\": true\n}',NULL),(206,205,205,NULL,0,'contacts',NULL,NULL,NULL,NULL,'field',NULL,'{\"source\":\"tree\",\"multiValued\":true}',NULL),(208,207,207,NULL,0,'FirstName',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(209,141,141,NULL,0,'_middlename',NULL,NULL,NULL,NULL,'field',3,NULL,NULL),(210,141,141,NULL,0,'_birthdate',NULL,NULL,NULL,NULL,'field',4,'{ \n\"generateAge\": \"Client Age\" \n}',NULL),(211,141,141,NULL,0,'_clientage',NULL,NULL,NULL,NULL,'field',5,NULL,NULL),(212,141,141,NULL,0,'_gender',NULL,NULL,NULL,NULL,'field',6,'{\n\"scope\" : 167,\n\"faceting\":true\n}','gender_i'),(272,141,141,NULL,0,'_emailaddress',NULL,NULL,NULL,NULL,'field',7,NULL,NULL),(274,141,141,NULL,0,'_ethnicity',NULL,NULL,NULL,NULL,'field',9,'{\n\"scope\" : 226\n}',NULL),(275,141,141,NULL,0,'_race',NULL,NULL,NULL,NULL,'field',8,'{\n\"scope\" : 227\n}',NULL),(276,141,141,NULL,0,'_primarylanguage',NULL,NULL,NULL,NULL,'field',10,'{\n\"scope\" : 228\n}',NULL),(277,141,141,NULL,0,'_limitedenglish',NULL,NULL,NULL,NULL,'varchar',11,NULL,NULL),(278,141,141,NULL,0,'_specialatrisk',NULL,NULL,NULL,NULL,'H',12,NULL,NULL),(279,141,141,NULL,0,'_disabilities',NULL,NULL,NULL,NULL,'field',13,NULL,NULL),(280,141,141,NULL,0,'_domestic',NULL,NULL,NULL,NULL,'field',14,NULL,NULL),(290,289,289,NULL,0,'_firstname',NULL,NULL,NULL,NULL,'field',1,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(291,289,289,NULL,0,'_lastname',NULL,NULL,NULL,NULL,'field',2,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(292,289,289,NULL,0,'_birthdate',NULL,NULL,NULL,NULL,'field',4,NULL,NULL),(293,289,289,NULL,0,'_age',NULL,NULL,NULL,NULL,'field',5,NULL,NULL),(294,289,289,NULL,0,'_gender',NULL,NULL,NULL,NULL,'field',6,'{\n\"scope\" : 167\n}',NULL),(295,289,289,NULL,0,'_relationship',NULL,NULL,NULL,NULL,'field',7,'{\n\"scope\" : 299\n}',NULL),(296,289,289,NULL,0,'_middlename',NULL,NULL,NULL,NULL,'varchar',3,NULL,NULL),(297,289,289,NULL,0,'_race',NULL,NULL,NULL,NULL,'field',8,'{\n\"scope\" : 227\n}',NULL),(298,289,289,NULL,0,'_ethnicity',NULL,NULL,NULL,NULL,'field',9,'{\n\"scope\" : 226\n}',NULL),(312,311,311,NULL,0,'_addresstype',NULL,NULL,NULL,NULL,'field',1,'{\n\"scope\" : 321\n}',NULL),(313,311,311,NULL,0,'_addressone',NULL,NULL,NULL,NULL,'field',2,'{\n\"faceting\":true\n}','addressone_s'),(314,311,311,NULL,0,'_addresstwo',NULL,NULL,NULL,NULL,'field',3,'{\n\"faceting\":true\n}','undefined'),(315,311,311,NULL,0,'_city',NULL,NULL,NULL,NULL,'field',4,'{\n\"faceting\":true\n}','city_s'),(316,311,311,NULL,0,'_state',NULL,NULL,NULL,NULL,'field',4,'{\n\"faceting\":true\n}','state_s'),(317,311,311,NULL,0,'_zip',NULL,NULL,NULL,NULL,'int',5,NULL,NULL),(318,311,311,NULL,0,'_begindate',NULL,NULL,NULL,NULL,'date',6,NULL,NULL),(319,311,311,NULL,0,'_enddate',NULL,NULL,NULL,NULL,'date',7,NULL,NULL),(320,311,311,NULL,0,'_primaryphone',NULL,NULL,NULL,NULL,'varchar',8,NULL,NULL),(432,172,172,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(433,172,172,NULL,0,'_primarymode',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 392\n}',NULL),(434,172,172,NULL,0,'_methodworking',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(435,172,172,NULL,0,'_ifnotworking',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(436,172,172,NULL,0,'_insured',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(437,172,172,NULL,0,'_receivedpayment',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(438,172,172,NULL,0,'_damagedindisaster',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(439,172,172,NULL,0,'_transportationneeds',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 401\n}',NULL),(441,440,440,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(442,440,440,NULL,0,'_predisasterliving',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\":334\n}',NULL),(443,440,440,NULL,0,'_damagedhouse',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(444,443,440,NULL,1,'_inspectedhouse',NULL,NULL,NULL,NULL,'field',NULL,'{\n	\"scope\": 351\n	,\"dependency\": {\n		\"pidValues\": [347]\n	}\n}',NULL),(445,440,440,NULL,0,'_accessiblehouse',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(446,440,440,NULL,0,'_livablehouse',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(447,440,440,NULL,0,'_clientdamagerating',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 355\n}',NULL),(448,440,440,NULL,0,'_clientrelocated',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(449,448,440,NULL,1,'_planstoreturn',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n   	\"pidValues\": [347]\n    }\n}',NULL),(450,440,440,NULL,0,'_utilitieswork',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(451,450,440,NULL,1,'_utilitiesnotworking',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 362\n   ,\"dependency\": {\n      \"pidValues\": [348]\n   }\n}',NULL),(452,440,440,NULL,0,'_disasterImpacts',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(453,440,440,NULL,0,'_predisasterinsurance',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 372\n}',NULL),(454,440,440,NULL,0,'_insurancedetails',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(456,455,455,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(457,455,455,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(458,455,455,NULL,0,'_incomereceived',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(459,455,455,NULL,0,'_noncashbenefits',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(460,455,455,NULL,0,'_incomeGroup',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 389\n}',NULL),(461,455,455,NULL,0,'_noncashbenefits',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(462,455,455,NULL,0,'_earnedIncome',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(463,455,455,NULL,0,'_unemploymentinsurance',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(464,455,455,NULL,0,'_ssi',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(465,455,455,NULL,0,'_ssdi',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(466,455,455,NULL,0,'_veteransdisability',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(468,467,467,NULL,0,'_assessmentorder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(469,467,467,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(470,467,467,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(471,467,467,NULL,0,'_rent',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\" : \"Total monthly amount\" \n} ',NULL),(472,467,467,NULL,0,'_mortgage',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(473,467,467,NULL,0,'_maintenance',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(474,467,467,NULL,0,'_carpayment',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(475,467,467,NULL,0,'_carinsurance',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(476,467,467,NULL,0,'_gasoline',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(477,467,467,NULL,0,'_medical',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(478,467,467,NULL,0,'_food',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(479,467,467,NULL,0,'_miscellaneous',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(480,467,467,NULL,0,'_totalExpenses',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(481,467,467,NULL,0,'_totalmonthlyamount',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"readonly\":true\n}',NULL),(483,482,482,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(484,482,482,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(485,482,482,NULL,0,'_employed',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":346\n}',NULL),(486,485,482,NULL,1,'_hoursworked',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(487,485,482,NULL,1,'_employmenttenure',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 411\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(488,482,482,NULL,0,'_additionalemployment',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":346\n}',NULL),(490,489,489,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(491,489,489,NULL,0,'_insuranceType',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 416\n}',NULL),(492,489,489,NULL,0,'_isPrimary',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(493,489,489,NULL,0,'_medscovered',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(494,489,489,NULL,0,'_dmecovered',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(495,489,489,NULL,0,'_insurancestatus',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 501\n}',NULL),(496,489,489,NULL,0,'_insurancelostdisaster',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(497,489,489,NULL,0,'_whatcausedinsuranceloss',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(498,489,489,NULL,0,'_startdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(499,489,489,NULL,0,'_enddate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(500,489,489,NULL,0,'_appliedfordate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(506,505,505,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(507,505,505,NULL,0,'_enoughfood',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(508,505,505,NULL,0,'_predisasterassistance',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 516\n}',NULL),(509,505,505,NULL,0,'_requestedfood',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(511,510,510,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',1,NULL,NULL),(512,510,510,NULL,0,'_indistress',NULL,NULL,NULL,NULL,'field',2,'{\n\"scope\": 346\n}',NULL),(513,510,510,NULL,0,'_liketospeak',NULL,NULL,NULL,NULL,'field',3,'{\n\"scope\": 346\n}',NULL),(514,510,510,NULL,0,'_feelsafe',NULL,NULL,NULL,NULL,'field',4,'{\n\"scope\": 346\n}',NULL),(515,510,510,NULL,0,'_hurtingyourselfothers',NULL,NULL,NULL,NULL,'field',5,'{\n\"scope\": 346\n}',NULL),(528,527,527,NULL,0,'_entrydate',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"value\": \"2016-10-24\"\n}',NULL),(529,527,527,NULL,0,'_regarding',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(530,527,527,NULL,0,'_regarding',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(531,527,527,NULL,0,'_notetype',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 522,\n\"faceting\":true\n}','notetype_i'),(532,527,527,NULL,0,'_casenote',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(534,533,533,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(535,533,533,NULL,0,'_childrenunder18',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(536,533,533,NULL,0,'_fostercare',NULL,NULL,NULL,NULL,'_objects',NULL,NULL,NULL),(537,535,533,NULL,1,'_fostercare',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(538,535,533,NULL,1,'_headstart',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(539,538,533,NULL,1,'_servicesdisrupted',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(540,535,533,NULL,1,'_childcareneed',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(541,540,533,NULL,1,'_priorvoucher',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(542,540,533,NULL,2,'_barrierstochildcare',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(543,533,533,NULL,0,'_childsupportpre',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(544,533,533,NULL,0,'_responsibleforchildsupoprt',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(545,533,533,NULL,0,'_paymentsdelayed',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(546,533,533,NULL,0,'_childsupportpost',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(547,535,533,NULL,1,'_kidsinschool',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(548,547,533,NULL,1,'_sameschoolpostdisaster',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(549,547,533,NULL,1,'_needhelpregistering',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [348]\n   }\n}',NULL),(550,535,533,NULL,1,'_missedimmunizations',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(551,535,533,NULL,1,'_copingconcerns',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(552,551,533,NULL,1,'_copingexplanations',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(554,553,553,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(555,553,553,NULL,0,'_anyoneloseclothing',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(556,553,553,NULL,0,'_usableclothing',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(557,553,553,NULL,0,'_coldweather',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(558,555,553,NULL,1,'_makeclaim',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n	\"pidValues\": [347]\n   }\n}',NULL),(560,559,559,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(561,559,559,NULL,0,'_anythingdestroyed',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(562,561,559,NULL,1,'_refrigerator',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(563,561,559,NULL,1,'_stove',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(564,561,559,NULL,1,'_beds',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(565,564,559,NULL,1,'_numberofbeds',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(566,559,559,NULL,0,'_numberofbeds',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(567,561,559,NULL,1,'_claimforfurniture',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(568,561,559,NULL,1,'_replacementitemsreceived',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(569,561,559,NULL,1,'_abletoinstall',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(608,607,607,NULL,0,'_referraldate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(609,607,607,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":570\n}',NULL),(610,607,607,NULL,0,'_provider',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(611,607,607,NULL,0,'_provider',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(612,607,607,NULL,0,'_streetaddress',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(613,607,607,NULL,0,'_zipcode',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(614,607,607,NULL,0,'_city',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(615,607,607,NULL,0,'_state',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(616,607,607,NULL,0,'_geocode',NULL,NULL,NULL,NULL,'geoPoint',NULL,NULL,NULL),(617,607,607,NULL,0,'_referralstatus',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":593\n}',NULL),(618,607,607,NULL,0,'_comments',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(619,607,607,NULL,0,'_associatedneed',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(620,607,607,NULL,0,'_voucherinformation',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(621,607,607,NULL,0,'_vouchernumber',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(622,607,607,NULL,0,'_voucheruom',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":602\n}',NULL),(623,607,607,NULL,0,'_voucherunits',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(624,607,607,NULL,0,'_unitvalue',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(625,607,607,NULL,0,'_vouchertotal',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(626,607,607,NULL,0,'_informationrelease',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(627,607,607,NULL,0,'_emailauthorized',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(628,607,607,NULL,0,'_referraloutcome',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(629,607,607,NULL,0,'_dateacknowledged',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(630,607,607,NULL,0,'_appointmentdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(631,607,607,NULL,0,'_appointmentdate',NULL,NULL,NULL,NULL,'datetime',NULL,NULL,NULL),(632,607,607,NULL,0,'_resultdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(633,607,607,NULL,0,'_result',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":597\n}',NULL),(634,141,141,NULL,0,'_fematier',NULL,NULL,NULL,NULL,'field',15,'{\n\"source\":\"tree\",\n\"scope\":137,\n\"faceting\":true\n}','fema_tier_i'),(643,141,141,NULL,0,'_clientstatus',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"source\":\"tree\",\n\"scope\": 644,\n\"faceting\":true\n}','client_status_i'),(652,651,651,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(653,651,651,NULL,0,'_priorseniorliving',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(654,653,651,NULL,1,'_clientdisplaced',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n	\"pidValues\": [347]\n   }\n}',NULL),(655,654,651,NULL,2,'_explaincircumstances',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n	\"pidValues\": [347]\n   }\n}',NULL),(657,656,656,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(658,656,656,NULL,0,'New Field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(659,656,656,NULL,0,'_priorlanguage',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(660,656,656,NULL,0,'_currentlyhavinglanguage',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(661,656,656,NULL,0,'_lostlanguageservices',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":346\n}',NULL),(670,669,669,NULL,0,'_name',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(671,669,669,NULL,0,'_address',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(672,669,669,NULL,0,'_notes',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(683,533,533,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n}',NULL),(684,533,533,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(703,141,141,NULL,0,'New Field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(718,607,607,NULL,0,'_name',NULL,NULL,NULL,NULL,'field',1,NULL,NULL),(722,311,311,NULL,0,'_latlon',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"faceting\":true\n}','latlon_s'),(845,510,510,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',6,'{\n\"scope\":685\n}',NULL),(846,510,510,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',7,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(847,553,553,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n}',NULL),(848,482,482,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(849,455,455,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(850,505,505,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(851,559,559,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n}',NULL),(852,489,489,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n}',NULL),(853,440,440,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(854,656,656,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(855,467,467,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(856,651,651,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(857,172,172,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(858,553,553,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(859,482,482,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(860,455,455,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(861,505,505,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(862,559,559,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(863,440,440,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": false\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(864,656,656,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(865,467,467,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(866,651,651,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(867,172,172,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(870,651,651,NULL,0,'TestReferral',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\":685\n}',NULL),(973,972,972,NULL,0,'Assessment Start',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(977,976,976,NULL,0,'_startdate',NULL,NULL,NULL,NULL,'datetime',NULL,NULL,NULL);
/*!40000 ALTER TABLE `templates_structure` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `templates_structure_bi` BEFORE INSERT ON `templates_structure` FOR EACH ROW BEGIN

	DECLARE msg VARCHAR(255);

	

	if (new.id = new.pid) then

		set msg = concat('Error: cyclic reference in templates_structure ', cast(new.id as char));

		signal sqlstate '45000' set message_text = msg;

	end if;

	

	if(NEW.PID is not null) THEN

		SET NEW.LEVEL = COALESCE((SELECT `level` + 1 FROM templates_structure WHERE id = NEW.PID), 0);

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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `templates_structure_bu` BEFORE UPDATE ON `templates_structure` FOR EACH ROW BEGIN

	DECLARE msg VARCHAR(255);

	

	IF (new.id = new.pid) THEN

		SET msg = CONCAT('Error: cyclic reference in templates_structure ', CAST(new.id AS CHAR));

		signal SQLSTATE '45000' SET message_text = msg;

	END IF;

	

	IF(NEW.PID IS NOT NULL) THEN

		SET NEW.LEVEL = coalesce((SELECT `level` +1 FROM templates_structure WHERE id = NEW.PID), 0);

	END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `name` varbinary(100) DEFAULT NULL,
  `en` varchar(250) DEFAULT NULL,
  `es` varchar(250) DEFAULT NULL,
  `ge` varchar(250) DEFAULT NULL,
  `fr` varchar(250) DEFAULT NULL,
  `hy` varchar(250) DEFAULT NULL,
  `pt` varchar(250) DEFAULT NULL,
  `ro` varchar(250) DEFAULT NULL,
  `ru` varchar(250) DEFAULT NULL,
  `ar` varchar(1000) DEFAULT NULL,
  `zh` varchar(1000) DEFAULT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 - anywhere, 1 - server, 2 - client',
  `info` varchar(1000) DEFAULT NULL COMMENT 'Where in CB the term is used, what it means',
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 - not deleted, 1 - deleted',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_translations__name` (`name`),
  KEY `FK_translations__pid` (`pid`),
  CONSTRAINT `FK_translations__pid` FOREIGN KEY (`pid`) REFERENCES `translations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tree`
--

DROP TABLE IF EXISTS `tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(20) unsigned DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `type` smallint(5) unsigned DEFAULT NULL,
  `draft` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `draft_pid` varchar(10) DEFAULT NULL COMMENT 'used to attach other objects to a non existing, yet creating item',
  `template_id` int(10) unsigned DEFAULT NULL,
  `tag_id` int(10) unsigned DEFAULT NULL,
  `target_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `date` datetime DEFAULT NULL COMMENT 'start date',
  `date_end` datetime DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `is_main` tinyint(1) DEFAULT NULL,
  `cfg` text,
  `inherit_acl` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'inherit the access permissions from parent',
  `cid` int(10) unsigned DEFAULT NULL COMMENT 'creator id',
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'creation date',
  `uid` int(10) DEFAULT NULL COMMENT 'updater id',
  `udate` timestamp NULL DEFAULT NULL COMMENT 'update date',
  `updated` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1st bit - node updated, 2nd - security updated, 3rd - node moved',
  `oid` int(11) DEFAULT NULL COMMENT 'owner id',
  `did` int(10) unsigned DEFAULT NULL COMMENT 'delete user id',
  `ddate` timestamp NULL DEFAULT NULL,
  `dstatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'delete item status: 0 - not deleted, 1 - deleted, 2 - parent deleted',
  PRIMARY KEY (`id`),
  KEY `tree_tag_id` (`tag_id`),
  KEY `tree_pid` (`pid`),
  KEY `tree_updated` (`updated`),
  KEY `IDX_tree_date__date_end` (`date`,`date_end`),
  KEY `tree_template_id` (`template_id`),
  KEY `tree_draft` (`draft`),
  CONSTRAINT `tree_pid` FOREIGN KEY (`pid`) REFERENCES `tree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tree_template_id` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree`
--

LOCK TABLES `tree` WRITE;
/*!40000 ALTER TABLE `tree` DISABLE KEYS */;
INSERT INTO `tree` VALUES (1,NULL,NULL,1,1,0,NULL,5,NULL,NULL,'Tree',NULL,NULL,NULL,1,'[]',0,1,'2012-11-17 17:10:21',1,'2014-01-17 13:53:00',0,1,NULL,NULL,0),(2,1,NULL,0,1,0,NULL,5,NULL,NULL,'System',NULL,NULL,NULL,NULL,'[]',0,1,'2015-05-20 15:57:45',NULL,NULL,0,1,NULL,NULL,0),(3,2,NULL,0,NULL,0,NULL,5,NULL,NULL,'Templates',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:45',1,'2014-01-17 13:53:08',0,1,NULL,NULL,0),(4,2,NULL,0,4,0,NULL,5,NULL,NULL,'Thesauri Item','2013-09-24 19:38:09',NULL,NULL,NULL,'[]',1,256,'2013-09-24 19:38:09',1,'2016-10-03 14:14:04',0,256,NULL,NULL,0),(5,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',1,'2016-10-21 16:13:42',0,1,NULL,NULL,0),(6,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'file_template',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:48',1,'2016-06-09 13:50:28',0,1,NULL,NULL,0),(7,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'task',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',1,'2016-09-29 20:17:28',0,1,NULL,NULL,0),(8,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Thesauri Item',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2016-06-09 13:52:05',0,1,NULL,NULL,0),(9,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Comment',NULL,NULL,NULL,NULL,'null',1,1,'2014-02-12 21:14:04',1,'2016-06-09 13:52:26',0,1,NULL,NULL,0),(10,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'User',NULL,NULL,NULL,NULL,'{\"files\":\"1\",\"main_file\":\"1\"}',1,1,'2014-01-17 13:50:48',1,'2016-06-09 13:52:43',0,1,NULL,NULL,0),(11,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Template',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:45',1,'2016-06-09 13:56:21',0,1,NULL,NULL,0),(12,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Field',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:45',1,'2016-06-09 13:53:18',0,1,NULL,NULL,0),(13,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',1,'2015-05-21 06:36:59',0,1,NULL,NULL,0),(14,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'initials',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(15,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'sex',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(16,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'position',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(17,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'email',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(18,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'language_id',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(19,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'short_date_format',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(20,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'description',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(21,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'room',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(22,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'phone',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(23,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'location',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,NULL,NULL,0),(24,6,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:50',NULL,NULL,0,1,NULL,NULL,0),(25,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2014-01-21 11:24:06',0,1,NULL,NULL,0),(26,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'type',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(27,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'order',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2016-06-09 13:57:55',0,1,NULL,NULL,0),(28,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'cfg',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2014-02-28 16:12:37',0,1,NULL,NULL,0),(29,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'solr_column_name',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(30,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(31,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2014-02-12 21:12:31',0,1,NULL,NULL,0),(32,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'type',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(33,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'visible',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(34,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'iconCls',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(35,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'cfg',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(36,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'title_template',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(37,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'info_template',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(38,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(39,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'iconCls',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:05:08',0,1,NULL,NULL,0),(40,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'visible',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:05:42',0,1,NULL,NULL,0),(41,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'order',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:05:57',0,1,NULL,NULL,0),(42,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,'{\"showIn\":\"top\"}',1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:04:56',0,1,NULL,NULL,0),(43,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'ru',NULL,NULL,NULL,NULL,'{\"showIn\":\"top\"}',1,1,'2014-01-17 14:09:11',NULL,NULL,0,1,1,'2015-05-21 12:20:51',1),(44,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 09:34:21',0,1,NULL,NULL,0),(45,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'assigned',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 10:32:02',0,1,NULL,NULL,0),(46,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'importance',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 12:26:19',0,1,NULL,NULL,0),(47,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'description',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 10:32:34',0,1,NULL,NULL,0),(48,5,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,'null',1,1,'2014-01-22 14:10:27',NULL,NULL,0,1,NULL,NULL,0),(49,9,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,'null',1,1,'2014-02-12 21:15:03',NULL,NULL,0,1,NULL,NULL,0),(50,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'due_date',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 10:30:34',NULL,NULL,0,1,NULL,NULL,0),(51,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'due_time',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 10:31:04',NULL,NULL,0,1,NULL,NULL,0),(52,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'task',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:09:09',NULL,NULL,0,1,NULL,NULL,0),(53,52,NULL,0,NULL,0,NULL,5,NULL,NULL,'Importance',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:09:33',NULL,NULL,0,1,NULL,NULL,0),(54,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'Low',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:23:09',NULL,NULL,0,1,NULL,NULL,0),(55,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'Medium',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:24:01',NULL,NULL,0,1,NULL,NULL,0),(56,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'High',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:24:41',NULL,NULL,0,1,NULL,NULL,0),(57,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'CRITICAL',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:25:12',NULL,NULL,0,1,NULL,NULL,0),(58,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'shortcut',NULL,NULL,NULL,NULL,NULL,1,1,'2015-06-06 21:50:18',1,'2016-06-09 13:53:35',0,1,NULL,NULL,0),(59,88,NULL,0,NULL,0,NULL,5,NULL,NULL,'Menu',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(60,2,NULL,0,NULL,0,NULL,5,NULL,NULL,'Menus',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(61,59,NULL,0,NULL,0,NULL,11,NULL,NULL,'- Menu separator -',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(62,59,NULL,0,NULL,0,NULL,11,NULL,NULL,'Menu rule',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(63,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(64,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'node_ids',NULL,NULL,NULL,NULL,'{\"multiValued\":true,\"editor\":\"form\",\"renderer\":\"listObjIcons\"}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(65,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'template_ids',NULL,NULL,NULL,NULL,'{\"templates\":\"11\",\"editor\":\"form\",\"multiValued\":true,\"renderer\":\"listObjIcons\"}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(66,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'user_group_ids',NULL,NULL,NULL,NULL,'{\"source\":\"usersgroups\",\"multiValued\":true}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(67,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'menu',NULL,NULL,NULL,NULL,'{\"templates\":\"11\",\"multiValued\":true,\"editor\":\"form\",\"allowValueSort\":true,\"renderer\":\"listObjIcons\"}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(68,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Global Menu',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',1,'2016-10-14 04:01:39',0,1,NULL,NULL,0),(69,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Templates',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(70,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Templates SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(71,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Fields',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(72,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Thesauri',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(73,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Create menu rules in this folder',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(74,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'link',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:15:55',NULL,NULL,0,1,NULL,NULL,0),(75,74,NULL,0,NULL,0,NULL,5,NULL,NULL,'Type',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:16:07',NULL,NULL,0,1,NULL,NULL,0),(76,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Article',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:17:46',NULL,NULL,0,1,NULL,NULL,0),(77,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Document',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:18:06',NULL,NULL,0,1,NULL,NULL,0),(78,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Image',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:18:24',NULL,NULL,0,1,NULL,NULL,0),(79,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Sound',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:18:42',NULL,NULL,0,1,NULL,NULL,0),(80,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Video',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:19:03',NULL,NULL,0,1,NULL,NULL,0),(81,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Website',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:19:25',NULL,NULL,0,1,NULL,NULL,0),(82,74,NULL,0,NULL,0,NULL,5,NULL,NULL,'Tags',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:19:42',NULL,NULL,0,1,NULL,NULL,0),(83,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'link',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:23:21',1,'2016-06-09 13:53:47',0,1,NULL,NULL,0),(84,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'type',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:25:21',NULL,NULL,0,1,NULL,NULL,0),(85,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'url',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:25:58',NULL,NULL,0,1,NULL,NULL,0),(86,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'description',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:26:29',NULL,NULL,0,1,NULL,NULL,0),(87,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'tags',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:27:09',1,'2015-09-01 07:30:36',0,1,NULL,NULL,0),(88,3,NULL,0,NULL,0,NULL,5,NULL,NULL,'Built-in',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-02 13:45:52',NULL,NULL,0,1,NULL,NULL,0),(89,3,NULL,0,NULL,0,NULL,5,NULL,NULL,'Config',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(90,2,NULL,0,NULL,0,NULL,5,NULL,NULL,'Config',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(91,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config int option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:54:28',0,1,NULL,NULL,0),(92,91,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(93,91,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(94,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config varchar option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:54:40',0,1,NULL,NULL,0),(95,94,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(96,94,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(97,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config text option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:54:50',0,1,NULL,NULL,0),(98,97,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(99,97,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(100,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config json option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:55:06',0,1,NULL,NULL,0),(101,100,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(102,100,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,'{\"editor\":\"ace\",\"format\":\"json\",\"validator\":\"json\"}',1,1,'2015-09-09 12:58:27',1,'2016-04-29 08:00:26',0,1,NULL,NULL,0),(103,100,NULL,0,NULL,0,NULL,12,NULL,NULL,'order',NULL,NULL,NULL,NULL,'{\"indexed\":true}',1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(104,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'project_name_en',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-08-08 00:34:11',0,1,NULL,NULL,0),(105,90,NULL,0,NULL,0,NULL,97,NULL,NULL,'templateIcons',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:48:37',0,1,NULL,NULL,0),(106,90,NULL,0,NULL,0,NULL,97,NULL,NULL,'folder_templates',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(107,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'default_folder_template',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(108,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'default_file_template',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(109,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'default_task_template',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(110,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'default_language',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(111,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'languages',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(112,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'object_type_plugins',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(113,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'treeNodes',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(114,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'Tasks',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(115,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'Dbnode',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(116,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'RecycleBin',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2015-11-25 13:52:47',0,1,NULL,NULL,0),(117,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Create config options rule',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(118,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'files',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:53:55',NULL,NULL,0,1,NULL,NULL,0),(119,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'timezone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:55:28',NULL,NULL,0,1,NULL,NULL,0),(120,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'language_en',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:56:08',NULL,NULL,0,1,NULL,NULL,0),(121,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'language_fr',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:56:40',NULL,NULL,0,1,NULL,NULL,0),(122,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'language_ru',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:57:06',NULL,NULL,0,1,NULL,NULL,0),(123,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'default_facet_configs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:59:21',1,'2016-10-20 21:42:06',0,1,NULL,NULL,0),(124,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'node_facets',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:01:22',1,'2016-10-20 21:00:44',0,1,NULL,NULL,0),(125,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'default_object_plugins',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:04:38',1,'2016-04-29 08:15:53',0,1,NULL,NULL,0),(126,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'images_display_size',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:11:54',NULL,NULL,0,1,NULL,NULL,0),(127,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'default_DC',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:12:21',1,'2016-10-21 16:03:08',0,1,NULL,NULL,0),(128,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'default_availableViews',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:14:13',1,'2016-10-21 16:03:19',0,1,NULL,NULL,0),(129,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'DCConfigs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:17:58',NULL,NULL,0,1,NULL,NULL,0),(130,129,NULL,0,NULL,0,NULL,100,NULL,NULL,'dc_tasks',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:18:25',NULL,NULL,0,1,NULL,NULL,0),(131,129,NULL,0,NULL,0,NULL,100,NULL,NULL,'dc_tasks_closed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:20:58',NULL,NULL,0,1,NULL,NULL,0),(132,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'geoMapping',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:22:54',1,'2016-08-08 00:34:42',0,1,NULL,NULL,0),(133,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test Task',NULL,'2016-08-31 02:45:00',NULL,NULL,NULL,1,1,'2016-08-08 00:36:48',NULL,NULL,0,1,1,'2016-08-08 01:25:52',1),(134,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:39:37',NULL,NULL,0,1,1,'2016-12-08 17:47:48',1),(135,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:39:50',NULL,NULL,0,1,1,'2016-12-08 17:47:51',1),(136,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:40:05',1,'2016-09-29 15:47:22',0,1,NULL,NULL,0),(137,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'FEMA Tier',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:40:35',1,'2016-10-03 19:17:18',0,1,1,'2016-12-06 17:07:06',1),(138,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 3: Significant Unmet Needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:41:56',1,'2016-10-03 19:19:31',0,1,1,'2016-12-06 17:07:06',2),(139,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 4: Immediate and Long-Term Unmet Needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:42:15',1,'2016-10-03 19:20:01',0,1,1,'2016-12-06 17:07:06',2),(140,3,NULL,0,NULL,0,NULL,5,NULL,NULL,'Custom',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:44:19',1,'2016-08-08 00:44:41',0,1,NULL,NULL,0),(141,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Client',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:45:29',1,'2016-11-14 20:43:34',0,1,NULL,NULL,0),(142,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_firstname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:46:56',1,'2016-10-22 01:14:13',0,1,NULL,NULL,0),(143,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_lastname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:47:39',1,'2016-10-22 01:14:29',0,1,NULL,NULL,0),(144,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_header',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:48:26',1,'2016-09-29 16:22:20',0,1,1,'2016-09-29 19:09:13',1),(145,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_femacategory',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:50:25',1,'2016-08-08 00:53:26',0,1,1,'2016-09-29 15:20:38',1),(146,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Person SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:58:42',NULL,NULL,0,1,1,'2016-08-08 02:05:50',1),(147,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Person SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:58:54',NULL,NULL,0,1,1,'2016-08-08 09:42:46',1),(149,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'New Folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 01:26:49',NULL,NULL,0,1,1,'2016-12-08 17:48:09',1),(150,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'Clients',NULL,NULL,NULL,NULL,NULL,0,1,'2016-08-08 01:26:59',1,'2016-09-29 19:52:34',0,1,NULL,NULL,0),(152,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'This',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 01:41:35',NULL,NULL,0,1,NULL,NULL,0),(156,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 01:45:35',NULL,NULL,0,1,1,'2016-12-08 17:47:56',1),(157,150,NULL,0,NULL,0,NULL,7,NULL,NULL,'New Task',NULL,NULL,NULL,NULL,NULL,1,3,'2016-08-08 01:46:50',NULL,NULL,0,3,3,'2016-08-08 01:46:56',1),(160,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 02:03:17',NULL,NULL,0,1,1,'2016-10-17 19:28:32',1),(161,150,NULL,0,NULL,0,NULL,7,NULL,NULL,'Something',NULL,NULL,NULL,NULL,NULL,1,3,'2016-08-08 02:09:19',NULL,NULL,0,3,3,'2016-08-08 02:09:48',1),(167,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Gender',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:13',1,'2016-09-29 15:26:30',0,1,NULL,NULL,0),(168,136,NULL,0,NULL,0,NULL,5,NULL,NULL,'System folders',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:24',NULL,NULL,0,1,1,'2016-12-08 17:48:17',1),(169,168,NULL,0,NULL,0,NULL,5,NULL,NULL,'Surveys',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:36',NULL,NULL,0,1,1,'2016-12-08 17:48:17',2),(170,168,NULL,0,NULL,0,NULL,5,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:43',NULL,NULL,0,1,1,'2016-12-08 17:48:17',2),(172,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'TransportationAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:47:00',1,'2016-11-14 15:26:18',0,1,NULL,NULL,0),(173,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Client SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:48:22',1,'2016-12-05 21:41:45',0,1,NULL,NULL,0),(182,150,NULL,0,NULL,0,NULL,7,NULL,NULL,'New Task',NULL,NULL,NULL,NULL,NULL,1,3,'2016-08-20 20:49:03',NULL,NULL,0,3,1,'2016-10-18 20:03:46',1),(201,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'Folder',NULL,NULL,NULL,NULL,NULL,1,3,'2016-09-14 19:09:08',1,'2016-09-29 20:14:31',0,3,1,'2016-12-08 17:48:00',1),(205,3,NULL,0,NULL,0,NULL,11,NULL,NULL,'Case',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:07:13',NULL,NULL,0,1,1,'2016-12-08 17:47:37',1),(206,205,NULL,0,NULL,0,NULL,12,NULL,NULL,'contacts',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:16:22',1,'2016-09-20 20:21:21',0,1,1,'2016-12-08 17:47:37',2),(207,3,NULL,0,NULL,0,NULL,11,NULL,NULL,'Contact',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:16:56',NULL,NULL,0,1,1,'2016-12-08 17:47:41',1),(208,207,NULL,0,NULL,0,NULL,12,NULL,NULL,'FirstName',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:17:59',NULL,NULL,0,1,1,'2016-12-08 17:47:41',2),(209,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_middlename',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:19:18',1,'2016-10-22 01:14:40',0,1,NULL,NULL,0),(210,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_birthdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:20:15',1,'2016-12-06 17:10:30',0,1,NULL,NULL,0),(211,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:21:33',1,'2016-09-29 16:22:42',0,1,NULL,NULL,0),(212,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gender',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:25:22',1,'2016-10-21 19:25:02',0,1,NULL,NULL,0),(213,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'New Thesauri Item',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:25:44',NULL,NULL,0,1,1,'2016-09-29 15:28:48',1),(214,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Male',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:26:48',1,'2016-09-29 15:28:12',0,1,NULL,NULL,0),(215,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Female',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:28:40',NULL,NULL,0,1,NULL,NULL,0),(216,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transgendered Female to Male',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:08',NULL,NULL,0,1,1,'2016-10-21 15:04:24',1),(217,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transgendered Male to Female',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:21',NULL,NULL,0,1,1,'2016-10-21 15:04:20',1),(218,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:36',NULL,NULL,0,1,NULL,NULL,0),(219,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:45',NULL,NULL,0,1,NULL,NULL,0),(220,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Data Not Collected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:56',NULL,NULL,0,1,NULL,NULL,0),(221,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Contact Method',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:22',1,'2016-09-29 15:33:06',0,1,NULL,NULL,0),(222,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'Phone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:35',NULL,NULL,0,1,NULL,NULL,0),(223,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'Email',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:44',NULL,NULL,0,1,NULL,NULL,0),(224,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'Mail',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:56',NULL,NULL,0,1,NULL,NULL,0),(225,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'SMS',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:31:04',NULL,NULL,0,1,NULL,NULL,0),(226,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ethnicity',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:39:06',NULL,NULL,0,1,NULL,NULL,0),(227,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:39:18',NULL,NULL,0,1,NULL,NULL,0),(228,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:39:34',NULL,NULL,0,1,NULL,NULL,0),(229,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hispanic/Latino',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:13',NULL,NULL,0,1,NULL,NULL,0),(230,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Non Hispanic/Latino',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:25',NULL,NULL,0,1,NULL,NULL,0),(231,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:39',NULL,NULL,0,1,NULL,NULL,0),(232,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:52',NULL,NULL,0,1,NULL,NULL,0),(233,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Data Not Collected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:41:04',NULL,NULL,0,1,NULL,NULL,0),(234,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'American Indian Native or Alaska Native',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:45:29',NULL,NULL,0,1,NULL,NULL,0),(235,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Asian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:45:39',NULL,NULL,0,1,NULL,NULL,0),(236,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Black or African American',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:45:56',NULL,NULL,0,1,NULL,NULL,0),(237,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Native Hawaiian or Other Pacific Islander',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:16',NULL,NULL,0,1,NULL,NULL,0),(238,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'White',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:26',NULL,NULL,0,1,NULL,NULL,0),(239,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:41',NULL,NULL,0,1,NULL,NULL,0),(240,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:52',NULL,NULL,0,1,NULL,NULL,0),(241,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Data Not Collected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:47:08',NULL,NULL,0,1,NULL,NULL,0),(242,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'English',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:47:42',NULL,NULL,0,1,NULL,NULL,0),(243,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Spanish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:47:55',NULL,NULL,0,1,NULL,NULL,0),(244,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'French',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:52:24',NULL,NULL,0,1,NULL,NULL,0),(245,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'German',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:52:37',NULL,NULL,0,1,NULL,NULL,0),(246,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Italian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:09',NULL,NULL,0,1,NULL,NULL,0),(247,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Polish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:19',NULL,NULL,0,1,NULL,NULL,0),(248,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Portuguese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:35',NULL,NULL,0,1,NULL,NULL,0),(249,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Russian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:47',NULL,NULL,0,1,NULL,NULL,0),(250,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Arabic',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:00',NULL,NULL,0,1,NULL,NULL,0),(251,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Armenian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:11',NULL,NULL,0,1,NULL,NULL,0),(252,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Farsi',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:22',NULL,NULL,0,1,NULL,NULL,0),(253,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hebrew',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:32',NULL,NULL,0,1,NULL,NULL,0),(254,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Turkish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:46',NULL,NULL,0,1,NULL,NULL,0),(255,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Cantonese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:04',NULL,NULL,0,1,NULL,NULL,0),(256,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Mandarin',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:18',NULL,NULL,0,1,NULL,NULL,0),(257,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Mien',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:29',1,'2016-09-29 15:55:51',0,1,NULL,NULL,0),(258,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'American Sign Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:38',NULL,NULL,0,1,NULL,NULL,0),(259,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Cambodian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:56:46',NULL,NULL,0,1,NULL,NULL,0),(260,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Chinese Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:57:06',NULL,NULL,0,1,NULL,NULL,0),(261,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hmong',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:57:16',NULL,NULL,0,1,NULL,NULL,0),(262,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Lao',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:57:26',NULL,NULL,0,1,NULL,NULL,0),(263,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Thai',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:59:44',NULL,NULL,0,1,NULL,NULL,0),(264,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Vietnamese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:59:54',NULL,NULL,0,1,NULL,NULL,0),(265,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tagalog',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:04',NULL,NULL,0,1,NULL,NULL,0),(266,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ilocano',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:15',NULL,NULL,0,1,NULL,NULL,0),(267,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Japanese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:25',NULL,NULL,0,1,NULL,NULL,0),(268,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Korean',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:38',NULL,NULL,0,1,NULL,NULL,0),(269,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Samoan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:53',NULL,NULL,0,1,NULL,NULL,0),(270,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Sign Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:01:08',NULL,NULL,0,1,NULL,NULL,0),(271,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Non English',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:01:22',NULL,NULL,0,1,NULL,NULL,0),(272,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_emailaddress',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:08:22',1,'2016-09-29 18:56:31',0,1,NULL,NULL,0),(274,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ethnicity',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 18:57:28',1,'2016-10-21 16:27:58',0,1,NULL,NULL,0),(275,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 18:58:15',1,'2016-10-21 16:28:07',0,1,NULL,NULL,0),(276,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_primarylanguage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 18:58:59',1,'2016-09-29 19:08:58',0,1,NULL,NULL,0),(277,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_limitedenglish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:03:14',NULL,NULL,0,1,NULL,NULL,0),(278,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_specialatrisk',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:04:00',NULL,NULL,0,1,1,'2016-09-29 19:09:06',1),(279,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_disabilities',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:04:40',1,'2016-09-29 19:06:59',0,1,NULL,NULL,0),(280,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_domestic',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:05:13',1,'2016-09-29 19:07:14',0,1,NULL,NULL,0),(286,201,NULL,0,NULL,0,NULL,5,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:51:38',1,'2016-09-29 19:51:59',0,1,1,'2016-12-08 17:48:00',2),(287,201,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:51:46',NULL,NULL,0,1,1,'2016-12-08 17:48:00',2),(288,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'CasesByStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 20:26:24',1,'2016-10-04 02:24:14',0,1,NULL,NULL,0),(289,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FamilyMember',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:13:15',1,'2016-11-14 15:24:41',0,1,NULL,NULL,0),(290,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_firstname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:15:03',1,'2016-10-03 13:26:58',0,1,NULL,NULL,0),(291,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_lastname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:15:25',1,'2016-10-03 13:27:06',0,1,NULL,NULL,0),(292,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_birthdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:27:52',1,'2016-10-03 13:30:30',0,1,NULL,NULL,0),(293,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_age',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:28:23',1,'2016-10-03 13:37:16',0,1,NULL,NULL,0),(294,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gender',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:29:22',1,'2016-11-02 19:37:16',0,1,NULL,NULL,0),(295,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_relationship',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:30:03',1,'2016-10-03 13:37:05',0,1,NULL,NULL,0),(296,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_middlename',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:30:21',NULL,NULL,0,1,NULL,NULL,0),(297,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:31:45',1,'2016-10-03 13:37:32',0,1,NULL,NULL,0),(298,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ethnicity',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:32:30',1,'2016-10-21 16:25:13',0,1,NULL,NULL,0),(299,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Relationship',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:33:36',NULL,NULL,0,1,NULL,NULL,0),(300,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Parent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:33:55',NULL,NULL,0,1,NULL,NULL,0),(301,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Son',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:02',NULL,NULL,0,1,NULL,NULL,0),(302,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Daughter',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:11',NULL,NULL,0,1,NULL,NULL,0),(303,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Dependent Child',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:26',NULL,NULL,0,1,NULL,NULL,0),(304,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Grandparent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:37',NULL,NULL,0,1,NULL,NULL,0),(305,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Guardian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:46',NULL,NULL,0,1,NULL,NULL,0),(306,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Spouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:53',NULL,NULL,0,1,NULL,NULL,0),(307,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Family Member',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:02',NULL,NULL,0,1,NULL,NULL,0),(308,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Non-Family',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:11',NULL,NULL,0,1,NULL,NULL,0),(309,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Caretaker',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:19',NULL,NULL,0,1,NULL,NULL,0),(310,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ex Spouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:26',NULL,NULL,0,1,NULL,NULL,0),(311,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Address',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:46:09',1,'2016-11-14 15:22:24',0,1,NULL,NULL,0),(312,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addresstype',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:47:07',1,'2016-10-03 13:55:49',0,1,NULL,NULL,0),(313,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addressone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:47:53',1,'2016-10-22 02:20:48',0,1,NULL,NULL,0),(314,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addresstwo',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:48:01',1,'2016-10-21 13:42:18',0,1,NULL,NULL,0),(315,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_city',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:49:17',1,'2016-10-20 22:17:34',0,1,NULL,NULL,0),(316,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_state',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:50:10',1,'2016-10-21 01:45:36',0,1,NULL,NULL,0),(317,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_zip',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:50:40',NULL,NULL,0,1,NULL,NULL,0),(318,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_begindate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:51:11',NULL,NULL,0,1,NULL,NULL,0),(319,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_enddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:51:48',NULL,NULL,0,1,NULL,NULL,0),(320,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_primaryphone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:52:12',NULL,NULL,0,1,NULL,NULL,0),(321,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'AddressType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:52:35',NULL,NULL,0,1,NULL,NULL,0),(322,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Current Mailing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:09',NULL,NULL,0,1,NULL,NULL,0),(323,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Temporary',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:17',NULL,NULL,0,1,NULL,NULL,0),(324,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Summer',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:24',NULL,NULL,0,1,NULL,NULL,0),(325,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Previous Mailing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:33',NULL,NULL,0,1,NULL,NULL,0),(326,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergency',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:42',NULL,NULL,0,1,NULL,NULL,0),(327,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Business Address/Place of Employment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:54',NULL,NULL,0,1,NULL,NULL,0),(328,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Residential',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:04',NULL,NULL,0,1,NULL,NULL,0),(329,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transitional',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:14',NULL,NULL,0,1,NULL,NULL,0),(330,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Last Permanent Address',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:26',NULL,NULL,0,1,NULL,NULL,0),(331,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Permanent Supportive',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:38',NULL,NULL,0,1,NULL,NULL,0),(332,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Homeless in Area of Disaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:51',NULL,NULL,0,1,NULL,NULL,0),(333,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:11:39',1,'2016-10-03 14:14:18',0,1,NULL,NULL,0),(334,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'LivingArrangement',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:14:42',NULL,NULL,0,1,NULL,NULL,0),(335,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Owned house/condominium',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:14:58',NULL,NULL,0,1,NULL,NULL,0),(336,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rental house',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:07',NULL,NULL,0,1,NULL,NULL,0),(337,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rental apartment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:18',NULL,NULL,0,1,NULL,NULL,0),(338,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Staying with friends/family',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:30',NULL,NULL,0,1,NULL,NULL,0),(339,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Shelter (domestic violence, homeless, runaway and youth)',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:51',NULL,NULL,0,1,NULL,NULL,0),(340,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Military Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:01',NULL,NULL,0,1,NULL,NULL,0),(341,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Student dormitory',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:11',NULL,NULL,0,1,NULL,NULL,0),(342,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Group home or nursing home',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:23',NULL,NULL,0,1,NULL,NULL,0),(343,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Subsidized housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:33',NULL,NULL,0,1,NULL,NULL,0),(344,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Homeless',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:42',NULL,NULL,0,1,NULL,NULL,0),(345,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:49',NULL,NULL,0,1,NULL,NULL,0),(346,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'YesNoRefused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:10',NULL,NULL,0,1,NULL,NULL,0),(347,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:19',1,'2016-10-03 19:40:45',0,1,NULL,NULL,0),(348,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:27',1,'2016-10-03 19:40:59',0,1,NULL,NULL,0),(349,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:36',1,'2016-10-03 19:41:12',0,1,NULL,NULL,0),(350,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:44',1,'2016-10-03 19:41:24',0,1,NULL,NULL,0),(351,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InspectingAgent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:08',NULL,NULL,0,1,NULL,NULL,0),(352,351,NULL,0,NULL,0,NULL,8,NULL,NULL,'By an insurance adjustor',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:25',NULL,NULL,0,1,NULL,NULL,0),(353,351,NULL,0,NULL,0,NULL,8,NULL,NULL,'By a FEMA official',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:36',NULL,NULL,0,1,NULL,NULL,0),(354,351,NULL,0,NULL,0,NULL,8,NULL,NULL,'By a local government official',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:48',NULL,NULL,0,1,NULL,NULL,0),(355,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'DamageRating',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:13',NULL,NULL,0,1,NULL,NULL,0),(356,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Not Damaged',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:31',NULL,NULL,0,1,NULL,NULL,0),(357,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Minor',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:38',NULL,NULL,0,1,NULL,NULL,0),(358,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Major',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:44',NULL,NULL,0,1,NULL,NULL,0),(359,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Destroyed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:53',NULL,NULL,0,1,NULL,NULL,0),(360,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client doesn''t know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:04',NULL,NULL,0,1,NULL,NULL,0),(361,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:11',NULL,NULL,0,1,NULL,NULL,0),(362,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'Utilities',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:35',NULL,NULL,0,1,NULL,NULL,0),(363,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Electrical power',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:45',NULL,NULL,0,1,NULL,NULL,0),(364,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Phone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:56',NULL,NULL,0,1,NULL,NULL,0),(365,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Water',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:21:06',NULL,NULL,0,1,NULL,NULL,0),(366,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Gas',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:21:41',NULL,NULL,0,1,NULL,NULL,0),(367,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Internet access',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:21:52',NULL,NULL,0,1,NULL,NULL,0),(368,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Propane',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:02',NULL,NULL,0,1,NULL,NULL,0),(369,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Fuel oil',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:12',NULL,NULL,0,1,NULL,NULL,0),(370,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Steam heat',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:21',NULL,NULL,0,1,NULL,NULL,0),(371,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Sewer and Sanitation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:33',NULL,NULL,0,1,NULL,NULL,0),(372,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InsuranceStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:56',NULL,NULL,0,1,NULL,NULL,0),(373,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client owned home and had homeowner''s insurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:23:36',NULL,NULL,0,1,NULL,NULL,0),(374,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client rented home and had renter''s insurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:23:49',NULL,NULL,0,1,NULL,NULL,0),(375,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client had hazard-specific insurance for disaster type (food, fire, earthquake)',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:09',NULL,NULL,0,1,NULL,NULL,0),(376,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Lack of appropriate Insurance Coverage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:22',NULL,NULL,0,1,NULL,NULL,0),(377,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client does not know insurance status',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:34',NULL,NULL,0,1,NULL,NULL,0),(378,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client was insured but does not have insurance policy information',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:49',NULL,NULL,0,1,NULL,NULL,0),(379,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client was uninsured',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:58',NULL,NULL,0,1,NULL,NULL,0),(380,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'HousingServiceType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:31:51',NULL,NULL,0,1,NULL,NULL,0),(381,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergency Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:03',NULL,NULL,0,1,NULL,NULL,0),(382,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:14',NULL,NULL,0,1,NULL,NULL,0),(383,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Bednight',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:25',NULL,NULL,0,1,NULL,NULL,0),(384,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Placement',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:36',NULL,NULL,0,1,NULL,NULL,0),(385,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Reservation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:50',NULL,NULL,0,1,NULL,NULL,0),(386,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tarp / Blue Roof',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:33:02',NULL,NULL,0,1,NULL,NULL,0),(387,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Temporary Housing and Other Financial Aid',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:33:21',NULL,NULL,0,1,NULL,NULL,0),(388,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transitional Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:33:33',NULL,NULL,0,1,NULL,NULL,0),(389,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'IncomeGroup',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:34:58',NULL,NULL,0,1,NULL,NULL,0),(390,389,NULL,0,NULL,0,NULL,8,NULL,NULL,'Cash Income',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:35:08',NULL,NULL,0,1,NULL,NULL,0),(391,389,NULL,0,NULL,0,NULL,8,NULL,NULL,'Non-cash benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:35:17',NULL,NULL,0,1,NULL,NULL,0),(392,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'TransportationMode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:41:42',NULL,NULL,0,1,NULL,NULL,0),(393,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Privately owned vehicle or motorcycle',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:00',NULL,NULL,0,1,NULL,NULL,0),(394,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Public Transit',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:10',NULL,NULL,0,1,NULL,NULL,0),(395,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Paratransit',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:18',NULL,NULL,0,1,NULL,NULL,0),(396,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Carshare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:26',NULL,NULL,0,1,NULL,NULL,0),(397,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ride with friends/family',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:36',NULL,NULL,0,1,NULL,NULL,0),(398,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Bike',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:43',NULL,NULL,0,1,NULL,NULL,0),(399,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Walk',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:50',NULL,NULL,0,1,NULL,NULL,0),(400,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:58',NULL,NULL,0,1,NULL,NULL,0),(401,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'TransportationNeed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:21',NULL,NULL,0,1,NULL,NULL,0),(402,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Vehicle lost/destroyed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:37',NULL,NULL,0,1,NULL,NULL,0),(403,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Public transit not working',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:46',NULL,NULL,0,1,NULL,NULL,0),(404,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Paratransit not working/accessible',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:58',NULL,NULL,0,1,NULL,NULL,0),(405,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Road closure/damage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:07',NULL,NULL,0,1,NULL,NULL,0),(406,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Unable to afford gas',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:17',NULL,NULL,0,1,NULL,NULL,0),(407,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Unable to afford transit fare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:29',NULL,NULL,0,1,NULL,NULL,0),(408,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Unable to afford gas dependably',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:51',NULL,NULL,0,1,NULL,NULL,0),(409,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Accessible vehicle not available',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:45:06',NULL,NULL,0,1,NULL,NULL,0),(410,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'PaymentStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:01',NULL,NULL,0,1,NULL,NULL,0),(411,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'EmploymentTenure',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:08',1,'2016-10-03 14:52:51',0,1,NULL,NULL,0),(412,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Received Payment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:21',NULL,NULL,0,1,NULL,NULL,0),(413,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Denied',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:29',NULL,NULL,0,1,NULL,NULL,0),(414,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pending Payment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:39',NULL,NULL,0,1,NULL,NULL,0),(415,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pending Decision',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:49',NULL,NULL,0,1,NULL,NULL,0),(416,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InsuranceType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:12',NULL,NULL,0,1,NULL,NULL,0),(417,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Private',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:23',NULL,NULL,0,1,NULL,NULL,0),(418,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Medicare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:31',NULL,NULL,0,1,NULL,NULL,0),(419,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Medicaid',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:41',NULL,NULL,0,1,NULL,NULL,0),(420,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'State Children''s Health Insurance Program S-CHIP',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:55',NULL,NULL,0,1,NULL,NULL,0),(421,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Military Insurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:49:04',NULL,NULL,0,1,NULL,NULL,0),(422,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Public',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:49:13',NULL,NULL,0,1,NULL,NULL,0),(423,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'CaseNoteType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:51:22',NULL,NULL,0,1,1,'2016-10-03 14:51:31',1),(424,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Permanent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:25',NULL,NULL,0,1,NULL,NULL,0),(425,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Temporary',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:34',NULL,NULL,0,1,NULL,NULL,0),(426,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Seasonal',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:42',NULL,NULL,0,1,NULL,NULL,0),(427,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:50',NULL,NULL,0,1,NULL,NULL,0),(428,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:57',NULL,NULL,0,1,NULL,NULL,0),(429,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'AssessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:54:31',NULL,NULL,0,1,NULL,NULL,0),(430,429,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pre-Disaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:54:53',NULL,NULL,0,1,NULL,NULL,0),(431,429,NULL,0,NULL,0,NULL,8,NULL,NULL,'Post-Disaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:55:02',NULL,NULL,0,1,NULL,NULL,0),(432,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:01:47',1,'2016-10-28 19:48:28',0,1,NULL,NULL,0),(433,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_primarymode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:02:41',1,'2016-11-14 20:56:51',0,1,NULL,NULL,0),(434,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_methodworking',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:03:20',1,'2016-11-10 16:30:25',0,1,NULL,NULL,0),(435,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ifnotworking',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:04:30',1,'2016-11-14 20:57:08',0,1,NULL,NULL,0),(436,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insured',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:04:59',NULL,NULL,0,1,NULL,NULL,0),(437,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_receivedpayment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:05:32',NULL,NULL,0,1,NULL,NULL,0),(438,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_damagedindisaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:06:11',NULL,NULL,0,1,NULL,NULL,0),(439,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_transportationneeds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:06:45',1,'2016-10-08 23:59:11',0,1,NULL,NULL,0),(440,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'HousingAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:08:29',1,'2016-11-14 15:25:24',0,1,NULL,NULL,0),(441,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:31:44',1,'2016-10-28 19:47:52',0,1,NULL,NULL,0),(442,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_predisasterliving',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:32:29',NULL,NULL,0,1,NULL,NULL,0),(443,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_damagedhouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:33:27',NULL,NULL,0,1,NULL,NULL,0),(444,443,NULL,0,NULL,0,NULL,12,NULL,NULL,'_inspectedhouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:34:12',1,'2016-11-04 14:55:53',0,1,NULL,NULL,0),(445,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_accessiblehouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:34:44',1,'2016-10-03 15:36:03',0,1,NULL,NULL,0),(446,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_livablehouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:35:28',1,'2016-10-03 15:35:52',0,1,NULL,NULL,0),(447,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientdamagerating',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:36:30',NULL,NULL,0,1,NULL,NULL,0),(448,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientrelocated',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:37:06',NULL,NULL,0,1,NULL,NULL,0),(449,448,NULL,0,NULL,0,NULL,12,NULL,NULL,'_planstoreturn',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:37:35',1,'2016-11-14 20:55:02',0,1,NULL,NULL,0),(450,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_utilitieswork',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:38:12',1,'2016-11-14 20:53:58',0,1,NULL,NULL,0),(451,450,NULL,0,NULL,0,NULL,12,NULL,NULL,'_utilitiesnotworking',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:38:48',1,'2016-11-04 14:52:53',0,1,NULL,NULL,0),(452,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_disasterImpacts',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:39:23',NULL,NULL,0,1,NULL,NULL,0),(453,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_predisasterinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:40:02',NULL,NULL,0,1,NULL,NULL,0),(454,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insurancedetails',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:40:35',NULL,NULL,0,1,NULL,NULL,0),(455,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FinancialAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:42:05',1,'2016-11-14 15:24:50',0,1,NULL,NULL,0),(456,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:42:30',1,'2016-10-28 19:47:12',0,1,NULL,NULL,0),(457,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:43:35',1,'2016-11-14 20:51:48',0,1,NULL,NULL,0),(458,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_incomereceived',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:43:58',1,'2016-11-14 20:51:27',0,1,NULL,NULL,0),(459,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_noncashbenefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:44:28',1,'2016-11-14 20:51:03',0,1,NULL,NULL,0),(460,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_incomeGroup',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:44:54',NULL,NULL,0,1,NULL,NULL,0),(461,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_noncashbenefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:46:01',NULL,NULL,0,1,NULL,NULL,0),(462,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_earnedIncome',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:46:26',NULL,NULL,0,1,NULL,NULL,0),(463,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_unemploymentinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:46:56',NULL,NULL,0,1,NULL,NULL,0),(464,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ssi',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:47:26',NULL,NULL,0,1,NULL,NULL,0),(465,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ssdi',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:47:49',NULL,NULL,0,1,NULL,NULL,0),(466,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_veteransdisability',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:48:24',NULL,NULL,0,1,NULL,NULL,0),(467,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'MonthlyExpensesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:50:40',1,'2016-11-14 15:25:42',0,1,NULL,NULL,0),(468,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentorder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:50:58',NULL,NULL,0,1,1,'2016-10-03 15:51:19',1),(469,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:51:21',1,'2016-10-28 19:48:10',0,1,NULL,NULL,0),(470,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:51:21',1,'2016-11-14 20:56:05',0,1,NULL,NULL,0),(471,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_rent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:54:47',1,'2016-12-06 17:33:16',0,1,NULL,NULL,0),(472,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_mortgage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:55:03',1,'2016-12-06 17:23:15',0,1,NULL,NULL,0),(473,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_maintenance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:55:28',1,'2016-12-06 17:23:49',0,1,NULL,NULL,0),(474,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_carpayment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:55:47',1,'2016-12-06 17:26:31',0,1,NULL,NULL,0),(475,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_carinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:56:28',1,'2016-12-06 17:26:22',0,1,NULL,NULL,0),(476,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gasoline',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:56:56',1,'2016-12-06 17:26:15',0,1,NULL,NULL,0),(477,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_medical',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:57:21',1,'2016-12-06 17:26:06',0,1,NULL,NULL,0),(478,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_food',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:57:35',1,'2016-12-06 17:25:58',0,1,NULL,NULL,0),(479,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_miscellaneous',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:57:54',1,'2016-12-06 17:25:49',0,1,NULL,NULL,0),(480,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_totalExpenses',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:58:12',1,'2016-12-06 17:22:20',0,1,NULL,NULL,0),(481,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_totalmonthlyamount',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:58:47',1,'2016-12-06 17:21:36',0,1,NULL,NULL,0),(482,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'EmploymentAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:59:58',1,'2016-11-14 15:24:30',0,1,NULL,NULL,0),(483,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:00:08',1,'2016-10-28 19:46:56',0,1,NULL,NULL,0),(484,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:00:08',1,'2016-11-14 20:50:31',0,1,NULL,NULL,0),(485,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_employed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:00:45',1,'2016-11-02 19:37:01',0,1,NULL,NULL,0),(486,485,NULL,0,NULL,0,NULL,12,NULL,NULL,'_hoursworked',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:01:08',1,'2016-11-04 17:34:45',0,1,NULL,NULL,0),(487,485,NULL,0,NULL,0,NULL,12,NULL,NULL,'_employmenttenure',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:01:53',1,'2016-11-04 17:35:48',0,1,NULL,NULL,0),(488,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_additionalemployment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:02:36',1,'2016-11-02 19:36:55',0,1,NULL,NULL,0),(489,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'HealthInsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:03:31',1,'2016-11-14 15:25:16',0,1,NULL,NULL,0),(490,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:03:59',NULL,NULL,0,1,NULL,NULL,0),(491,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insuranceType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:05:05',NULL,NULL,0,1,NULL,NULL,0),(492,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_isPrimary',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:06:03',1,'2016-11-02 19:39:54',0,1,NULL,NULL,0),(493,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_medscovered',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:06:23',1,'2016-11-02 19:39:48',0,1,NULL,NULL,0),(494,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_dmecovered',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:06:58',1,'2016-11-02 19:40:12',0,1,NULL,NULL,0),(495,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insurancestatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:07:35',1,'2016-10-03 16:12:39',0,1,NULL,NULL,0),(496,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insurancelostdisaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:08:11',1,'2016-11-02 19:40:05',0,1,NULL,NULL,0),(497,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_whatcausedinsuranceloss',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:08:52',NULL,NULL,0,1,NULL,NULL,0),(498,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_startdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:09:06',NULL,NULL,0,1,NULL,NULL,0),(499,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_enddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:09:19',NULL,NULL,0,1,NULL,NULL,0),(500,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_appliedfordate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:09:34',NULL,NULL,0,1,NULL,NULL,0),(501,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InsuranceStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:11:50',NULL,NULL,0,1,NULL,NULL,0),(502,501,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pending/Applied',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:12:04',NULL,NULL,0,1,NULL,NULL,0),(503,501,NULL,0,NULL,0,NULL,8,NULL,NULL,'Active',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:12:12',NULL,NULL,0,1,NULL,NULL,0),(504,501,NULL,0,NULL,0,NULL,8,NULL,NULL,'Inactive',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:12:19',NULL,NULL,0,1,NULL,NULL,0),(505,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FoodAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:16:09',1,'2016-11-14 15:24:58',0,1,NULL,NULL,0),(506,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:16:28',1,'2016-10-28 19:47:21',0,1,NULL,NULL,0),(507,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_enoughfood',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:16:54',1,'2016-11-02 19:38:22',0,1,NULL,NULL,0),(508,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_predisasterassistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:17:30',1,'2016-11-02 19:38:16',0,1,NULL,NULL,0),(509,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_requestedfood',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:18:00',1,'2016-11-02 19:38:01',0,1,NULL,NULL,0),(510,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'BehavioralHealthAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:19:16',1,'2016-11-14 15:23:32',0,1,NULL,NULL,0),(511,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:20:01',1,'2016-10-28 19:46:20',0,1,NULL,NULL,0),(512,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_indistress',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:20:30',1,'2016-11-02 18:56:35',0,1,NULL,NULL,0),(513,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_liketospeak',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:22:35',1,'2016-11-02 18:56:15',0,1,NULL,NULL,0),(514,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_feelsafe',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:22:55',1,'2016-11-02 18:56:51',0,1,NULL,NULL,0),(515,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_hurtingyourselfothers',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:23:29',1,'2016-11-02 18:56:43',0,1,NULL,NULL,0),(516,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'FoodHelp',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:24:25',NULL,NULL,0,1,NULL,NULL,0),(517,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Woman Infants & Children (WIC) Benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:24:50',NULL,NULL,0,1,NULL,NULL,0),(518,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Supplemental Nutrition Assistance Program (SNAP)',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:06',NULL,NULL,0,1,NULL,NULL,0),(519,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance from local food pantries/food banks',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:22',NULL,NULL,0,1,NULL,NULL,0),(520,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Meals on wheels',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:32',NULL,NULL,0,1,NULL,NULL,0),(521,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:41',NULL,NULL,0,1,NULL,NULL,0),(522,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'CaseNoteType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:34:42',NULL,NULL,0,1,NULL,NULL,0),(523,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Education',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:34:53',NULL,NULL,0,1,NULL,NULL,0),(524,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Employment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:35:01',NULL,NULL,0,1,NULL,NULL,0),(525,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Skills Building',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:35:12',NULL,NULL,0,1,NULL,NULL,0),(526,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:35:23',NULL,NULL,0,1,NULL,NULL,0),(527,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'CaseNote',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:50:16',1,'2016-11-14 15:23:55',0,1,NULL,NULL,0),(528,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_entrydate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:51:53',1,'2016-10-24 14:23:31',0,1,NULL,NULL,0),(529,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_regarding',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:52:06',1,'2016-10-03 16:54:37',0,1,NULL,NULL,0),(530,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_regarding',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:52:13',NULL,NULL,0,1,1,'2016-10-18 16:16:46',1),(531,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_notetype',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:52:32',1,'2016-12-07 05:23:15',0,1,NULL,NULL,0),(532,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_casenote',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:53:51',1,'2016-10-03 16:54:20',0,1,NULL,NULL,0),(533,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'ChildAssesment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:55:23',1,'2016-11-14 15:24:05',0,1,NULL,NULL,0),(534,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:56:18',1,'2016-10-28 19:46:35',0,1,NULL,NULL,0),(535,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childrenunder18',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:57:02',NULL,NULL,0,1,NULL,NULL,0),(536,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fostercare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:57:38',NULL,NULL,0,1,1,'2016-10-21 14:00:50',1),(537,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fostercare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:57:53',1,'2016-11-14 20:53:16',0,1,NULL,NULL,0),(538,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_headstart',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:58:37',1,'2016-11-04 17:25:53',0,1,NULL,NULL,0),(539,538,NULL,0,NULL,0,NULL,12,NULL,NULL,'_servicesdisrupted',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:59:15',1,'2016-11-04 17:16:42',0,1,NULL,NULL,0),(540,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childcareneed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:59:41',1,'2016-11-04 17:26:50',0,1,NULL,NULL,0),(541,540,NULL,0,NULL,0,NULL,12,NULL,NULL,'_priorvoucher',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:00:11',1,'2016-11-04 17:22:41',0,1,NULL,NULL,0),(542,540,NULL,0,NULL,0,NULL,12,NULL,NULL,'_barrierstochildcare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:00:46',1,'2016-11-15 14:23:50',0,1,NULL,NULL,0),(543,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childsupportpre',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:01:17',1,'2016-11-14 20:40:49',0,1,NULL,NULL,0),(544,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_responsibleforchildsupoprt',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:01:47',1,'2016-11-02 18:57:42',0,1,NULL,NULL,0),(545,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_paymentsdelayed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:02:08',1,'2016-11-02 18:58:03',0,1,NULL,NULL,0),(546,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childsupportpost',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:04:45',1,'2016-11-14 20:41:01',0,1,NULL,NULL,0),(547,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_kidsinschool',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:05:21',1,'2016-11-04 17:25:39',0,1,NULL,NULL,0),(548,547,NULL,0,NULL,0,NULL,12,NULL,NULL,'_sameschoolpostdisaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:06:11',1,'2016-11-04 17:18:00',0,1,NULL,NULL,0),(549,547,NULL,0,NULL,0,NULL,12,NULL,NULL,'_needhelpregistering',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:06:45',1,'2016-11-04 17:18:37',0,1,NULL,NULL,0),(550,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_missedimmunizations',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:07:19',1,'2016-11-04 17:25:13',0,1,NULL,NULL,0),(551,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_copingconcerns',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:07:43',1,'2016-11-04 17:26:31',0,1,NULL,NULL,0),(552,551,NULL,0,NULL,0,NULL,12,NULL,NULL,'_copingexplanations',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:08:05',1,'2016-11-04 17:15:04',0,1,NULL,NULL,0),(553,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'ClothingAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:52:21',1,'2016-11-14 15:24:21',0,1,NULL,NULL,0),(554,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:52:42',1,'2016-10-28 19:46:46',0,1,NULL,NULL,0),(555,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_anyoneloseclothing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:53:13',1,'2016-11-02 19:36:37',0,1,NULL,NULL,0),(556,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_usableclothing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:54:46',1,'2016-11-02 19:36:08',0,1,NULL,NULL,0),(557,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_coldweather',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:55:33',1,'2016-11-02 19:36:30',0,1,NULL,NULL,0),(558,555,NULL,0,NULL,0,NULL,12,NULL,NULL,'_makeclaim',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:56:05',1,'2016-11-04 13:21:45',0,1,NULL,NULL,0),(559,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FurnitureAndAppliancesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:57:08',1,'2016-11-14 15:25:06',0,1,NULL,NULL,0),(560,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:57:32',1,'2016-10-28 19:47:31',0,1,NULL,NULL,0),(561,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_anythingdestroyed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:58:06',1,'2016-11-02 19:38:57',0,1,NULL,NULL,0),(562,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_refrigerator',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:58:58',1,'2016-11-04 17:31:46',0,1,NULL,NULL,0),(563,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_stove',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:59:12',1,'2016-11-04 17:31:40',0,1,NULL,NULL,0),(564,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_beds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:59:33',1,'2016-11-04 17:30:45',0,1,NULL,NULL,0),(565,564,NULL,0,NULL,0,NULL,12,NULL,NULL,'_numberofbeds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:00:05',1,'2016-11-04 17:31:22',0,1,NULL,NULL,0),(566,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_numberofbeds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:00:14',NULL,NULL,0,1,1,'2016-10-21 14:38:10',1),(567,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_claimforfurniture',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:00:47',1,'2016-11-04 17:30:25',0,1,NULL,NULL,0),(568,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_replacementitemsreceived',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:01:20',1,'2016-11-04 17:29:40',0,1,NULL,NULL,0),(569,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_abletoinstall',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:01:58',1,'2016-11-04 17:30:13',0,1,NULL,NULL,0),(570,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ReferralService',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:30:29',NULL,NULL,0,1,NULL,NULL,0),(571,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance identifying private legal counsel',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:32:25',NULL,NULL,0,1,NULL,NULL,0),(572,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with D-Snap application',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:32:38',NULL,NULL,0,1,NULL,NULL,0),(573,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with insurance claim/appeal',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:32:52',NULL,NULL,0,1,NULL,NULL,0),(574,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Bus Tokens',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:02',NULL,NULL,0,1,NULL,NULL,0),(575,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Counseling-Alcohol',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:19',NULL,NULL,0,1,NULL,NULL,0),(576,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergency Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:44',NULL,NULL,0,1,NULL,NULL,0),(577,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Laundry Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:58',NULL,NULL,0,1,NULL,NULL,0),(578,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to community organizations for food needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:13',NULL,NULL,0,1,NULL,NULL,0),(579,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to faith-based/community organizations for clothing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:29',NULL,NULL,0,1,NULL,NULL,0),(580,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rental Assitance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:40',NULL,NULL,0,1,NULL,NULL,0),(581,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Social Services for WIC/SNAP',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:51',NULL,NULL,0,1,NULL,NULL,0),(582,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with accessing VA benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:36:49',NULL,NULL,0,1,NULL,NULL,0),(583,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with FEMA ONA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:00',NULL,NULL,0,1,NULL,NULL,0),(584,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Bus Pass',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:07',NULL,NULL,0,1,NULL,NULL,0),(585,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Case Management',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:16',NULL,NULL,0,1,NULL,NULL,0),(586,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Disaster Case Management',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:30',NULL,NULL,0,1,NULL,NULL,0),(587,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Healthcare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:41',NULL,NULL,0,1,NULL,NULL,0),(588,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Prenatal Care',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:50',NULL,NULL,0,1,NULL,NULL,0),(589,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to faith-based/community organizations for replacement',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:38:10',NULL,NULL,0,1,NULL,NULL,0),(590,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to mass care for immediate food needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:38:40',NULL,NULL,0,1,NULL,NULL,0),(591,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Restoration of pre-disaster Meals on Wheels services',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:38:54',NULL,NULL,0,1,NULL,NULL,0),(592,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transportation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:39:02',NULL,NULL,0,1,NULL,NULL,0),(593,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ReferralStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:39:27',NULL,NULL,0,1,NULL,NULL,0),(594,593,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral Made',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:39:56',1,'2016-10-03 18:40:33',0,1,NULL,NULL,0),(595,593,NULL,0,NULL,0,NULL,8,NULL,NULL,'Not Eligible',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:40:08',NULL,NULL,0,1,NULL,NULL,0),(596,593,NULL,0,NULL,0,NULL,8,NULL,NULL,'Resources Not Available',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:40:20',NULL,NULL,0,1,NULL,NULL,0),(597,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ReferralResult',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:02',NULL,NULL,0,1,NULL,NULL,0),(598,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'ServiceProvided',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:18',NULL,NULL,0,1,NULL,NULL,0),(599,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'Information Only',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:26',NULL,NULL,0,1,NULL,NULL,0),(600,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rejected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:34',NULL,NULL,0,1,NULL,NULL,0),(601,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'No Show',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:43',NULL,NULL,0,1,NULL,NULL,0),(602,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'UnitOfMeasure',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:48:39',NULL,NULL,0,1,NULL,NULL,0),(603,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Dollars',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:48:57',NULL,NULL,0,1,NULL,NULL,0),(604,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Minutes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:07',NULL,NULL,0,1,NULL,NULL,0),(605,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Count',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:14',NULL,NULL,0,1,NULL,NULL,0),(606,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hours',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:21',NULL,NULL,0,1,NULL,NULL,0),(607,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:54',1,'2016-11-14 15:25:51',0,1,NULL,NULL,0),(608,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referraldate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:50:22',NULL,NULL,0,1,NULL,NULL,0),(609,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:51:00',1,'2016-10-03 19:13:00',0,1,NULL,NULL,0),(610,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_provider',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:51:40',NULL,NULL,0,1,NULL,NULL,0),(611,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_provider',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:52:15',NULL,NULL,0,1,NULL,NULL,0),(612,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_streetaddress',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:52:33',1,'2016-10-03 18:52:47',0,1,NULL,NULL,0),(613,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_zipcode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:04',NULL,NULL,0,1,NULL,NULL,0),(614,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_city',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:13',NULL,NULL,0,1,NULL,NULL,0),(615,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_state',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:37',NULL,NULL,0,1,NULL,NULL,0),(616,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_geocode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:53',NULL,NULL,0,1,NULL,NULL,0),(617,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralstatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:54:41',1,'2016-10-03 19:13:16',0,1,NULL,NULL,0),(618,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_comments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:54:58',NULL,NULL,0,1,NULL,NULL,0),(619,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_associatedneed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:55:23',NULL,NULL,0,1,NULL,NULL,0),(620,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_voucherinformation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:59:04',NULL,NULL,0,1,NULL,NULL,0),(621,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_vouchernumber',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:59:25',NULL,NULL,0,1,NULL,NULL,0),(622,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_voucheruom',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:02:11',1,'2016-10-03 19:13:42',0,1,NULL,NULL,0),(623,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_voucherunits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:02:32',NULL,NULL,0,1,NULL,NULL,0),(624,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_unitvalue',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:02:52',NULL,NULL,0,1,NULL,NULL,0),(625,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_vouchertotal',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:03:27',NULL,NULL,0,1,NULL,NULL,0),(626,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_informationrelease',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:05:33',NULL,NULL,0,1,NULL,NULL,0),(627,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_emailauthorized',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:05:53',NULL,NULL,0,1,NULL,NULL,0),(628,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referraloutcome',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:06:59',NULL,NULL,0,1,NULL,NULL,0),(629,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_dateacknowledged',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:07:22',NULL,NULL,0,1,NULL,NULL,0),(630,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_appointmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:07:37',NULL,NULL,0,1,NULL,NULL,0),(631,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_appointmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:07:50',NULL,NULL,0,1,NULL,NULL,0),(632,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_resultdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:08:06',NULL,NULL,0,1,NULL,NULL,0),(633,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_result',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:08:29',1,'2016-10-03 19:12:37',0,1,NULL,NULL,0),(634,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fematier',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:15:04',1,'2016-10-04 02:15:39',0,1,1,'2016-12-06 17:08:47',1),(635,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 1: Immediate Needs Met',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:18:21',NULL,NULL,0,1,1,'2016-12-06 17:07:06',2),(636,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 2: Some Remaining Unmet Needs or in Current Rebuild/Repair Status',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:18:24',1,'2016-10-03 19:18:53',0,1,1,'2016-12-06 17:07:06',2),(642,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'New Folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:53:59',NULL,NULL,0,1,1,'2016-12-08 17:48:12',1),(643,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientstatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:12:24',1,'2016-10-04 02:15:59',0,1,1,'2016-12-06 17:08:43',1),(644,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ClientStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:13:13',NULL,NULL,0,1,1,'2016-12-06 17:07:20',1),(645,644,NULL,0,NULL,0,NULL,8,NULL,NULL,'Open',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:13:28',NULL,NULL,0,1,1,'2016-12-06 17:07:20',2),(646,644,NULL,0,NULL,0,NULL,8,NULL,NULL,'Closed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:13:33',NULL,NULL,0,1,1,'2016-12-06 17:07:20',2),(651,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'SeniorServicesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:04:35',1,'2016-11-14 15:26:00',0,1,NULL,NULL,0),(652,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:05:01',1,'2016-10-28 19:48:18',0,1,NULL,NULL,0),(653,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_priorseniorliving',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:05:54',1,'2016-11-02 19:41:54',0,1,NULL,NULL,0),(654,653,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientdisplaced',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:07:18',1,'2016-11-04 13:26:19',0,1,NULL,NULL,0),(655,654,NULL,0,NULL,0,NULL,12,NULL,NULL,'_explaincircumstances',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:08:02',1,'2016-11-04 13:26:37',0,1,NULL,NULL,0),(656,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'LanguageAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:08:51',1,'2016-11-14 15:25:32',0,1,NULL,NULL,0),(657,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:11:30',1,'2016-10-28 19:48:00',0,1,NULL,NULL,0),(658,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'New Field',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:28',NULL,NULL,0,1,1,'2016-10-09 00:13:04',1),(659,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_priorlanguage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:57',1,'2016-10-09 00:13:22',0,1,NULL,NULL,0),(660,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_currentlyhavinglanguage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:57',1,'2016-11-02 19:41:16',0,1,NULL,NULL,0),(661,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_lostlanguageservices',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:57',1,'2016-11-02 19:40:55',0,1,NULL,NULL,0),(663,129,NULL,0,NULL,0,NULL,100,NULL,NULL,'dc_cases_fema',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 21:01:34',NULL,NULL,0,1,NULL,NULL,0),(665,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Will Goes to Hollywood',NULL,'2016-10-17 08:15:00',NULL,NULL,NULL,1,1,'2016-10-13 14:36:16',NULL,NULL,0,1,1,'2016-10-17 19:28:27',1),(666,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'FEMA Tier 1',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-13 14:37:17',1,'2016-10-13 14:37:56',0,1,1,'2016-12-08 17:47:44',1),(667,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-13 14:38:06',NULL,NULL,0,1,1,'2016-12-08 17:48:20',1),(668,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'Services',NULL,NULL,NULL,NULL,NULL,0,1,'2016-10-14 03:57:53',1,'2016-10-21 14:17:09',0,1,NULL,NULL,0),(669,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Service',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 03:59:17',1,'2016-11-14 15:26:10',0,1,NULL,NULL,0),(670,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_name',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 03:59:37',NULL,NULL,0,1,NULL,NULL,0),(671,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_address',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 03:59:53',NULL,NULL,0,1,NULL,NULL,0),(672,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_notes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 04:00:19',NULL,NULL,0,1,NULL,NULL,0),(674,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'Backup',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-17 19:38:44',1,'2016-10-17 19:39:01',0,1,1,'2016-12-08 17:47:34',1),(678,150,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-17 19:46:43',NULL,NULL,0,1,1,'2016-10-18 17:49:28',1),(679,150,NULL,2,NULL,0,NULL,9,NULL,NULL,'Test2',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-17 19:46:47',NULL,NULL,0,1,1,'2016-10-18 17:49:26',1),(680,150,NULL,2,NULL,0,NULL,9,NULL,NULL,'Sup',NULL,NULL,NULL,NULL,NULL,1,6,'2016-10-17 19:47:06',NULL,NULL,0,6,6,'2016-10-21 16:23:15',1),(681,150,NULL,0,NULL,0,NULL,7,NULL,NULL,'Will Test',NULL,'2016-10-17 01:45:00',NULL,NULL,NULL,1,1,'2016-10-17 19:48:17',NULL,NULL,0,1,1,'2016-10-20 16:03:33',1),(683,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:42:11',1,'2016-10-21 15:51:40',0,1,NULL,NULL,0),(684,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:44:19',1,'2016-10-21 15:20:05',0,1,NULL,NULL,0),(685,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'YesNo',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:46:08',NULL,NULL,0,1,NULL,NULL,0),(686,685,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:46:22',NULL,NULL,0,1,NULL,NULL,0),(687,685,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:46:29',NULL,NULL,0,1,NULL,NULL,0),(703,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'New Field',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 16:42:31',NULL,NULL,0,1,1,'2016-10-18 16:42:52',1),(704,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 16:45:24',NULL,NULL,0,1,1,'2016-12-08 17:48:03',1),(706,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'New Task',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 16:56:16',NULL,NULL,0,1,1,'2016-10-21 00:37:42',1),(713,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Will',NULL,'2016-10-18 00:45:00',NULL,NULL,NULL,1,1,'2016-10-18 19:46:42',NULL,NULL,0,1,1,'2016-10-21 00:37:42',1),(718,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_name',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-20 18:36:01',1,'2016-10-21 12:56:47',0,1,NULL,NULL,0),(721,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test Task',NULL,'2016-10-20 01:15:00',NULL,NULL,NULL,1,1,'2016-10-20 19:52:11',1,'2016-10-20 19:55:30',0,1,1,'2016-10-21 00:37:42',1),(722,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_latlon',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-20 20:15:35',1,'2016-10-20 22:17:20',0,1,NULL,NULL,0),(732,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'dsafdsaf',NULL,NULL,NULL,NULL,NULL,1,3,'2016-10-21 00:36:55',NULL,NULL,0,3,NULL,NULL,0),(733,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'test',NULL,'2016-10-20 00:00:00',NULL,NULL,NULL,1,1,'2016-10-21 00:38:18',NULL,NULL,0,1,NULL,NULL,0),(845,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:13:31',1,'2016-10-21 15:51:31',0,1,NULL,NULL,0),(846,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:13:31',1,'2016-10-21 15:42:12',0,1,NULL,NULL,0),(847,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:20:43',1,'2016-10-21 15:42:49',0,1,NULL,NULL,0),(848,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:20:52',1,'2016-10-21 16:08:10',0,1,NULL,NULL,0),(849,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:14',1,'2016-10-21 16:09:08',0,1,NULL,NULL,0),(850,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:22',1,'2016-10-21 16:12:46',0,1,NULL,NULL,0),(851,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:31',1,'2016-10-21 15:44:56',0,1,NULL,NULL,0),(852,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:38',1,'2016-10-21 15:45:14',0,1,1,'2016-10-21 15:46:57',1),(853,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:51',1,'2016-10-21 16:10:14',0,1,NULL,NULL,0),(854,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:58',1,'2016-10-21 16:13:08',0,1,NULL,NULL,0),(855,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:06',1,'2016-10-21 16:11:06',0,1,NULL,NULL,0),(856,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:13',1,'2016-10-21 16:05:15',0,1,NULL,NULL,0),(857,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:20',1,'2016-10-21 16:11:51',0,1,NULL,NULL,0),(858,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:56',1,'2016-10-21 15:48:02',0,1,NULL,NULL,0),(859,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:04',1,'2016-10-21 16:08:23',0,1,NULL,NULL,0),(860,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:15',1,'2016-10-21 16:09:19',0,1,NULL,NULL,0),(861,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:21',1,'2016-10-21 16:12:59',0,1,NULL,NULL,0),(862,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:27',1,'2016-10-21 15:49:41',0,1,NULL,NULL,0),(863,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:35',1,'2016-10-21 16:10:31',0,1,NULL,NULL,0),(864,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:39',1,'2016-10-21 16:13:18',0,1,NULL,NULL,0),(865,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:46',1,'2016-10-21 16:11:22',0,1,NULL,NULL,0),(866,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:51',1,'2016-10-21 16:05:48',0,1,NULL,NULL,0),(867,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:56',1,'2016-10-21 16:12:04',0,1,NULL,NULL,0),(870,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'TestReferral',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:42:04',NULL,NULL,0,1,1,'2016-10-21 15:45:54',1),(879,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,10,'2016-10-24 13:46:45',NULL,NULL,0,10,NULL,NULL,0),(896,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test Task',NULL,'2016-10-26 03:00:00',NULL,NULL,NULL,1,10,'2016-10-24 15:10:05',NULL,NULL,0,10,NULL,NULL,0),(897,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,10,'2016-10-24 15:11:24',NULL,NULL,0,10,10,'2016-10-24 15:11:36',1),(937,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,6,'2016-11-02 19:52:28',NULL,NULL,0,6,NULL,NULL,0),(938,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:07',NULL,NULL,0,1,NULL,NULL,0),(939,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:18',NULL,NULL,0,1,NULL,NULL,0),(940,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:42',NULL,NULL,0,1,NULL,NULL,0),(941,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:56',NULL,NULL,0,1,NULL,NULL,0),(952,136,NULL,0,NULL,0,NULL,5,NULL,NULL,'System folders',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:29:39',1,'2016-11-14 15:30:00',0,1,NULL,NULL,0),(953,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:30:26',NULL,NULL,0,1,NULL,NULL,0),(954,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:30:52',1,'2016-11-14 15:31:08',0,1,NULL,NULL,0),(955,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:30:59',NULL,NULL,0,1,NULL,NULL,0),(962,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 17:54:39',1,'2016-11-14 17:55:07',0,1,NULL,NULL,0),(963,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'AssessmentMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 17:57:19',1,'2016-11-14 20:18:41',0,1,NULL,NULL,0),(970,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'AssessmentsTest',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 18:18:58',NULL,NULL,0,1,1,'2016-12-08 17:47:23',1),(972,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:09:16',1,'2016-11-14 20:28:22',0,1,NULL,NULL,0),(973,972,NULL,0,NULL,0,NULL,12,NULL,NULL,'Assessment Start',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:15:12',NULL,NULL,0,1,NULL,NULL,0),(976,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'ClientIntake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:28:53',NULL,NULL,0,1,NULL,NULL,0),(977,976,NULL,0,NULL,0,NULL,12,NULL,NULL,'_startdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:29:21',NULL,NULL,0,1,NULL,NULL,0),(978,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'ClientIntakeMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:33:05',NULL,NULL,0,1,NULL,NULL,0);
/*!40000 ALTER TABLE `tree` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_bi` BEFORE INSERT ON `tree` FOR EACH ROW BEGIN

	DECLARE msg VARCHAR(255);

	

	if (new.id = new.pid) then

		set msg = concat('Error inserting cyclic reference: ', cast(new.id as char));

		signal sqlstate '45000' set message_text = msg;

	end if;

	

	

	set new.oid = coalesce(new.oid, new.cid);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_ai` AFTER INSERT ON `tree` FOR EACH ROW BEGIN

	

	declare tmp_new_case_id

		,tmp_new_security_set_id bigint unsigned default null;

	DECLARE tmp_new_pids TEXT DEFAULT '';

	

	if( 	(new.template_id is not null)

		and (select id from templates where (id = new.template_id) and (`type` = 'case') )

	) THEN

		SET tmp_new_case_id = new.id;

	END IF;

	select

		ti.pids

		,coalesce(tmp_new_case_id, ti.case_id)

		,ti.security_set_id

	into

		tmp_new_pids

		,tmp_new_case_id

		,tmp_new_security_set_id

	from tree t

	left join tree_info ti on t.id = ti.id

	where t.id = new.pid;

	SET tmp_new_pids = TRIM( ',' FROM CONCAT( tmp_new_pids, ',', new.id) );

	if(new.inherit_acl = 0) then

		set tmp_new_security_set_id = f_get_security_set_id(new.id);

	END IF;

	insert into tree_info (

		id

		,pids

		,case_id

		,security_set_id

	)

	values (

		new.id

		,tmp_new_pids

		,tmp_new_case_id

		,tmp_new_security_set_id

	);

	

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_au` AFTER UPDATE ON `tree` FOR EACH ROW BEGIN

	DECLARE tmp_old_pids

		,tmp_new_pids TEXT DEFAULT '';

	DECLARE tmp_old_case_id

		,tmp_new_case_id

		,tmp_old_security_set_id

		,tmp_new_security_set_id BIGINT UNSIGNED DEFAULT NULL;

	DECLARE tmp_old_security_set

		,tmp_new_security_set VARCHAR(9999) DEFAULT '';

	DECLARE tmp_old_pids_length

		,tmp_old_security_set_length

		,tmp_acl_count INT UNSIGNED DEFAULT 0;

	

	IF( (COALESCE(old.pid, 0) <> COALESCE(new.pid, 0) )

	    OR ( old.inherit_acl <> new.inherit_acl )

	  )THEN

		

		SELECT

			ti.pids 

			,ti.case_id 

			,ti.acl_count 

			,ti.security_set_id 

			,ts.set 

		INTO

			tmp_old_pids

			,tmp_old_case_id

			,tmp_acl_count

			,tmp_old_security_set_id

			,tmp_old_security_set

		FROM tree_info ti

		LEFT JOIN tree_acl_security_sets ts ON ti.security_set_id = ts.id

		WHERE ti.id = new.id;

		

		IF(tmp_old_case_id = old.id) THEN

			SET tmp_new_case_id = new.id;

		END IF;

		

		if(new.pid is null) THEN

			SET tmp_new_pids = new.id;

			

			SET tmp_new_security_set_id = null;

			set tmp_new_security_set = '';

		ELSE

			SELECT

				ti.pids

				,COALESCE(tmp_new_case_id, ti.case_id)

				,ti.security_set_id

				,ts.set

			INTO

				tmp_new_pids

				,tmp_new_case_id

				,tmp_new_security_set_id

				,tmp_new_security_set

			FROM tree t

			LEFT JOIN tree_info ti ON t.id = ti.id

			LEFT JOIN tree_acl_security_sets ts ON ti.security_set_id = ts.id

			WHERE t.id = new.pid;

			SET tmp_new_pids = TRIM( ',' FROM CONCAT( tmp_new_pids, ',', new.id) );

		END IF;

		

		

		IF(tmp_acl_count > 0) THEN

			

			IF(new.inherit_acl = 0) THEN

				SET tmp_new_security_set = new.id;

			else

				SET tmp_new_security_set = TRIM( ',' FROM CONCAT(tmp_new_security_set, ',', new.id ) );

			END IF;

			UPDATE tree_acl_security_sets

			SET `set` = tmp_new_security_set

				,updated = 1

			WHERE id = tmp_old_security_set_id;

			SET tmp_new_security_set_id = tmp_old_security_set_id;

		ELSE

			

			IF(new.inherit_acl = 0) THEN

				SET tmp_new_security_set_id = NULL;

				SET tmp_new_security_set = '';

			END IF;

		END IF;

		

		SET tmp_old_pids_length = LENGTH( tmp_old_pids ) +1;

		SET tmp_old_security_set_length = LENGTH( tmp_old_security_set ) +1;

		

		UPDATE tree_info

		SET	pids = tmp_new_pids

			,case_id = tmp_new_case_id

			,security_set_id = tmp_new_security_set_id

		WHERE id = new.id;

		

		CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_tree_info_pids`(

			`id` BIGINT UNSIGNED NOT NULL,

			`inherit_acl` TINYINT(1) NOT NULL DEFAULT '1',

			PRIMARY KEY (`id`)

		);

		CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_tree_info_childs`(

			`id` BIGINT UNSIGNED NOT NULL,

			`inherit_acl` TINYINT(1) NOT NULL DEFAULT '1',

			PRIMARY KEY (`id`)

		);

		CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_tree_info_security_sets`(

			`id` BIGINT UNSIGNED NOT NULL,

			`new_id` BIGINT UNSIGNED NULL,

			`set` VARCHAR(9999),

			PRIMARY KEY (`id`),

			INDEX `IDX_tmp_tree_info_security_sets__set` (`set`),

			INDEX `IDX_tmp_tree_info_security_sets__new_id` (`new_id`)

		);

		DELETE FROM tmp_tree_info_pids;

		DELETE FROM tmp_tree_info_childs;

		DELETE FROM tmp_tree_info_security_sets;

		INSERT INTO tmp_tree_info_childs (id, inherit_acl)

			SELECT id, inherit_acl

			FROM tree

			WHERE pid = new.id;

		WHILE( ROW_COUNT() > 0 )DO

			UPDATE

				tmp_tree_info_childs

				,tree_info

			SET

				tree_info.pids = CONCAT(tmp_new_pids, SUBSTRING(tree_info.pids, tmp_old_pids_length))

				,tree_info.case_id = CASE WHEN (tree_info.case_id = tmp_old_case_id) THEN tmp_new_case_id ELSE COALESCE(tree_info.case_id, tmp_new_case_id) END

				,tree_info.security_set_id =

					CASE

					WHEN (tmp_tree_info_childs.inherit_acl = 1)

					     AND ( coalesce(tree_info.security_set_id, 0) = coalesce(tmp_old_security_set_id, 0) )

						THEN tmp_new_security_set_id

					ELSE tree_info.security_set_id

					END

			WHERE tmp_tree_info_childs.id = tree_info.id;

			DELETE FROM tmp_tree_info_pids;

			INSERT INTO tmp_tree_info_pids

				SELECT id, inherit_acl

				FROM tmp_tree_info_childs;

			INSERT INTO tmp_tree_info_security_sets (id)

				SELECT DISTINCT ti.security_set_id

				FROM tmp_tree_info_childs c

				JOIN tree_info ti ON c.id = ti.id

				WHERE ti.security_set_id IS NOT NULL

					and c.inherit_acl = 1

			ON DUPLICATE KEY UPDATE id = ti.security_set_id;

			DELETE FROM tmp_tree_info_childs;

			INSERT INTO tmp_tree_info_childs (id, inherit_acl)

				SELECT

					t.id,

					case when ( (t.inherit_acl = 1) and (ti.inherit_acl = 1) ) then 1 else 0 END

				FROM tmp_tree_info_pids  ti

				JOIN tree t

					ON ti.id = t.pid;

		END WHILE;

		

		UPDATE tmp_tree_info_security_sets

			,tree_acl_security_sets

			SET tree_acl_security_sets.`set` = TRIM( ',' FROM CONCAT(tmp_new_security_set, SUBSTRING(tree_acl_security_sets.set, tmp_old_security_set_length)) )

				,tree_acl_security_sets.updated = 1

		WHERE tmp_tree_info_security_sets.id <> coalesce(tmp_new_security_set_id, 0)

			AND tmp_tree_info_security_sets.id = tree_acl_security_sets.id

			AND tree_acl_security_sets.set LIKE CONCAT(tmp_old_security_set,',%');

		

		if(tmp_old_security_set_id <> coalesce(tmp_new_security_set_id, 0)) THEN

			if( (select count(*) from tree_info where security_set_id = tmp_old_security_set_id) = 0) THEN

				delete from `tree_acl_security_sets` where id = tmp_old_security_set_id;

			END IF;

		END IF;

	END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tree_acl`
--

DROP TABLE IF EXISTS `tree_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree_acl` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` bigint(20) unsigned NOT NULL,
  `user_group_id` int(10) unsigned NOT NULL,
  `allow` int(16) NOT NULL DEFAULT '0',
  `deny` int(16) NOT NULL DEFAULT '0',
  `cid` int(10) unsigned DEFAULT NULL,
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` int(10) unsigned DEFAULT NULL,
  `udate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `FK_tree_acl__node_id__user_group_id` (`node_id`,`user_group_id`),
  KEY `FK_tree_acl__user_group_id` (`user_group_id`),
  CONSTRAINT `FK_tree_acl__node_id` FOREIGN KEY (`node_id`) REFERENCES `tree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tree_acl__user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_acl`
--

LOCK TABLES `tree_acl` WRITE;
/*!40000 ALTER TABLE `tree_acl` DISABLE KEYS */;
INSERT INTO `tree_acl` VALUES (1,150,2,2431,0,1,'2016-08-08 01:29:59',1,'2016-10-21 00:32:39'),(18,668,2,2175,0,1,'2016-10-21 00:34:46',1,'2016-10-21 00:34:52'),(20,1,2,2175,0,1,'2016-10-21 00:36:35',1,'2016-10-21 00:36:39');
/*!40000 ALTER TABLE `tree_acl` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_acl_ai` AFTER INSERT ON `tree_acl` FOR EACH ROW BEGIN

	declare tmp_acl_count int unsigned default 0;

	DECLARE tmp_new_security_set_id

		,tmp_old_security_set_id BIGINT UNSIGNED default null;

	DECLARE tmp_old_security_set, msg

		,tmp_new_security_set varchar(9999) default '';

	select ti.acl_count + 1

		,ti.security_set_id

		,coalesce( ts.set, '')

	into tmp_acl_count

		,tmp_old_security_set_id

		,tmp_old_security_set

	from tree_info ti

	left join `tree_acl_security_sets` ts on ti.security_set_id = ts.id

	where ti.id = new.node_id;

	

	IF((tmp_acl_count > 1) OR

	  (tmp_old_security_set = new.node_id) OR

	  (CONCAT(',', tmp_old_security_set) LIKE CONCAT('%,', new.node_id))

	 ) THEN

		UPDATE tree_info

		SET acl_count = tmp_acl_count

		WHERE id = new.node_id;

		

		update `tree_acl_security_sets`

		set updated = 1

		where id = tmp_old_security_set_id;

		

		UPDATE `tree_acl_security_sets`

		SET updated = 1

		WHERE `set` like concat(tmp_old_security_set, ',%');

	ELSE

		

		set tmp_new_security_set = trim( ',' from concat(tmp_old_security_set, ',', new.node_id) );

		insert into tree_acl_security_sets (`set`)

		values(tmp_new_security_set)

		on duplicate key

		update id = last_insert_id(id);

		set tmp_new_security_set_id = last_insert_id();

		

		UPDATE tree_info

		SET 	acl_count = tmp_acl_count

			,security_set_id = tmp_new_security_set_id

		WHERE id = new.node_id;

		

		CALL p_update_child_security_sets(new.node_id, tmp_old_security_set_id, tmp_new_security_set_id);

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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_acl_au` AFTER UPDATE ON `tree_acl` FOR EACH ROW BEGIN

	DECLARE tmp_security_set_id BIGINT UNSIGNED;

	DECLARE tmp_security_set VARCHAR(9999) DEFAULT '';

	

	SELECT ti.security_set_id

		,ts.set

	INTO tmp_security_set_id

		,tmp_security_set

	FROM tree_info ti

	JOIN `tree_acl_security_sets` ts ON ti.security_set_id = ts.id

	WHERE ti.id = new.node_id;

	

	UPDATE `tree_acl_security_sets`

	SET updated = 1

	WHERE id = tmp_security_set_id;

	

	UPDATE `tree_acl_security_sets`

	SET updated = 1

	WHERE `set` LIKE CONCAT(tmp_security_set, ',%');

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_acl_ad` AFTER DELETE ON `tree_acl` FOR EACH ROW BEGIN

	DECLARE tmp_acl_count

		,tmp_length INT DEFAULT 0;

	DECLARE tmp_old_security_set_id

		,tmp_new_security_set_id BIGINT UNSIGNED default null;

	DECLARE tmp_old_security_set

		,tmp_new_security_set VARCHAR(9999) DEFAULT '';

	declare tmp_inherit_acl  tinyint(1) default 1;

	

	

	SELECT  case when (ti.acl_count >0)

			THEN ti.acl_count - 1

			ELSE 0

		END

		,ti.security_set_id

		,ts.set

	INTO tmp_acl_count

		,tmp_old_security_set_id

		,tmp_old_security_set

	FROM tree_info ti

	JOIN `tree_acl_security_sets` ts ON ti.security_set_id = ts.id

	WHERE ti.id = old.node_id;

	

	IF(tmp_acl_count > 0) THEN

		UPDATE tree_info

		SET acl_count = tmp_acl_count

		WHERE id = old.node_id;

		

		UPDATE `tree_acl_security_sets`

		SET updated = 1

		WHERE id = tmp_old_security_set_id;

		

		UPDATE `tree_acl_security_sets`

		SET updated = 1

		WHERE `set` LIKE CONCAT(tmp_old_security_set, ',%');

	ELSE

		

		select inherit_acl

		into tmp_inherit_acl

		from tree

		where id = old.node_id;

		

		if(tmp_inherit_acl = 1) THEN

			

			set tmp_length = length( SUBSTRING_INDEX( tmp_old_security_set, ',', -1 ) );

			

			set tmp_length = LENGTH( tmp_old_security_set) - tmp_length - 1;

			if(tmp_length < 0) Then

				Set tmp_length = 0;

			END IF;

			SET tmp_new_security_set = substring( tmp_old_security_set, 1,  tmp_length );

			

			if(LENGTH(tmp_new_security_set) > 0) THEN

				select id

				into tmp_new_security_set_id

				from tree_acl_security_sets

				where `set` = tmp_new_security_set;

			else

				set tmp_new_security_set_id = null;

			END IF;

		END IF;

		

		UPDATE tree_info

		SET acl_count = tmp_acl_count

			,security_set_id = tmp_new_security_set_id

		WHERE id = old.node_id;

		

		CALL p_update_child_security_sets(old.node_id, tmp_old_security_set_id, tmp_new_security_set_id);

		IF( COALESCE(tmp_new_security_set_id, 0) <> tmp_old_security_set_id) THEN

			DELETE FROM tree_acl_security_sets

			WHERE id = tmp_old_security_set_id;

		END IF;

	END IF;

  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tree_acl_security_sets`
--

DROP TABLE IF EXISTS `tree_acl_security_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree_acl_security_sets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `set` varchar(9999) NOT NULL,
  `md5` varchar(32) NOT NULL DEFAULT '-',
  `updated` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_tree_acl_security_sets__md5` (`md5`),
  KEY `IDX_tree_acl_security_sets__set` (`set`(100))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_acl_security_sets`
--

LOCK TABLES `tree_acl_security_sets` WRITE;
/*!40000 ALTER TABLE `tree_acl_security_sets` DISABLE KEYS */;
INSERT INTO `tree_acl_security_sets` VALUES (1,'150','7ef605fc8dba5425d6965fbd4c8fbe1f',0),(2,'7','8f14e45fceea167a5a36dedd4bea2543',1),(4,'664','2291d2ec3b3048d1a6f86c2c4591b7e0',1),(5,'675','8fecb20817b3847419bb3de39a609afe',1),(6,'668','192fc044e74dffea144f9ac5dc9f3395',0),(7,'1','c4ca4238a0b923820dcc509a6f75849b',0);
/*!40000 ALTER TABLE `tree_acl_security_sets` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_acl_security_sets_bi` BEFORE INSERT ON `tree_acl_security_sets` FOR EACH ROW BEGIN

	set new.md5 = md5(new.set);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_acl_security_sets_bu` BEFORE UPDATE ON `tree_acl_security_sets` FOR EACH ROW BEGIN

	set new.md5 = md5(new.set);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tree_acl_security_sets_result`
--

DROP TABLE IF EXISTS `tree_acl_security_sets_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree_acl_security_sets_result` (
  `security_set_id` bigint(20) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `bit0` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=deny, 1=allow',
  `bit1` tinyint(1) NOT NULL DEFAULT '0',
  `bit2` tinyint(1) DEFAULT '0',
  `bit3` tinyint(1) DEFAULT '0',
  `bit4` tinyint(1) DEFAULT '0',
  `bit5` tinyint(1) DEFAULT '0',
  `bit6` tinyint(1) DEFAULT '0',
  `bit7` tinyint(1) DEFAULT '0',
  `bit8` tinyint(1) DEFAULT '0',
  `bit9` tinyint(1) DEFAULT '0',
  `bit10` tinyint(1) DEFAULT '0',
  `bit11` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`security_set_id`,`user_id`),
  KEY `IDX_tree_acl_security_sets_result__user_id` (`user_id`),
  CONSTRAINT `FK_tree_acl_security_sets_result__security_set_id` FOREIGN KEY (`security_set_id`) REFERENCES `tree_acl_security_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tree_acl_security_sets_result__user_id` FOREIGN KEY (`user_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_acl_security_sets_result`
--

LOCK TABLES `tree_acl_security_sets_result` WRITE;
/*!40000 ALTER TABLE `tree_acl_security_sets_result` DISABLE KEYS */;
INSERT INTO `tree_acl_security_sets_result` VALUES (1,2,1,1,1,1,1,1,1,0,1,0,0,1),(4,2,0,0,0,0,0,0,0,0,0,0,0,0),(5,2,0,0,0,0,0,0,0,0,0,0,0,0),(6,2,1,1,1,1,1,1,1,0,0,0,0,1),(7,2,1,1,1,1,1,1,1,0,0,0,0,1);
/*!40000 ALTER TABLE `tree_acl_security_sets_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tree_info`
--

DROP TABLE IF EXISTS `tree_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree_info` (
  `id` bigint(20) unsigned NOT NULL,
  `pids` text NOT NULL COMMENT 'comma separated parent ids',
  `path` text COMMENT 'slash separated parent names',
  `case_id` bigint(20) unsigned DEFAULT NULL,
  `acl_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'count of security rules associated with this node in the tree',
  `security_set_id` bigint(20) unsigned DEFAULT NULL,
  `updated` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `tree_info__case_id` (`case_id`),
  KEY `tree_info__security_set_id` (`security_set_id`),
  KEY `tree_info__updated` (`updated`),
  KEY `tree_info_pids` (`pids`(200)),
  CONSTRAINT `tree_info__case_id` FOREIGN KEY (`case_id`) REFERENCES `tree` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tree_info__id` FOREIGN KEY (`id`) REFERENCES `tree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tree_info__security_set_id` FOREIGN KEY (`security_set_id`) REFERENCES `tree_acl_security_sets` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_info`
--

LOCK TABLES `tree_info` WRITE;
/*!40000 ALTER TABLE `tree_info` DISABLE KEYS */;
INSERT INTO `tree_info` VALUES (1,'1','',NULL,1,7,0),(2,'1,2','/',NULL,0,NULL,0),(3,'1,2,3','/System/',NULL,0,NULL,0),(4,'1,2,4','/System/',NULL,0,NULL,0),(5,'1,2,3,88,5','/System/Templates/',NULL,0,NULL,0),(6,'1,2,3,88,6','/System/Templates/',NULL,0,NULL,0),(7,'1,2,3,88,7','/System/Templates/',NULL,1,2,0),(8,'1,2,3,88,8','/System/Templates/',NULL,0,NULL,0),(9,'1,2,3,88,9','/System/Templates/',NULL,0,NULL,0),(10,'1,2,3,88,10','/System/Templates/',NULL,0,NULL,0),(11,'1,2,3,88,11','/System/Templates/',NULL,0,NULL,0),(12,'1,2,3,88,12','/System/Templates/',NULL,0,NULL,0),(13,'1,2,3,88,10,13','/System/Templates/User/',NULL,0,NULL,0),(14,'1,2,3,88,10,14','/System/Templates/User/',NULL,0,NULL,0),(15,'1,2,3,88,10,15','/System/Templates/User/',NULL,0,NULL,0),(16,'1,2,3,88,10,16','/System/Templates/User/',NULL,0,NULL,0),(17,'1,2,3,88,10,17','/System/Templates/User/',NULL,0,NULL,0),(18,'1,2,3,88,10,18','/System/Templates/User/',NULL,0,NULL,0),(19,'1,2,3,88,10,19','/System/Templates/User/',NULL,0,NULL,0),(20,'1,2,3,88,10,20','/System/Templates/User/',NULL,0,NULL,0),(21,'1,2,3,88,10,21','/System/Templates/User/',NULL,0,NULL,0),(22,'1,2,3,88,10,22','/System/Templates/User/',NULL,0,NULL,0),(23,'1,2,3,88,10,23','/System/Templates/User/',NULL,0,NULL,0),(24,'1,2,3,88,6,24','/System/Templates/file/',NULL,0,NULL,0),(25,'1,2,3,88,12,25','/System/Templates/Fields template/',NULL,0,NULL,0),(26,'1,2,3,88,12,26','/System/Templates/Fields template/',NULL,0,NULL,0),(27,'1,2,3,88,12,27','/System/Templates/Fields template/',NULL,0,NULL,0),(28,'1,2,3,88,12,28','/System/Templates/Fields template/',NULL,0,NULL,0),(29,'1,2,3,88,12,29','/System/Templates/Fields template/',NULL,0,NULL,0),(30,'1,2,3,88,12,30','/System/Templates/Fields template/',NULL,0,NULL,0),(31,'1,2,3,88,11,31','/System/Templates/Templates template/',NULL,0,NULL,0),(32,'1,2,3,88,11,32','/System/Templates/Templates template/',NULL,0,NULL,0),(33,'1,2,3,88,11,33','/System/Templates/Templates template/',NULL,0,NULL,0),(34,'1,2,3,88,11,34','/System/Templates/Templates template/',NULL,0,NULL,0),(35,'1,2,3,88,11,35','/System/Templates/Templates template/',NULL,0,NULL,0),(36,'1,2,3,88,11,36','/System/Templates/Templates template/',NULL,0,NULL,0),(37,'1,2,3,88,11,37','/System/Templates/Templates template/',NULL,0,NULL,0),(38,'1,2,3,88,11,38','/System/Templates/Templates template/',NULL,0,NULL,0),(39,'1,2,3,88,8,39','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(40,'1,2,3,88,8,40','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(41,'1,2,3,88,8,41','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(42,'1,2,3,88,8,42','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(43,'1,2,3,88,8,43','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(44,'1,2,3,88,7,44','/System/Templates/task/',NULL,0,2,0),(45,'1,2,3,88,7,45','/System/Templates/task/',NULL,0,2,0),(46,'1,2,3,88,7,46','/System/Templates/task/',NULL,0,2,0),(47,'1,2,3,88,7,47','/System/Templates/task/',NULL,0,2,0),(48,'1,2,3,88,5,48','/System/Templates/folder/',NULL,0,NULL,0),(49,'1,2,3,88,9,49','/System/Templates/Comment/',NULL,0,NULL,0),(50,'1,2,3,88,7,50','/System/Templates/task/',NULL,0,2,0),(51,'1,2,3,88,7,51','/System/Templates/task/',NULL,0,2,0),(52,'1,2,4,52',NULL,NULL,0,NULL,0),(53,'1,2,4,52,53',NULL,NULL,0,NULL,0),(54,'1,2,4,52,53,54',NULL,NULL,0,NULL,0),(55,'1,2,4,52,53,55',NULL,NULL,0,NULL,0),(56,'1,2,4,52,53,56',NULL,NULL,0,NULL,0),(57,'1,2,4,52,53,57',NULL,NULL,0,NULL,0),(58,'1,2,3,88,58',NULL,NULL,0,NULL,0),(59,'1,2,3,88,59',NULL,NULL,0,NULL,0),(60,'1,2,60',NULL,NULL,0,NULL,0),(61,'1,2,3,88,59,61',NULL,NULL,0,NULL,0),(62,'1,2,3,88,59,62',NULL,NULL,0,NULL,0),(63,'1,2,3,88,59,62,63',NULL,NULL,0,NULL,0),(64,'1,2,3,88,59,62,64',NULL,NULL,0,NULL,0),(65,'1,2,3,88,59,62,65',NULL,NULL,0,NULL,0),(66,'1,2,3,88,59,62,66',NULL,NULL,0,NULL,0),(67,'1,2,3,88,59,62,67',NULL,NULL,0,NULL,0),(68,'1,2,60,68',NULL,NULL,0,NULL,0),(69,'1,2,60,69',NULL,NULL,0,NULL,0),(70,'1,2,60,70',NULL,NULL,0,NULL,0),(71,'1,2,60,71',NULL,NULL,0,NULL,0),(72,'1,2,60,72',NULL,NULL,0,NULL,0),(73,'1,2,60,73',NULL,NULL,0,NULL,0),(74,'1,2,4,74',NULL,NULL,0,NULL,0),(75,'1,2,4,74,75',NULL,NULL,0,NULL,0),(76,'1,2,4,74,75,76',NULL,NULL,0,NULL,0),(77,'1,2,4,74,75,77',NULL,NULL,0,NULL,0),(78,'1,2,4,74,75,78',NULL,NULL,0,NULL,0),(79,'1,2,4,74,75,79',NULL,NULL,0,NULL,0),(80,'1,2,4,74,75,80',NULL,NULL,0,NULL,0),(81,'1,2,4,74,75,81',NULL,NULL,0,NULL,0),(82,'1,2,4,74,82',NULL,NULL,0,NULL,0),(83,'1,2,3,88,83',NULL,NULL,0,NULL,0),(84,'1,2,3,88,83,84',NULL,NULL,0,NULL,0),(85,'1,2,3,88,83,85',NULL,NULL,0,NULL,0),(86,'1,2,3,88,83,86',NULL,NULL,0,NULL,0),(87,'1,2,3,88,83,87',NULL,NULL,0,NULL,0),(88,'1,2,3,88',NULL,NULL,0,NULL,0),(89,'1,2,3,89',NULL,NULL,0,NULL,0),(90,'1,2,90',NULL,NULL,0,NULL,0),(91,'1,2,3,89,91',NULL,NULL,0,NULL,0),(92,'1,2,3,89,91,92',NULL,NULL,0,NULL,0),(93,'1,2,3,89,91,93',NULL,NULL,0,NULL,0),(94,'1,2,3,89,94',NULL,NULL,0,NULL,0),(95,'1,2,3,89,94,95',NULL,NULL,0,NULL,0),(96,'1,2,3,89,94,96',NULL,NULL,0,NULL,0),(97,'1,2,3,89,97',NULL,NULL,0,NULL,0),(98,'1,2,3,89,97,98',NULL,NULL,0,NULL,0),(99,'1,2,3,89,97,99',NULL,NULL,0,NULL,0),(100,'1,2,3,89,100',NULL,NULL,0,NULL,0),(101,'1,2,3,89,100,101',NULL,NULL,0,NULL,0),(102,'1,2,3,89,100,102',NULL,NULL,0,NULL,0),(103,'1,2,3,89,100,103',NULL,NULL,0,NULL,0),(104,'1,2,90,104',NULL,NULL,0,NULL,0),(105,'1,2,90,105',NULL,NULL,0,NULL,0),(106,'1,2,90,106',NULL,NULL,0,NULL,0),(107,'1,2,90,107',NULL,NULL,0,NULL,0),(108,'1,2,90,108',NULL,NULL,0,NULL,0),(109,'1,2,90,109',NULL,NULL,0,NULL,0),(110,'1,2,90,110',NULL,NULL,0,NULL,0),(111,'1,2,90,111',NULL,NULL,0,NULL,0),(112,'1,2,90,112',NULL,NULL,0,NULL,0),(113,'1,2,90,113',NULL,NULL,0,NULL,0),(114,'1,2,90,113,114',NULL,NULL,0,NULL,0),(115,'1,2,90,113,115',NULL,NULL,0,NULL,0),(116,'1,2,90,113,116',NULL,NULL,0,NULL,0),(117,'1,2,60,117',NULL,NULL,0,NULL,0),(118,'1,2,90,118',NULL,NULL,0,NULL,0),(119,'1,2,90,119',NULL,NULL,0,NULL,0),(120,'1,2,90,120',NULL,NULL,0,NULL,0),(121,'1,2,90,121',NULL,NULL,0,NULL,0),(122,'1,2,90,122',NULL,NULL,0,NULL,0),(123,'1,2,90,123',NULL,NULL,0,NULL,0),(124,'1,2,90,124',NULL,NULL,0,NULL,0),(125,'1,2,90,125',NULL,NULL,0,NULL,0),(126,'1,2,90,126',NULL,NULL,0,NULL,0),(127,'1,2,90,127',NULL,NULL,0,NULL,0),(128,'1,2,90,128',NULL,NULL,0,NULL,0),(129,'1,2,90,129',NULL,NULL,0,NULL,0),(130,'1,2,90,129,130',NULL,NULL,0,NULL,0),(131,'1,2,90,129,131',NULL,NULL,0,NULL,0),(132,'1,2,90,132',NULL,NULL,0,NULL,0),(133,'1,133',NULL,NULL,0,7,0),(134,'1,2,4,134',NULL,NULL,0,NULL,0),(135,'1,2,4,135',NULL,NULL,0,NULL,0),(136,'1,2,4,136',NULL,NULL,0,NULL,0),(137,'1,2,4,136,137',NULL,NULL,0,NULL,0),(138,'1,2,4,136,137,138',NULL,NULL,0,NULL,0),(139,'1,2,4,136,137,139',NULL,NULL,0,NULL,0),(140,'1,2,3,140',NULL,NULL,0,NULL,0),(141,'1,2,3,140,141',NULL,NULL,0,NULL,0),(142,'1,2,3,140,141,142',NULL,NULL,0,NULL,0),(143,'1,2,3,140,141,143',NULL,NULL,0,NULL,0),(144,'1,2,3,140,141,144',NULL,NULL,0,NULL,0),(145,'1,2,3,140,141,145',NULL,NULL,0,NULL,0),(146,'1,2,60,146',NULL,NULL,0,NULL,0),(147,'1,2,60,147',NULL,NULL,0,NULL,0),(149,'1,149',NULL,NULL,0,7,0),(150,'1,150',NULL,NULL,1,1,0),(152,'1,2,90,113,152',NULL,NULL,0,NULL,0),(156,'1,150,156',NULL,NULL,0,1,0),(157,'1,150,157',NULL,NULL,0,1,0),(160,'1,160',NULL,NULL,0,7,0),(161,'1,150,161',NULL,NULL,0,1,0),(167,'1,2,4,136,167',NULL,NULL,0,NULL,0),(168,'1,2,4,136,168',NULL,NULL,0,NULL,0),(169,'1,2,4,136,168,169',NULL,NULL,0,NULL,0),(170,'1,2,4,136,168,170',NULL,NULL,0,NULL,0),(172,'1,2,3,140,172',NULL,NULL,0,NULL,0),(173,'1,2,60,173',NULL,NULL,0,NULL,0),(182,'1,150,182',NULL,NULL,0,1,0),(201,'1,150,201',NULL,NULL,0,1,0),(205,'1,2,3,205',NULL,NULL,0,NULL,0),(206,'1,2,3,205,206',NULL,NULL,0,NULL,0),(207,'1,2,3,207',NULL,NULL,0,NULL,0),(208,'1,2,3,207,208',NULL,NULL,0,NULL,0),(209,'1,2,3,140,141,209',NULL,NULL,0,NULL,0),(210,'1,2,3,140,141,210',NULL,NULL,0,NULL,0),(211,'1,2,3,140,141,211',NULL,NULL,0,NULL,0),(212,'1,2,3,140,141,212',NULL,NULL,0,NULL,0),(213,'1,2,4,136,213',NULL,NULL,0,NULL,0),(214,'1,2,4,136,167,214',NULL,NULL,0,NULL,0),(215,'1,2,4,136,167,215',NULL,NULL,0,NULL,0),(216,'1,2,4,136,167,216',NULL,NULL,0,NULL,0),(217,'1,2,4,136,167,217',NULL,NULL,0,NULL,0),(218,'1,2,4,136,167,218',NULL,NULL,0,NULL,0),(219,'1,2,4,136,167,219',NULL,NULL,0,NULL,0),(220,'1,2,4,136,167,220',NULL,NULL,0,NULL,0),(221,'1,2,4,136,221',NULL,NULL,0,NULL,0),(222,'1,2,4,136,221,222',NULL,NULL,0,NULL,0),(223,'1,2,4,136,221,223',NULL,NULL,0,NULL,0),(224,'1,2,4,136,221,224',NULL,NULL,0,NULL,0),(225,'1,2,4,136,221,225',NULL,NULL,0,NULL,0),(226,'1,2,4,136,226',NULL,NULL,0,NULL,0),(227,'1,2,4,136,227',NULL,NULL,0,NULL,0),(228,'1,2,4,136,228',NULL,NULL,0,NULL,0),(229,'1,2,4,136,226,229',NULL,NULL,0,NULL,0),(230,'1,2,4,136,226,230',NULL,NULL,0,NULL,0),(231,'1,2,4,136,226,231',NULL,NULL,0,NULL,0),(232,'1,2,4,136,226,232',NULL,NULL,0,NULL,0),(233,'1,2,4,136,226,233',NULL,NULL,0,NULL,0),(234,'1,2,4,136,227,234',NULL,NULL,0,NULL,0),(235,'1,2,4,136,227,235',NULL,NULL,0,NULL,0),(236,'1,2,4,136,227,236',NULL,NULL,0,NULL,0),(237,'1,2,4,136,227,237',NULL,NULL,0,NULL,0),(238,'1,2,4,136,227,238',NULL,NULL,0,NULL,0),(239,'1,2,4,136,227,239',NULL,NULL,0,NULL,0),(240,'1,2,4,136,227,240',NULL,NULL,0,NULL,0),(241,'1,2,4,136,227,241',NULL,NULL,0,NULL,0),(242,'1,2,4,136,228,242',NULL,NULL,0,NULL,0),(243,'1,2,4,136,228,243',NULL,NULL,0,NULL,0),(244,'1,2,4,136,228,244',NULL,NULL,0,NULL,0),(245,'1,2,4,136,228,245',NULL,NULL,0,NULL,0),(246,'1,2,4,136,228,246',NULL,NULL,0,NULL,0),(247,'1,2,4,136,228,247',NULL,NULL,0,NULL,0),(248,'1,2,4,136,228,248',NULL,NULL,0,NULL,0),(249,'1,2,4,136,228,249',NULL,NULL,0,NULL,0),(250,'1,2,4,136,228,250',NULL,NULL,0,NULL,0),(251,'1,2,4,136,228,251',NULL,NULL,0,NULL,0),(252,'1,2,4,136,228,252',NULL,NULL,0,NULL,0),(253,'1,2,4,136,228,253',NULL,NULL,0,NULL,0),(254,'1,2,4,136,228,254',NULL,NULL,0,NULL,0),(255,'1,2,4,136,228,255',NULL,NULL,0,NULL,0),(256,'1,2,4,136,228,256',NULL,NULL,0,NULL,0),(257,'1,2,4,136,228,257',NULL,NULL,0,NULL,0),(258,'1,2,4,136,228,258',NULL,NULL,0,NULL,0),(259,'1,2,4,136,228,259',NULL,NULL,0,NULL,0),(260,'1,2,4,136,228,260',NULL,NULL,0,NULL,0),(261,'1,2,4,136,228,261',NULL,NULL,0,NULL,0),(262,'1,2,4,136,228,262',NULL,NULL,0,NULL,0),(263,'1,2,4,136,228,263',NULL,NULL,0,NULL,0),(264,'1,2,4,136,228,264',NULL,NULL,0,NULL,0),(265,'1,2,4,136,228,265',NULL,NULL,0,NULL,0),(266,'1,2,4,136,228,266',NULL,NULL,0,NULL,0),(267,'1,2,4,136,228,267',NULL,NULL,0,NULL,0),(268,'1,2,4,136,228,268',NULL,NULL,0,NULL,0),(269,'1,2,4,136,228,269',NULL,NULL,0,NULL,0),(270,'1,2,4,136,228,270',NULL,NULL,0,NULL,0),(271,'1,2,4,136,228,271',NULL,NULL,0,NULL,0),(272,'1,2,3,140,141,272',NULL,NULL,0,NULL,0),(274,'1,2,3,140,141,274',NULL,NULL,0,NULL,0),(275,'1,2,3,140,141,275',NULL,NULL,0,NULL,0),(276,'1,2,3,140,141,276',NULL,NULL,0,NULL,0),(277,'1,2,3,140,141,277',NULL,NULL,0,NULL,0),(278,'1,2,3,140,141,278',NULL,NULL,0,NULL,0),(279,'1,2,3,140,141,279',NULL,NULL,0,NULL,0),(280,'1,2,3,140,141,280',NULL,NULL,0,NULL,0),(286,'1,150,201,286',NULL,NULL,0,1,0),(287,'1,150,201,287',NULL,NULL,0,1,0),(288,'1,2,90,113,288',NULL,NULL,0,NULL,0),(289,'1,2,3,140,289',NULL,NULL,0,NULL,0),(290,'1,2,3,140,289,290',NULL,NULL,0,NULL,0),(291,'1,2,3,140,289,291',NULL,NULL,0,NULL,0),(292,'1,2,3,140,289,292',NULL,NULL,0,NULL,0),(293,'1,2,3,140,289,293',NULL,NULL,0,NULL,0),(294,'1,2,3,140,289,294',NULL,NULL,0,NULL,0),(295,'1,2,3,140,289,295',NULL,NULL,0,NULL,0),(296,'1,2,3,140,289,296',NULL,NULL,0,NULL,0),(297,'1,2,3,140,289,297',NULL,NULL,0,NULL,0),(298,'1,2,3,140,289,298',NULL,NULL,0,NULL,0),(299,'1,2,4,136,299',NULL,NULL,0,NULL,0),(300,'1,2,4,136,299,300',NULL,NULL,0,NULL,0),(301,'1,2,4,136,299,301',NULL,NULL,0,NULL,0),(302,'1,2,4,136,299,302',NULL,NULL,0,NULL,0),(303,'1,2,4,136,299,303',NULL,NULL,0,NULL,0),(304,'1,2,4,136,299,304',NULL,NULL,0,NULL,0),(305,'1,2,4,136,299,305',NULL,NULL,0,NULL,0),(306,'1,2,4,136,299,306',NULL,NULL,0,NULL,0),(307,'1,2,4,136,299,307',NULL,NULL,0,NULL,0),(308,'1,2,4,136,299,308',NULL,NULL,0,NULL,0),(309,'1,2,4,136,299,309',NULL,NULL,0,NULL,0),(310,'1,2,4,136,299,310',NULL,NULL,0,NULL,0),(311,'1,2,3,140,311',NULL,NULL,0,NULL,0),(312,'1,2,3,140,311,312',NULL,NULL,0,NULL,0),(313,'1,2,3,140,311,313',NULL,NULL,0,NULL,0),(314,'1,2,3,140,311,314',NULL,NULL,0,NULL,0),(315,'1,2,3,140,311,315',NULL,NULL,0,NULL,0),(316,'1,2,3,140,311,316',NULL,NULL,0,NULL,0),(317,'1,2,3,140,311,317',NULL,NULL,0,NULL,0),(318,'1,2,3,140,311,318',NULL,NULL,0,NULL,0),(319,'1,2,3,140,311,319',NULL,NULL,0,NULL,0),(320,'1,2,3,140,311,320',NULL,NULL,0,NULL,0),(321,'1,2,4,136,321',NULL,NULL,0,NULL,0),(322,'1,2,4,136,321,322',NULL,NULL,0,NULL,0),(323,'1,2,4,136,321,323',NULL,NULL,0,NULL,0),(324,'1,2,4,136,321,324',NULL,NULL,0,NULL,0),(325,'1,2,4,136,321,325',NULL,NULL,0,NULL,0),(326,'1,2,4,136,321,326',NULL,NULL,0,NULL,0),(327,'1,2,4,136,321,327',NULL,NULL,0,NULL,0),(328,'1,2,4,136,321,328',NULL,NULL,0,NULL,0),(329,'1,2,4,136,321,329',NULL,NULL,0,NULL,0),(330,'1,2,4,136,321,330',NULL,NULL,0,NULL,0),(331,'1,2,4,136,321,331',NULL,NULL,0,NULL,0),(332,'1,2,4,136,321,332',NULL,NULL,0,NULL,0),(333,'1,2,4,333',NULL,NULL,0,NULL,0),(334,'1,2,4,333,334',NULL,NULL,0,NULL,0),(335,'1,2,4,333,334,335',NULL,NULL,0,NULL,0),(336,'1,2,4,333,334,336',NULL,NULL,0,NULL,0),(337,'1,2,4,333,334,337',NULL,NULL,0,NULL,0),(338,'1,2,4,333,334,338',NULL,NULL,0,NULL,0),(339,'1,2,4,333,334,339',NULL,NULL,0,NULL,0),(340,'1,2,4,333,334,340',NULL,NULL,0,NULL,0),(341,'1,2,4,333,334,341',NULL,NULL,0,NULL,0),(342,'1,2,4,333,334,342',NULL,NULL,0,NULL,0),(343,'1,2,4,333,334,343',NULL,NULL,0,NULL,0),(344,'1,2,4,333,334,344',NULL,NULL,0,NULL,0),(345,'1,2,4,333,334,345',NULL,NULL,0,NULL,0),(346,'1,2,4,333,346',NULL,NULL,0,NULL,0),(347,'1,2,4,333,346,347',NULL,NULL,0,NULL,0),(348,'1,2,4,333,346,348',NULL,NULL,0,NULL,0),(349,'1,2,4,333,346,349',NULL,NULL,0,NULL,0),(350,'1,2,4,333,346,350',NULL,NULL,0,NULL,0),(351,'1,2,4,333,351',NULL,NULL,0,NULL,0),(352,'1,2,4,333,351,352',NULL,NULL,0,NULL,0),(353,'1,2,4,333,351,353',NULL,NULL,0,NULL,0),(354,'1,2,4,333,351,354',NULL,NULL,0,NULL,0),(355,'1,2,4,333,355',NULL,NULL,0,NULL,0),(356,'1,2,4,333,355,356',NULL,NULL,0,NULL,0),(357,'1,2,4,333,355,357',NULL,NULL,0,NULL,0),(358,'1,2,4,333,355,358',NULL,NULL,0,NULL,0),(359,'1,2,4,333,355,359',NULL,NULL,0,NULL,0),(360,'1,2,4,333,355,360',NULL,NULL,0,NULL,0),(361,'1,2,4,333,355,361',NULL,NULL,0,NULL,0),(362,'1,2,4,333,362',NULL,NULL,0,NULL,0),(363,'1,2,4,333,362,363',NULL,NULL,0,NULL,0),(364,'1,2,4,333,362,364',NULL,NULL,0,NULL,0),(365,'1,2,4,333,362,365',NULL,NULL,0,NULL,0),(366,'1,2,4,333,362,366',NULL,NULL,0,NULL,0),(367,'1,2,4,333,362,367',NULL,NULL,0,NULL,0),(368,'1,2,4,333,362,368',NULL,NULL,0,NULL,0),(369,'1,2,4,333,362,369',NULL,NULL,0,NULL,0),(370,'1,2,4,333,362,370',NULL,NULL,0,NULL,0),(371,'1,2,4,333,362,371',NULL,NULL,0,NULL,0),(372,'1,2,4,333,372',NULL,NULL,0,NULL,0),(373,'1,2,4,333,372,373',NULL,NULL,0,NULL,0),(374,'1,2,4,333,372,374',NULL,NULL,0,NULL,0),(375,'1,2,4,333,372,375',NULL,NULL,0,NULL,0),(376,'1,2,4,333,372,376',NULL,NULL,0,NULL,0),(377,'1,2,4,333,372,377',NULL,NULL,0,NULL,0),(378,'1,2,4,333,372,378',NULL,NULL,0,NULL,0),(379,'1,2,4,333,372,379',NULL,NULL,0,NULL,0),(380,'1,2,4,333,380',NULL,NULL,0,NULL,0),(381,'1,2,4,333,380,381',NULL,NULL,0,NULL,0),(382,'1,2,4,333,380,382',NULL,NULL,0,NULL,0),(383,'1,2,4,333,380,383',NULL,NULL,0,NULL,0),(384,'1,2,4,333,380,384',NULL,NULL,0,NULL,0),(385,'1,2,4,333,380,385',NULL,NULL,0,NULL,0),(386,'1,2,4,333,380,386',NULL,NULL,0,NULL,0),(387,'1,2,4,333,380,387',NULL,NULL,0,NULL,0),(388,'1,2,4,333,380,388',NULL,NULL,0,NULL,0),(389,'1,2,4,333,389',NULL,NULL,0,NULL,0),(390,'1,2,4,333,389,390',NULL,NULL,0,NULL,0),(391,'1,2,4,333,389,391',NULL,NULL,0,NULL,0),(392,'1,2,4,333,392',NULL,NULL,0,NULL,0),(393,'1,2,4,333,392,393',NULL,NULL,0,NULL,0),(394,'1,2,4,333,392,394',NULL,NULL,0,NULL,0),(395,'1,2,4,333,392,395',NULL,NULL,0,NULL,0),(396,'1,2,4,333,392,396',NULL,NULL,0,NULL,0),(397,'1,2,4,333,392,397',NULL,NULL,0,NULL,0),(398,'1,2,4,333,392,398',NULL,NULL,0,NULL,0),(399,'1,2,4,333,392,399',NULL,NULL,0,NULL,0),(400,'1,2,4,333,392,400',NULL,NULL,0,NULL,0),(401,'1,2,4,333,401',NULL,NULL,0,NULL,0),(402,'1,2,4,333,401,402',NULL,NULL,0,NULL,0),(403,'1,2,4,333,401,403',NULL,NULL,0,NULL,0),(404,'1,2,4,333,401,404',NULL,NULL,0,NULL,0),(405,'1,2,4,333,401,405',NULL,NULL,0,NULL,0),(406,'1,2,4,333,401,406',NULL,NULL,0,NULL,0),(407,'1,2,4,333,401,407',NULL,NULL,0,NULL,0),(408,'1,2,4,333,401,408',NULL,NULL,0,NULL,0),(409,'1,2,4,333,401,409',NULL,NULL,0,NULL,0),(410,'1,2,4,333,410',NULL,NULL,0,NULL,0),(411,'1,2,4,333,411',NULL,NULL,0,NULL,0),(412,'1,2,4,333,410,412',NULL,NULL,0,NULL,0),(413,'1,2,4,333,410,413',NULL,NULL,0,NULL,0),(414,'1,2,4,333,410,414',NULL,NULL,0,NULL,0),(415,'1,2,4,333,410,415',NULL,NULL,0,NULL,0),(416,'1,2,4,333,416',NULL,NULL,0,NULL,0),(417,'1,2,4,333,416,417',NULL,NULL,0,NULL,0),(418,'1,2,4,333,416,418',NULL,NULL,0,NULL,0),(419,'1,2,4,333,416,419',NULL,NULL,0,NULL,0),(420,'1,2,4,333,416,420',NULL,NULL,0,NULL,0),(421,'1,2,4,333,416,421',NULL,NULL,0,NULL,0),(422,'1,2,4,333,416,422',NULL,NULL,0,NULL,0),(423,'1,2,4,333,423',NULL,NULL,0,NULL,0),(424,'1,2,4,333,411,424',NULL,NULL,0,NULL,0),(425,'1,2,4,333,411,425',NULL,NULL,0,NULL,0),(426,'1,2,4,333,411,426',NULL,NULL,0,NULL,0),(427,'1,2,4,333,411,427',NULL,NULL,0,NULL,0),(428,'1,2,4,333,411,428',NULL,NULL,0,NULL,0),(429,'1,2,4,333,429',NULL,NULL,0,NULL,0),(430,'1,2,4,333,429,430',NULL,NULL,0,NULL,0),(431,'1,2,4,333,429,431',NULL,NULL,0,NULL,0),(432,'1,2,3,140,172,432',NULL,NULL,0,NULL,0),(433,'1,2,3,140,172,433',NULL,NULL,0,NULL,0),(434,'1,2,3,140,172,434',NULL,NULL,0,NULL,0),(435,'1,2,3,140,172,435',NULL,NULL,0,NULL,0),(436,'1,2,3,140,172,436',NULL,NULL,0,NULL,0),(437,'1,2,3,140,172,437',NULL,NULL,0,NULL,0),(438,'1,2,3,140,172,438',NULL,NULL,0,NULL,0),(439,'1,2,3,140,172,439',NULL,NULL,0,NULL,0),(440,'1,2,3,140,440',NULL,NULL,0,NULL,0),(441,'1,2,3,140,440,441',NULL,NULL,0,NULL,0),(442,'1,2,3,140,440,442',NULL,NULL,0,NULL,0),(443,'1,2,3,140,440,443',NULL,NULL,0,NULL,0),(444,'1,2,3,140,440,443,444',NULL,NULL,0,NULL,0),(445,'1,2,3,140,440,445',NULL,NULL,0,NULL,0),(446,'1,2,3,140,440,446',NULL,NULL,0,NULL,0),(447,'1,2,3,140,440,447',NULL,NULL,0,NULL,0),(448,'1,2,3,140,440,448',NULL,NULL,0,NULL,0),(449,'1,2,3,140,440,448,449',NULL,NULL,0,NULL,0),(450,'1,2,3,140,440,450',NULL,NULL,0,NULL,0),(451,'1,2,3,140,440,450,451',NULL,NULL,0,NULL,0),(452,'1,2,3,140,440,452',NULL,NULL,0,NULL,0),(453,'1,2,3,140,440,453',NULL,NULL,0,NULL,0),(454,'1,2,3,140,440,454',NULL,NULL,0,NULL,0),(455,'1,2,3,140,455',NULL,NULL,0,NULL,0),(456,'1,2,3,140,455,456',NULL,NULL,0,NULL,0),(457,'1,2,3,140,455,457',NULL,NULL,0,NULL,0),(458,'1,2,3,140,455,458',NULL,NULL,0,NULL,0),(459,'1,2,3,140,455,459',NULL,NULL,0,NULL,0),(460,'1,2,3,140,455,460',NULL,NULL,0,NULL,0),(461,'1,2,3,140,455,461',NULL,NULL,0,NULL,0),(462,'1,2,3,140,455,462',NULL,NULL,0,NULL,0),(463,'1,2,3,140,455,463',NULL,NULL,0,NULL,0),(464,'1,2,3,140,455,464',NULL,NULL,0,NULL,0),(465,'1,2,3,140,455,465',NULL,NULL,0,NULL,0),(466,'1,2,3,140,455,466',NULL,NULL,0,NULL,0),(467,'1,2,3,140,467',NULL,NULL,0,NULL,0),(468,'1,2,3,140,467,468',NULL,NULL,0,NULL,0),(469,'1,2,3,140,467,469',NULL,NULL,0,NULL,0),(470,'1,2,3,140,467,470',NULL,NULL,0,NULL,0),(471,'1,2,3,140,467,471',NULL,NULL,0,NULL,0),(472,'1,2,3,140,467,472',NULL,NULL,0,NULL,0),(473,'1,2,3,140,467,473',NULL,NULL,0,NULL,0),(474,'1,2,3,140,467,474',NULL,NULL,0,NULL,0),(475,'1,2,3,140,467,475',NULL,NULL,0,NULL,0),(476,'1,2,3,140,467,476',NULL,NULL,0,NULL,0),(477,'1,2,3,140,467,477',NULL,NULL,0,NULL,0),(478,'1,2,3,140,467,478',NULL,NULL,0,NULL,0),(479,'1,2,3,140,467,479',NULL,NULL,0,NULL,0),(480,'1,2,3,140,467,480',NULL,NULL,0,NULL,0),(481,'1,2,3,140,467,481',NULL,NULL,0,NULL,0),(482,'1,2,3,140,482',NULL,NULL,0,NULL,0),(483,'1,2,3,140,482,483',NULL,NULL,0,NULL,0),(484,'1,2,3,140,482,484',NULL,NULL,0,NULL,0),(485,'1,2,3,140,482,485',NULL,NULL,0,NULL,0),(486,'1,2,3,140,482,485,486',NULL,NULL,0,NULL,0),(487,'1,2,3,140,482,485,487',NULL,NULL,0,NULL,0),(488,'1,2,3,140,482,488',NULL,NULL,0,NULL,0),(489,'1,2,3,140,489',NULL,NULL,0,NULL,0),(490,'1,2,3,140,489,490',NULL,NULL,0,NULL,0),(491,'1,2,3,140,489,491',NULL,NULL,0,NULL,0),(492,'1,2,3,140,489,492',NULL,NULL,0,NULL,0),(493,'1,2,3,140,489,493',NULL,NULL,0,NULL,0),(494,'1,2,3,140,489,494',NULL,NULL,0,NULL,0),(495,'1,2,3,140,489,495',NULL,NULL,0,NULL,0),(496,'1,2,3,140,489,496',NULL,NULL,0,NULL,0),(497,'1,2,3,140,489,497',NULL,NULL,0,NULL,0),(498,'1,2,3,140,489,498',NULL,NULL,0,NULL,0),(499,'1,2,3,140,489,499',NULL,NULL,0,NULL,0),(500,'1,2,3,140,489,500',NULL,NULL,0,NULL,0),(501,'1,2,4,333,501',NULL,NULL,0,NULL,0),(502,'1,2,4,333,501,502',NULL,NULL,0,NULL,0),(503,'1,2,4,333,501,503',NULL,NULL,0,NULL,0),(504,'1,2,4,333,501,504',NULL,NULL,0,NULL,0),(505,'1,2,3,140,505',NULL,NULL,0,NULL,0),(506,'1,2,3,140,505,506',NULL,NULL,0,NULL,0),(507,'1,2,3,140,505,507',NULL,NULL,0,NULL,0),(508,'1,2,3,140,505,508',NULL,NULL,0,NULL,0),(509,'1,2,3,140,505,509',NULL,NULL,0,NULL,0),(510,'1,2,3,140,510',NULL,NULL,0,NULL,0),(511,'1,2,3,140,510,511',NULL,NULL,0,NULL,0),(512,'1,2,3,140,510,512',NULL,NULL,0,NULL,0),(513,'1,2,3,140,510,513',NULL,NULL,0,NULL,0),(514,'1,2,3,140,510,514',NULL,NULL,0,NULL,0),(515,'1,2,3,140,510,515',NULL,NULL,0,NULL,0),(516,'1,2,4,333,516',NULL,NULL,0,NULL,0),(517,'1,2,4,333,516,517',NULL,NULL,0,NULL,0),(518,'1,2,4,333,516,518',NULL,NULL,0,NULL,0),(519,'1,2,4,333,516,519',NULL,NULL,0,NULL,0),(520,'1,2,4,333,516,520',NULL,NULL,0,NULL,0),(521,'1,2,4,333,516,521',NULL,NULL,0,NULL,0),(522,'1,2,4,136,522',NULL,NULL,0,NULL,0),(523,'1,2,4,136,522,523',NULL,NULL,0,NULL,0),(524,'1,2,4,136,522,524',NULL,NULL,0,NULL,0),(525,'1,2,4,136,522,525',NULL,NULL,0,NULL,0),(526,'1,2,4,136,522,526',NULL,NULL,0,NULL,0),(527,'1,2,3,140,527',NULL,NULL,0,NULL,0),(528,'1,2,3,140,527,528',NULL,NULL,0,NULL,0),(529,'1,2,3,140,527,529',NULL,NULL,0,NULL,0),(530,'1,2,3,140,527,530',NULL,NULL,0,NULL,0),(531,'1,2,3,140,527,531',NULL,NULL,0,NULL,0),(532,'1,2,3,140,527,532',NULL,NULL,0,NULL,0),(533,'1,2,3,140,533',NULL,NULL,0,NULL,0),(534,'1,2,3,140,533,534',NULL,NULL,0,NULL,0),(535,'1,2,3,140,533,535',NULL,NULL,0,NULL,0),(536,'1,2,3,140,533,536',NULL,NULL,0,NULL,0),(537,'1,2,3,140,533,535,537',NULL,NULL,0,NULL,0),(538,'1,2,3,140,533,535,538',NULL,NULL,0,NULL,0),(539,'1,2,3,140,533,535,538,539',NULL,NULL,0,NULL,0),(540,'1,2,3,140,533,535,540',NULL,NULL,0,NULL,0),(541,'1,2,3,140,533,535,540,541',NULL,NULL,0,NULL,0),(542,'1,2,3,140,533,535,540,542',NULL,NULL,0,NULL,0),(543,'1,2,3,140,533,543',NULL,NULL,0,NULL,0),(544,'1,2,3,140,533,544',NULL,NULL,0,NULL,0),(545,'1,2,3,140,533,545',NULL,NULL,0,NULL,0),(546,'1,2,3,140,533,546',NULL,NULL,0,NULL,0),(547,'1,2,3,140,533,535,547',NULL,NULL,0,NULL,0),(548,'1,2,3,140,533,535,547,548',NULL,NULL,0,NULL,0),(549,'1,2,3,140,533,535,547,549',NULL,NULL,0,NULL,0),(550,'1,2,3,140,533,535,550',NULL,NULL,0,NULL,0),(551,'1,2,3,140,533,535,551',NULL,NULL,0,NULL,0),(552,'1,2,3,140,533,535,551,552',NULL,NULL,0,NULL,0),(553,'1,2,3,140,553',NULL,NULL,0,NULL,0),(554,'1,2,3,140,553,554',NULL,NULL,0,NULL,0),(555,'1,2,3,140,553,555',NULL,NULL,0,NULL,0),(556,'1,2,3,140,553,556',NULL,NULL,0,NULL,0),(557,'1,2,3,140,553,557',NULL,NULL,0,NULL,0),(558,'1,2,3,140,553,555,558',NULL,NULL,0,NULL,0),(559,'1,2,3,140,559',NULL,NULL,0,NULL,0),(560,'1,2,3,140,559,560',NULL,NULL,0,NULL,0),(561,'1,2,3,140,559,561',NULL,NULL,0,NULL,0),(562,'1,2,3,140,559,561,562',NULL,NULL,0,NULL,0),(563,'1,2,3,140,559,561,563',NULL,NULL,0,NULL,0),(564,'1,2,3,140,559,561,564',NULL,NULL,0,NULL,0),(565,'1,2,3,140,559,561,564,565',NULL,NULL,0,NULL,0),(566,'1,2,3,140,559,566',NULL,NULL,0,NULL,0),(567,'1,2,3,140,559,561,567',NULL,NULL,0,NULL,0),(568,'1,2,3,140,559,561,568',NULL,NULL,0,NULL,0),(569,'1,2,3,140,559,561,569',NULL,NULL,0,NULL,0),(570,'1,2,4,136,570',NULL,NULL,0,NULL,0),(571,'1,2,4,136,570,571',NULL,NULL,0,NULL,0),(572,'1,2,4,136,570,572',NULL,NULL,0,NULL,0),(573,'1,2,4,136,570,573',NULL,NULL,0,NULL,0),(574,'1,2,4,136,570,574',NULL,NULL,0,NULL,0),(575,'1,2,4,136,570,575',NULL,NULL,0,NULL,0),(576,'1,2,4,136,570,576',NULL,NULL,0,NULL,0),(577,'1,2,4,136,570,577',NULL,NULL,0,NULL,0),(578,'1,2,4,136,570,578',NULL,NULL,0,NULL,0),(579,'1,2,4,136,570,579',NULL,NULL,0,NULL,0),(580,'1,2,4,136,570,580',NULL,NULL,0,NULL,0),(581,'1,2,4,136,570,581',NULL,NULL,0,NULL,0),(582,'1,2,4,136,570,582',NULL,NULL,0,NULL,0),(583,'1,2,4,136,570,583',NULL,NULL,0,NULL,0),(584,'1,2,4,136,570,584',NULL,NULL,0,NULL,0),(585,'1,2,4,136,570,585',NULL,NULL,0,NULL,0),(586,'1,2,4,136,570,586',NULL,NULL,0,NULL,0),(587,'1,2,4,136,570,587',NULL,NULL,0,NULL,0),(588,'1,2,4,136,570,588',NULL,NULL,0,NULL,0),(589,'1,2,4,136,570,589',NULL,NULL,0,NULL,0),(590,'1,2,4,136,570,590',NULL,NULL,0,NULL,0),(591,'1,2,4,136,570,591',NULL,NULL,0,NULL,0),(592,'1,2,4,136,570,592',NULL,NULL,0,NULL,0),(593,'1,2,4,136,593',NULL,NULL,0,NULL,0),(594,'1,2,4,136,593,594',NULL,NULL,0,NULL,0),(595,'1,2,4,136,593,595',NULL,NULL,0,NULL,0),(596,'1,2,4,136,593,596',NULL,NULL,0,NULL,0),(597,'1,2,4,136,597',NULL,NULL,0,NULL,0),(598,'1,2,4,136,597,598',NULL,NULL,0,NULL,0),(599,'1,2,4,136,597,599',NULL,NULL,0,NULL,0),(600,'1,2,4,136,597,600',NULL,NULL,0,NULL,0),(601,'1,2,4,136,597,601',NULL,NULL,0,NULL,0),(602,'1,2,4,136,602',NULL,NULL,0,NULL,0),(603,'1,2,4,136,602,603',NULL,NULL,0,NULL,0),(604,'1,2,4,136,602,604',NULL,NULL,0,NULL,0),(605,'1,2,4,136,602,605',NULL,NULL,0,NULL,0),(606,'1,2,4,136,602,606',NULL,NULL,0,NULL,0),(607,'1,2,3,140,607',NULL,NULL,0,NULL,0),(608,'1,2,3,140,607,608',NULL,NULL,0,NULL,0),(609,'1,2,3,140,607,609',NULL,NULL,0,NULL,0),(610,'1,2,3,140,607,610',NULL,NULL,0,NULL,0),(611,'1,2,3,140,607,611',NULL,NULL,0,NULL,0),(612,'1,2,3,140,607,612',NULL,NULL,0,NULL,0),(613,'1,2,3,140,607,613',NULL,NULL,0,NULL,0),(614,'1,2,3,140,607,614',NULL,NULL,0,NULL,0),(615,'1,2,3,140,607,615',NULL,NULL,0,NULL,0),(616,'1,2,3,140,607,616',NULL,NULL,0,NULL,0),(617,'1,2,3,140,607,617',NULL,NULL,0,NULL,0),(618,'1,2,3,140,607,618',NULL,NULL,0,NULL,0),(619,'1,2,3,140,607,619',NULL,NULL,0,NULL,0),(620,'1,2,3,140,607,620',NULL,NULL,0,NULL,0),(621,'1,2,3,140,607,621',NULL,NULL,0,NULL,0),(622,'1,2,3,140,607,622',NULL,NULL,0,NULL,0),(623,'1,2,3,140,607,623',NULL,NULL,0,NULL,0),(624,'1,2,3,140,607,624',NULL,NULL,0,NULL,0),(625,'1,2,3,140,607,625',NULL,NULL,0,NULL,0),(626,'1,2,3,140,607,626',NULL,NULL,0,NULL,0),(627,'1,2,3,140,607,627',NULL,NULL,0,NULL,0),(628,'1,2,3,140,607,628',NULL,NULL,0,NULL,0),(629,'1,2,3,140,607,629',NULL,NULL,0,NULL,0),(630,'1,2,3,140,607,630',NULL,NULL,0,NULL,0),(631,'1,2,3,140,607,631',NULL,NULL,0,NULL,0),(632,'1,2,3,140,607,632',NULL,NULL,0,NULL,0),(633,'1,2,3,140,607,633',NULL,NULL,0,NULL,0),(634,'1,2,3,140,141,634',NULL,NULL,0,NULL,0),(635,'1,2,4,136,137,635',NULL,NULL,0,NULL,0),(636,'1,2,4,136,137,636',NULL,NULL,0,NULL,0),(642,'1,642',NULL,NULL,0,7,0),(643,'1,2,3,140,141,643',NULL,NULL,0,NULL,0),(644,'1,2,4,136,644',NULL,NULL,0,NULL,0),(645,'1,2,4,136,644,645',NULL,NULL,0,NULL,0),(646,'1,2,4,136,644,646',NULL,NULL,0,NULL,0),(651,'1,2,3,140,651',NULL,NULL,0,NULL,0),(652,'1,2,3,140,651,652',NULL,NULL,0,NULL,0),(653,'1,2,3,140,651,653',NULL,NULL,0,NULL,0),(654,'1,2,3,140,651,653,654',NULL,NULL,0,NULL,0),(655,'1,2,3,140,651,653,654,655',NULL,NULL,0,NULL,0),(656,'1,2,3,140,656',NULL,NULL,0,NULL,0),(657,'1,2,3,140,656,657',NULL,NULL,0,NULL,0),(658,'1,2,3,140,656,658',NULL,NULL,0,NULL,0),(659,'1,2,3,140,656,659',NULL,NULL,0,NULL,0),(660,'1,2,3,140,656,660',NULL,NULL,0,NULL,0),(661,'1,2,3,140,656,661',NULL,NULL,0,NULL,0),(663,'1,2,90,129,663',NULL,NULL,0,NULL,0),(665,'1,665',NULL,NULL,0,7,0),(666,'1,150,666',NULL,NULL,0,1,0),(667,'1,150,667',NULL,NULL,0,1,0),(668,'1,668',NULL,NULL,1,6,0),(669,'1,2,3,140,669',NULL,NULL,0,NULL,0),(670,'1,2,3,140,669,670',NULL,NULL,0,NULL,0),(671,'1,2,3,140,669,671',NULL,NULL,0,NULL,0),(672,'1,2,3,140,669,672',NULL,NULL,0,NULL,0),(674,'1,150,674',NULL,NULL,0,1,0),(678,'1,150,678',NULL,NULL,0,1,0),(679,'1,150,679',NULL,NULL,0,1,0),(680,'1,150,680',NULL,NULL,0,1,0),(681,'1,150,681',NULL,NULL,0,1,0),(683,'1,2,3,140,533,683',NULL,NULL,0,NULL,0),(684,'1,2,3,140,533,684',NULL,NULL,0,NULL,0),(685,'1,2,4,333,685',NULL,NULL,0,NULL,0),(686,'1,2,4,333,685,686',NULL,NULL,0,NULL,0),(687,'1,2,4,333,685,687',NULL,NULL,0,NULL,0),(703,'1,2,3,140,141,703',NULL,NULL,0,NULL,0),(704,'1,150,704',NULL,NULL,0,1,0),(706,'1,706',NULL,NULL,0,7,0),(713,'1,713',NULL,NULL,0,7,0),(718,'1,2,3,140,607,718',NULL,NULL,0,NULL,0),(721,'1,721',NULL,NULL,0,7,0),(722,'1,2,3,140,311,722',NULL,NULL,0,NULL,0),(732,'1,732',NULL,NULL,0,7,0),(733,'1,733',NULL,NULL,0,7,0),(845,'1,2,3,140,510,845',NULL,NULL,0,NULL,0),(846,'1,2,3,140,510,846',NULL,NULL,0,NULL,0),(847,'1,2,3,140,553,847',NULL,NULL,0,NULL,0),(848,'1,2,3,140,482,848',NULL,NULL,0,NULL,0),(849,'1,2,3,140,455,849',NULL,NULL,0,NULL,0),(850,'1,2,3,140,505,850',NULL,NULL,0,NULL,0),(851,'1,2,3,140,559,851',NULL,NULL,0,NULL,0),(852,'1,2,3,140,489,852',NULL,NULL,0,NULL,0),(853,'1,2,3,140,440,853',NULL,NULL,0,NULL,0),(854,'1,2,3,140,656,854',NULL,NULL,0,NULL,0),(855,'1,2,3,140,467,855',NULL,NULL,0,NULL,0),(856,'1,2,3,140,651,856',NULL,NULL,0,NULL,0),(857,'1,2,3,140,172,857',NULL,NULL,0,NULL,0),(858,'1,2,3,140,553,858',NULL,NULL,0,NULL,0),(859,'1,2,3,140,482,859',NULL,NULL,0,NULL,0),(860,'1,2,3,140,455,860',NULL,NULL,0,NULL,0),(861,'1,2,3,140,505,861',NULL,NULL,0,NULL,0),(862,'1,2,3,140,559,862',NULL,NULL,0,NULL,0),(863,'1,2,3,140,440,863',NULL,NULL,0,NULL,0),(864,'1,2,3,140,656,864',NULL,NULL,0,NULL,0),(865,'1,2,3,140,467,865',NULL,NULL,0,NULL,0),(866,'1,2,3,140,651,866',NULL,NULL,0,NULL,0),(867,'1,2,3,140,172,867',NULL,NULL,0,NULL,0),(870,'1,2,3,140,651,870',NULL,NULL,0,NULL,0),(879,'1,879',NULL,NULL,0,7,0),(896,'1,896',NULL,NULL,0,7,0),(897,'1,150,897',NULL,NULL,0,1,0),(937,'1,937',NULL,NULL,0,7,0),(938,'1,2,4,333,346,347,938',NULL,NULL,0,NULL,0),(939,'1,2,4,333,346,347,939',NULL,NULL,0,NULL,0),(940,'1,2,4,333,346,347,940',NULL,NULL,0,NULL,0),(941,'1,2,4,333,346,347,941',NULL,NULL,0,NULL,0),(952,'1,2,4,136,952',NULL,NULL,0,NULL,0),(953,'1,2,4,136,952,953',NULL,NULL,0,NULL,0),(954,'1,2,4,136,952,954',NULL,NULL,0,NULL,0),(955,'1,2,4,136,952,955',NULL,NULL,0,NULL,0),(962,'1,2,4,136,952,962',NULL,NULL,0,NULL,0),(963,'1,2,60,963',NULL,NULL,0,NULL,0),(970,'1,2,3,140,970',NULL,NULL,0,NULL,0),(972,'1,2,3,140,972',NULL,NULL,0,NULL,0),(973,'1,2,3,140,972,973',NULL,NULL,0,NULL,0),(976,'1,2,3,140,976',NULL,NULL,0,NULL,0),(977,'1,2,3,140,976,977',NULL,NULL,0,NULL,0),(978,'1,2,60,978',NULL,NULL,0,NULL,0);
/*!40000 ALTER TABLE `tree_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tree_info_bu` BEFORE UPDATE ON `tree_info` FOR EACH ROW BEGIN

	if(

		(old.pids <> new.pids)

		OR(old.path <> new.path)

		OR ( coalesce(old.case_id, 0) <> coalesce(new.case_id, 0) )

		OR (old.acl_count <> new.acl_count)

		OR ( COALESCE(old.security_set_id, 0) <> COALESCE(new.security_set_id, 0) )

	)

	THEN

		SET new.updated = 1;

	END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tree_user_config`
--

DROP TABLE IF EXISTS `tree_user_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree_user_config` (
  `guid` varchar(50) NOT NULL COMMENT 'id of the tree node or vitual node',
  `user_id` int(10) unsigned NOT NULL,
  `cfg` text,
  PRIMARY KEY (`guid`,`user_id`),
  KEY `tree_user_config__user_id` (`user_id`),
  CONSTRAINT `tree_user_config__user_id` FOREIGN KEY (`user_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_user_config`
--

LOCK TABLES `tree_user_config` WRITE;
/*!40000 ALTER TABLE `tree_user_config` DISABLE KEYS */;
INSERT INTO `tree_user_config` VALUES ('3-recycleBin',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"cid\":{\"idx\":2,\"width\":200,\"sortable\":true},\"ddate\":{\"idx\":3,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"ASC\"},\"group\":null}'),('default',1,'{\"columns\":{\"name\":{\"idx\":0,\"width\":362,\"sortable\":true},\"nid\":{\"idx\":1,\"width\":80,\"sortable\":true},\"date\":{\"idx\":2,\"width\":130,\"sortable\":true},\"size\":{\"idx\":3,\"width\":80,\"sortable\":true},\"cid\":{\"idx\":4,\"width\":200,\"sortable\":true},\"oid\":{\"idx\":5,\"width\":200,\"sortable\":true},\"cdate\":{\"idx\":6,\"width\":130,\"sortable\":true},\"udate\":{\"idx\":7,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"ASC\"},\"group\":null}'),('template_11',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"type\":{\"idx\":2,\"width\":100,\"sortable\":true},\"cfg\":{\"idx\":3,\"width\":100,\"sortable\":true},\"order\":{\"idx\":4,\"width\":98,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"nid\",\"direction\":\"ASC\"},\"group\":null}'),('template_141',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"cid\":{\"idx\":2,\"width\":200,\"sortable\":true},\"cdate\":{\"idx\":3,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"nid\",\"direction\":\"ASC\"},\"group\":null}'),('template_5',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":40,\"sortable\":true},\"name\":{\"idx\":1,\"width\":243,\"sortable\":true},\"oid\":{\"idx\":2,\"width\":177,\"sortable\":true},\"cid\":{\"idx\":3,\"width\":177,\"sortable\":true},\"cdate\":{\"idx\":4,\"width\":207,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"ASC\"},\"group\":null}');
/*!40000 ALTER TABLE `tree_user_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT '2',
  `system` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `first_name` varchar(60) DEFAULT NULL,
  `last_name` varchar(60) DEFAULT NULL,
  `l1` varchar(150) DEFAULT NULL,
  `l2` varchar(150) DEFAULT NULL,
  `l3` varchar(150) DEFAULT NULL,
  `l4` varchar(150) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `password_change` date DEFAULT NULL,
  `recover_hash` varchar(100) DEFAULT NULL,
  `language_id` int(10) unsigned NOT NULL DEFAULT '1',
  `cfg` longtext NOT NULL,
  `data` longtext NOT NULL,
  `last_login` int(11) DEFAULT NULL,
  `login_successful` int(11) DEFAULT NULL,
  `login_from_ip` varchar(40) DEFAULT NULL,
  `last_logout` int(11) DEFAULT NULL,
  `last_action_time` int(11) DEFAULT NULL,
  `enabled` int(11) DEFAULT '1',
  `cid` int(10) unsigned DEFAULT NULL,
  `cdate` int(11) NOT NULL DEFAULT '0',
  `uid` int(10) unsigned DEFAULT NULL,
  `udate` varchar(255) DEFAULT '0000-00-00 00:00:00',
  `did` int(10) unsigned DEFAULT NULL,
  `ddate` int(11) DEFAULT NULL,
  `searchField` longtext,
  `salt` varchar(255) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_type__name` (`type`,`name`),
  KEY `IDX_recover_hash` (`recover_hash`),
  KEY `FK_users_groups_language` (`language_id`),
  KEY `IDX_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (1,2,1,'root','Administrator','','Administrator','Administrator','Administrator','Administrator','m','tjones@this.com','1_josh.jpg.png','50775b4f5109fd22c46dabb17f710c17','2016-11-01',NULL,1,'{\"short_date_format\":\"m\\/d\\/Y\",\"long_date_format\":\"F j, Y\",\"country_code\":\"\",\"phone\":\"\",\"timezone\":\"\",\"security\":{\"recovery_email\":true,\"email\":\"admin@mail.server.com\",\"TSV\":null},\"state\":{\"mAc\":{\"width\":250,\"weight\":-10},\"mopp\":{\"width\":315,\"collapsed\":false,\"weight\":-20},\"oew100\":{\"width\":1280,\"height\":672,\"maximized\":true,\"size\":{\"width\":600,\"height\":450},\"pos\":[1010,106]},\"oevg\":{\"columns\":{\"title\":{\"idx\":0,\"width\":316},\"value\":{\"idx\":1,\"flex\":1}},\"group\":null},\"oew94\":{\"width\":600,\"height\":450,\"maximized\":false,\"size\":{\"width\":600,\"height\":450},\"pos\":[1010,106]},\"oew12\":{\"width\":600,\"height\":450,\"maximized\":false,\"size\":{\"width\":600,\"height\":450},\"pos\":[604,106]},\"oew91\":{\"width\":600,\"height\":450,\"maximized\":false,\"size\":{\"width\":600,\"height\":450},\"pos\":[1010,106]},\"btree\":{\"paths\":[\"\\/1\",\"\\/1\\/150\",\"\\/1\\/668\",\"\\/1\\/2\",\"\\/1\\/2\\/60\",\"\\/1\\/2\\/4\",\"\\/1\\/3-recycleBin\"],\"width\":250,\"selected\":\"\\/1\\/3-recycleBin\",\"weight\":0},\"veg\":{\"columns\":{\"title\":{\"idx\":0,\"width\":100},\"value\":{\"idx\":1,\"flex\":1}},\"group\":null},\"uploadGrid\":{\"columns\":{\"name\":{\"idx\":0,\"width\":150},\"size\":{\"idx\":1,\"width\":90,\"sortable\":true},\"status\":{\"idx\":2,\"width\":75,\"sortable\":true},\"loaded\":{\"idx\":3,\"width\":75,\"sortable\":true},\"pathtext\":{\"idx\":4,\"width\":200,\"sortable\":true},\"msg\":{\"idx\":5,\"width\":175,\"hidden\":true,\"sortable\":true}},\"group\":null},\"oew141\":{\"width\":1920,\"height\":986,\"maximized\":true,\"size\":{\"width\":600,\"height\":450},\"pos\":[0,0]},\"oew7\":{\"width\":1920,\"height\":986,\"maximized\":true,\"size\":{\"width\":600,\"height\":450},\"pos\":[0,0]}},\"color\":\"#8fada9\",\"lastNotifyTime\":\"2016-12-08 18:04:39\",\"max_rows\":25,\"lastSeenActionId\":727,\"theme\":\"crisp-touch\",\"notificationSettings\":{\"notifyFor\":\"all\",\"delay\":1,\"delaySize\":15}}','{\"email\":\"a\"}',1481219192,0,'192.168.33.1',1481220316,2016,1,1,0,1,'2013-03-20 12:57:29',NULL,NULL,' root Administrator  Administrator Administrator Administrator Administrator tjones@this.com ','13fc2d6342d313642320b81dc2c54623','{“ROLE_USER\":\"ROLE_USER”}'),(2,1,1,'everyone','Everyone',NULL,'Everyone','Everyone','Everyone','Everyone',NULL,'',NULL,NULL,NULL,NULL,1,'','',NULL,NULL,NULL,NULL,NULL,1,NULL,2015,NULL,'0000-00-00 00:00:00',NULL,NULL,' everyone Everyone Everyone Everyone Everyone  ','','');
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_groups_bi` BEFORE INSERT ON `users_groups` FOR EACH ROW BEGIN

	set new.searchField = concat(

		' '

		,coalesce(new.name, '')

		,' '

		,COALESCE(new.first_name, '')

		,' '

		,COALESCE(new.last_name, '')

		,' '

		,COALESCE(new.l1, '')

		,' '

		,COALESCE(new.l2, '')

		,' '

		,COALESCE(new.l3, '')

		,' '

		,COALESCE(new.l4, '')

		,' '

		,COALESCE(new.email, '')

		,' '

	);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_groups_ai` AFTER INSERT ON `users_groups` FOR EACH ROW BEGIN

	declare tmp_everyone_user_id int unsigned;

	

	IF( new.type = 2 ) THEN

		

		SELECT id

		into tmp_everyone_user_id

		FROM users_groups

		WHERE `type` = 1

			AND `system` = 1

			AND name = 'everyone';

		

		update `tree_acl_security_sets`

		set updated = 1

			where id in (

				select distinct security_set_id

				from `tree_acl_security_sets_result`

				where user_id = tmp_everyone_user_id

			)

		;

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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_groups_bu` BEFORE UPDATE ON `users_groups` FOR EACH ROW BEGIN

	SET new.searchField = CONCAT(

		' '

		,COALESCE(new.name, '')

		,' '

		,COALESCE(new.first_name, '')

		,' '

		,COALESCE(new.last_name, '')

		,' '

		,COALESCE(new.l1, '')

		,' '

		,COALESCE(new.l2, '')

		,' '

		,COALESCE(new.l3, '')

		,' '

		,COALESCE(new.l4, '')

		,' '

		,COALESCE(new.email, '')

		,' '

	);

	if( coalesce(old.password, '') <> coalesce(new.password, '') ) THEN

		set new.password_change = CURRENT_DATE;

	end if;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users_groups_association`
--

DROP TABLE IF EXISTS `users_groups_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups_association` (
  `user_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `cid` int(11) unsigned NOT NULL DEFAULT '1',
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` int(11) unsigned DEFAULT NULL,
  `udate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `FK_users_groups_association__group_id` (`group_id`),
  CONSTRAINT `FK_users_groups_association__group_id` FOREIGN KEY (`group_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_users_groups_association__user_id` FOREIGN KEY (`user_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups_association`
--

LOCK TABLES `users_groups_association` WRITE;
/*!40000 ALTER TABLE `users_groups_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups_association` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_groups_association_ai` AFTER INSERT ON `users_groups_association` FOR EACH ROW BEGIN

	

	UPDATE tree_acl_security_sets

	SET updated = 1

		WHERE id IN (

			SELECT DISTINCT ti.security_set_id

			FROM `tree_acl` ta

			JOIN tree_info ti ON ti.`id` = ta.`node_id`

			WHERE ta.`user_group_id` = new.group_id

		)

	;

	

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_groups_association_ad` AFTER DELETE ON `users_groups_association` FOR EACH ROW BEGIN

	

	UPDATE tree_acl_security_sets

	SET updated = 1

		WHERE id IN (

			SELECT DISTINCT security_set_id

			FROM `tree_acl_security_sets_result`

			WHERE user_id = old.user_id

		)

	;

	

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'ecmrs'
--
/*!50003 DROP FUNCTION IF EXISTS `f_get_next_autoincrement_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_next_autoincrement_id`(in_tablename tinytext) RETURNS int(11)
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN

	return (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME = in_tablename);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_objects_case_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_objects_case_id`(in_id int unsigned) RETURNS int(10) unsigned
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN

	declare tmp_pid int unsigned;

	DECLARE tmp_type varchar(10);

	DECLARE tmp_path TEXT CHARSET utf8 DEFAULT '';

	SET tmp_path = CONCAT('/', in_id);

	select t.pid, tp.`type` into tmp_pid, tmp_type from tree t left join templates tp on t.template_id = tp.id where t.id = in_id;

	WHILE((tmp_pid IS NOT NULL) AND (COALESCE(tmp_type,'') <> 'case') AND ( INSTR(CONCAT(tmp_path, '/'), CONCAT('/',tmp_pid,'/') ) =0) ) DO

		SET tmp_path = CONCAT('/', tmp_pid, tmp_path);

		SET in_id = tmp_pid;

		

		SELECT t.pid, tp.`type` INTO tmp_pid, tmp_type FROM tree t LEFT JOIN templates tp ON t.template_id = tp.id WHERE t.id = in_id;

	END WHILE;

	IF(COALESCE(tmp_type,'') <> 'case') THEN

		set in_id = null;

	end if;

	return in_id;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_security_set_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_security_set_id`(in_id bigint unsigned) RETURNS int(10) unsigned
    MODIFIES SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

	DECLARE tmp_i

		,tmp_new_security_set_id BIGINT UNSIGNED DEFAULT NULL;

	DECLARE tmp_inherit_acl INT DEFAULT NULL;

	DECLARE tmp_ids_path

		,tmp_element

		,tmp_security_set VARCHAR(9999) DEFAULT '';

	DECLARE tmp_acl_count INT UNSIGNED DEFAULT 0;

	SET tmp_i = 1;

	set tmp_ids_path = f_get_tree_ids_path(in_id);

	set tmp_element = `sfm_get_path_element`(tmp_ids_path, '/', tmp_i);

	while(tmp_element <> '')DO

		select inherit_acl

		into tmp_inherit_acl

		from tree

		where id = tmp_element;

		if(tmp_inherit_acl = 1) THEN

			SELECT COUNT(*)

			into tmp_acl_count

			FROM tree_acl

			WHERE node_id = tmp_element;

			if(tmp_acl_count > 0)THEN

				set tmp_security_set = trim(',' FROM concat(tmp_security_set, ',', tmp_element));

			end if;

		ELSE

			SET tmp_security_set = tmp_element;

		END IF;

		set tmp_i = tmp_i + 1;

		SET tmp_element = `sfm_get_path_element`(tmp_ids_path, '/', tmp_i);

		set tmp_acl_count = 0;

	END WHILE;

	if(tmp_security_set <> '') THEN

		set tmp_i = null;

		select id

		into tmp_i

		from tree_acl_security_sets

		where `md5` = md5(tmp_security_set);

		if(tmp_i is null) then

			insert into `tree_acl_security_sets` (`set`)

			values(tmp_security_set)

			on duplicate key update id = last_insert_id(id);

			set tmp_i = last_insert_id();

		END IF;

		return tmp_i;

	END IF;

	return null;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_tag_pids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_tag_pids`(in_id int UNSIGNED) RETURNS varchar(300) CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

	declare rez varchar(300) CHARSET utf8;

	declare tmp_pid int UNSIGNED;

	set rez = in_id;

	select pid INTO tmp_pid from tags where id = in_id;

	while(tmp_pid is not null)do

		SET rez = CONCAT(tmp_pid, '/', rez);

		SELECT pid INTO tmp_pid FROM tags WHERE id = tmp_pid;

	END while;

	return rez;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_tree_ids_path` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_tree_ids_path`(in_id bigint unsigned) RETURNS text CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'Returns element ids path from the tree'
BEGIN

	DECLARE tmp_pid BIGINT UNSIGNED DEFAULT NULL;

	DECLARE rez text CHARSET utf8 DEFAULT '';

	set rez = concat('/', in_id);

	SELECT pid INTO tmp_pid FROM tree WHERE id = in_id;

	WHILE( (tmp_pid IS NOT NULL) and ( INSTR(concat(rez, '/'), concat('/', tmp_pid, '/') ) =0) ) DO

		SET rez = CONCAT('/', tmp_pid, rez);

		SELECT pid INTO tmp_pid FROM tree WHERE id = tmp_pid;

	END WHILE;

	RETURN rez;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_tree_inherit_ids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_tree_inherit_ids`(in_id bigint unsigned) RETURNS text CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'Returns element ids path from the tree which inherit acl from parents'
BEGIN

	DECLARE tmp_pid BIGINT UNSIGNED DEFAULT NULL;

	DECLARE tmp_acl_count INT UNSIGNED DEFAULT 0;

	DECLARE tmp_inherit BOOL DEFAULT NULL;

	DECLARE rez text CHARSET utf8 DEFAULT '';

	SELECT pid, inherit_acl, acl_count INTO tmp_pid, tmp_inherit, tmp_acl_count FROM tree WHERE id = in_id;

	IF( tmp_acl_count > 0 ) THEN

		SET rez = CONCAT('/', in_id);

	END IF;

	WHILE( (tmp_pid IS NOT NULL) AND (tmp_inherit = 1) and ( INSTR(concat(rez, '/'), concat('/', tmp_pid, '/') ) = 0) ) DO

		SET in_id = tmp_pid;

		SELECT pid, inherit_acl, acl_count INTO tmp_pid, tmp_inherit, tmp_acl_count FROM tree WHERE id = in_id;

		IF( tmp_acl_count > 0 ) THEN

			SET rez = CONCAT('/', in_id, rez);

		END IF;

	END WHILE;

	RETURN rez;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_tree_path` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_tree_path`(in_id bigint unsigned) RETURNS text CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'Returns element path from the tree'
BEGIN

	DECLARE tmp_pid BIGINT UNSIGNED DEFAULT NULL;

	DECLARE tmp_name varchar(500) CHARSET utf8 DEFAULT '';

	DECLARE rez text CHARSET utf8 DEFAULT '';

	DECLARE tmp_path TEXT CHARSET utf8 DEFAULT '';

	SET tmp_path = CONCAT('/', in_id);

	SELECT pid INTO tmp_pid FROM tree WHERE id = in_id;

	WHILE( (tmp_pid IS NOT NULL) AND ( INSTR(CONCAT(tmp_path, '/'), concat('/',tmp_pid,'/') ) =0) ) DO

		SET tmp_path = CONCAT('/', tmp_pid, tmp_path);

		SET rez = CONCAT('/', tmp_name, rez);

		SELECT pid, `name` INTO tmp_pid, tmp_name FROM tree WHERE id = tmp_pid;

	END WHILE;

	RETURN rez;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_get_tree_pids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_get_tree_pids`(in_id bigint unsigned) RETURNS varchar(500) CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

	declare tmp_pid bigint unsigned default null;

	DECLARE rez varchar(500) CHARSET utf8 default '';

	select pid into tmp_pid from tree where id = in_id;

	while( (tmp_pid is not null) AND ( INSTR(CONCAT(',',rez, ','), concat(',',tmp_pid,',') ) =0) )do

		if(rez <> '') then

			set rez = concat(',', rez);

		end if;

		set rez = concat(tmp_pid, rez);

		SELECT pid INTO tmp_pid FROM tree WHERE id = tmp_pid;

	end while;

	return rez;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `remove_extra_spaces` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `remove_extra_spaces`(

inString VARCHAR(500) CHARSET utf8) RETURNS varchar(500) CHARSET utf8
    DETERMINISTIC
BEGIN

	DECLARE _outString VARCHAR(500) CHARSET utf8;

	SET _outString = REPLACE(inString, '  ', ' ');

	while(inString <> _outString) do

		set inString = _outString;

		set _outString = replace(inString, '  ', ' ');

	END WHILE;

	SET _outString = TRIM(_outString);

	RETURN _outString;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sfm_adjust_path` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `sfm_adjust_path`(path VARCHAR(500), in_delimiter VARCHAR(50)) RETURNS varchar(500) CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'adds slashes to the begin and end of the path'
BEGIN

	DECLARE tmp_delim_len SMALLINT;

	SET tmp_delim_len = CHAR_LENGTH(in_delimiter);

	IF(path IS NULL) THEN SET path = ''; END IF;

	IF(LEFT (path, tmp_delim_len) <> in_delimiter) THEN SET path = CONCAT(in_delimiter, path); END IF;

	IF(RIGHT(path, tmp_delim_len) <> in_delimiter) THEN SET path = CONCAT(path, in_delimiter); END IF;

	RETURN path;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sfm_get_path_element` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `sfm_get_path_element`(in_path VARCHAR(500) CHARSET utf8, in_delimiter VARCHAR(50) CHARSET utf8, in_element_index SMALLINT) RETURNS varchar(500) CHARSET utf8
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'string'
BEGIN

	SET in_path = sfm_adjust_path(in_path, in_delimiter);

	RETURN (SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(in_path, in_delimiter, in_element_index + 1), in_delimiter, -1));

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `templates_get_path` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `templates_get_path`(in_id int) RETURNS varchar(300) CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

	declare rez, tmp varchar(300) CHARSET utf8;

	declare tmp_pid int;

	set rez = '';

	select title, pid INTO rez, tmp_pid from templates where id = in_id;

	while((tmp_pid is not null) and(tmp_pid not in (1)))do

		SELECT title, pid INTO tmp, tmp_pid FROM templates WHERE id = tmp_pid;

		if(coalesce(tmp, '') <> '') THEN

			if(coalesce(rez, '') <> '') THEN

				set rez = concat(tmp, ', ', rez);

			ELSE

				SET rez = tmp;

			END IF;

		END IF;

	END while;

	return rez;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_add_user`(username varchar(50), pass varchar(100) )
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	insert into users (`name`, `password`) values(username, MD5(CONCAT('aero', pass)));

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_clean_deleted_nodes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_clean_deleted_nodes`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	create temporary table tmp_clean_tree_ids SELECT id FROM tree WHERE dstatus > 0;

	DELETE FROM objects WHERE id IN (SELECT id FROM tmp_clean_tree_ids);

	DELETE FROM files WHERE id IN (SELECT id FROM tmp_clean_tree_ids);

	delete FROM tree WHERE id in (select id from tmp_clean_tree_ids);

	drop table tmp_clean_tree_ids;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_clear_lost_objects` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_clear_lost_objects`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_clear_lost_ids(id bigint UNSIGNED);

	delete from tmp_clear_lost_ids;

	insert into tmp_clear_lost_ids

		SELECT o.id

		FROM objects o

		LEFT JOIN tree t

			ON o.`id` = t.id

		WHERE t.id IS NULL;

	DELETE FROM objects WHERE id IN

	(select id from tmp_clear_lost_ids);

	drop table tmp_clear_lost_ids;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_delete_template_field_with_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_delete_template_field_with_data`(in_field_id bigint unsigned)
    MODIFIES SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'string'
BEGIN

	delete from objects where id = in_field_id;

	DELETE FROM tree WHERE id = in_field_id;

	delete from templates_structure where id = in_field_id;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_delete_tree_node` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_delete_tree_node`(in_id bigint unsigned)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	DELETE FROM tree WHERE id = in_id;

	DELETE FROM objects WHERE id = in_id;

	DELETE FROM files WHERE id = in_id;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_mark_all_childs_as_active` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_mark_all_childs_as_active`(in_id bigint unsigned)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_achild_ids(id bigint UNSIGNED);

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_achild_ids2(id BIGINT UNSIGNED);

	delete from tmp_achild_ids;

	DELETE FROM tmp_achild_ids2;

	insert into tmp_achild_ids select id from tree where pid = in_id;

	while(ROW_COUNT() > 0)do

		update tree, tmp_achild_ids

		  set tree.did = NULL

		  ,tree.ddate = NULL

		  ,tree.dstatus = 0

		  , tree.updated = 1

		where tmp_achild_ids.id = tree.id;

		DELETE FROM tmp_achild_ids2;

		insert into tmp_achild_ids2 select id from tmp_achild_ids;

		delete from tmp_achild_ids;

		INSERT INTO tmp_achild_ids SELECT t.id FROM tree t join tmp_achild_ids2 c on t.pid = c.id;

	END WHILE;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_mark_all_childs_as_deleted` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_mark_all_childs_as_deleted`(in_id bigint unsigned, in_did int unsigned)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_dchild_ids(id bigint UNSIGNED);

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_dchild_ids2(id BIGINT UNSIGNED);

	delete from tmp_dchild_ids;

	DELETE FROM tmp_dchild_ids2;

	insert into tmp_dchild_ids select id from tree where pid = in_id;

	while(ROW_COUNT() > 0)do

		update tree, tmp_dchild_ids

		    set tree.did = in_did

			,tree.ddate = CURRENT_TIMESTAMP

			,tree.dstatus = 2

			,tree.updated = 1

		    where tmp_dchild_ids.id = tree.id;

		DELETE FROM tmp_dchild_ids2;

		insert into tmp_dchild_ids2 select id from tmp_dchild_ids;

		delete from tmp_dchild_ids;

		INSERT INTO tmp_dchild_ids SELECT t.id FROM tree t join tmp_dchild_ids2 c on t.pid = c.id;

	END WHILE;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_mark_all_child_drafts_as_active` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_mark_all_child_drafts_as_active`(in_id bigint unsigned)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_achild_ids(id bigint UNSIGNED);

	CREATE TEMPORARY TABLE IF NOT EXISTS tmp_achild_ids2(id BIGINT UNSIGNED);

	delete from tmp_achild_ids;

	DELETE FROM tmp_achild_ids2;

	insert into tmp_achild_ids

		select id

		from tree

		where pid = in_id and draft = 1;

	while(ROW_COUNT() > 0)do

		update tree, tmp_achild_ids

		  set 	tree.draft = 0

			,tree.updated = 1

		where tmp_achild_ids.id = tree.id;

		DELETE FROM tmp_achild_ids2;

		insert into tmp_achild_ids2

			select id

			from tmp_achild_ids;

		delete from tmp_achild_ids;

		INSERT INTO tmp_achild_ids

			SELECT t.id

			FROM tree t

			join tmp_achild_ids2 c

			  on t.pid = c.id and t.draft = 1;

	END WHILE;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_recalculate_security_sets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_recalculate_security_sets`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	truncate table `tree_acl_security_sets`;

	insert into tree_acl_security_sets (id, `set`)

		select node_id, `f_get_tree_inherit_ids`(node_id) from

		(SELECT DISTINCT node_id FROM `tree_acl`) t;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_sort_tags` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_sort_tags`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Sort tags by l1 field and updates incremental order field'
BEGIN

	create table if not exists tmp_tags_sort (`id` int(11) unsigned NOT NULL AUTO_INCREMENT,

	  `pid` int(11) unsigned DEFAULT NULL,

	  

	  `order` smallint(5) unsigned NOT NULL DEFAULT '0',

	  PRIMARY KEY (`id`));

	delete from tmp_tags_sort;

	SET @i = 0;

	insert into tmp_tags_sort (id, `order`) select id, @i:=@i+1 from tags where pid is null order by `type`, l1;

	while (select count(*) from tags t left join tmp_tags_sort ts1 on t.pid = ts1.id LEFT JOIN tmp_tags_sort ts2 ON t.id = ts2.id where ts1.id is not null and ts2.id is null) do

		SET @i = 0;

		SET @pid = 0;

		INSERT INTO tmp_tags_sort (id, `order`, pid)

			SELECT t.id, case when t.pid = @pid then @i:=@i+1 else @i:=1 END, @pid := t.pid

			FROM tags t left join tmp_tags_sort ts3 on t.pid = ts3.id LEFT JOIN tmp_tags_sort ts4 ON t.id = ts4.id WHERE ts3.id is NOT null and ts4.id is null ORDER BY t.pid, t.`type`, t.l1;

	end while;

	

	update tags t, tmp_tags_sort ts set t.order = ts.order where t.id = ts.id;

	drop table tmp_tags_sort;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_sort_templates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_sort_templates`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Sort templates by l1 field and updates incremental order field'
BEGIN

	create table if not exists tmp_templates_sort (`id` int(11) unsigned NOT NULL AUTO_INCREMENT,

	  `pid` int(11) unsigned DEFAULT NULL,

	  

	  `order` smallint(5) unsigned NOT NULL DEFAULT '0',

	  PRIMARY KEY (`id`));

	delete from tmp_templates_sort;

	SET @i = 0;

	insert into tmp_templates_sort (id, `order`) select id, @i:=@i+1 from templates where pid is null order by `type`, l1;

	while (select count(*) from templates t left join tmp_templates_sort ts1 on t.pid = ts1.id LEFT JOIN tmp_templates_sort ts2 ON t.id = ts2.id where ts1.id is not null and ts2.id is null) do

		SET @i = 0;

		SET @pid = 0;

		INSERT INTO tmp_templates_sort (id, `order`, pid)

			SELECT t.id, case when t.pid = @pid then @i:=@i+1 else @i:=1 END, @pid := t.pid

			FROM templates t left join tmp_templates_sort ts3 on t.pid = ts3.id LEFT JOIN tmp_templates_sort ts4 ON t.id = ts4.id WHERE ts3.id is NOT null and ts4.id is null ORDER BY t.pid, t.`type`, t.l1;

	end while;

	

	update templates t, tmp_templates_sort ts set t.order = ts.order where t.id = ts.id;

	drop table tmp_templates_sort;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_child_security_sets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_update_child_security_sets`(

	in_node_id bigint unsigned

	,in_from_security_set_id bigint unsigned

	,in_to_security_set_id bigint unsigned

     )
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	DECLARE tmp_from_security_set, msg

		,tmp_to_security_set varchar(9999);

	DECLARE tmp_security_set_length INT UNSIGNED DEFAULT 0;

	

	select `set`

	into tmp_from_security_set

	from `tree_acl_security_sets`

	where id = in_from_security_set_id;

	

	SELECT `set`

	INTO tmp_to_security_set

	FROM `tree_acl_security_sets`

	WHERE id = in_to_security_set_id;

	

	SET tmp_security_set_length = LENGTH( tmp_from_security_set ) +1;

	CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_update_child_sets_pids`(

		`id` BIGINT UNSIGNED NOT NULL,

		PRIMARY KEY (`id`)

	);

	CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_update_child_sets_childs`(

		`id` BIGINT UNSIGNED NOT NULL,

		PRIMARY KEY (`id`)

	);

	CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_update_child_sets_security_sets`(

		`id` BIGINT UNSIGNED NOT NULL,

		PRIMARY KEY (`id`)

	);

	DELETE FROM tmp_update_child_sets_pids;

	DELETE FROM tmp_update_child_sets_childs;

	DELETE FROM tmp_update_child_sets_security_sets;

	INSERT INTO tmp_update_child_sets_childs (id)

	values(in_node_id);

	WHILE( ROW_COUNT() > 0 )DO

		

		update tmp_update_child_sets_childs

			,tree_info

		set tree_info.security_set_id = in_to_security_set_id

		where tmp_update_child_sets_childs.id = tree_info.id

			and (	tree_info.security_set_id is null

				OR

				tree_info.security_set_id = in_from_security_set_id

			);

		DELETE FROM tmp_update_child_sets_pids;

		INSERT INTO tmp_update_child_sets_pids

			SELECT id

			FROM tmp_update_child_sets_childs;

		INSERT INTO tmp_update_child_sets_security_sets

			SELECT DISTINCT ti.security_set_id

			FROM tmp_update_child_sets_childs c

			JOIN tree_info ti

				ON c.id = ti.id

				and ti.security_set_id is not null

		ON DUPLICATE KEY UPDATE id = ti.security_set_id;

		DELETE FROM tmp_update_child_sets_childs;

		INSERT INTO tmp_update_child_sets_childs (id)

			SELECT t.id

			FROM tmp_update_child_sets_pids  ti

			JOIN tree t

				ON ti.id = t.pid

				and t.inherit_acl = 1;

	END WHILE;

	

	delete

	from tmp_update_child_sets_security_sets

	where id = in_to_security_set_id;

	

	UPDATE tmp_update_child_sets_security_sets

		,tree_acl_security_sets

		SET tree_acl_security_sets.`set` = CONCAT(

			tmp_to_security_set

			,CASE WHEN tmp_security_set_length IS NULL

			THEN

			  CONCAT(',', tree_acl_security_sets.set)

			ELSE

			 SUBSTRING(tree_acl_security_sets.set, tmp_security_set_length)

			END

		)

		,`tree_acl_security_sets`.updated = 1

	WHERE tmp_update_child_sets_security_sets.id = tree_acl_security_sets.id;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_files_content__ref_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_update_files_content__ref_count`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	UPDATE files_content c SET ref_count = COALESCE((SELECT COUNT(id) FROM files WHERE content_id = c.id), 0)+

	COALESCE((SELECT COUNT(id) FROM files_versions WHERE content_id = c.id), 0);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_template_structure_levels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_update_template_structure_levels`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN

	DECLARE `tmp_level` INT DEFAULT 0;

	CREATE TABLE IF NOT EXISTS tmp_level_id (`id` INT(11) UNSIGNED NOT NULL, PRIMARY KEY (`id`));

	CREATE TABLE IF NOT EXISTS tmp_level_pid (`id` INT(11) UNSIGNED NOT NULL, PRIMARY KEY (`id`));

	INSERT INTO tmp_level_id

	  SELECT ts1.id

	  FROM templates_structure ts1

	  LEFT JOIN templates_structure ts2 ON ts1.pid = ts2.id

	  WHERE ts2.id IS NULL;

	WHILE (ROW_COUNT() > 0) DO

	  UPDATE templates_structure, tmp_level_id

	  SET templates_structure.`level` = tmp_level

	  WHERE templates_structure.id = tmp_level_id.id;

	  DELETE FROM tmp_level_pid;

	  INSERT INTO tmp_level_pid

		SELECT id FROM tmp_level_id;

	  DELETE FROM tmp_level_id;

	  INSERT INTO tmp_level_id

	    SELECT ts1.id

	    FROM templates_structure ts1

	    JOIN tmp_level_pid ts2 ON ts1.pid = ts2.id;

	  SET tmp_level = tmp_level + 1;

	END WHILE;

	DROP TABLE tmp_level_id;

	DROP TABLE tmp_level_pid;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_tree_acl_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_update_tree_acl_count`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Update acl_count field in tree table'
BEGIN

	create temporary table tmp_tree_acl_count select node_id `id`, count(*) `count` FROM `tree_acl` group by node_id;

	UPDATE tree, tmp_tree_acl_count set tree.acl_count = tmp_tree_acl_count.count where tree.id = tmp_tree_acl_count.id;

	drop table tmp_tree_acl_count;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_tree_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_update_tree_info`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'update tree_info_table. \n	This procedure is a quick solution and is known to work slow on big trees.\n	It''s actually designed just for upgrading from an old casebox database to new security updates format.\n	'
BEGIN

	delete from tree_info;

	delete from `tree_acl_security_sets`;

	ALTER TABLE `tree_acl_security_sets` AUTO_INCREMENT = 1;

	create temporary table tmp_tree_info

	SELECT id

		,REPLACE(TRIM( '/' FROM `f_get_tree_ids_path`(id)), '/', ',') `pids`

		,`f_get_tree_path`(id) `path`

		,`f_get_objects_case_id`(id) `case_id`

		,(SELECT COUNT(*) FROM `tree_acl` WHERE node_id = t.id) `acl_count`

		,`f_get_security_set_id`(id) `security_set_id`

		,1 `updated`

	FROM tree t;

	INSERT INTO tree_info (

		id

		,pids

		,path

		,case_id

		,acl_count

		,security_set_id

		,updated

	) select * from tmp_tree_info ti

	on duplicate key

	update

		pids = ti.pids

		,path = ti.path

		,case_id =  ti.case_id

		,acl_count = ti.acl_count

		,security_set_id = ti.security_set_id

		,updated = 1;

	drop TEMPORARY TABLE tmp_tree_info;

	ALTER TABLE `tree_acl_security_sets` AUTO_INCREMENT = 1;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_users_first_and_last_names_from_l1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_update_users_first_and_last_names_from_l1`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'string'
BEGIN

	UPDATE users_groups

	SET

		first_name = `sfm_get_path_element`(l1, ' ', 1)

		,last_name = TRIM(

			CONCAT(

				`sfm_get_path_element`(l1, ' ', 2)

				,' '

				,`sfm_get_path_element`(l1, ' ', 3)

			)

		);

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_user_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_user_login`(IN `in_username` VARCHAR(50), `in_password` VARCHAR(100), `in_from_ip` VARCHAR(40))
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'checks for login credetials and log the attemps'
BEGIN

	DECLARE `user_id` INT DEFAULT NULL;

	DECLARE `user_pass` VARCHAR(255);

	SELECT `id`, `password`  INTO `user_id`, `user_pass` FROM users_groups WHERE `name` = `in_username` and enabled = 1 and did is NULL;

	IF(user_id IS NOT NULL) THEN

		IF(`user_pass` = MD5(CONCAT('aero', `in_password`))) THEN

			UPDATE users_groups SET last_login = CURRENT_TIMESTAMP, login_successful = 1, login_from_ip = `in_from_ip`  WHERE id = `user_id`;

			SELECT user_id, 1 `status`;

		ELSE

			UPDATE users_groups SET last_login = CURRENT_TIMESTAMP, login_successful = login_successful-2, login_from_ip = `in_from_ip`  WHERE id = `user_id`;

			SELECT user_id, 0 `status`;

		END IF;

	ELSE

		SELECT 0 `user_id`, 0 `status`;

	END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-08 13:15:16

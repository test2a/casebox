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
) ENGINE=InnoDB AUTO_INCREMENT=2917 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_log`
--

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
INSERT INTO `config` VALUES (104,NULL,'project_name_en','ECMRS - Electronic Case Record Management System',NULL),(105,NULL,'templateIcons','\nfa fa-arrow-circle-left fa-fl\nfa fa-arrow-circle-o-left fa-fl\nfa fa-arrow-circle-o-right fa-fl\nfa fa-arrow-circle-right fa-fl\nfa fa-arrow-left fa-fl\nfa fa-arrow-right fa-fl\nfa fa-book fa-fl\nfa fa-bookmark fa-fl\nfa fa-bookmark-o fa-fl\nfa fa-briefcase fa-fl\nfa fa-bug fa-fl\nfa fa-building fa-fl\nfa fa-building-o fa-fl\nfa fa-calendar-o fa-fl\nfa fa-camera fa-fl\nfa fa-comment fa-fl\nfa fa-comment-o fa-fl\nfa fa-commenting fa-fl\nfa fa-commenting-o fa-fl\nfa fa-comments fa-fl\nfa fa-comments-o fa-fl\nfa fa-envelope fa-fl\nfa fa-envelope-o fa-fl\nfa fa-external-link fa-fl\nfa fa-external-link-square  fa-fl\nfa fa-file fa-fl\nfa fa-file-archive-o fa-fl\nfa fa-file-audio-o fa-fl\nfa fa-file-code-o fa-fl\nfa fa-file-excel-o fa-fl\nfa fa-file-image-o fa-fl\nfa fa-file-movie-o fa-fl\nfa fa-file-o fa-fl\nfa fa-file-pdf-o fa-fl\nfa fa-file-photo-o fa-fl\nfa fa-file-picture-o fa-fl\nfa fa-file-powerpoint-o fa-fl\nfa fa-file-sound-o fa-fl\nfa fa-file-text fa-fl\nfa fa-file-text-o fa-fl\nfa fa-file-video-o fa-fl\nfa fa-file-word-o fa-fl\nfa fa-file-zip-o fa-fl\nfa fa-files-o fa-fl\nfa fa-film fa-fl\nfa fa-flash fa-fl\nfa fa-folder fa-fl\nfa fa-folder-o fa-fl\nfa fa-folder-open fa-fl\nfa fa-folder-open-o fa-fl\nfa fa-foursquare fa-fl\nfa fa-gavel fa-fl\nfa fa-gear fa-fl\nfa fa-gears fa-fl\nfa fa-info fa-fl\nfa fa-info-circle fa-fl\nfa fa-institution fa-fl\nfa fa-link fa-fl\nfa fa-print fa-fl\nfa fa-stack-exchange fa-fl\nfa fa-sticky-note fa-fl\nfa fa-sticky-note-o fa-fl\nfa fa-suitcase fa-fl\nfa fa-tasks fa-fl\nfa fa-university fa-fl\nfa fa-unlink fa-fl\nfa fa-user fa-fl\nfa fa-user-md fa-fl\nfa fa-user-plus fa-fl\nfa fa-user-secret fa-fl\nfa fa-user-times fa-fl\nfa fa-users fa-fl\nfa fa-warning fa-fl\nfa fa-wpforms fa-fl',NULL),(106,NULL,'folder_templates','5,11,100',NULL),(107,NULL,'default_folder_template','5',NULL),(108,NULL,'default_file_template','6',NULL),(109,NULL,'default_task_template','7',NULL),(110,NULL,'default_language','en',NULL),(111,NULL,'languages','en',NULL),(112,NULL,'object_type_plugins','{\r\n  \"object\": [\"objectProperties\", \"files\", \"tasks\", \"contentItems\", \"comments\", \"systemProperties\"]\r\n  ,\"case\": [\"objectProperties\", \"files\", \"tasks\", \"contentItems\", \"comments\", \"systemProperties\"]\r\n  ,\"task\": [\"objectProperties\", \"files\", \"contentItems\", \"comments\", \"systemProperties\"]\r\n  ,\"file\": [\"thumb\", \"meta\", \"versions\", \"tasks\", \"comments\", \"systemProperties\"]\r\n}',NULL),(113,NULL,'treeNodes','',NULL),(114,113,'Tasks','{\n    \"pid\": 1\n}',1),(115,113,'Dbnode','[]',2),(116,113,'RecycleBin','{\r\n    \"pid\": \"1\",\r\n    \"facets\": [\r\n        \"did\"\r\n    ],\r\n    \"DC\": {\r\n        \"nid\": {}\r\n        ,\"name\": {}\r\n        ,\"cid\": {}\r\n        ,\"ddate\": {\r\n            \"solr_column_name\": \"ddate\"\r\n        }\r\n    }\r\n}',3),(117,NULL,'default_object_plugins','{\n\"objectProperties\": {\n\"visibility\": {\n\"!context\": \"window\"\n,\"!template_type\": \"file\"\n}\n,\"order\": 0\n}\n,\"files\": {\n\"visibility\": {\n\"template_type\": \"object,search,case,task\"\n}\n,\"order\": 2\n}\n,\"tasks\": {\n\"visibility\": {\n\"template_type\": \"object,search,case,task\"\n}\n,\"order\": 3\n}\n,\"contentItems\": {\n\"visibility\": {\n\"!template_type\": \"file,time_tracking\"\n}\n,\"order\": 4\n}\n,\"thumb\": {\n\"visibility\": {\n\"!context\": \"window\"\n,\"template_type\": \"file\"\n}\n,\"order\": 5\n}\n,\"currentVersion\": {\n\"visibility\": {\n\"context\": \"window\"\n,\"template_type\": \"file\"\n}\n,\"order\": 6\n}\n,\"versions\": {\n\"visibility\": {\n\"template_type\": \"file\"\n}\n,\"order\": 7\n}\n,\"meta\": {\n\"visibility\": {\n\"template_type\": \"file\"\n}\n,\"order\": 8\n}\n,\"comments\": {\n\"order\": 9\n,\"visibility\": {\n\"!template_type\": \"time_tracking\"\n}\n\n}\n}',NULL),(118,NULL,'files','{\r\n  \"max_versions\": \"*:1;php,odt,doc,docx,xls,xlsx:20;pdf:5;png,gif,jpg,jpeg,tif,tiff:2;\"\r\n\r\n  ,\"edit\" : {\r\n    \"text\": \"txt,php,js,xml,csv\"\r\n    ,\"html\": \"html,htm\"\r\n    ,\"webdav\": \"doc,docx,ppt,dot,dotx,xls,xlsm,xltx,ppt,pot,pps,pptx,odt,ott,odm,ods,odg,otg,odp,odf,odb\"\r\n  }\r\n\r\n  ,\"webdav_url\": \"https://webdav.host.com/{core_name}/edit-{node_id}/{name}\"\r\n}',NULL),(119,NULL,'timezone','UTC',NULL),(120,NULL,'language_en','{\r\n\"name\": \"English\"\r\n,\"locale\": \"en_US\"\r\n,\"long_date_format\": \"%F %j, %Y\"\r\n,\"short_date_format\": \"%m/%d/%Y\"\r\n,\"time_format\": \"%H:%i\"\r\n}',NULL),(121,NULL,'language_fr','{\r\n\"name\": \"French\"\r\n,\"locale\": \"fr_FR\"\r\n,\"long_date_format\": \"%j %F %Y\"\r\n,\"short_date_format\": \"%d.%m.%Y\"\r\n,\"time_format\": \"%H:%i\"\r\n}\r\n',NULL),(122,NULL,'language_ru','{\r\n\"name\": \"Русский\"\r\n,\"locale\": \"ru_RU\"\r\n,\"long_date_format\": \"%j %F %Y\"\r\n,\"short_date_format\": \"%d.%m.%Y\"\r\n,\"time_format\": \"%H:%i\"\r\n}',NULL),(123,NULL,'default_facet_configs','{\r\n  \"template_type\": {\r\n    \"title\": \"[Type]\"\r\n    ,\"type\": \"objectTypes\"\r\n  }\r\n  ,\"template\": {\r\n    \"title\": \"[Template]\"\r\n    ,\"field\": \"template_id\"\r\n    ,\"type\": \"objects\"\r\n  }\r\n  ,\"creator\": {\r\n    \"title\": \"[Creator]\"\r\n    ,\"field\": \"cid\"\r\n    ,\"type\": \"users\"\r\n  }\r\n  ,\"owner\": {\r\n    \"title\": \"[Owner]\"\r\n    ,\"field\": \"oid\"\r\n    ,\"type\": \"users\"\r\n  }\r\n  ,\"updater\": {\r\n    \"title\": \"Updater\"\r\n    ,\"field\": \"uid\"\r\n    ,\"type\": \"users\"\r\n  }\r\n  ,\"date\": {\r\n    \"title\": \"[Date]\"\r\n    ,\"facet\": \"query\"\r\n    ,\"type\": \"dates\"\r\n    ,\"manualPeriod\": true\r\n    ,\"queries\": [\r\n      \"today\"\r\n      ,\"yesterday\"\r\n      ,\"week\"\r\n      ,\"month\"\r\n    ]\r\n    ,\"boolMode\": true\r\n  }\r\n  ,\"date_end\": {\r\n    \"title\": \"End date\"\r\n    ,\"facet\": \"query\"\r\n    ,\"type\": \"dates\"\r\n    ,\"queries\": [\r\n      \"today\"\r\n      ,\"week\"\r\n      ,\"next7days\"\r\n      ,\"next31days\"\r\n      ,\"month\"\r\n    ]\r\n    ,\"boolMode\": true\r\n  }\r\n  ,\"status\": {\r\n    \"title\": \"[Status]\"\r\n    ,\"type\": \"objects\"\r\n }\r\n  ,\"task_status\": {\r\n    \"title\": \"[Status]\"\r\n    ,\"type\": \"taskStatuses\"\r\n }\r\n  ,\"assigned\": {\r\n    \"title\": \"Assigned\"\r\n    ,\"field\": \"task_u_assignee\"\r\n    ,\"type\": \"users\"\r\n    ,\"boolMode\": true\r\n  }, \"gender\": {\r\n\"field\": \"gender_i\"\r\n,\"title\": \"Gender\"\r\n,\"type\": \"objects\"\r\n}, \r\n\"headofhousehold\": {\r\n\"field\": \"headofhousehold_i\"\r\n,\"title\": \"Head of Household\"\r\n,\"type\": \"objects\"\r\n},\r\n\"ethnicity\": {\r\n\"field\": \"ethnicity_i\"\r\n,\"title\": \"Hispanic Origin\"\r\n,\"type\": \"objects\"\r\n},\r\n\"language\": {\r\n\"field\": \"language_i\"\r\n,\"title\": \"Language\"\r\n,\"type\": \"objects\"\r\n},\r\n\"transportationassessment\": {\r\n\"field\": \"transportationassessment_i\"\r\n,\"title\": \"Transportation Assessment\"\r\n,\"type\": \"objects\"\r\n},\r\n\"childassessment\": {\r\n\"field\": \"childassessment_i\"\r\n,\"title\": \"Child Assessment\"\r\n,\"type\": \"objects\"\r\n},\r\n\"race\": {\r\n\"field\": \"race_i\"\r\n,\"title\": \"Client Race\"\r\n,\"type\": \"objects\"\r\n},\r\n\"fema_tier\": {\r\n\"field\": \"fema_tier_i\"\r\n,\"title\": \"FEMA Tier\"\r\n,\"type\": \"objects\"\r\n}\r\n}',NULL),(124,NULL,'node_facets','{\r\n\"1\" : [\r\n  \"template_type\"\r\n  ,\"creator\"\r\n  ,\"template\"\r\n  ,\"date\"\r\n  ,\"status\"\r\n  ,\"assigned\"\r\n],\r\n\"150\" : [\r\n\"status\",\r\n\"taskstatus\",\r\n\"assigned\",\r\n \"race\",\r\n \"gender\",\r\n \"maritalstatus\",\r\n \"ethnicity\",\r\n \"language\",\r\n \"headofhousehold\",\r\n\"transportationassessment\",\r\n\"childassessment\"\r\n]\r\n\r\n}',NULL),(125,NULL,'default_object_plugins','{\r\n  \"objectProperties\": {\r\n    \"visibility\": {\r\n      \"!context\": \"window\"\r\n      ,\"!template_type\": \"file\"\r\n    }\r\n    ,\"order\": 0\r\n  }\r\n  ,\"files\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"object,search,case,task\"\r\n    }\r\n    ,\"order\": 2\r\n  }\r\n  ,\"tasks\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"object,search,case,task\"\r\n    }\r\n    ,\"order\": 3\r\n  }\r\n  ,\"contentItems\": {\r\n    \"visibility\": {\r\n      \"!template_type\": \"file,time_tracking\"\r\n    }\r\n    ,\"order\": 4\r\n  }\r\n  ,\"thumb\": {\r\n    \"visibility\": {\r\n      \"!context\": \"window\"\r\n      ,\"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 5\r\n  }\r\n  ,\"currentVersion\": {\r\n    \"visibility\": {\r\n      \"context\": \"window\"\r\n      ,\"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 6\r\n  }\r\n  ,\"versions\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 7\r\n  }\r\n  ,\"meta\": {\r\n    \"visibility\": {\r\n      \"template_type\": \"file\"\r\n    }\r\n    ,\"order\": 8\r\n  }\r\n  ,\"comments\": {\r\n    \"order\": 9\r\n    ,\"visibility\": {\r\n      \"!template_type\": \"time_tracking\"\r\n    }\r\n\r\n  }\r\n}',NULL),(126,NULL,'images_display_size','512000',NULL),(127,NULL,'default_DC','{\r\n\"nid\": {}\r\n,\"name\": {\r\n  \"solr_column_name\": \"name\"\r\n}\r\n,\"cid\": {\r\n  \"solr_column_name\": \"cid\"\r\n}\r\n,\"oid\": {\r\n  \"solr_column_name\": \"oid\"\r\n}\r\n,\"cdate\": {\r\n  \"solr_column_name\": \"cdate\"\r\n}\r\n,\"udate\": {\r\n  \"solr_column_name\": \"udate\"\r\n}\r\n}',NULL),(128,NULL,'default_availableViews','grid,charts,pivot,activityStream,calendar,dashboard',NULL),(129,NULL,'DCConfigs','',NULL),(130,129,'dc_tasks','{\r\n    \"nid\":[]\r\n    ,\"name\":[]\r\n    ,\"importance\":{\"solr_column_name\":\"task_importance\"}\r\n    ,\"order\":{\r\n        \"solr_column_name\":\"task_order\"\r\n        ,\"sortType\":\"asInt\"\r\n        ,\"align\":\"center\"\r\n        ,\"columnWidth\":\"10\"\r\n    }\r\n    ,\"time_estimated\":{\r\n        \"width\":\"20px\"\r\n        ,\"format\":\"H:i\"\r\n    }\r\n    ,\"phase\": {\r\n        \"solr_column_name\": \"task_phase\"\r\n    }\r\n    ,\"project\": {\r\n        \"solr_column_name\": \"task_projects\"\r\n    }\r\n    ,\"cid\":[]\r\n    ,\"assigned\":[]\r\n    ,\"comment_user_id\":[]\r\n    ,\"comment_date\":[]\r\n    ,\"cdate\":[]\r\n}',NULL),(131,129,'dc_tasks_closed','{\r\n    \"nid\":[]\r\n    ,\"name\":[]\r\n    ,\"importance\":{\"solr_column_name\":\"task_importance\"}\r\n    ,\"order\":{\"solr_column_name\":\"task_order\"\r\n        ,\"sortType\":\"asInt\"\r\n        ,\"align\":\"center\"\r\n        ,\"columnWidth\":\"10\"\r\n    }\r\n    ,\"project\": {\r\n        \"solr_column_name\": \"task_projects\"\r\n    }    \r\n    ,\"time_completed\":{\r\n        \"columnWidth\":\"20\"\r\n        ,\"format\":\"H:i\"\r\n    }\r\n    ,\"time_estimated\":{\r\n        \"width\":\"20px\"\r\n        ,\"format\":\"H:i\"\r\n    }\r\n    ,\"task_d_closed\":{\r\n        \"solr_column_name\":\"task_d_closed\"\r\n        ,\"xtype\":\"datecolumn\"\r\n        ,\"format\":\"Y-m-d\"\r\n        ,\"title\":\"Closed date\"\r\n    }\r\n    ,\"cid\":[]\r\n    ,\"cdate\":[]\r\n    ,\"assigned\":[]\r\n    ,\"comment_user_id\":[]\r\n    ,\"comment_date\":[]\r\n}',NULL),(132,NULL,'geoMapping','true',NULL),(288,113,'Cases','{\n\"pid\": 1,\n\"DC\": {\n  \"id\": {},\n  \"name\": {},\n  \"assigned\": {},\n  \"task_d_closed\":{},\n  \"cdate\":{\"title\":\"Created\"}\n}\n}',1),(663,129,'dc_cases_fema','{\n\"nid\":[]\n,\"name\":[]\n,\"importance\":{\"solr_column_name\":\"fema_tier_i\"}\n,\"order\":{\n\"solr_column_name\":\"task_order\"\n,\"sortType\":\"asInt\"\n,\"align\":\"center\"\n,\"columnWidth\":\"10\"\n}\n,\"time_estimated\":{\n\"width\":\"20px\"\n,\"format\":\"H:i\"\n}\n,\"phase\": {\n\"solr_column_name\": \"task_phase\"\n}\n,\"project\": {\n\"solr_column_name\": \"task_projects\"\n}\n,\"cid\":[]\n,\"assigned\":[]\n,\"comment_user_id\":[]\n,\"comment_date\":[]\n,\"cdate\":[]\n}\n\n',NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=1307 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1235,1,NULL,'Insider Threat Awareness.pdf','',1,1,'2016-12-15 21:18:17','2016-12-15 21:18:17'),(1251,2,NULL,'josh.jpg','',1,1,'2016-12-30 01:18:48','2016-12-30 01:18:48'),(1255,2,NULL,'josh (1).jpg','',1,1,'2016-12-30 01:22:10','2016-12-30 01:22:10'),(1257,2,NULL,'josh.jpg','',1,1,'2016-12-30 01:48:22','2016-12-30 01:48:22'),(1259,2,NULL,'josh.jpg','',1,1,'2016-12-30 02:54:31','2016-12-30 02:54:32'),(1305,3,NULL,'Alert X.png','',24,24,'2017-01-06 13:37:23','2017-01-06 13:37:23'),(1306,4,NULL,'New Page.png','',24,24,'2017-01-06 13:37:24','2017-01-06 13:37:24');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_content`
--

LOCK TABLES `files_content` WRITE;
/*!40000 ALTER TABLE `files_content` DISABLE KEYS */;
INSERT INTO `files_content` VALUES (1,904453,NULL,'application/pdf','2016/12/15',1,NULL,0,'89fcec3ef4026ef2ea1b78b12e1d42ees904453'),(2,16401,NULL,'image/jpeg','2016/12/30',4,NULL,1,'f3bbe755b81835547a98b533797d8990s16401'),(3,200056,NULL,'image/png','2017/01/06',1,NULL,1,'a4751de7801539882072dd051da0cfa5s200056'),(4,138627,NULL,'image/png','2017/01/06',1,NULL,1,'e29d22858b10814cc0b877a45d3f1679s138627');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guids`
--

LOCK TABLES `guids` WRITE;
/*!40000 ALTER TABLE `guids` DISABLE KEYS */;
INSERT INTO `guids` VALUES (7,'Cases'),(6,'CasesByStatus'),(2,'Dbnode'),(4,'Person'),(3,'RecycleBin'),(1,'Tasks'),(5,'This');
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
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (8,1225,2178,'2178','create','2016-12-15 21:11:09',NULL,1,24,0,0),(9,1230,2183,'2183','create','2016-12-15 21:12:59',NULL,1,24,0,0),(10,1237,2193,'2193','create','2016-12-15 21:31:30',NULL,1,24,0,0),(11,1237,2219,'2219,2208,2207','comment','2016-12-30 01:48:28',NULL,1,24,0,0),(13,1237,2768,'2768,2761,2758,2755,2752,2211,2210,2209','update','2017-01-13 14:58:40',NULL,1,24,0,0),(16,1225,2217,'2217,2215','comment','2016-12-30 01:22:17',NULL,1,24,0,0),(17,1230,2253,'2253,2247','update','2017-01-04 15:51:22',NULL,1,24,0,0),(18,1230,2284,'2284,2283,2282,2281,2280,2279','comment','2017-01-05 17:37:23',NULL,1,24,0,0),(24,1291,2296,'2296','create','2017-01-06 10:31:59',NULL,24,25,0,0),(25,1291,2314,'2314,2313','comment','2017-01-06 15:54:03',NULL,24,25,0,0),(27,1314,2325,'2325','create','2017-01-09 00:42:37',NULL,1,23,0,0),(28,1243,2913,'2913,2656,2336,2329','update','2017-01-18 20:32:57',NULL,1,28,0,0),(29,1199,2330,'2330','update','2017-01-09 01:20:46',NULL,1,21,0,0),(30,1212,2868,'2868,2796,2331','update','2017-01-14 04:58:28',NULL,1,21,0,0),(31,1225,2334,'2334','close','2017-01-09 01:35:52',NULL,1,24,0,0),(33,1230,2339,'2339','close','2017-01-09 14:38:10',NULL,1,24,0,0),(34,1329,2377,'2377','create','2017-01-10 16:19:10',NULL,1,29,0,0),(36,1477,2743,'2743','create','2017-01-12 03:40:49',NULL,1,29,0,0),(37,1477,2743,'2743','create','2017-01-12 03:40:49',NULL,1,25,0,0),(38,1237,2767,'2767,2760,2757,2754,2751','close','2017-01-13 14:58:36',NULL,1,24,0,0),(40,1237,2769,'2769,2762,2759,2756,2753','reopen','2017-01-13 14:58:40',NULL,1,24,0,0),(53,1482,2776,'2776','create','2017-01-13 16:04:16',NULL,1,29,0,0),(54,1482,2783,'2783','close','2017-01-13 16:06:50',NULL,1,29,0,0),(55,1482,2910,'2910,2873,2784','update','2017-01-18 20:02:00',NULL,1,29,0,0),(56,1482,2785,'2785','reopen','2017-01-13 16:06:53',NULL,1,29,0,0),(57,1482,2786,'2786','comment','2017-01-13 16:46:48',NULL,1,29,0,0),(58,1314,2793,'2793,2788','update','2017-01-13 18:59:22',NULL,1,23,0,0),(59,1314,2792,'2792','close','2017-01-13 18:59:21',NULL,1,23,0,0),(61,1314,2794,'2794','reopen','2017-01-13 18:59:22',NULL,1,23,0,0),(62,1199,2802,'2802','close','2017-01-14 00:27:41',NULL,1,21,0,0),(64,1329,2908,'2908,2883','update','2017-01-18 15:19:42',NULL,1,29,0,0),(65,1526,2889,'2889','create','2017-01-18 14:08:07',NULL,24,27,0,0),(66,1542,2909,'2909','create','2017-01-18 20:01:06',NULL,1,29,0,0),(68,1543,2912,'2912','create','2017-01-18 20:14:48',NULL,24,29,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=1544 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'{\"_title\":\"Tree\",\"en\":\"Tree\"}',NULL),(2,'{\"_title\":\"System\",\"en\":\"System\"}',NULL),(3,'{\"_title\":\"Templates\",\"en\":\"Templates\"}',NULL),(4,'{\"_title\":\"Thesauri Item\"}','{\"wu\":[],\"solr\":{\"content\":\"Thesauri Item\\n\"},\"lastAction\":{\"type\":\"update\",\"time\":\"2016-10-03T14:14:04Z\",\"users\":{\"1\":\"298\"}}}'),(5,'{\"_title\":\"folder\",\"en\":\"Folder\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-folder\",\"cfg\":\"{\\\"createMethod\\\":\\\"inline\\\",\\n  \\\"DC\\\": {\\n    \\\"nid\\\": {},\\n    \\\"name\\\": {},\\n    \\\"oid\\\": {},\\n    \\\"cid\\\": { \\\"title\\\": \\\"Entered By\\\"},\\n    \\\"cdate\\\": { \\\"title\\\": \\\"Entered Date\\\"}\\n  },\\n  \\\"object_plugins\\\":\\n      [\\\"comments\\\",\\n       \\\"systemProperties\\\"\\n      ]\\n\\n}\",\"title_template\":\"{name}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2723\"},\"time\":\"2017-01-12T02:27:12Z\"},\"solr\":{\"content\":\"folder\\nFolder\\nobject\\n1\\nicon-folder\\n{\\\"createMethod\\\":\\\"inline\\\",\\n  \\\"DC\\\": {\\n    \\\"nid\\\": {},\\n    \\\"name\\\": {},\\n    \\\"oid\\\": {},\\n    \\\"cid\\\": { \\\"title\\\": \\\"Entered By\\\"},\\n    \\\"cdate\\\": { \\\"title\\\": \\\"Entered Date\\\"}\\n  },\\n  \\\"object_plugins\\\":\\n      [\\\"comments\\\",\\n       \\\"systemProperties\\\"\\n      ]\\n\\n}\\n{name}\\n\"},\"wu\":[]}'),(6,'{\"_title\":\"file_template\",\"en\":\"File\",\"type\":\"file\",\"visible\":1,\"iconCls\":\"fa fa-file fa-fl\",\"title_template\":\"{name}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"4\"},\"time\":\"2016-06-09T13:50:28Z\"},\"solr\":{\"content\":\"file_template\\nFile\\nfile\\n1\\nfa fa-file fa-fl\\n{name}\\n\"},\"wu\":[]}'),(7,'{\"_title\":\"task\",\"en\":\"Task\",\"type\":\"task\",\"visible\":1,\"iconCls\":\"icon-task\",\"title_template\":\"{name}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"234\"},\"time\":\"2016-09-29T20:17:28Z\"},\"solr\":{\"content\":\"task\\nTask\\ntask\\n1\\nicon-task\\n{name}\\n\"},\"wu\":[]}'),(8,'{\"_title\":\"Thesauri Item\",\"en\":\"Thesauri Item\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"fa fa-sticky-note fa-fl\",\"title_template\":\"{en}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"6\"},\"time\":\"2016-06-09T13:52:05Z\"},\"solr\":{\"content\":\"Thesauri Item\\nThesauri Item\\nobject\\n1\\nfa fa-sticky-note fa-fl\\n{en}\\n\"},\"wu\":[]}'),(9,'{\"_title\":\"Comment\",\"en\":\"Comment\",\"type\":\"comment\",\"visible\":1,\"iconCls\":\"fa fa-comment fa-fl\",\"cfg\":\"{\\n  \\\"systemType\\\": 2\\n}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"7\"},\"time\":\"2016-06-09T13:52:26Z\"},\"solr\":{\"content\":\"Comment\\nComment\\ncomment\\n1\\nfa fa-comment fa-fl\\n{\\n  \\\"systemType\\\": 2\\n}\\n\"},\"wu\":[]}'),(10,'{\"_title\":\"User\",\"en\":\"User\",\"type\":\"user\",\"visible\":1,\"iconCls\":\"fa fa-user fa-fl\",\"cfg\":\"{\\\"files\\\":\\\"1\\\",\\\"main_file\\\":\\\"1\\\"}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"8\"},\"time\":\"2016-06-09T13:52:43Z\"},\"solr\":{\"content\":\"User\\nUser\\nuser\\n1\\nfa fa-user fa-fl\\n{\\\"files\\\":\\\"1\\\",\\\"main_file\\\":\\\"1\\\"}\\n\"},\"wu\":[]}'),(11,'{\"_title\":\"Template\",\"en\":\"Template\",\"type\":\"template\",\"visible\":1,\"iconCls\":\"fa fa-file-code-o fa-fl\",\"cfg\":\"{\\n\\\"DC\\\": {\\n  \\\"nid\\\": {},\\n  \\\"name\\\": {},\\n  \\\"type\\\": {},\\n  \\\"cfg\\\": {},\\n  \\\"order\\\": {\\n     \\\"sortType\\\": \\\"asInt\\\"\\n     ,\\\"solr_column_name\\\": \\\"order\\\"\\n  }\\n}\\n}\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"16\"},\"time\":\"2016-06-09T13:56:21Z\"},\"solr\":{\"content\":\"Template\\nTemplate\\ntemplate\\n1\\nfa fa-file-code-o fa-fl\\n{\\n\\\"DC\\\": {\\n  \\\"nid\\\": {},\\n  \\\"name\\\": {},\\n  \\\"type\\\": {},\\n  \\\"cfg\\\": {},\\n  \\\"order\\\": {\\n     \\\"sortType\\\": \\\"asInt\\\"\\n     ,\\\"solr_column_name\\\": \\\"order\\\"\\n  }\\n}\\n}\\n\"},\"wu\":[]}'),(12,'{\"_title\":\"Field\",\"en\":\"Field\",\"type\":\"field\",\"visible\":1,\"iconCls\":\"fa fa-foursquare fa-fl\",\"cfg\":\"[]\"}','{\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"9\"},\"time\":\"2016-06-09T13:53:18Z\"},\"solr\":{\"content\":\"Field\\nField\\nfield\\n1\\nfa fa-foursquare fa-fl\\n[]\\n\"},\"wu\":[],\"solrConfigUpdated\":true}'),(13,'{\"_title\":\"en\",\"en\":\"Full name (en)\",\"type\":\"varchar\",\"order\":\"1\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2056\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"en\\nFull name (en)\\nvarchar\\n1\\n\",\"order\":1}}'),(14,'{\"en\":\"Initials\",\"ru\":\"Initiales\",\"_title\":\"initials\",\"type\":\"varchar\",\"order\":\"4\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2057\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"initials\\nInitials\\nvarchar\\n4\\n\",\"order\":4}}'),(15,'{\"en\":\"Sex\",\"ru\":\"Sexe\",\"_title\":\"sex\",\"type\":\"_sex\",\"order\":\"5\",\"cfg\":\"{\\\"thesauriId\\\":\\\"90\\\"}\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2063\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"sex\\nSex\\n_sex\\n5\\n{\\\"thesauriId\\\":\\\"90\\\"}\\n\",\"order\":5}}'),(16,'{\"en\":\"Position\",\"ru\":\"Titre\",\"_title\":\"position\",\"type\":\"combo\",\"order\":\"7\",\"cfg\":\"{\\\"thesauriId\\\":\\\"362\\\"}\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2061\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"position\\nPosition\\ncombo\\n7\\n{\\\"thesauriId\\\":\\\"362\\\"}\\n\",\"order\":7}}'),(17,'{\"en\":\"E-mail\",\"ru\":\"E-mail\",\"_title\":\"email\",\"type\":\"varchar\",\"order\":\"9\",\"cfg\":\"{\\\"maxInstances\\\":\\\"3\\\"}\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2055\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"email\\nE-mail\\nvarchar\\n9\\n{\\\"maxInstances\\\":\\\"3\\\"}\\n\",\"order\":9}}'),(18,'{\"en\":\"Language\",\"ru\":\"Langue\",\"_title\":\"language_id\",\"type\":\"_language\",\"order\":\"11\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2058\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"language_id\\nLanguage\\n_language\\n11\\n\",\"order\":11}}'),(19,'{\"en\":\"Date format\",\"ru\":\"Format de date\",\"_title\":\"short_date_format\",\"type\":\"_short_date_format\",\"order\":\"12\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2064\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"short_date_format\\nDate format\\n_short_date_format\\n12\\n\",\"order\":12}}'),(20,'{\"en\":\"Description\",\"ru\":\"Description\",\"_title\":\"description\",\"type\":\"varchar\",\"order\":\"13\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2054\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"description\\nDescription\\nvarchar\\n13\\n\",\"order\":13}}'),(21,'{\"en\":\"Room\",\"ru\":\"Salle\",\"_title\":\"room\",\"type\":\"varchar\",\"order\":\"8\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2062\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"room\\nRoom\\nvarchar\\n8\\n\",\"order\":8}}'),(22,'{\"en\":\"Phone\",\"ru\":\"T','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2060\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"\"}}'),(23,'{\"en\":\"Location\",\"ru\":\"Emplacement\",\"_title\":\"location\",\"type\":\"combo\",\"order\":\"6\",\"cfg\":\"{\\\"thesauriId\\\":\\\"394\\\"}\"}','{\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2059\"},\"time\":\"2016-12-13T22:57:25Z\"},\"solr\":{\"content\":\"location\\nLocation\\ncombo\\n6\\n{\\\"thesauriId\\\":\\\"394\\\"}\\n\",\"order\":6}}'),(24,'{\"en\":\"Program\",\"ru\":\"Program\",\"_title\":\"program\",\"type\":\"_objects\",\"order\":\"1\",\"cfg\":\"{\\r\\n\\\"source\\\":\\\"thesauri\\\"\\r\\n,\\\"thesauriId\\\": \\\"715\\\"\\r\\n,\\\"multiValued\\\": true\\r\\n,\\\"autoLoad\\\": true\\r\\n,\\\"editor\\\":\\\"form\\\"\\r\\n,\\\"renderer\\\": \\\"listGreenIcons\\\"\\r\\n,\\\"faceting\\\": true\\r\\n}\",\"solr_column_name\":\"category_id\"}','[]'),(25,'{\"_title\":\"_title\",\"en\":\"Name\",\"ru\":\"Name\",\"type\":\"varchar\",\"cfg\":\"{\\\"showIn\\\":\\\"top\\\"}\"}','[]'),(26,'{\"en\":\"Type\",\"ru\":\"Type\",\"_title\":\"type\",\"type\":\"_fieldTypesCombo\",\"order\":\"5\",\"cfg\":\"[]\"}','[]'),(27,'{\"_title\":\"order\",\"en\":\"Order\",\"type\":\"int\",\"order\":\"6\",\"cfg\":\"{\\n  \\\"indexed\\\": true\\n}\",\"solr_column_name\":\"order\"}','{\"wu\":[],\"solr\":{\"content\":\"order\\nOrder\\nint\\n6\\n{\\n  \\\"indexed\\\": true\\n}\\norder\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"17\"},\"time\":\"2016-06-09T13:57:55Z\"}}'),(28,'{\"_title\":\"cfg\",\"en\":\"Config\",\"ru\":\"Config\",\"type\":\"memo\",\"order\":\"7\",\"cfg\":\"{\\\"height\\\":100}\"}','[]'),(29,'{\"en\":\"Solr column name\",\"ru\":\"Solr column name\",\"_title\":\"solr_column_name\",\"type\":\"varchar\",\"order\":\"8\",\"cfg\":\"[]\"}','[]'),(30,'{\"en\":\"Title (en)\",\"ru\":\"Title (en)\",\"_title\":\"en\",\"type\":\"varchar\",\"order\":\"1\",\"cfg\":\"[]\"}','[]'),(31,'{\"_title\":\"_title\",\"en\":\"Name\",\"ru\":\"Name\",\"type\":\"varchar\",\"cfg\":\"{\\\"showIn\\\":\\\"top\\\",\\\"rea-dOnly\\\":true}\"}','[]'),(32,'{\"en\":\"Type\",\"ru\":\"Type\",\"_title\":\"type\",\"type\":\"_templateTypesCombo\",\"order\":\"5\",\"cfg\":\"[]\"}','[]'),(33,'{\"en\":\"Active\",\"ru\":\"Active\",\"_title\":\"visible\",\"type\":\"checkbox\",\"order\":\"6\",\"cfg\":\"{\\\"showIn\\\":\\\"top\\\"}\"}','[]'),(34,'{\"en\":\"Icon class\",\"ru\":\"Icon class\",\"_title\":\"iconCls\",\"type\":\"iconcombo\",\"order\":\"7\",\"cfg\":\"[]\"}','[]'),(35,'{\"en\":\"Config\",\"ru\":\"Config\",\"_title\":\"cfg\",\"type\":\"text\",\"order\":\"8\",\"cfg\":\"{\\\"height\\\":100}\"}','[]'),(36,'{\"en\":\"Title template\",\"ru\":\"Title template\",\"_title\":\"title_template\",\"type\":\"text\",\"order\":\"9\",\"cfg\":\"{\\\"height\\\":50}\"}','[]'),(37,'{\"en\":\"Info template\",\"ru\":\"Info template\",\"_title\":\"info_template\",\"type\":\"text\",\"order\":\"10\",\"cfg\":\"{\\\"height\\\":50}\"}','[]'),(38,'{\"en\":\"Title (en)\",\"ru\":\"Title (en)\",\"_title\":\"en\",\"type\":\"varchar\",\"order\":\"1\",\"cfg\":\"[]\"}','[]'),(39,'{\"_title\":\"iconCls\",\"en\":\"Icon class\",\"type\":\"iconcombo\",\"order\":5}','{\"solr\":[]}'),(40,'{\"_title\":\"visible\",\"en\":\"Visible\",\"type\":\"checkbox\",\"order\":6}','{\"solr\":[]}'),(41,'{\"_title\":\"order\",\"en\":\"Order\",\"type\":\"int\",\"order\":7,\"cfg\":\"{\\n\\\"indexed\\\": true\\n}\",\"solr_column_name\":\"order\"}','{\"solr\":[]}'),(42,'{\"_title\":\"en\",\"en\":\"Title\",\"type\":\"varchar\",\"order\":0,\"cfg\":\"{\\\"showIn\\\":\\\"top\\\"}\"}','{\"solr\":[]}'),(43,'{\"_title\":\"ru\",\"type\":\"varchar\",\"order\":1,\"cfg\":{\"showIn\":\"top\"}}','[]'),(44,'{\"_title\":\"_title\",\"en\":\"Title\",\"type\":\"varchar\",\"order\":1,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','[]'),(45,'{\"_title\":\"assigned\",\"en\":\"Assigned\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n  \\\"editor\\\": \\\"form\\\"\\n  ,\\\"source\\\": \\\"users\\\"\\n  ,\\\"renderer\\\": \\\"listObjIcons\\\"\\n  ,\\\"autoLoad\\\": true\\n  ,\\\"multiValued\\\": true\\n  ,\\\"hidePreview\\\": true\\n}\"}','[]'),(46,'{\"_title\":\"importance\",\"en\":\"Importance\",\"type\":\"_objects\",\"order\":8,\"cfg\":\"{\\n  \\\"scope\\\": 53,\\n  \\\"value\\\": 54,\\n  \\\"faceting\\\": true\\n}\"}','[]'),(47,'{\"_title\":\"description\",\"en\":\"Description\",\"type\":\"memo\",\"order\":10,\"cfg\":\"{\\n  \\\"height\\\": 100\\n  ,\\\"noHeader\\\": true\\n  ,\\\"hidePreview\\\": true\\n  ,\\\"linkRenderer\\\": \\\"user,object,url\\\"\\n}\"}','[]'),(48,'{\"_title\":\"_title\",\"en\":\"Name\",\"ru\":\"????????\",\"type\":\"varchar\",\"order\":1}','[]'),(49,'{\"_title\":\"_title\",\"en\":\"Text\",\"ru\":\"?????\",\"type\":\"memo\",\"order\":0,\"cfg\":\"{\\n\\\"height\\\": 100\\n}\",\"solr_column_name\":\"content\"}','[]'),(50,'{\"_title\":\"due_date\",\"en\":\"Due date\",\"type\":\"date\",\"order\":5,\"cfg\":\"{\\n\\\"hidePreview\\\": true\\n}\"}','[]'),(51,'{\"_title\":\"due_time\",\"en\":\"Due time\",\"type\":\"time\",\"order\":6,\"cfg\":\"{\\n\\\"hidePreview\\\": true\\n}\"}','[]'),(52,'{\"_title\":\"task\"}','[]'),(53,'{\"_title\":\"Importance\"}','[]'),(54,'{\"en\":\"Low\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":1}','[]'),(55,'{\"en\":\"Medium\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":2}','[]'),(56,'{\"en\":\"High\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":3}','[]'),(57,'{\"en\":\"CRITICAL\",\"iconCls\":\"icon-tag-small\",\"visible\":1,\"order\":4}','[]'),(58,'{\"_title\":\"shortcut\",\"en\":\"Shortcut\",\"type\":\"shortcut\",\"visible\":1,\"iconCls\":\"fa fa-external-link-square  fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"shortcut\\nShortcut\\nshortcut\\n1\\nfa fa-external-link-square  fa-fl\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"10\"},\"time\":\"2016-06-09T13:53:35Z\"},\"wu\":[]}'),(59,'{\"_title\":\"Menu\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":1},\"time\":\"2015-09-07T12:32:02Z\"}}'),(60,'{\"_title\":\"Menus\"}','{\"fu\":[],\"solr\":[]}'),(61,'{\"_title\":\"- Menu separator -\",\"en\":\"- Menu separator -\",\"type\":\"object\",\"visible\":1}','{\"fu\":[1],\"solr\":[]}'),(62,'{\"_title\":\"Menu rule\",\"en\":\"Menu rule\",\"type\":\"menu\",\"visible\":1}','{\"fu\":[1],\"solr\":[]}'),(63,'{\"name\":\"_title\",\"en\":\"Title\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(64,'{\"name\":\"node_ids\",\"en\":\"Nodes\",\"type\":\"_objects\",\"order\":2,\"cfg\":\"{\\\"multiValued\\\":true,\\\"editor\\\":\\\"form\\\",\\\"renderer\\\":\\\"listObjIcons\\\"}\"}','{\"fu\":[1],\"solr\":[]}'),(65,'{\"name\":\"template_ids\",\"en\":\"Templates\",\"type\":\"_objects\",\"order\":3,\"cfg\":\"{\\\"templates\\\":\\\"11\\\",\\\"editor\\\":\\\"form\\\",\\\"multiValued\\\":true,\\\"renderer\\\":\\\"listObjIcons\\\"}\"}','{\"fu\":[1],\"solr\":[]}'),(66,'{\"name\":\"user_group_ids\",\"en\":\"Users\\/Groups\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\\"source\\\":\\\"usersgroups\\\",\\\"multiValued\\\":true}\"}','{\"fu\":[1],\"solr\":[]}'),(67,'{\"name\":\"menu\",\"en\":\"Menu\",\"type\":\"_objects\",\"order\":5,\"cfg\":\"{\\\"templates\\\":\\\"11\\\",\\\"multiValued\\\":true,\\\"editor\\\":\\\"form\\\",\\\"allowValueSort\\\":true,\\\"renderer\\\":\\\"listObjIcons\\\"}\"}','{\"fu\":[1],\"solr\":[]}'),(68,'{\"_title\":\"Global Menu\",\"menu\":\"141,669,61,5,7,1205\"}','{\"fu\":[1],\"solr\":{\"content\":\"Global Menu\\n141,669,61,5,7,1205\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2131\"},\"time\":\"2016-12-15T19:26:25Z\"},\"wu\":[]}'),(69,'{\"_title\":\"System Templates\",\"node_ids\":\"3\",\"template_ids\":null,\"user_group_ids\":null,\"menu\":\"11,5\"}','{\"fu\":[1],\"solr\":[]}'),(70,'{\"_title\":\"System Templates SubMenu\",\"node_ids\":null,\"template_ids\":\"11\",\"user_group_ids\":null,\"menu\":\"12\"}','{\"fu\":[1],\"solr\":[]}'),(71,'{\"_title\":\"System Fields\",\"node_ids\":null,\"template_ids\":\"12\",\"user_group_ids\":null,\"menu\":\"12\"}','{\"fu\":[1],\"solr\":[]}'),(72,'{\"_title\":\"System Thesauri\",\"node_ids\":\"4\",\"template_ids\":\"5\",\"user_group_ids\":null,\"menu\":\"8,61,5\"}','{\"fu\":[1],\"solr\":[]}'),(73,'{\"_title\":\"Create menu rules in this folder\",\"node_ids\":60,\"menu\":62}','{\"fu\":[1],\"solr\":[]}'),(74,'{\"_title\":\"link\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:15:55Z\",\"users\":{\"1\":1}}}'),(75,'{\"_title\":\"Type\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:16:08Z\",\"users\":{\"1\":2}}}'),(76,'{\"en\":\"Article\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":1}','{\"fu\":[1],\"solr\":{\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:17:46Z\",\"users\":{\"1\":3}}}'),(77,'{\"en\":\"Document\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":2}','{\"fu\":[1],\"solr\":{\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:18:06Z\",\"users\":{\"1\":4}}}'),(78,'{\"en\":\"Image\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":3}','{\"fu\":[1],\"solr\":{\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:18:24Z\",\"users\":{\"1\":5}}}'),(79,'{\"en\":\"Sound\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":4}','{\"fu\":[1],\"solr\":{\"order\":4},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:18:42Z\",\"users\":{\"1\":6}}}'),(80,'{\"en\":\"Video\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":5}','{\"fu\":[1],\"solr\":{\"order\":5},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:19:03Z\",\"users\":{\"1\":7}}}'),(81,'{\"en\":\"Website\",\"iconCls\":\"icon-element\",\"visible\":1,\"order\":6}','{\"fu\":[1],\"solr\":{\"order\":6},\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:19:25Z\",\"users\":{\"1\":8}}}'),(82,'{\"_title\":\"Tags\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:19:43Z\",\"users\":{\"1\":9}}}'),(83,'{\"_title\":\"link\",\"en\":\"Link\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"fa fa-external-link fa-fl\",\"title_template\":\"{url}\"}','{\"fu\":[1],\"solr\":{\"content\":\"link\\nLink\\nobject\\n1\\nfa fa-external-link fa-fl\\n{url}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"11\"},\"time\":\"2016-06-09T13:53:47Z\"},\"wu\":[]}'),(84,'{\"_title\":\"type\",\"en\":\"Type\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"scope\\\": 75 \\n}\"}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:25:21Z\",\"users\":{\"1\":11}}}'),(85,'{\"_title\":\"url\",\"en\":\"URL\",\"type\":\"varchar\",\"order\":2}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:25:59Z\",\"users\":{\"1\":12}}}'),(86,'{\"_title\":\"description\",\"en\":\"Description\",\"type\":\"varchar\",\"order\":3}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-01T07:26:29Z\",\"users\":{\"1\":13}}}'),(87,'{\"_title\":\"tags\",\"en\":\"Tags\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n\\\"scope\\\": 82\\n,\\\"editor\\\": \\\"tagField\\\"\\n}\"}','{\"fu\":[1],\"solr\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":16},\"time\":\"2015-09-01T07:30:36Z\"}}'),(88,'{\"_title\":\"Built-in\"}','{\"fu\":[],\"solr\":[],\"lastAction\":{\"type\":\"create\",\"time\":\"2015-09-02T13:45:53Z\",\"users\":{\"1\":17}}}'),(89,'{\"_title\":\"Config\"}','{\"fu\":[],\"solr\":[]}'),(90,'{\"_title\":\"Config\"}','{\"fu\":[],\"solr\":[]}'),(91,'{\"_title\":\"Config int option\",\"en\":\"Config int option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gear fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config int option\\nConfig int option\\nconfig\\n1\\nfa fa-gear fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"12\"},\"time\":\"2016-06-09T13:54:28Z\"}}'),(92,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(93,'{\"name\":\"value\",\"en\":\"Value\",\"type\":\"int\",\"order\":2}','{\"fu\":[1],\"solr\":[]}'),(94,'{\"_title\":\"Config varchar option\",\"en\":\"Config varchar option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gear fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config varchar option\\nConfig varchar option\\nconfig\\n1\\nfa fa-gear fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"13\"},\"time\":\"2016-06-09T13:54:40Z\"}}'),(95,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(96,'{\"name\":\"value\",\"en\":\"Value\",\"type\":\"varchar\",\"order\":2}','{\"fu\":[1],\"solr\":[]}'),(97,'{\"_title\":\"Config text option\",\"en\":\"Config text option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gear fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config text option\\nConfig text option\\nconfig\\n1\\nfa fa-gear fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"14\"},\"time\":\"2016-06-09T13:54:50Z\"}}'),(98,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(99,'{\"name\":\"value\",\"en\":\"Value\",\"type\":\"text\",\"order\":2}','{\"fu\":[1],\"solr\":[]}'),(100,'{\"_title\":\"Config json option\",\"en\":\"Config json option\",\"type\":\"config\",\"visible\":1,\"iconCls\":\"fa fa-gears fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"Config json option\\nConfig json option\\nconfig\\n1\\nfa fa-gears fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"15\"},\"time\":\"2016-06-09T13:55:06Z\"}}'),(101,'{\"name\":\"_title\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"fu\":[1],\"solr\":[]}'),(102,'{\"en\":\"Value\",\"type\":\"text\",\"order\":2,\"cfg\":\"{\\n\\\"editor\\\":\\\"ace\\\",\\n\\\"format\\\":\\\"json\\\",\\n\\\"validator\\\":\\\"json\\\"\\n}\"}','{\"fu\":[1],\"solr\":{\"content\":\"Value\\ntext\\n2\\n{\\n\\\"editor\\\":\\\"ace\\\",\\n\\\"format\\\":\\\"json\\\",\\n\\\"validator\\\":\\\"json\\\"\\n}\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"7\"},\"time\":\"2016-04-29T08:00:26Z\"}}'),(103,'{\"name\":\"order\",\"en\":\"Order\",\"type\":\"int\",\"order\":3,\"solr_column_name\":\"order\",\"cfg\":\"{\\\"indexed\\\":true}\"}','{\"fu\":[1],\"solr\":[]}'),(104,'{\"_title\":\"project_name_en\",\"value\":\"ECMRS - Electronic Case Record Management System\"}','{\"fu\":[1],\"solr\":{\"content\":\"project_name_en\\nECMRS - Electronic Case Record Management System\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1\"},\"time\":\"2016-08-08T00:34:11Z\"}}'),(105,'{\"_title\":\"templateIcons\",\"value\":\"\\nfa fa-arrow-circle-left fa-fl\\nfa fa-arrow-circle-o-left fa-fl\\nfa fa-arrow-circle-o-right fa-fl\\nfa fa-arrow-circle-right fa-fl\\nfa fa-arrow-left fa-fl\\nfa fa-arrow-right fa-fl\\nfa fa-book fa-fl\\nfa fa-bookmark fa-fl\\nfa fa-bookmark-o fa-fl\\nfa fa-briefcase fa-fl\\nfa fa-bug fa-fl\\nfa fa-building fa-fl\\nfa fa-building-o fa-fl\\nfa fa-calendar-o fa-fl\\nfa fa-camera fa-fl\\nfa fa-comment fa-fl\\nfa fa-comment-o fa-fl\\nfa fa-commenting fa-fl\\nfa fa-commenting-o fa-fl\\nfa fa-comments fa-fl\\nfa fa-comments-o fa-fl\\nfa fa-envelope fa-fl\\nfa fa-envelope-o fa-fl\\nfa fa-external-link fa-fl\\nfa fa-external-link-square  fa-fl\\nfa fa-file fa-fl\\nfa fa-file-archive-o fa-fl\\nfa fa-file-audio-o fa-fl\\nfa fa-file-code-o fa-fl\\nfa fa-file-excel-o fa-fl\\nfa fa-file-image-o fa-fl\\nfa fa-file-movie-o fa-fl\\nfa fa-file-o fa-fl\\nfa fa-file-pdf-o fa-fl\\nfa fa-file-photo-o fa-fl\\nfa fa-file-picture-o fa-fl\\nfa fa-file-powerpoint-o fa-fl\\nfa fa-file-sound-o fa-fl\\nfa fa-file-text fa-fl\\nfa fa-file-text-o fa-fl\\nfa fa-file-video-o fa-fl\\nfa fa-file-word-o fa-fl\\nfa fa-file-zip-o fa-fl\\nfa fa-files-o fa-fl\\nfa fa-film fa-fl\\nfa fa-flash fa-fl\\nfa fa-folder fa-fl\\nfa fa-folder-o fa-fl\\nfa fa-folder-open fa-fl\\nfa fa-folder-open-o fa-fl\\nfa fa-foursquare fa-fl\\nfa fa-gavel fa-fl\\nfa fa-gear fa-fl\\nfa fa-gears fa-fl\\nfa fa-info fa-fl\\nfa fa-info-circle fa-fl\\nfa fa-institution fa-fl\\nfa fa-link fa-fl\\nfa fa-print fa-fl\\nfa fa-stack-exchange fa-fl\\nfa fa-sticky-note fa-fl\\nfa fa-sticky-note-o fa-fl\\nfa fa-suitcase fa-fl\\nfa fa-tasks fa-fl\\nfa fa-university fa-fl\\nfa fa-unlink fa-fl\\nfa fa-user fa-fl\\nfa fa-user-md fa-fl\\nfa fa-user-plus fa-fl\\nfa fa-user-secret fa-fl\\nfa fa-user-times fa-fl\\nfa fa-users fa-fl\\nfa fa-warning fa-fl\\nfa fa-wpforms fa-fl\"}','{\"fu\":[1],\"solr\":{\"content\":\"templateIcons\\n\\nfa fa-arrow-circle-left fa-fl\\nfa fa-arrow-circle-o-left fa-fl\\nfa fa-arrow-circle-o-right fa-fl\\nfa fa-arrow-circle-right fa-fl\\nfa fa-arrow-left fa-fl\\nfa fa-arrow-right fa-fl\\nfa fa-book fa-fl\\nfa fa-bookmark fa-fl\\nfa fa-bookmark-o fa-fl\\nfa fa-briefcase fa-fl\\nfa fa-bug fa-fl\\nfa fa-building fa-fl\\nfa fa-building-o fa-fl\\nfa fa-calendar-o fa-fl\\nfa fa-camera fa-fl\\nfa fa-comment fa-fl\\nfa fa-comment-o fa-fl\\nfa fa-commenting fa-fl\\nfa fa-commenting-o fa-fl\\nfa fa-comments fa-fl\\nfa fa-comments-o fa-fl\\nfa fa-envelope fa-fl\\nfa fa-envelope-o fa-fl\\nfa fa-external-link fa-fl\\nfa fa-external-link-square  fa-fl\\nfa fa-file fa-fl\\nfa fa-file-archive-o fa-fl\\nfa fa-file-audio-o fa-fl\\nfa fa-file-code-o fa-fl\\nfa fa-file-excel-o fa-fl\\nfa fa-file-image-o fa-fl\\nfa fa-file-movie-o fa-fl\\nfa fa-file-o fa-fl\\nfa fa-file-pdf-o fa-fl\\nfa fa-file-photo-o fa-fl\\nfa fa-file-picture-o fa-fl\\nfa fa-file-powerpoint-o fa-fl\\nfa fa-file-sound-o fa-fl\\nfa fa-file-text fa-fl\\nfa fa-file-text-o fa-fl\\nfa fa-file-video-o fa-fl\\nfa fa-file-word-o fa-fl\\nfa fa-file-zip-o fa-fl\\nfa fa-files-o fa-fl\\nfa fa-film fa-fl\\nfa fa-flash fa-fl\\nfa fa-folder fa-fl\\nfa fa-folder-o fa-fl\\nfa fa-folder-open fa-fl\\nfa fa-folder-open-o fa-fl\\nfa fa-foursquare fa-fl\\nfa fa-gavel fa-fl\\nfa fa-gear fa-fl\\nfa fa-gears fa-fl\\nfa fa-info fa-fl\\nfa fa-info-circle fa-fl\\nfa fa-institution fa-fl\\nfa fa-link fa-fl\\nfa fa-print fa-fl\\nfa fa-stack-exchange fa-fl\\nfa fa-sticky-note fa-fl\\nfa fa-sticky-note-o fa-fl\\nfa fa-suitcase fa-fl\\nfa fa-tasks fa-fl\\nfa fa-university fa-fl\\nfa fa-unlink fa-fl\\nfa fa-user fa-fl\\nfa fa-user-md fa-fl\\nfa fa-user-plus fa-fl\\nfa fa-user-secret fa-fl\\nfa fa-user-times fa-fl\\nfa fa-users fa-fl\\nfa fa-warning fa-fl\\nfa fa-wpforms fa-fl\\n\"},\"wu\":[],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1\"},\"time\":\"2016-06-09T13:48:36Z\"}}'),(106,'{\"_title\":\"folder_templates\",\"value\":\"5,11,100\"}','{\"fu\":[1],\"solr\":[]}'),(107,'{\"_title\":\"default_folder_template\",\"value\":\"5\"}','{\"fu\":[1],\"solr\":[]}'),(108,'{\"_title\":\"default_file_template\",\"value\":\"6\"}','{\"fu\":[1],\"solr\":[]}'),(109,'{\"_title\":\"default_task_template\",\"value\":\"7\"}','{\"fu\":[1],\"solr\":[]}'),(110,'{\"_title\":\"default_language\",\"value\":\"en\"}','{\"fu\":[1],\"solr\":[]}'),(111,'{\"_title\":\"languages\",\"value\":\"en\"}','{\"fu\":[1],\"solr\":[]}'),(112,'{\"_title\":\"object_type_plugins\",\"value\":\"{\\r\\n  \\\"object\\\": [\\\"objectProperties\\\", \\\"files\\\", \\\"tasks\\\", \\\"contentItems\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n  ,\\\"case\\\": [\\\"objectProperties\\\", \\\"files\\\", \\\"tasks\\\", \\\"contentItems\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n  ,\\\"task\\\": [\\\"objectProperties\\\", \\\"files\\\", \\\"contentItems\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n  ,\\\"file\\\": [\\\"thumb\\\", \\\"meta\\\", \\\"versions\\\", \\\"tasks\\\", \\\"comments\\\", \\\"systemProperties\\\"]\\r\\n}\"}','{\"fu\":[1],\"solr\":[]}'),(113,'{\"_title\":\"treeNodes\",\"value\":\"\"}','{\"fu\":[1],\"solr\":[]}'),(114,'{\"_title\":\"Tasks\",\"value\":\"{\\n    \\\"pid\\\": 1\\n}\",\"order\":1}','{\"fu\":[1],\"solr\":{\"order\":1}}'),(115,'{\"_title\":\"Dbnode\",\"value\":\"[]\",\"order\":2}','{\"fu\":[1],\"solr\":{\"order\":2}}'),(116,'{\"_title\":\"RecycleBin\",\"value\":\"{\\r\\n    \\\"pid\\\": \\\"1\\\",\\r\\n    \\\"facets\\\": [\\r\\n        \\\"did\\\"\\r\\n    ],\\r\\n    \\\"DC\\\": {\\r\\n        \\\"nid\\\": {}\\r\\n        ,\\\"name\\\": {}\\r\\n        ,\\\"cid\\\": {}\\r\\n        ,\\\"ddate\\\": {\\r\\n            \\\"solr_column_name\\\": \\\"ddate\\\"\\r\\n        }\\r\\n    }\\r\\n}\",\"order\":3}','{\"fu\":[1],\"solr\":{\"order\":3},\"wu\":[1],\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":1},\"time\":\"2015-11-25T13:52:47Z\"}}'),(117,'{\"_title\":\"Create config options rule\",\"node_ids\":90,\"menu\":\"91,94,97,100\"}','{\"fu\":[1],\"solr\":[]}'),(118,'{\"_title\":\"files\",\"value\":\"{\\r\\n  \\\"max_versions\\\": \\\"*:1;php,odt,doc,docx,xls,xlsx:20;pdf:5;png,gif,jpg,jpeg,tif,tiff:2;\\\"\\r\\n\\r\\n  ,\\\"edit\\\" : {\\r\\n    \\\"text\\\": \\\"txt,php,js,xml,csv\\\"\\r\\n    ,\\\"html\\\": \\\"html,htm\\\"\\r\\n    ,\\\"webdav\\\": \\\"doc,docx,ppt,dot,dotx,xls,xlsm,xltx,ppt,pot,pps,pptx,odt,ott,odm,ods,odg,otg,odp,odf,odb\\\"\\r\\n  }\\r\\n\\r\\n  ,\\\"webdav_url\\\": \\\"https:\\/\\/webdav.host.com\\/{core_name}\\/edit-{node_id}\\/{name}\\\"\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"files\\n{\\r\\n  \\\"max_versions\\\": \\\"*:1;php,odt,doc,docx,xls,xlsx:20;pdf:5;png,gif,jpg,jpeg,tif,tiff:2;\\\"\\r\\n\\r\\n  ,\\\"edit\\\" : {\\r\\n    \\\"text\\\": \\\"txt,php,js,xml,csv\\\"\\r\\n    ,\\\"html\\\": \\\"html,htm\\\"\\r\\n    ,\\\"webdav\\\": \\\"doc,docx,ppt,dot,dotx,xls,xlsm,xltx,ppt,pot,pps,pptx,odt,ott,odm,ods,odg,otg,odp,odf,odb\\\"\\r\\n  }\\r\\n\\r\\n  ,\\\"webdav_url\\\": \\\"https:\\/\\/webdav.host.com\\/{core_name}\\/edit-{node_id}\\/{name}\\\"\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:53:55Z\",\"users\":{\"1\":\"1\"}}}'),(119,'{\"_title\":\"timezone\",\"value\":\"UTC\"}','{\"wu\":[],\"solr\":{\"content\":\"timezone\\nUTC\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:55:28Z\",\"users\":{\"1\":\"2\"}}}'),(120,'{\"_title\":\"language_en\",\"value\":\"{\\r\\n\\\"name\\\": \\\"English\\\"\\r\\n,\\\"locale\\\": \\\"en_US\\\"\\r\\n,\\\"long_date_format\\\": \\\"%F %j, %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%m\\/%d\\/%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"language_en\\n{\\r\\n\\\"name\\\": \\\"English\\\"\\r\\n,\\\"locale\\\": \\\"en_US\\\"\\r\\n,\\\"long_date_format\\\": \\\"%F %j, %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%m\\/%d\\/%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:56:08Z\",\"users\":{\"1\":\"3\"}}}'),(121,'{\"_title\":\"language_fr\",\"value\":\"{\\r\\n\\\"name\\\": \\\"French\\\"\\r\\n,\\\"locale\\\": \\\"fr_FR\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\r\\n\"}','{\"wu\":[],\"solr\":{\"content\":\"language_fr\\n{\\r\\n\\\"name\\\": \\\"French\\\"\\r\\n,\\\"locale\\\": \\\"fr_FR\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\r\\n\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:56:40Z\",\"users\":{\"1\":\"4\"}}}'),(122,'{\"_title\":\"language_ru\",\"value\":\"{\\r\\n\\\"name\\\": \\\"???????\\\"\\r\\n,\\\"locale\\\": \\\"ru_RU\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"language_ru\\n{\\r\\n\\\"name\\\": \\\"???????\\\"\\r\\n,\\\"locale\\\": \\\"ru_RU\\\"\\r\\n,\\\"long_date_format\\\": \\\"%j %F %Y\\\"\\r\\n,\\\"short_date_format\\\": \\\"%d.%m.%Y\\\"\\r\\n,\\\"time_format\\\": \\\"%H:%i\\\"\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T07:57:06Z\",\"users\":{\"1\":\"5\"}}}'),(123,'{\"_title\":\"default_facet_configs\",\"value\":\"{\\r\\n  \\\"template_type\\\": {\\r\\n    \\\"title\\\": \\\"[Type]\\\"\\r\\n    ,\\\"type\\\": \\\"objectTypes\\\"\\r\\n  }\\r\\n  ,\\\"template\\\": {\\r\\n    \\\"title\\\": \\\"[Template]\\\"\\r\\n    ,\\\"field\\\": \\\"template_id\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n  }\\r\\n  ,\\\"creator\\\": {\\r\\n    \\\"title\\\": \\\"[Creator]\\\"\\r\\n    ,\\\"field\\\": \\\"cid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"owner\\\": {\\r\\n    \\\"title\\\": \\\"[Owner]\\\"\\r\\n    ,\\\"field\\\": \\\"oid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"updater\\\": {\\r\\n    \\\"title\\\": \\\"Updater\\\"\\r\\n    ,\\\"field\\\": \\\"uid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"date\\\": {\\r\\n    \\\"title\\\": \\\"[Date]\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"manualPeriod\\\": true\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"yesterday\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"date_end\\\": {\\r\\n    \\\"title\\\": \\\"End date\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"next7days\\\"\\r\\n      ,\\\"next31days\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n }\\r\\n  ,\\\"task_status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"taskStatuses\\\"\\r\\n }\\r\\n  ,\\\"assigned\\\": {\\r\\n    \\\"title\\\": \\\"Assigned\\\"\\r\\n    ,\\\"field\\\": \\\"task_u_assignee\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }, \\\"gender\\\": {\\r\\n\\\"field\\\": \\\"gender_i\\\"\\r\\n,\\\"title\\\": \\\"Gender\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}, \\r\\n\\\"headofhousehold\\\": {\\r\\n\\\"field\\\": \\\"headofhousehold_i\\\"\\r\\n,\\\"title\\\": \\\"Head of Household\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"ethnicity\\\": {\\r\\n\\\"field\\\": \\\"ethnicity_i\\\"\\r\\n,\\\"title\\\": \\\"Hispanic Origin\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"language\\\": {\\r\\n\\\"field\\\": \\\"language_i\\\"\\r\\n,\\\"title\\\": \\\"Language\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"transportationassessment\\\": {\\r\\n\\\"field\\\": \\\"transportationassessment_i\\\"\\r\\n,\\\"title\\\": \\\"Transportation Assessment\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"childassessment\\\": {\\r\\n\\\"field\\\": \\\"childassessment_i\\\"\\r\\n,\\\"title\\\": \\\"Child Assessment\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"race\\\": {\\r\\n\\\"field\\\": \\\"race_i\\\"\\r\\n,\\\"title\\\": \\\"Client Race\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"fema_tier\\\": {\\r\\n\\\"field\\\": \\\"fema_tier_i\\\"\\r\\n,\\\"title\\\": \\\"FEMA Tier\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"default_facet_configs\\n{\\r\\n  \\\"template_type\\\": {\\r\\n    \\\"title\\\": \\\"[Type]\\\"\\r\\n    ,\\\"type\\\": \\\"objectTypes\\\"\\r\\n  }\\r\\n  ,\\\"template\\\": {\\r\\n    \\\"title\\\": \\\"[Template]\\\"\\r\\n    ,\\\"field\\\": \\\"template_id\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n  }\\r\\n  ,\\\"creator\\\": {\\r\\n    \\\"title\\\": \\\"[Creator]\\\"\\r\\n    ,\\\"field\\\": \\\"cid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"owner\\\": {\\r\\n    \\\"title\\\": \\\"[Owner]\\\"\\r\\n    ,\\\"field\\\": \\\"oid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"updater\\\": {\\r\\n    \\\"title\\\": \\\"Updater\\\"\\r\\n    ,\\\"field\\\": \\\"uid\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n  }\\r\\n  ,\\\"date\\\": {\\r\\n    \\\"title\\\": \\\"[Date]\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"manualPeriod\\\": true\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"yesterday\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"date_end\\\": {\\r\\n    \\\"title\\\": \\\"End date\\\"\\r\\n    ,\\\"facet\\\": \\\"query\\\"\\r\\n    ,\\\"type\\\": \\\"dates\\\"\\r\\n    ,\\\"queries\\\": [\\r\\n      \\\"today\\\"\\r\\n      ,\\\"week\\\"\\r\\n      ,\\\"next7days\\\"\\r\\n      ,\\\"next31days\\\"\\r\\n      ,\\\"month\\\"\\r\\n    ]\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }\\r\\n  ,\\\"status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"objects\\\"\\r\\n }\\r\\n  ,\\\"task_status\\\": {\\r\\n    \\\"title\\\": \\\"[Status]\\\"\\r\\n    ,\\\"type\\\": \\\"taskStatuses\\\"\\r\\n }\\r\\n  ,\\\"assigned\\\": {\\r\\n    \\\"title\\\": \\\"Assigned\\\"\\r\\n    ,\\\"field\\\": \\\"task_u_assignee\\\"\\r\\n    ,\\\"type\\\": \\\"users\\\"\\r\\n    ,\\\"boolMode\\\": true\\r\\n  }, \\\"gender\\\": {\\r\\n\\\"field\\\": \\\"gender_i\\\"\\r\\n,\\\"title\\\": \\\"Gender\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}, \\r\\n\\\"headofhousehold\\\": {\\r\\n\\\"field\\\": \\\"headofhousehold_i\\\"\\r\\n,\\\"title\\\": \\\"Head of Household\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"ethnicity\\\": {\\r\\n\\\"field\\\": \\\"ethnicity_i\\\"\\r\\n,\\\"title\\\": \\\"Hispanic Origin\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"language\\\": {\\r\\n\\\"field\\\": \\\"language_i\\\"\\r\\n,\\\"title\\\": \\\"Language\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"transportationassessment\\\": {\\r\\n\\\"field\\\": \\\"transportationassessment_i\\\"\\r\\n,\\\"title\\\": \\\"Transportation Assessment\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"childassessment\\\": {\\r\\n\\\"field\\\": \\\"childassessment_i\\\"\\r\\n,\\\"title\\\": \\\"Child Assessment\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"race\\\": {\\r\\n\\\"field\\\": \\\"race_i\\\"\\r\\n,\\\"title\\\": \\\"Client Race\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n},\\r\\n\\\"fema_tier\\\": {\\r\\n\\\"field\\\": \\\"fema_tier_i\\\"\\r\\n,\\\"title\\\": \\\"FEMA Tier\\\"\\r\\n,\\\"type\\\": \\\"objects\\\"\\r\\n}\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2246\"},\"time\":\"2017-01-04T15:46:51Z\"}}'),(124,'{\"_title\":\"node_facets\",\"value\":\"{\\r\\n\\\"1\\\" : [\\r\\n  \\\"template_type\\\"\\r\\n  ,\\\"creator\\\"\\r\\n  ,\\\"template\\\"\\r\\n  ,\\\"date\\\"\\r\\n  ,\\\"status\\\"\\r\\n  ,\\\"assigned\\\"\\r\\n],\\r\\n\\\"150\\\" : [\\r\\n\\\"status\\\",\\r\\n\\\"taskstatus\\\",\\r\\n\\\"assigned\\\",\\r\\n \\\"race\\\",\\r\\n \\\"gender\\\",\\r\\n \\\"maritalstatus\\\",\\r\\n \\\"ethnicity\\\",\\r\\n \\\"language\\\",\\r\\n \\\"headofhousehold\\\",\\r\\n\\\"transportationassessment\\\",\\r\\n\\\"childassessment\\\"\\r\\n]\\r\\n\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"node_facets\\n{\\r\\n\\\"1\\\" : [\\r\\n  \\\"template_type\\\"\\r\\n  ,\\\"creator\\\"\\r\\n  ,\\\"template\\\"\\r\\n  ,\\\"date\\\"\\r\\n  ,\\\"status\\\"\\r\\n  ,\\\"assigned\\\"\\r\\n],\\r\\n\\\"150\\\" : [\\r\\n\\\"status\\\",\\r\\n\\\"taskstatus\\\",\\r\\n\\\"assigned\\\",\\r\\n \\\"race\\\",\\r\\n \\\"gender\\\",\\r\\n \\\"maritalstatus\\\",\\r\\n \\\"ethnicity\\\",\\r\\n \\\"language\\\",\\r\\n \\\"headofhousehold\\\",\\r\\n\\\"transportationassessment\\\",\\r\\n\\\"childassessment\\\"\\r\\n]\\r\\n\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2257\"},\"time\":\"2017-01-04T20:16:31Z\"}}'),(125,'{\"_title\":\"default_object_plugins\",\"value\":\"{\\r\\n  \\\"objectProperties\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"!template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 0\\r\\n  }\\r\\n  ,\\\"files\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 2\\r\\n  }\\r\\n  ,\\\"tasks\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 3\\r\\n  }\\r\\n  ,\\\"contentItems\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"file,time_tracking\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 4\\r\\n  }\\r\\n  ,\\\"thumb\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 5\\r\\n  }\\r\\n  ,\\\"currentVersion\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 6\\r\\n  }\\r\\n  ,\\\"versions\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 7\\r\\n  }\\r\\n  ,\\\"meta\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 8\\r\\n  }\\r\\n  ,\\\"comments\\\": {\\r\\n    \\\"order\\\": 9\\r\\n    ,\\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"time_tracking\\\"\\r\\n    }\\r\\n\\r\\n  }\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"default_object_plugins\\n{\\r\\n  \\\"objectProperties\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"!template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 0\\r\\n  }\\r\\n  ,\\\"files\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 2\\r\\n  }\\r\\n  ,\\\"tasks\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"object,search,case,task\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 3\\r\\n  }\\r\\n  ,\\\"contentItems\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"file,time_tracking\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 4\\r\\n  }\\r\\n  ,\\\"thumb\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"!context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 5\\r\\n  }\\r\\n  ,\\\"currentVersion\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"context\\\": \\\"window\\\"\\r\\n      ,\\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 6\\r\\n  }\\r\\n  ,\\\"versions\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 7\\r\\n  }\\r\\n  ,\\\"meta\\\": {\\r\\n    \\\"visibility\\\": {\\r\\n      \\\"template_type\\\": \\\"file\\\"\\r\\n    }\\r\\n    ,\\\"order\\\": 8\\r\\n  }\\r\\n  ,\\\"comments\\\": {\\r\\n    \\\"order\\\": 9\\r\\n    ,\\\"visibility\\\": {\\r\\n      \\\"!template_type\\\": \\\"time_tracking\\\"\\r\\n    }\\r\\n\\r\\n  }\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"13\"},\"time\":\"2016-04-29T08:15:53Z\"}}'),(126,'{\"_title\":\"images_display_size\",\"value\":512000}','{\"wu\":[],\"solr\":{\"content\":\"images_display_size\\n512000\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:11:54Z\",\"users\":{\"1\":\"10\"}}}'),(127,'{\"_title\":\"default_DC\",\"value\":\"{\\r\\n\\\"nid\\\": {}\\r\\n,\\\"name\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"name\\\"\\r\\n}\\r\\n,\\\"cid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cid\\\"\\r\\n}\\r\\n,\\\"oid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"oid\\\"\\r\\n}\\r\\n,\\\"cdate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cdate\\\"\\r\\n}\\r\\n,\\\"udate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"udate\\\"\\r\\n}\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"default_DC\\n{\\r\\n\\\"nid\\\": {}\\r\\n,\\\"name\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"name\\\"\\r\\n}\\r\\n,\\\"cid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cid\\\"\\r\\n}\\r\\n,\\\"oid\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"oid\\\"\\r\\n}\\r\\n,\\\"cdate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"cdate\\\"\\r\\n}\\r\\n,\\\"udate\\\": {\\r\\n  \\\"solr_column_name\\\": \\\"udate\\\"\\r\\n}\\r\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1170\"},\"time\":\"2016-10-21T16:03:08Z\"}}'),(128,'{\"_title\":\"default_availableViews\",\"value\":\"grid,charts,pivot,activityStream,calendar,dashboard\"}','{\"wu\":[],\"solr\":{\"content\":\"default_availableViews\\ngrid,charts,pivot,activityStream,calendar,dashboard\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2202\"},\"time\":\"2016-12-27T17:23:53Z\"}}'),(129,'{\"_title\":\"DCConfigs\"}','{\"wu\":[],\"solr\":{\"content\":\"DCConfigs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:17:58Z\",\"users\":{\"1\":\"14\"}}}'),(130,'{\"_title\":\"dc_tasks\",\"value\":\"{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"phase\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_phase\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"dc_tasks\\n{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"phase\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_phase\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:18:25Z\",\"users\":{\"1\":\"15\"}}}'),(131,'{\"_title\":\"dc_tasks_closed\",\"value\":\"{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }    \\r\\n    ,\\\"time_completed\\\":{\\r\\n        \\\"columnWidth\\\":\\\"20\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"task_d_closed\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_d_closed\\\"\\r\\n        ,\\\"xtype\\\":\\\"datecolumn\\\"\\r\\n        ,\\\"format\\\":\\\"Y-m-d\\\"\\r\\n        ,\\\"title\\\":\\\"Closed date\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"dc_tasks_closed\\n{\\r\\n    \\\"nid\\\":[]\\r\\n    ,\\\"name\\\":[]\\r\\n    ,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"task_importance\\\"}\\r\\n    ,\\\"order\\\":{\\\"solr_column_name\\\":\\\"task_order\\\"\\r\\n        ,\\\"sortType\\\":\\\"asInt\\\"\\r\\n        ,\\\"align\\\":\\\"center\\\"\\r\\n        ,\\\"columnWidth\\\":\\\"10\\\"\\r\\n    }\\r\\n    ,\\\"project\\\": {\\r\\n        \\\"solr_column_name\\\": \\\"task_projects\\\"\\r\\n    }    \\r\\n    ,\\\"time_completed\\\":{\\r\\n        \\\"columnWidth\\\":\\\"20\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"time_estimated\\\":{\\r\\n        \\\"width\\\":\\\"20px\\\"\\r\\n        ,\\\"format\\\":\\\"H:i\\\"\\r\\n    }\\r\\n    ,\\\"task_d_closed\\\":{\\r\\n        \\\"solr_column_name\\\":\\\"task_d_closed\\\"\\r\\n        ,\\\"xtype\\\":\\\"datecolumn\\\"\\r\\n        ,\\\"format\\\":\\\"Y-m-d\\\"\\r\\n        ,\\\"title\\\":\\\"Closed date\\\"\\r\\n    }\\r\\n    ,\\\"cid\\\":[]\\r\\n    ,\\\"cdate\\\":[]\\r\\n    ,\\\"assigned\\\":[]\\r\\n    ,\\\"comment_user_id\\\":[]\\r\\n    ,\\\"comment_date\\\":[]\\r\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-04-29T08:20:59Z\",\"users\":{\"1\":\"16\"}}}'),(132,'{\"_title\":\"geoMapping\",\"value\":\"true\"}','{\"wu\":[],\"solr\":{\"content\":\"geoMapping\\ntrue\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2\"},\"time\":\"2016-08-08T00:34:42Z\"}}'),(134,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1757\"},\"time\":\"2016-12-08T17:47:48Z\"}}'),(135,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1758\"},\"time\":\"2016-12-08T17:47:51Z\"}}'),(136,'{\"_title\":\"Client\"}','{\"wu\":[],\"solr\":{\"content\":\"Client\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"159\"},\"time\":\"2016-09-29T15:47:22Z\"}}'),(137,'{\"en\":\"FEMA Tier\",\"iconCls\":\"fa fa-building-o fa-fl\",\"visible\":1,\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Tier\\nfa fa-building-o fa-fl\\n1\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1669\"},\"time\":\"2016-12-06T17:07:06Z\"}}'),(138,'{\"en\":\"Tier 3: Significant Unmet Needs\",\"iconCls\":\"fa fa-warning fa-fl\",\"visible\":1,\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Tier 3: Significant Unmet Needs\\nfa fa-warning fa-fl\\n1\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"631\"},\"time\":\"2016-10-03T19:19:31Z\"}}'),(139,'{\"en\":\"Tier 4: Immediate and Long-Term Unmet Needs\",\"iconCls\":\"fa fa-external-link-square  fa-fl\",\"visible\":1,\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Tier 4: Immediate and Long-Term Unmet Needs\\nfa fa-external-link-square  fa-fl\\n1\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"632\"},\"time\":\"2016-10-03T19:20:01Z\"}}'),(140,'{\"_title\":\"Custom\"}','{\"wu\":[],\"solr\":{\"content\":\"Custom\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"13\"},\"time\":\"2016-08-08T00:44:41Z\"}}'),(141,'{\"_title\":\"Client\",\"en\":\"Client\",\"type\":\"case\",\"visible\":1,\"iconCls\":\"icon-case\",\"cfg\":\"{\\n\\\"DC\\\": {\\n  \\\"nid\\\": {},\\n  \\\"name\\\": {},\\n  \\\"type\\\": {},\\n  \\\"cfg\\\": {},\\n  \\\"order\\\": {\\n     \\\"sortType\\\": \\\"asInt\\\"\\n     ,\\\"solr_column_name\\\": \\\"order\\\"\\n  }\\n}\\n}\",\"title_template\":\"{_firstname}  {_lastname}\"}','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2326\"},\"time\":\"2017-01-09T01:10:44Z\"}}'),(142,'{\"_title\":\"_firstname\",\"en\":\"First Name\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"firstname_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_firstname\\nFirst Name\\nvarchar\\n2\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true,\\n\\\"faceting\\\":true\\n}\\nfirstname_s\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1791\"},\"time\":\"2016-12-12T13:57:46Z\"}}'),(143,'{\"_title\":\"_lastname\",\"en\":\"Last Name\",\"type\":\"varchar\",\"order\":1,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true,\\n\\\"faceting\\\":true}\",\"solr_column_name\":\"lastname_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_lastname\\nLast Name\\nvarchar\\n1\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true,\\n\\\"faceting\\\":true}\\nlastname_s\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1789\"},\"time\":\"2016-12-12T13:57:37Z\"}}'),(144,'{\"_title\":\"_header\",\"en\":\"Client Information\",\"type\":\"H\",\"order\":0}','{\"wu\":[],\"solr\":{\"content\":\"_header\\nClient Information\\nH\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"214\"},\"time\":\"2016-09-29T19:09:13Z\"}}'),(145,'{\"_title\":\"_femacategory\",\"en\":\"FEMA Category\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n  \\\"scope\\\": 137,\\n  \\\"value\\\": 138,\\n  \\\"faceting\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_femacategory\\nFEMA Category\\n_objects\\n4\\n{\\n  \\\"scope\\\": 137,\\n  \\\"value\\\": 138,\\n  \\\"faceting\\\": true\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"122\"},\"time\":\"2016-09-29T15:20:38Z\"}}'),(146,'{\"_title\":\"Person SubMenu\",\"template_ids\":\"7\",\"menu\":\"141\"}','{\"wu\":[],\"solr\":{\"content\":\"Person SubMenu\\n7\\n141\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"48\"},\"time\":\"2016-08-08T02:05:50Z\"}}'),(147,'{\"_title\":\"Person SubMenu\",\"template_ids\":\"141\",\"menu\":\"141\"}','{\"wu\":[],\"solr\":{\"content\":\"Person SubMenu\\n141\\n141\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"67\"},\"time\":\"2016-08-08T09:42:46Z\"}}'),(149,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1762\"},\"time\":\"2016-12-08T17:48:09Z\"}}'),(150,'{\"_title\":\"Clients\"}','{\"wu\":[3,1,6],\"solr\":{\"content\":\"Clients\\n\",\"comment_user_id\":6,\"comment_date\":\"2016-10-17T19:47:06Z\"},\"lastAction\":{\"type\":\"comment\",\"users\":{\"1\":\"726\",\"6\":\"727\"},\"time\":\"2016-10-17T19:47:06Z\"},\"lastComment\":{\"user_id\":6,\"date\":\"2016-10-17T19:47:06Z\"}}'),(156,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1759\"},\"time\":\"2016-12-08T17:47:56Z\"}}'),(167,'{\"en\":\"Gender\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Gender\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"126\"},\"time\":\"2016-09-29T15:26:30Z\"}}'),(168,'{\"_title\":\"System folders\"}','{\"wu\":[],\"solr\":{\"content\":\"System folders\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1764\"},\"time\":\"2016-12-08T17:48:17Z\"}}'),(169,'{\"_title\":\"Surveys\"}','{\"wu\":[],\"solr\":{\"content\":\"Surveys\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-08-08T09:38:36Z\",\"users\":{\"1\":\"62\"}}}'),(170,'{\"_title\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-08-08T09:38:43Z\",\"users\":{\"1\":\"63\"}}}'),(172,'{\"_title\":\"TransportationAssessment\",\"en\":\"Transportation Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-transportation\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Transportation Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"TransportationAssessment\\nTransportation Assessment\\ncaseassessment\\n1\\nicon-assessment-transportation\\n{\\n\\\"leaf\\\":true\\n}\\nTransportation Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2272\"},\"time\":\"2017-01-04T20:46:03Z\"}}'),(173,'{\"_title\":\"Client SubMenu\",\"template_ids\":\"141\",\"menu\":\"527,289,311,607,61,510,533,553,482,1120,455,505,559,489,440,656,1175,651,172\"}','{\"wu\":[],\"solr\":{\"content\":\"Client SubMenu\\n141\\n527,289,311,607,61,510,533,553,482,1120,455,505,559,489,440,656,1175,651,172\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2090\"},\"time\":\"2016-12-13T23:35:36Z\"}}'),(201,'{\"_title\":\"Folder\"}','{\"wu\":[],\"solr\":{\"content\":\"Folder\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1760\"},\"time\":\"2016-12-08T17:48:00Z\"}}'),(205,'{\"_title\":\"Case\",\"en\":\"Case\",\"type\":\"case\",\"visible\":1,\"iconCls\":\"icon-briefcase\",\"title_template\":\"{name}\"}','{\"wu\":[],\"solr\":{\"content\":\"Case\\nCase\\ncase\\n1\\nicon-briefcase\\n{name}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1754\"},\"time\":\"2016-12-08T17:47:37Z\"}}'),(206,'{\"_title\":\"contacts\",\"type\":\"_objects\",\"cfg\":\"{\\\"source\\\":\\\"tree\\\",\\\"multiValued\\\":true}\"}','{\"wu\":[],\"solr\":{\"content\":\"contacts\\n_objects\\n{\\\"source\\\":\\\"tree\\\",\\\"multiValued\\\":true}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"116\"},\"time\":\"2016-09-20T20:21:21Z\"}}'),(207,'{\"_title\":\"Contact\",\"en\":\"Contact\",\"type\":\"object\",\"visible\":\"Generic-2\"}','{\"wu\":[],\"solr\":{\"content\":\"Contact\\nContact\\nobject\\nGeneric-2\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1755\"},\"time\":\"2016-12-08T17:47:41Z\"}}'),(208,'{\"_title\":\"FirstName\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"FirstName\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-20T20:17:59Z\",\"users\":{\"1\":\"115\"}}}'),(209,'{\"_title\":\"_middlename\",\"en\":\"Middle Name\",\"type\":\"varchar\",\"order\":3,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"middlename_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_middlename\\nMiddle Name\\nvarchar\\n3\\n{\\n\\\"faceting\\\":true\\n}\\nmiddlename_s\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1809\"},\"time\":\"2016-12-13T14:10:48Z\"}}'),(210,'{\"_title\":\"_birthdate\",\"en\":\"Birth Date\",\"type\":\"date\",\"order\":4,\"cfg\":\"{ \\n\\\"generateAge\\\": \\\"Client Age\\\" ,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"birthdate_dt\"}','{\"wu\":[],\"solr\":{\"content\":\"_birthdate\\nBirth Date\\ndate\\n4\\n{ \\n\\\"generateAge\\\": \\\"Client Age\\\" ,\\n\\\"faceting\\\":true\\n}\\nbirthdate_dt\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1811\"},\"time\":\"2016-12-13T14:11:16Z\"}}'),(211,'{\"_title\":\"_clientage\",\"en\":\"Client Age\",\"type\":\"int\",\"order\":5,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"clientage_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientage\\nClient Age\\nint\\n5\\n{\\n\\\"faceting\\\":true\\n}\\nclientage_i\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1810\"},\"time\":\"2016-12-13T14:10:56Z\"}}'),(212,'{\"_title\":\"_gender\",\"en\":\"Gender\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\" : 167,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"gender_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_gender\\nGender\\n_objects\\n6\\n{\\n\\\"scope\\\" : 167,\\n\\\"faceting\\\":true\\n}\\ngender_i\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1230\"},\"time\":\"2016-10-21T19:25:02Z\"}}'),(213,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"131\"},\"time\":\"2016-09-29T15:28:48Z\"}}'),(214,'{\"en\":\"Male\",\"iconCls\":\"fa fa-user-secret fa-fl\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Male\\nfa fa-user-secret fa-fl\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"129\"},\"time\":\"2016-09-29T15:28:12Z\"}}'),(215,'{\"en\":\"Female\"}','{\"wu\":[],\"solr\":{\"content\":\"Female\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:28:40Z\",\"users\":{\"1\":\"130\"}}}'),(216,'{\"en\":\"Transgendered Female to Male\"}','{\"wu\":[],\"solr\":{\"content\":\"Transgendered Female to Male\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1074\"},\"time\":\"2016-10-21T15:04:24Z\"}}'),(217,'{\"en\":\"Transgendered Male to Female\"}','{\"wu\":[],\"solr\":{\"content\":\"Transgendered Male to Female\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1073\"},\"time\":\"2016-10-21T15:04:20Z\"}}'),(218,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:29:36Z\",\"users\":{\"1\":\"134\"}}}'),(219,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:29:45Z\",\"users\":{\"1\":\"135\"}}}'),(220,'{\"en\":\"Data Not Collected\"}','{\"wu\":[],\"solr\":{\"content\":\"Data Not Collected\\n\"},\"lastAction\":{\"type\":\"restore\",\"users\":{\"1\":\"1951\"},\"time\":\"2016-12-13T20:09:53Z\"}}'),(221,'{\"en\":\"Contact Method\"}','{\"wu\":[],\"solr\":{\"content\":\"Contact Method\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"142\"},\"time\":\"2016-09-29T15:33:06Z\"}}'),(222,'{\"en\":\"Phone\"}','{\"wu\":[],\"solr\":{\"content\":\"Phone\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:30:35Z\",\"users\":{\"1\":\"138\"}}}'),(223,'{\"en\":\"Email\"}','{\"wu\":[],\"solr\":{\"content\":\"Email\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:30:44Z\",\"users\":{\"1\":\"139\"}}}'),(224,'{\"en\":\"Mail\"}','{\"wu\":[],\"solr\":{\"content\":\"Mail\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:30:56Z\",\"users\":{\"1\":\"140\"}}}'),(225,'{\"en\":\"SMS\"}','{\"wu\":[],\"solr\":{\"content\":\"SMS\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:31:04Z\",\"users\":{\"1\":\"141\"}}}'),(226,'{\"en\":\"Ethnicity\"}','{\"wu\":[],\"solr\":{\"content\":\"Ethnicity\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:39:06Z\",\"users\":{\"1\":\"143\"}}}'),(227,'{\"en\":\"Race\"}','{\"wu\":[],\"solr\":{\"content\":\"Race\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:39:18Z\",\"users\":{\"1\":\"144\"}}}'),(228,'{\"en\":\"Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:39:34Z\",\"users\":{\"1\":\"145\"}}}'),(229,'{\"en\":\"Yes - Mexican, Mexican American, Chicano\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Yes - Mexican, Mexican American, Chicano\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1958\"},\"time\":\"2016-12-13T20:13:09Z\"}}'),(230,'{\"en\":\"No\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"No\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1957\"},\"time\":\"2016-12-13T20:12:51Z\"}}'),(231,'{\"en\":\"Don''t Know\",\"order\":7}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n7\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1963\"},\"time\":\"2016-12-13T20:14:00Z\"}}'),(232,'{\"en\":\"Refused\",\"order\":6}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n6\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1962\"},\"time\":\"2016-12-13T20:13:53Z\"}}'),(233,'{\"en\":\"Data Not Collected\",\"order\":8}','{\"wu\":[],\"solr\":{\"content\":\"Data Not Collected\\n8\\n\",\"order\":8},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1964\"},\"time\":\"2016-12-13T20:14:07Z\"}}'),(234,'{\"en\":\"American Indian Native or Alaska Native\"}','{\"wu\":[],\"solr\":{\"content\":\"American Indian Native or Alaska Native\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:45:29Z\",\"users\":{\"1\":\"151\"}}}'),(235,'{\"en\":\"Asian American\"}','{\"wu\":[],\"solr\":{\"content\":\"Asian American\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1965\"},\"time\":\"2016-12-13T20:15:08Z\"}}'),(236,'{\"en\":\"Black or African American\"}','{\"wu\":[],\"solr\":{\"content\":\"Black or African American\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:45:56Z\",\"users\":{\"1\":\"153\"}}}'),(237,'{\"en\":\"Native Hawaiian or Other Pacific Islander\"}','{\"wu\":[],\"solr\":{\"content\":\"Native Hawaiian or Other Pacific Islander\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:16Z\",\"users\":{\"1\":\"154\"}}}'),(238,'{\"en\":\"White\"}','{\"wu\":[],\"solr\":{\"content\":\"White\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:26Z\",\"users\":{\"1\":\"155\"}}}'),(239,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:41Z\",\"users\":{\"1\":\"156\"}}}'),(240,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:46:52Z\",\"users\":{\"1\":\"157\"}}}'),(241,'{\"en\":\"Data Not Collected\"}','{\"wu\":[],\"solr\":{\"content\":\"Data Not Collected\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:47:08Z\",\"users\":{\"1\":\"158\"}}}'),(242,'{\"en\":\"English\"}','{\"wu\":[],\"solr\":{\"content\":\"English\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:47:42Z\",\"users\":{\"1\":\"160\"}}}'),(243,'{\"en\":\"Spanish\"}','{\"wu\":[],\"solr\":{\"content\":\"Spanish\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:47:55Z\",\"users\":{\"1\":\"161\"}}}'),(244,'{\"en\":\"French\"}','{\"wu\":[],\"solr\":{\"content\":\"French\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:52:24Z\",\"users\":{\"1\":\"162\"}}}'),(245,'{\"en\":\"German\"}','{\"wu\":[],\"solr\":{\"content\":\"German\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:52:37Z\",\"users\":{\"1\":\"163\"}}}'),(246,'{\"en\":\"Italian\"}','{\"wu\":[],\"solr\":{\"content\":\"Italian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:09Z\",\"users\":{\"1\":\"164\"}}}'),(247,'{\"en\":\"Polish\"}','{\"wu\":[],\"solr\":{\"content\":\"Polish\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:19Z\",\"users\":{\"1\":\"165\"}}}'),(248,'{\"en\":\"Portuguese\"}','{\"wu\":[],\"solr\":{\"content\":\"Portuguese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:35Z\",\"users\":{\"1\":\"166\"}}}'),(249,'{\"en\":\"Russian\"}','{\"wu\":[],\"solr\":{\"content\":\"Russian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:53:47Z\",\"users\":{\"1\":\"167\"}}}'),(250,'{\"en\":\"Arabic\"}','{\"wu\":[],\"solr\":{\"content\":\"Arabic\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:00Z\",\"users\":{\"1\":\"168\"}}}'),(251,'{\"en\":\"Armenian\"}','{\"wu\":[],\"solr\":{\"content\":\"Armenian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:11Z\",\"users\":{\"1\":\"169\"}}}'),(252,'{\"en\":\"Farsi\"}','{\"wu\":[],\"solr\":{\"content\":\"Farsi\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:22Z\",\"users\":{\"1\":\"170\"}}}'),(253,'{\"en\":\"Hebrew\"}','{\"wu\":[],\"solr\":{\"content\":\"Hebrew\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:32Z\",\"users\":{\"1\":\"171\"}}}'),(254,'{\"en\":\"Turkish\"}','{\"wu\":[],\"solr\":{\"content\":\"Turkish\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:54:46Z\",\"users\":{\"1\":\"172\"}}}'),(255,'{\"en\":\"Cantonese\"}','{\"wu\":[],\"solr\":{\"content\":\"Cantonese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:55:04Z\",\"users\":{\"1\":\"173\"}}}'),(256,'{\"en\":\"Mandarin\"}','{\"wu\":[],\"solr\":{\"content\":\"Mandarin\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:55:18Z\",\"users\":{\"1\":\"174\"}}}'),(257,'{\"en\":\"Mien\"}','{\"wu\":[],\"solr\":{\"content\":\"Mien\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"177\"},\"time\":\"2016-09-29T15:55:51Z\"}}'),(258,'{\"en\":\"American Sign Language\"}','{\"wu\":[],\"solr\":{\"content\":\"American Sign Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:55:38Z\",\"users\":{\"1\":\"176\"}}}'),(259,'{\"en\":\"Cambodian\"}','{\"wu\":[],\"solr\":{\"content\":\"Cambodian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:56:46Z\",\"users\":{\"1\":\"178\"}}}'),(260,'{\"en\":\"Other Chinese Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Chinese Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:57:06Z\",\"users\":{\"1\":\"179\"}}}'),(261,'{\"en\":\"Hmong\"}','{\"wu\":[],\"solr\":{\"content\":\"Hmong\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:57:16Z\",\"users\":{\"1\":\"180\"}}}'),(262,'{\"en\":\"Lao\"}','{\"wu\":[],\"solr\":{\"content\":\"Lao\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:57:26Z\",\"users\":{\"1\":\"181\"}}}'),(263,'{\"en\":\"Thai\"}','{\"wu\":[],\"solr\":{\"content\":\"Thai\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:59:44Z\",\"users\":{\"1\":\"182\"}}}'),(264,'{\"en\":\"Vietnamese\"}','{\"wu\":[],\"solr\":{\"content\":\"Vietnamese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T15:59:54Z\",\"users\":{\"1\":\"183\"}}}'),(265,'{\"en\":\"Tagalog\"}','{\"wu\":[],\"solr\":{\"content\":\"Tagalog\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:04Z\",\"users\":{\"1\":\"184\"}}}'),(266,'{\"en\":\"Ilocano\"}','{\"wu\":[],\"solr\":{\"content\":\"Ilocano\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:15Z\",\"users\":{\"1\":\"185\"}}}'),(267,'{\"en\":\"Japanese\"}','{\"wu\":[],\"solr\":{\"content\":\"Japanese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:25Z\",\"users\":{\"1\":\"186\"}}}'),(268,'{\"en\":\"Korean\"}','{\"wu\":[],\"solr\":{\"content\":\"Korean\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:38Z\",\"users\":{\"1\":\"187\"}}}'),(269,'{\"en\":\"Samoan\"}','{\"wu\":[],\"solr\":{\"content\":\"Samoan\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:00:53Z\",\"users\":{\"1\":\"188\"}}}'),(270,'{\"en\":\"Other Sign Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Sign Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:01:08Z\",\"users\":{\"1\":\"189\"}}}'),(271,'{\"en\":\"Other Non English\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Non English\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-09-29T16:01:22Z\",\"users\":{\"1\":\"190\"}}}'),(272,'{\"_title\":\"_emailaddress\",\"en\":\"Email Address\",\"type\":\"varchar\",\"order\":11,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"emailaddress_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_emailaddress\\nEmail Address\\nvarchar\\n11\\n{\\n\\\"faceting\\\":true\\n}\\nemailaddress_s\\n\",\"order\":11},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2735\"},\"time\":\"2017-01-12T02:54:03Z\"}}'),(274,'{\"_title\":\"_ethnicity\",\"en\":\"Hispanic Origin?\",\"type\":\"_objects\",\"order\":9,\"cfg\":\"{\\n\\\"scope\\\" : 226,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"ethnicity_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_ethnicity\\nHispanic Origin?\\n_objects\\n9\\n{\\n\\\"scope\\\" : 226,\\n\\\"faceting\\\":true\\n}\\nethnicity_i\\n\",\"order\":9},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2729\"},\"time\":\"2017-01-12T02:48:59Z\"}}'),(275,'{\"_title\":\"_race\",\"en\":\"Race\",\"type\":\"_objects\",\"order\":10,\"cfg\":\"{\\n\\\"scope\\\" : 227,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"race_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_race\\nRace\\n_objects\\n10\\n{\\n\\\"scope\\\" : 227,\\n\\\"faceting\\\":true\\n}\\nrace_i\\n\",\"order\":10},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1807\"},\"time\":\"2016-12-13T14:10:21Z\"}}'),(276,'{\"_title\":\"_primarylanguage\",\"en\":\"Primary Language\",\"type\":\"_objects\",\"order\":10,\"cfg\":\"{\\n\\\"scope\\\" : 228,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"primarylanguage_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_primarylanguage\\nPrimary Language\\n_objects\\n10\\n{\\n\\\"scope\\\" : 228,\\n\\\"faceting\\\":true\\n}\\nprimarylanguage_i\\n\",\"order\":10},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2736\"},\"time\":\"2017-01-12T02:56:02Z\"}}'),(277,'{\"_title\":\"languageassessment\",\"en\":\"Individuals with Limited English Proficiency\",\"type\":\"_objects\",\"order\":21,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"limitedenglish_i\"}','{\"wu\":[],\"solr\":{\"content\":\"languageassessment\\nIndividuals with Limited English Proficiency\\n_objects\\n21\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\nlimitedenglish_i\\n\",\"order\":21},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2345\"},\"time\":\"2017-01-10T15:37:23Z\"}}'),(278,'{\"_title\":\"_specialatrisk\",\"en\":\"Special\\/At-Risk Populations\",\"type\":\"H\",\"order\":12}','{\"wu\":[],\"solr\":{\"content\":\"_specialatrisk\\nSpecial\\/At-Risk Populations\\nH\\n12\\n\",\"order\":12},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"213\"},\"time\":\"2016-09-29T19:09:06Z\"}}'),(279,'{\"_title\":\"at_risk_population\",\"en\":\"Self-Reported Special\\/At-Risk Populations\",\"type\":\"_objects\",\"order\":20,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"required\\\":true\\n,\\\"source\\\": \\\"tree\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"fields\\\":\\\"title\\\"\\n,\\\"scope\\\":1496\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": false\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"at_risk_population\\nSelf-Reported Special\\/At-Risk Populations\\n_objects\\n20\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"required\\\":true\\n,\\\"source\\\": \\\"tree\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"fields\\\":\\\"title\\\"\\n,\\\"scope\\\":1496\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": false\\n}\\n\",\"order\":20},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2916\"},\"time\":\"2017-01-18T21:57:32Z\"}}'),(280,'{\"_title\":\"_domestic\",\"en\":\"Domestic Violence Survivors?\",\"type\":\"_objects\",\"order\":19,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"domestic_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_domestic\\nDomestic Violence Survivors?\\n_objects\\n19\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\ndomestic_i\\n\",\"order\":19},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2857\"},\"time\":\"2017-01-14T01:26:35Z\"}}'),(286,'{\"_title\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"Test\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"227\"},\"time\":\"2016-09-29T19:51:59Z\"}}'),(287,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"229\"},\"time\":\"2016-09-29T19:52:15Z\"}}'),(288,'{\"_title\":\"Cases\",\"value\":\"{\\n\\\"pid\\\": 1,\\n\\\"DC\\\": {\\n  \\\"id\\\": {},\\n  \\\"name\\\": {},\\n  \\\"assigned\\\": {},\\n  \\\"task_d_closed\\\":{},\\n  \\\"cdate\\\":{\\\"title\\\":\\\"Created\\\"}\\n}\\n}\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Cases\\n{\\n\\\"pid\\\": 1,\\n\\\"DC\\\": {\\n  \\\"id\\\": {},\\n  \\\"name\\\": {},\\n  \\\"assigned\\\": {},\\n  \\\"task_d_closed\\\":{},\\n  \\\"cdate\\\":{\\\"title\\\":\\\"Created\\\"}\\n}\\n}\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2340\"},\"time\":\"2017-01-09T14:42:35Z\"}}'),(289,'{\"_title\":\"FamilyMember\",\"en\":\"Family Member\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-object4\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"{_firstname} {_lastname} - {_relationship}\"}','{\"wu\":[],\"solr\":{\"content\":\"FamilyMember\\nFamily Member\\nobject\\n1\\nicon-object4\\n{\\n\\\"leaf\\\":true\\n}\\n{_firstname} {_lastname} - {_relationship}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2745\"},\"time\":\"2017-01-12T15:24:52Z\"}}'),(290,'{\"_title\":\"_firstname\",\"en\":\"First Name\",\"type\":\"varchar\",\"order\":1,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_firstname\\nFirst Name\\nvarchar\\n1\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"240\"},\"time\":\"2016-10-03T13:26:58Z\"}}'),(291,'{\"_title\":\"_lastname\",\"en\":\"Last Name\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_lastname\\nLast Name\\nvarchar\\n2\\n{\\n\\\"required\\\": true\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"241\"},\"time\":\"2016-10-03T13:27:06Z\"}}'),(292,'{\"_title\":\"_birthdate\",\"en\":\"Birth Date\",\"type\":\"date\",\"order\":4,\"cfg\":\"{ \\n\\\"generateAge\\\": \\\"Age\\\" ,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_birthdate\\nBirth Date\\ndate\\n4\\n{ \\n\\\"generateAge\\\": \\\"Age\\\" ,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2724\"},\"time\":\"2017-01-12T02:39:57Z\"}}'),(293,'{\"_title\":\"_age\",\"en\":\"Age\",\"type\":\"int\",\"order\":5,\"cfg\":\"\\t{ \\n\\\"readOnly\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_age\\nAge\\nint\\n5\\n\\t{ \\n\\\"readOnly\\\": true\\n}\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2725\"},\"time\":\"2017-01-12T02:40:21Z\"}}'),(294,'{\"_title\":\"_gender\",\"en\":\"Gender\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\" : 167\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_gender\\nGender\\n_objects\\n6\\n{\\n\\\"scope\\\" : 167\\n}\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1446\"},\"time\":\"2016-11-02T19:37:16Z\"}}'),(295,'{\"_title\":\"_relationship\",\"en\":\"Relationship to Head of Household\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n\\\"scope\\\" : 299,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_relationship\\nRelationship to Head of Household\\n_objects\\n7\\n{\\n\\\"scope\\\" : 299,\\n\\\"required\\\":true\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2744\"},\"time\":\"2017-01-12T15:24:07Z\"}}'),(296,'{\"_title\":\"_middlename\",\"en\":\"Middle Name\",\"type\":\"varchar\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"_middlename\\nMiddle Name\\nvarchar\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:30:21Z\",\"users\":{\"1\":\"246\"}}}'),(297,'{\"_title\":\"_race\",\"en\":\"Race\",\"type\":\"_objects\",\"order\":9,\"cfg\":\"{\\n\\\"scope\\\" : 227,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_race\\nRace\\n_objects\\n9\\n{\\n\\\"scope\\\" : 227,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":9},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2741\"},\"time\":\"2017-01-12T03:10:26Z\"}}'),(298,'{\"_title\":\"_ethnicity\",\"en\":\"Hispanic Origin?\",\"type\":\"_objects\",\"order\":8,\"cfg\":\"{\\n\\\"scope\\\" : 226,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_ethnicity\\nHispanic Origin?\\n_objects\\n8\\n{\\n\\\"scope\\\" : 226,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":8},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2742\"},\"time\":\"2017-01-12T03:10:35Z\"}}'),(299,'{\"en\":\"Relationship\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Relationship\\n1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:33:36Z\",\"users\":{\"1\":\"252\"}}}'),(300,'{\"en\":\"Parent\"}','{\"wu\":[],\"solr\":{\"content\":\"Parent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:33:55Z\",\"users\":{\"1\":\"253\"}}}'),(301,'{\"en\":\"Son\"}','{\"wu\":[],\"solr\":{\"content\":\"Son\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:02Z\",\"users\":{\"1\":\"254\"}}}'),(302,'{\"en\":\"Daughter\"}','{\"wu\":[],\"solr\":{\"content\":\"Daughter\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:11Z\",\"users\":{\"1\":\"255\"}}}'),(303,'{\"en\":\"Dependent Child\"}','{\"wu\":[],\"solr\":{\"content\":\"Dependent Child\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:26Z\",\"users\":{\"1\":\"256\"}}}'),(304,'{\"en\":\"Grandparent\"}','{\"wu\":[],\"solr\":{\"content\":\"Grandparent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:37Z\",\"users\":{\"1\":\"257\"}}}'),(305,'{\"en\":\"Guardian\"}','{\"wu\":[],\"solr\":{\"content\":\"Guardian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:46Z\",\"users\":{\"1\":\"258\"}}}'),(306,'{\"en\":\"Spouse\"}','{\"wu\":[],\"solr\":{\"content\":\"Spouse\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:34:53Z\",\"users\":{\"1\":\"259\"}}}'),(307,'{\"en\":\"Other Family Member\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Family Member\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:02Z\",\"users\":{\"1\":\"260\"}}}'),(308,'{\"en\":\"Other Non-Family\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Non-Family\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:11Z\",\"users\":{\"1\":\"261\"}}}'),(309,'{\"en\":\"Other Caretaker\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Caretaker\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:19Z\",\"users\":{\"1\":\"262\"}}}'),(310,'{\"en\":\"Ex Spouse\"}','{\"wu\":[],\"solr\":{\"content\":\"Ex Spouse\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:35:26Z\",\"users\":{\"1\":\"263\"}}}'),(311,'{\"_title\":\"Address\",\"en\":\"Address\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-object8\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Address\"}','{\"wu\":[],\"solr\":{\"content\":\"Address\\nAddress\\nobject\\n1\\nicon-object8\\n{\\n\\\"leaf\\\":true\\n}\\nAddress\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1553\"},\"time\":\"2016-11-14T15:22:24Z\"}}'),(312,'{\"_title\":\"_addresstype\",\"en\":\"Address Type\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"scope\\\" : 321\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_addresstype\\nAddress Type\\n_objects\\n1\\n{\\n\\\"scope\\\" : 321\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"294\"},\"time\":\"2016-10-03T13:55:49Z\"}}'),(313,'{\"_title\":\"_addressone\",\"en\":\"Address One\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"addressone_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_addressone\\nAddress One\\nvarchar\\n2\\n{\\n\\\"faceting\\\":true\\n}\\naddressone_s\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1251\"},\"time\":\"2016-10-22T02:20:48Z\"}}'),(314,'{\"_title\":\"_addresstwo\",\"en\":\"Apt\\/Suite\",\"type\":\"varchar\",\"order\":3,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"undefined\"}','{\"wu\":[],\"solr\":{\"content\":\"_addresstwo\\nApt\\/Suite\\nvarchar\\n3\\n{\\n\\\"faceting\\\":true\\n}\\nundefined\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"982\"},\"time\":\"2016-10-21T13:42:18Z\"}}'),(315,'{\"_title\":\"_city\",\"en\":\"City\",\"type\":\"varchar\",\"order\":4,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"city_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_city\\nCity\\nvarchar\\n4\\n{\\n\\\"faceting\\\":true\\n}\\ncity_s\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"892\"},\"time\":\"2016-10-20T22:17:34Z\"}}'),(316,'{\"_title\":\"_state\",\"en\":\"State\",\"type\":\"varchar\",\"order\":4,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"state_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_state\\nState\\nvarchar\\n4\\n{\\n\\\"faceting\\\":true\\n}\\nstate_s\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"921\"},\"time\":\"2016-10-21T01:45:36Z\"}}'),(317,'{\"_title\":\"_zip\",\"en\":\"Zip code\",\"type\":\"int\",\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"_zip\\nZip code\\nint\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:50:40Z\",\"users\":{\"1\":\"278\"}}}'),(318,'{\"_title\":\"_begindate\",\"en\":\"Begin Date\",\"type\":\"date\",\"order\":6}','{\"wu\":[],\"solr\":{\"content\":\"_begindate\\nBegin Date\\ndate\\n6\\n\",\"order\":6},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:51:11Z\",\"users\":{\"1\":\"279\"}}}'),(319,'{\"_title\":\"_enddate\",\"en\":\"End Date\",\"type\":\"date\",\"order\":7}','{\"wu\":[],\"solr\":{\"content\":\"_enddate\\nEnd Date\\ndate\\n7\\n\",\"order\":7},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:51:48Z\",\"users\":{\"1\":\"280\"}}}'),(320,'{\"_title\":\"_primaryphone\",\"en\":\"Primary Phone\",\"type\":\"varchar\",\"order\":8}','{\"wu\":[],\"solr\":{\"content\":\"_primaryphone\\nPrimary Phone\\nvarchar\\n8\\n\",\"order\":8},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:52:12Z\",\"users\":{\"1\":\"281\"}}}'),(321,'{\"en\":\"AddressType\"}','{\"wu\":[],\"solr\":{\"content\":\"AddressType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:52:35Z\",\"users\":{\"1\":\"282\"}}}'),(322,'{\"en\":\"Current Mailing\"}','{\"wu\":[],\"solr\":{\"content\":\"Current Mailing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:09Z\",\"users\":{\"1\":\"283\"}}}'),(323,'{\"en\":\"Temporary\"}','{\"wu\":[],\"solr\":{\"content\":\"Temporary\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:17Z\",\"users\":{\"1\":\"284\"}}}'),(324,'{\"en\":\"Summer\"}','{\"wu\":[],\"solr\":{\"content\":\"Summer\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:24Z\",\"users\":{\"1\":\"285\"}}}'),(325,'{\"en\":\"Previous Mailing\"}','{\"wu\":[],\"solr\":{\"content\":\"Previous Mailing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:33Z\",\"users\":{\"1\":\"286\"}}}'),(326,'{\"en\":\"Emergency\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:42Z\",\"users\":{\"1\":\"287\"}}}'),(327,'{\"en\":\"Business Address\\/Place of Employment\"}','{\"wu\":[],\"solr\":{\"content\":\"Business Address\\/Place of Employment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:53:54Z\",\"users\":{\"1\":\"288\"}}}'),(328,'{\"en\":\"Residential\"}','{\"wu\":[],\"solr\":{\"content\":\"Residential\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:04Z\",\"users\":{\"1\":\"289\"}}}'),(329,'{\"en\":\"Transitional\"}','{\"wu\":[],\"solr\":{\"content\":\"Transitional\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:14Z\",\"users\":{\"1\":\"290\"}}}'),(330,'{\"en\":\"Last Permanent Address\"}','{\"wu\":[],\"solr\":{\"content\":\"Last Permanent Address\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:26Z\",\"users\":{\"1\":\"291\"}}}'),(331,'{\"en\":\"Permanent Supportive\"}','{\"wu\":[],\"solr\":{\"content\":\"Permanent Supportive\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:38Z\",\"users\":{\"1\":\"292\"}}}'),(332,'{\"en\":\"Homeless in Area of Disaster\"}','{\"wu\":[],\"solr\":{\"content\":\"Homeless in Area of Disaster\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T13:54:51Z\",\"users\":{\"1\":\"293\"}}}'),(333,'{\"_title\":\"Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"299\"},\"time\":\"2016-10-03T14:14:18Z\"}}'),(334,'{\"en\":\"LivingArrangement\",\"visible\":\"Generic-4\"}','{\"wu\":[],\"solr\":{\"content\":\"LivingArrangement\\nGeneric-4\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:14:42Z\",\"users\":{\"1\":\"300\"}}}'),(335,'{\"en\":\"Owned house\\/condominium\"}','{\"wu\":[],\"solr\":{\"content\":\"Owned house\\/condominium\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:14:58Z\",\"users\":{\"1\":\"301\"}}}'),(336,'{\"en\":\"Rental house\"}','{\"wu\":[],\"solr\":{\"content\":\"Rental house\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:07Z\",\"users\":{\"1\":\"302\"}}}'),(337,'{\"en\":\"Rental apartment\"}','{\"wu\":[],\"solr\":{\"content\":\"Rental apartment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:18Z\",\"users\":{\"1\":\"303\"}}}'),(338,'{\"en\":\"Staying with friends\\/family\"}','{\"wu\":[],\"solr\":{\"content\":\"Staying with friends\\/family\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:30Z\",\"users\":{\"1\":\"304\"}}}'),(339,'{\"en\":\"Shelter (domestic violence, homeless, runaway and youth)\"}','{\"wu\":[],\"solr\":{\"content\":\"Shelter (domestic violence, homeless, runaway and youth)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:15:51Z\",\"users\":{\"1\":\"305\"}}}'),(340,'{\"en\":\"Military Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Military Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:01Z\",\"users\":{\"1\":\"306\"}}}'),(341,'{\"en\":\"Student dormitory\"}','{\"wu\":[],\"solr\":{\"content\":\"Student dormitory\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:11Z\",\"users\":{\"1\":\"307\"}}}'),(342,'{\"en\":\"Group home or nursing home\"}','{\"wu\":[],\"solr\":{\"content\":\"Group home or nursing home\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:23Z\",\"users\":{\"1\":\"308\"}}}'),(343,'{\"en\":\"Subsidized housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Subsidized housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:33Z\",\"users\":{\"1\":\"309\"}}}'),(344,'{\"en\":\"Homeless\"}','{\"wu\":[],\"solr\":{\"content\":\"Homeless\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:42Z\",\"users\":{\"1\":\"310\"}}}'),(345,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:16:49Z\",\"users\":{\"1\":\"311\"}}}'),(346,'{\"en\":\"YesNoRefused\"}','{\"wu\":[],\"solr\":{\"content\":\"YesNoRefused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:17:10Z\",\"users\":{\"1\":\"312\"}}}'),(347,'{\"en\":\"Yes\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Yes\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"641\"},\"time\":\"2016-10-03T19:40:45Z\"}}'),(348,'{\"en\":\"No\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"No\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"642\"},\"time\":\"2016-10-03T19:40:59Z\"}}'),(349,'{\"en\":\"Don''t know\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Don''t know\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"643\"},\"time\":\"2016-10-03T19:41:12Z\"}}'),(350,'{\"en\":\"Refused\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"644\"},\"time\":\"2016-10-03T19:41:24Z\"}}'),(351,'{\"en\":\"InspectingAgent\"}','{\"wu\":[],\"solr\":{\"content\":\"InspectingAgent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:08Z\",\"users\":{\"1\":\"317\"}}}'),(352,'{\"en\":\"By an insurance adjustor\"}','{\"wu\":[],\"solr\":{\"content\":\"By an insurance adjustor\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:25Z\",\"users\":{\"1\":\"318\"}}}'),(353,'{\"en\":\"By a FEMA official\"}','{\"wu\":[],\"solr\":{\"content\":\"By a FEMA official\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:36Z\",\"users\":{\"1\":\"319\"}}}'),(354,'{\"en\":\"By a local government official\"}','{\"wu\":[],\"solr\":{\"content\":\"By a local government official\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:18:48Z\",\"users\":{\"1\":\"320\"}}}'),(355,'{\"en\":\"DamageRating\"}','{\"wu\":[],\"solr\":{\"content\":\"DamageRating\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:13Z\",\"users\":{\"1\":\"321\"}}}'),(356,'{\"en\":\"Not Damaged\"}','{\"wu\":[],\"solr\":{\"content\":\"Not Damaged\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:31Z\",\"users\":{\"1\":\"322\"}}}'),(357,'{\"en\":\"Minor\"}','{\"wu\":[],\"solr\":{\"content\":\"Minor\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:38Z\",\"users\":{\"1\":\"323\"}}}'),(358,'{\"en\":\"Major\"}','{\"wu\":[],\"solr\":{\"content\":\"Major\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:44Z\",\"users\":{\"1\":\"324\"}}}'),(359,'{\"en\":\"Destroyed\"}','{\"wu\":[],\"solr\":{\"content\":\"Destroyed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:19:53Z\",\"users\":{\"1\":\"325\"}}}'),(360,'{\"en\":\"Client doesn''t know\"}','{\"wu\":[],\"solr\":{\"content\":\"Client doesn''t know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:04Z\",\"users\":{\"1\":\"326\"}}}'),(361,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:11Z\",\"users\":{\"1\":\"327\"}}}'),(362,'{\"en\":\"Utilities\"}','{\"wu\":[],\"solr\":{\"content\":\"Utilities\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"332\"},\"time\":\"2016-10-03T14:21:29Z\"}}'),(363,'{\"en\":\"Electrical power\"}','{\"wu\":[],\"solr\":{\"content\":\"Electrical power\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:45Z\",\"users\":{\"1\":\"329\"}}}'),(364,'{\"en\":\"Phone\"}','{\"wu\":[],\"solr\":{\"content\":\"Phone\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:20:56Z\",\"users\":{\"1\":\"330\"}}}'),(365,'{\"en\":\"Water\"}','{\"wu\":[],\"solr\":{\"content\":\"Water\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:21:06Z\",\"users\":{\"1\":\"331\"}}}'),(366,'{\"en\":\"Gas\"}','{\"wu\":[],\"solr\":{\"content\":\"Gas\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:21:41Z\",\"users\":{\"1\":\"333\"}}}'),(367,'{\"en\":\"Internet access\"}','{\"wu\":[],\"solr\":{\"content\":\"Internet access\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:21:52Z\",\"users\":{\"1\":\"334\"}}}'),(368,'{\"en\":\"Propane\"}','{\"wu\":[],\"solr\":{\"content\":\"Propane\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:02Z\",\"users\":{\"1\":\"335\"}}}'),(369,'{\"en\":\"Fuel oil\"}','{\"wu\":[],\"solr\":{\"content\":\"Fuel oil\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:12Z\",\"users\":{\"1\":\"336\"}}}'),(370,'{\"en\":\"Steam heat\"}','{\"wu\":[],\"solr\":{\"content\":\"Steam heat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:21Z\",\"users\":{\"1\":\"337\"}}}'),(371,'{\"en\":\"Sewer and Sanitation\"}','{\"wu\":[],\"solr\":{\"content\":\"Sewer and Sanitation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:33Z\",\"users\":{\"1\":\"338\"}}}'),(372,'{\"en\":\"InsuranceStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"InsuranceStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:22:56Z\",\"users\":{\"1\":\"339\"}}}'),(373,'{\"en\":\"Client owned home and had homeowner''s insurance\"}','{\"wu\":[],\"solr\":{\"content\":\"Client owned home and had homeowner''s insurance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:23:36Z\",\"users\":{\"1\":\"340\"}}}'),(374,'{\"en\":\"Client rented home and had renter''s insurance\"}','{\"wu\":[],\"solr\":{\"content\":\"Client rented home and had renter''s insurance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:23:49Z\",\"users\":{\"1\":\"341\"}}}'),(375,'{\"en\":\"Client had hazard-specific insurance for disaster type (food, fire, earthquake)\"}','{\"wu\":[],\"solr\":{\"content\":\"Client had hazard-specific insurance for disaster type (food, fire, earthquake)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:09Z\",\"users\":{\"1\":\"342\"}}}'),(376,'{\"en\":\"Lack of appropriate Insurance Coverage\"}','{\"wu\":[],\"solr\":{\"content\":\"Lack of appropriate Insurance Coverage\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:22Z\",\"users\":{\"1\":\"343\"}}}'),(377,'{\"en\":\"Client does not know insurance status\"}','{\"wu\":[],\"solr\":{\"content\":\"Client does not know insurance status\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:34Z\",\"users\":{\"1\":\"344\"}}}'),(378,'{\"en\":\"Client was insured but does not have insurance policy information\"}','{\"wu\":[],\"solr\":{\"content\":\"Client was insured but does not have insurance policy information\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:49Z\",\"users\":{\"1\":\"345\"}}}'),(379,'{\"en\":\"Client was uninsured\"}','{\"wu\":[],\"solr\":{\"content\":\"Client was uninsured\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:24:58Z\",\"users\":{\"1\":\"346\"}}}'),(380,'{\"en\":\"HousingServiceType\"}','{\"wu\":[],\"solr\":{\"content\":\"HousingServiceType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:31:51Z\",\"users\":{\"1\":\"347\"}}}'),(381,'{\"en\":\"Emergency Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:03Z\",\"users\":{\"1\":\"348\"}}}'),(382,'{\"en\":\"Housing Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:14Z\",\"users\":{\"1\":\"349\"}}}'),(383,'{\"en\":\"Housing Bednight\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Bednight\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:25Z\",\"users\":{\"1\":\"350\"}}}'),(384,'{\"en\":\"Housing Placement\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Placement\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:36Z\",\"users\":{\"1\":\"351\"}}}'),(385,'{\"en\":\"Housing Reservation\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Reservation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:32:50Z\",\"users\":{\"1\":\"352\"}}}'),(386,'{\"en\":\"Tarp \\/ Blue Roof\"}','{\"wu\":[],\"solr\":{\"content\":\"Tarp \\/ Blue Roof\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:33:02Z\",\"users\":{\"1\":\"353\"}}}'),(387,'{\"en\":\"Temporary Housing and Other Financial Aid\"}','{\"wu\":[],\"solr\":{\"content\":\"Temporary Housing and Other Financial Aid\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:33:21Z\",\"users\":{\"1\":\"354\"}}}'),(388,'{\"en\":\"Transitional Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Transitional Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:33:33Z\",\"users\":{\"1\":\"355\"}}}'),(389,'{\"en\":\"IncomeGroup\"}','{\"wu\":[],\"solr\":{\"content\":\"IncomeGroup\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:34:58Z\",\"users\":{\"1\":\"356\"}}}'),(390,'{\"en\":\"Cash Income\"}','{\"wu\":[],\"solr\":{\"content\":\"Cash Income\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:35:08Z\",\"users\":{\"1\":\"357\"}}}'),(391,'{\"en\":\"Non-cash benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Non-cash benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:35:17Z\",\"users\":{\"1\":\"358\"}}}'),(392,'{\"en\":\"TransportationMode\"}','{\"wu\":[],\"solr\":{\"content\":\"TransportationMode\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:41:42Z\",\"users\":{\"1\":\"359\"}}}'),(393,'{\"en\":\"Privately owned vehicle or motorcycle\"}','{\"wu\":[],\"solr\":{\"content\":\"Privately owned vehicle or motorcycle\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:00Z\",\"users\":{\"1\":\"360\"}}}'),(394,'{\"en\":\"Public Transit\"}','{\"wu\":[],\"solr\":{\"content\":\"Public Transit\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:10Z\",\"users\":{\"1\":\"361\"}}}'),(395,'{\"en\":\"Paratransit\"}','{\"wu\":[],\"solr\":{\"content\":\"Paratransit\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:18Z\",\"users\":{\"1\":\"362\"}}}'),(396,'{\"en\":\"Carshare\"}','{\"wu\":[],\"solr\":{\"content\":\"Carshare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:26Z\",\"users\":{\"1\":\"363\"}}}'),(397,'{\"en\":\"Ride with friends\\/family\"}','{\"wu\":[],\"solr\":{\"content\":\"Ride with friends\\/family\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:36Z\",\"users\":{\"1\":\"364\"}}}'),(398,'{\"en\":\"Bike\"}','{\"wu\":[],\"solr\":{\"content\":\"Bike\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:43Z\",\"users\":{\"1\":\"365\"}}}'),(399,'{\"en\":\"Walk\"}','{\"wu\":[],\"solr\":{\"content\":\"Walk\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:50Z\",\"users\":{\"1\":\"366\"}}}'),(400,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:42:58Z\",\"users\":{\"1\":\"367\"}}}'),(401,'{\"en\":\"TransportationNeed\"}','{\"wu\":[],\"solr\":{\"content\":\"TransportationNeed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:21Z\",\"users\":{\"1\":\"368\"}}}'),(402,'{\"en\":\"Vehicle lost\\/destroyed\"}','{\"wu\":[],\"solr\":{\"content\":\"Vehicle lost\\/destroyed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:37Z\",\"users\":{\"1\":\"369\"}}}'),(403,'{\"en\":\"Public transit not working\"}','{\"wu\":[],\"solr\":{\"content\":\"Public transit not working\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:46Z\",\"users\":{\"1\":\"370\"}}}'),(404,'{\"en\":\"Paratransit not working\\/accessible\"}','{\"wu\":[],\"solr\":{\"content\":\"Paratransit not working\\/accessible\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:43:58Z\",\"users\":{\"1\":\"371\"}}}'),(405,'{\"en\":\"Road closure\\/damage\"}','{\"wu\":[],\"solr\":{\"content\":\"Road closure\\/damage\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:07Z\",\"users\":{\"1\":\"372\"}}}'),(406,'{\"en\":\"Unable to afford gas\"}','{\"wu\":[],\"solr\":{\"content\":\"Unable to afford gas\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:17Z\",\"users\":{\"1\":\"373\"}}}'),(407,'{\"en\":\"Unable to afford transit fare\"}','{\"wu\":[],\"solr\":{\"content\":\"Unable to afford transit fare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:29Z\",\"users\":{\"1\":\"374\"}}}'),(408,'{\"en\":\"Unable to afford gas dependably\"}','{\"wu\":[],\"solr\":{\"content\":\"Unable to afford gas dependably\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:44:51Z\",\"users\":{\"1\":\"375\"}}}'),(409,'{\"en\":\"Accessible vehicle not available\"}','{\"wu\":[],\"solr\":{\"content\":\"Accessible vehicle not available\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:45:06Z\",\"users\":{\"1\":\"376\"}}}'),(410,'{\"en\":\"PaymentStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"PaymentStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:01Z\",\"users\":{\"1\":\"377\"}}}'),(411,'{\"en\":\"EmploymentTenure\"}','{\"wu\":[],\"solr\":{\"content\":\"EmploymentTenure\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"392\"},\"time\":\"2016-10-03T14:52:51Z\"}}'),(412,'{\"en\":\"Received Payment\"}','{\"wu\":[],\"solr\":{\"content\":\"Received Payment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:21Z\",\"users\":{\"1\":\"379\"}}}'),(413,'{\"en\":\"Denied\"}','{\"wu\":[],\"solr\":{\"content\":\"Denied\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:29Z\",\"users\":{\"1\":\"380\"}}}'),(414,'{\"en\":\"Pending Payment\"}','{\"wu\":[],\"solr\":{\"content\":\"Pending Payment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:39Z\",\"users\":{\"1\":\"381\"}}}'),(415,'{\"en\":\"Pending Decision\"}','{\"wu\":[],\"solr\":{\"content\":\"Pending Decision\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:46:49Z\",\"users\":{\"1\":\"382\"}}}'),(416,'{\"en\":\"InsuranceType\"}','{\"wu\":[],\"solr\":{\"content\":\"InsuranceType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:12Z\",\"users\":{\"1\":\"383\"}}}'),(417,'{\"en\":\"Private\"}','{\"wu\":[],\"solr\":{\"content\":\"Private\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:23Z\",\"users\":{\"1\":\"384\"}}}'),(418,'{\"en\":\"Medicare\"}','{\"wu\":[],\"solr\":{\"content\":\"Medicare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:31Z\",\"users\":{\"1\":\"385\"}}}'),(419,'{\"en\":\"Medicaid\"}','{\"wu\":[],\"solr\":{\"content\":\"Medicaid\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:41Z\",\"users\":{\"1\":\"386\"}}}'),(420,'{\"en\":\"State Children''s Health Insurance Program S-CHIP\"}','{\"wu\":[],\"solr\":{\"content\":\"State Children''s Health Insurance Program S-CHIP\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:48:55Z\",\"users\":{\"1\":\"387\"}}}'),(421,'{\"en\":\"Military Insurance\"}','{\"wu\":[],\"solr\":{\"content\":\"Military Insurance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:49:04Z\",\"users\":{\"1\":\"388\"}}}'),(422,'{\"en\":\"Other Public\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Public\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:49:13Z\",\"users\":{\"1\":\"389\"}}}'),(423,'{\"en\":\"CaseNoteType\"}','{\"wu\":[],\"solr\":{\"content\":\"CaseNoteType\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"391\"},\"time\":\"2016-10-03T14:51:31Z\"}}'),(424,'{\"en\":\"Permanent\"}','{\"wu\":[],\"solr\":{\"content\":\"Permanent\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:25Z\",\"users\":{\"1\":\"393\"}}}'),(425,'{\"en\":\"Temporary\"}','{\"wu\":[],\"solr\":{\"content\":\"Temporary\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:34Z\",\"users\":{\"1\":\"394\"}}}'),(426,'{\"en\":\"Seasonal\"}','{\"wu\":[],\"solr\":{\"content\":\"Seasonal\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:42Z\",\"users\":{\"1\":\"395\"}}}'),(427,'{\"en\":\"Don''t Know\"}','{\"wu\":[],\"solr\":{\"content\":\"Don''t Know\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:50Z\",\"users\":{\"1\":\"396\"}}}'),(428,'{\"en\":\"Refused\"}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:53:57Z\",\"users\":{\"1\":\"397\"}}}'),(429,'{\"en\":\"AssessmentOrder\"}','{\"wu\":[],\"solr\":{\"content\":\"AssessmentOrder\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:54:31Z\",\"users\":{\"1\":\"398\"}}}'),(430,'{\"en\":\"Pre-Disaster\"}','{\"wu\":[],\"solr\":{\"content\":\"Pre-Disaster\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:54:53Z\",\"users\":{\"1\":\"399\"}}}'),(431,'{\"en\":\"Post-Disaster\"}','{\"wu\":[],\"solr\":{\"content\":\"Post-Disaster\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T14:55:02Z\",\"users\":{\"1\":\"400\"}}}'),(432,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1322\"},\"time\":\"2016-10-28T19:48:28Z\"}}'),(433,'{\"_title\":\"_primarymode\",\"en\":\"What was the client''s primary mode of transportation prior to the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 392\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_primarymode\\nWhat was the client''s primary mode of transportation prior to the disaster?\\n_objects\\n{\\n\\\"scope\\\": 392\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1659\"},\"time\":\"2016-11-14T20:56:51Z\"}}'),(434,'{\"_title\":\"_methodworking\",\"en\":\"Is this method of transportation still working for the client post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [393]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_methodworking\\nIs this method of transportation still working for the client post-disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [393]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2044\"},\"time\":\"2016-12-13T22:48:05Z\"}}'),(435,'{\"_title\":\"_ifnotworking\",\"en\":\"If the client''s primary mode of transportation prior to the disaster is a privately owned vehicle or motorcycle and the method of transportation is not working post-disaster, answer the following:\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_ifnotworking\\nIf the client''s primary mode of transportation prior to the disaster is a privately owned vehicle or motorcycle and the method of transportation is not working post-disaster, answer the following:\\nH\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2053\"},\"time\":\"2016-12-13T22:53:24Z\"}}'),(436,'{\"_title\":\"_insured\",\"en\":\"Was it insured?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insured\\nWas it insured?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2050\"},\"time\":\"2016-12-13T22:51:05Z\"}}'),(437,'{\"_title\":\"_receivedpayment\",\"en\":\"Have you received payments or been denied by your insurer?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_receivedpayment\\nHave you received payments or been denied by your insurer?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2051\"},\"time\":\"2016-12-13T22:51:19Z\"}}'),(438,'{\"_title\":\"_damagedindisaster\",\"en\":\"Was your vehicle damaged in the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_damagedindisaster\\nWas your vehicle damaged in the disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2049\"},\"time\":\"2016-12-13T22:50:49Z\"}}'),(439,'{\"_title\":\"_transportationneeds\",\"en\":\"Transportation Needs\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 401\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_transportationneeds\\nTransportation Needs\\n_objects\\n{\\n   \\\"scope\\\": 401\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2052\"},\"time\":\"2016-12-13T22:51:39Z\"}}'),(440,'{\"_title\":\"HousingAssessment\",\"en\":\"Housing Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-object8\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Housing Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"HousingAssessment\\nHousing Assessment\\ncaseassessment\\n1\\nicon-object8\\n{\\n\\\"leaf\\\":true\\n}\\nHousing Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2267\"},\"time\":\"2017-01-04T20:45:06Z\"}}'),(441,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1318\"},\"time\":\"2016-10-28T19:47:52Z\"}}'),(442,'{\"_title\":\"_predisasterliving\",\"en\":\"Where did the client live pre-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":334\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_predisasterliving\\nWhere did the client live pre-disaster?\\n_objects\\n{\\n\\\"scope\\\":334\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:32:29Z\",\"users\":{\"1\":\"413\"}}}'),(443,'{\"_title\":\"_damagedhouse\",\"en\":\"In the disaster, was client home damaged or affected?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_damagedhouse\\nIn the disaster, was client home damaged or affected?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:33:27Z\",\"users\":{\"1\":\"414\"}}}'),(444,'{\"_title\":\"_inspectedhouse\",\"en\":\"If client home was damaged, has the home been inspected?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\t\\\"scope\\\": 351\\n\\t,\\\"dependency\\\": {\\n\\t\\t\\\"pidValues\\\": [347]\\n\\t}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_inspectedhouse\\nIf client home was damaged, has the home been inspected?\\n_objects\\n{\\n\\t\\\"scope\\\": 351\\n\\t,\\\"dependency\\\": {\\n\\t\\t\\\"pidValues\\\": [347]\\n\\t}\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1490\"},\"time\":\"2016-11-04T14:56:02Z\"}}'),(445,'{\"_title\":\"_accessiblehouse\",\"en\":\"Is the client able to access the home?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_accessiblehouse\\nIs the client able to access the home?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"419\"},\"time\":\"2016-10-03T15:36:03Z\"}}'),(446,'{\"_title\":\"_livablehouse\",\"en\":\"Does client consider home livable or inhabitable?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_livablehouse\\nDoes client consider home livable or inhabitable?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"418\"},\"time\":\"2016-10-03T15:35:52Z\"}}'),(447,'{\"_title\":\"_clientdamagerating\",\"en\":\"Client Damage Rating\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 355\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientdamagerating\\nClient Damage Rating\\n_objects\\n{\\n\\\"scope\\\": 355\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:36:30Z\",\"users\":{\"1\":\"420\"}}}'),(448,'{\"_title\":\"_clientrelocated\",\"en\":\"Was client relocated\\/evacuated?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientrelocated\\nWas client relocated\\/evacuated?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:37:06Z\",\"users\":{\"1\":\"421\"}}}'),(449,'{\"_title\":\"_planstoreturn\",\"en\":\"If yes, what are client''s plan to return home?\",\"type\":\"text\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n   \\t\\\"pidValues\\\": [347]\\n    }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_planstoreturn\\nIf yes, what are client''s plan to return home?\\ntext\\n{\\n   \\\"dependency\\\": {\\n   \\t\\\"pidValues\\\": [347]\\n    }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1656\"},\"time\":\"2016-11-14T20:55:02Z\"}}'),(450,'{\"_title\":\"_utilitieswork\",\"en\":\"Do all of client''s utilities work?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_utilitieswork\\nDo all of client''s utilities work?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1654\"},\"time\":\"2016-11-14T20:53:58Z\"}}'),(451,'{\"_title\":\"_utilitiesnotworking\",\"en\":\"If no, please select utilities that do not work\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 362\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_utilitiesnotworking\\nIf no, please select utilities that do not work\\n_objects\\n{\\n   \\\"scope\\\": 362\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1487\"},\"time\":\"2016-11-04T14:52:53Z\"}}'),(452,'{\"_title\":\"_disasterImpacts\",\"en\":\"Details of Disaster Impacts to Home\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_disasterImpacts\\nDetails of Disaster Impacts to Home\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:39:23Z\",\"users\":{\"1\":\"425\"}}}'),(453,'{\"_title\":\"_predisasterinsurance\",\"en\":\"Pre-disaster housing insurance status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 372\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_predisasterinsurance\\nPre-disaster housing insurance status\\n_objects\\n{\\n\\\"scope\\\": 372\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:40:02Z\",\"users\":{\"1\":\"426\"}}}'),(454,'{\"_title\":\"_insurancedetails\",\"en\":\"Details of insurance information\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_insurancedetails\\nDetails of insurance information\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:40:35Z\",\"users\":{\"1\":\"427\"}}}'),(455,'{\"_title\":\"FinancialAssessment\",\"en\":\"Financial Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-echr_complaint\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Financial Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"FinancialAssessment\\nFinancial Assessment\\ncaseassessment\\n1\\nicon-echr_complaint\\n{\\n\\\"leaf\\\":true\\n}\\nFinancial Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2263\"},\"time\":\"2017-01-04T20:44:26Z\"}}'),(456,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1315\"},\"time\":\"2016-10-28T19:47:12Z\"}}'),(457,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1652\"},\"time\":\"2016-11-14T20:51:48Z\"}}'),(458,'{\"_title\":\"_incomereceived\",\"en\":\"Income Received?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_incomereceived\\nIncome Received?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1651\"},\"time\":\"2016-11-14T20:51:27Z\"}}'),(459,'{\"_title\":\"_noncashbenefits\",\"en\":\"Non-cash Benefits?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_noncashbenefits\\nNon-cash Benefits?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1650\"},\"time\":\"2016-11-14T20:51:03Z\"}}'),(460,'{\"_title\":\"_incomeGroup\",\"en\":\"Income Group\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 389\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_incomeGroup\\nIncome Group\\n_objects\\n{\\n\\\"scope\\\": 389\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:44:54Z\",\"users\":{\"1\":\"433\"}}}'),(461,'{\"_title\":\"_noncashbenefits\",\"en\":\"If Income or Non-cash Benefits received, enter income\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_noncashbenefits\\nIf Income or Non-cash Benefits received, enter income\\nH\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:46:01Z\",\"users\":{\"1\":\"434\"}}}'),(462,'{\"_title\":\"_earnedIncome\",\"en\":\"Earned income (i.e. employment income)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_earnedIncome\\nEarned income (i.e. employment income)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:46:26Z\",\"users\":{\"1\":\"435\"}}}'),(463,'{\"_title\":\"_unemploymentinsurance\",\"en\":\"Unemployment Insurance\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_unemploymentinsurance\\nUnemployment Insurance\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:46:56Z\",\"users\":{\"1\":\"436\"}}}'),(464,'{\"_title\":\"_ssi\",\"en\":\"Supplemental Security Income (SSI)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_ssi\\nSupplemental Security Income (SSI)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:47:26Z\",\"users\":{\"1\":\"437\"}}}'),(465,'{\"_title\":\"_ssdi\",\"en\":\"Social Security Disability Income (SSDI)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_ssdi\\nSocial Security Disability Income (SSDI)\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:47:49Z\",\"users\":{\"1\":\"438\"}}}'),(466,'{\"_title\":\"_veteransdisability\",\"en\":\"Veterans Disability Payment\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_veteransdisability\\nVeterans Disability Payment\\nfloat\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T15:48:24Z\",\"users\":{\"1\":\"439\"}}}'),(467,'{\"_title\":\"MonthlyExpensesAssessment\",\"en\":\"Monthly Expenses Assessment\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-echr_complaint\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Monthly Expenses Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"MonthlyExpensesAssessment\\nMonthly Expenses Assessment\\nobject\\n1\\nicon-echr_complaint\\n{\\n\\\"leaf\\\":true\\n}\\nMonthly Expenses Assessment\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2017\"},\"time\":\"2016-12-13T21:39:49Z\"}}'),(468,'{\"_title\":\"_assessmentorder\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentorder\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"442\"},\"time\":\"2016-10-03T15:51:19Z\"}}'),(469,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1320\"},\"time\":\"2016-10-28T19:48:10Z\"}}'),(470,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1658\"},\"time\":\"2016-11-14T20:56:05Z\"}}'),(471,'{\"_title\":\"_rent\",\"en\":\"Rent\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\" : \\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_rent\\nRent\\nfloat\\n{ \\n\\\"totalValue\\\" : \\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1689\"},\"time\":\"2016-12-06T17:33:16Z\"}}'),(472,'{\"_title\":\"_mortgage\",\"en\":\"Mortgage\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_mortgage\\nMortgage\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1680\"},\"time\":\"2016-12-06T17:23:15Z\"}}'),(473,'{\"_title\":\"_maintenance\",\"en\":\"Maintenance\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_maintenance\\nMaintenance\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1681\"},\"time\":\"2016-12-06T17:23:49Z\"}}'),(474,'{\"_title\":\"_carpayment\",\"en\":\"Car Payment\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_carpayment\\nCar Payment\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1687\"},\"time\":\"2016-12-06T17:26:31Z\"}}'),(475,'{\"_title\":\"_carinsurance\",\"en\":\"Car Insurance\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_carinsurance\\nCar Insurance\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1686\"},\"time\":\"2016-12-06T17:26:22Z\"}}'),(476,'{\"_title\":\"_gasoline\",\"en\":\"Gasoline\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_gasoline\\nGasoline\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1685\"},\"time\":\"2016-12-06T17:26:15Z\"}}'),(477,'{\"_title\":\"_medical\",\"en\":\"Medical\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_medical\\nMedical\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1684\"},\"time\":\"2016-12-06T17:26:06Z\"}}'),(478,'{\"_title\":\"_food\",\"en\":\"Food\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_food\\nFood\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1683\"},\"time\":\"2016-12-06T17:25:58Z\"}}'),(479,'{\"_title\":\"_miscellaneous\",\"en\":\"Miscellaneous\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_miscellaneous\\nMiscellaneous\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1682\"},\"time\":\"2016-12-06T17:25:49Z\"}}'),(480,'{\"_title\":\"_totalExpenses\",\"en\":\"Number of Expenses\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_totalExpenses\\nNumber of Expenses\\nint\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1678\"},\"time\":\"2016-12-06T17:22:20Z\"}}'),(481,'{\"_title\":\"_totalmonthlyamount\",\"en\":\"Total monthly amount\",\"type\":\"float\",\"cfg\":\"{\\n\\\"readonly\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_totalmonthlyamount\\nTotal monthly amount\\nfloat\\n{\\n\\\"readonly\\\":true\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1677\"},\"time\":\"2016-12-06T17:21:36Z\"}}'),(482,'{\"_title\":\"EmploymentAssessment\",\"en\":\"Employment Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-employment\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Employment Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"EmploymentAssessment\\nEmployment Assessment\\ncaseassessment\\n1\\nicon-assessment-employment\\n{\\n\\\"leaf\\\":true\\n}\\nEmployment Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2261\"},\"time\":\"2017-01-04T20:43:57Z\"}}'),(483,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1314\"},\"time\":\"2016-10-28T19:46:56Z\"}}'),(484,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1648\"},\"time\":\"2016-11-14T20:50:31Z\"}}'),(485,'{\"_title\":\"_employed\",\"en\":\"Employed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_employed\\nEmployed?\\n_objects\\n{\\n\\\"scope\\\":346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1445\"},\"time\":\"2016-11-02T19:37:01Z\"}}'),(486,'{\"_title\":\"_hoursworked\",\"en\":\"Hours worked last week\",\"type\":\"int\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_hoursworked\\nHours worked last week\\nint\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1536\"},\"time\":\"2016-11-04T17:34:56Z\"}}'),(487,'{\"_title\":\"_employmenttenure\",\"en\":\"Employment Tenure\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 411\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_employmenttenure\\nEmployment Tenure\\n_objects\\n{\\n   \\\"scope\\\": 411\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1538\"},\"time\":\"2016-11-04T17:35:48Z\"}}'),(488,'{\"_title\":\"_additionalemployment\",\"en\":\"Looking for additional employment\\/increased hours?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_additionalemployment\\nLooking for additional employment\\/increased hours?\\n_objects\\n{\\n\\\"scope\\\":346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1444\"},\"time\":\"2016-11-02T19:36:55Z\"}}'),(489,'{\"_title\":\"HealthAssessment\",\"en\":\"Health Insurance and Access to Health Care\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-case_card\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Health Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"HealthAssessment\\nHealth Insurance and Access to Health Care\\ncaseassessment\\n1\\nicon-case_card\\n{\\n\\\"leaf\\\":true\\n}\\nHealth Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2532\"},\"time\":\"2017-01-11T15:39:18Z\"}}'),(490,'{\"_title\":\"_assessmentdate\",\"en\":\"Date Added\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nDate Added\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:03:59Z\",\"users\":{\"1\":\"466\"}}}'),(491,'{\"_title\":\"_insuranceType\",\"en\":\"Insurance Type\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 416\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insuranceType\\nInsurance Type\\n_objects\\n{\\n\\\"scope\\\": 416\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:05:05Z\",\"users\":{\"1\":\"467\"}}}'),(492,'{\"_title\":\"_isPrimary\",\"en\":\"Is Primary?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_isPrimary\\nIs Primary?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1454\"},\"time\":\"2016-11-02T19:39:54Z\"}}'),(493,'{\"_title\":\"_medscovered\",\"en\":\"Meds Covered?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_medscovered\\nMeds Covered?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1453\"},\"time\":\"2016-11-02T19:39:48Z\"}}'),(494,'{\"_title\":\"_dmecovered\",\"en\":\"Durable Medical Equipment (DME) covered?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_dmecovered\\nDurable Medical Equipment (DME) covered?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1456\"},\"time\":\"2016-11-02T19:40:12Z\"}}'),(495,'{\"_title\":\"_insurancestatus\",\"en\":\"Status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 501\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insurancestatus\\nStatus\\n_objects\\n{\\n\\\"scope\\\": 501\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"481\"},\"time\":\"2016-10-03T16:12:39Z\"}}'),(496,'{\"_title\":\"_insurancelostdisaster\",\"en\":\"Was this insurance lost as a result of the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_insurancelostdisaster\\nWas this insurance lost as a result of the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1455\"},\"time\":\"2016-11-02T19:40:05Z\"}}'),(497,'{\"_title\":\"_whatcausedinsuranceloss\",\"en\":\"What caused the insurance coverage to be lost?\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_whatcausedinsuranceloss\\nWhat caused the insurance coverage to be lost?\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:08:52Z\",\"users\":{\"1\":\"473\"}}}'),(498,'{\"_title\":\"_startdate\",\"en\":\"Start Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_startdate\\nStart Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:09:06Z\",\"users\":{\"1\":\"474\"}}}'),(499,'{\"_title\":\"_enddate\",\"en\":\"End Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_enddate\\nEnd Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:09:19Z\",\"users\":{\"1\":\"475\"}}}'),(500,'{\"_title\":\"_appliedfordate\",\"en\":\"Applied For Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_appliedfordate\\nApplied For Date\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:09:34Z\",\"users\":{\"1\":\"476\"}}}'),(501,'{\"en\":\"InsuranceStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"InsuranceStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:11:50Z\",\"users\":{\"1\":\"477\"}}}'),(502,'{\"en\":\"Pending\\/Applied\"}','{\"wu\":[],\"solr\":{\"content\":\"Pending\\/Applied\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:12:04Z\",\"users\":{\"1\":\"478\"}}}'),(503,'{\"en\":\"Active\"}','{\"wu\":[],\"solr\":{\"content\":\"Active\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:12:12Z\",\"users\":{\"1\":\"479\"}}}'),(504,'{\"en\":\"Inactive\"}','{\"wu\":[],\"solr\":{\"content\":\"Inactive\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:12:19Z\",\"users\":{\"1\":\"480\"}}}'),(505,'{\"_title\":\"FoodAssessment\",\"en\":\"Food Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-food\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Food Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"FoodAssessment\\nFood Assessment\\ncaseassessment\\n1\\nicon-assessment-food\\n{\\n\\\"leaf\\\":true\\n}\\nFood Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2264\"},\"time\":\"2017-01-04T20:44:34Z\"}}'),(506,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1316\"},\"time\":\"2016-10-28T19:47:21Z\"}}'),(507,'{\"_title\":\"_enoughfood\",\"en\":\"Does client have enough food to feed all members of the household?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_enoughfood\\nDoes client have enough food to feed all members of the household?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1449\"},\"time\":\"2016-11-02T19:38:22Z\"}}'),(508,'{\"_title\":\"_predisasterassistance\",\"en\":\"Pre-Disaster, was client or any household member receiving food assistance?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 516\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_predisasterassistance\\nPre-Disaster, was client or any household member receiving food assistance?\\n_objects\\n{\\n\\\"scope\\\": 516\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1448\"},\"time\":\"2016-11-02T19:38:16Z\"}}'),(509,'{\"_title\":\"_requestedfood\",\"en\":\"Since the disaster, has client requested help with food from anyone?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_requestedfood\\nSince the disaster, has client requested help with food from anyone?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1447\"},\"time\":\"2016-11-02T19:38:01Z\"}}'),(510,'{\"_title\":\"MedicalAssessment\",\"en\":\"Behavioral Health Advocacy Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-behavioral\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Behavioral Health Advocacy Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"MedicalAssessment\\nBehavioral Health Advocacy Assessment\\ncaseassessment\\n1\\nicon-assessment-behavioral\\n{\\n\\\"leaf\\\":true\\n}\\nBehavioral Health Advocacy Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2270\"},\"time\":\"2017-01-04T20:45:42Z\"}}'),(511,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1311\"},\"time\":\"2016-10-28T19:46:20Z\"}}'),(512,'{\"_title\":\"_indistress\",\"en\":\"Is client or anyone in the household in distress?\",\"type\":\"_objects\",\"order\":2,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_indistress\\nIs client or anyone in the household in distress?\\n_objects\\n2\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1421\"},\"time\":\"2016-11-02T18:56:35Z\"}}'),(513,'{\"_title\":\"_liketospeak\",\"en\":\"Would client or anyone in the household like to speak to someone about coping with disaster-related stress?\",\"type\":\"_objects\",\"order\":3,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_liketospeak\\nWould client or anyone in the household like to speak to someone about coping with disaster-related stress?\\n_objects\\n3\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1419\"},\"time\":\"2016-11-02T18:56:15Z\"}}'),(514,'{\"_title\":\"_feelsafe\",\"en\":\"Do you feel safe at home?\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_feelsafe\\nDo you feel safe at home?\\n_objects\\n4\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1423\"},\"time\":\"2016-11-02T18:56:51Z\"}}'),(515,'{\"_title\":\"_hurtingyourselfothers\",\"en\":\"Have you felt like hurting yourself or others?\",\"type\":\"_objects\",\"order\":5,\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_hurtingyourselfothers\\nHave you felt like hurting yourself or others?\\n_objects\\n5\\n{\\n\\\"scope\\\": 346\\n}\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1422\"},\"time\":\"2016-11-02T18:56:43Z\"}}'),(516,'{\"en\":\"FoodHelp\"}','{\"wu\":[],\"solr\":{\"content\":\"FoodHelp\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:24:25Z\",\"users\":{\"1\":\"493\"}}}'),(517,'{\"en\":\"Woman Infants & Children (WIC) Benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Woman Infants & Children (WIC) Benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:24:50Z\",\"users\":{\"1\":\"494\"}}}'),(518,'{\"en\":\"Supplemental Nutrition Assistance Program (SNAP)\"}','{\"wu\":[],\"solr\":{\"content\":\"Supplemental Nutrition Assistance Program (SNAP)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:06Z\",\"users\":{\"1\":\"495\"}}}'),(519,'{\"en\":\"Assistance from local food pantries\\/food banks\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance from local food pantries\\/food banks\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:22Z\",\"users\":{\"1\":\"496\"}}}'),(520,'{\"en\":\"Meals on wheels\"}','{\"wu\":[],\"solr\":{\"content\":\"Meals on wheels\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:32Z\",\"users\":{\"1\":\"497\"}}}'),(521,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:25:41Z\",\"users\":{\"1\":\"498\"}}}'),(522,'{\"en\":\"CaseNoteType\"}','{\"wu\":[],\"solr\":{\"content\":\"CaseNoteType\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:34:42Z\",\"users\":{\"1\":\"499\"}}}'),(523,'{\"en\":\"Education\"}','{\"wu\":[],\"solr\":{\"content\":\"Education\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:34:53Z\",\"users\":{\"1\":\"500\"}}}'),(524,'{\"en\":\"Employment\"}','{\"wu\":[],\"solr\":{\"content\":\"Employment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:35:01Z\",\"users\":{\"1\":\"501\"}}}'),(525,'{\"en\":\"Skills Building\"}','{\"wu\":[],\"solr\":{\"content\":\"Skills Building\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:35:12Z\",\"users\":{\"1\":\"502\"}}}'),(526,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:35:23Z\",\"users\":{\"1\":\"503\"}}}'),(527,'{\"_title\":\"CaseNote\",\"en\":\"Case Note\",\"type\":\"object\",\"visible\":1,\"iconCls\":\"icon-committee-phase\",\"cfg\":\"{\\n    \\\"acceptChildren\\\": false\\n    ,\\\"leaf\\\":true\\n}\",\"title_template\":\"Case Note\"}','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1555\"},\"time\":\"2016-11-14T15:23:55Z\"}}'),(528,'{\"_title\":\"_entrydate\",\"en\":\"Entry Date\",\"type\":\"datetime\",\"cfg\":\"{\\n\\\"value\\\": \\\"2016-10-24\\\"\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_entrydate\\nEntry Date\\ndatetime\\n{\\n\\\"value\\\": \\\"2016-10-24\\\"\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1272\"},\"time\":\"2016-10-24T14:23:31Z\"}}'),(529,'{\"_title\":\"_regarding\",\"en\":\"Regarding\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_regarding\\nRegarding\\nvarchar\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"513\"},\"time\":\"2016-10-03T16:54:37Z\"}}'),(530,'{\"_title\":\"_regarding\",\"en\":\"Regarding\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_regarding\\nRegarding\\nvarchar\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"741\"},\"time\":\"2016-10-18T16:16:46Z\"}}'),(531,'{\"_title\":\"_notetype\",\"en\":\"Note Type\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 522,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"notetype_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_notetype\\nNote Type\\n_objects\\n{\\n\\\"scope\\\": 522,\\n\\\"faceting\\\":true\\n}\\nnotetype_i\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1694\"},\"time\":\"2016-12-07T05:23:15Z\"}}'),(532,'{\"_title\":\"_casenote\",\"en\":\"Case Note\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_casenote\\nCase Note\\ntext\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"512\"},\"time\":\"2016-10-03T16:54:20Z\"}}'),(533,'{\"_title\":\"ChildAssesment\",\"en\":\"Children and Youth Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-child\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Children and Youth Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"ChildAssesment\\nChildren and Youth Assessment\\ncaseassessment\\n1\\nicon-assessment-child\\n{\\n\\\"leaf\\\":true\\n}\\nChildren and Youth Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2259\"},\"time\":\"2017-01-04T20:35:15Z\"}}'),(534,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1312\"},\"time\":\"2016-10-28T19:46:35Z\"}}'),(535,'{\"_title\":\"_childrenunder18\",\"en\":\"Do you have children under the age of 18 in your household?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childrenunder18\\nDo you have children under the age of 18 in your household?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T16:57:02Z\",\"users\":{\"1\":\"516\"}}}'),(536,'{\"_title\":\"_fostercare\",\"en\":\"Are any of the children in the household placements from Foster Care\",\"type\":\"_objects\"}','{\"wu\":[],\"solr\":{\"content\":\"_fostercare\\nAre any of the children in the household placements from Foster Care\\n_objects\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"991\"},\"time\":\"2016-10-21T14:00:50Z\"}}'),(537,'{\"_title\":\"_fostercare\",\"en\":\"Are any of the children in the household placements from Foster Care?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_fostercare\\nAre any of the children in the household placements from Foster Care?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1653\"},\"time\":\"2016-11-14T20:53:16Z\"}}'),(538,'{\"_title\":\"_headstart\",\"en\":\"Prior to the disaster, was the client''s child in a child care or Head Start Program?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_headstart\\nPrior to the disaster, was the client''s child in a child care or Head Start Program?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1513\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(539,'{\"_title\":\"_servicesdisrupted\",\"en\":\"If yes, were the services disrupted as a result of the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_servicesdisrupted\\nIf yes, were the services disrupted as a result of the disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1496\"},\"time\":\"2016-11-04T17:17:08Z\"}}'),(540,'{\"_title\":\"_childcareneed\",\"en\":\"Does client currently have a need for child care?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childcareneed\\nDoes client currently have a need for child care?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1514\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(541,'{\"_title\":\"_priorvoucher\",\"en\":\"Prior to the disaster, did client get voucher assistance for child care?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_priorvoucher\\nPrior to the disaster, did client get voucher assistance for child care?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1504\"},\"time\":\"2016-11-04T17:23:02Z\"}}'),(542,'{\"_title\":\"_barrierstochildcare\",\"en\":\"If child care is needed but child is not getting it, what are the barriers?\",\"type\":\"varchar\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_barrierstochildcare\\nIf child care is needed but child is not getting it, what are the barriers?\\nvarchar\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1663\"},\"time\":\"2016-11-15T14:23:50Z\"}}'),(543,'{\"_title\":\"_childsupportpre\",\"en\":\"Was client receiving child support payments before the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childsupportpre\\nWas client receiving child support payments before the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1626\"},\"time\":\"2016-11-14T20:40:49Z\"}}'),(544,'{\"_title\":\"_responsibleforchildsupoprt\",\"en\":\"Is the client the individual responsible for paying support?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_responsibleforchildsupoprt\\nIs the client the individual responsible for paying support?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1426\"},\"time\":\"2016-11-02T18:57:42Z\"}}'),(545,'{\"_title\":\"_paymentsdelayed\",\"en\":\"Have payments been delayed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_paymentsdelayed\\nHave payments been delayed?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1428\"},\"time\":\"2016-11-02T18:58:03Z\"}}'),(546,'{\"_title\":\"_childsupportpost\",\"en\":\"Is the client receiving child support payments post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_childsupportpost\\nIs the client receiving child support payments post-disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1627\"},\"time\":\"2016-11-14T20:41:01Z\"}}'),(547,'{\"_title\":\"_kidsinschool\",\"en\":\"Are the client''s kids currently in school?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_kidsinschool\\nAre the client''s kids currently in school?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1515\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(548,'{\"_title\":\"_sameschoolpostdisaster\",\"en\":\"If client''s kids currently in school, are they in the same school district post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_sameschoolpostdisaster\\nIf client''s kids currently in school, are they in the same school district post-disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1500\"},\"time\":\"2016-11-04T17:18:54Z\"}}'),(549,'{\"_title\":\"_needhelpregistering\",\"en\":\"If client''s kids not currently in school, does client need help registering their children for school?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_needhelpregistering\\nIf client''s kids not currently in school, does client need help registering their children for school?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [348]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1499\"},\"time\":\"2016-11-04T17:18:44Z\"}}'),(550,'{\"_title\":\"_missedimmunizations\",\"en\":\"Since the disaster, has your child missed any scheduled check ups or immunizations?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_missedimmunizations\\nSince the disaster, has your child missed any scheduled check ups or immunizations?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1516\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(551,'{\"_title\":\"_copingconcerns\",\"en\":\"Does client have concerns about how his\\/her child is coping post-disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_copingconcerns\\nDoes client have concerns about how his\\/her child is coping post-disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1517\"},\"time\":\"2016-11-04T17:27:20Z\"}}'),(552,'{\"_title\":\"_copingexplanations\",\"en\":\"If yes, please explain in detail\",\"type\":\"text\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_copingexplanations\\nIf yes, please explain in detail\\ntext\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1493\"},\"time\":\"2016-11-04T17:15:24Z\"}}'),(553,'{\"_title\":\"ClothingAssessment\",\"en\":\"Clothing Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-clothing\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Clothing Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"ClothingAssessment\\nClothing Assessment\\ncaseassessment\\n1\\nicon-assessment-clothing\\n{\\n\\\"leaf\\\":true\\n}\\nClothing Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2260\"},\"time\":\"2017-01-04T20:36:24Z\"}}'),(554,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1313\"},\"time\":\"2016-10-28T19:46:46Z\"}}'),(555,'{\"_title\":\"_anyoneloseclothing\",\"en\":\"Did any of the household members lose clothing as a result of the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_anyoneloseclothing\\nDid any of the household members lose clothing as a result of the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1443\"},\"time\":\"2016-11-02T19:36:37Z\"}}'),(556,'{\"_title\":\"_usableclothing\",\"en\":\"Does client\\/family have useable clothing and shoes for work or school?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_usableclothing\\nDoes client\\/family have useable clothing and shoes for work or school?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1440\"},\"time\":\"2016-11-02T19:36:08Z\"}}'),(557,'{\"_title\":\"_coldweather\",\"en\":\"Does client\\/family have cold-weather clothing (e.g.,coats, hats, gloves)?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_coldweather\\nDoes client\\/family have cold-weather clothing (e.g.,coats, hats, gloves)?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1442\"},\"time\":\"2016-11-02T19:36:30Z\"}}'),(558,'{\"_title\":\"_makeclaim\",\"en\":\"Did client claim for the clothes with the insurance company?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_makeclaim\\nDid client claim for the clothes with the insurance company?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1473\"},\"time\":\"2016-11-04T13:21:45Z\"}}'),(559,'{\"_title\":\"FurnitureAndAppliancesAssessment\",\"en\":\"Furniture and Appliances Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-appliances\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Furniture and Appliances Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"FurnitureAndAppliancesAssessment\\nFurniture and Appliances Assessment\\ncaseassessment\\n1\\nicon-assessment-appliances\\n{\\n\\\"leaf\\\":true\\n}\\nFurniture and Appliances Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2265\"},\"time\":\"2017-01-04T20:44:45Z\"}}'),(560,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1317\"},\"time\":\"2016-10-28T19:47:31Z\"}}'),(561,'{\"_title\":\"_anythingdestroyed\",\"en\":\"Did client have furniture or home appliances destroyed in the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_anythingdestroyed\\nDid client have furniture or home appliances destroyed in the disaster?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1451\"},\"time\":\"2016-11-02T19:38:57Z\"}}'),(562,'{\"_title\":\"_refrigerator\",\"en\":\"Refrigerator\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_refrigerator\\nRefrigerator\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1527\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(563,'{\"_title\":\"_stove\",\"en\":\"Stove\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_stove\\nStove\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1528\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(564,'{\"_title\":\"_beds\",\"en\":\"Bed(s)\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_beds\\nBed(s)\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1529\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(565,'{\"_title\":\"_numberofbeds\",\"en\":\"If bed(s) destroyed, specify number of bed(s)\",\"type\":\"int\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_numberofbeds\\nIf bed(s) destroyed, specify number of bed(s)\\nint\\n{\\n   \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1524\"},\"time\":\"2016-11-04T17:31:30Z\"}}'),(566,'{\"_title\":\"_numberofbeds\",\"en\":\"If bed(s) destroyed, specify number of bed(s)\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_numberofbeds\\nIf bed(s) destroyed, specify number of bed(s)\\nint\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1010\"},\"time\":\"2016-10-21T14:38:10Z\"}}'),(567,'{\"_title\":\"_claimforfurniture\",\"en\":\"Did client have a claim for the furniture and appliance with your insurance?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_claimforfurniture\\nDid client have a claim for the furniture and appliance with your insurance?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1530\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(568,'{\"_title\":\"_replacementitemsreceived\",\"en\":\"Did client get replacement items from any nonprofit organizations?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_replacementitemsreceived\\nDid client get replacement items from any nonprofit organizations?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1531\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(569,'{\"_title\":\"_abletoinstall\",\"en\":\"Was client able to install replacement furniture and appliances in the home?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_abletoinstall\\nWas client able to install replacement furniture and appliances in the home?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"1532\"},\"time\":\"2016-11-04T17:32:12Z\"}}'),(570,'{\"en\":\"ReferralService\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"ReferralService\\n1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:30:29Z\",\"users\":{\"1\":\"552\"}}}'),(571,'{\"en\":\"Assistance identifying private legal counsel\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance identifying private legal counsel\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:32:25Z\",\"users\":{\"1\":\"553\"}}}'),(572,'{\"en\":\"Assistance with D-Snap application\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with D-Snap application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:32:38Z\",\"users\":{\"1\":\"554\"}}}'),(573,'{\"en\":\"Assistance with insurance claim\\/appeal\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with insurance claim\\/appeal\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:32:52Z\",\"users\":{\"1\":\"555\"}}}'),(574,'{\"en\":\"Bus Tokens\"}','{\"wu\":[],\"solr\":{\"content\":\"Bus Tokens\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:02Z\",\"users\":{\"1\":\"556\"}}}'),(575,'{\"en\":\"Counseling-Alcohol\"}','{\"wu\":[],\"solr\":{\"content\":\"Counseling-Alcohol\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:19Z\",\"users\":{\"1\":\"557\"}}}'),(576,'{\"en\":\"Emergency Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency Housing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:44Z\",\"users\":{\"1\":\"558\"}}}'),(577,'{\"en\":\"Laundry Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Laundry Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:33:58Z\",\"users\":{\"1\":\"559\"}}}'),(578,'{\"en\":\"Referral to community organizations for food needs\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to community organizations for food needs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:13Z\",\"users\":{\"1\":\"560\"}}}'),(579,'{\"en\":\"Referral to faith-based\\/community organizations for clothing\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to faith-based\\/community organizations for clothing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:29Z\",\"users\":{\"1\":\"561\"}}}'),(580,'{\"en\":\"Rental Assitance\"}','{\"wu\":[],\"solr\":{\"content\":\"Rental Assitance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:40Z\",\"users\":{\"1\":\"562\"}}}'),(581,'{\"en\":\"Social Services for WIC\\/SNAP\"}','{\"wu\":[],\"solr\":{\"content\":\"Social Services for WIC\\/SNAP\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:34:51Z\",\"users\":{\"1\":\"563\"}}}'),(582,'{\"en\":\"Assistance with accessing VA benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with accessing VA benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:36:49Z\",\"users\":{\"1\":\"564\"}}}'),(583,'{\"en\":\"Assistance with FEMA ONA\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with FEMA ONA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:00Z\",\"users\":{\"1\":\"565\"}}}'),(584,'{\"en\":\"Bus Pass\"}','{\"wu\":[],\"solr\":{\"content\":\"Bus Pass\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:07Z\",\"users\":{\"1\":\"566\"}}}'),(585,'{\"en\":\"Case Management\"}','{\"wu\":[],\"solr\":{\"content\":\"Case Management\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:16Z\",\"users\":{\"1\":\"567\"}}}'),(586,'{\"en\":\"Disaster Case Management\"}','{\"wu\":[],\"solr\":{\"content\":\"Disaster Case Management\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:30Z\",\"users\":{\"1\":\"568\"}}}'),(587,'{\"en\":\"Healthcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Healthcare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:41Z\",\"users\":{\"1\":\"569\"}}}'),(588,'{\"en\":\"Prenatal Care\"}','{\"wu\":[],\"solr\":{\"content\":\"Prenatal Care\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:37:50Z\",\"users\":{\"1\":\"570\"}}}'),(589,'{\"en\":\"Referral to faith-based\\/community organizations for replacement\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to faith-based\\/community organizations for replacement\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:38:10Z\",\"users\":{\"1\":\"571\"}}}'),(590,'{\"en\":\"Referral to mass care for immediate food needs\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to mass care for immediate food needs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:38:40Z\",\"users\":{\"1\":\"572\"}}}'),(591,'{\"en\":\"Restoration of pre-disaster Meals on Wheels services\"}','{\"wu\":[],\"solr\":{\"content\":\"Restoration of pre-disaster Meals on Wheels services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:38:54Z\",\"users\":{\"1\":\"573\"}}}'),(592,'{\"en\":\"Transportation\"}','{\"wu\":[],\"solr\":{\"content\":\"Transportation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:39:02Z\",\"users\":{\"1\":\"574\"}}}'),(593,'{\"en\":\"ReferralStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"ReferralStatus\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:39:27Z\",\"users\":{\"1\":\"575\"}}}'),(594,'{\"en\":\"Referral Made\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral Made\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"579\"},\"time\":\"2016-10-03T18:40:33Z\"}}'),(595,'{\"en\":\"Not Eligible\"}','{\"wu\":[],\"solr\":{\"content\":\"Not Eligible\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:40:08Z\",\"users\":{\"1\":\"577\"}}}'),(596,'{\"en\":\"Resources Not Available\"}','{\"wu\":[],\"solr\":{\"content\":\"Resources Not Available\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:40:20Z\",\"users\":{\"1\":\"578\"}}}'),(597,'{\"en\":\"ReferralResult\"}','{\"wu\":[],\"solr\":{\"content\":\"ReferralResult\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:02Z\",\"users\":{\"1\":\"580\"}}}'),(598,'{\"en\":\"ServiceProvided\"}','{\"wu\":[],\"solr\":{\"content\":\"ServiceProvided\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:18Z\",\"users\":{\"1\":\"581\"}}}'),(599,'{\"en\":\"Information Only\"}','{\"wu\":[],\"solr\":{\"content\":\"Information Only\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:26Z\",\"users\":{\"1\":\"582\"}}}'),(600,'{\"en\":\"Rejected\"}','{\"wu\":[],\"solr\":{\"content\":\"Rejected\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:34Z\",\"users\":{\"1\":\"583\"}}}'),(601,'{\"en\":\"No Show\"}','{\"wu\":[],\"solr\":{\"content\":\"No Show\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:41:43Z\",\"users\":{\"1\":\"584\"}}}'),(602,'{\"en\":\"UnitOfMeasure\"}','{\"wu\":[],\"solr\":{\"content\":\"UnitOfMeasure\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:48:39Z\",\"users\":{\"1\":\"585\"}}}'),(603,'{\"en\":\"Dollars\"}','{\"wu\":[],\"solr\":{\"content\":\"Dollars\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:48:57Z\",\"users\":{\"1\":\"586\"}}}'),(604,'{\"en\":\"Minutes\"}','{\"wu\":[],\"solr\":{\"content\":\"Minutes\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:49:07Z\",\"users\":{\"1\":\"587\"}}}'),(605,'{\"en\":\"Count\"}','{\"wu\":[],\"solr\":{\"content\":\"Count\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:49:14Z\",\"users\":{\"1\":\"588\"}}}'),(606,'{\"en\":\"Hours\"}','{\"wu\":[],\"solr\":{\"content\":\"Hours\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T18:49:21Z\",\"users\":{\"1\":\"589\"}}}'),(607,'{\"_title\":\"Referral\",\"en\":\"Referral\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-arrow-right-medium\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"{_referraltype} [{_referralservice}] Referral - {_referralstatus} {_result}\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral\\nReferral\\ncaseassessment\\n1\\nicon-arrow-right-medium\\n{\\n\\\"leaf\\\":true\\n}\\n{_referraltype} [{_referralservice}] Referral - {_referralstatus} {_result}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2881\"},\"time\":\"2017-01-17T18:17:49Z\"}}'),(608,'{\"_title\":\"_referraldate\",\"en\":\"Referral Date\",\"type\":\"date\",\"order\":1,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referraldate\\nReferral Date\\ndate\\n1\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2663\"},\"time\":\"2017-01-11T20:26:17Z\"}}'),(609,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":570\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"scope\\\":570\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2604\"},\"time\":\"2017-01-11T16:59:56Z\"}}'),(610,'{\"_title\":\"_provider\",\"en\":\"Refer to Provider\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_provider\\nRefer to Provider\\nvarchar\\n2\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2661\"},\"time\":\"2017-01-11T20:25:36Z\"}}'),(611,'{\"_title\":\"_provider\",\"en\":\"Refer to Provider\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_provider\\nRefer to Provider\\nvarchar\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2607\"},\"time\":\"2017-01-11T17:10:09Z\"}}'),(612,'{\"_title\":\"_streetaddress\",\"en\":\"Street Address\",\"type\":\"varchar\",\"order\":3,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_streetaddress\\nStreet Address\\nvarchar\\n3\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2667\"},\"time\":\"2017-01-11T20:27:01Z\"}}'),(613,'{\"_title\":\"_zipcode\",\"en\":\"Zip Code\",\"type\":\"int\",\"order\":6,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_zipcode\\nZip Code\\nint\\n6\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2668\"},\"time\":\"2017-01-11T20:27:10Z\"}}'),(614,'{\"_title\":\"_city\",\"en\":\"City\",\"type\":\"varchar\",\"order\":4,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_city\\nCity\\nvarchar\\n4\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2660\"},\"time\":\"2017-01-11T20:25:28Z\"}}'),(615,'{\"_title\":\"_state\",\"en\":\"State\",\"type\":\"varchar\",\"order\":5,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_state\\nState\\nvarchar\\n5\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2665\"},\"time\":\"2017-01-11T20:26:40Z\"}}'),(616,'{\"_title\":\"_geocode\",\"en\":\"Geopoint\",\"type\":\"geoPoint\"}','{\"wu\":[],\"solr\":{\"content\":\"_geocode\\nGeopoint\\ngeoPoint\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2627\"},\"time\":\"2017-01-11T19:18:25Z\"}}'),(617,'{\"_title\":\"_referralstatus\",\"en\":\"Status\",\"type\":\"_objects\",\"order\":2,\"cfg\":\"{\\n\\\"scope\\\":593,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralstatus\\nStatus\\n_objects\\n2\\n{\\n\\\"scope\\\":593,\\n\\\"required\\\":true\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2623\"},\"time\":\"2017-01-11T19:17:18Z\"}}'),(618,'{\"_title\":\"_comments\",\"en\":\"Comments\",\"type\":\"text\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"_comments\\nComments\\ntext\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2657\"},\"time\":\"2017-01-11T20:24:02Z\"}}'),(619,'{\"_title\":\"_associatedneed\",\"en\":\"Associated Need\\/Barrier\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_associatedneed\\nAssociated Need\\/Barrier\\nvarchar\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2628\"},\"time\":\"2017-01-11T19:18:37Z\"}}'),(620,'{\"_title\":\"_voucherinformation\",\"en\":\"Voucher Information - Please complete the following information if your organization has authorized a voucher for this service\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_voucherinformation\\nVoucher Information - Please complete the following information if your organization has authorized a voucher for this service\\nH\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2636\"},\"time\":\"2017-01-11T19:20:55Z\"}}'),(621,'{\"_title\":\"_vouchernumber\",\"en\":\"Voucher Number\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_vouchernumber\\nVoucher Number\\nint\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2637\"},\"time\":\"2017-01-11T19:20:55Z\"}}'),(622,'{\"_title\":\"_voucheruom\",\"en\":\"Units of Measure\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":602\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_voucheruom\\nUnits of Measure\\n_objects\\n{\\n\\\"scope\\\":602\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2635\"},\"time\":\"2017-01-11T19:20:55Z\"}}'),(623,'{\"_title\":\"_voucherunits\",\"en\":\"Units\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_voucherunits\\nUnits\\nint\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2639\"},\"time\":\"2017-01-11T19:20:55Z\"}}'),(624,'{\"_title\":\"_unitvalue\",\"en\":\"Unit Value ($)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_unitvalue\\nUnit Value ($)\\nfloat\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2640\"},\"time\":\"2017-01-11T19:21:16Z\"}}'),(625,'{\"_title\":\"_vouchertotal\",\"en\":\"Total($)\",\"type\":\"float\"}','{\"wu\":[],\"solr\":{\"content\":\"_vouchertotal\\nTotal($)\\nfloat\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2638\"},\"time\":\"2017-01-11T19:20:55Z\"}}'),(626,'{\"_title\":\"_informationrelease\",\"en\":\"Information release - if the client has authorized that his\\/her information can be released to the provider, please indicate this below.  Doing so will cause an email to be automatically generated and sent to this provider with information regarding the referral\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_informationrelease\\nInformation release - if the client has authorized that his\\/her information can be released to the provider, please indicate this below.  Doing so will cause an email to be automatically generated and sent to this provider with information regarding the referral\\nH\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2629\"},\"time\":\"2017-01-11T19:18:58Z\"}}'),(627,'{\"_title\":\"_emailauthorized\",\"en\":\"Email Authorized\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_emailauthorized\\nEmail Authorized\\nvarchar\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2630\"},\"time\":\"2017-01-11T19:19:03Z\"}}'),(628,'{\"_title\":\"_referraloutcome\",\"en\":\"Referral Outcome - Enter the date acknowledged by the referral recipient, appointment date and time, result date, and result.\",\"type\":\"H\"}','{\"wu\":[],\"solr\":{\"content\":\"_referraloutcome\\nReferral Outcome - Enter the date acknowledged by the referral recipient, appointment date and time, result date, and result.\\nH\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2631\"},\"time\":\"2017-01-11T19:19:25Z\"}}'),(629,'{\"_title\":\"_dateacknowledged\",\"en\":\"Date Acknowledged\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_dateacknowledged\\nDate Acknowledged\\ndate\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2653\"},\"time\":\"2017-01-11T19:31:01Z\"}}'),(630,'{\"_title\":\"_appointmentdate\",\"en\":\"Appointment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_appointmentdate\\nAppointment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2658\"},\"time\":\"2017-01-11T20:24:15Z\"}}'),(631,'{\"_title\":\"_appointmentdate\",\"en\":\"Appointment Date\\/Time\",\"type\":\"datetime\",\"order\":7,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_appointmentdate\\nAppointment Date\\/Time\\ndatetime\\n7\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2662\"},\"time\":\"2017-01-11T20:25:54Z\"}}'),(632,'{\"_title\":\"_resultdate\",\"en\":\"Result Date\",\"type\":\"date\",\"order\":7,\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_resultdate\\nResult Date\\ndate\\n7\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2664\"},\"time\":\"2017-01-11T20:26:30Z\"}}'),(633,'{\"_title\":\"_result\",\"en\":\"Result\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n\\\"scope\\\":597\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_result\\nResult\\n_objects\\n7\\n{\\n\\\"scope\\\":597\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [594]\\n}\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2655\"},\"time\":\"2017-01-11T20:17:09Z\"}}'),(634,'{\"_title\":\"_fematier\",\"en\":\"FEMA Tier\",\"type\":\"_objects\",\"order\":15,\"cfg\":\"{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\":137,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"fema_tier_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_fematier\\nFEMA Tier\\n_objects\\n15\\n{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\":137,\\n\\\"faceting\\\":true\\n}\\nfema_tier_i\\n\",\"order\":15},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1672\"},\"time\":\"2016-12-06T17:08:47Z\"}}'),(635,'{\"en\":\"Tier 1: Immediate Needs Met\"}','{\"wu\":[],\"solr\":{\"content\":\"Tier 1: Immediate Needs Met\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-03T19:18:21Z\",\"users\":{\"1\":\"628\"}}}'),(636,'{\"en\":\"Tier 2: Some Remaining Unmet Needs or in Current Rebuild\\/Repair Status\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Tier 2: Some Remaining Unmet Needs or in Current Rebuild\\/Repair Status\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"630\"},\"time\":\"2016-10-03T19:18:53Z\"}}'),(642,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1763\"},\"time\":\"2016-12-08T17:48:12Z\"}}'),(643,'{\"_title\":\"_clientstatus\",\"en\":\"Client Status\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\": 644,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"client_status_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientstatus\\nClient Status\\n_objects\\n{\\n\\\"source\\\":\\\"tree\\\",\\n\\\"scope\\\": 644,\\n\\\"faceting\\\":true\\n}\\nclient_status_i\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1671\"},\"time\":\"2016-12-06T17:08:43Z\"}}'),(644,'{\"en\":\"ClientStatus\"}','{\"wu\":[],\"solr\":{\"content\":\"ClientStatus\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1670\"},\"time\":\"2016-12-06T17:07:20Z\"}}'),(645,'{\"en\":\"Open\"}','{\"wu\":[],\"solr\":{\"content\":\"Open\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-04T02:13:28Z\",\"users\":{\"1\":\"656\"}}}'),(646,'{\"en\":\"Closed\"}','{\"wu\":[],\"solr\":{\"content\":\"Closed\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-04T02:13:33Z\",\"users\":{\"1\":\"657\"}}}'),(651,'{\"_title\":\"SeniorServicesAssessment\",\"en\":\"Senior Services Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-senior-services\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Senior Services Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"SeniorServicesAssessment\\nSenior Services Assessment\\ncaseassessment\\n1\\nicon-assessment-senior-services\\n{\\n\\\"leaf\\\":true\\n}\\nSenior Services Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2271\"},\"time\":\"2017-01-04T20:45:55Z\"}}'),(652,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1321\"},\"time\":\"2016-10-28T19:48:18Z\"}}'),(653,'{\"_title\":\"_priorseniorliving\",\"en\":\"Prior to the disaster, was anyone in the household living in senior housing, assisted living, or in a nursing home?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_priorseniorliving\\nPrior to the disaster, was anyone in the household living in senior housing, assisted living, or in a nursing home?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1459\"},\"time\":\"2016-11-02T19:41:54Z\"}}'),(654,'{\"_title\":\"_clientdisplaced\",\"en\":\"If yes, was the client displaced following the disaster?\",\"type\":\"_objects\",\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientdisplaced\\nIf yes, was the client displaced following the disaster?\\n_objects\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1477\"},\"time\":\"2016-11-04T13:26:19Z\"}}'),(655,'{\"_title\":\"_explaincircumstances\",\"en\":\"If yes, please explain the circumstances\",\"type\":\"varchar\",\"cfg\":\"{\\n   \\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_explaincircumstances\\nIf yes, please explain the circumstances\\nvarchar\\n{\\n   \\\"dependency\\\": {\\n\\t\\\"pidValues\\\": [347]\\n   }\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1478\"},\"time\":\"2016-11-04T13:26:37Z\"}}'),(656,'{\"_title\":\"LanguageAssessment\",\"en\":\"Language Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-assessment-language\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Language Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"LanguageAssessment\\nLanguage Assessment\\ncaseassessment\\n1\\nicon-assessment-language\\n{\\n\\\"leaf\\\":true\\n}\\nLanguage Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2268\"},\"time\":\"2017-01-04T20:45:19Z\"}}'),(657,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1319\"},\"time\":\"2016-10-28T19:48:00Z\"}}'),(658,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"683\"},\"time\":\"2016-10-09T00:13:04Z\"}}'),(659,'{\"_title\":\"_priorlanguage\",\"en\":\"Pre-Disaster, was client receiving language services?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_priorlanguage\\nPre-Disaster, was client receiving language services?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"684\"},\"time\":\"2016-10-09T00:13:22Z\"}}'),(660,'{\"_title\":\"_currentlyhavinglanguage\",\"en\":\"Is client currently having difficulty accessing services due to language concerns?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_currentlyhavinglanguage\\nIs client currently having difficulty accessing services due to language concerns?\\n_objects\\n{\\n\\\"scope\\\": 346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1458\"},\"time\":\"2016-11-02T19:41:16Z\"}}'),(661,'{\"_title\":\"_lostlanguageservices\",\"en\":\"As a result of the disaster, client lost language services?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_lostlanguageservices\\nAs a result of the disaster, client lost language services?\\n_objects\\n{\\n\\\"scope\\\":346\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1457\"},\"time\":\"2016-11-02T19:40:55Z\"}}'),(663,'{\"_title\":\"dc_cases_fema\",\"value\":\"{\\n\\\"nid\\\":[]\\n,\\\"name\\\":[]\\n,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"fema_tier_i\\\"}\\n,\\\"order\\\":{\\n\\\"solr_column_name\\\":\\\"task_order\\\"\\n,\\\"sortType\\\":\\\"asInt\\\"\\n,\\\"align\\\":\\\"center\\\"\\n,\\\"columnWidth\\\":\\\"10\\\"\\n}\\n,\\\"time_estimated\\\":{\\n\\\"width\\\":\\\"20px\\\"\\n,\\\"format\\\":\\\"H:i\\\"\\n}\\n,\\\"phase\\\": {\\n\\\"solr_column_name\\\": \\\"task_phase\\\"\\n}\\n,\\\"project\\\": {\\n\\\"solr_column_name\\\": \\\"task_projects\\\"\\n}\\n,\\\"cid\\\":[]\\n,\\\"assigned\\\":[]\\n,\\\"comment_user_id\\\":[]\\n,\\\"comment_date\\\":[]\\n,\\\"cdate\\\":[]\\n}\\n\\n\"}','{\"wu\":[],\"solr\":{\"content\":\"dc_cases_fema\\n{\\n\\\"nid\\\":[]\\n,\\\"name\\\":[]\\n,\\\"importance\\\":{\\\"solr_column_name\\\":\\\"fema_tier_i\\\"}\\n,\\\"order\\\":{\\n\\\"solr_column_name\\\":\\\"task_order\\\"\\n,\\\"sortType\\\":\\\"asInt\\\"\\n,\\\"align\\\":\\\"center\\\"\\n,\\\"columnWidth\\\":\\\"10\\\"\\n}\\n,\\\"time_estimated\\\":{\\n\\\"width\\\":\\\"20px\\\"\\n,\\\"format\\\":\\\"H:i\\\"\\n}\\n,\\\"phase\\\": {\\n\\\"solr_column_name\\\": \\\"task_phase\\\"\\n}\\n,\\\"project\\\": {\\n\\\"solr_column_name\\\": \\\"task_projects\\\"\\n}\\n,\\\"cid\\\":[]\\n,\\\"assigned\\\":[]\\n,\\\"comment_user_id\\\":[]\\n,\\\"comment_date\\\":[]\\n,\\\"cdate\\\":[]\\n}\\n\\n\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-09T21:01:34Z\",\"users\":{\"1\":\"688\"}}}'),(666,'{\"_title\":\"FEMA Tier 1\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Tier 1\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1756\"},\"time\":\"2016-12-08T17:47:44Z\"}}'),(667,'{\"_title\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"Test\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1765\"},\"time\":\"2016-12-08T17:48:20Z\"}}'),(668,'{\"_title\":\"Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Services\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"997\"},\"time\":\"2016-10-21T14:17:09Z\"}}'),(669,'{\"_title\":\"Service\",\"en\":\"Service\",\"type\":\"object\",\"iconCls\":\"icon-case_card\",\"cfg\":\"{\\n\\\"leaf\\\":false\\n}\",\"title_template\":\"{_name}\"}','{\"wu\":[],\"solr\":{\"content\":\"Service\\nService\\nobject\\nicon-case_card\\n{\\n\\\"leaf\\\":false\\n}\\n{_name}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2387\"},\"time\":\"2017-01-10T20:48:57Z\"}}'),(670,'{\"_title\":\"_name\",\"en\":\"Name\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_name\\nName\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-14T03:59:37Z\",\"users\":{\"1\":\"711\"}}}'),(671,'{\"_title\":\"_address\",\"en\":\"Address\",\"type\":\"varchar\"}','{\"wu\":[],\"solr\":{\"content\":\"_address\\nAddress\\nvarchar\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-14T03:59:53Z\",\"users\":{\"1\":\"712\"}}}'),(672,'{\"_title\":\"_notes\",\"en\":\"Notes\",\"type\":\"text\"}','{\"wu\":[],\"solr\":{\"content\":\"_notes\\nNotes\\ntext\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-14T04:00:19Z\",\"users\":{\"1\":\"713\"}}}'),(674,'{\"_title\":\"Backup\"}','{\"wu\":[],\"solr\":{\"content\":\"Backup\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1753\"},\"time\":\"2016-12-08T17:47:34Z\"}}'),(678,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"768\"},\"time\":\"2016-10-18T17:49:28Z\"}}'),(679,'{\"_title\":\"Test2\"}','{\"wu\":[],\"solr\":{\"content\":\"Test2\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"767\"},\"time\":\"2016-10-18T17:49:26Z\"}}'),(680,'{\"_title\":\"Sup\"}','{\"wu\":[],\"solr\":{\"content\":\"Sup\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"6\":\"1196\"},\"time\":\"2016-10-21T16:23:15Z\"}}'),(683,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2583\"},\"time\":\"2017-01-11T16:16:10Z\"}}'),(684,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1359\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1359\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2584\"},\"time\":\"2017-01-11T16:16:28Z\"}}'),(685,'{\"en\":\"YesNo\",\"visible\":\"Generic-1\"}','{\"wu\":[],\"solr\":{\"content\":\"YesNo\\nGeneric-1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-18T13:46:08Z\",\"users\":{\"1\":\"733\"}}}'),(686,'{\"en\":\"Yes\"}','{\"wu\":[],\"solr\":{\"content\":\"Yes\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-18T13:46:22Z\",\"users\":{\"1\":\"734\"}}}'),(687,'{\"en\":\"No\"}','{\"wu\":[],\"solr\":{\"content\":\"No\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-10-18T13:46:29Z\",\"users\":{\"1\":\"735\"}}}'),(703,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"757\"},\"time\":\"2016-10-18T16:42:52Z\"}}'),(704,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1761\"},\"time\":\"2016-12-08T17:48:03Z\"}}'),(708,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"521728\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"770\"},\"time\":\"2016-10-18T17:54:33Z\"}}'),(718,'{\"_title\":\"_name\",\"en\":\"Name\",\"type\":\"varchar\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"_name\\nName\\nvarchar\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2626\"},\"time\":\"2017-01-11T19:18:04Z\"}}'),(722,'{\"_title\":\"_latlon\",\"en\":\"Latitude\\/Longitude\",\"type\":\"geoPoint\",\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"latlon_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_latlon\\nLatitude\\/Longitude\\ngeoPoint\\n{\\n\\\"faceting\\\":true\\n}\\nlatlon_s\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2026\"},\"time\":\"2016-12-13T21:46:29Z\"}}'),(845,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n6\\n{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\\n\",\"order\":6},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2587\"},\"time\":\"2017-01-11T16:17:03Z\"}}'),(846,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1371\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n7\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1371\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2586\"},\"time\":\"2017-01-11T16:16:44Z\"}}'),(847,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2581\"},\"time\":\"2017-01-11T16:15:54Z\"}}'),(848,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2578\"},\"time\":\"2017-01-11T16:15:19Z\"}}'),(849,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1180\"},\"time\":\"2016-10-21T16:09:08Z\"}}'),(850,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2545\"},\"time\":\"2017-01-11T15:59:04Z\"}}'),(851,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2548\"},\"time\":\"2017-01-11T16:01:43Z\"}}'),(852,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1144\"},\"time\":\"2016-10-21T15:46:57Z\"}}'),(853,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2570\"},\"time\":\"2017-01-11T16:12:30Z\"}}'),(854,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2565\"},\"time\":\"2017-01-11T16:10:02Z\"}}'),(855,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1185\"},\"time\":\"2016-10-21T16:11:06Z\"}}'),(856,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2563\"},\"time\":\"2017-01-11T16:09:41Z\"}}'),(857,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2561\"},\"time\":\"2017-01-11T16:09:21Z\"}}'),(858,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1397\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1397\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2580\"},\"time\":\"2017-01-11T16:15:36Z\"}}'),(859,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1396\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1396\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2577\"},\"time\":\"2017-01-11T16:15:08Z\"}}'),(860,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1181\"},\"time\":\"2016-10-21T16:09:19Z\"}}'),(861,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1398\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1398\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2544\"},\"time\":\"2017-01-11T15:58:47Z\"}}'),(862,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1429\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2547\"},\"time\":\"2017-01-11T16:01:30Z\"}}'),(863,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": false\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1361\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": false\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1361\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2569\"},\"time\":\"2017-01-11T16:12:17Z\"}}'),(864,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1400\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1400\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2564\"},\"time\":\"2017-01-11T16:09:54Z\"}}'),(865,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":668\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1186\"},\"time\":\"2016-10-21T16:11:22Z\"}}'),(866,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1403\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1403\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2562\"},\"time\":\"2017-01-11T16:09:33Z\"}}'),(867,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1392\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1392\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2560\"},\"time\":\"2017-01-11T16:09:08Z\"}}'),(870,'{\"_title\":\"TestReferral\",\"en\":\"TestReferral\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":685\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"TestReferral\\nTestReferral\\n_objects\\n{\\n\\\"scope\\\":685\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1140\"},\"time\":\"2016-10-21T15:45:54Z\"}}'),(897,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"10\":\"1286\"},\"time\":\"2016-10-24T15:11:36Z\"}}'),(938,'{\"en\":\"Yes\",\"visible\":\"Generic-1\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Yes\\nGeneric-1\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:07Z\",\"users\":{\"1\":\"1467\"}}}'),(939,'{\"en\":\"No\",\"visible\":\"Generic-2\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"No\\nGeneric-2\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:18Z\",\"users\":{\"1\":\"1468\"}}}'),(940,'{\"en\":\"Don''t know\",\"visible\":\"Generic-3\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Don''t know\\nGeneric-3\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:42Z\",\"users\":{\"1\":\"1469\"}}}'),(941,'{\"en\":\"Refused\",\"visible\":\"Generic-4\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Refused\\nGeneric-4\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-04T13:18:56Z\",\"users\":{\"1\":\"1470\"}}}'),(952,'{\"_title\":\"System folders\"}','{\"wu\":[],\"solr\":{\"content\":\"System folders\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1572\"},\"time\":\"2016-11-14T15:30:00Z\"}}'),(953,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T15:30:26Z\",\"users\":{\"1\":\"1573\"}}}'),(954,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1576\"},\"time\":\"2016-11-14T15:31:08Z\"}}'),(955,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T15:30:59Z\",\"users\":{\"1\":\"1575\"}}}'),(962,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1590\"},\"time\":\"2016-11-14T17:55:07Z\"}}'),(963,'{\"_title\":\"AssessmentMenu\",\"template_ids\":\"972\",\"menu\":\"510,533,553,482,455,505,559,489,440,656,467,651,172\"}','{\"wu\":[],\"solr\":{\"content\":\"AssessmentMenu\\n972\\n510,533,553,482,455,505,559,489,440,656,467,651,172\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1613\"},\"time\":\"2016-11-14T20:18:41Z\"}}'),(970,'{\"_title\":\"AssessmentsTest\",\"en\":\"Test\",\"type\":\"object\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"AssessmentsTest\\nTest\\nobject\\n1\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"1752\"},\"time\":\"2016-12-08T17:47:23Z\"}}'),(972,'{\"_title\":\"Assessments\",\"en\":\"Assessments\",\"type\":\"object\",\"visible\":1,\"title_template\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\nAssessments\\nobject\\n1\\nAssessments\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2025\"},\"time\":\"2016-12-13T21:45:39Z\"}}'),(973,'{\"_title\":\"Assessment Start\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessment Start\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:15:12Z\",\"users\":{\"1\":\"1609\"}}}'),(976,'{\"_title\":\"ClientIntake\",\"en\":\"Client Intake\",\"type\":\"object\",\"visible\":\"Generic-1\",\"title_template\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"ClientIntake\\nClient Intake\\nobject\\nGeneric-1\\nClient Intake\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2024\"},\"time\":\"2016-12-13T21:45:32Z\"}}'),(977,'{\"_title\":\"_startdate\",\"en\":\"Start Date\",\"type\":\"datetime\"}','{\"wu\":[],\"solr\":{\"content\":\"_startdate\\nStart Date\\ndatetime\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:29:21Z\",\"users\":{\"1\":\"1617\"}}}'),(978,'{\"_title\":\"ClientIntakeMenu\",\"template_ids\":\"976\",\"menu\":\"311,489,289\"}','{\"wu\":[],\"solr\":{\"content\":\"ClientIntakeMenu\\n976\\n311,489,289\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-11-14T20:33:05Z\",\"users\":{\"1\":\"1618\"}}}'),(1026,'{\"_firstname\":\"Test\",\"_lastname\":\"persons\",\"_middlename\":\"Test\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"persons\\nTest\\nTest\\n\",\"lastname_s\":\"persons\",\"firstname_s\":\"Test\",\"middlename_s\":\"Test\",\"task_status\":2,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2115\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1027,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1767\"},\"time\":\"2016-12-08T21:29:34Z\"}}'),(1028,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1768\"},\"time\":\"2016-12-08T21:29:34Z\"}}'),(1029,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1769\"},\"time\":\"2016-12-08T21:29:34Z\"}}'),(1030,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1770\"},\"time\":\"2016-12-08T21:29:34Z\"}}'),(1031,'{\"_firstname\":\"Test\",\"_lastname\":\"Person2\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[21],\"solr\":{\"content\":\"Person2\\nTest\\n\",\"lastname_s\":\"Person2\",\"firstname_s\":\"Test\",\"task_status\":2,\"task_u_all\":[\"21\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2116\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1032,'{\"_title\":\"_street\",\"en\":\"Street\",\"type\":\"varchar\",\"order\":13,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"street_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_street\\nStreet\\nvarchar\\n13\\n{\\n\\\"faceting\\\":true\\n}\\nstreet_s\\n\",\"order\":13},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1817\"},\"time\":\"2016-12-13T14:25:30Z\"}}'),(1033,'{\"_title\":\"_maritalstatus\",\"en\":\"Marital Status\",\"type\":\"_objects\",\"order\":7,\"cfg\":\"{\\n\\\"scope\\\": 1035,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"maritalstatus_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_maritalstatus\\nMarital Status\\n_objects\\n7\\n{\\n\\\"scope\\\": 1035,\\n\\\"faceting\\\":true\\n}\\nmaritalstatus_i\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1804\"},\"time\":\"2016-12-13T14:09:35Z\"}}'),(1034,'{\"_title\":\"_headofhousehold\",\"en\":\"Head of Household?\",\"type\":\"_objects\",\"order\":17,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"headofhousehold_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_headofhousehold\\nHead of Household?\\n_objects\\n17\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\nheadofhousehold_i\\n\",\"order\":17},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2734\"},\"time\":\"2017-01-12T02:53:14Z\"}}'),(1035,'{\"en\":\"MaritalStatus\",\"visible\":\"Generic-1\"}','{\"wu\":[],\"solr\":{\"content\":\"MaritalStatus\\nGeneric-1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-12T14:02:20Z\",\"users\":{\"1\":\"1796\"}}}'),(1036,'{\"en\":\"Married\",\"visible\":\"Generic-2\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Married\\nGeneric-2\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-12T14:02:37Z\",\"users\":{\"1\":\"1797\"}}}'),(1037,'{\"en\":\"Single\",\"visible\":\"Generic-3\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Single\\nGeneric-3\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-12T14:02:50Z\",\"users\":{\"1\":\"1798\"}}}'),(1038,'{\"_title\":\"_addresstitle\",\"en\":\"Address\",\"type\":\"H\",\"order\":12}','{\"wu\":[],\"solr\":{\"content\":\"_addresstitle\\nAddress\\nH\\n12\\n\",\"order\":12},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1815\"},\"time\":\"2016-12-13T14:15:00Z\"}}'),(1039,'{\"_title\":\"_city\",\"en\":\"CIty\",\"type\":\"varchar\",\"order\":14,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"city_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_city\\nCIty\\nvarchar\\n14\\n{\\n\\\"faceting\\\":true\\n}\\ncity_s\\n\",\"order\":14},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1819\"},\"time\":\"2016-12-13T14:26:32Z\"}}'),(1040,'{\"_title\":\"_state\",\"en\":\"State\",\"type\":\"varchar\",\"order\":15,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"state_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_state\\nState\\nvarchar\\n15\\n{\\n\\\"faceting\\\":true\\n}\\nstate_s\\n\",\"order\":15},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1881\"},\"time\":\"2016-12-13T15:08:12Z\"}}'),(1041,'{\"en\":\"State\",\"visible\":\"Generic-1\"}','{\"wu\":[],\"solr\":{\"content\":\"State\\nGeneric-1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:34:02Z\",\"users\":{\"1\":\"1821\"}}}'),(1042,'{\"en\":\"AL\"}','{\"wu\":[],\"solr\":{\"content\":\"AL\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:37:57Z\",\"users\":{\"1\":\"1822\"}}}'),(1043,'{\"en\":\"AK\"}','{\"wu\":[],\"solr\":{\"content\":\"AK\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:09Z\",\"users\":{\"1\":\"1823\"}}}'),(1044,'{\"en\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1876\"},\"time\":\"2016-12-13T14:46:10Z\"}}'),(1045,'{\"en\":\"AZ\"}','{\"wu\":[],\"solr\":{\"content\":\"AZ\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:23Z\",\"users\":{\"1\":\"1825\"}}}'),(1046,'{\"en\":\"AR\"}','{\"wu\":[],\"solr\":{\"content\":\"AR\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:29Z\",\"users\":{\"1\":\"1826\"}}}'),(1047,'{\"en\":\"CA\"}','{\"wu\":[],\"solr\":{\"content\":\"CA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:34Z\",\"users\":{\"1\":\"1827\"}}}'),(1048,'{\"en\":\"CO\"}','{\"wu\":[],\"solr\":{\"content\":\"CO\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:41Z\",\"users\":{\"1\":\"1828\"}}}'),(1049,'{\"en\":\"CT\"}','{\"wu\":[],\"solr\":{\"content\":\"CT\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:47Z\",\"users\":{\"1\":\"1829\"}}}'),(1050,'{\"en\":\"DE\"}','{\"wu\":[],\"solr\":{\"content\":\"DE\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:38:54Z\",\"users\":{\"1\":\"1830\"}}}'),(1051,'{\"en\":\"FL\"}','{\"wu\":[],\"solr\":{\"content\":\"FL\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:00Z\",\"users\":{\"1\":\"1831\"}}}'),(1052,'{\"en\":\"GA\"}','{\"wu\":[],\"solr\":{\"content\":\"GA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:05Z\",\"users\":{\"1\":\"1832\"}}}'),(1053,'{\"en\":\"HI\"}','{\"wu\":[],\"solr\":{\"content\":\"HI\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:11Z\",\"users\":{\"1\":\"1833\"}}}'),(1054,'{\"en\":\"ID\"}','{\"wu\":[],\"solr\":{\"content\":\"ID\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:17Z\",\"users\":{\"1\":\"1834\"}}}'),(1055,'{\"en\":\"IL\"}','{\"wu\":[],\"solr\":{\"content\":\"IL\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:23Z\",\"users\":{\"1\":\"1835\"}}}'),(1056,'{\"en\":\"IN\"}','{\"wu\":[],\"solr\":{\"content\":\"IN\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:30Z\",\"users\":{\"1\":\"1836\"}}}'),(1057,'{\"en\":\"KY\"}','{\"wu\":[],\"solr\":{\"content\":\"KY\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1841\"},\"time\":\"2016-12-13T14:40:32Z\"}}'),(1058,'{\"en\":\"LA\"}','{\"wu\":[],\"solr\":{\"content\":\"LA\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1842\"},\"time\":\"2016-12-13T14:40:41Z\"}}'),(1059,'{\"en\":\"IA\"}','{\"wu\":[],\"solr\":{\"content\":\"IA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:39:53Z\",\"users\":{\"1\":\"1839\"}}}'),(1060,'{\"en\":\"KS\"}','{\"wu\":[],\"solr\":{\"content\":\"KS\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:40:00Z\",\"users\":{\"1\":\"1840\"}}}'),(1061,'{\"en\":\"ME\"}','{\"wu\":[],\"solr\":{\"content\":\"ME\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:41:27Z\",\"users\":{\"1\":\"1843\"}}}'),(1062,'{\"en\":\"MD\"}','{\"wu\":[],\"solr\":{\"content\":\"MD\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:41:32Z\",\"users\":{\"1\":\"1844\"}}}'),(1063,'{\"en\":\"MA\"}','{\"wu\":[],\"solr\":{\"content\":\"MA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:41:38Z\",\"users\":{\"1\":\"1845\"}}}'),(1064,'{\"en\":\"MN\"}','{\"wu\":[],\"solr\":{\"content\":\"MN\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:41:48Z\",\"users\":{\"1\":\"1846\"}}}'),(1065,'{\"en\":\"MI\"}','{\"wu\":[],\"solr\":{\"content\":\"MI\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:42:06Z\",\"users\":{\"1\":\"1847\"}}}'),(1066,'{\"en\":\"MS\"}','{\"wu\":[],\"solr\":{\"content\":\"MS\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:42:15Z\",\"users\":{\"1\":\"1848\"}}}'),(1067,'{\"en\":\"MO\"}','{\"wu\":[],\"solr\":{\"content\":\"MO\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:42:22Z\",\"users\":{\"1\":\"1849\"}}}'),(1068,'{\"en\":\"MT\"}','{\"wu\":[],\"solr\":{\"content\":\"MT\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:42:33Z\",\"users\":{\"1\":\"1850\"}}}'),(1069,'{\"en\":\"NE\"}','{\"wu\":[],\"solr\":{\"content\":\"NE\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:42:41Z\",\"users\":{\"1\":\"1851\"}}}'),(1070,'{\"en\":\"NV\"}','{\"wu\":[],\"solr\":{\"content\":\"NV\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:42:47Z\",\"users\":{\"1\":\"1852\"}}}'),(1071,'{\"en\":\"NH\"}','{\"wu\":[],\"solr\":{\"content\":\"NH\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1854\"},\"time\":\"2016-12-13T14:43:08Z\"}}'),(1072,'{\"en\":\"NJ\"}','{\"wu\":[],\"solr\":{\"content\":\"NJ\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:20Z\",\"users\":{\"1\":\"1855\"}}}'),(1073,'{\"en\":\"NM\"}','{\"wu\":[],\"solr\":{\"content\":\"NM\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:27Z\",\"users\":{\"1\":\"1856\"}}}'),(1074,'{\"en\":\"NY\"}','{\"wu\":[],\"solr\":{\"content\":\"NY\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:32Z\",\"users\":{\"1\":\"1857\"}}}'),(1075,'{\"en\":\"NC\"}','{\"wu\":[],\"solr\":{\"content\":\"NC\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:37Z\",\"users\":{\"1\":\"1858\"}}}'),(1076,'{\"en\":\"ND\"}','{\"wu\":[],\"solr\":{\"content\":\"ND\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:42Z\",\"users\":{\"1\":\"1859\"}}}'),(1077,'{\"en\":\"OH\"}','{\"wu\":[],\"solr\":{\"content\":\"OH\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:52Z\",\"users\":{\"1\":\"1860\"}}}'),(1078,'{\"en\":\"OK\"}','{\"wu\":[],\"solr\":{\"content\":\"OK\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:43:59Z\",\"users\":{\"1\":\"1861\"}}}'),(1079,'{\"en\":\"OR\"}','{\"wu\":[],\"solr\":{\"content\":\"OR\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:07Z\",\"users\":{\"1\":\"1862\"}}}'),(1080,'{\"en\":\"PA\"}','{\"wu\":[],\"solr\":{\"content\":\"PA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:11Z\",\"users\":{\"1\":\"1863\"}}}'),(1081,'{\"en\":\"RI\"}','{\"wu\":[],\"solr\":{\"content\":\"RI\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:17Z\",\"users\":{\"1\":\"1864\"}}}'),(1082,'{\"en\":\"SC\"}','{\"wu\":[],\"solr\":{\"content\":\"SC\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:24Z\",\"users\":{\"1\":\"1865\"}}}'),(1083,'{\"en\":\"SD\"}','{\"wu\":[],\"solr\":{\"content\":\"SD\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:30Z\",\"users\":{\"1\":\"1866\"}}}'),(1084,'{\"en\":\"TN\"}','{\"wu\":[],\"solr\":{\"content\":\"TN\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:34Z\",\"users\":{\"1\":\"1867\"}}}'),(1085,'{\"en\":\"TX\"}','{\"wu\":[],\"solr\":{\"content\":\"TX\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:45Z\",\"users\":{\"1\":\"1868\"}}}'),(1086,'{\"en\":\"UT\"}','{\"wu\":[],\"solr\":{\"content\":\"UT\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:44:53Z\",\"users\":{\"1\":\"1869\"}}}'),(1087,'{\"en\":\"VT\"}','{\"wu\":[],\"solr\":{\"content\":\"VT\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:45:04Z\",\"users\":{\"1\":\"1870\"}}}'),(1088,'{\"en\":\"VA\"}','{\"wu\":[],\"solr\":{\"content\":\"VA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:45:09Z\",\"users\":{\"1\":\"1871\"}}}'),(1089,'{\"en\":\"WA\"}','{\"wu\":[],\"solr\":{\"content\":\"WA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:45:15Z\",\"users\":{\"1\":\"1872\"}}}'),(1090,'{\"en\":\"WV\"}','{\"wu\":[],\"solr\":{\"content\":\"WV\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:45:20Z\",\"users\":{\"1\":\"1873\"}}}'),(1091,'{\"en\":\"WI\"}','{\"wu\":[],\"solr\":{\"content\":\"WI\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:45:27Z\",\"users\":{\"1\":\"1874\"}}}'),(1092,'{\"en\":\"WY\"}','{\"wu\":[],\"solr\":{\"content\":\"WY\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T14:45:33Z\",\"users\":{\"1\":\"1875\"}}}'),(1093,'{\"_title\":\"_zip\",\"en\":\"Zip Code\",\"type\":\"int\",\"order\":16,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"zip_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_zip\\nZip Code\\nint\\n16\\n{\\n\\\"faceting\\\":true\\n}\\nzip_s\\n\",\"order\":16},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1880\"},\"time\":\"2016-12-13T14:56:32Z\"}}'),(1094,'{\"_title\":\"_selfreportedtitle\",\"en\":\"Self Reported Special\\/At Risk Population\",\"type\":\"H\",\"order\":17}','{\"wu\":[],\"solr\":{\"content\":\"_selfreportedtitle\\nSelf Reported Special\\/At Risk Population\\nH\\n17\\n\",\"order\":17},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2361\"},\"time\":\"2017-01-10T15:44:08Z\"}}'),(1095,'{\"_title\":\"childassessment\",\"en\":\"Children\",\"type\":\"_objects\",\"order\":18,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"childassessment_i\"}','{\"wu\":[],\"solr\":{\"content\":\"childassessment\\nChildren\\n_objects\\n18\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\nchildassessment_i\\n\",\"order\":18},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2357\"},\"time\":\"2017-01-10T15:39:08Z\"}}'),(1096,'{\"_title\":\"seniorservicesassessment\",\"en\":\"Elderly\",\"type\":\"_objects\",\"order\":19,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"seniorservicesassessment\\nElderly\\n_objects\\n19\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":19},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2347\"},\"time\":\"2017-01-10T15:38:03Z\"}}'),(1097,'{\"_title\":\"employmentassessment\",\"en\":\"Employment\",\"type\":\"_objects\",\"order\":23,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"employment_i\"}','{\"wu\":[],\"solr\":{\"content\":\"employmentassessment\\nEmployment\\n_objects\\n23\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\nemployment_i\\n\",\"order\":23},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2355\"},\"time\":\"2017-01-10T15:38:55Z\"}}'),(1098,'{\"_title\":\"financialassessment\",\"en\":\"Financial\",\"type\":\"_objects\",\"order\":22,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"financialassessment\\nFinancial\\n_objects\\n22\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":22},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2353\"},\"time\":\"2017-01-10T15:38:43Z\"}}'),(1099,'{\"_title\":\"foodassessment\",\"en\":\"Food\",\"type\":\"_objects\",\"order\":23,\"cfg\":\"{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"foodassessment\\nFood\\n_objects\\n23\\n{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":23},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2352\"},\"time\":\"2017-01-10T15:38:38Z\"}}'),(1100,'{\"_title\":\"housingassessment\",\"en\":\"Housing\",\"type\":\"_objects\",\"order\":24,\"cfg\":\"{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"housing_i\"}','{\"wu\":[],\"solr\":{\"content\":\"housingassessment\\nHousing\\n_objects\\n24\\n{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\\nhousing_i\\n\",\"order\":24},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2350\"},\"time\":\"2017-01-10T15:38:21Z\"}}'),(1101,'{\"_title\":\"medicalassessment\",\"en\":\"Medical\",\"type\":\"_objects\",\"order\":25,\"cfg\":\"{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"medical_i\"}','{\"wu\":[],\"solr\":{\"content\":\"medicalassessment\\nMedical\\n_objects\\n25\\n{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\\nmedical_i\\n\",\"order\":25},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2348\"},\"time\":\"2017-01-10T15:38:13Z\"}}'),(1102,'{\"_title\":\"transportationassessment\",\"en\":\"Transportation\",\"type\":\"_objects\",\"order\":25,\"cfg\":\"{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"transportationassessment_i\"}','{\"wu\":[],\"solr\":{\"content\":\"transportationassessment\\nTransportation\\n_objects\\n25\\n{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\\ntransportationassessment_i\\n\",\"order\":25},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2346\"},\"time\":\"2017-01-10T15:37:58Z\"}}'),(1103,'{\"_lastname\":\"Tom\",\"_firstname\":\"Jones\",\"_middlename\":\"Richard\",\"_birthdate\":\"2016-12-13T00:00:00Z\",\"_clientage\":0,\"_gender\":218,\"_maritalstatus\":1036,\"_emailaddress\":\"test@this.com\",\"_headofhousehold\":347,\"_ethnicity\":229,\"_race\":235,\"_primarylanguage\":250,\"_limitedenglish\":347,\"_street\":\"123 Fake Street\",\"_city\":\"Simsponsville\",\"_domestic\":347,\"_zip\":22222,\"_children\":347,\"_elderly\":347,\"_disabilities\":347,\"_employment\":347,\"sys_data\":[]}','{\"full_address\":22345,\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"Tom\\nJones\\nRichard\\n2016-12-13T00:00:00Z\\n218\\n1036\\ntest@this.com\\n347\\n229\\n235\\n250\\n123 Fake Street\\nSimsponsville\\n22222\\n347\\n347\\n\",\"lastname_s\":\"Tom\",\"firstname_s\":\"Jones\",\"middlename_s\":\"Richard\",\"birthdate_dt\":\"2016-12-13T00:00:00Z\",\"gender_i\":218,\"maritalstatus_i\":1036,\"emailaddress_s\":\"test@this.com\",\"headofhousehold_i\":347,\"ethnicity_i\":229,\"race_i\":235,\"primarylanguage_i\":250,\"street_s\":\"123 Fake Street\",\"city_s\":\"Simsponsville\",\"zip_s\":22222,\"domestic_\":347,\"disabilities_i\":347,\"task_status\":2,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2118\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1104,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1904\"},\"time\":\"2016-12-13T16:29:48Z\"}}'),(1105,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1905\"},\"time\":\"2016-12-13T16:29:48Z\"}}'),(1106,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1906\"},\"time\":\"2016-12-13T16:29:48Z\"}}'),(1107,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1907\"},\"time\":\"2016-12-13T16:29:48Z\"}}'),(1108,'{\"_lastname\":\"Tom\",\"_firstname\":\"Smith\",\"_middlename\":\"Test\",\"_birthdate\":\"2016-12-13T00:00:00Z\",\"_clientage\":0,\"_maritalstatus\":1036,\"_emailaddress\":\"test@this.com\",\"_ethnicity\":229,\"_street\":\"939 Quantril Way\",\"_city\":\"Baltimore\",\"_state\":\"MD\",\"_zip\":21205,\"sys_data\":[]}','{\"full_address\":22144,\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"Tom\\nSmith\\nTest\\n2016-12-13T00:00:00Z\\n1036\\ntest@this.com\\n229\\n939 Quantril Way\\nBaltimore\\nMD\\n21205\\n\",\"lastname_s\":\"Tom\",\"firstname_s\":\"Smith\",\"middlename_s\":\"Test\",\"birthdate_dt\":\"2016-12-13T00:00:00Z\",\"maritalstatus_i\":1036,\"emailaddress_s\":\"test@this.com\",\"ethnicity_i\":229,\"street_s\":\"939 Quantril Way\",\"city_s\":\"Baltimore\",\"state_s\":\"MD\",\"zip_s\":21205,\"task_status\":2,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2117\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1109,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1914\"},\"time\":\"2016-12-13T17:42:24Z\"}}'),(1110,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1915\"},\"time\":\"2016-12-13T17:42:24Z\"}}'),(1111,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1916\"},\"time\":\"2016-12-13T17:42:24Z\"}}'),(1112,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1917\"},\"time\":\"2016-12-13T17:42:24Z\"}}'),(1113,'{\"_title\":\"assigned\",\"en\":\"Assigned Case Manager\",\"type\":\"_objects\",\"order\":33,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"required\\\": false\\n,\\\"source\\\": \\\"users\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": false\\n,\\\"hidePreview\\\": true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"assigned\\nAssigned Case Manager\\n_objects\\n33\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"required\\\": false\\n,\\\"source\\\": \\\"users\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": false\\n,\\\"hidePreview\\\": true\\n}\\n\",\"order\":33},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2911\"},\"time\":\"2017-01-18T20:14:27Z\"}}'),(1114,'{\"_title\":\"_assignedheader\",\"en\":\"Assigned Case Manager\",\"type\":\"H\",\"order\":30}','{\"wu\":[],\"solr\":{\"content\":\"_assignedheader\\nAssigned Case Manager\\nH\\n30\\n\",\"order\":30},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2360\"},\"time\":\"2017-01-10T15:44:02Z\"}}'),(1115,'{\"_lastname\":\"Jones\",\"_firstname\":\"TOm\",\"assigned\":\"21\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[21],\"task_status\":2,\"wu\":[1,21],\"solr\":{\"content\":\"Jones\\nTOm\\n21\\n\",\"lastname_s\":\"Jones\",\"firstname_s\":\"TOm\",\"task_status\":2,\"task_u_assignee\":[21],\"task_u_all\":[21,\"1\"],\"task_u_ongoing\":[21],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2114\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1116,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1924\"},\"time\":\"2016-12-13T18:27:38Z\"}}'),(1117,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1925\"},\"time\":\"2016-12-13T18:27:38Z\"}}'),(1118,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1926\"},\"time\":\"2016-12-13T18:27:38Z\"}}'),(1119,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"1927\"},\"time\":\"2016-12-13T18:27:38Z\"}}'),(1120,'{\"_title\":\"FEMAAssessment\",\"en\":\"FEMA Assistance\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-complaint-subjects\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"FEMA Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMAAssessment\\nFEMA Assistance\\ncaseassessment\\n1\\nicon-complaint-subjects\\n{\\n\\\"leaf\\\":true\\n}\\nFEMA Assistance\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2262\"},\"time\":\"2017-01-04T20:44:18Z\"}}'),(1121,'{\"_title\":\"_clienthavefemanumber\",\"en\":\"Does client have a FEMA registration number?\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clienthavefemanumber\\nDoes client have a FEMA registration number?\\n_objects\\n1\\n{\\n\\\"scope\\\":346\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T18:44:18Z\",\"users\":{\"1\":\"1932\"}}}'),(1122,'{\"_title\":\"_femanumber\",\"en\":\"FEMA Registration #\",\"type\":\"varchar\",\"order\":2,\"cfg\":\"{\\n \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_femanumber\\nFEMA Registration #\\nvarchar\\n2\\n{\\n \\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2108\"},\"time\":\"2016-12-13T23:49:08Z\"}}'),(1123,'{\"_title\":\"_progressheader\",\"en\":\"Manage Loan Activities\",\"type\":\"H\",\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"_progressheader\\nManage Loan Activities\\nH\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2120\"},\"time\":\"2016-12-14T00:19:59Z\"}}'),(1124,'{\"_title\":\"_clientnotreceived\",\"en\":\"Client has not received or does not know\",\"type\":\"_objects\",\"order\":3,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientnotreceived\\nClient has not received or does not know\\n_objects\\n3\\n{\\n\\\"scope\\\":346\\n}\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1937\"},\"time\":\"2016-12-13T18:48:08Z\"}}'),(1125,'{\"_title\":\"_clientthrewaway\",\"en\":\"Client has received envelope but threw away\",\"type\":\"_objects\",\"order\":4,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientthrewaway\\nClient has received envelope but threw away\\n_objects\\n4\\n{\\n\\\"scope\\\":346\\n}\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1938\"},\"time\":\"2016-12-13T18:48:17Z\"}}'),(1126,'{\"_title\":\"_submittedsba\",\"en\":\"Client has submitted SBA application\",\"type\":\"_objects\",\"order\":6,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_submittedsba\\nClient has submitted SBA application\\n_objects\\n6\\n{\\n\\\"scope\\\":346\\n}\\n\",\"order\":6},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T18:58:00Z\",\"users\":{\"1\":\"1940\"}}}'),(1127,'{\"_title\":\"_submittedsbadate\",\"en\":\"SBA Application Submitted Date\",\"type\":\"date\",\"order\":7}','{\"wu\":[],\"solr\":{\"content\":\"_submittedsbadate\\nSBA Application Submitted Date\\ndate\\n7\\n\",\"order\":7},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1948\"},\"time\":\"2016-12-13T19:04:36Z\"}}'),(1128,'{\"_title\":\"_clientapproved\",\"en\":\"Client has been approved for SBA loan\",\"type\":\"_objects\",\"order\":8,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clientapproved\\nClient has been approved for SBA loan\\n_objects\\n8\\n{\\n\\\"scope\\\":346\\n}\\n\",\"order\":8},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2091\"},\"time\":\"2016-12-13T23:44:30Z\"}}'),(1129,'{\"_title\":\"_clientapproveddate\",\"en\":\"Date Approved\",\"type\":\"date\",\"order\":9}','{\"wu\":[],\"solr\":{\"content\":\"_clientapproveddate\\nDate Approved\\ndate\\n9\\n\",\"order\":9},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2092\"},\"time\":\"2016-12-13T23:44:39Z\"}}'),(1130,'{\"_title\":\"_submittedclaim\",\"en\":\"Client has submitted claim for FEMA Individual Assistance\",\"type\":\"_objects\",\"order\":10,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\\n\"}','{\"wu\":[],\"solr\":{\"content\":\"_submittedclaim\\nClient has submitted claim for FEMA Individual Assistance\\n_objects\\n10\\n{\\n\\\"scope\\\":346\\n}\\n\\n\",\"order\":10},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2093\"},\"time\":\"2016-12-13T23:44:47Z\"}}'),(1131,'{\"_title\":\"_submittedclaimdate\",\"en\":\"Submitted Claim Date\",\"type\":\"date\",\"order\":11}','{\"wu\":[],\"solr\":{\"content\":\"_submittedclaimdate\\nSubmitted Claim Date\\ndate\\n11\\n\",\"order\":11},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2094\"},\"time\":\"2016-12-13T23:44:55Z\"}}'),(1132,'{\"_title\":\"_clienthasreceivednoncomp\",\"en\":\"CLient has received Non-Comp Notice from FEMA IA\",\"type\":\"_objects\",\"order\":12,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_clienthasreceivednoncomp\\nCLient has received Non-Comp Notice from FEMA IA\\n_objects\\n12\\n{\\n\\\"scope\\\":346\\n}\\n\",\"order\":12},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2095\"},\"time\":\"2016-12-13T23:45:05Z\"}}'),(1133,'{\"_title\":\"_clienthasreceivednoncompdate\",\"en\":\"Non-Comp Notice Received Date\",\"type\":\"date\",\"order\":13}','{\"wu\":[],\"solr\":{\"content\":\"_clienthasreceivednoncompdate\\nNon-Comp Notice Received Date\\ndate\\n13\\n\",\"order\":13},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2096\"},\"time\":\"2016-12-13T23:45:28Z\"}}'),(1134,'{\"en\":\"Yes - Another Hispanic, Latino, or Spanish Origin\",\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"Yes - Another Hispanic, Latino, or Spanish Origin\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1961\"},\"time\":\"2016-12-13T20:13:43Z\"}}'),(1135,'{\"en\":\"Yes - Cuban\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Yes - Cuban\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1960\"},\"time\":\"2016-12-13T20:13:32Z\"}}'),(1136,'{\"en\":\"Yes - Puerto Rican\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Yes - Puerto Rican\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"1959\"},\"time\":\"2016-12-13T20:13:21Z\"}}'),(1137,'{\"en\":\"Chinese\"}','{\"wu\":[],\"solr\":{\"content\":\"Chinese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:15:24Z\",\"users\":{\"1\":\"1966\"}}}'),(1138,'{\"en\":\"Filipino\"}','{\"wu\":[],\"solr\":{\"content\":\"Filipino\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:15:37Z\",\"users\":{\"1\":\"1967\"}}}'),(1139,'{\"en\":\"Other Asian\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Asian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:15:44Z\",\"users\":{\"1\":\"1968\"}}}'),(1140,'{\"en\":\"Japanese\"}','{\"wu\":[],\"solr\":{\"content\":\"Japanese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:15:53Z\",\"users\":{\"1\":\"1969\"}}}'),(1141,'{\"en\":\"Korean\"}','{\"wu\":[],\"solr\":{\"content\":\"Korean\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:16:01Z\",\"users\":{\"1\":\"1970\"}}}'),(1142,'{\"en\":\"Vietnamese\"}','{\"wu\":[],\"solr\":{\"content\":\"Vietnamese\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:16:10Z\",\"users\":{\"1\":\"1971\"}}}'),(1143,'{\"en\":\"Native Hawaiian\"}','{\"wu\":[],\"solr\":{\"content\":\"Native Hawaiian\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:16:23Z\",\"users\":{\"1\":\"1972\"}}}'),(1144,'{\"en\":\"Guamanian or Chamorro\"}','{\"wu\":[],\"solr\":{\"content\":\"Guamanian or Chamorro\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:17:14Z\",\"users\":{\"1\":\"1973\"}}}'),(1145,'{\"en\":\"Samoan\"}','{\"wu\":[],\"solr\":{\"content\":\"Samoan\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:18:21Z\",\"users\":{\"1\":\"1974\"}}}'),(1146,'{\"en\":\"Other Pacific Islander\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Pacific Islander\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:18:30Z\",\"users\":{\"1\":\"1975\"}}}'),(1147,'{\"en\":\"Some other Race\"}','{\"wu\":[],\"solr\":{\"content\":\"Some other Race\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:18:39Z\",\"users\":{\"1\":\"1976\"}}}'),(1148,'{\"_title\":\"_specialneedscount\",\"en\":\"How Many Special Needs?\",\"type\":\"int\",\"order\":20,\"cfg\":\"{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\",\"solr_column_name\":\"specialneedscount_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_specialneedscount\\nHow Many Special Needs?\\nint\\n20\\n{\\n   \\\"scope\\\": 346\\n   ,\\\"dependency\\\": {\\n      \\\"pidValues\\\": [347]\\n   }\\n}\\nspecialneedscount_i\\n\",\"order\":20},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2041\"},\"time\":\"2016-12-13T22:35:27Z\"}}'),(1149,'{\"_title\":\"_numberinhousehold\",\"en\":\"Number of individuals in household\",\"type\":\"int\",\"order\":17,\"solr_column_name\":\"numberinhousehold_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_numberinhousehold\\nNumber of individuals in household\\nint\\n17\\nnumberinhousehold_i\\n\",\"order\":17},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2732\"},\"time\":\"2017-01-12T02:51:38Z\"}}'),(1150,'{\"_title\":\"_unmetneedsheader\",\"en\":\"Identified Unmet Needs\",\"type\":\"H\",\"order\":21}','{\"wu\":[],\"solr\":{\"content\":\"_unmetneedsheader\\nIdentified Unmet Needs\\nH\\n21\\n\",\"order\":21},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2359\"},\"time\":\"2017-01-10T15:43:54Z\"}}'),(1151,'{\"en\":\"TriageLevel\",\"visible\":\"Generic-1\"}','{\"wu\":[],\"solr\":{\"content\":\"TriageLevel\\nGeneric-1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:32:47Z\",\"users\":{\"1\":\"1983\"}}}'),(1152,'{\"en\":\"Emergent\",\"visible\":\"Generic-2\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Emergent\\nGeneric-2\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:32:57Z\",\"users\":{\"1\":\"1984\"}}}'),(1153,'{\"en\":\"Urgent\",\"visible\":\"Generic-3\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Urgent\\nGeneric-3\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:33:05Z\",\"users\":{\"1\":\"1985\"}}}'),(1154,'{\"en\":\"Non-Urgent\",\"visible\":\"Generic-4\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Non-Urgent\\nGeneric-4\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-13T20:33:17Z\",\"users\":{\"1\":\"1986\"}}}'),(1155,'{\"en\":\"Not Started\",\"visible\":\"Generic-5\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Not Started\\nGeneric-5\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2870\"},\"time\":\"2017-01-17T17:23:30Z\"}}'),(1156,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2721\"},\"time\":\"2017-01-12T02:01:04Z\"}}'),(1157,'{\"_title\":\"_assessmentOrder\",\"en\":\"Pre or Post Assessment?\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\": 429\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentOrder\\nPre or Post Assessment?\\n_objects\\n{\\n\\\"scope\\\": 429\\n}\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2003\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1158,'{\"_title\":\"_rent\",\"en\":\"Rent\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\" : \\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_rent\\nRent\\nfloat\\n{ \\n\\\"totalValue\\\" : \\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2004\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1159,'{\"_title\":\"_mortgage\",\"en\":\"Mortgage\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_mortgage\\nMortgage\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2005\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1160,'{\"_title\":\"_maintenance\",\"en\":\"Maintenance\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_maintenance\\nMaintenance\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2006\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1161,'{\"_title\":\"_carpayment\",\"en\":\"Car Payment\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_carpayment\\nCar Payment\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2007\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1162,'{\"_title\":\"_carinsurance\",\"en\":\"Car Insurance\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_carinsurance\\nCar Insurance\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2008\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1163,'{\"_title\":\"_gasoline\",\"en\":\"Gasoline\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_gasoline\\nGasoline\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2009\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1164,'{\"_title\":\"_medical\",\"en\":\"Medical\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_medical\\nMedical\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2010\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1165,'{\"_title\":\"_food\",\"en\":\"Food\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_food\\nFood\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2011\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1166,'{\"_title\":\"_miscellaneous\",\"en\":\"Miscellaneous\",\"type\":\"float\",\"cfg\":\"{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \"}','{\"wu\":[],\"solr\":{\"content\":\"_miscellaneous\\nMiscellaneous\\nfloat\\n{ \\n\\\"totalValue\\\":\\\"Total monthly amount\\\" \\n} \\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2012\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1167,'{\"_title\":\"_totalExpenses\",\"en\":\"Number of Expenses\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"_totalExpenses\\nNumber of Expenses\\nint\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2013\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1168,'{\"_title\":\"_totalmonthlyamount\",\"en\":\"Total monthly amount\",\"type\":\"float\",\"cfg\":\"{\\n\\\"readonly\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_totalmonthlyamount\\nTotal monthly amount\\nfloat\\n{\\n\\\"readonly\\\":true\\n}\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2014\"},\"time\":\"2016-12-13T21:39:32Z\"}}'),(1169,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2593\"},\"time\":\"2017-01-11T16:28:03Z\"}}'),(1170,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1391\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-1\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1391\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2594\"},\"time\":\"2017-01-11T16:28:16Z\"}}'),(1171,'{\"_title\":\"clothingassessment\",\"en\":\"Clothing\",\"type\":\"_objects\",\"order\":23,\"cfg\":\"{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"clothingassessment\\nClothing\\n_objects\\n23\\n{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":23},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2356\"},\"time\":\"2017-01-10T15:39:00Z\"}}'),(1172,'{\"_title\":\"femaassessment\",\"en\":\"FEMA\\/SBA Assistance\",\"type\":\"_objects\",\"order\":25,\"cfg\":\"{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"femaassessment\\nFEMA\\/SBA Assistance\\n_objects\\n25\\n{\\n\\\"scope\\\": 346,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":25},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2354\"},\"time\":\"2017-01-10T15:38:49Z\"}}'),(1173,'{\"_title\":\"furnitureandappliancesassessment\",\"en\":\"Furniture\\/Appliances\",\"type\":\"_objects\",\"order\":25,\"cfg\":\"{\\n\\\"scope\\\":1151,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"furnitureandappliancesassessment\\nFurniture\\/Appliances\\n_objects\\n25\\n{\\n\\\"scope\\\":1151,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":25},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2351\"},\"time\":\"2017-01-10T15:38:26Z\"}}'),(1174,'{\"_title\":\"legalservicesassessment\",\"en\":\"Legal Services\",\"type\":\"_objects\",\"order\":25,\"cfg\":\"{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"legalservicesassessment\\nLegal Services\\n_objects\\n25\\n{\\n\\\"scope\\\": 1151,\\n\\\"faceting\\\":true\\n}\\n\",\"order\":25},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2349\"},\"time\":\"2017-01-10T15:38:17Z\"}}'),(1175,'{\"_title\":\"LegalServicesAssessment\",\"en\":\"Legal Services Assessment\",\"type\":\"caseassessment\",\"visible\":1,\"iconCls\":\"icon-echr_decision\",\"cfg\":\"{\\n\\\"leaf\\\":true\\n}\",\"title_template\":\"Legal Services Assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"LegalServicesAssessment\\nLegal Services Assessment\\ncaseassessment\\n1\\nicon-echr_decision\\n{\\n\\\"leaf\\\":true\\n}\\nLegal Services Assessment\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2269\"},\"time\":\"2017-01-04T20:45:34Z\"}}'),(1176,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-1,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-1\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2557\"},\"time\":\"2017-01-11T16:06:37Z\"}}'),(1177,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\",\"order\":0}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2112\"},\"time\":\"2016-12-13T23:54:56Z\"}}'),(1178,'{\"_title\":\"_assessmentdate\",\"en\":\"Assessment Date\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentdate\\nAssessment Date\\ndate\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2039\"},\"time\":\"2016-12-13T22:08:23Z\"}}'),(1179,'{\"assigned\":\"23,21\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[23,21],\"task_status\":2,\"wu\":[1,23,21],\"solr\":{\"content\":\"23,21\\n\",\"task_status\":2,\"task_u_assignee\":[23,21],\"task_u_all\":[23,21,\"1\"],\"task_u_ongoing\":[23,21],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2119\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1180,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2067\"},\"time\":\"2016-12-13T23:06:32Z\"}}'),(1181,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2068\"},\"time\":\"2016-12-13T23:06:32Z\"}}'),(1182,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2069\"},\"time\":\"2016-12-13T23:06:32Z\"}}'),(1183,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2070\"},\"time\":\"2016-12-13T23:06:32Z\"}}'),(1184,'{\"disabilityassessment\":347,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"\",\"task_status\":2,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2113\"},\"time\":\"2016-12-14T00:00:07Z\"}}'),(1185,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2074\"},\"time\":\"2016-12-13T23:16:40Z\"}}'),(1186,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2075\"},\"time\":\"2016-12-13T23:16:40Z\"}}'),(1187,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2076\"},\"time\":\"2016-12-13T23:16:40Z\"}}'),(1188,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2077\"},\"time\":\"2016-12-13T23:16:40Z\"}}'),(1189,'{\"_title\":\"_iabenefit\",\"en\":\"Client has received FEMA IA Benefit\",\"type\":\"_objects\",\"order\":13,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\",\"solr_column_name\":\"iabenefit_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_iabenefit\\nClient has received FEMA IA Benefit\\n_objects\\n13\\n{\\n\\\"scope\\\":346\\n}\\niabenefit_i\\n\",\"order\":13},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2111\"},\"time\":\"2016-12-13T23:54:39Z\"}}'),(1190,'{\"_title\":\"_iabenefitdate\",\"en\":\"IA Benefit Date\",\"type\":\"date\",\"order\":14}','{\"wu\":[],\"solr\":{\"content\":\"_iabenefitdate\\nIA Benefit Date\\ndate\\n14\\n\",\"order\":14},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2098\"},\"time\":\"2016-12-13T23:46:17Z\"}}'),(1191,'{\"_title\":\"_maxgrant\",\"en\":\"Client has receive MAX Grant from FEMA\",\"type\":\"_objects\",\"order\":15,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\",\"solr_column_name\":\"maxgrant_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_maxgrant\\nClient has receive MAX Grant from FEMA\\n_objects\\n15\\n{\\n\\\"scope\\\":346\\n}\\nmaxgrant_i\\n\",\"order\":15},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2099\"},\"time\":\"2016-12-13T23:46:24Z\"}}'),(1192,'{\"_title\":\"_maxgrantdate\",\"en\":\"MAX Grant Date\",\"type\":\"date\",\"order\":16}','{\"wu\":[],\"solr\":{\"content\":\"_maxgrantdate\\nMAX Grant Date\\ndate\\n16\\n\",\"order\":16},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2100\"},\"time\":\"2016-12-13T23:46:43Z\"}}'),(1193,'{\"_title\":\"_otherneedsassistance\",\"en\":\"Client has applied for FEMA Other Needs Assistance\",\"type\":\"_objects\",\"order\":17,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\",\"solr_column_name\":\"otherneedsassistance_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_otherneedsassistance\\nClient has applied for FEMA Other Needs Assistance\\n_objects\\n17\\n{\\n\\\"scope\\\":346\\n}\\notherneedsassistance_i\\n\",\"order\":17},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2101\"},\"time\":\"2016-12-13T23:46:52Z\"}}'),(1194,'{\"_title\":\"_otherneedsassistancedate\",\"en\":\"Other Needs Assistance Date\",\"type\":\"date\",\"order\":18,\"solr_column_name\":\"otherneedsassistancedate_dt\"}','{\"wu\":[],\"solr\":{\"content\":\"_otherneedsassistancedate\\nOther Needs Assistance Date\\ndate\\n18\\notherneedsassistancedate_dt\\n\",\"order\":18},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2102\"},\"time\":\"2016-12-13T23:47:02Z\"}}'),(1195,'{\"_title\":\"_onareceived\",\"en\":\"Client has received ONA\",\"type\":\"_objects\",\"order\":19,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\",\"solr_column_name\":\"onareceived_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_onareceived\\nClient has received ONA\\n_objects\\n19\\n{\\n\\\"scope\\\":346\\n}\\nonareceived_i\\n\",\"order\":19},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2103\"},\"time\":\"2016-12-13T23:47:16Z\"}}'),(1196,'{\"_title\":\"_onareceiveddate\",\"en\":\"ONA Received Date\",\"type\":\"date\",\"order\":20,\"solr_column_name\":\"onareceiveddate_dt\"}','{\"wu\":[],\"solr\":{\"content\":\"_onareceiveddate\\nONA Received Date\\ndate\\n20\\nonareceiveddate_dt\\n\",\"order\":20},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2104\"},\"time\":\"2016-12-13T23:47:29Z\"}}'),(1197,'{\"_title\":\"_onadenied\",\"en\":\"Client was denied for ONA\",\"type\":\"_objects\",\"order\":21,\"cfg\":\"{\\n\\\"scope\\\":346\\n}\",\"solr_column_name\":\"onadenied_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_onadenied\\nClient was denied for ONA\\n_objects\\n21\\n{\\n\\\"scope\\\":346\\n}\\nonadenied_i\\n\",\"order\":21},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2105\"},\"time\":\"2016-12-13T23:47:36Z\"}}'),(1198,'{\"_title\":\"_onadenieddate\",\"en\":\"ONA Denied Date\",\"type\":\"date\",\"order\":22,\"solr_column_name\":\"onadenieddate_dt\"}','{\"wu\":[],\"solr\":{\"content\":\"_onadenieddate\\nONA Denied Date\\ndate\\n22\\nonadenieddate_dt\\n\",\"order\":22},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2106\"},\"time\":\"2016-12-13T23:47:45Z\"}}'),(1199,'{\"_lastname\":\"ClientWorkflow\",\"_firstname\":\"Test\",\"_middlename\":\"Johnson\",\"_birthdate\":\"2009-12-15T00:00:00Z\",\"_clientage\":7,\"_gender\":214,\"_maritalstatus\":1036,\"_emailaddress\":\"tjomjones@this.com\",\"_headofhousehold\":347,\"_ethnicity\":230,\"_race\":234,\"_primarylanguage\":253,\"_street\":\"123 Fake Street\",\"_city\":\"Test\",\"_state\":\"MD\",\"_zip\":22223,\"_numberinhousehold\":1,\"childassessment\":347,\"_domestic\":347,\"seniorservicesassessment\":347,\"_disabilities\":348,\"languageassessment\":347,\"financialassessment\":347,\"employmentassessment\":347,\"foodassessment\":1152,\"clothingassessment\":1153,\"housingassessment\":1155,\"medicalassessment\":1153,\"transportationassessment\":1154,\"femaassessment\":348,\"furnitureandappliancesassessment\":1152,\"legalservicesassessment\":1152,\"assigned\":\"21\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[21],\"task_status\":3,\"wu\":[1,21],\"solr\":{\"content\":\"ClientWorkflow\\nTest\\nJohnson\\n2009-12-15T00:00:00Z\\n7\\n214\\n1036\\n230\\n234\\n253\\ntjomjones@this.com\\n123 Fake Street\\nTest\\nMD\\n22223\\n347\\n1\\n347\\n348\\n21\\n\",\"lastname_s\":\"ClientWorkflow\",\"firstname_s\":\"Test\",\"middlename_s\":\"Johnson\",\"birthdate_dt\":\"2009-12-15T00:00:00Z\",\"clientage_i\":7,\"gender_i\":214,\"maritalstatus_i\":1036,\"ethnicity_i\":230,\"race_i\":234,\"primarylanguage_i\":253,\"emailaddress_s\":\"tjomjones@this.com\",\"street_s\":\"123 Fake Street\",\"city_s\":\"Test\",\"state_s\":\"MD\",\"zip_s\":22223,\"headofhousehold_i\":347,\"domestic_i\":347,\"disabilities_i\":348,\"task_status\":3,\"task_u_assignee\":[21],\"task_u_all\":[21,\"1\"],\"race\":\"American Indian Native or Alaska Native\",\"gender\":\"Male\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"123 Fake Street Test MD 22223\",\"task_d_closed\":\"2017-01-14T00:27:41Z\",\"task_u_ongoing\":[21],\"task_ym_closed\":\"1701\",\"cls\":\"\"},\"lastAction\":{\"type\":\"close\",\"users\":{\"1\":\"2802\"},\"time\":\"2017-01-14T00:27:41Z\"},\"maritalstatus\":\"Married\",\"headofhousehold\":\"Yes\",\"race\":\"American Indian Native or Alaska Native\",\"gender\":\"Male\",\"ethnicity\":\"No\",\"full_address\":\"123 Fake Street Test MD 22223\",\"task_d_closed\":\"2017-01-14T00:27:41Z\"}'),(1200,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2139\"},\"time\":\"2016-12-15T19:56:09Z\"}}'),(1201,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2138\"},\"time\":\"2016-12-15T19:56:06Z\"}}'),(1202,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2141\"},\"time\":\"2016-12-15T19:56:15Z\"}}'),(1203,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2140\"},\"time\":\"2016-12-15T19:56:12Z\"}}'),(1204,'{\"_title\":\"Reports\"}','{\"wu\":[],\"solr\":{\"content\":\"Reports\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T19:20:52Z\",\"users\":{\"1\":\"2126\"}}}'),(1205,'{\"_title\":\"FEMA Report\",\"en\":\"FEMA Daily Report\",\"type\":\"object\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Report\\nFEMA Daily Report\\nobject\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T19:21:16Z\",\"users\":{\"1\":\"2127\"}}}'),(1206,'{\"_title\":\"Total Client Contact\",\"type\":\"int\"}','{\"wu\":[],\"solr\":{\"content\":\"Total Client Contact\\nint\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2130\"},\"time\":\"2016-12-15T19:25:28Z\"}}'),(1207,'{\"_title\":\"ReportDate\",\"en\":\"Date of Report\",\"type\":\"date\"}','{\"wu\":[],\"solr\":{\"content\":\"ReportDate\\nDate of Report\\ndate\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T19:24:44Z\",\"users\":{\"1\":\"2129\"}}}'),(1208,'{\"Total Client Contact\":1,\"ReportDate\":\"2016-12-15T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"1\\n2016-12-15T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T19:27:11Z\",\"users\":{\"1\":\"2132\"}}}'),(1209,'{\"_title\":\"Test\",\"due_date\":\"2016-12-19T00:00:00Z\",\"importance\":54,\"sys_data\":[]}','{\"task_due_date\":\"2016-12-19T00:00:00Z\",\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":1,\"wu\":[1],\"solr\":{\"content\":\"Test\\n2016-12-19T00:00:00Z\\n54\\n\",\"\":54,\"task_status\":1,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2203\"},\"time\":\"2016-12-28T21:50:45Z\"}}'),(1210,'{\"_assessmentdate\":\"2016-12-15T00:00:00Z\",\"_anyoneloseclothing\":{\"value\":347,\"childs\":{\"_makeclaim\":347}},\"_usableclothing\":347,\"_coldweather\":347,\"_referralneeded\":687}','{\"wu\":[1],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n347\\n347\\n347\\n347\\n687\\n\",\"comment_user_id\":1,\"comment_date\":\"2016-12-15T19:55:37Z\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2173\"},\"time\":\"2016-12-15T20:47:39Z\"},\"lastComment\":{\"user_id\":1,\"date\":\"2016-12-15T19:55:37Z\"}}'),(1211,'{\"_title\":\"Alls good with this assessment\"}','{\"wu\":[],\"solr\":{\"content\":\"Alls good with this assessment\"}}'),(1212,'{\"_lastname\":\"Test\",\"_firstname\":\"Recovery\",\"at_risk_population\":\"1497,1498,1499,1500,1501,1502\",\"identified_unmet_needs\":\"1511,1507,1508,1506,1515,1510,1512,1514,1505,1513,1504,1509\",\"_fematier\":1325,\"assigned\":\"21\",\"sys_data\":[],\"oid\":21}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[21],\"task_status\":2,\"wu\":[1,21],\"solr\":{\"content\":\"Test\\nRecovery\\n1497,1498,1499,1500,1501,1502\\n1511,1507,1508,1506,1515,1510,1512,1514,1505,1513,1504,1509\\n1325\\n21\\n\",\"lastname_s\":\"Test\",\"firstname_s\":\"Recovery\",\"fematier_i\":1325,\"comment_user_id\":1,\"comment_date\":\"2016-12-30T02:54:35Z\",\"task_status\":2,\"task_u_assignee\":[21],\"task_u_all\":[21,\"1\"],\"task_u_ongoing\":[21],\"cls\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2868\"},\"time\":\"2017-01-14T04:58:28Z\"},\"lastComment\":{\"user_id\":1,\"date\":\"2016-12-30T02:54:35Z\"},\"assessments_completed\":[],\"assessments_needed\":[],\"referrals_needed\":null,\"full_address\":\"\"}'),(1213,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2142\"},\"time\":\"2016-12-15T19:57:15Z\"}}'),(1214,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2143\"},\"time\":\"2016-12-15T19:57:15Z\"}}'),(1215,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2155\"},\"time\":\"2016-12-15T20:20:02Z\"}}'),(1216,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2154\"},\"time\":\"2016-12-15T20:19:58Z\"}}'),(1217,'{\"_assessmentdate\":\"2016-12-15T00:00:00Z\",\"_childrenunder18\":{\"value\":347,\"childs\":{\"_fostercare\":347,\"_headstart\":{\"value\":347,\"childs\":{\"_servicesdisrupted\":347}},\"_childcareneed\":{\"value\":347,\"childs\":{\"_priorvoucher\":347,\"_barrierstochildcare\":\"I don''t know\"}}}},\"_referralneeded\":686}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n347\\n347\\n347\\n347\\n347\\n347\\nI don''t know\\n686\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2150\"},\"time\":\"2016-12-15T19:59:36Z\"}}'),(1218,'{\"_assessmentdate\":\"2016-12-15T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T19:58:04Z\",\"users\":{\"1\":\"2148\"}}}'),(1219,'{\"_entrydate\":\"2016-10-24T04:00:00.000Z\",\"_regarding\":\"This\",\"_notetype\":523,\"_casenote\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-10-24T04:00:00.000Z\\nThis\\n523\\nTest\\n\",\"notetype_i\":523},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T20:08:27Z\",\"users\":{\"1\":\"2151\"}}}'),(1220,'{\"_referraldate\":\"2016-12-15T00:00:00Z\",\"_referralservice\":590}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n590\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2153\"},\"time\":\"2016-12-15T20:18:23Z\"}}'),(1221,'{\"_assessmentdate\":\"2016-12-15T00:00:00Z\",\"_referralneeded\":686}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n686\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2679\"},\"time\":\"2017-01-11T21:05:28Z\"}}'),(1222,'{\"_referraldate\":\"2016-12-15T00:00:00Z\",\"_referralservice\":571}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n571\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T20:25:41Z\",\"users\":{\"1\":\"2157\"}}}'),(1223,'{\"_title\":\"referralrecoveryplan\",\"en\":\"Recovery Plan Details\",\"type\":\"text\",\"cfg\":\"{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [347]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"referralrecoveryplan\\nRecovery Plan Details\\ntext\\n{\\n\\\"dependency\\\": {\\n\\\"pidValues\\\": [347]\\n}\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2567\"},\"time\":\"2017-01-11T16:11:27Z\"}}'),(1224,'{\"_assessmentdate\":\"2016-12-15T00:00:00Z\",\"_predisasterliving\":344,\"_damagedhouse\":347,\"_predisasterinsurance\":375,\"_referralneeded\":686}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n344\\n347\\n375\\n686\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T20:37:11Z\",\"users\":{\"1\":\"2167\"}}}'),(1225,'{\"_lastname\":\"Simpson\",\"_firstname\":\"Jennifer\",\"assigned\":\"24\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[24],\"task_status\":3,\"wu\":[1,24],\"solr\":{\"content\":\"Simpson\\nJennifer\\n24\\n\",\"lastname_s\":\"Simpson\",\"firstname_s\":\"Jennifer\",\"comment_user_id\":1,\"comment_date\":\"2016-12-30T01:22:17Z\",\"task_status\":3,\"task_u_assignee\":[24],\"task_u_all\":[24,\"1\"],\"task_d_closed\":\"2017-01-09T01:35:52Z\",\"task_u_ongoing\":[24],\"task_ym_closed\":\"1701\",\"cls\":\"\"},\"lastAction\":{\"type\":\"close\",\"users\":{\"1\":\"2334\"},\"time\":\"2017-01-09T01:35:52Z\"},\"lastComment\":{\"user_id\":1,\"date\":\"2016-12-30T01:22:17Z\"},\"task_d_closed\":\"2017-01-09T01:35:52Z\"}'),(1226,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2174\"},\"time\":\"2016-12-15T21:11:09Z\"}}'),(1227,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2175\"},\"time\":\"2016-12-15T21:11:09Z\"}}'),(1228,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2176\"},\"time\":\"2016-12-15T21:11:09Z\"}}'),(1229,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2177\"},\"time\":\"2016-12-15T21:11:09Z\"}}'),(1230,'{\"_lastname\":\"Whater\",\"_firstname\":\"Ter\",\"_race\":1145,\"childassessment\":347,\"transportationassessment\":1152,\"assigned\":\"24\",\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[24],\"task_status\":3,\"wu\":[1,24],\"solr\":{\"content\":\"Whater\\nTer\\n1145\\n347\\n1152\\n24\\n\",\"lastname_s\":\"Whater\",\"firstname_s\":\"Ter\",\"race_i\":1145,\"childassessment_i\":347,\"transportationassessment_i\":1152,\"comment_user_id\":1,\"comment_date\":\"2017-01-05T17:37:23Z\",\"task_status\":3,\"task_u_assignee\":[24],\"task_u_all\":[24,\"1\"],\"race\":\"Samoan\",\"task_d_closed\":\"2017-01-09T14:38:10Z\",\"task_u_ongoing\":[24],\"task_ym_closed\":\"1701\",\"cls\":\"\"},\"lastAction\":{\"type\":\"close\",\"users\":{\"1\":\"2339\"},\"time\":\"2017-01-09T14:38:10Z\"},\"race\":\"Samoan\",\"full_address\":\"\",\"lastComment\":{\"user_id\":1,\"date\":\"2017-01-05T17:37:23Z\"},\"task_d_closed\":\"2017-01-09T14:38:10Z\"}'),(1231,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2184\"},\"time\":\"2016-12-15T21:16:49Z\"}}'),(1232,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2185\"},\"time\":\"2016-12-15T21:16:51Z\"}}'),(1233,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2186\"},\"time\":\"2016-12-15T21:17:43Z\"}}'),(1234,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2182\"},\"time\":\"2016-12-15T21:12:59Z\"}}'),(1235,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"904453\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"2187\"},\"time\":\"2016-12-15T21:18:17Z\"}}'),(1236,'{\"_entrydate\":\"2016-10-24T04:00:00.000Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-10-24T04:00:00.000Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-15T21:24:22Z\",\"users\":{\"1\":\"2188\"}}}'),(1237,'{\"_lastname\":\"Test\",\"_firstname\":\"Person\",\"_middlename\":\"T\",\"_street\":\"123 Fake Street\",\"childassessment\":347,\"_domestic\":347,\"seniorservicesassessment\":347,\"_disabilities\":{\"value\":347,\"childs\":{\"_specialneedscount\":1}},\"languageassessment\":347,\"financialassessment\":347,\"employmentassessment\":347,\"foodassessment\":1155,\"clothingassessment\":1155,\"housingassessment\":1155,\"medicalassessment\":1155,\"transportationassessment\":1152,\"femaassessment\":349,\"assigned\":\"24\",\"sys_data\":[],\"oid\":24}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_ongoing\":[24],\"task_status\":2,\"wu\":[1,24],\"solr\":{\"content\":\"Test\\nPerson\\nT\\n123 Fake Street\\n347\\n347\\n1\\n24\\n\",\"lastname_s\":\"Test\",\"firstname_s\":\"Person\",\"middlename_s\":\"T\",\"street_s\":\"123 Fake Street\",\"domestic_i\":347,\"disabilities_i\":347,\"comment_user_id\":1,\"comment_date\":\"2016-12-30T01:48:27Z\",\"task_status\":2,\"task_u_assignee\":[24],\"task_u_all\":[24,\"1\"],\"full_address\":\"123 Fake Dr, Luray, VA 22835, USA\",\"task_u_ongoing\":[24],\"lat_lon\":\"38.70619,-78.5065048\",\"county\":\"Page County\",\"location_type\":\"RANGE_INTERPOLATED\",\"cls\":\"\"},\"lastAction\":{\"type\":\"reopen\",\"users\":{\"1\":\"2769\"},\"time\":\"2017-01-13T14:58:40Z\"},\"lastComment\":{\"user_id\":1,\"date\":\"2016-12-30T01:48:27Z\"},\"assessments_completed\":[],\"assessments_needed\":[],\"referrals_needed\":null,\"full_address\":\"123 Fake Street\",\"task_u_done\":[]}'),(1238,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2189\"},\"time\":\"2016-12-15T21:31:30Z\"}}'),(1239,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2190\"},\"time\":\"2016-12-15T21:31:30Z\"}}'),(1240,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2191\"},\"time\":\"2016-12-15T21:31:30Z\"}}'),(1241,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2192\"},\"time\":\"2016-12-15T21:31:30Z\"}}'),(1242,'{\"_assessmentdate\":\"2016-12-15T00:00:00Z\",\"_primarymode\":398,\"_referralneeded\":686}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-15T00:00:00Z\\n398\\n686\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2234\"},\"time\":\"2017-01-03T21:00:53Z\"}}'),(1243,'{\"_lastname\":\"Jonas\",\"_firstname\":\"Myname\",\"_middlename\":\"dsafdsaf\",\"_birthdate\":\"2016-12-16T00:00:00Z\",\"_clientage\":0,\"_gender\":218,\"_maritalstatus\":1036,\"_ethnicity\":1135,\"_race\":235,\"_primarylanguage\":250,\"_street\":\"123 Fake STreet\",\"at_risk_population\":\"1497,1498,1499,1500,1501,1502\",\"identified_unmet_needs\":\"1511,1507,1508,1506,1515,1510,1512,1514,1505,1513,1504,1509\",\"_fematier\":1327,\"assigned\":\"28\",\"sys_data\":[],\"oid\":28}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[28],\"task_status\":2,\"wu\":[1,28],\"solr\":{\"content\":\"Jonas\\nMyname\\ndsafdsaf\\n2016-12-16T00:00:00Z\\n218\\n1036\\n1135\\n235\\n250\\n123 Fake STreet\\n1497,1498,1499,1500,1501,1502\\n1511,1507,1508,1506,1515,1510,1512,1514,1505,1513,1504,1509\\n1327\\n28\\n\",\"lastname_s\":\"Jonas\",\"firstname_s\":\"Myname\",\"middlename_s\":\"dsafdsaf\",\"birthdate_dt\":\"2016-12-16T00:00:00Z\",\"gender_i\":218,\"maritalstatus_i\":1036,\"ethnicity_i\":1135,\"race_i\":235,\"primarylanguage_i\":250,\"street_s\":\"123 Fake STreet\",\"fematier_i\":1327,\"task_status\":2,\"task_u_assignee\":[28],\"task_u_all\":[28,\"1\"],\"race\":\"Asian American\",\"gender\":\"Don''t Know\",\"maritalstatus\":\"Married\",\"ethnicity\":\"Yes - Cuban\",\"full_address\":\"123 Fake Dr, Luray, VA 22835, USA\",\"assessments_reported\":[510,533,553,482,1120,455,505,559,489,440,656,1175,651,172],\"assessments_needed\":[510,533,553,482,1120,455,505,559,489,440,656,1175,651,172],\"task_u_ongoing\":[28],\"lat_lon\":\"38.70619,-78.5065048\",\"county\":\"Page County\",\"location_type\":\"RANGE_INTERPOLATED\",\"cls\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2913\"},\"time\":\"2017-01-18T20:32:57Z\"},\"race\":\"Asian American\",\"gender\":\"Don''t Know\",\"maritalstatus\":\"Married\",\"ethnicity\":\"Yes - Cuban\",\"full_address\":\"123 Fake STreet\",\"assessments_completed\":[],\"assessments_reported\":[510,533,553,482,1120,455,505,559,489,440,656,1175,651,172],\"assessments_needed\":[510,533,553,482,1120,455,505,559,489,440,656,1175,651,172]}'),(1244,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2196\"},\"time\":\"2016-12-17T04:03:35Z\"}}'),(1245,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2197\"},\"time\":\"2016-12-17T04:03:35Z\"}}'),(1246,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2198\"},\"time\":\"2016-12-17T04:03:35Z\"}}'),(1247,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2199\"},\"time\":\"2016-12-17T04:03:35Z\"}}'),(1248,'{\"_assessmentdate\":\"2016-12-17T00:00:00Z\",\"_primarymode\":{\"value\":393,\"childs\":{\"_methodworking\":{\"value\":347,\"childs\":{\"_insured\":347,\"_receivedpayment\":348,\"_damagedindisaster\":348,\"_transportationneeds\":406}}}},\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-17T00:00:00Z\\n393\\n347\\n347\\n348\\n348\\n406\\n687\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2235\"},\"time\":\"2017-01-03T21:00:56Z\"}}'),(1249,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2766\"},\"time\":\"2017-01-13T04:24:22Z\"}}'),(1250,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2765\"},\"time\":\"2017-01-13T04:24:20Z\"}}'),(1251,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"16401\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"2212\"},\"time\":\"2016-12-30T01:18:48Z\"}}'),(1252,'{\"_firstname\":\"Test\",\"_lastname\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"Test\\nTest\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-30T01:20:59Z\",\"users\":{\"1\":\"2213\"}}}'),(1253,'{\"_assessmentdate\":\"2016-12-29T00:00:00Z\",\"_indistress\":347,\"_liketospeak\":347,\"_feelsafe\":347,\"_hurtingyourselfothers\":347}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-29T00:00:00Z\\n347\\n347\\n347\\n347\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-30T01:21:43Z\",\"users\":{\"1\":\"2214\"}}}'),(1254,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"}}'),(1255,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"16401\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"2216\"},\"time\":\"2016-12-30T01:22:10Z\"}}'),(1256,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2254\"},\"time\":\"2017-01-04T17:48:12Z\"}}'),(1257,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"16401\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"2218\"},\"time\":\"2016-12-30T01:48:22Z\"}}'),(1258,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2764\"},\"time\":\"2017-01-13T04:24:15Z\"}}'),(1259,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"16401\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"1\":\"2220\"},\"time\":\"2016-12-30T02:54:32Z\"}}'),(1260,'{\"_title\":\"test bug fix\"}','{\"wu\":[],\"solr\":{\"content\":\"test bug fix\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2240\"},\"time\":\"2017-01-04T15:06:19Z\"}}'),(1261,'{\"_firstname\":\"Tommy\",\"_lastname\":\"Simpson\"}','{\"wu\":[],\"solr\":{\"content\":\"Tommy\\nSimpson\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2016-12-30T13:41:13Z\",\"users\":{\"25\":\"2223\"}}}'),(1262,'{\"_assessmentdate\":\"2016-12-30T00:00:00Z\",\"_anyoneloseclothing\":{\"value\":347,\"childs\":{\"_makeclaim\":347}},\"_usableclothing\":347,\"_coldweather\":347,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1425,1426,1427,1428\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2016-12-30T00:00:00Z\\n347\\n347\\n347\\n347\\n686\\n1425,1426,1427,1428\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2588\"},\"time\":\"2017-01-11T16:17:29Z\"}}'),(1263,'{\"_name\":\"Test Service\",\"_address\":\"123 Fake Street\",\"_notes\":\"Test Service\"}','{\"wu\":[],\"solr\":{\"content\":\"Test Service\\n123 Fake Street\\nTest Service\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2482\"},\"time\":\"2017-01-11T14:39:14Z\"}}'),(1264,'{\"_title\":\"_phonenumber\",\"en\":\"Primary Phone Number\",\"type\":\"varchar\",\"order\":11,\"cfg\":\"{\\n\\\"faceting\\\":true\\n}\",\"solr_column_name\":\"phonenumber_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_phonenumber\\nPrimary Phone Number\\nvarchar\\n11\\n{\\n\\\"faceting\\\":true\\n}\\nphonenumber_s\\n\",\"order\":11},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2727\"},\"time\":\"2017-01-12T02:47:03Z\"}}'),(1265,'{\"_assessmentdate\":\"2017-01-03T00:00:00Z\",\"_primarymode\":398,\"_referralneeded\":686,\"_referralservice\":\"1263\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-03T00:00:00Z\\n398\\n686\\n1263\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2437\"},\"time\":\"2017-01-11T01:42:13Z\"}}'),(1266,'{\"_assessmentdate\":\"2017-01-03T00:00:00Z\",\"_primarymode\":398,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1407,1408,1409\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-03T00:00:00Z\\n398\\n686\\n1407,1408,1409\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2589\"},\"time\":\"2017-01-11T16:17:43Z\"}}'),(1267,'{\"_assessmentdate\":\"2017-01-04T00:00:00Z\",\"_primarymode\":398}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-04T00:00:00Z\\n398\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2438\"},\"time\":\"2017-01-11T01:42:17Z\"}}'),(1268,'{\"_assessmentdate\":\"2017-01-04T00:00:00Z\",\"_predisasterliving\":342,\"_damagedhouse\":{\"value\":347,\"childs\":{\"_inspectedhouse\":353}},\"_accessiblehouse\":347,\"_livablehouse\":347}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-04T00:00:00Z\\n342\\n347\\n353\\n347\\n347\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2439\"},\"time\":\"2017-01-11T01:42:24Z\"}}'),(1269,'{\"_assessmentdate\":\"2017-01-16T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-16T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"28\":\"2344\"},\"time\":\"2017-01-09T21:06:49Z\"}}'),(1270,'{\"_assessmentdate\":\"2017-01-04T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-04T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-04T20:55:36Z\",\"users\":{\"1\":\"2274\"}}}'),(1271,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T11:58:54Z\",\"users\":{\"1\":\"2275\"}}}'),(1272,'{\"_title\":\"identified_unmet_needs\",\"en\":\"Identified Unmet Needs\",\"type\":\"_objects\",\"order\":31,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"required\\\":true\\n,\\\"source\\\": \\\"tree\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"fields\\\":\\\"title\\\"\\n,\\\"scope\\\":1503\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": false\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"identified_unmet_needs\\nIdentified Unmet Needs\\n_objects\\n31\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"required\\\":true\\n,\\\"source\\\": \\\"tree\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"fields\\\":\\\"title\\\"\\n,\\\"scope\\\":1503\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": false\\n}\\n\",\"order\":31},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2915\"},\"time\":\"2017-01-18T21:57:21Z\"}}'),(1273,'{\"_referraldate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2681\"},\"time\":\"2017-01-11T21:06:50Z\"}}'),(1274,'{\"_title\":\"testlongcomment\"}','{\"wu\":[],\"solr\":{\"content\":\"testlongcomment\"}}'),(1275,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"}}'),(1276,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"}}'),(1277,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"}}'),(1278,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"}}'),(1279,'{\"_title\":\"test\"}','{\"wu\":[],\"solr\":{\"content\":\"test\"}}'),(1280,'{\"_referraldate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T17:38:32Z\",\"users\":{\"1\":\"2285\"}}}'),(1281,'{\"_referraldate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2682\"},\"time\":\"2017-01-11T21:06:54Z\"}}'),(1282,'{\"_referraldate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2683\"},\"time\":\"2017-01-11T21:06:57Z\"}}'),(1283,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T17:50:22Z\",\"users\":{\"1\":\"2288\"}}}'),(1284,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2680\"},\"time\":\"2017-01-11T21:05:46Z\"}}'),(1285,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\",\"_childsupportpost\":347,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1413,1414,1416,1417,1418,1419,1412,1415\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n347\\n686\\n1413,1414,1416,1417,1418,1419,1412,1415\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2763\"},\"time\":\"2017-01-13T04:23:47Z\"}}'),(1286,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T17:58:20Z\",\"users\":{\"1\":\"2291\"}}}'),(1287,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T18:00:15Z\",\"users\":{\"1\":\"2292\"}}}'),(1288,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T18:01:43Z\",\"users\":{\"1\":\"2293\"}}}'),(1289,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n2017-01-05T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T18:01:54Z\",\"users\":{\"1\":\"2294\"}}}'),(1290,'{\"_assessmentdate\":\"2017-01-05T00:00:00Z\",\"_clienthavefemanumber\":{\"value\":347,\"childs\":{\"_femanumber\":\"235235325\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-05T00:00:00Z\\n347\\n235235325\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-05T18:05:45Z\",\"users\":{\"1\":\"2295\"}}}'),(1291,'{\"_lastname\":\"Faith\",\"_firstname\":\"Hodges\",\"_middlename\":\"A\",\"_birthdate\":\"1984-12-12T00:00:00Z\",\"_clientage\":32,\"_gender\":214,\"_maritalstatus\":1036,\"_emailaddress\":\"test@test.com\",\"_headofhousehold\":347,\"_ethnicity\":230,\"_race\":238,\"_primarylanguage\":242,\"_street\":\"1747 T St. NW\",\"_city\":\"Washington \",\"_state\":\"DC\",\"_zip\":20009,\"_numberinhousehold\":5,\"_phonenumber\":\"5555555555\",\"childassessment\":347,\"_domestic\":348,\"seniorservicesassessment\":348,\"_disabilities\":348,\"languageassessment\":348,\"financialassessment\":347,\"employmentassessment\":347,\"foodassessment\":1152,\"clothingassessment\":1155,\"housingassessment\":1152,\"medicalassessment\":1155,\"transportationassessment\":1155,\"femaassessment\":347,\"furnitureandappliancesassessment\":1155,\"legalservicesassessment\":1155,\"assigned\":\"25\",\"assessments\":\"533,553,505,455,559,489\",\"sys_data\":[]}','{\"race\":\"White\",\"gender\":\"Male\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"1747 T St. NW Washington  DC 20009\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[25],\"task_status\":2,\"wu\":[24,25],\"solr\":{\"content\":\"Faith\\nHodges\\nA\\n1984-12-12T00:00:00Z\\n32\\n214\\n1036\\ntest@test.com\\n347\\n230\\n238\\n242\\n1747 T St. NW\\nWashington \\nDC\\n20009\\n5\\n5555555555\\n347\\n348\\n348\\n348\\n348\\n347\\n347\\n1152\\n1155\\n1152\\n1155\\n1155\\n347\\n1155\\n1155\\n25\\n533,553,505,455,559,489\\n\",\"lastname_s\":\"Faith\",\"firstname_s\":\"Hodges\",\"middlename_s\":\"A\",\"birthdate_dt\":\"1984-12-12T00:00:00Z\",\"clientage_i\":32,\"gender_i\":214,\"maritalstatus_i\":1036,\"emailaddress_s\":\"test@test.com\",\"headofhousehold_i\":347,\"ethnicity_i\":230,\"race_i\":238,\"primarylanguage_i\":242,\"street_s\":\"1747 T St. NW\",\"city_s\":\"Washington \",\"state_s\":\"DC\",\"zip_s\":20009,\"phonenumber_s\":\"5555555555\",\"childassessment_i\":347,\"domestic_\":348,\"\":1155,\"disabilities_i\":348,\"limitedenglish_i\":348,\"employment_i\":347,\"housing_i\":1152,\"medical_i\":1155,\"transportationassessment_i\":1155,\"comment_user_id\":24,\"comment_date\":\"2017-01-06T15:54:03Z\",\"task_status\":2,\"task_u_assignee\":[25],\"task_u_all\":[25,\"24\"],\"race\":\"White\",\"gender\":\"Male\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"1747 T St NW, Washington, DC 20009, USA\",\"task_u_ongoing\":[25],\"lat_lon\":\"38.9158008,-77.0404251\",\"county\":\"Washington\",\"location_type\":\"ROOFTOP\",\"cls\":\"\"},\"lastAction\":{\"type\":\"comment\",\"users\":{\"24\":\"2314\"},\"time\":\"2017-01-06T15:54:03Z\"},\"lastComment\":{\"user_id\":24,\"date\":\"2017-01-06T15:54:03Z\"}}'),(1292,'{\"_firstname\":\"John\",\"_lastname\":\"Hodges\",\"_middlename\":\"Mike\",\"_birthdate\":\"2005-12-07T00:00:00Z\",\"_age\":11,\"_gender\":214,\"_relationship\":301,\"_race\":238,\"_ethnicity\":230}','{\"wu\":[],\"solr\":{\"content\":\"John\\nHodges\\nMike\\n2005-12-07T00:00:00Z\\n11\\n214\\n301\\n238\\n230\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T10:43:36Z\",\"users\":{\"24\":\"2297\"}}}'),(1293,'{\"_lastname\":\"Johnson\",\"_firstname\":\"Bill\",\"sys_data\":[]}','{\"full_address\":\"\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[24],\"solr\":{\"content\":\"Johnson\\nBill\\n\",\"lastname_s\":\"Johnson\",\"firstname_s\":\"Bill\",\"task_status\":2,\"task_u_all\":[\"24\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T10:44:27Z\",\"users\":{\"24\":\"2298\"}}}'),(1294,'{\"_lastname\":\"Johnson\",\"_firstname\":\"Bill\",\"sys_data\":[]}','{\"full_address\":\"\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[24],\"solr\":{\"content\":\"Johnson\\nBill\\n\",\"lastname_s\":\"Johnson\",\"firstname_s\":\"Bill\",\"comment_user_id\":24,\"comment_date\":\"2017-01-06T16:36:33Z\",\"task_status\":2,\"task_u_all\":[\"24\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"comment\",\"users\":{\"24\":\"2318\"},\"time\":\"2017-01-06T16:36:33Z\"},\"lastComment\":{\"user_id\":24,\"date\":\"2017-01-06T16:36:33Z\"}}'),(1295,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_anyoneloseclothing\":347,\"_usableclothing\":347,\"_coldweather\":348,\"_referralneeded\":686,\"_referralservice\":\"1263\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n347\\n347\\n348\\n686\\n1263\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:11:10Z\",\"users\":{\"24\":\"2300\"}}}'),(1296,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_assessmentOrder\":431,\"_employed\":{\"value\":347,\"childs\":{\"_hoursworked\":40,\"_employmenttenure\":424}},\"_additionalemployment\":348,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n431\\n347\\n40\\n424\\n348\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:20:54Z\",\"users\":{\"24\":\"2301\"}}}'),(1297,'{\"_incomereceived\":347,\"_noncashbenefits\":348,\"_incomeGroup\":390,\"_earnedIncome\":40000,\"_unemploymentinsurance\":0,\"_ssi\":0,\"_ssdi\":0,\"_veteransdisability\":0}','{\"wu\":[],\"solr\":{\"content\":\"347\\n348\\n390\\n348\\n40000\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:21:58Z\",\"users\":{\"24\":\"2302\"}}}'),(1298,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_enoughfood\":348,\"_predisasterassistance\":519,\"_requestedfood\":348,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1263\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n348\\n519\\n348\\n686\\n1263\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:23:17Z\",\"users\":{\"24\":\"2303\"}}}'),(1299,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_primarymode\":398,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n398\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:24:23Z\",\"users\":{\"24\":\"2304\"}}}'),(1300,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_priorlanguage\":348,\"_currentlyhavinglanguage\":348,\"_lostlanguageservices\":348}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n348\\n348\\n348\\n2017-01-06T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:25:26Z\",\"users\":{\"24\":\"2305\"}}}'),(1301,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_priorlanguage\":348,\"_currentlyhavinglanguage\":348,\"_lostlanguageservices\":348,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n348\\n348\\n348\\n2017-01-06T00:00:00Z\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:27:03Z\",\"users\":{\"24\":\"2306\"}}}'),(1302,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_childrenunder18\":{\"value\":347,\"childs\":{\"_fostercare\":348,\"_headstart\":348,\"_childcareneed\":348,\"_kidsinschool\":{\"value\":347,\"childs\":{\"_sameschoolpostdisaster\":347}},\"_missedimmunizations\":348,\"_copingconcerns\":348}},\"_childsupportpre\":348}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n347\\n348\\n348\\n348\\n348\\n347\\n347\\n348\\n348\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:32:23Z\",\"users\":{\"24\":\"2307\"}}}'),(1303,'{\"_assessmentdate\":\"2017-01-06T00:00:00Z\",\"_childrenunder18\":{\"value\":347,\"childs\":{\"_fostercare\":348,\"_headstart\":348,\"_childcareneed\":348,\"_kidsinschool\":{\"value\":347,\"childs\":{\"_sameschoolpostdisaster\":347}},\"_missedimmunizations\":348,\"_copingconcerns\":348}},\"_childsupportpre\":348,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n347\\n348\\n348\\n348\\n348\\n347\\n347\\n348\\n348\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:33:00Z\",\"users\":{\"24\":\"2308\"}}}'),(1304,'{\"_entrydate\":\"2016-10-24T04:00:00.000Z\",\"_regarding\":\"Health\",\"_notetype\":526,\"_casenote\":\"client''s in poor health\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-10-24T04:00:00.000Z\\nHealth\\n526\\nclient''s in poor health\\n\",\"notetype_i\":526},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T11:34:42Z\",\"users\":{\"24\":\"2309\"}}}'),(1305,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"200056\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"24\":\"2310\"},\"time\":\"2017-01-06T13:37:23Z\"}}'),(1306,'[]','{\"wu\":[],\"solr\":{\"content\":\"\",\"size\":\"138627\",\"versions\":0},\"lastAction\":{\"type\":\"file_upload\",\"users\":{\"24\":\"2311\"},\"time\":\"2017-01-06T13:37:24Z\"}}'),(1307,'{\"_name\":\"Will''s Auto Body\",\"_address\":\"123 Fake St. Mclean VA 22101\",\"_notes\":\"Ask for Bobbie, she will give you a good deal.\"}','{\"wu\":[],\"solr\":{\"content\":\"Will''s Auto Body\\n123 Fake St. Mclean VA 22101\\nAsk for Bobbie, she will give you a good deal.\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T15:32:33Z\",\"users\":{\"24\":\"2312\"}}}'),(1308,'{\"_title\":\"blah blah blah\"}','{\"wu\":[],\"solr\":{\"content\":\"blah blah blah\"}}'),(1309,'{\"_title\":\"Super thanks for asking\"}','{\"wu\":[],\"solr\":{\"content\":\"Super thanks for asking\"}}'),(1310,'{\"_referraldate\":\"2017-01-06T00:00:00Z\",\"_referralservice\":583,\"_provider\":[\"X\",\"X\"],\"_streetaddress\":\"555 fake st\",\"_zipcode\":22101,\"_city\":\"Mclean\",\"_state\":\"VA\",\"_referralstatus\":594,\"_comments\":\"What?!?!\",\"_associatedneed\":\"Not sure\",\"_vouchernumber\":1234,\"_voucheruom\":603,\"_voucherunits\":100,\"_unitvalue\":100,\"_vouchertotal\":85,\"_emailauthorized\":\"yes\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-06T00:00:00Z\\n583\\nX\\nX\\nX\\nX\\n555 fake st\\n22101\\nMclean\\nVA\\n594\\nWhat?!?!\\nNot sure\\n1234\\n603\\n100\\n100\\n85\\nyes\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-06T16:07:33Z\",\"users\":{\"24\":\"2315\"}}}'),(1311,'{\"_title\":\"Wanted to make sure they had enough food so I sent them to a food bank\"}','{\"wu\":[],\"solr\":{\"content\":\"Wanted to make sure they had enough food so I sent them to a food bank\"}}'),(1312,'{\"_title\":\"Talked to them on the phone and updated the notes for the referred serviecs\"}','{\"wu\":[],\"solr\":{\"content\":\"Talked to them on the phone and updated the notes for the referred serviecs\"}}'),(1313,'{\"_title\":\"They got everything they needed and are back to normal\"}','{\"wu\":[],\"solr\":{\"content\":\"They got everything they needed and are back to normal\"}}'),(1314,'{\"_lastname\":\"Test\",\"_firstname\":\"Test\",\"assessments_reported\":\"510,533,553,482,1120,455,505,559,489,440,656,1175,651,172\",\"_fematier\":1325,\"assigned\":\"23\",\"sys_data\":[],\"oid\":23}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_ongoing\":[23],\"task_status\":2,\"wu\":[1,23],\"solr\":{\"content\":\"Test\\nTest\\n510,533,553,482,1120,455,505,559,489,440,656,1175,651,172\\n1325\\n23\\n\",\"lastname_s\":\"Test\",\"firstname_s\":\"Test\",\"fematier_i\":1325,\"task_status\":2,\"assessments_reported\":[510,533,553,482,1120,455,505,559,489,440,656,1175,651,172],\"task_u_assignee\":[23],\"task_u_all\":[23,\"1\"],\"assessments_needed\":{\"0\":510,\"1\":533,\"2\":553,\"3\":482,\"4\":1120,\"5\":455,\"6\":505,\"7\":559,\"8\":489,\"9\":440,\"10\":656,\"12\":651,\"13\":172},\"assessments_completed\":{\"11\":1175},\"task_u_ongoing\":[23],\"cls\":\"\"},\"lastAction\":{\"type\":\"reopen\",\"users\":{\"1\":\"2794\"},\"time\":\"2017-01-13T18:59:22Z\"},\"referrals_needed\":[],\"assessments_completed\":{\"11\":1175},\"assessments_needed\":{\"0\":510,\"1\":533,\"2\":553,\"3\":482,\"4\":1120,\"5\":455,\"6\":505,\"7\":559,\"8\":489,\"9\":440,\"10\":656,\"12\":651,\"13\":172},\"full_address\":\"\",\"task_u_done\":[]}'),(1315,'{\"_title\":\"Client Intake\"}','{\"wu\":[],\"solr\":{\"content\":\"Client Intake\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2321\"},\"time\":\"2017-01-09T00:42:37Z\"}}'),(1316,'{\"_title\":\"Assessments\"}','{\"wu\":[],\"solr\":{\"content\":\"Assessments\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2322\"},\"time\":\"2017-01-09T00:42:37Z\"}}'),(1317,'{\"_title\":\"Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Referrals\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2323\"},\"time\":\"2017-01-09T00:42:37Z\"}}'),(1318,'{\"_title\":\"Recovery Plan\"}','{\"wu\":[],\"solr\":{\"content\":\"Recovery Plan\\n\"},\"lastAction\":{\"type\":\"copy\",\"users\":{\"1\":\"2324\"},\"time\":\"2017-01-09T00:42:37Z\"}}'),(1319,'{\"_title\":\"Responder\"}','{\"wu\":[],\"solr\":{\"content\":\"Responder\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2338\"},\"time\":\"2017-01-09T14:21:54Z\"}}'),(1320,'{\"_lastname\":\"Stoudt\",\"_firstname\":\"Dan\",\"assessments\":\"533,553\",\"sys_data\":[]}','{\"full_address\":\"\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[29],\"solr\":{\"content\":\"Stoudt\\nDan\\n533,553\\n\",\"lastname_s\":\"Stoudt\",\"firstname_s\":\"Dan\",\"task_status\":2,\"task_u_all\":[\"29\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-09T20:28:31Z\",\"users\":{\"29\":\"2341\"}}}'),(1321,'{\"_assessmentdate\":\"2017-01-09T00:00:00Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-09T00:00:00Z\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2343\"},\"time\":\"2017-01-09T21:03:57Z\"}}'),(1322,'{\"_title\":\"_atriskheader\",\"en\":\"Self-Reported Special\\/At-Risk Populations\",\"type\":\"H\",\"order\":18}','{\"wu\":[],\"solr\":{\"content\":\"_atriskheader\\nSelf-Reported Special\\/At-Risk Populations\\nH\\n18\\n\",\"order\":18},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T16:04:58Z\",\"users\":{\"1\":\"2364\"}}}'),(1323,'{\"_title\":\"_fematier\",\"en\":\"FEMA Tier\",\"type\":\"_objects\",\"order\":32,\"cfg\":\"{\\n\\\"scope\\\": 1324,\\n\\\"faceting\\\":true,\\n\\\"required\\\":true\\n}\",\"solr_column_name\":\"fematier_i\"}','{\"wu\":[],\"solr\":{\"content\":\"_fematier\\nFEMA Tier\\n_objects\\n32\\n{\\n\\\"scope\\\": 1324,\\n\\\"faceting\\\":true,\\n\\\"required\\\":true\\n}\\nfematier_i\\n\",\"order\":32},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2376\"},\"time\":\"2017-01-10T16:13:41Z\"}}'),(1324,'{\"en\":\"FEMATier\",\"visible\":\"Generic-1\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMATier\\nGeneric-1\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T16:12:04Z\",\"users\":{\"1\":\"2370\"}}}'),(1325,'{\"en\":\"Tier 1\",\"visible\":\"Generic-2\",\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Tier 1\\nGeneric-2\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T16:12:15Z\",\"users\":{\"1\":\"2371\"}}}'),(1326,'{\"en\":\"Tier 2\",\"visible\":\"Generic-3\",\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Tier 2\\nGeneric-3\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T16:12:22Z\",\"users\":{\"1\":\"2372\"}}}'),(1327,'{\"en\":\"Tier 3\",\"visible\":\"Generic-4\",\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Tier 3\\nGeneric-4\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T16:12:29Z\",\"users\":{\"1\":\"2373\"}}}'),(1328,'{\"en\":\"Tier 4\",\"visible\":\"Generic-5\",\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Tier 4\\nGeneric-5\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T16:12:36Z\",\"users\":{\"1\":\"2374\"}}}'),(1329,'{\"_lastname\":\"Test\",\"_firstname\":\"Test\",\"_birthdate\":\"2014-01-04T00:00:00Z\",\"_clientage\":3,\"_race\":235,\"_headofhousehold\":347,\"at_risk_population\":\"1497,1498\",\"identified_unmet_needs\":\"1511\",\"_fematier\":1325,\"assigned\":\"29\",\"sys_data\":[],\"oid\":29}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[29],\"task_status\":2,\"wu\":[1,29],\"solr\":{\"content\":\"Test\\nTest\\n2014-01-04T00:00:00Z\\n3\\n235\\n347\\n1497,1498\\n1511\\n1325\\n29\\n\",\"lastname_s\":\"Test\",\"firstname_s\":\"Test\",\"birthdate_dt\":\"2014-01-04T00:00:00Z\",\"clientage_i\":3,\"race_i\":235,\"headofhousehold_i\":347,\"fematier_i\":1325,\"task_status\":2,\"task_u_assignee\":[29],\"task_u_all\":[29,\"1\"],\"race\":\"Asian American\",\"headofhousehold\":\"Yes\",\"assessments_reported\":[510,533,651],\"assessments_needed\":{\"1\":533,\"2\":651},\"assessments_completed\":[510],\"referrals_needed\":[510],\"referrals_completed\":[\"1524\"],\"referrals_started\":[\"1523\"],\"task_u_ongoing\":[29],\"cls\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2908\"},\"time\":\"2017-01-18T15:19:42Z\"},\"assessments_completed\":[510],\"assessments_reported\":[510,533,651],\"assessments_needed\":{\"1\":533,\"2\":651},\"referrals_needed\":[510],\"referrals_started\":[\"1523\"],\"referrals_completed\":[\"1524\"],\"race\":\"Asian American\",\"headofhousehold\":\"Yes\",\"full_address\":\"\"}'),(1330,'{\"_name\":\"Childcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Childcare\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2389\"},\"time\":\"2017-01-10T20:58:23Z\"}}'),(1331,'{\"_name\":\"Child Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Child Services\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2480\"},\"time\":\"2017-01-11T14:39:14Z\"}}'),(1332,'{\"en\":\"ChildServices\"}','{\"wu\":[],\"solr\":{\"content\":\"ChildServices\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2412\"},\"time\":\"2017-01-10T21:20:04Z\"}}'),(1333,'{\"en\":\"Childcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Childcare\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2408\"},\"time\":\"2017-01-10T21:19:53Z\"}}'),(1334,'{\"en\":\"School District\"}','{\"wu\":[],\"solr\":{\"content\":\"School District\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2410\"},\"time\":\"2017-01-10T21:19:53Z\"}}'),(1335,'{\"en\":\"Head Start\\/ Early Head Start\"}','{\"wu\":[],\"solr\":{\"content\":\"Head Start\\/ Early Head Start\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2409\"},\"time\":\"2017-01-10T21:19:53Z\"}}'),(1336,'{\"en\":\"Social Services or Family Court for child support payment\"}','{\"wu\":[],\"solr\":{\"content\":\"Social Services or Family Court for child support payment\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2411\"},\"time\":\"2017-01-10T21:19:53Z\"}}'),(1337,'{\"_name\":\"Bob''s Burgers\"}','{\"wu\":[],\"solr\":{\"content\":\"Bob''s Burgers\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T20:58:38Z\",\"users\":{\"1\":\"2390\"}}}'),(1338,'{\"_name\":\"School District\"}','{\"wu\":[],\"solr\":{\"content\":\"School District\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T20:59:06Z\",\"users\":{\"1\":\"2391\"}}}'),(1339,'{\"_name\":\"Bob''s Burgers Childcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Bob''s Burgers Childcare\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2479\"},\"time\":\"2017-01-11T14:39:14Z\"}}'),(1340,'{\"en\":\"Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Services\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2396\"},\"time\":\"2017-01-10T21:10:38Z\"}}'),(1341,'{\"_title\":\"Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:10:28Z\",\"users\":{\"1\":\"2395\"}}}'),(1342,'{\"en\":\"Child Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Child Services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:11:17Z\",\"users\":{\"1\":\"2397\"}}}'),(1343,'{\"en\":\"School District\"}','{\"wu\":[],\"solr\":{\"content\":\"School District\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:11:36Z\",\"users\":{\"1\":\"2398\"}}}'),(1344,'{\"en\":\"Childcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Childcare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:11:46Z\",\"users\":{\"1\":\"2399\"}}}'),(1345,'{\"en\":\"Head Start \\/ Early Head Start\"}','{\"wu\":[],\"solr\":{\"content\":\"Head Start \\/ Early Head Start\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:12:00Z\",\"users\":{\"1\":\"2400\"}}}'),(1346,'{\"en\":\"Social Services or Family Court for Child Support Payment\"}','{\"wu\":[],\"solr\":{\"content\":\"Social Services or Family Court for Child Support Payment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:12:23Z\",\"users\":{\"1\":\"2401\"}}}'),(1347,'{\"en\":\"Referral to Child Care and referral Agency\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Child Care and referral Agency\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:12:38Z\",\"users\":{\"1\":\"2402\"}}}'),(1348,'{\"en\":\"Referral to Disaster Distress Helpline\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Disaster Distress Helpline\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:12:50Z\",\"users\":{\"1\":\"2403\"}}}'),(1349,'{\"en\":\"Referral to social services for TANF\\/ CCDF application\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to social services for TANF\\/ CCDF application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:14:53Z\",\"users\":{\"1\":\"2404\"}}}'),(1350,'{\"en\":\"Referral to VOAD\\/ community group for school supplies\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to VOAD\\/ community group for school supplies\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T21:15:04Z\",\"users\":{\"1\":\"2405\"}}}'),(1351,'{\"_assessmentdate\":\"2017-01-10T00:00:00Z\",\"_childrenunder18\":{\"value\":347,\"childs\":{\"_fostercare\":347}},\"_referralservice\":\"1344,1345,1347,1348,1349,1350,1343,1346\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-10T00:00:00Z\\n347\\n347\\n1344,1345,1347,1348,1349,1350,1343,1346\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2882\"},\"time\":\"2017-01-17T18:18:06Z\"}}'),(1352,'{\"_title\":\"_servicetype\",\"en\":\"Service Type\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":1341\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_servicetype\\nService Type\\n_objects\\n{\\n\\\"scope\\\":1341\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2445\"},\"time\":\"2017-01-11T13:57:11Z\"}}'),(1353,'{\"_title\":\"_servicesubtype\",\"en\":\"Referral Type\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":\\\"variable\\\"\\n,\\\"dependency\\\":{}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_servicesubtype\\nReferral Type\\n_objects\\n{\\n\\\"scope\\\":\\\"variable\\\"\\n,\\\"dependency\\\":{}\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2416\"},\"time\":\"2017-01-10T21:27:43Z\"}}'),(1354,'{\"_servicetype\":{\"value\":1342,\"childs\":{\"_servicesubtype\":1344}}}','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2481\"},\"time\":\"2017-01-11T14:39:14Z\"}}'),(1355,'{\"_title\":\"_service\",\"en\":\"Service\",\"type\":\"_objects\",\"cfg\":\"{\\n  \\\"source\\\": \\\"tree\\\"\\n  ,\\\"fq\\\": [\'country_id: 190\']  \\/\\/ that have a \\\"country_id\\\" = 190. (make sure such a SOLR field exist)\\n  ,\\\"templates\\\": [69]          \\/\\/ judge templateId=69\\n                              \\/\\/ (Contacts folder may contain objects based on other\\n                              \\/\\/ templates, i.e. not only \'judges\')\\n\\n  ,\\\"autoLoad\\\": true           \\/\\/ loading the list of judges when editor is shown\\n  ,\\\"renderer\\\": \\\"listObjIcons\\\" \\/\\/ visually display a list of nodes with the icon\\n                              \\/\\/ specified in template config\\n\\n  ,\\\"maxInstances\\\": 3          \\/\\/ allow up to 3 judges to be specified\\n  ,\\\"editor\\\": \\\"form\\\"           \\/\\/ shows a form with a list of judges\\n  ,\\\"dependency\\\": {\\n    \\\"pidValues\\\": [634]        \\/\\/ it means the `judges` field will appear only if\\n                              \\/\\/ the `org_type` field has value \'634\'\\n                              \\/\\/ 634 is the id of thesauri item meaning \'court\'\\n  }\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_service\\nService\\n_objects\\n{\\n  \\\"source\\\": \\\"tree\\\"\\n  ,\\\"fq\\\": [\'country_id: 190\']  \\/\\/ that have a \\\"country_id\\\" = 190. (make sure such a SOLR field exist)\\n  ,\\\"templates\\\": [69]          \\/\\/ judge templateId=69\\n                              \\/\\/ (Contacts folder may contain objects based on other\\n                              \\/\\/ templates, i.e. not only \'judges\')\\n\\n  ,\\\"autoLoad\\\": true           \\/\\/ loading the list of judges when editor is shown\\n  ,\\\"renderer\\\": \\\"listObjIcons\\\" \\/\\/ visually display a list of nodes with the icon\\n                              \\/\\/ specified in template config\\n\\n  ,\\\"maxInstances\\\": 3          \\/\\/ allow up to 3 judges to be specified\\n  ,\\\"editor\\\": \\\"form\\\"           \\/\\/ shows a form with a list of judges\\n  ,\\\"dependency\\\": {\\n    \\\"pidValues\\\": [634]        \\/\\/ it means the `judges` field will appear only if\\n                              \\/\\/ the `org_type` field has value \'634\'\\n                              \\/\\/ 634 is the id of thesauri item meaning \'court\'\\n  }\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2605\"},\"time\":\"2017-01-11T17:00:07Z\"}}'),(1356,'{\"_title\":\"_referraltype\",\"en\":\"Referral Type\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"scope\\\":668,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referraltype\\nReferral Type\\n_objects\\n1\\n{\\n\\\"scope\\\":668,\\n\\\"required\\\":true\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2670\"},\"time\":\"2017-01-11T20:32:16Z\"}}'),(1357,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":\\\"variable\\\"\\n,\\\"dependency\\\":{}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"scope\\\":\\\"variable\\\"\\n,\\\"dependency\\\":{}\\n}\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2620\"},\"time\":\"2017-01-11T18:28:11Z\"}}'),(1358,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"scope\\\":\\\"variable\\\"\\n,\\\"dependency\\\":{}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"scope\\\":\\\"variable\\\"\\n,\\\"dependency\\\":{}\\n}\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2619\"},\"time\":\"2017-01-11T18:28:00Z\"}}'),(1359,'{\"_title\":\"Child Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Child Services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-10T22:11:23Z\",\"users\":{\"1\":\"2425\"}}}'),(1360,'{\"_title\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"Test\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2458\"},\"time\":\"2017-01-11T14:20:59Z\"}}'),(1361,'{\"_title\":\"Housing Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Housing Referrals\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T01:33:03Z\",\"users\":{\"1\":\"2428\"}}}'),(1362,'[]','{\"wu\":[],\"solr\":{\"content\":\"\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2611\"},\"time\":\"2017-01-11T17:37:58Z\"}}'),(1363,'{\"_title\":\"Emergency Housing Mass Care Shelter\"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency Housing Mass Care Shelter\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2610\"},\"time\":\"2017-01-11T17:37:58Z\"}}'),(1364,'{\"_title\":\"Other Emergency Housing\"}','{\"wu\":[],\"solr\":{\"content\":\"Other Emergency Housing\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2613\"},\"time\":\"2017-01-11T17:37:58Z\"}}'),(1365,'{\"_title\":\"Assistance Housing Reservation (e.g.ARC)\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance Housing Reservation (e.g.ARC)\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2609\"},\"time\":\"2017-01-11T17:37:58Z\"}}'),(1366,'{\"_title\":\"Tarp \\/ Blue Roof\"}','{\"wu\":[],\"solr\":{\"content\":\"Tarp \\/ Blue Roof\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2608\"},\"time\":\"2017-01-11T17:37:58Z\"}}'),(1367,'{\"_title\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2612\"},\"time\":\"2017-01-11T17:37:58Z\"}}'),(1368,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1361\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n-2\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1361\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2568\"},\"time\":\"2017-01-11T16:11:35Z\"}}'),(1369,'{\"_name\":\"ARC\"}','{\"wu\":[],\"solr\":{\"content\":\"ARC\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T01:47:16Z\",\"users\":{\"1\":\"2441\"}}}'),(1370,'{\"_referralservice\":\"1366,1364,1362\"}','{\"wu\":[],\"solr\":{\"content\":\"1366,1364,1362\\n1366,1364,1362\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T01:48:36Z\",\"users\":{\"1\":\"2442\"}}}'),(1371,'{\"_title\":\"Behavioral Health Referrals\"}','{\"wu\":[],\"solr\":{\"content\":\"Behavioral Health Referrals\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T01:56:52Z\",\"users\":{\"1\":\"2443\"}}}'),(1372,'{\"_name\":\"Community clinical provider\",\"_providers\":[\"Tom Jones, 123 Fake Street\",\"Jenny Jones, 123 Test Street\"]}','{\"wu\":[],\"solr\":{\"content\":\"Community clinical provider\\nTom Jones, 123 Fake Street\\nJenny Jones, 123 Test Street\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2615\"},\"time\":\"2017-01-11T17:49:59Z\"}}'),(1373,'{\"_title\":\"FEMA Services\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T13:57:59Z\",\"users\":{\"1\":\"2446\"}}}'),(1374,'{\"_name\":\"Assist with appeal for SBA denial\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with appeal for SBA denial\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T13:59:26Z\",\"users\":{\"1\":\"2447\"}}}'),(1375,'{\"_name\":\"Assist with completion of FEMA IA Application\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with completion of FEMA IA Application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T13:59:57Z\",\"users\":{\"1\":\"2448\"}}}'),(1376,'{\"_name\":\"Assist with completion of FEMA ONA Application\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with completion of FEMA ONA Application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:00:24Z\",\"users\":{\"1\":\"2449\"}}}'),(1377,'{\"_name\":\"Assist with completion of SBA Loan Applications\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with completion of SBA Loan Applications\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:00:34Z\",\"users\":{\"1\":\"2450\"}}}'),(1378,'{\"_name\":\"Assist with FEMA IA denial\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with FEMA IA denial\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:00:43Z\",\"users\":{\"1\":\"2451\"}}}'),(1379,'{\"_name\":\"Assist with FEMA ONA denial\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with FEMA ONA denial\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:00:52Z\",\"users\":{\"1\":\"2452\"}}}'),(1380,'{\"_name\":\"Assist with FEMA\\/SBA Sequence of Delivery\"}','{\"wu\":[],\"solr\":{\"content\":\"Assist with FEMA\\/SBA Sequence of Delivery\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:01:04Z\",\"users\":{\"1\":\"2453\"}}}'),(1381,'{\"_name\":\"Obtain signed FEMA Disclosure release from client\"}','{\"wu\":[],\"solr\":{\"content\":\"Obtain signed FEMA Disclosure release from client\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:01:56Z\",\"users\":{\"1\":\"2454\"}}}'),(1382,'{\"_name\":\"Provide education regarding FEMA\\/SBA Sequence of Delivery\"}','{\"wu\":[],\"solr\":{\"content\":\"Provide education regarding FEMA\\/SBA Sequence of Delivery\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:02:32Z\",\"users\":{\"1\":\"2455\"}}}'),(1383,'{\"_name\":\"Submit inquiry to FEMA IA Branch re: client''s IA\"}','{\"wu\":[],\"solr\":{\"content\":\"Submit inquiry to FEMA IA Branch re: client''s IA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:02:45Z\",\"users\":{\"1\":\"2456\"}}}'),(1384,'{\"_name\":\"Submit inquiry to FEMA IA Branch: client''s ONA\"}','{\"wu\":[],\"solr\":{\"content\":\"Submit inquiry to FEMA IA Branch: client''s ONA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:02:53Z\",\"users\":{\"1\":\"2457\"}}}'),(1385,'{\"_name\":\"FEMA -Transitional Shelter Assistance (TSA)\"}','{\"wu\":[],\"solr\":{\"content\":\"FEMA -Transitional Shelter Assistance (TSA)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:23:57Z\",\"users\":{\"1\":\"2459\"}}}'),(1386,'{\"_name\":\"Emergency Housing Mass Care Shelter \"}','{\"wu\":[],\"solr\":{\"content\":\"Emergency Housing Mass Care Shelter \\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:24:08Z\",\"users\":{\"1\":\"2460\"}}}'),(1387,'{\"_name\":\"Other Emergency Housing \"}','{\"wu\":[],\"solr\":{\"content\":\"Other Emergency Housing \\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:24:23Z\",\"users\":{\"1\":\"2461\"}}}'),(1388,'{\"_name\":\"Assistance Housing Reservation (e.g.ARC)\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance Housing Reservation (e.g.ARC)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:24:33Z\",\"users\":{\"1\":\"2462\"}}}'),(1389,'{\"_name\":\"Tarp \\/ Blue Roof\"}','{\"wu\":[],\"solr\":{\"content\":\"Tarp \\/ Blue Roof\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:24:43Z\",\"users\":{\"1\":\"2463\"}}}'),(1390,'{\"_name\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:24:56Z\",\"users\":{\"1\":\"2464\"}}}'),(1391,'{\"_title\":\"Financial\"}','{\"wu\":[],\"solr\":{\"content\":\"Financial\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2466\"},\"time\":\"2017-01-11T14:29:05Z\"}}'),(1392,'{\"_title\":\"Transportation\"}','{\"wu\":[],\"solr\":{\"content\":\"Transportation\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:29:59Z\",\"users\":{\"1\":\"2467\"}}}'),(1393,'{\"_name\":\"Disaster Unemployment Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Disaster Unemployment Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:32:06Z\",\"users\":{\"1\":\"2468\"}}}'),(1394,'{\"_name\":\"Grant Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Grant Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:33:53Z\",\"users\":{\"1\":\"2469\"}}}'),(1395,'{\"_name\":\"Other\"}','{\"wu\":[],\"solr\":{\"content\":\"Other\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:33:58Z\",\"users\":{\"1\":\"2470\"}}}'),(1396,'{\"_title\":\"Employment\"}','{\"wu\":[],\"solr\":{\"content\":\"Employment\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:36:36Z\",\"users\":{\"1\":\"2471\"}}}'),(1397,'{\"_title\":\"Clothing\"}','{\"wu\":[],\"solr\":{\"content\":\"Clothing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:36:47Z\",\"users\":{\"1\":\"2472\"}}}'),(1398,'{\"_title\":\"Food\"}','{\"wu\":[],\"solr\":{\"content\":\"Food\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:36:59Z\",\"users\":{\"1\":\"2473\"}}}'),(1399,'{\"_title\":\"Health\"}','{\"wu\":[],\"solr\":{\"content\":\"Health\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:37:45Z\",\"users\":{\"1\":\"2474\"}}}'),(1400,'{\"_title\":\"Language\"}','{\"wu\":[],\"solr\":{\"content\":\"Language\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:37:59Z\",\"users\":{\"1\":\"2475\"}}}'),(1401,'{\"_title\":\"LegalServices\"}','{\"wu\":[],\"solr\":{\"content\":\"LegalServices\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:38:19Z\",\"users\":{\"1\":\"2476\"}}}'),(1402,'{\"_title\":\"Medical\"}','{\"wu\":[],\"solr\":{\"content\":\"Medical\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:38:43Z\",\"users\":{\"1\":\"2477\"}}}'),(1403,'{\"_title\":\"Senior Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Senior Services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:39:00Z\",\"users\":{\"1\":\"2478\"}}}'),(1404,'{\"_name\":\"Medication\"}','{\"wu\":[],\"solr\":{\"content\":\"Medication\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:52:45Z\",\"users\":{\"1\":\"2483\"}}}'),(1405,'{\"_name\":\"Durable Medical Equipment (e.g. wheelchair,cane)\"}','{\"wu\":[],\"solr\":{\"content\":\"Durable Medical Equipment (e.g. wheelchair,cane)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:53:00Z\",\"users\":{\"1\":\"2484\"}}}'),(1406,'{\"_name\":\"Clinic Referral\"}','{\"wu\":[],\"solr\":{\"content\":\"Clinic Referral\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T14:53:13Z\",\"users\":{\"1\":\"2485\"}}}'),(1407,'{\"_name\":\"Bus Pass\"}','{\"wu\":[],\"solr\":{\"content\":\"Bus Pass\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:08:13Z\",\"users\":{\"1\":\"2486\"}}}'),(1408,'{\"_name\":\"Bus Tokens\"}','{\"wu\":[],\"solr\":{\"content\":\"Bus Tokens\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:08:20Z\",\"users\":{\"1\":\"2487\"}}}'),(1409,'{\"_name\":\"Transportation\"}','{\"wu\":[],\"solr\":{\"content\":\"Transportation\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2492\"},\"time\":\"2017-01-11T15:12:17Z\"}}'),(1410,'{\"_name\":\"Crisis Counseling Program\"}','{\"wu\":[],\"solr\":{\"content\":\"Crisis Counseling Program\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:12:52Z\",\"users\":{\"1\":\"2493\"}}}'),(1411,'{\"_name\":\"Disaster Distress Helpline\"}','{\"wu\":[],\"solr\":{\"content\":\"Disaster Distress Helpline\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:13:05Z\",\"users\":{\"1\":\"2494\"}}}'),(1412,'{\"_name\":\"School District\"}','{\"wu\":[],\"solr\":{\"content\":\"School District\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:14:14Z\",\"users\":{\"1\":\"2495\"}}}'),(1413,'{\"_name\":\"Childcare\"}','{\"wu\":[],\"solr\":{\"content\":\"Childcare\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:14:22Z\",\"users\":{\"1\":\"2496\"}}}'),(1414,'{\"_name\":\"Head Start\\/ Early Head Start\"}','{\"wu\":[],\"solr\":{\"content\":\"Head Start\\/ Early Head Start\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:14:30Z\",\"users\":{\"1\":\"2497\"}}}'),(1415,'{\"_name\":\"Social Services or Family Court for child support payment \"}','{\"wu\":[],\"solr\":{\"content\":\"Social Services or Family Court for child support payment \\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:14:37Z\",\"users\":{\"1\":\"2498\"}}}'),(1416,'{\"_name\":\"Referral to Child Care and referral Agency\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Child Care and referral Agency\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:14:45Z\",\"users\":{\"1\":\"2499\"}}}'),(1417,'{\"_name\":\"Referral to Disaster Distress Helpline\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Disaster Distress Helpline\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:14:57Z\",\"users\":{\"1\":\"2500\"}}}'),(1418,'{\"_name\":\"Referral to social services for TANF\\/ CCDF application\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to social services for TANF\\/ CCDF application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:15:06Z\",\"users\":{\"1\":\"2501\"}}}'),(1419,'{\"_name\":\"Referral to VOAD\\/ community group for school supplies\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to VOAD\\/ community group for school supplies\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:15:17Z\",\"users\":{\"1\":\"2502\"}}}'),(1420,'{\"_name\":\"Assistance with D-SNAP application\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with D-SNAP application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:15:41Z\",\"users\":{\"1\":\"2503\"}}}'),(1421,'{\"_name\":\"Referral to community organizations for food needs\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to community organizations for food needs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:16:00Z\",\"users\":{\"1\":\"2504\"}}}'),(1422,'{\"_name\":\"Referral to mass care assistance  for immediate food needs\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to mass care assistance  for immediate food needs\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:16:14Z\",\"users\":{\"1\":\"2505\"}}}'),(1423,'{\"_name\":\"Referred to Senior Meals on Wheels Services\"}','{\"wu\":[],\"solr\":{\"content\":\"Referred to Senior Meals on Wheels Services\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:16:25Z\",\"users\":{\"1\":\"2506\"}}}'),(1424,'{\"_name\":\"Social Services for WIC\\/ SNAP\\/D-SNAP\"}','{\"wu\":[],\"solr\":{\"content\":\"Social Services for WIC\\/ SNAP\\/D-SNAP\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:16:35Z\",\"users\":{\"1\":\"2507\"}}}'),(1425,'{\"_name\":\"Assistance with FEMA ONA\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with FEMA ONA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:16:54Z\",\"users\":{\"1\":\"2508\"}}}'),(1426,'{\"_name\":\"Assistance with insurance claim\\/ appeal\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with insurance claim\\/ appeal\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:17:02Z\",\"users\":{\"1\":\"2509\"}}}'),(1427,'{\"_name\":\"Laundry Assistance\"}','{\"wu\":[],\"solr\":{\"content\":\"Laundry Assistance\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:17:08Z\",\"users\":{\"1\":\"2510\"}}}'),(1428,'{\"_name\":\"Referral to faith- based\\/ community organization for clothing\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to faith- based\\/ community organization for clothing\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:17:21Z\",\"users\":{\"1\":\"2511\"}}}'),(1429,'{\"_title\":\"Furniture And Appliances\"}','{\"wu\":[],\"solr\":{\"content\":\"Furniture And Appliances\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:25:10Z\",\"users\":{\"1\":\"2512\"}}}'),(1430,'{\"_name\":\"Assistance with FEMA ONA\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with FEMA ONA\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:25:17Z\",\"users\":{\"1\":\"2513\"}}}'),(1431,'{\"_name\":\"Assistance with install of new or removal of old\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with install of new or removal of old\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:25:26Z\",\"users\":{\"1\":\"2514\"}}}'),(1432,'{\"_name\":\"Assistance with insurance claim\\/ appeal\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with insurance claim\\/ appeal\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:25:33Z\",\"users\":{\"1\":\"2515\"}}}'),(1433,'{\"_name\":\"Referral to faith- based\\/ community organization for replacement\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to faith- based\\/ community organization for replacement\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:26:08Z\",\"users\":{\"1\":\"2516\"}}}'),(1434,'{\"_name\":\"Assistance with accessing VA benefits\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with accessing VA benefits\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:28:12Z\",\"users\":{\"1\":\"2517\"}}}'),(1435,'{\"_name\":\"Assistance with LIHEAP application\"}','{\"wu\":[],\"solr\":{\"content\":\"Assistance with LIHEAP application\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:28:23Z\",\"users\":{\"1\":\"2518\"}}}'),(1436,'{\"_name\":\"Home delivered meals (e.g., Meals on Wheels)\"}','{\"wu\":[],\"solr\":{\"content\":\"Home delivered meals (e.g., Meals on Wheels)\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:28:33Z\",\"users\":{\"1\":\"2519\"}}}'),(1437,'{\"_name\":\"Referral to Adult Day Health Care Center\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Adult Day Health Care Center\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:28:41Z\",\"users\":{\"1\":\"2520\"}}}'),(1438,'{\"_name\":\"Referral to area agency on aging\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to area agency on aging\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:28:53Z\",\"users\":{\"1\":\"2521\"}}}'),(1439,'{\"_name\":\"Referral to senior center\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to senior center\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2617\"},\"time\":\"2017-01-11T18:06:39Z\"}}'),(1440,'{\"_name\":\"Language resources\"}','{\"wu\":[],\"solr\":{\"content\":\"Language resources\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:29:20Z\",\"users\":{\"1\":\"2523\"}}}'),(1441,'{\"_name\":\"State language telephone line\"}','{\"wu\":[],\"solr\":{\"content\":\"State language telephone line\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:29:27Z\",\"users\":{\"1\":\"2524\"}}}'),(1442,'{\"_name\":\"Referral to Disaster Legal Services Program\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Disaster Legal Services Program\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:31:32Z\",\"users\":{\"1\":\"2525\"}}}'),(1443,'{\"_name\":\"Referral to Legal Aid\"}','{\"wu\":[],\"solr\":{\"content\":\"Referral to Legal Aid\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:31:43Z\",\"users\":{\"1\":\"2526\"}}}'),(1444,'{\"_name\":\"Other Legal Service \"}','{\"wu\":[],\"solr\":{\"content\":\"Other Legal Service \\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T15:32:01Z\",\"users\":{\"1\":\"2527\"}}}'),(1445,'{\"_title\":\"Health Insurance And Health Care Access\"}','{\"wu\":[],\"solr\":{\"content\":\"Health Insurance And Health Care Access\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2531\"},\"time\":\"2017-01-11T15:38:55Z\"}}'),(1446,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":100,\"cfg\":\"{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n100\\n{\\n\\\"scope\\\":685\\n,\\\"required\\\":true\\n}\\n\",\"order\":100},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2599\"},\"time\":\"2017-01-11T16:34:23Z\"}}'),(1447,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1373\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n1\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1373\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2596\"},\"time\":\"2017-01-11T16:30:04Z\"}}'),(1448,'{\"_title\":\"_referralneeded\",\"en\":\"Referral Needed?\",\"type\":\"_objects\",\"order\":-2,\"cfg\":\"{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralneeded\\nReferral Needed?\\n_objects\\n-2\\n{\\n\\\"scope\\\":685,\\n\\\"required\\\":true\\n}\\n\",\"order\":-2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2591\"},\"time\":\"2017-01-11T16:24:04Z\"}}'),(1449,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"order\":1,\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1399\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n1\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1399\\n}\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2592\"},\"time\":\"2017-01-11T16:25:04Z\"}}'),(1450,'{\"_title\":\"_referralservice\",\"en\":\"Referral Service\",\"type\":\"_objects\",\"cfg\":\"{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1401\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_referralservice\\nReferral Service\\n_objects\\n{\\n\\\"editor\\\": \\\"form\\\"\\n,\\\"source\\\": \\\"services\\\"\\n,\\\"renderer\\\": \\\"listObjIcons\\\"\\n,\\\"autoLoad\\\": true\\n,\\\"multiValued\\\": true\\n,\\\"hidePreview\\\": true\\n,\\\"scope\\\":1401\\n,\\\"dependency\\\": {\\n\\\"pidValues\\\": [686]\\n}\\n}\\n\"},\"lastAction\":{\"type\":\"move\",\"users\":{\"1\":\"2556\"},\"time\":\"2017-01-11T16:06:23Z\"}}'),(1451,'{\"_assessmentdate\":\"2017-01-11T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1430,1432\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-11T00:00:00Z\\n686\\n1430,1432\\n686\\n1430,1432\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T16:21:16Z\",\"users\":{\"1\":\"2590\"}}}'),(1452,'{\"_name\":\"Employment Placement Service\"}','{\"wu\":[],\"solr\":{\"content\":\"Employment Placement Service\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T16:38:57Z\",\"users\":{\"1\":\"2600\"}}}'),(1453,'{\"_name\":\"Job Hunting Resources\"}','{\"wu\":[],\"solr\":{\"content\":\"Job Hunting Resources\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2602\"},\"time\":\"2017-01-11T16:39:47Z\"}}'),(1454,'{\"_title\":\"_providers\",\"en\":\"Service Providers\",\"type\":\"varchar\",\"cfg\":\"{\\n\\\"maxInstances\\\":10\\n}\\n\"}','{\"wu\":[],\"solr\":{\"content\":\"_providers\\nService Providers\\nvarchar\\n{\\n\\\"maxInstances\\\":10\\n}\\n\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-11T17:49:15Z\",\"users\":{\"1\":\"2614\"}}}'),(1455,'{\"_referraltype\":{\"value\":1359,\"childs\":{\"_referralservice\":1413}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_referraldate\":\"2017-01-11T00:00:00Z\",\"_provider\":\"Test\",\"_streetaddress\":\"123 Test Street\",\"_city\":\"Test\",\"_state\":\"MD\",\"_zipcode\":23555,\"_appointmentdate\":\"2017-01-11T17:25:00.000Z\",\"_resultdate\":\"2017-01-11T00:00:00Z\",\"_result\":600}},\"_comments\":\"Not sure\"}','{\"wu\":[],\"solr\":{\"content\":\"1413\\n1359\\n2017-01-11T00:00:00Z\\nTest\\n594\\n123 Test Street\\nNot sure\\nTest\\nMD\\n23555\\n2017-01-11T17:25:00.000Z\\n2017-01-11T00:00:00Z\\n600\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2684\"},\"time\":\"2017-01-11T21:07:00Z\"}}'),(1456,'{\"_referraltype\":{\"value\":1371,\"childs\":{\"_referralservice\":1410}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_result\":599}}}','{\"wu\":[],\"solr\":{\"content\":\"1410\\n1371\\n594\\n599\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2750\"},\"time\":\"2017-01-12T17:39:01Z\"}}'),(1457,'{\"_referraltype\":{\"value\":1371,\"childs\":{\"_referralservice\":1372}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_referraldate\":\"2017-01-13T00:00:00Z\",\"_provider\":\"Test\",\"_streetaddress\":\"123 Test\",\"_result\":600}}}','{\"wu\":[],\"solr\":{\"content\":\"1372\\n1371\\n2017-01-13T00:00:00Z\\nTest\\n594\\n123 Test\\n600\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2799\"},\"time\":\"2017-01-13T19:37:53Z\"}}'),(1458,'{\"_referraltype\":{\"value\":1397,\"childs\":{\"_referralservice\":1425}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_referraldate\":\"2017-01-11T00:00:00Z\",\"_appointmentdate\":\"2017-01-11T05:00:00.000Z\",\"_resultdate\":\"2017-01-11T00:00:00Z\",\"_result\":599}}}','{\"wu\":[],\"solr\":{\"content\":\"1425\\n1397\\n2017-01-11T00:00:00Z\\n594\\n2017-01-11T05:00:00.000Z\\n2017-01-11T00:00:00Z\\n599\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2687\"},\"time\":\"2017-01-11T21:11:46Z\"}}'),(1459,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":99,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n99\\nassessmentnote_s\\n\",\"order\":99},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T01:13:57Z\",\"users\":{\"1\":\"2689\"}}}'),(1460,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":98,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n98\\nassessmentnote_s\\n\",\"order\":98},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2706\"},\"time\":\"2017-01-12T01:20:27Z\"}}'),(1461,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":97,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n97\\nassessmentnote_s\\n\",\"order\":97},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2707\"},\"time\":\"2017-01-12T01:20:43Z\"}}'),(1462,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":994,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n994\\nassessmentnote_s\\n\",\"order\":994},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2718\"},\"time\":\"2017-01-12T01:31:12Z\"}}'),(1463,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":979,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n979\\nassessmentnote_s\\n\",\"order\":979},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2719\"},\"time\":\"2017-01-12T01:32:21Z\"}}'),(1464,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":95,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n95\\nassessmentnote_s\\n\",\"order\":95},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2709\"},\"time\":\"2017-01-12T01:21:23Z\"}}'),(1465,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":91,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n91\\nassessmentnote_s\\n\",\"order\":91},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2710\"},\"time\":\"2017-01-12T01:21:43Z\"}}'),(1466,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":96,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n96\\nassessmentnote_s\\n\",\"order\":96},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2711\"},\"time\":\"2017-01-12T01:21:56Z\"}}'),(1467,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":93,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n93\\nassessmentnote_s\\n\",\"order\":93},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2712\"},\"time\":\"2017-01-12T01:22:12Z\"}}'),(1468,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":993,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n993\\nassessmentnote_s\\n\",\"order\":993},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2713\"},\"time\":\"2017-01-12T01:22:26Z\"}}'),(1469,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":92,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n92\\nassessmentnote_s\\n\",\"order\":92},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2714\"},\"time\":\"2017-01-12T01:22:38Z\"}}'),(1470,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":993,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n993\\nassessmentnote_s\\n\",\"order\":993},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2715\"},\"time\":\"2017-01-12T01:22:49Z\"}}'),(1471,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":99,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n99\\nassessmentnote_s\\n\",\"order\":99},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2702\"},\"time\":\"2017-01-12T01:16:08Z\"}}'),(1472,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":91,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n91\\nassessmentnote_s\\n\",\"order\":91},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2716\"},\"time\":\"2017-01-12T01:23:00Z\"}}'),(1473,'{\"_title\":\"_assessmentnote\",\"en\":\"Notes\",\"type\":\"text\",\"order\":92,\"solr_column_name\":\"assessmentnote_s\"}','{\"wu\":[],\"solr\":{\"content\":\"_assessmentnote\\nNotes\\ntext\\n92\\nassessmentnote_s\\n\",\"order\":92},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2717\"},\"time\":\"2017-01-12T01:23:16Z\"}}'),(1474,'{\"_assessmentdate\":\"2017-01-04T00:00:00Z\",\"_indistress\":347,\"_liketospeak\":347,\"_feelsafe\":347,\"_hurtingyourselfothers\":348,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1372\"}},\"_assessmentnote\":\"something\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-04T00:00:00Z\\n347\\n347\\n347\\n348\\n686\\n1372\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\nsomething\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T01:20:03Z\",\"users\":{\"1\":\"2705\"}}}'),(1475,'{\"_assessmentdate\":\"2017-01-11T00:00:00Z\",\"_incomereceived\":349,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1393\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-11T00:00:00Z\\n349\\n686\\n1393\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T02:01:54Z\",\"users\":{\"1\":\"2722\"}}}'),(1476,'{\"_firstname\":\"Tom\",\"_lastname\":\"Jones\",\"_middlename\":\"Test\",\"_birthdate\":\"1973-01-18T00:00:00Z\",\"_age\":43}','{\"wu\":[],\"solr\":{\"content\":\"Tom\\nJones\\nTest\\n1973-01-18T00:00:00Z\\n43\\n\",\"\":\"1973-01-18T00:00:00Z\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T02:40:57Z\",\"users\":{\"1\":\"2726\"}}}'),(1477,'{\"_title\":\"Test\",\"due_date\":\"2017-01-11T00:00:00Z\",\"due_time\":\"01:45:00\",\"assigned\":\"29,25\",\"importance\":56,\"description\":\"test\",\"sys_data\":[]}','{\"task_due_date\":\"2017-01-11T00:00:00Z\",\"task_due_time\":\"01:45:00\",\"task_allday\":false,\"task_u_done\":[],\"task_u_ongoing\":[29,25],\"task_status\":1,\"wu\":[1,29,25],\"solr\":{\"content\":\"Test\\n2017-01-11T00:00:00Z\\n01:45:00\\n29,25\\n56\\ntest\\n\",\"\":56,\"task_status\":1,\"task_u_assignee\":[29,25],\"task_u_all\":[29,25,\"1\"],\"task_u_ongoing\":[29,25],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T03:40:49Z\",\"users\":{\"1\":\"2743\"}}}'),(1478,'{\"_firstname\":\"Test\",\"_lastname\":\"Test\",\"_relationship\":303}','{\"wu\":[],\"solr\":{\"content\":\"Test\\nTest\\n303\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T15:25:13Z\",\"users\":{\"1\":\"2746\"}}}'),(1479,'{\"_title\":\"_familymembers\",\"en\":\"Family Members\",\"type\":\"varchar\",\"order\":3,\"cfg\":\"{\\n\\\"maxInstances\\\":40\\n}\"}','{\"wu\":[],\"solr\":{\"content\":\"_familymembers\\nFamily Members\\nvarchar\\n3\\n{\\n\\\"maxInstances\\\":40\\n}\\n\",\"order\":3},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2795\"},\"time\":\"2017-01-13T19:03:00Z\"}}'),(1480,'{\"_referraltype\":{\"value\":1359,\"childs\":{\"_referralservice\":1413}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_referraldate\":\"2017-01-12T00:00:00Z\",\"_result\":598}}}','{\"wu\":[],\"solr\":{\"content\":\"1413\\n1359\\n2017-01-12T00:00:00Z\\n594\\n598\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-12T17:37:26Z\",\"users\":{\"1\":\"2749\"}}}'),(1481,'{\"_entrydate\":\"2016-10-24T04:00:00.000Z\",\"_regarding\":\"Test\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-10-24T04:00:00.000Z\\nTest\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T15:41:02Z\",\"users\":{\"1\":\"2775\"}}}'),(1482,'{\"_lastname\":\"Sampson\",\"_firstname\":\"Jillian\",\"_middlename\":\"test\",\"_birthdate\":\"1956-01-20T00:00:00Z\",\"_clientage\":60,\"_gender\":215,\"_maritalstatus\":1036,\"_ethnicity\":230,\"_race\":234,\"_primarylanguage\":258,\"_emailaddress\":\"tjones@this.com\",\"_phonenumber\":\"123-445-4444\",\"_street\":\"123 Fake Street\",\"_city\":\"Test\",\"_state\":\"MD\",\"_zip\":23555,\"_headofhousehold\":347,\"_numberinhousehold\":4,\"at_risk_population\":\"1497,1498,1499,1500,1501,1502\",\"identified_unmet_needs\":\"1507,1511,1508\",\"_fematier\":1326,\"assigned\":\"29\",\"sys_data\":[],\"oid\":29}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"assessments_completed\":[510,533,553,482,656,651],\"assessments_needed\":[],\"task_u_ongoing\":[29],\"task_status\":2,\"wu\":[1,29],\"solr\":{\"content\":\"Sampson\\nJillian\\ntest\\n1956-01-20T00:00:00Z\\n60\\n215\\n1036\\n230\\n234\\n258\\ntjones@this.com\\n123-445-4444\\n123 Fake Street\\nTest\\nMD\\n23555\\n347\\n4\\n1497,1498,1499,1500,1501,1502\\n1507,1511,1508\\n1326\\n29\\n\",\"lastname_s\":\"Sampson\",\"firstname_s\":\"Jillian\",\"middlename_s\":\"test\",\"birthdate_dt\":\"1956-01-20T00:00:00Z\",\"clientage_i\":60,\"gender_i\":215,\"maritalstatus_i\":1036,\"ethnicity_i\":230,\"race_i\":234,\"primarylanguage_i\":258,\"emailaddress_s\":\"tjones@this.com\",\"phonenumber_s\":\"123-445-4444\",\"street_s\":\"123 Fake Street\",\"city_s\":\"Test\",\"state_s\":\"MD\",\"zip_s\":23555,\"headofhousehold_i\":347,\"fematier_i\":1326,\"comment_user_id\":1,\"comment_date\":\"2017-01-13T16:46:45Z\",\"task_status\":2,\"task_u_assignee\":[29],\"task_u_all\":[29,\"1\"],\"race\":\"American Indian Native or Alaska Native\",\"gender\":\"Female\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"123 Fake Street Test MD 23555\",\"assessments_reported\":[510,533,553,482,656,651],\"assessments_completed\":[510,533,553,482,656,651],\"referrals_needed\":[510,656,651],\"referrals_completed\":[\"1518\"],\"referrals_started\":[\"1520\",\"1521\"],\"task_u_ongoing\":[29],\"cls\":\"\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2910\"},\"time\":\"2017-01-18T20:02:00Z\"},\"referrals_needed\":[510,656,651],\"task_u_done\":[],\"lastComment\":{\"user_id\":1,\"date\":\"2017-01-13T16:46:45Z\"},\"assessments_reported\":[510,533,553,482,656,651],\"referrals_started\":[\"1520\",\"1521\"],\"referrals_completed\":[\"1518\"],\"race\":\"American Indian Native or Alaska Native\",\"gender\":\"Female\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"123 Fake Street Test MD 23555\"}'),(1483,'{\"_assessmentdate\":\"2017-01-13T00:00:00Z\",\"_indistress\":347,\"_liketospeak\":347,\"_feelsafe\":347,\"_hurtingyourselfothers\":347,\"_referralneeded\":686}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-13T00:00:00Z\\n347\\n347\\n347\\n347\\n686\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T16:04:57Z\",\"users\":{\"1\":\"2777\"}}}'),(1484,'{\"_assessmentdate\":\"2017-01-13T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1413,1414,1416,1417,1418,1419,1412,1415\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-13T00:00:00Z\\n686\\n1413,1414,1416,1417,1418,1419,1412,1415\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T16:05:22Z\",\"users\":{\"1\":\"2778\"}}}'),(1485,'{\"_assessmentdate\":\"2017-01-13T00:00:00Z\",\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-13T00:00:00Z\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T16:05:44Z\",\"users\":{\"1\":\"2779\"}}}'),(1486,'{\"_assessmentdate\":\"2017-01-13T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1452\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-13T00:00:00Z\\n686\\n1452\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T16:06:11Z\",\"users\":{\"1\":\"2780\"}}}'),(1487,'{\"_referraltype\":{\"value\":1371,\"childs\":{\"_referralservice\":1372}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_referraldate\":\"2017-01-13T00:00:00Z\"}}}','{\"wu\":[],\"solr\":{\"content\":\"1372\\n1371\\n2017-01-13T00:00:00Z\\n594\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T16:06:30Z\",\"users\":{\"1\":\"2781\"}}}'),(1488,'{\"_referraltype\":{\"value\":1359,\"childs\":{\"_referralservice\":1413}},\"_referralstatus\":595}','{\"wu\":[],\"solr\":{\"content\":\"1413\\n1359\\n595\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T16:06:46Z\",\"users\":{\"1\":\"2782\"}}}'),(1489,'{\"_title\":\"Awesome\"}','{\"wu\":[],\"solr\":{\"content\":\"Awesome\"}}'),(1490,'{\"_assessmentdate\":\"2017-01-13T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1372,1410,1411\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-13T00:00:00Z\\n686\\n1372,1410,1411\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2789\"},\"time\":\"2017-01-13T18:51:57Z\"}}'),(1491,'{\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1444,1442,1443\"}}}','{\"wu\":[],\"solr\":{\"content\":\"1444,1442,1443\\n686\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2791\"},\"time\":\"2017-01-13T18:53:02Z\"}}'),(1492,'{\"_firstname\":\"Simpson\",\"_lastname\":\"Joes\",\"_birthdate\":\"2017-01-13T00:00:00Z\",\"_age\":0,\"_relationship\":302}','{\"wu\":[],\"solr\":{\"content\":\"Simpson\\nJoes\\n2017-01-13T00:00:00Z\\n302\\n\",\"\":\"2017-01-13T00:00:00Z\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T19:04:49Z\",\"users\":{\"1\":\"2797\"}}}'),(1493,'{\"_assessmentdate\":\"2017-01-13T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1372,1410,1411\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-13T00:00:00Z\\n686\\n1372,1410,1411\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T19:37:28Z\",\"users\":{\"1\":\"2798\"}}}'),(1494,'{\"_entrydate\":\"2016-10-24T04:00:00.000Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-10-24T04:00:00.000Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T19:42:25Z\",\"users\":{\"1\":\"2800\"}}}'),(1495,'{\"_entrydate\":\"2016-10-24T04:00:00.000Z\"}','{\"wu\":[],\"solr\":{\"content\":\"2016-10-24T04:00:00.000Z\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-13T19:42:33Z\",\"users\":{\"1\":\"2801\"}}}'),(1496,'{\"en\":\"AtRiskPopulations\"}','{\"wu\":[],\"solr\":{\"content\":\"AtRiskPopulations\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2811\"},\"time\":\"2017-01-14T00:49:25Z\"}}'),(1497,'{\"en\":\"Children\",\"iconCls\":\"icon-assessment-child\",\"visible\":1,\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Children\\nicon-assessment-child\\n1\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2861\"},\"time\":\"2017-01-14T01:35:55Z\"}}'),(1498,'{\"en\":\"Elderly\",\"iconCls\":\"\\ticon-assessment-senior-services\",\"visible\":1,\"order\":2}','{\"wu\":[],\"solr\":{\"content\":\"Elderly\\n\\ticon-assessment-senior-services\\n1\\n2\\n\",\"order\":2},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2862\"},\"time\":\"2017-01-14T01:36:18Z\"}}'),(1499,'{\"en\":\"Individual Disabilities in the household\",\"iconCls\":\"icon-tag\",\"visible\":1,\"order\":3}','{\"wu\":[],\"solr\":{\"content\":\"Individual Disabilities in the household\\nicon-tag\\n1\\n3\\n\",\"order\":3},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2863\"},\"time\":\"2017-01-14T01:37:06Z\"}}'),(1500,'{\"en\":\"Domestic Violence Survivors\",\"iconCls\":\"icon-users\",\"visible\":1,\"order\":4}','{\"wu\":[],\"solr\":{\"content\":\"Domestic Violence Survivors\\nicon-users\\n1\\n4\\n\",\"order\":4},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2864\"},\"time\":\"2017-01-14T01:37:37Z\"}}'),(1501,'{\"en\":\"Individuals with Limited English Proficiency\",\"iconCls\":\"icon-assessment-language\",\"visible\":1,\"order\":5}','{\"wu\":[],\"solr\":{\"content\":\"Individuals with Limited English Proficiency\\nicon-assessment-language\\n1\\n5\\n\",\"order\":5},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2865\"},\"time\":\"2017-01-14T01:38:02Z\"}}'),(1502,'{\"en\":\"None Self-Reported\",\"iconCls\":\"icon-cross\",\"visible\":1,\"order\":33}','{\"wu\":[],\"solr\":{\"content\":\"None Self-Reported\\nicon-cross\\n1\\n33\\n\",\"order\":33},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2859\"},\"time\":\"2017-01-14T01:30:05Z\"}}'),(1503,'{\"en\":\"IdentifiedNeeds\"}','{\"wu\":[],\"solr\":{\"content\":\"IdentifiedNeeds\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-14T00:50:10Z\",\"users\":{\"1\":\"2813\"}}}'),(1504,'{\"en\":\"Food\",\"iconCls\":\"icon-assessment-food\",\"visible\":1,\"order\":1}','{\"wu\":[],\"solr\":{\"content\":\"Food\\nicon-assessment-food\\n1\\n1\\n\",\"order\":1},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2830\"},\"time\":\"2017-01-14T01:01:22Z\"}}'),(1505,'{\"en\":\"Legal\",\"iconCls\":\"icon-echr_decision\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Legal\\nicon-echr_decision\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2849\"},\"time\":\"2017-01-14T01:19:49Z\"}}'),(1506,'{\"en\":\"FEMA Help\",\"iconCls\":\"\\ticon-complaint-subjects\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"FEMA Help\\n\\ticon-complaint-subjects\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2850\"},\"time\":\"2017-01-14T01:20:14Z\"}}'),(1507,'{\"en\":\"Clothing\",\"iconCls\":\"icon-assessment-clothing\",\"visible\":\"Generic-5\"}','{\"wu\":[],\"solr\":{\"content\":\"Clothing\\nicon-assessment-clothing\\nGeneric-5\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2827\"},\"time\":\"2017-01-14T00:56:07Z\"}}'),(1508,'{\"en\":\"Employment\",\"iconCls\":\"icon-assessment-employment\",\"visible\":\"Generic-4\"}','{\"wu\":[],\"solr\":{\"content\":\"Employment\\nicon-assessment-employment\\nGeneric-4\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2826\"},\"time\":\"2017-01-14T00:55:19Z\"}}'),(1509,'{\"en\":\"None Identified\",\"iconCls\":\"icon-cross\",\"visible\":\"Generic-11\",\"order\":33}','{\"wu\":[],\"solr\":{\"content\":\"None Identified\\nicon-cross\\nGeneric-11\\n33\\n\",\"order\":33},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2848\"},\"time\":\"2017-01-14T01:19:17Z\"}}'),(1510,'{\"en\":\"Furniture and\\/or appliances\",\"iconCls\":\"icon-assessment-appliances\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Furniture and\\/or appliances\\nicon-assessment-appliances\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2851\"},\"time\":\"2017-01-14T01:21:16Z\"}}'),(1511,'{\"en\":\"Behavioral Health\",\"iconCls\":\"icon-assessment-behavioral\",\"visible\":\"Generic-9\"}','{\"wu\":[],\"solr\":{\"content\":\"Behavioral Health\\nicon-assessment-behavioral\\nGeneric-9\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2834\"},\"time\":\"2017-01-14T01:03:53Z\"}}'),(1512,'{\"en\":\"Health Insurance or Health Access\",\"iconCls\":\"icon-case_card\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Health Insurance or Health Access\\nicon-case_card\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2837\"},\"time\":\"2017-01-14T01:04:46Z\"}}'),(1513,'{\"en\":\"Transportation\",\"iconCls\":\"icon-assessment-transportation\",\"visible\":\"Generic-13\"}','{\"wu\":[],\"solr\":{\"content\":\"Transportation\\nicon-assessment-transportation\\nGeneric-13\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-14T01:05:30Z\",\"users\":{\"1\":\"2838\"}}}'),(1514,'{\"en\":\"Housing\",\"iconCls\":\"icon-object8\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Housing\\nicon-object8\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2852\"},\"time\":\"2017-01-14T01:22:08Z\"}}'),(1515,'{\"en\":\"Finances\",\"iconCls\":\"icon-echr_complaint\",\"visible\":1}','{\"wu\":[],\"solr\":{\"content\":\"Finances\\nicon-echr_complaint\\n1\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2853\"},\"time\":\"2017-01-14T01:22:35Z\"}}'),(1516,'{\"_title\":\"test\",\"importance\":57,\"sys_data\":[]}','{\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"task_u_ongoing\":[],\"task_status\":2,\"wu\":[1],\"solr\":{\"content\":\"test\\n57\\n\",\"\":57,\"task_status\":2,\"task_u_all\":[\"1\"],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-14T01:30:52Z\",\"users\":{\"1\":\"2860\"}}}'),(1517,'{\"en\":\"Not Started\"}','{\"wu\":[],\"solr\":{\"content\":\"Not Started\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"1\":\"2871\"},\"time\":\"2017-01-17T17:23:37Z\"}}'),(1518,'{\"_referraltype\":{\"value\":\"1400\",\"childs\":{\"_referralservice\":1440}},\"_referralstatus\":594,\"_comments\":\"I don''t know what to do here.\"}','{\"wu\":[],\"solr\":{\"content\":\"1440\\n1400\\n594\\nI don''t know what to do here.\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2877\"},\"time\":\"2017-01-17T18:15:59Z\"}}'),(1519,'{\"_assessmentdate\":\"2017-01-17T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1440\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-17T00:00:00Z\\n2017-01-17T00:00:00Z\\n686\\n1440\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-17T18:15:33Z\",\"users\":{\"1\":\"2875\"}}}'),(1520,'{\"_referralstatus\":1155,\"_referraltype\":{\"value\":\"1403\",\"childs\":{\"_referralservice\":1435}}}','{\"wu\":[],\"solr\":{\"content\":\"1435\\n1403\\n1155\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-17T18:16:24Z\",\"users\":{\"1\":\"2878\"}}}'),(1521,'{\"_referralstatus\":1155,\"_referraltype\":{\"value\":\"1403\",\"childs\":{\"_referralservice\":1436}}}','{\"wu\":[],\"solr\":{\"content\":\"1436\\n1403\\n1155\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-17T18:16:24Z\",\"users\":{\"1\":\"2879\"}}}'),(1522,'{\"_assessmentdate\":\"2017-01-17T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1435,1436\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-17T00:00:00Z\\n686\\n1435,1436\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-17T18:16:24Z\",\"users\":{\"1\":\"2880\"}}}'),(1523,'{\"_referralstatus\":1155,\"_referraltype\":{\"value\":\"1371\",\"childs\":{\"_referralservice\":1372}}}','{\"wu\":[],\"solr\":{\"content\":\"1372\\n1371\\n1155\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-17T18:18:34Z\",\"users\":{\"1\":\"2884\"}}}'),(1524,'{\"_referraltype\":{\"value\":\"1371\",\"childs\":{\"_referralservice\":1410}},\"_referralstatus\":594}','{\"wu\":[],\"solr\":{\"content\":\"1410\\n1371\\n594\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"1\":\"2887\"},\"time\":\"2017-01-17T18:18:46Z\"}}'),(1525,'{\"_assessmentdate\":\"2017-01-17T00:00:00Z\",\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1372,1410\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-17T00:00:00Z\\n686\\n1372,1410\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-17T18:18:34Z\",\"users\":{\"1\":\"2886\"}}}'),(1526,'{\"_lastname\":\"Sara\",\"_firstname\":\"Johnson\",\"_middlename\":\"Michelle\",\"_birthdate\":\"1970-10-18T00:00:00Z\",\"_clientage\":46,\"_gender\":215,\"_maritalstatus\":1037,\"_ethnicity\":230,\"_race\":238,\"_primarylanguage\":242,\"_emailaddress\":\"sj@gmail.test.com\",\"_phonenumber\":\"5555555555\",\"_street\":\"234 fake st.\",\"_city\":\"fake\",\"_state\":\"VA\",\"_zip\":22101,\"_headofhousehold\":347,\"_numberinhousehold\":3,\"at_risk_population\":\"1499,1497,1501\",\"identified_unmet_needs\":\"1511,1507,1504,1505,1513\",\"_fematier\":1327,\"assigned\":\"27\",\"sys_data\":[],\"oid\":27}','{\"race\":\"White\",\"gender\":\"Female\",\"maritalstatus\":\"Single\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"234 fake st. fake VA 22101\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"assessments_completed\":{\"0\":510,\"1\":533,\"2\":553,\"3\":505,\"6\":1175,\"7\":172,\"8\":656},\"assessments_reported\":[510,533,553,505,656,1175,172],\"assessments_needed\":[],\"task_u_ongoing\":[27],\"task_status\":2,\"wu\":[24,27],\"solr\":{\"content\":\"Sara\\nJohnson\\nMichelle\\n1970-10-18T00:00:00Z\\n46\\n215\\n1037\\n230\\n238\\n242\\nsj@gmail.test.com\\n5555555555\\n234 fake st.\\nfake\\nVA\\n22101\\n347\\n3\\n1499,1497,1501\\n1511,1507,1504,1505,1513\\n1327\\n27\\n\",\"lastname_s\":\"Sara\",\"firstname_s\":\"Johnson\",\"middlename_s\":\"Michelle\",\"birthdate_dt\":\"1970-10-18T00:00:00Z\",\"clientage_i\":46,\"gender_i\":215,\"maritalstatus_i\":1037,\"ethnicity_i\":230,\"race_i\":238,\"primarylanguage_i\":242,\"emailaddress_s\":\"sj@gmail.test.com\",\"phonenumber_s\":\"5555555555\",\"street_s\":\"234 fake st.\",\"city_s\":\"fake\",\"state_s\":\"VA\",\"zip_s\":22101,\"headofhousehold_i\":347,\"fematier_i\":1327,\"task_status\":2,\"task_u_assignee\":[27],\"task_u_all\":[27,\"24\"],\"race\":\"White\",\"gender\":\"Female\",\"maritalstatus\":\"Single\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"234 fake st. fake VA 22101\",\"assessments_reported\":[510,533,553,505,656,1175,172],\"assessments_completed\":{\"0\":510,\"1\":533,\"2\":553,\"3\":505,\"6\":1175,\"7\":172,\"8\":656},\"referrals_needed\":[510,533,505,172],\"referrals_completed\":[\"1539\"],\"referrals_started\":[\"1529\",\"1531\",\"1534\"],\"task_u_ongoing\":[27],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:08:07Z\",\"users\":{\"24\":\"2889\"}},\"referrals_needed\":[510,533,505,172],\"referrals_started\":[\"1529\",\"1531\",\"1534\"],\"referrals_completed\":[\"1539\"]}'),(1527,'{\"_firstname\":\"Rebecca\",\"_lastname\":\"Johnson\",\"_middlename\":\"Adair\",\"_birthdate\":\"1982-08-18T00:00:00Z\",\"_age\":34,\"_gender\":215,\"_relationship\":302,\"_ethnicity\":230}','{\"wu\":[],\"solr\":{\"content\":\"Rebecca\\nJohnson\\nAdair\\n1982-08-18T00:00:00Z\\n34\\n215\\n302\\n230\\n\",\"\":230},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:09:52Z\",\"users\":{\"24\":\"2890\"}}}'),(1528,'{\"_firstname\":\"Rebecca\",\"_lastname\":\"Johnson\",\"_middlename\":\"Adair\",\"_birthdate\":\"1982-08-18T00:00:00Z\",\"_age\":34,\"_gender\":215,\"_relationship\":302,\"_ethnicity\":230,\"_race\":238}','{\"wu\":[],\"solr\":{\"content\":\"Rebecca\\nJohnson\\nAdair\\n1982-08-18T00:00:00Z\\n34\\n215\\n302\\n230\\n238\\n\",\"\":238},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:12:05Z\",\"users\":{\"24\":\"2891\"}}}'),(1529,'{\"_referraltype\":{\"value\":\"1371\",\"childs\":{\"_referralservice\":1411}},\"_referralstatus\":1155,\"_comments\":\"need something\"}','{\"wu\":[],\"solr\":{\"content\":\"1411\\n1371\\n1155\\nneed something\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"24\":\"2896\"},\"time\":\"2017-01-18T14:15:18Z\"}}'),(1530,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_indistress\":348,\"_liketospeak\":348,\"_feelsafe\":347,\"_hurtingyourselfothers\":348,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1411\"}},\"_assessmentnote\":\"She just needs someone to talk to, in order to relieve stress\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n348\\n347\\n348\\n686\\n1411\\nShe just needs someone to talk to, in order to relieve stress\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:13:35Z\",\"users\":{\"24\":\"2893\"}}}'),(1531,'{\"_referralstatus\":1155,\"_referraltype\":{\"value\":\"1359\",\"childs\":{\"_referralservice\":1414}}}','{\"wu\":[],\"solr\":{\"content\":\"1414\\n1359\\n1155\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:14:30Z\",\"users\":{\"24\":\"2894\"}}}'),(1532,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_childrenunder18\":348,\"_childsupportpre\":348,\"_responsibleforchildsupoprt\":347,\"_paymentsdelayed\":348,\"_childsupportpost\":347,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1414\"}},\"_assessmentnote\":\"She was in head start previously, needs to continue\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n348\\n347\\n348\\n347\\n686\\n1414\\nShe was in head start previously, needs to continue\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:14:30Z\",\"users\":{\"24\":\"2895\"}}}'),(1533,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_anyoneloseclothing\":348,\"_usableclothing\":348,\"_coldweather\":348,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n348\\n348\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:15:50Z\",\"users\":{\"24\":\"2897\"}}}'),(1534,'{\"_referralstatus\":1155,\"_referraltype\":{\"value\":\"1398\",\"childs\":{\"_referralservice\":1422}}}','{\"wu\":[],\"solr\":{\"content\":\"1422\\n1398\\n1155\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:16:22Z\",\"users\":{\"24\":\"2898\"}}}'),(1535,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_enoughfood\":348,\"_predisasterassistance\":521,\"_requestedfood\":348,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1422\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n521\\n348\\n686\\n1422\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:16:23Z\",\"users\":{\"24\":\"2899\"}}}'),(1536,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_priorlanguage\":348,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n2017-01-18T00:00:00Z\\n687\\n\"},\"lastAction\":{\"type\":\"delete\",\"users\":{\"24\":\"2905\"},\"time\":\"2017-01-18T14:17:32Z\"}}'),(1537,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_priorlanguage\":348,\"_lostlanguageservices\":348,\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n348\\n2017-01-18T00:00:00Z\\n687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:16:50Z\",\"users\":{\"24\":\"2901\"}}}'),(1538,'{\"_referralneeded\":687}','{\"wu\":[],\"solr\":{\"content\":\"687\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:17:03Z\",\"users\":{\"24\":\"2902\"}}}'),(1539,'{\"_referraltype\":{\"value\":\"1392\",\"childs\":{\"_referralservice\":1407}},\"_referralstatus\":{\"value\":594,\"childs\":{\"_referraldate\":\"2017-01-18T00:00:00Z\"}},\"_comments\":\"Needs to get to work\"}','{\"wu\":[],\"solr\":{\"content\":\"1407\\n1392\\n2017-01-18T00:00:00Z\\n594\\nNeeds to get to work\\n\"},\"lastAction\":{\"type\":\"update\",\"users\":{\"24\":\"2914\"},\"time\":\"2017-01-18T20:36:22Z\"}}'),(1540,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_primarymode\":398,\"_referralneeded\":{\"value\":686,\"childs\":{\"_referralservice\":\"1409\"}}}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n398\\n686\\n1409\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:17:20Z\",\"users\":{\"24\":\"2904\"}}}'),(1541,'{\"_assessmentdate\":\"2017-01-18T00:00:00Z\",\"_priorlanguage\":348,\"_currentlyhavinglanguage\":348,\"_lostlanguageservices\":348,\"_referralneeded\":687,\"_assessmentnote\":\"kjjklnm\"}','{\"wu\":[],\"solr\":{\"content\":\"2017-01-18T00:00:00Z\\n348\\n348\\n348\\n2017-01-18T00:00:00Z\\n687\\nkjjklnm\\n\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T14:18:31Z\",\"users\":{\"24\":\"2906\"}}}'),(1542,'{\"_lastname\":\"tom\",\"_firstname\":\"jones\",\"_middlename\":\"test\",\"_birthdate\":\"2017-01-18T00:00:00Z\",\"_clientage\":0,\"_gender\":218,\"_maritalstatus\":1037,\"_ethnicity\":1136,\"_race\":1137,\"_primarylanguage\":251,\"_emailaddress\":\"test@this.com\",\"_phonenumber\":\"2355-55-555\",\"_street\":\"test\",\"_city\":\"test\",\"_state\":\"test\",\"_zip\":235325,\"_headofhousehold\":347,\"_numberinhousehold\":2,\"at_risk_population\":\"1497\",\"identified_unmet_needs\":\"1511,1507\",\"_fematier\":1325,\"assigned\":\"29\",\"sys_data\":[],\"oid\":29}','{\"race\":\"Chinese\",\"gender\":\"Don''t Know\",\"maritalstatus\":\"Single\",\"ethnicity\":\"Yes - Puerto Rican\",\"headofhousehold\":\"Yes\",\"full_address\":\"test test test 235325\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"assessments_completed\":[],\"assessments_reported\":[510,533,553],\"assessments_needed\":[510,533,553],\"task_u_ongoing\":[29],\"task_status\":2,\"wu\":[1,29],\"solr\":{\"content\":\"tom\\njones\\ntest\\n2017-01-18T00:00:00Z\\n218\\n1037\\n1136\\n1137\\n251\\ntest@this.com\\n2355-55-555\\ntest\\ntest\\ntest\\n235325\\n347\\n2\\n1497\\n1511,1507\\n1325\\n29\\n\",\"lastname_s\":\"tom\",\"firstname_s\":\"jones\",\"middlename_s\":\"test\",\"birthdate_dt\":\"2017-01-18T00:00:00Z\",\"gender_i\":218,\"maritalstatus_i\":1037,\"ethnicity_i\":1136,\"race_i\":1137,\"primarylanguage_i\":251,\"emailaddress_s\":\"test@this.com\",\"phonenumber_s\":\"2355-55-555\",\"street_s\":\"test\",\"city_s\":\"test\",\"state_s\":\"test\",\"zip_s\":235325,\"headofhousehold_i\":347,\"fematier_i\":1325,\"task_status\":2,\"task_u_assignee\":[29],\"task_u_all\":[29,\"1\"],\"race\":\"Chinese\",\"gender\":\"Don''t Know\",\"maritalstatus\":\"Single\",\"ethnicity\":\"Yes - Puerto Rican\",\"headofhousehold\":\"Yes\",\"full_address\":\"test test test 235325\",\"assessments_reported\":[510,533,553],\"assessments_needed\":[510,533,553],\"task_u_ongoing\":[29],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T20:01:06Z\",\"users\":{\"1\":\"2909\"}}}'),(1543,'{\"_lastname\":\"Smoot\",\"_firstname\":\"Catherine\",\"_middlename\":\"Ann\",\"_birthdate\":\"1984-09-18T00:00:00Z\",\"_clientage\":32,\"_gender\":214,\"_maritalstatus\":1036,\"_ethnicity\":230,\"_race\":238,\"_primarylanguage\":242,\"_emailaddress\":\"fake@fake.com\",\"_phonenumber\":\"5555555555\",\"_street\":\"555 fake st.\",\"_city\":\"fake\",\"_state\":\"va\",\"_zip\":20001,\"_headofhousehold\":347,\"_numberinhousehold\":5,\"at_risk_population\":\"1500,1498,1497\",\"identified_unmet_needs\":\"1507,1508,1515,1514,1505,1513\",\"_fematier\":1326,\"assigned\":\"29\",\"sys_data\":[],\"oid\":29}','{\"race\":\"White\",\"gender\":\"Male\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"555 fake st. fake va 20001\",\"task_due_date\":null,\"task_due_time\":null,\"task_allday\":true,\"task_u_done\":[],\"assessments_completed\":[],\"assessments_reported\":[533,553,482,455,440,1175,651,172],\"assessments_needed\":[533,553,482,455,440,1175,651,172],\"task_u_ongoing\":[29],\"task_status\":2,\"wu\":[24,29],\"solr\":{\"content\":\"Smoot\\nCatherine\\nAnn\\n1984-09-18T00:00:00Z\\n32\\n214\\n1036\\n230\\n238\\n242\\nfake@fake.com\\n5555555555\\n555 fake st.\\nfake\\nva\\n20001\\n347\\n5\\n1500,1498,1497\\n1507,1508,1515,1514,1505,1513\\n1326\\n29\\n\",\"lastname_s\":\"Smoot\",\"firstname_s\":\"Catherine\",\"middlename_s\":\"Ann\",\"birthdate_dt\":\"1984-09-18T00:00:00Z\",\"clientage_i\":32,\"gender_i\":214,\"maritalstatus_i\":1036,\"ethnicity_i\":230,\"race_i\":238,\"primarylanguage_i\":242,\"emailaddress_s\":\"fake@fake.com\",\"phonenumber_s\":\"5555555555\",\"street_s\":\"555 fake st.\",\"city_s\":\"fake\",\"state_s\":\"va\",\"zip_s\":20001,\"headofhousehold_i\":347,\"fematier_i\":1326,\"task_status\":2,\"task_u_assignee\":[29],\"task_u_all\":[29,\"24\"],\"race\":\"White\",\"gender\":\"Male\",\"maritalstatus\":\"Married\",\"ethnicity\":\"No\",\"headofhousehold\":\"Yes\",\"full_address\":\"555 fake st. fake va 20001\",\"assessments_reported\":[533,553,482,455,440,1175,651,172],\"assessments_needed\":[533,553,482,455,440,1175,651,172],\"task_u_ongoing\":[29],\"cls\":\"\"},\"lastAction\":{\"type\":\"create\",\"time\":\"2017-01-18T20:14:48Z\",\"users\":{\"24\":\"2912\"}}}');
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
  `type` enum('case','caseassessment','object','file','task','user','email','template','field','search','comment','shortcut','menu','config') DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1320 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (5,88,0,'object','folder','Folder','Folder','Folder','Folder',5,1,'icon-folder',NULL,'{\"createMethod\":\"inline\",\n  \"DC\": {\n    \"nid\": {},\n    \"name\": {},\n    \"oid\": {},\n    \"cid\": { \"title\": \"Entered By\"},\n    \"cdate\": { \"title\": \"Entered Date\"}\n  },\n  \"object_plugins\":\n      [\"comments\",\n       \"systemProperties\"\n      ]\n\n}','{name}',NULL),(6,88,0,'file','file_template','File','File','File','File',6,1,'fa fa-file fa-fl',NULL,NULL,'{name}',NULL),(7,88,0,'task','task','Task','Task','Task','Task',3,1,'icon-task',NULL,NULL,'{name}',NULL),(8,88,0,'object','Thesauri Item','Thesauri item','Thesauri item','Thesauri item','Thesauri item',0,1,'fa fa-sticky-note fa-fl',NULL,NULL,'{en}',NULL),(9,88,0,'comment','Comment',NULL,NULL,NULL,NULL,0,1,'fa fa-comment fa-fl',NULL,'{\n  \"systemType\": 2\n}',NULL,NULL),(10,88,0,'user','User','User',NULL,'Пользователь',NULL,1,1,'fa fa-user fa-fl',NULL,'{\"files\":\"1\",\"main_file\":\"1\"}',NULL,NULL),(11,88,0,'template','Template','Template','Template','Template','Template',0,1,'fa fa-file-code-o fa-fl',NULL,'{\n\"DC\": {\n  \"nid\": {},\n  \"name\": {},\n  \"type\": {},\n  \"cfg\": {},\n  \"order\": {\n     \"sortType\": \"asInt\"\n     ,\"solr_column_name\": \"order\"\n  }\n}\n}',NULL,NULL),(12,88,0,'field','Field','Field','Field','Field','Field',0,1,'fa fa-foursquare fa-fl',NULL,'[]',NULL,NULL),(58,88,0,'shortcut','shortcut','Shortcut',NULL,NULL,NULL,0,1,'fa fa-external-link-square  fa-fl',NULL,NULL,NULL,NULL),(61,59,0,'object','- Menu separator -','- Menu separator -',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(62,59,0,'menu','Menu rule','Menu rule',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(83,88,0,'object','link','Link',NULL,NULL,NULL,0,1,'fa fa-external-link fa-fl',NULL,NULL,'{url}',NULL),(91,89,0,'config','Config int option','Config int option',NULL,NULL,NULL,0,1,'fa fa-gear fa-fl',NULL,NULL,NULL,NULL),(94,89,0,'config','Config varchar option','Config varchar option',NULL,NULL,NULL,0,1,'fa fa-gear fa-fl',NULL,NULL,NULL,NULL),(97,89,0,'config','Config text option','Config text option',NULL,NULL,NULL,0,1,'fa fa-gear fa-fl',NULL,NULL,NULL,NULL),(100,89,0,'config','Config json option','Config json option',NULL,NULL,NULL,0,1,'fa fa-gears fa-fl',NULL,NULL,NULL,NULL),(141,140,0,'case','Client',NULL,NULL,NULL,NULL,0,1,'icon-case',NULL,'{\n\"DC\": {\n  \"nid\": {},\n  \"name\": {},\n  \"type\": {},\n  \"cfg\": {},\n  \"order\": {\n     \"sortType\": \"asInt\"\n     ,\"solr_column_name\": \"order\"\n  }\n}\n}','{_firstname}  {_lastname}',NULL),(172,140,0,'caseassessment','TransportationAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-transportation',NULL,'{\n\"leaf\":true\n}','Transportation Assessment',NULL),(205,3,0,'case','Case',NULL,NULL,NULL,NULL,0,0,'icon-briefcase',NULL,NULL,'{name}',NULL),(207,3,0,'object','Contact',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(289,140,0,'object','FamilyMember',NULL,NULL,NULL,NULL,0,1,'icon-object4',NULL,'{\n\"leaf\":true\n}','{_firstname} {_lastname} - {_relationship}',NULL),(311,140,0,'object','Address',NULL,NULL,NULL,NULL,0,1,'icon-object8',NULL,'{\n\"leaf\":true\n}','Address',NULL),(440,140,0,'caseassessment','HousingAssessment',NULL,NULL,NULL,NULL,0,1,'icon-object8',NULL,'{\n\"leaf\":true\n}','Housing Assessment',NULL),(455,140,0,'caseassessment','FinancialAssessment',NULL,NULL,NULL,NULL,0,1,'icon-echr_complaint',NULL,'{\n\"leaf\":true\n}','Financial Assessment',NULL),(467,140,0,'caseassessment','MonthlyExpensesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-echr_complaint',NULL,'{\n\"leaf\":true\n}','Monthly Expenses Assessment',NULL),(482,140,0,'caseassessment','EmploymentAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-employment',NULL,'{\n\"leaf\":true\n}','Employment Assessment',NULL),(489,140,0,'caseassessment','HealthAssessment',NULL,NULL,NULL,NULL,0,1,'icon-case_card',NULL,'{\n\"leaf\":true\n}','Health Assessment',NULL),(505,140,0,'caseassessment','FoodAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-food',NULL,'{\n\"leaf\":true\n}','Food Assessment',NULL),(510,140,0,'caseassessment','MedicalAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-behavioral',NULL,'{\n\"leaf\":true\n}','Behavioral Health Advocacy Assessment',NULL),(527,140,0,'object','CaseNote',NULL,NULL,NULL,NULL,0,1,'icon-committee-phase',NULL,'{\n    \"acceptChildren\": false\n    ,\"leaf\":true\n}','Case Note',NULL),(533,140,0,'caseassessment','ChildAssesment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-child',NULL,'{\n\"leaf\":true\n}','Children and Youth Assessment',NULL),(553,140,0,'caseassessment','ClothingAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-clothing',NULL,'{\n\"leaf\":true\n}','Clothing Assessment',NULL),(559,140,0,'caseassessment','FurnitureAndAppliancesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-appliances',NULL,'{\n\"leaf\":true\n}','Furniture and Appliances Assessment',NULL),(607,140,0,'caseassessment','Referral',NULL,NULL,NULL,NULL,0,1,'icon-arrow-right-medium',NULL,'{\n\"leaf\":true\n}','{_referraltype} [{_referralservice}] Referral - {_referralstatus} {_result}',NULL),(651,140,0,'caseassessment','SeniorServicesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-senior-services',NULL,'{\n\"leaf\":true\n}','Senior Services Assessment',NULL),(656,140,0,'caseassessment','LanguageAssessment',NULL,NULL,NULL,NULL,0,1,'icon-assessment-language',NULL,'{\n\"leaf\":true\n}','Language Assessment',NULL),(669,140,0,'object','Service',NULL,NULL,NULL,NULL,0,0,'icon-case_card',NULL,'{\n\"leaf\":false\n}','{_name}',NULL),(976,140,0,'object','ClientIntake',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,'Client Intake',NULL),(1120,140,0,'caseassessment','FEMAAssessment',NULL,NULL,NULL,NULL,0,1,'icon-complaint-subjects',NULL,'{\n\"leaf\":true\n}','FEMA Assistance',NULL),(1175,140,0,'caseassessment','LegalServicesAssessment',NULL,NULL,NULL,NULL,0,1,'icon-echr_decision',NULL,'{\n\"leaf\":true\n}','Legal Services Assessment',NULL),(1205,3,0,'object','FEMA Report',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(1319,3,0,NULL,'Responder',NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=1480 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates_structure`
--

LOCK TABLES `templates_structure` WRITE;
/*!40000 ALTER TABLE `templates_structure` DISABLE KEYS */;
INSERT INTO `templates_structure` VALUES (13,10,10,'f',0,'en','Full name (en)',NULL,NULL,NULL,'varchar',1,NULL,NULL),(14,10,10,'f',0,'initials','Initials','Initiales','Инициалы',NULL,'varchar',4,'[]',NULL),(15,10,10,'f',0,'sex','Sex','Sexe','Пол',NULL,'_sex',5,'{\"thesauriId\":\"90\"}',NULL),(16,10,10,'f',0,'position','Position','Titre','Должность',NULL,'_objects',7,'{\"source\":\"tree\",\"scope\":24340,\"oldThesauriId\":\"362\"}',NULL),(17,10,10,'f',0,'email','E-mail','E-mail','E-mail',NULL,'varchar',9,'{\"maxInstances\":\"3\"}',NULL),(18,10,10,'f',0,'language_id','Language','Langue','Язык',NULL,'_language',11,'[]',NULL),(19,10,10,'f',0,'short_date_format','Date format','Format de date','Формат даты',NULL,'_short_date_format',12,'[]',NULL),(20,10,10,'f',0,'description','Description','Description','Примечание',NULL,'varchar',13,'[]',NULL),(21,10,10,'f',0,'room','Room','Salle','Кабинет',NULL,'varchar',8,'[]',NULL),(22,10,10,'f',0,'phone','Phone','Téléphone','Телефон',NULL,'varchar',10,'{\"maxInstances\":\"10\"}',NULL),(23,10,10,'f',0,'location','Location','Emplacement','Расположение',NULL,'_objects',6,'{\"source\":\"tree\",\"scope\":24373,\"oldThesauriId\":\"394\"}',NULL),(24,6,6,'f',0,'program','Program','Program','Program','Program','_objects',1,'{\"source\":\"tree\",\"multiValued\":true,\"autoLoad\":true,\"editor\":\"form\",\"renderer\":\"listGreenIcons\",\"faceting\":true,\"scope\":24265,\"oldThesauriId\":\"715\"}',NULL),(25,12,12,NULL,0,'_title','Name','Name','Name','Name','varchar',NULL,'{\"showIn\":\"top\"}',NULL),(26,12,12,NULL,0,'type','Type','Type','Type','Type','_fieldTypesCombo',5,'[]',NULL),(27,12,12,NULL,0,'order','Order','Order','Order','Order','field',6,'{\n  \"indexed\": true\n}','order'),(28,12,12,NULL,0,'cfg','Config','Config','Config','Config','memo',7,'{\"height\":100}',NULL),(29,12,12,NULL,0,'solr_column_name','Solr column name','Solr column name','Solr column name','Solr column name','varchar',8,'[]',NULL),(30,12,12,NULL,0,'en','Title (en)','Title (en)','Title (en)','Title (en)','varchar',1,'[]',NULL),(31,11,11,NULL,0,'_title','Name','Name','Name','Name','varchar',NULL,'{\"showIn\":\"top\",\"rea-dOnly\":true}',NULL),(32,11,11,NULL,0,'type','Type','Type','Type','Type','_templateTypesCombo',5,'[]',NULL),(33,11,11,NULL,0,'visible','Active','Active','Active','Active','checkbox',6,'{\"showIn\":\"top\"}',NULL),(34,11,11,NULL,0,'iconCls','Icon class','Icon class','Icon class','Icon class','iconcombo',7,'[]',NULL),(35,11,11,NULL,0,'cfg','Config','Config','Config','Config','text',8,'{\"height\":100}',NULL),(36,11,11,NULL,0,'title_template','Title template','Title template','Title template','Title template','text',9,'{\"height\":50}',NULL),(37,11,11,NULL,0,'info_template','Info template','Info template','Info template','Info template','text',10,'{\"height\":50}',NULL),(38,11,11,NULL,0,'en','Title (en)','Title (en)','Title (en)','Title (en)','varchar',1,'[]',NULL),(39,8,8,NULL,0,'iconCls','Icon class',NULL,NULL,NULL,'iconcombo',5,NULL,NULL),(40,8,8,NULL,0,'visible','Visible',NULL,NULL,NULL,'checkbox',6,NULL,NULL),(41,8,8,NULL,0,'order','Order',NULL,NULL,NULL,'int',7,'{\n\"indexed\": true\n}','order'),(42,8,8,NULL,0,'en','Title',NULL,NULL,NULL,'varchar',0,'{\"showIn\":\"top\"}',NULL),(43,8,8,NULL,0,'ru','Title (ru)','Title (ru)','Title (ru)','Title (ru)','varchar',1,'{\"showIn\":\"top\"}',NULL),(44,7,7,NULL,0,'_title','Title',NULL,NULL,NULL,'varchar',1,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(45,7,7,NULL,0,'assigned','Assigned',NULL,NULL,NULL,'_objects',7,'{\n  \"editor\": \"form\"\n  ,\"source\": \"users\"\n  ,\"renderer\": \"listObjIcons\"\n  ,\"autoLoad\": true\n  ,\"multiValued\": true\n  ,\"hidePreview\": true\n}',NULL),(46,7,7,NULL,0,'importance','Importance',NULL,NULL,NULL,'_objects',8,'{\n  \"scope\": 53,\n  \"value\": 54,\n  \"faceting\": true\n}',NULL),(47,7,7,NULL,0,'description','Description',NULL,NULL,NULL,'memo',10,'{\n  \"height\": 100\n  ,\"noHeader\": true\n  ,\"hidePreview\": true\n  ,\"linkRenderer\": \"user,object,url\"\n}',NULL),(48,5,5,NULL,0,'_title','Name','Название',NULL,NULL,'varchar',1,NULL,NULL),(49,9,9,NULL,0,'_title','Text','Текст',NULL,NULL,'memo',0,'{\n\"height\": 100\n}','content'),(50,7,7,NULL,0,'due_date','Due date',NULL,NULL,NULL,'date',5,'{\n\"hidePreview\": true\n}',NULL),(51,7,7,NULL,0,'due_time','Due time',NULL,NULL,NULL,'time',6,'{\n\"hidePreview\": true\n}',NULL),(63,62,62,NULL,0,'_title','Title',NULL,NULL,NULL,'varchar',1,NULL,NULL),(64,62,62,NULL,0,'node_ids','Nodes',NULL,NULL,NULL,'_objects',2,'{\"multiValued\":true,\"editor\":\"form\",\"renderer\":\"listObjIcons\"}',NULL),(65,62,62,NULL,0,'template_ids','Templates',NULL,NULL,NULL,'_objects',3,'{\"templates\":\"11\",\"editor\":\"form\",\"multiValued\":true,\"renderer\":\"listObjIcons\"}',NULL),(66,62,62,NULL,0,'user_group_ids','Users/Groups',NULL,NULL,NULL,'_objects',4,'{\"source\":\"usersgroups\",\"multiValued\":true}',NULL),(67,62,62,NULL,0,'menu','Menu',NULL,NULL,NULL,'_objects',5,'{\"templates\":\"11\",\"multiValued\":true,\"editor\":\"form\",\"allowValueSort\":true,\"renderer\":\"listObjIcons\"}',NULL),(84,83,83,NULL,0,'type','Type',NULL,NULL,NULL,'_objects',1,'{\n\"scope\": 75 \n}',NULL),(85,83,83,NULL,0,'url','URL',NULL,NULL,NULL,'varchar',2,NULL,NULL),(86,83,83,NULL,0,'description','Description',NULL,NULL,NULL,'varchar',3,NULL,NULL),(87,83,83,NULL,0,'tags','Tags',NULL,NULL,NULL,'_objects',4,'{\n\"scope\": 82\n,\"editor\": \"tagField\"\n}',NULL),(92,91,91,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(93,91,91,NULL,0,'value','Value',NULL,NULL,NULL,'int',2,NULL,NULL),(95,94,94,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(96,94,94,NULL,0,'value','Value',NULL,NULL,NULL,'varchar',2,NULL,NULL),(98,97,97,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(99,97,97,NULL,0,'value','Value',NULL,NULL,NULL,'text',2,NULL,NULL),(101,100,100,NULL,0,'_title','Name',NULL,NULL,NULL,'varchar',1,NULL,NULL),(102,100,100,NULL,0,'value','Value',NULL,NULL,NULL,'field',2,'{\n\"editor\":\"ace\",\n\"format\":\"json\",\n\"validator\":\"json\"\n}',NULL),(103,100,100,NULL,0,'order','Order',NULL,NULL,NULL,'int',3,'{\"indexed\":true}','order'),(142,141,141,NULL,0,'_firstname',NULL,NULL,NULL,NULL,'field',2,'{\n\"required\": true\n,\"hidePreview\": true,\n\"faceting\":true\n}','firstname_s'),(143,141,141,NULL,0,'_lastname',NULL,NULL,NULL,NULL,'field',1,'{\n\"required\": true\n,\"hidePreview\": true,\n\"faceting\":true}','lastname_s'),(144,141,141,NULL,0,'_header',NULL,NULL,NULL,NULL,'field',0,NULL,NULL),(145,141,141,NULL,0,'_femacategory',NULL,NULL,NULL,NULL,'field',4,'{\n  \"scope\": 137,\n  \"value\": 138,\n  \"faceting\": true\n}',NULL),(206,205,205,NULL,0,'contacts',NULL,NULL,NULL,NULL,'field',NULL,'{\"source\":\"tree\",\"multiValued\":true}',NULL),(208,207,207,NULL,0,'FirstName',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(209,141,141,NULL,0,'_middlename',NULL,NULL,NULL,NULL,'field',3,'{\n\"faceting\":true\n}','middlename_s'),(210,141,141,NULL,0,'_birthdate',NULL,NULL,NULL,NULL,'field',4,'{ \n\"generateAge\": \"Client Age\" ,\n\"faceting\":true\n}','birthdate_dt'),(211,141,141,NULL,0,'_clientage',NULL,NULL,NULL,NULL,'field',5,'{\n\"faceting\":true\n}','clientage_i'),(212,141,141,NULL,0,'_gender',NULL,NULL,NULL,NULL,'field',6,'{\n\"scope\" : 167,\n\"faceting\":true\n}','gender_i'),(272,141,141,NULL,0,'_emailaddress',NULL,NULL,NULL,NULL,'field',11,'{\n\"faceting\":true\n}','emailaddress_s'),(274,141,141,NULL,0,'_ethnicity',NULL,NULL,NULL,NULL,'field',9,'{\n\"scope\" : 226,\n\"faceting\":true\n}','ethnicity_i'),(275,141,141,NULL,0,'_race',NULL,NULL,NULL,NULL,'field',10,'{\n\"scope\" : 227,\n\"faceting\":true\n}','race_i'),(276,141,141,NULL,0,'_primarylanguage',NULL,NULL,NULL,NULL,'field',10,'{\n\"scope\" : 228,\n\"faceting\":true\n}','primarylanguage_i'),(277,141,141,NULL,0,'languageassessment',NULL,NULL,NULL,NULL,'field',21,'{\n\"scope\": 346,\n\"faceting\":true\n}','limitedenglish_i'),(278,141,141,NULL,0,'_specialatrisk',NULL,NULL,NULL,NULL,'H',12,NULL,NULL),(279,141,141,NULL,0,'at_risk_population',NULL,NULL,NULL,NULL,'field',20,'{\n\"editor\": \"form\"\n,\"required\":true\n,\"source\": \"tree\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"fields\":\"title\"\n,\"scope\":1496\n,\"multiValued\": true\n,\"hidePreview\": false\n}',NULL),(280,141,141,NULL,0,'_domestic',NULL,NULL,NULL,NULL,'field',19,'{\n\"scope\": 346,\n\"faceting\":true\n}','domestic_i'),(290,289,289,NULL,0,'_firstname',NULL,NULL,NULL,NULL,'field',1,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(291,289,289,NULL,0,'_lastname',NULL,NULL,NULL,NULL,'field',2,'{\n\"required\": true\n,\"hidePreview\": true\n}',NULL),(292,289,289,NULL,0,'_birthdate',NULL,NULL,NULL,NULL,'field',4,'{ \n\"generateAge\": \"Age\" ,\n\"faceting\":true\n}',NULL),(293,289,289,NULL,0,'_age',NULL,NULL,NULL,NULL,'field',5,'	{ \n\"readOnly\": true\n}',NULL),(294,289,289,NULL,0,'_gender',NULL,NULL,NULL,NULL,'field',6,'{\n\"scope\" : 167\n}',NULL),(295,289,289,NULL,0,'_relationship',NULL,NULL,NULL,NULL,'field',7,'{\n\"scope\" : 299,\n\"required\":true\n}',NULL),(296,289,289,NULL,0,'_middlename',NULL,NULL,NULL,NULL,'varchar',3,NULL,NULL),(297,289,289,NULL,0,'_race',NULL,NULL,NULL,NULL,'field',9,'{\n\"scope\" : 227,\n\"faceting\":true\n}',NULL),(298,289,289,NULL,0,'_ethnicity',NULL,NULL,NULL,NULL,'field',8,'{\n\"scope\" : 226,\n\"faceting\":true\n}',NULL),(312,311,311,NULL,0,'_addresstype',NULL,NULL,NULL,NULL,'field',1,'{\n\"scope\" : 321\n}',NULL),(313,311,311,NULL,0,'_addressone',NULL,NULL,NULL,NULL,'field',2,'{\n\"faceting\":true\n}','addressone_s'),(314,311,311,NULL,0,'_addresstwo',NULL,NULL,NULL,NULL,'field',3,'{\n\"faceting\":true\n}','undefined'),(315,311,311,NULL,0,'_city',NULL,NULL,NULL,NULL,'field',4,'{\n\"faceting\":true\n}','city_s'),(316,311,311,NULL,0,'_state',NULL,NULL,NULL,NULL,'field',4,'{\n\"faceting\":true\n}','state_s'),(317,311,311,NULL,0,'_zip',NULL,NULL,NULL,NULL,'int',5,NULL,NULL),(318,311,311,NULL,0,'_begindate',NULL,NULL,NULL,NULL,'date',6,NULL,NULL),(319,311,311,NULL,0,'_enddate',NULL,NULL,NULL,NULL,'date',7,NULL,NULL),(320,311,311,NULL,0,'_primaryphone',NULL,NULL,NULL,NULL,'varchar',8,NULL,NULL),(432,172,172,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(433,172,172,NULL,0,'_primarymode',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 392\n}',NULL),(434,433,172,NULL,1,'_methodworking',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [393]\n   }\n}',NULL),(435,172,172,NULL,0,'_ifnotworking',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(436,434,172,NULL,2,'_insured',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(437,434,172,NULL,2,'_receivedpayment',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(438,434,172,NULL,2,'_damagedindisaster',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(439,434,172,NULL,2,'_transportationneeds',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 401\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(441,440,440,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(442,440,440,NULL,0,'_predisasterliving',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\":334\n}',NULL),(443,440,440,NULL,0,'_damagedhouse',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(444,443,440,NULL,1,'_inspectedhouse',NULL,NULL,NULL,NULL,'field',NULL,'{\n	\"scope\": 351\n	,\"dependency\": {\n		\"pidValues\": [347]\n	}\n}',NULL),(445,440,440,NULL,0,'_accessiblehouse',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(446,440,440,NULL,0,'_livablehouse',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(447,440,440,NULL,0,'_clientdamagerating',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 355\n}',NULL),(448,440,440,NULL,0,'_clientrelocated',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(449,448,440,NULL,1,'_planstoreturn',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n   	\"pidValues\": [347]\n    }\n}',NULL),(450,440,440,NULL,0,'_utilitieswork',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(451,450,440,NULL,1,'_utilitiesnotworking',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 362\n   ,\"dependency\": {\n      \"pidValues\": [348]\n   }\n}',NULL),(452,440,440,NULL,0,'_disasterImpacts',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(453,440,440,NULL,0,'_predisasterinsurance',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 372\n}',NULL),(454,440,440,NULL,0,'_insurancedetails',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(456,455,455,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(457,455,455,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(458,455,455,NULL,0,'_incomereceived',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(459,455,455,NULL,0,'_noncashbenefits',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(460,455,455,NULL,0,'_incomeGroup',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 389\n}',NULL),(461,455,455,NULL,0,'_noncashbenefits',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(462,455,455,NULL,0,'_earnedIncome',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(463,455,455,NULL,0,'_unemploymentinsurance',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(464,455,455,NULL,0,'_ssi',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(465,455,455,NULL,0,'_ssdi',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(466,455,455,NULL,0,'_veteransdisability',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(468,467,467,NULL,0,'_assessmentorder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(469,467,467,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(470,467,467,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(471,467,467,NULL,0,'_rent',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\" : \"Total monthly amount\" \n} ',NULL),(472,467,467,NULL,0,'_mortgage',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(473,467,467,NULL,0,'_maintenance',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(474,467,467,NULL,0,'_carpayment',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(475,467,467,NULL,0,'_carinsurance',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(476,467,467,NULL,0,'_gasoline',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(477,467,467,NULL,0,'_medical',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(478,467,467,NULL,0,'_food',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(479,467,467,NULL,0,'_miscellaneous',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(480,467,467,NULL,0,'_totalExpenses',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(481,467,467,NULL,0,'_totalmonthlyamount',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"readonly\":true\n}',NULL),(483,482,482,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(484,482,482,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(485,482,482,NULL,0,'_employed',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":346\n}',NULL),(486,485,482,NULL,1,'_hoursworked',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(487,485,482,NULL,1,'_employmenttenure',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 411\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(488,482,482,NULL,0,'_additionalemployment',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":346\n}',NULL),(490,489,489,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(491,489,489,NULL,0,'_insuranceType',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 416\n}',NULL),(492,489,489,NULL,0,'_isPrimary',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(493,489,489,NULL,0,'_medscovered',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(494,489,489,NULL,0,'_dmecovered',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(495,489,489,NULL,0,'_insurancestatus',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 501\n}',NULL),(496,489,489,NULL,0,'_insurancelostdisaster',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(497,489,489,NULL,0,'_whatcausedinsuranceloss',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(498,489,489,NULL,0,'_startdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(499,489,489,NULL,0,'_enddate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(500,489,489,NULL,0,'_appliedfordate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(506,505,505,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(507,505,505,NULL,0,'_enoughfood',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(508,505,505,NULL,0,'_predisasterassistance',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 516\n}',NULL),(509,505,505,NULL,0,'_requestedfood',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(511,510,510,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',1,NULL,NULL),(512,510,510,NULL,0,'_indistress',NULL,NULL,NULL,NULL,'field',2,'{\n\"scope\": 346\n}',NULL),(513,510,510,NULL,0,'_liketospeak',NULL,NULL,NULL,NULL,'field',3,'{\n\"scope\": 346\n}',NULL),(514,510,510,NULL,0,'_feelsafe',NULL,NULL,NULL,NULL,'field',4,'{\n\"scope\": 346\n}',NULL),(515,510,510,NULL,0,'_hurtingyourselfothers',NULL,NULL,NULL,NULL,'field',5,'{\n\"scope\": 346\n}',NULL),(528,527,527,NULL,0,'_entrydate',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"value\": \"2016-10-24\"\n}',NULL),(529,527,527,NULL,0,'_regarding',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(530,527,527,NULL,0,'_regarding',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(531,527,527,NULL,0,'_notetype',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 522,\n\"faceting\":true\n}','notetype_i'),(532,527,527,NULL,0,'_casenote',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(534,533,533,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(535,533,533,NULL,0,'_childrenunder18',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\": 346\n}',NULL),(536,533,533,NULL,0,'_fostercare',NULL,NULL,NULL,NULL,'_objects',NULL,NULL,NULL),(537,535,533,NULL,1,'_fostercare',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(538,535,533,NULL,1,'_headstart',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(539,538,533,NULL,1,'_servicesdisrupted',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(540,535,533,NULL,1,'_childcareneed',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(541,540,533,NULL,1,'_priorvoucher',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(542,540,533,NULL,2,'_barrierstochildcare',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(543,533,533,NULL,0,'_childsupportpre',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(544,533,533,NULL,0,'_responsibleforchildsupoprt',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(545,533,533,NULL,0,'_paymentsdelayed',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(546,533,533,NULL,0,'_childsupportpost',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(547,535,533,NULL,1,'_kidsinschool',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(548,547,533,NULL,1,'_sameschoolpostdisaster',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(549,547,533,NULL,1,'_needhelpregistering',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [348]\n   }\n}',NULL),(550,535,533,NULL,1,'_missedimmunizations',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(551,535,533,NULL,1,'_copingconcerns',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(552,551,533,NULL,1,'_copingexplanations',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(554,553,553,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(555,553,553,NULL,0,'_anyoneloseclothing',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(556,553,553,NULL,0,'_usableclothing',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(557,553,553,NULL,0,'_coldweather',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(558,555,553,NULL,1,'_makeclaim',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n	\"pidValues\": [347]\n   }\n}',NULL),(560,559,559,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(561,559,559,NULL,0,'_anythingdestroyed',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(562,561,559,NULL,1,'_refrigerator',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(563,561,559,NULL,1,'_stove',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(564,561,559,NULL,1,'_beds',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(565,564,559,NULL,1,'_numberofbeds',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(566,559,559,NULL,0,'_numberofbeds',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(567,561,559,NULL,1,'_claimforfurniture',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(568,561,559,NULL,1,'_replacementitemsreceived',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(569,561,559,NULL,1,'_abletoinstall',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(608,617,607,NULL,1,'_referraldate',NULL,NULL,NULL,NULL,'field',1,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(609,607,607,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":570\n}',NULL),(610,617,607,NULL,1,'_provider',NULL,NULL,NULL,NULL,'field',2,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(611,607,607,NULL,0,'_provider',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(612,617,607,NULL,1,'_streetaddress',NULL,NULL,NULL,NULL,'field',3,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(613,617,607,NULL,1,'_zipcode',NULL,NULL,NULL,NULL,'field',6,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(614,617,607,NULL,1,'_city',NULL,NULL,NULL,NULL,'field',4,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(615,617,607,NULL,1,'_state',NULL,NULL,NULL,NULL,'field',5,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(616,607,607,NULL,0,'_geocode',NULL,NULL,NULL,NULL,'geoPoint',NULL,NULL,NULL),(617,607,607,NULL,0,'_referralstatus',NULL,NULL,NULL,NULL,'field',2,'{\n\"scope\":593,\n\"required\":true\n}',NULL),(618,607,607,NULL,0,'_comments',NULL,NULL,NULL,NULL,'field',3,NULL,NULL),(619,607,607,NULL,0,'_associatedneed',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(620,607,607,NULL,0,'_voucherinformation',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(621,607,607,NULL,0,'_vouchernumber',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(622,607,607,NULL,0,'_voucheruom',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":602\n}',NULL),(623,607,607,NULL,0,'_voucherunits',NULL,NULL,NULL,NULL,'int',NULL,NULL,NULL),(624,607,607,NULL,0,'_unitvalue',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(625,607,607,NULL,0,'_vouchertotal',NULL,NULL,NULL,NULL,'float',NULL,NULL,NULL),(626,607,607,NULL,0,'_informationrelease',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(627,607,607,NULL,0,'_emailauthorized',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(628,607,607,NULL,0,'_referraloutcome',NULL,NULL,NULL,NULL,'H',NULL,NULL,NULL),(629,617,607,NULL,1,'_dateacknowledged',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(630,617,607,NULL,1,'_appointmentdate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(631,617,607,NULL,1,'_appointmentdate',NULL,NULL,NULL,NULL,'field',7,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(632,617,607,NULL,1,'_resultdate',NULL,NULL,NULL,NULL,'field',7,'{\n\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(633,617,607,NULL,1,'_result',NULL,NULL,NULL,NULL,'field',7,'{\n\"scope\":597\n,\"dependency\": {\n\"pidValues\": [594]\n}\n}',NULL),(634,141,141,NULL,0,'_fematier',NULL,NULL,NULL,NULL,'field',15,'{\n\"source\":\"tree\",\n\"scope\":137,\n\"faceting\":true\n}','fema_tier_i'),(643,141,141,NULL,0,'_clientstatus',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"source\":\"tree\",\n\"scope\": 644,\n\"faceting\":true\n}','client_status_i'),(652,651,651,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(653,651,651,NULL,0,'_priorseniorliving',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(654,653,651,NULL,1,'_clientdisplaced',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"scope\": 346\n   ,\"dependency\": {\n	\"pidValues\": [347]\n   }\n}',NULL),(655,654,651,NULL,2,'_explaincircumstances',NULL,NULL,NULL,NULL,'field',NULL,'{\n   \"dependency\": {\n	\"pidValues\": [347]\n   }\n}',NULL),(657,656,656,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(658,656,656,NULL,0,'New Field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(659,656,656,NULL,0,'_priorlanguage',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(660,656,656,NULL,0,'_currentlyhavinglanguage',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 346\n}',NULL),(661,656,656,NULL,0,'_lostlanguageservices',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":346\n}',NULL),(670,669,669,NULL,0,'_name',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(671,669,669,NULL,0,'_address',NULL,NULL,NULL,NULL,'varchar',NULL,NULL,NULL),(672,669,669,NULL,0,'_notes',NULL,NULL,NULL,NULL,'text',NULL,NULL,NULL),(683,533,533,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n,\"required\":true\n}',NULL),(684,683,533,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1359\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(703,141,141,NULL,0,'New Field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(718,607,607,NULL,0,'_name',NULL,NULL,NULL,NULL,'field',1,NULL,NULL),(722,311,311,NULL,0,'_latlon',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"faceting\":true\n}','latlon_s'),(845,510,510,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',6,'{\n\"scope\":685\n,\"required\":true\n}',NULL),(846,845,510,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',7,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1371\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(847,553,553,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n,\"required\":true\n}',NULL),(848,482,482,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n,\"required\":true\n}',NULL),(849,455,455,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(850,505,505,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n,\"required\":true\n}',NULL),(851,559,559,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(852,489,489,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":685\n}',NULL),(853,440,440,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(854,656,656,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(855,467,467,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685\n}',NULL),(856,651,651,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(857,172,172,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(858,847,553,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1397\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(859,848,482,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1396\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(860,455,455,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(861,850,505,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"dependency\": {\n\"pidValues\": [686]\n}\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1398\n}',NULL),(862,851,559,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"dependency\": {\n\"pidValues\": [686]\n}\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1429\n}',NULL),(863,853,440,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": false\n,\"hidePreview\": true\n,\"scope\":1361\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(864,854,656,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1400\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(865,467,467,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":668\n}',NULL),(866,856,651,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1403\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(867,857,172,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1392\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(870,651,651,NULL,0,'TestReferral',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n\"scope\":685\n}',NULL),(977,976,976,NULL,0,'_startdate',NULL,NULL,NULL,NULL,'datetime',NULL,NULL,NULL),(1032,141,141,NULL,0,'_street',NULL,NULL,NULL,NULL,'field',13,'{\n\"faceting\":true\n}','street_s'),(1033,141,141,NULL,0,'_maritalstatus',NULL,NULL,NULL,NULL,'field',7,'{\n\"scope\": 1035,\n\"faceting\":true\n}','maritalstatus_i'),(1034,141,141,NULL,0,'_headofhousehold',NULL,NULL,NULL,NULL,'field',17,'{\n\"scope\": 346,\n\"faceting\":true\n}','headofhousehold_i'),(1038,141,141,NULL,0,'_addresstitle',NULL,NULL,NULL,NULL,'field',12,NULL,NULL),(1039,141,141,NULL,0,'_city',NULL,NULL,NULL,NULL,'field',14,'{\n\"faceting\":true\n}','city_s'),(1040,141,141,NULL,0,'_state',NULL,NULL,NULL,NULL,'field',15,'{\n\"faceting\":true\n}','state_s'),(1093,141,141,NULL,0,'_zip',NULL,NULL,NULL,NULL,'field',16,'{\n\"faceting\":true\n}','zip_s'),(1094,141,141,NULL,0,'_selfreportedtitle',NULL,NULL,NULL,NULL,'field',17,NULL,NULL),(1095,141,141,NULL,0,'childassessment',NULL,NULL,NULL,NULL,'field',18,'{\n\"scope\": 346,\n\"faceting\":true\n}','childassessment_i'),(1096,141,141,NULL,0,'seniorservicesassessment',NULL,NULL,NULL,NULL,'field',19,'{\n\"scope\": 346,\n\"faceting\":true\n}',NULL),(1097,141,141,NULL,0,'employmentassessment',NULL,NULL,NULL,NULL,'field',23,'{\n\"scope\": 346,\n\"faceting\":true\n}','employment_i'),(1098,141,141,NULL,0,'financialassessment',NULL,NULL,NULL,NULL,'field',22,'{\n\"scope\": 346,\n\"faceting\":true\n}',NULL),(1099,141,141,NULL,0,'foodassessment',NULL,NULL,NULL,NULL,'field',23,'{\n\"scope\": 1151,\n\"faceting\":true\n}',NULL),(1100,141,141,NULL,0,'housingassessment',NULL,NULL,NULL,NULL,'field',24,'{\n\"scope\": 1151,\n\"faceting\":true\n}','housing_i'),(1101,141,141,NULL,0,'medicalassessment',NULL,NULL,NULL,NULL,'field',25,'{\n\"scope\": 1151,\n\"faceting\":true\n}','medical_i'),(1102,141,141,NULL,0,'transportationassessment',NULL,NULL,NULL,NULL,'field',25,'{\n\"scope\": 1151,\n\"faceting\":true\n}','transportationassessment_i'),(1113,141,141,NULL,0,'assigned',NULL,NULL,NULL,NULL,'field',33,'{\n\"editor\": \"form\"\n,\"required\": false\n,\"source\": \"users\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": false\n,\"hidePreview\": true\n}',NULL),(1114,141,141,NULL,0,'_assignedheader',NULL,NULL,NULL,NULL,'H',30,NULL,NULL),(1121,1120,1120,NULL,0,'_clienthavefemanumber',NULL,NULL,NULL,NULL,'_objects',1,'{\n\"scope\":346\n}',NULL),(1122,1121,1120,NULL,1,'_femanumber',NULL,NULL,NULL,NULL,'field',2,'{\n \"dependency\": {\n      \"pidValues\": [347]\n   }\n}',NULL),(1123,1120,1120,NULL,0,'_progressheader',NULL,NULL,NULL,NULL,'field',5,NULL,NULL),(1124,1120,1120,NULL,0,'_clientnotreceived',NULL,NULL,NULL,NULL,'field',3,'{\n\"scope\":346\n}',NULL),(1125,1120,1120,NULL,0,'_clientthrewaway',NULL,NULL,NULL,NULL,'field',4,'{\n\"scope\":346\n}',NULL),(1126,1120,1120,NULL,0,'_submittedsba',NULL,NULL,NULL,NULL,'_objects',6,'{\n\"scope\":346\n}',NULL),(1127,1120,1120,NULL,0,'_submittedsbadate',NULL,NULL,NULL,NULL,'field',7,NULL,NULL),(1128,1120,1120,NULL,0,'_clientapproved',NULL,NULL,NULL,NULL,'field',8,'{\n\"scope\":346\n}',NULL),(1129,1120,1120,NULL,0,'_clientapproveddate',NULL,NULL,NULL,NULL,'field',9,NULL,NULL),(1130,1120,1120,NULL,0,'_submittedclaim',NULL,NULL,NULL,NULL,'field',10,'{\n\"scope\":346\n}\n',NULL),(1131,1120,1120,NULL,0,'_submittedclaimdate',NULL,NULL,NULL,NULL,'field',11,NULL,NULL),(1132,1120,1120,NULL,0,'_clienthasreceivednoncomp',NULL,NULL,NULL,NULL,'field',12,'{\n\"scope\":346\n}',NULL),(1133,1120,1120,NULL,0,'_clienthasreceivednoncompdate',NULL,NULL,NULL,NULL,'field',13,NULL,NULL),(1148,279,141,NULL,1,'_specialneedscount',NULL,NULL,NULL,NULL,'field',20,'{\n   \"scope\": 346\n   ,\"dependency\": {\n      \"pidValues\": [347]\n   }\n}','specialneedscount_i'),(1149,141,141,NULL,0,'_numberinhousehold',NULL,NULL,NULL,NULL,'field',17,NULL,'numberinhousehold_i'),(1150,141,141,NULL,0,'_unmetneedsheader',NULL,NULL,NULL,NULL,'field',21,NULL,NULL),(1156,455,455,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(1157,455,467,NULL,0,'_assessmentOrder',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\": 429\n}',NULL),(1158,455,467,NULL,0,'_rent',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\" : \"Total monthly amount\" \n} ',NULL),(1159,455,467,NULL,0,'_mortgage',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1160,455,467,NULL,0,'_maintenance',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1161,455,467,NULL,0,'_carpayment',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1162,455,467,NULL,0,'_carinsurance',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1163,455,467,NULL,0,'_gasoline',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1164,455,467,NULL,0,'_medical',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1165,455,467,NULL,0,'_food',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1166,455,467,NULL,0,'_miscellaneous',NULL,NULL,NULL,NULL,'field',NULL,'{ \n\"totalValue\":\"Total monthly amount\" \n} ',NULL),(1167,455,467,NULL,0,'_totalExpenses',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(1168,455,467,NULL,0,'_totalmonthlyamount',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"readonly\":true\n}',NULL),(1169,455,455,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(1170,1169,455,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1391\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(1171,141,141,NULL,0,'clothingassessment',NULL,NULL,NULL,NULL,'_objects',23,'{\n\"scope\": 1151,\n\"faceting\":true\n}',NULL),(1172,141,141,NULL,0,'femaassessment',NULL,NULL,NULL,NULL,'field',25,'{\n\"scope\": 346,\n\"faceting\":true\n}',NULL),(1173,141,141,NULL,0,'furnitureandappliancesassessment',NULL,NULL,NULL,NULL,'field',25,'{\n\"scope\":1151,\n\"faceting\":true\n}',NULL),(1174,141,141,NULL,0,'legalservicesassessment',NULL,NULL,NULL,NULL,'_objects',25,'{\n\"scope\": 1151,\n\"faceting\":true\n}',NULL),(1176,1175,1175,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(1177,1120,1120,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',0,NULL,NULL),(1178,1175,656,NULL,0,'_assessmentdate',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(1189,1120,1120,NULL,0,'_iabenefit',NULL,NULL,NULL,NULL,'field',13,'{\n\"scope\":346\n}','iabenefit_i'),(1190,1120,1120,NULL,0,'_iabenefitdate',NULL,NULL,NULL,NULL,'field',14,NULL,NULL),(1191,1120,1120,NULL,0,'_maxgrant',NULL,NULL,NULL,NULL,'field',15,'{\n\"scope\":346\n}','maxgrant_i'),(1192,1120,1120,NULL,0,'_maxgrantdate',NULL,NULL,NULL,NULL,'field',16,NULL,NULL),(1193,1120,1120,NULL,0,'_otherneedsassistance',NULL,NULL,NULL,NULL,'field',17,'{\n\"scope\":346\n}','otherneedsassistance_i'),(1194,1120,1120,NULL,0,'_otherneedsassistancedate',NULL,NULL,NULL,NULL,'field',18,NULL,'otherneedsassistancedate_dt'),(1195,1120,1120,NULL,0,'_onareceived',NULL,NULL,NULL,NULL,'field',19,'{\n\"scope\":346\n}','onareceived_i'),(1196,1120,1120,NULL,0,'_onareceiveddate',NULL,NULL,NULL,NULL,'field',20,NULL,'onareceiveddate_dt'),(1197,1120,1120,NULL,0,'_onadenied',NULL,NULL,NULL,NULL,'field',21,'{\n\"scope\":346\n}','onadenied_i'),(1198,1120,1120,NULL,0,'_onadenieddate',NULL,NULL,NULL,NULL,'field',22,NULL,'onadenieddate_dt'),(1206,1205,1205,NULL,0,'Total Client Contact',NULL,NULL,NULL,NULL,'field',NULL,NULL,NULL),(1207,1205,1205,NULL,0,'ReportDate',NULL,NULL,NULL,NULL,'date',NULL,NULL,NULL),(1223,853,440,NULL,1,'referralrecoveryplan',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"dependency\": {\n\"pidValues\": [347]\n}\n}',NULL),(1264,141,141,NULL,0,'_phonenumber',NULL,NULL,NULL,NULL,'field',11,'{\n\"faceting\":true\n}','phonenumber_s'),(1272,141,141,NULL,0,'identified_unmet_needs',NULL,NULL,NULL,NULL,'field',31,'{\n\"editor\": \"form\"\n,\"required\":true\n,\"source\": \"tree\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"fields\":\"title\"\n,\"scope\":1503\n,\"multiValued\": true\n,\"hidePreview\": false\n}',NULL),(1322,141,141,NULL,0,'_atriskheader',NULL,NULL,NULL,NULL,'H',18,NULL,NULL),(1323,141,141,NULL,0,'_fematier',NULL,NULL,NULL,NULL,'field',32,'{\n\"scope\": 1324,\n\"faceting\":true,\n\"required\":true\n}','fematier_i'),(1352,669,669,NULL,0,'_servicetype',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":1341\n}',NULL),(1353,1352,669,NULL,1,'_servicesubtype',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":\"variable\"\n,\"dependency\":{}\n}',NULL),(1355,607,607,NULL,0,'_service',NULL,NULL,NULL,NULL,'_objects',NULL,'{\n  \"source\": \"tree\"\n  ,\"fq\": [\'country_id: 190\']  // that have a \"country_id\" = 190. (make sure such a SOLR field exist)\n  ,\"templates\": [69]          // judge templateId=69\n                              // (Contacts folder may contain objects based on other\n                              // templates, i.e. not only \'judges\')\n\n  ,\"autoLoad\": true           // loading the list of judges when editor is shown\n  ,\"renderer\": \"listObjIcons\" // visually display a list of nodes with the icon\n                              // specified in template config\n\n  ,\"maxInstances\": 3          // allow up to 3 judges to be specified\n  ,\"editor\": \"form\"           // shows a form with a list of judges\n  ,\"dependency\": {\n    \"pidValues\": [634]        // it means the `judges` field will appear only if\n                              // the `org_type` field has value \'634\'\n                              // 634 is the id of thesauri item meaning \'court\'\n  }\n}',NULL),(1356,607,607,NULL,0,'_referraltype',NULL,NULL,NULL,NULL,'field',1,'{\n\"scope\":668,\n\"required\":true\n}',NULL),(1357,1356,607,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":\"variable\"\n,\"dependency\":{}\n}',NULL),(1358,1357,607,NULL,2,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"scope\":\"variable\"\n,\"dependency\":{}\n}',NULL),(1368,440,440,NULL,0,'_referralservice',NULL,NULL,NULL,NULL,'field',0,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1361\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(1446,1120,1120,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',100,'{\n\"scope\":685\n,\"required\":true\n}',NULL),(1447,1446,1120,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',1,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1373\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(1448,489,489,NULL,0,'_referralneeded',NULL,NULL,NULL,NULL,'field',0,'{\n\"scope\":685,\n\"required\":true\n}',NULL),(1449,1448,489,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',1,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"dependency\": {\n\"pidValues\": [686]\n}\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1399\n}',NULL),(1450,1176,1175,NULL,1,'_referralservice',NULL,NULL,NULL,NULL,'field',NULL,'{\n\"editor\": \"form\"\n,\"source\": \"services\"\n,\"renderer\": \"listObjIcons\"\n,\"autoLoad\": true\n,\"multiValued\": true\n,\"hidePreview\": true\n,\"scope\":1401\n,\"dependency\": {\n\"pidValues\": [686]\n}\n}',NULL),(1454,669,669,NULL,0,'_providers',NULL,NULL,NULL,NULL,'varchar',NULL,'{\n\"maxInstances\":10\n}\n',NULL),(1459,510,510,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'text',99,NULL,'assessmentnote_s'),(1460,533,533,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',98,NULL,'assessmentnote_s'),(1461,553,553,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',97,NULL,'assessmentnote_s'),(1462,482,482,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',994,NULL,'assessmentnote_s'),(1463,1120,1120,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',979,NULL,'assessmentnote_s'),(1464,455,455,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',95,NULL,'assessmentnote_s'),(1465,505,505,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',91,NULL,'assessmentnote_s'),(1466,559,559,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',96,NULL,'assessmentnote_s'),(1467,489,489,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',93,NULL,'assessmentnote_s'),(1468,440,440,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',993,NULL,'assessmentnote_s'),(1469,656,656,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',92,NULL,'assessmentnote_s'),(1470,1175,1175,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',993,NULL,'assessmentnote_s'),(1471,607,510,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'text',99,NULL,'assessmentnote_s'),(1472,651,651,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',91,NULL,'assessmentnote_s'),(1473,172,172,NULL,0,'_assessmentnote',NULL,NULL,NULL,NULL,'field',92,NULL,'assessmentnote_s'),(1479,141,141,NULL,0,'_familymembers',NULL,NULL,NULL,NULL,'varchar',3,'{\n\"maxInstances\":40\n}',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=1544 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree`
--

LOCK TABLES `tree` WRITE;
/*!40000 ALTER TABLE `tree` DISABLE KEYS */;
INSERT INTO `tree` VALUES (1,NULL,NULL,1,1,0,NULL,5,NULL,NULL,'Tree',NULL,NULL,NULL,1,'[]',0,1,'2012-11-17 17:10:21',1,'2014-01-17 13:53:00',0,1,NULL,NULL,0),(2,1,NULL,0,1,0,NULL,5,NULL,NULL,'System',NULL,NULL,NULL,NULL,'[]',0,1,'2015-05-20 15:57:45',NULL,NULL,0,1,NULL,NULL,0),(3,2,NULL,0,NULL,0,NULL,5,NULL,NULL,'Templates',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:45',1,'2014-01-17 13:53:08',0,1,NULL,NULL,0),(4,2,NULL,0,4,0,NULL,5,NULL,NULL,'Thesauri Item','2013-09-24 19:38:09',NULL,NULL,NULL,'[]',1,256,'2013-09-24 19:38:09',1,'2016-10-03 14:14:04',0,256,NULL,NULL,0),(5,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',1,'2017-01-12 02:27:12',0,1,NULL,NULL,0),(6,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'file_template',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:48',1,'2016-06-09 13:50:28',0,1,NULL,NULL,0),(7,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'task',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',1,'2016-09-29 20:17:28',0,1,NULL,NULL,0),(8,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Thesauri Item',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2016-06-09 13:52:05',0,1,NULL,NULL,0),(9,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Comment',NULL,NULL,NULL,NULL,'null',1,1,'2014-02-12 21:14:04',1,'2016-06-09 13:52:26',0,1,NULL,NULL,0),(10,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'User',NULL,NULL,NULL,NULL,'{\"files\":\"1\",\"main_file\":\"1\"}',1,1,'2014-01-17 13:50:48',1,'2016-06-09 13:52:43',0,1,NULL,NULL,0),(11,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Template',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:45',1,'2016-06-09 13:56:21',0,1,NULL,NULL,0),(12,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'Field',NULL,NULL,NULL,NULL,'[]',1,1,'2014-01-17 13:50:45',1,'2016-06-09 13:53:18',0,1,NULL,NULL,0),(13,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',1,'2015-05-21 06:36:59',0,1,1,'2016-12-13 22:57:25',1),(14,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'initials',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(15,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'sex',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(16,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'position',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(17,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'email',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(18,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'language_id',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(19,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'short_date_format',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(20,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'description',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(21,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'room',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(22,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'phone',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(23,10,NULL,0,NULL,0,NULL,12,NULL,NULL,'location',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:48',NULL,NULL,0,1,1,'2016-12-13 22:57:25',1),(24,6,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:50',NULL,NULL,0,1,NULL,NULL,0),(25,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2014-01-21 11:24:06',0,1,NULL,NULL,0),(26,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'type',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(27,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'order',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2016-06-09 13:57:55',0,1,NULL,NULL,0),(28,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'cfg',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2014-02-28 16:12:37',0,1,NULL,NULL,0),(29,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'solr_column_name',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(30,12,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(31,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',1,'2014-02-12 21:12:31',0,1,NULL,NULL,0),(32,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'type',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(33,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'visible',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(34,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'iconCls',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(35,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'cfg',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(36,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'title_template',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(37,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'info_template',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(38,11,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 13:50:51',NULL,NULL,0,1,NULL,NULL,0),(39,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'iconCls',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:05:08',0,1,NULL,NULL,0),(40,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'visible',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:05:42',0,1,NULL,NULL,0),(41,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'order',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:05:57',0,1,NULL,NULL,0),(42,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'en',NULL,NULL,NULL,NULL,'{\"showIn\":\"top\"}',1,1,'2014-01-17 14:09:11',1,'2015-07-21 12:04:56',0,1,NULL,NULL,0),(43,8,NULL,0,NULL,0,NULL,12,NULL,NULL,'ru',NULL,NULL,NULL,NULL,'{\"showIn\":\"top\"}',1,1,'2014-01-17 14:09:11',NULL,NULL,0,1,1,'2015-05-21 12:20:51',1),(44,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 09:34:21',0,1,NULL,NULL,0),(45,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'assigned',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 10:32:02',0,1,NULL,NULL,0),(46,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'importance',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 12:26:19',0,1,NULL,NULL,0),(47,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'description',NULL,NULL,NULL,NULL,NULL,1,1,'2014-01-17 14:33:42',1,'2015-05-21 10:32:34',0,1,NULL,NULL,0),(48,5,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,'null',1,1,'2014-01-22 14:10:27',NULL,NULL,0,1,NULL,NULL,0),(49,9,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,'null',1,1,'2014-02-12 21:15:03',NULL,NULL,0,1,NULL,NULL,0),(50,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'due_date',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 10:30:34',NULL,NULL,0,1,NULL,NULL,0),(51,7,NULL,0,NULL,0,NULL,12,NULL,NULL,'due_time',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 10:31:04',NULL,NULL,0,1,NULL,NULL,0),(52,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'task',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:09:09',NULL,NULL,0,1,NULL,NULL,0),(53,52,NULL,0,NULL,0,NULL,5,NULL,NULL,'Importance',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:09:33',NULL,NULL,0,1,NULL,NULL,0),(54,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'Low',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:23:09',NULL,NULL,0,1,NULL,NULL,0),(55,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'Medium',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:24:01',NULL,NULL,0,1,NULL,NULL,0),(56,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'High',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:24:41',NULL,NULL,0,1,NULL,NULL,0),(57,53,NULL,0,NULL,0,NULL,8,NULL,NULL,'CRITICAL',NULL,NULL,NULL,NULL,'null',1,1,'2015-05-21 12:25:12',NULL,NULL,0,1,NULL,NULL,0),(58,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'shortcut',NULL,NULL,NULL,NULL,NULL,1,1,'2015-06-06 21:50:18',1,'2016-06-09 13:53:35',0,1,NULL,NULL,0),(59,88,NULL,0,NULL,0,NULL,5,NULL,NULL,'Menu',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(60,2,NULL,0,NULL,0,NULL,5,NULL,NULL,'Menus',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(61,59,NULL,0,NULL,0,NULL,11,NULL,NULL,'- Menu separator -',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(62,59,NULL,0,NULL,0,NULL,11,NULL,NULL,'Menu rule',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(63,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(64,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'node_ids',NULL,NULL,NULL,NULL,'{\"multiValued\":true,\"editor\":\"form\",\"renderer\":\"listObjIcons\"}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(65,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'template_ids',NULL,NULL,NULL,NULL,'{\"templates\":\"11\",\"editor\":\"form\",\"multiValued\":true,\"renderer\":\"listObjIcons\"}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(66,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'user_group_ids',NULL,NULL,NULL,NULL,'{\"source\":\"usersgroups\",\"multiValued\":true}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(67,62,NULL,0,NULL,0,NULL,12,NULL,NULL,'menu',NULL,NULL,NULL,NULL,'{\"templates\":\"11\",\"multiValued\":true,\"editor\":\"form\",\"allowValueSort\":true,\"renderer\":\"listObjIcons\"}',1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(68,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Global Menu',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',1,'2016-12-15 19:26:25',0,1,NULL,NULL,0),(69,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Templates',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(70,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Templates SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(71,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Fields',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(72,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'System Thesauri',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(73,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Create menu rules in this folder',NULL,NULL,NULL,NULL,NULL,1,1,'2015-07-24 07:45:11',NULL,NULL,0,1,NULL,NULL,0),(74,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'link',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:15:55',NULL,NULL,0,1,NULL,NULL,0),(75,74,NULL,0,NULL,0,NULL,5,NULL,NULL,'Type',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:16:07',NULL,NULL,0,1,NULL,NULL,0),(76,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Article',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:17:46',NULL,NULL,0,1,NULL,NULL,0),(77,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Document',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:18:06',NULL,NULL,0,1,NULL,NULL,0),(78,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Image',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:18:24',NULL,NULL,0,1,NULL,NULL,0),(79,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Sound',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:18:42',NULL,NULL,0,1,NULL,NULL,0),(80,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Video',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:19:03',NULL,NULL,0,1,NULL,NULL,0),(81,75,NULL,0,NULL,0,NULL,8,NULL,NULL,'Website',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:19:25',NULL,NULL,0,1,NULL,NULL,0),(82,74,NULL,0,NULL,0,NULL,5,NULL,NULL,'Tags',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:19:42',NULL,NULL,0,1,NULL,NULL,0),(83,88,NULL,0,NULL,0,NULL,11,NULL,NULL,'link',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:23:21',1,'2016-06-09 13:53:47',0,1,NULL,NULL,0),(84,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'type',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:25:21',NULL,NULL,0,1,NULL,NULL,0),(85,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'url',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:25:58',NULL,NULL,0,1,NULL,NULL,0),(86,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'description',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:26:29',NULL,NULL,0,1,NULL,NULL,0),(87,83,NULL,0,NULL,0,NULL,12,NULL,NULL,'tags',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-01 07:27:09',1,'2015-09-01 07:30:36',0,1,NULL,NULL,0),(88,3,NULL,0,NULL,0,NULL,5,NULL,NULL,'Built-in',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-02 13:45:52',NULL,NULL,0,1,NULL,NULL,0),(89,3,NULL,0,NULL,0,NULL,5,NULL,NULL,'Config',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(90,2,NULL,0,NULL,0,NULL,5,NULL,NULL,'Config',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(91,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config int option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:54:28',0,1,NULL,NULL,0),(92,91,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(93,91,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(94,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config varchar option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:54:40',0,1,NULL,NULL,0),(95,94,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(96,94,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(97,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config text option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:54:50',0,1,NULL,NULL,0),(98,97,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(99,97,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(100,89,NULL,0,NULL,0,NULL,11,NULL,NULL,'Config json option',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:55:06',0,1,NULL,NULL,0),(101,100,NULL,0,NULL,0,NULL,12,NULL,NULL,'_title',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(102,100,NULL,0,NULL,0,NULL,12,NULL,NULL,'value',NULL,NULL,NULL,NULL,'{\"editor\":\"ace\",\"format\":\"json\",\"validator\":\"json\"}',1,1,'2015-09-09 12:58:27',1,'2016-04-29 08:00:26',0,1,NULL,NULL,0),(103,100,NULL,0,NULL,0,NULL,12,NULL,NULL,'order',NULL,NULL,NULL,NULL,'{\"indexed\":true}',1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(104,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'project_name_en',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-08-08 00:34:11',0,1,NULL,NULL,0),(105,90,NULL,0,NULL,0,NULL,97,NULL,NULL,'templateIcons',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2016-06-09 13:48:37',0,1,NULL,NULL,0),(106,90,NULL,0,NULL,0,NULL,97,NULL,NULL,'folder_templates',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(107,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'default_folder_template',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(108,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'default_file_template',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(109,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'default_task_template',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(110,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'default_language',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(111,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'languages',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(112,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'object_type_plugins',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(113,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'treeNodes',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(114,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'Tasks',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(115,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'Dbnode',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(116,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'RecycleBin',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',1,'2015-11-25 13:52:47',0,1,NULL,NULL,0),(117,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Create config options rule',NULL,NULL,NULL,NULL,NULL,1,1,'2015-09-09 12:58:27',NULL,NULL,0,1,NULL,NULL,0),(118,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'files',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:53:55',NULL,NULL,0,1,NULL,NULL,0),(119,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'timezone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:55:28',NULL,NULL,0,1,NULL,NULL,0),(120,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'language_en',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:56:08',NULL,NULL,0,1,NULL,NULL,0),(121,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'language_fr',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:56:40',NULL,NULL,0,1,NULL,NULL,0),(122,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'language_ru',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:57:06',NULL,NULL,0,1,NULL,NULL,0),(123,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'default_facet_configs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 07:59:21',1,'2017-01-04 15:46:51',0,1,NULL,NULL,0),(124,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'node_facets',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:01:22',1,'2017-01-04 20:16:31',0,1,NULL,NULL,0),(125,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'default_object_plugins',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:04:38',1,'2016-04-29 08:15:53',0,1,NULL,NULL,0),(126,90,NULL,0,NULL,0,NULL,91,NULL,NULL,'images_display_size',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:11:54',NULL,NULL,0,1,NULL,NULL,0),(127,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'default_DC',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:12:21',1,'2016-10-21 16:03:08',0,1,NULL,NULL,0),(128,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'default_availableViews',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:14:13',1,'2016-12-27 17:23:53',0,1,NULL,NULL,0),(129,90,NULL,0,NULL,0,NULL,100,NULL,NULL,'DCConfigs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:17:58',NULL,NULL,0,1,NULL,NULL,0),(130,129,NULL,0,NULL,0,NULL,100,NULL,NULL,'dc_tasks',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:18:25',NULL,NULL,0,1,NULL,NULL,0),(131,129,NULL,0,NULL,0,NULL,100,NULL,NULL,'dc_tasks_closed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:20:58',NULL,NULL,0,1,NULL,NULL,0),(132,90,NULL,0,NULL,0,NULL,94,NULL,NULL,'geoMapping',NULL,NULL,NULL,NULL,NULL,1,1,'2016-04-29 08:22:54',1,'2016-08-08 00:34:42',0,1,NULL,NULL,0),(134,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:39:37',NULL,NULL,0,1,1,'2016-12-08 17:47:48',1),(135,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:39:50',NULL,NULL,0,1,1,'2016-12-08 17:47:51',1),(136,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:40:05',1,'2016-09-29 15:47:22',0,1,NULL,NULL,0),(137,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'FEMA Tier',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:40:35',1,'2016-10-03 19:17:18',0,1,1,'2016-12-06 17:07:06',1),(138,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 3: Significant Unmet Needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:41:56',1,'2016-10-03 19:19:31',0,1,1,'2016-12-06 17:07:06',2),(139,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 4: Immediate and Long-Term Unmet Needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:42:15',1,'2016-10-03 19:20:01',0,1,1,'2016-12-06 17:07:06',2),(140,3,NULL,0,NULL,0,NULL,5,NULL,NULL,'Custom',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:44:19',1,'2016-08-08 00:44:41',0,1,NULL,NULL,0),(141,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Client',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:45:29',1,'2017-01-09 01:10:44',0,1,NULL,NULL,0),(142,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_firstname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:46:56',1,'2016-12-12 13:57:46',0,1,NULL,NULL,0),(143,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_lastname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:47:39',1,'2016-12-12 13:57:37',0,1,NULL,NULL,0),(144,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_header',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:48:26',1,'2016-09-29 16:22:20',0,1,1,'2016-09-29 19:09:13',1),(145,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_femacategory',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:50:25',1,'2016-08-08 00:53:26',0,1,1,'2016-09-29 15:20:38',1),(146,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Person SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:58:42',NULL,NULL,0,1,1,'2016-08-08 02:05:50',1),(147,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Person SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 00:58:54',NULL,NULL,0,1,1,'2016-08-08 09:42:46',1),(149,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'New Folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 01:26:49',NULL,NULL,0,1,1,'2016-12-08 17:48:09',1),(150,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'Clients',NULL,NULL,NULL,NULL,NULL,0,1,'2016-08-08 01:26:59',1,'2016-09-29 19:52:34',0,1,NULL,NULL,0),(156,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 01:45:35',NULL,NULL,0,1,1,'2016-12-08 17:47:56',1),(167,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Gender',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:13',1,'2016-09-29 15:26:30',0,1,NULL,NULL,0),(168,136,NULL,0,NULL,0,NULL,5,NULL,NULL,'System folders',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:24',NULL,NULL,0,1,1,'2016-12-08 17:48:17',1),(169,168,NULL,0,NULL,0,NULL,5,NULL,NULL,'Surveys',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:36',NULL,NULL,0,1,1,'2016-12-08 17:48:17',2),(170,168,NULL,0,NULL,0,NULL,5,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:38:43',NULL,NULL,0,1,1,'2016-12-08 17:48:17',2),(172,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'TransportationAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:47:00',1,'2017-01-04 20:46:03',0,1,NULL,NULL,0),(173,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'Client SubMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-08-08 09:48:22',1,'2016-12-13 23:35:36',0,1,NULL,NULL,0),(201,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'Folder',NULL,NULL,NULL,NULL,NULL,1,3,'2016-09-14 19:09:08',1,'2016-09-29 20:14:31',0,3,1,'2016-12-08 17:48:00',1),(205,3,NULL,0,NULL,0,NULL,11,NULL,NULL,'Case',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:07:13',NULL,NULL,0,1,1,'2016-12-08 17:47:37',1),(206,205,NULL,0,NULL,0,NULL,12,NULL,NULL,'contacts',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:16:22',1,'2016-09-20 20:21:21',0,1,1,'2016-12-08 17:47:37',2),(207,3,NULL,0,NULL,0,NULL,11,NULL,NULL,'Contact',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:16:56',NULL,NULL,0,1,1,'2016-12-08 17:47:41',1),(208,207,NULL,0,NULL,0,NULL,12,NULL,NULL,'FirstName',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-20 20:17:59',NULL,NULL,0,1,1,'2016-12-08 17:47:41',2),(209,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_middlename',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:19:18',1,'2016-12-13 14:10:48',0,1,NULL,NULL,0),(210,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_birthdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:20:15',1,'2016-12-13 14:11:16',0,1,NULL,NULL,0),(211,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:21:33',1,'2016-12-13 14:10:56',0,1,NULL,NULL,0),(212,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gender',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:25:22',1,'2016-10-21 19:25:02',0,1,NULL,NULL,0),(213,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'New Thesauri Item',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:25:44',NULL,NULL,0,1,1,'2016-09-29 15:28:48',1),(214,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Male',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:26:48',1,'2016-09-29 15:28:12',0,1,NULL,NULL,0),(215,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Female',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:28:40',NULL,NULL,0,1,NULL,NULL,0),(216,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transgendered Female to Male',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:08',NULL,NULL,0,1,1,'2016-10-21 15:04:24',1),(217,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transgendered Male to Female',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:21',NULL,NULL,0,1,1,'2016-10-21 15:04:20',1),(218,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:36',NULL,NULL,0,1,NULL,NULL,0),(219,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:45',NULL,NULL,0,1,NULL,NULL,0),(220,167,NULL,0,NULL,0,NULL,8,NULL,NULL,'Data Not Collected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:29:56',NULL,NULL,0,1,NULL,NULL,0),(221,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Contact Method',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:22',1,'2016-09-29 15:33:06',0,1,NULL,NULL,0),(222,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'Phone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:35',NULL,NULL,0,1,NULL,NULL,0),(223,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'Email',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:44',NULL,NULL,0,1,NULL,NULL,0),(224,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'Mail',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:30:56',NULL,NULL,0,1,NULL,NULL,0),(225,221,NULL,0,NULL,0,NULL,8,NULL,NULL,'SMS',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:31:04',NULL,NULL,0,1,NULL,NULL,0),(226,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ethnicity',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:39:06',NULL,NULL,0,1,NULL,NULL,0),(227,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:39:18',NULL,NULL,0,1,NULL,NULL,0),(228,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:39:34',NULL,NULL,0,1,NULL,NULL,0),(229,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes - Mexican, Mexican American, Chicano',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:13',1,'2016-12-13 20:13:09',0,1,NULL,NULL,0),(230,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:25',1,'2016-12-13 20:12:51',0,1,NULL,NULL,0),(231,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:39',1,'2016-12-13 20:14:00',0,1,NULL,NULL,0),(232,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:40:52',1,'2016-12-13 20:13:53',0,1,NULL,NULL,0),(233,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Data Not Collected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:41:04',1,'2016-12-13 20:14:07',0,1,NULL,NULL,0),(234,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'American Indian Native or Alaska Native',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:45:29',NULL,NULL,0,1,NULL,NULL,0),(235,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Asian American',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:45:39',1,'2016-12-13 20:15:08',0,1,NULL,NULL,0),(236,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Black or African American',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:45:56',NULL,NULL,0,1,NULL,NULL,0),(237,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Native Hawaiian or Other Pacific Islander',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:16',NULL,NULL,0,1,NULL,NULL,0),(238,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'White',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:26',NULL,NULL,0,1,NULL,NULL,0),(239,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:41',NULL,NULL,0,1,NULL,NULL,0),(240,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:46:52',NULL,NULL,0,1,NULL,NULL,0),(241,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Data Not Collected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:47:08',NULL,NULL,0,1,NULL,NULL,0),(242,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'English',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:47:42',NULL,NULL,0,1,NULL,NULL,0),(243,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Spanish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:47:55',NULL,NULL,0,1,NULL,NULL,0),(244,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'French',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:52:24',NULL,NULL,0,1,NULL,NULL,0),(245,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'German',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:52:37',NULL,NULL,0,1,NULL,NULL,0),(246,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Italian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:09',NULL,NULL,0,1,NULL,NULL,0),(247,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Polish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:19',NULL,NULL,0,1,NULL,NULL,0),(248,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Portuguese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:35',NULL,NULL,0,1,NULL,NULL,0),(249,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Russian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:53:47',NULL,NULL,0,1,NULL,NULL,0),(250,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Arabic',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:00',NULL,NULL,0,1,NULL,NULL,0),(251,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Armenian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:11',NULL,NULL,0,1,NULL,NULL,0),(252,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Farsi',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:22',NULL,NULL,0,1,NULL,NULL,0),(253,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hebrew',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:32',NULL,NULL,0,1,NULL,NULL,0),(254,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Turkish',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:54:46',NULL,NULL,0,1,NULL,NULL,0),(255,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Cantonese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:04',NULL,NULL,0,1,NULL,NULL,0),(256,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Mandarin',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:18',NULL,NULL,0,1,NULL,NULL,0),(257,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Mien',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:29',1,'2016-09-29 15:55:51',0,1,NULL,NULL,0),(258,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'American Sign Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:55:38',NULL,NULL,0,1,NULL,NULL,0),(259,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Cambodian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:56:46',NULL,NULL,0,1,NULL,NULL,0),(260,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Chinese Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:57:06',NULL,NULL,0,1,NULL,NULL,0),(261,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hmong',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:57:16',NULL,NULL,0,1,NULL,NULL,0),(262,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Lao',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:57:26',NULL,NULL,0,1,NULL,NULL,0),(263,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Thai',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:59:44',NULL,NULL,0,1,NULL,NULL,0),(264,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Vietnamese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 15:59:54',NULL,NULL,0,1,NULL,NULL,0),(265,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tagalog',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:04',NULL,NULL,0,1,NULL,NULL,0),(266,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ilocano',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:15',NULL,NULL,0,1,NULL,NULL,0),(267,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Japanese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:25',NULL,NULL,0,1,NULL,NULL,0),(268,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Korean',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:38',NULL,NULL,0,1,NULL,NULL,0),(269,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Samoan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:00:53',NULL,NULL,0,1,NULL,NULL,0),(270,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Sign Language',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:01:08',NULL,NULL,0,1,NULL,NULL,0),(271,228,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Non English',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:01:22',NULL,NULL,0,1,NULL,NULL,0),(272,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_emailaddress',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 16:08:22',1,'2017-01-12 02:54:03',0,1,NULL,NULL,0),(274,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ethnicity',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 18:57:28',1,'2017-01-12 02:48:59',0,1,NULL,NULL,0),(275,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 18:58:15',1,'2016-12-13 14:10:21',0,1,NULL,NULL,0),(276,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_primarylanguage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 18:58:59',1,'2017-01-12 02:56:02',0,1,NULL,NULL,0),(277,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'languageassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:03:14',1,'2016-12-13 21:39:04',0,1,1,'2017-01-10 15:37:23',1),(278,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_specialatrisk',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:04:00',NULL,NULL,0,1,1,'2016-09-29 19:09:06',1),(279,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'at_risk_population',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:04:40',1,'2017-01-18 21:57:32',0,1,NULL,NULL,0),(280,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_domestic',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:05:13',1,'2017-01-12 02:58:42',0,1,1,'2017-01-14 01:26:35',1),(286,201,NULL,0,NULL,0,NULL,5,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:51:38',1,'2016-09-29 19:51:59',0,1,1,'2016-12-08 17:48:00',2),(287,201,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 19:51:46',NULL,NULL,0,1,1,'2016-12-08 17:48:00',2),(288,113,NULL,0,NULL,0,NULL,100,NULL,NULL,'Cases',NULL,NULL,NULL,NULL,NULL,1,1,'2016-09-29 20:26:24',1,'2017-01-09 14:42:35',0,1,NULL,NULL,0),(289,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FamilyMember',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:13:15',1,'2017-01-12 15:24:52',0,1,NULL,NULL,0),(290,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_firstname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:15:03',1,'2016-10-03 13:26:58',0,1,NULL,NULL,0),(291,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_lastname',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:15:25',1,'2016-10-03 13:27:06',0,1,NULL,NULL,0),(292,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_birthdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:27:52',1,'2017-01-12 02:39:57',0,1,NULL,NULL,0),(293,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_age',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:28:23',1,'2017-01-12 02:40:21',0,1,NULL,NULL,0),(294,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gender',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:29:22',1,'2016-11-02 19:37:16',0,1,NULL,NULL,0),(295,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_relationship',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:30:03',1,'2017-01-12 15:24:07',0,1,NULL,NULL,0),(296,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_middlename',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:30:21',NULL,NULL,0,1,NULL,NULL,0),(297,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:31:45',1,'2017-01-12 03:10:26',0,1,NULL,NULL,0),(298,289,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ethnicity',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:32:30',1,'2017-01-12 03:10:35',0,1,NULL,NULL,0),(299,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'Relationship',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:33:36',NULL,NULL,0,1,NULL,NULL,0),(300,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Parent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:33:55',NULL,NULL,0,1,NULL,NULL,0),(301,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Son',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:02',NULL,NULL,0,1,NULL,NULL,0),(302,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Daughter',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:11',NULL,NULL,0,1,NULL,NULL,0),(303,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Dependent Child',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:26',NULL,NULL,0,1,NULL,NULL,0),(304,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Grandparent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:37',NULL,NULL,0,1,NULL,NULL,0),(305,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Guardian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:46',NULL,NULL,0,1,NULL,NULL,0),(306,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Spouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:34:53',NULL,NULL,0,1,NULL,NULL,0),(307,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Family Member',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:02',NULL,NULL,0,1,NULL,NULL,0),(308,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Non-Family',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:11',NULL,NULL,0,1,NULL,NULL,0),(309,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Caretaker',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:19',NULL,NULL,0,1,NULL,NULL,0),(310,299,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ex Spouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:35:26',NULL,NULL,0,1,NULL,NULL,0),(311,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Address',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:46:09',1,'2016-11-14 15:22:24',0,1,NULL,NULL,0),(312,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addresstype',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:47:07',1,'2016-10-03 13:55:49',0,1,NULL,NULL,0),(313,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addressone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:47:53',1,'2016-10-22 02:20:48',0,1,NULL,NULL,0),(314,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addresstwo',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:48:01',1,'2016-10-21 13:42:18',0,1,NULL,NULL,0),(315,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_city',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:49:17',1,'2016-10-20 22:17:34',0,1,NULL,NULL,0),(316,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_state',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:50:10',1,'2016-10-21 01:45:36',0,1,NULL,NULL,0),(317,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_zip',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:50:40',NULL,NULL,0,1,NULL,NULL,0),(318,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_begindate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:51:11',NULL,NULL,0,1,NULL,NULL,0),(319,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_enddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:51:48',NULL,NULL,0,1,NULL,NULL,0),(320,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_primaryphone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:52:12',NULL,NULL,0,1,NULL,NULL,0),(321,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'AddressType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:52:35',NULL,NULL,0,1,NULL,NULL,0),(322,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Current Mailing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:09',NULL,NULL,0,1,NULL,NULL,0),(323,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Temporary',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:17',NULL,NULL,0,1,NULL,NULL,0),(324,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Summer',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:24',NULL,NULL,0,1,NULL,NULL,0),(325,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Previous Mailing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:33',NULL,NULL,0,1,NULL,NULL,0),(326,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergency',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:42',NULL,NULL,0,1,NULL,NULL,0),(327,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Business Address/Place of Employment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:53:54',NULL,NULL,0,1,NULL,NULL,0),(328,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Residential',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:04',NULL,NULL,0,1,NULL,NULL,0),(329,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transitional',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:14',NULL,NULL,0,1,NULL,NULL,0),(330,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Last Permanent Address',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:26',NULL,NULL,0,1,NULL,NULL,0),(331,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Permanent Supportive',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:38',NULL,NULL,0,1,NULL,NULL,0),(332,321,NULL,0,NULL,0,NULL,8,NULL,NULL,'Homeless in Area of Disaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 13:54:51',NULL,NULL,0,1,NULL,NULL,0),(333,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:11:39',1,'2016-10-03 14:14:18',0,1,NULL,NULL,0),(334,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'LivingArrangement',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:14:42',NULL,NULL,0,1,NULL,NULL,0),(335,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Owned house/condominium',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:14:58',NULL,NULL,0,1,NULL,NULL,0),(336,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rental house',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:07',NULL,NULL,0,1,NULL,NULL,0),(337,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rental apartment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:18',NULL,NULL,0,1,NULL,NULL,0),(338,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Staying with friends/family',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:30',NULL,NULL,0,1,NULL,NULL,0),(339,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Shelter (domestic violence, homeless, runaway and youth)',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:15:51',NULL,NULL,0,1,NULL,NULL,0),(340,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Military Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:01',NULL,NULL,0,1,NULL,NULL,0),(341,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Student dormitory',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:11',NULL,NULL,0,1,NULL,NULL,0),(342,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Group home or nursing home',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:23',NULL,NULL,0,1,NULL,NULL,0),(343,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Subsidized housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:33',NULL,NULL,0,1,NULL,NULL,0),(344,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Homeless',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:42',NULL,NULL,0,1,NULL,NULL,0),(345,334,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:16:49',NULL,NULL,0,1,NULL,NULL,0),(346,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'YesNoRefused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:10',NULL,NULL,0,1,NULL,NULL,0),(347,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:19',1,'2016-10-03 19:40:45',0,1,NULL,NULL,0),(348,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:27',1,'2016-10-03 19:40:59',0,1,NULL,NULL,0),(349,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:36',1,'2016-10-03 19:41:12',0,1,NULL,NULL,0),(350,346,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:17:44',1,'2016-10-03 19:41:24',0,1,NULL,NULL,0),(351,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InspectingAgent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:08',NULL,NULL,0,1,NULL,NULL,0),(352,351,NULL,0,NULL,0,NULL,8,NULL,NULL,'By an insurance adjustor',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:25',NULL,NULL,0,1,NULL,NULL,0),(353,351,NULL,0,NULL,0,NULL,8,NULL,NULL,'By a FEMA official',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:36',NULL,NULL,0,1,NULL,NULL,0),(354,351,NULL,0,NULL,0,NULL,8,NULL,NULL,'By a local government official',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:18:48',NULL,NULL,0,1,NULL,NULL,0),(355,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'DamageRating',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:13',NULL,NULL,0,1,NULL,NULL,0),(356,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Not Damaged',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:31',NULL,NULL,0,1,NULL,NULL,0),(357,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Minor',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:38',NULL,NULL,0,1,NULL,NULL,0),(358,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Major',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:44',NULL,NULL,0,1,NULL,NULL,0),(359,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Destroyed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:19:53',NULL,NULL,0,1,NULL,NULL,0),(360,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client doesn''t know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:04',NULL,NULL,0,1,NULL,NULL,0),(361,355,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:11',NULL,NULL,0,1,NULL,NULL,0),(362,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'Utilities',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:35',NULL,NULL,0,1,NULL,NULL,0),(363,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Electrical power',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:45',NULL,NULL,0,1,NULL,NULL,0),(364,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Phone',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:20:56',NULL,NULL,0,1,NULL,NULL,0),(365,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Water',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:21:06',NULL,NULL,0,1,NULL,NULL,0),(366,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Gas',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:21:41',NULL,NULL,0,1,NULL,NULL,0),(367,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Internet access',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:21:52',NULL,NULL,0,1,NULL,NULL,0),(368,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Propane',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:02',NULL,NULL,0,1,NULL,NULL,0),(369,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Fuel oil',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:12',NULL,NULL,0,1,NULL,NULL,0),(370,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Steam heat',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:21',NULL,NULL,0,1,NULL,NULL,0),(371,362,NULL,0,NULL,0,NULL,8,NULL,NULL,'Sewer and Sanitation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:33',NULL,NULL,0,1,NULL,NULL,0),(372,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InsuranceStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:22:56',NULL,NULL,0,1,NULL,NULL,0),(373,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client owned home and had homeowner''s insurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:23:36',NULL,NULL,0,1,NULL,NULL,0),(374,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client rented home and had renter''s insurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:23:49',NULL,NULL,0,1,NULL,NULL,0),(375,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client had hazard-specific insurance for disaster type (food, fire, earthquake)',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:09',NULL,NULL,0,1,NULL,NULL,0),(376,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Lack of appropriate Insurance Coverage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:22',NULL,NULL,0,1,NULL,NULL,0),(377,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client does not know insurance status',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:34',NULL,NULL,0,1,NULL,NULL,0),(378,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client was insured but does not have insurance policy information',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:49',NULL,NULL,0,1,NULL,NULL,0),(379,372,NULL,0,NULL,0,NULL,8,NULL,NULL,'Client was uninsured',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:24:58',NULL,NULL,0,1,NULL,NULL,0),(380,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'HousingServiceType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:31:51',NULL,NULL,0,1,NULL,NULL,0),(381,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergency Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:03',NULL,NULL,0,1,NULL,NULL,0),(382,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:14',NULL,NULL,0,1,NULL,NULL,0),(383,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Bednight',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:25',NULL,NULL,0,1,NULL,NULL,0),(384,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Placement',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:36',NULL,NULL,0,1,NULL,NULL,0),(385,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing Reservation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:32:50',NULL,NULL,0,1,NULL,NULL,0),(386,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tarp / Blue Roof',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:33:02',NULL,NULL,0,1,NULL,NULL,0),(387,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Temporary Housing and Other Financial Aid',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:33:21',NULL,NULL,0,1,NULL,NULL,0),(388,380,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transitional Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:33:33',NULL,NULL,0,1,NULL,NULL,0),(389,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'IncomeGroup',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:34:58',NULL,NULL,0,1,NULL,NULL,0),(390,389,NULL,0,NULL,0,NULL,8,NULL,NULL,'Cash Income',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:35:08',NULL,NULL,0,1,NULL,NULL,0),(391,389,NULL,0,NULL,0,NULL,8,NULL,NULL,'Non-cash benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:35:17',NULL,NULL,0,1,NULL,NULL,0),(392,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'TransportationMode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:41:42',NULL,NULL,0,1,NULL,NULL,0),(393,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Privately owned vehicle or motorcycle',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:00',NULL,NULL,0,1,NULL,NULL,0),(394,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Public Transit',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:10',NULL,NULL,0,1,NULL,NULL,0),(395,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Paratransit',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:18',NULL,NULL,0,1,NULL,NULL,0),(396,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Carshare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:26',NULL,NULL,0,1,NULL,NULL,0),(397,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Ride with friends/family',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:36',NULL,NULL,0,1,NULL,NULL,0),(398,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Bike',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:43',NULL,NULL,0,1,NULL,NULL,0),(399,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Walk',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:50',NULL,NULL,0,1,NULL,NULL,0),(400,392,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:42:58',NULL,NULL,0,1,NULL,NULL,0),(401,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'TransportationNeed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:21',NULL,NULL,0,1,NULL,NULL,0),(402,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Vehicle lost/destroyed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:37',NULL,NULL,0,1,NULL,NULL,0),(403,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Public transit not working',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:46',NULL,NULL,0,1,NULL,NULL,0),(404,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Paratransit not working/accessible',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:43:58',NULL,NULL,0,1,NULL,NULL,0),(405,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Road closure/damage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:07',NULL,NULL,0,1,NULL,NULL,0),(406,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Unable to afford gas',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:17',NULL,NULL,0,1,NULL,NULL,0),(407,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Unable to afford transit fare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:29',NULL,NULL,0,1,NULL,NULL,0),(408,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Unable to afford gas dependably',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:44:51',NULL,NULL,0,1,NULL,NULL,0),(409,401,NULL,0,NULL,0,NULL,8,NULL,NULL,'Accessible vehicle not available',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:45:06',NULL,NULL,0,1,NULL,NULL,0),(410,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'PaymentStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:01',NULL,NULL,0,1,NULL,NULL,0),(411,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'EmploymentTenure',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:08',1,'2016-10-03 14:52:51',0,1,NULL,NULL,0),(412,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Received Payment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:21',NULL,NULL,0,1,NULL,NULL,0),(413,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Denied',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:29',NULL,NULL,0,1,NULL,NULL,0),(414,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pending Payment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:39',NULL,NULL,0,1,NULL,NULL,0),(415,410,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pending Decision',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:46:49',NULL,NULL,0,1,NULL,NULL,0),(416,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InsuranceType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:12',NULL,NULL,0,1,NULL,NULL,0),(417,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Private',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:23',NULL,NULL,0,1,NULL,NULL,0),(418,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Medicare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:31',NULL,NULL,0,1,NULL,NULL,0),(419,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Medicaid',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:41',NULL,NULL,0,1,NULL,NULL,0),(420,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'State Children''s Health Insurance Program S-CHIP',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:48:55',NULL,NULL,0,1,NULL,NULL,0),(421,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Military Insurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:49:04',NULL,NULL,0,1,NULL,NULL,0),(422,416,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Public',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:49:13',NULL,NULL,0,1,NULL,NULL,0),(423,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'CaseNoteType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:51:22',NULL,NULL,0,1,1,'2016-10-03 14:51:31',1),(424,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Permanent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:25',NULL,NULL,0,1,NULL,NULL,0),(425,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Temporary',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:34',NULL,NULL,0,1,NULL,NULL,0),(426,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Seasonal',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:42',NULL,NULL,0,1,NULL,NULL,0),(427,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t Know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:50',NULL,NULL,0,1,NULL,NULL,0),(428,411,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:53:57',NULL,NULL,0,1,NULL,NULL,0),(429,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'AssessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:54:31',NULL,NULL,0,1,NULL,NULL,0),(430,429,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pre-Disaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:54:53',NULL,NULL,0,1,NULL,NULL,0),(431,429,NULL,0,NULL,0,NULL,8,NULL,NULL,'Post-Disaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 14:55:02',NULL,NULL,0,1,NULL,NULL,0),(432,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:01:47',1,'2016-10-28 19:48:28',0,1,NULL,NULL,0),(433,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_primarymode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:02:41',1,'2016-11-14 20:56:51',0,1,NULL,NULL,0),(434,433,NULL,0,NULL,0,NULL,12,NULL,NULL,'_methodworking',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:03:20',1,'2016-12-13 22:48:05',0,1,NULL,NULL,0),(435,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ifnotworking',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:04:30',1,'2016-11-14 20:57:08',0,1,1,'2016-12-13 22:53:24',1),(436,434,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insured',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:04:59',1,'2016-12-13 22:51:05',0,1,NULL,NULL,0),(437,434,NULL,0,NULL,0,NULL,12,NULL,NULL,'_receivedpayment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:05:32',1,'2016-12-13 22:51:19',0,1,NULL,NULL,0),(438,434,NULL,0,NULL,0,NULL,12,NULL,NULL,'_damagedindisaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:06:11',1,'2016-12-13 22:50:49',0,1,NULL,NULL,0),(439,434,NULL,0,NULL,0,NULL,12,NULL,NULL,'_transportationneeds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:06:45',1,'2016-12-13 22:51:39',0,1,NULL,NULL,0),(440,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'HousingAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:08:29',1,'2017-01-04 20:45:06',0,1,NULL,NULL,0),(441,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:31:44',1,'2016-10-28 19:47:52',0,1,NULL,NULL,0),(442,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_predisasterliving',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:32:29',NULL,NULL,0,1,NULL,NULL,0),(443,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_damagedhouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:33:27',NULL,NULL,0,1,NULL,NULL,0),(444,443,NULL,0,NULL,0,NULL,12,NULL,NULL,'_inspectedhouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:34:12',1,'2016-11-04 14:55:53',0,1,NULL,NULL,0),(445,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_accessiblehouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:34:44',1,'2016-10-03 15:36:03',0,1,NULL,NULL,0),(446,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_livablehouse',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:35:28',1,'2016-10-03 15:35:52',0,1,NULL,NULL,0),(447,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientdamagerating',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:36:30',NULL,NULL,0,1,NULL,NULL,0),(448,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientrelocated',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:37:06',NULL,NULL,0,1,NULL,NULL,0),(449,448,NULL,0,NULL,0,NULL,12,NULL,NULL,'_planstoreturn',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:37:35',1,'2016-11-14 20:55:02',0,1,NULL,NULL,0),(450,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_utilitieswork',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:38:12',1,'2016-11-14 20:53:58',0,1,NULL,NULL,0),(451,450,NULL,0,NULL,0,NULL,12,NULL,NULL,'_utilitiesnotworking',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:38:48',1,'2016-11-04 14:52:53',0,1,NULL,NULL,0),(452,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_disasterImpacts',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:39:23',NULL,NULL,0,1,NULL,NULL,0),(453,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_predisasterinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:40:02',NULL,NULL,0,1,NULL,NULL,0),(454,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insurancedetails',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:40:35',NULL,NULL,0,1,NULL,NULL,0),(455,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FinancialAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:42:05',1,'2017-01-04 20:44:26',0,1,NULL,NULL,0),(456,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:42:30',1,'2016-10-28 19:47:12',0,1,1,NULL,3),(457,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:43:35',1,'2016-11-14 20:51:48',0,1,1,NULL,3),(458,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_incomereceived',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:43:58',1,'2016-11-14 20:51:27',0,1,NULL,NULL,0),(459,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_noncashbenefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:44:28',1,'2016-11-14 20:51:03',0,1,NULL,NULL,0),(460,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_incomeGroup',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:44:54',NULL,NULL,0,1,NULL,NULL,0),(461,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_noncashbenefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:46:01',NULL,NULL,0,1,NULL,NULL,0),(462,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_earnedIncome',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:46:26',NULL,NULL,0,1,NULL,NULL,0),(463,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_unemploymentinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:46:56',NULL,NULL,0,1,NULL,NULL,0),(464,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ssi',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:47:26',NULL,NULL,0,1,NULL,NULL,0),(465,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_ssdi',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:47:49',NULL,NULL,0,1,NULL,NULL,0),(466,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_veteransdisability',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:48:24',NULL,NULL,0,1,NULL,NULL,0),(467,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'MonthlyExpensesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:50:40',1,'2016-11-14 15:25:42',0,1,1,'2016-12-13 21:39:49',1),(468,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentorder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:50:58',NULL,NULL,0,1,1,'2016-12-13 21:39:49',2),(469,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:51:21',1,'2016-10-28 19:48:10',0,1,1,'2016-12-13 21:39:49',2),(470,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:51:21',1,'2016-11-14 20:56:05',0,1,1,'2016-12-13 21:39:49',2),(471,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_rent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:54:47',1,'2016-12-06 17:33:16',0,1,1,'2016-12-13 21:39:49',2),(472,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_mortgage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:55:03',1,'2016-12-06 17:23:15',0,1,1,'2016-12-13 21:39:49',2),(473,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_maintenance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:55:28',1,'2016-12-06 17:23:49',0,1,1,'2016-12-13 21:39:49',2),(474,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_carpayment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:55:47',1,'2016-12-06 17:26:31',0,1,1,'2016-12-13 21:39:49',2),(475,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_carinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:56:28',1,'2016-12-06 17:26:22',0,1,1,'2016-12-13 21:39:49',2),(476,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gasoline',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:56:56',1,'2016-12-06 17:26:15',0,1,1,'2016-12-13 21:39:49',2),(477,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_medical',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:57:21',1,'2016-12-06 17:26:06',0,1,1,'2016-12-13 21:39:49',2),(478,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_food',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:57:35',1,'2016-12-06 17:25:58',0,1,1,'2016-12-13 21:39:49',2),(479,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_miscellaneous',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:57:54',1,'2016-12-06 17:25:49',0,1,1,'2016-12-13 21:39:49',2),(480,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_totalExpenses',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:58:12',1,'2016-12-06 17:22:20',0,1,1,'2016-12-13 21:39:49',2),(481,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_totalmonthlyamount',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:58:47',1,'2016-12-06 17:21:36',0,1,1,'2016-12-13 21:39:49',2),(482,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'EmploymentAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 15:59:58',1,'2017-01-04 20:43:57',0,1,NULL,NULL,0),(483,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:00:08',1,'2016-10-28 19:46:56',0,1,NULL,NULL,0),(484,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:00:08',1,'2016-11-14 20:50:31',0,1,NULL,NULL,0),(485,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_employed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:00:45',1,'2016-11-02 19:37:01',0,1,NULL,NULL,0),(486,485,NULL,0,NULL,0,NULL,12,NULL,NULL,'_hoursworked',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:01:08',1,'2016-11-04 17:34:45',0,1,NULL,NULL,0),(487,485,NULL,0,NULL,0,NULL,12,NULL,NULL,'_employmenttenure',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:01:53',1,'2016-11-04 17:35:48',0,1,NULL,NULL,0),(488,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_additionalemployment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:02:36',1,'2016-11-02 19:36:55',0,1,NULL,NULL,0),(489,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'HealthAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:03:31',1,'2017-01-11 15:39:18',0,1,NULL,NULL,0),(490,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:03:59',NULL,NULL,0,1,NULL,NULL,0),(491,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insuranceType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:05:05',NULL,NULL,0,1,NULL,NULL,0),(492,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_isPrimary',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:06:03',1,'2016-11-02 19:39:54',0,1,NULL,NULL,0),(493,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_medscovered',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:06:23',1,'2016-11-02 19:39:48',0,1,NULL,NULL,0),(494,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_dmecovered',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:06:58',1,'2016-11-02 19:40:12',0,1,NULL,NULL,0),(495,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insurancestatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:07:35',1,'2016-10-03 16:12:39',0,1,NULL,NULL,0),(496,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_insurancelostdisaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:08:11',1,'2016-11-02 19:40:05',0,1,NULL,NULL,0),(497,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_whatcausedinsuranceloss',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:08:52',NULL,NULL,0,1,NULL,NULL,0),(498,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_startdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:09:06',NULL,NULL,0,1,NULL,NULL,0),(499,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_enddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:09:19',NULL,NULL,0,1,NULL,NULL,0),(500,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_appliedfordate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:09:34',NULL,NULL,0,1,NULL,NULL,0),(501,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'InsuranceStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:11:50',NULL,NULL,0,1,NULL,NULL,0),(502,501,NULL,0,NULL,0,NULL,8,NULL,NULL,'Pending/Applied',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:12:04',NULL,NULL,0,1,NULL,NULL,0),(503,501,NULL,0,NULL,0,NULL,8,NULL,NULL,'Active',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:12:12',NULL,NULL,0,1,NULL,NULL,0),(504,501,NULL,0,NULL,0,NULL,8,NULL,NULL,'Inactive',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:12:19',NULL,NULL,0,1,NULL,NULL,0),(505,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FoodAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:16:09',1,'2017-01-04 20:44:34',0,1,NULL,NULL,0),(506,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:16:28',1,'2016-10-28 19:47:21',0,1,NULL,NULL,0),(507,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_enoughfood',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:16:54',1,'2016-11-02 19:38:22',0,1,NULL,NULL,0),(508,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_predisasterassistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:17:30',1,'2016-11-02 19:38:16',0,1,NULL,NULL,0),(509,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_requestedfood',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:18:00',1,'2016-11-02 19:38:01',0,1,NULL,NULL,0),(510,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'BehavioralHealthAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:19:16',1,'2017-01-04 20:45:42',0,1,NULL,NULL,0),(511,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:20:01',1,'2016-10-28 19:46:20',0,1,NULL,NULL,0),(512,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_indistress',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:20:30',1,'2016-11-02 18:56:35',0,1,NULL,NULL,0),(513,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_liketospeak',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:22:35',1,'2016-11-02 18:56:15',0,1,NULL,NULL,0),(514,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_feelsafe',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:22:55',1,'2016-11-02 18:56:51',0,1,NULL,NULL,0),(515,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_hurtingyourselfothers',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:23:29',1,'2016-11-02 18:56:43',0,1,NULL,NULL,0),(516,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'FoodHelp',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:24:25',NULL,NULL,0,1,NULL,NULL,0),(517,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Woman Infants & Children (WIC) Benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:24:50',NULL,NULL,0,1,NULL,NULL,0),(518,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Supplemental Nutrition Assistance Program (SNAP)',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:06',NULL,NULL,0,1,NULL,NULL,0),(519,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance from local food pantries/food banks',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:22',NULL,NULL,0,1,NULL,NULL,0),(520,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Meals on wheels',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:32',NULL,NULL,0,1,NULL,NULL,0),(521,516,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:25:41',NULL,NULL,0,1,NULL,NULL,0),(522,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'CaseNoteType',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:34:42',NULL,NULL,0,1,NULL,NULL,0),(523,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Education',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:34:53',NULL,NULL,0,1,NULL,NULL,0),(524,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Employment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:35:01',NULL,NULL,0,1,NULL,NULL,0),(525,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Skills Building',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:35:12',NULL,NULL,0,1,NULL,NULL,0),(526,522,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:35:23',NULL,NULL,0,1,NULL,NULL,0),(527,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'CaseNote',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:50:16',1,'2016-11-14 15:23:55',0,1,NULL,NULL,0),(528,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_entrydate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:51:53',1,'2016-10-24 14:23:31',0,1,NULL,NULL,0),(529,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_regarding',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:52:06',1,'2016-10-03 16:54:37',0,1,NULL,NULL,0),(530,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_regarding',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:52:13',NULL,NULL,0,1,1,'2016-10-18 16:16:46',1),(531,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_notetype',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:52:32',1,'2016-12-07 05:23:15',0,1,NULL,NULL,0),(532,527,NULL,0,NULL,0,NULL,12,NULL,NULL,'_casenote',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:53:51',1,'2016-10-03 16:54:20',0,1,NULL,NULL,0),(533,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'ChildAssesment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:55:23',1,'2017-01-04 20:35:15',0,1,NULL,NULL,0),(534,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:56:18',1,'2016-10-28 19:46:35',0,1,NULL,NULL,0),(535,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childrenunder18',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:57:02',NULL,NULL,0,1,NULL,NULL,0),(536,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fostercare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:57:38',NULL,NULL,0,1,1,'2016-10-21 14:00:50',1),(537,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fostercare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:57:53',1,'2016-11-14 20:53:16',0,1,NULL,NULL,0),(538,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_headstart',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:58:37',1,'2016-11-04 17:25:53',0,1,NULL,NULL,0),(539,538,NULL,0,NULL,0,NULL,12,NULL,NULL,'_servicesdisrupted',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:59:15',1,'2016-11-04 17:16:42',0,1,NULL,NULL,0),(540,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childcareneed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 16:59:41',1,'2016-11-04 17:26:50',0,1,NULL,NULL,0),(541,540,NULL,0,NULL,0,NULL,12,NULL,NULL,'_priorvoucher',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:00:11',1,'2016-11-04 17:22:41',0,1,NULL,NULL,0),(542,540,NULL,0,NULL,0,NULL,12,NULL,NULL,'_barrierstochildcare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:00:46',1,'2016-11-15 14:23:50',0,1,NULL,NULL,0),(543,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childsupportpre',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:01:17',1,'2016-11-14 20:40:49',0,1,NULL,NULL,0),(544,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_responsibleforchildsupoprt',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:01:47',1,'2016-11-02 18:57:42',0,1,NULL,NULL,0),(545,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_paymentsdelayed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:02:08',1,'2016-11-02 18:58:03',0,1,NULL,NULL,0),(546,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_childsupportpost',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:04:45',1,'2016-11-14 20:41:01',0,1,NULL,NULL,0),(547,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_kidsinschool',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:05:21',1,'2016-11-04 17:25:39',0,1,NULL,NULL,0),(548,547,NULL,0,NULL,0,NULL,12,NULL,NULL,'_sameschoolpostdisaster',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:06:11',1,'2016-11-04 17:18:00',0,1,NULL,NULL,0),(549,547,NULL,0,NULL,0,NULL,12,NULL,NULL,'_needhelpregistering',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:06:45',1,'2016-11-04 17:18:37',0,1,NULL,NULL,0),(550,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_missedimmunizations',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:07:19',1,'2016-11-04 17:25:13',0,1,NULL,NULL,0),(551,535,NULL,0,NULL,0,NULL,12,NULL,NULL,'_copingconcerns',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:07:43',1,'2016-11-04 17:26:31',0,1,NULL,NULL,0),(552,551,NULL,0,NULL,0,NULL,12,NULL,NULL,'_copingexplanations',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:08:05',1,'2016-11-04 17:15:04',0,1,NULL,NULL,0),(553,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'ClothingAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:52:21',1,'2017-01-04 20:36:24',0,1,NULL,NULL,0),(554,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:52:42',1,'2016-10-28 19:46:46',0,1,NULL,NULL,0),(555,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_anyoneloseclothing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:53:13',1,'2016-11-02 19:36:37',0,1,NULL,NULL,0),(556,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_usableclothing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:54:46',1,'2016-11-02 19:36:08',0,1,NULL,NULL,0),(557,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_coldweather',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:55:33',1,'2016-11-02 19:36:30',0,1,NULL,NULL,0),(558,555,NULL,0,NULL,0,NULL,12,NULL,NULL,'_makeclaim',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:56:05',1,'2016-11-04 13:21:45',0,1,NULL,NULL,0),(559,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FurnitureAndAppliancesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:57:08',1,'2017-01-04 20:44:45',0,1,NULL,NULL,0),(560,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:57:32',1,'2016-10-28 19:47:31',0,1,NULL,NULL,0),(561,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_anythingdestroyed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:58:06',1,'2016-11-02 19:38:57',0,1,NULL,NULL,0),(562,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_refrigerator',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:58:58',1,'2016-11-04 17:31:46',0,1,NULL,NULL,0),(563,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_stove',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:59:12',1,'2016-11-04 17:31:40',0,1,NULL,NULL,0),(564,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_beds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 17:59:33',1,'2016-11-04 17:30:45',0,1,NULL,NULL,0),(565,564,NULL,0,NULL,0,NULL,12,NULL,NULL,'_numberofbeds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:00:05',1,'2016-11-04 17:31:22',0,1,NULL,NULL,0),(566,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_numberofbeds',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:00:14',NULL,NULL,0,1,1,'2016-10-21 14:38:10',1),(567,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_claimforfurniture',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:00:47',1,'2016-11-04 17:30:25',0,1,NULL,NULL,0),(568,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_replacementitemsreceived',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:01:20',1,'2016-11-04 17:29:40',0,1,NULL,NULL,0),(569,561,NULL,0,NULL,0,NULL,12,NULL,NULL,'_abletoinstall',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:01:58',1,'2016-11-04 17:30:13',0,1,NULL,NULL,0),(570,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ReferralService',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:30:29',NULL,NULL,0,1,NULL,NULL,0),(571,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance identifying private legal counsel',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:32:25',NULL,NULL,0,1,NULL,NULL,0),(572,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with D-Snap application',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:32:38',NULL,NULL,0,1,NULL,NULL,0),(573,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with insurance claim/appeal',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:32:52',NULL,NULL,0,1,NULL,NULL,0),(574,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Bus Tokens',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:02',NULL,NULL,0,1,NULL,NULL,0),(575,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Counseling-Alcohol',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:19',NULL,NULL,0,1,NULL,NULL,0),(576,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergency Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:44',NULL,NULL,0,1,NULL,NULL,0),(577,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Laundry Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:33:58',NULL,NULL,0,1,NULL,NULL,0),(578,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to community organizations for food needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:13',NULL,NULL,0,1,NULL,NULL,0),(579,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to faith-based/community organizations for clothing',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:29',NULL,NULL,0,1,NULL,NULL,0),(580,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rental Assitance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:40',NULL,NULL,0,1,NULL,NULL,0),(581,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Social Services for WIC/SNAP',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:34:51',NULL,NULL,0,1,NULL,NULL,0),(582,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with accessing VA benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:36:49',NULL,NULL,0,1,NULL,NULL,0),(583,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Assistance with FEMA ONA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:00',NULL,NULL,0,1,NULL,NULL,0),(584,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Bus Pass',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:07',NULL,NULL,0,1,NULL,NULL,0),(585,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Case Management',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:16',NULL,NULL,0,1,NULL,NULL,0),(586,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Disaster Case Management',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:30',NULL,NULL,0,1,NULL,NULL,0),(587,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Healthcare',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:41',NULL,NULL,0,1,NULL,NULL,0),(588,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Prenatal Care',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:37:50',NULL,NULL,0,1,NULL,NULL,0),(589,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to faith-based/community organizations for replacement',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:38:10',NULL,NULL,0,1,NULL,NULL,0),(590,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to mass care for immediate food needs',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:38:40',NULL,NULL,0,1,NULL,NULL,0),(591,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Restoration of pre-disaster Meals on Wheels services',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:38:54',NULL,NULL,0,1,NULL,NULL,0),(592,570,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transportation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:39:02',NULL,NULL,0,1,NULL,NULL,0),(593,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ReferralStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:39:27',NULL,NULL,0,1,NULL,NULL,0),(594,593,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral Made',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:39:56',1,'2016-10-03 18:40:33',0,1,NULL,NULL,0),(595,593,NULL,0,NULL,0,NULL,8,NULL,NULL,'Not Eligible',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:40:08',NULL,NULL,0,1,NULL,NULL,0),(596,593,NULL,0,NULL,0,NULL,8,NULL,NULL,'Resources Not Available',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:40:20',NULL,NULL,0,1,NULL,NULL,0),(597,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ReferralResult',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:02',NULL,NULL,0,1,NULL,NULL,0),(598,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'ServiceProvided',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:18',NULL,NULL,0,1,NULL,NULL,0),(599,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'Information Only',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:26',NULL,NULL,0,1,NULL,NULL,0),(600,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'Rejected',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:34',NULL,NULL,0,1,NULL,NULL,0),(601,597,NULL,0,NULL,0,NULL,8,NULL,NULL,'No Show',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:41:43',NULL,NULL,0,1,NULL,NULL,0),(602,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'UnitOfMeasure',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:48:39',NULL,NULL,0,1,NULL,NULL,0),(603,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Dollars',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:48:57',NULL,NULL,0,1,NULL,NULL,0),(604,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Minutes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:07',NULL,NULL,0,1,NULL,NULL,0),(605,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Count',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:14',NULL,NULL,0,1,NULL,NULL,0),(606,602,NULL,0,NULL,0,NULL,8,NULL,NULL,'Hours',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:21',NULL,NULL,0,1,NULL,NULL,0),(607,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:49:54',1,'2017-01-17 18:17:49',0,1,NULL,NULL,0),(608,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referraldate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:50:22',1,'2017-01-11 20:26:17',0,1,NULL,NULL,0),(609,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:51:00',1,'2016-10-03 19:13:00',0,1,1,'2017-01-11 16:59:56',1),(610,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_provider',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:51:40',1,'2017-01-11 20:25:36',0,1,NULL,NULL,0),(611,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_provider',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:52:15',NULL,NULL,0,1,1,'2017-01-11 17:10:09',1),(612,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_streetaddress',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:52:33',1,'2017-01-11 20:27:01',0,1,NULL,NULL,0),(613,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_zipcode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:04',1,'2017-01-11 20:27:10',0,1,NULL,NULL,0),(614,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_city',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:13',1,'2017-01-11 20:25:28',0,1,NULL,NULL,0),(615,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_state',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:37',1,'2017-01-11 20:26:40',0,1,NULL,NULL,0),(616,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_geocode',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:53:53',NULL,NULL,0,1,1,'2017-01-11 19:18:25',1),(617,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralstatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:54:41',1,'2017-01-11 19:17:18',0,1,NULL,NULL,0),(618,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_comments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:54:58',1,'2017-01-11 20:24:02',0,1,NULL,NULL,0),(619,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_associatedneed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:55:23',NULL,NULL,0,1,1,'2017-01-11 19:18:37',1),(620,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_voucherinformation',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:59:04',NULL,NULL,0,1,1,'2017-01-11 19:20:55',1),(621,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_vouchernumber',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 18:59:25',NULL,NULL,0,1,1,'2017-01-11 19:20:55',1),(622,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_voucheruom',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:02:11',1,'2016-10-03 19:13:42',0,1,1,'2017-01-11 19:20:55',1),(623,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_voucherunits',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:02:32',NULL,NULL,0,1,1,'2017-01-11 19:20:55',1),(624,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_unitvalue',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:02:52',NULL,NULL,0,1,1,'2017-01-11 19:21:16',1),(625,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_vouchertotal',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:03:27',NULL,NULL,0,1,1,'2017-01-11 19:20:55',1),(626,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_informationrelease',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:05:33',NULL,NULL,0,1,1,'2017-01-11 19:18:58',1),(627,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_emailauthorized',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:05:53',NULL,NULL,0,1,1,'2017-01-11 19:19:03',1),(628,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referraloutcome',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:06:59',NULL,NULL,0,1,1,'2017-01-11 19:19:25',1),(629,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_dateacknowledged',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:07:22',NULL,NULL,0,1,1,'2017-01-11 19:31:01',1),(630,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_appointmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:07:37',NULL,NULL,0,1,1,NULL,3),(631,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_appointmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:07:50',1,'2017-01-11 20:25:54',0,1,NULL,NULL,0),(632,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_resultdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:08:06',1,'2017-01-11 20:26:30',0,1,NULL,NULL,0),(633,617,NULL,0,NULL,0,NULL,12,NULL,NULL,'_result',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:08:29',1,'2017-01-11 20:17:09',0,1,NULL,NULL,0),(634,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fematier',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:15:04',1,'2016-10-04 02:15:39',0,1,1,'2016-12-06 17:08:47',1),(635,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 1: Immediate Needs Met',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:18:21',NULL,NULL,0,1,1,'2016-12-06 17:07:06',2),(636,137,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 2: Some Remaining Unmet Needs or in Current Rebuild/Repair Status',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:18:24',1,'2016-10-03 19:18:53',0,1,1,'2016-12-06 17:07:06',2),(642,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'New Folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-03 19:53:59',NULL,NULL,0,1,1,'2016-12-08 17:48:12',1),(643,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientstatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:12:24',1,'2016-10-04 02:15:59',0,1,1,'2016-12-06 17:08:43',1),(644,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'ClientStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:13:13',NULL,NULL,0,1,1,'2016-12-06 17:07:20',1),(645,644,NULL,0,NULL,0,NULL,8,NULL,NULL,'Open',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:13:28',NULL,NULL,0,1,1,'2016-12-06 17:07:20',2),(646,644,NULL,0,NULL,0,NULL,8,NULL,NULL,'Closed',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-04 02:13:33',NULL,NULL,0,1,1,'2016-12-06 17:07:20',2),(651,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'SeniorServicesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:04:35',1,'2017-01-04 20:45:55',0,1,NULL,NULL,0),(652,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:05:01',1,'2016-10-28 19:48:18',0,1,NULL,NULL,0),(653,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_priorseniorliving',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:05:54',1,'2016-11-02 19:41:54',0,1,NULL,NULL,0),(654,653,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientdisplaced',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:07:18',1,'2016-11-04 13:26:19',0,1,NULL,NULL,0),(655,654,NULL,0,NULL,0,NULL,12,NULL,NULL,'_explaincircumstances',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:08:02',1,'2016-11-04 13:26:37',0,1,NULL,NULL,0),(656,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'LanguageAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:08:51',1,'2017-01-04 20:45:19',0,1,NULL,NULL,0),(657,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:11:30',1,'2016-10-28 19:48:00',0,1,NULL,NULL,0),(658,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'New Field',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:28',NULL,NULL,0,1,1,'2016-10-09 00:13:04',1),(659,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_priorlanguage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:57',1,'2016-10-09 00:13:22',0,1,NULL,NULL,0),(660,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_currentlyhavinglanguage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:57',1,'2016-11-02 19:41:16',0,1,NULL,NULL,0),(661,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_lostlanguageservices',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 00:12:57',1,'2016-11-02 19:40:55',0,1,NULL,NULL,0),(663,129,NULL,0,NULL,0,NULL,100,NULL,NULL,'dc_cases_fema',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-09 21:01:34',NULL,NULL,0,1,NULL,NULL,0),(666,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'FEMA Tier 1',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-13 14:37:17',1,'2016-10-13 14:37:56',0,1,1,'2016-12-08 17:47:44',1),(667,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-13 14:38:06',NULL,NULL,0,1,1,'2016-12-08 17:48:20',1),(668,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'Services',NULL,NULL,NULL,NULL,NULL,0,1,'2016-10-14 03:57:53',1,'2016-10-21 14:17:09',0,1,NULL,NULL,0),(669,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Service',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 03:59:17',1,'2017-01-10 20:48:57',0,1,NULL,NULL,0),(670,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_name',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 03:59:37',NULL,NULL,0,1,NULL,NULL,0),(671,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_address',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 03:59:53',NULL,NULL,0,1,NULL,NULL,0),(672,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_notes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-14 04:00:19',NULL,NULL,0,1,NULL,NULL,0),(674,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'Backup',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-17 19:38:44',1,'2016-10-17 19:39:01',0,1,1,'2016-12-08 17:47:34',1),(678,150,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-17 19:46:43',NULL,NULL,0,1,1,'2016-10-18 17:49:28',1),(679,150,NULL,2,NULL,0,NULL,9,NULL,NULL,'Test2',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-17 19:46:47',NULL,NULL,0,1,1,'2016-10-18 17:49:26',1),(680,150,NULL,2,NULL,0,NULL,9,NULL,NULL,'Sup',NULL,NULL,NULL,NULL,NULL,1,6,'2016-10-17 19:47:06',NULL,NULL,0,6,6,'2016-10-21 16:23:15',1),(683,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:42:11',1,'2017-01-11 16:16:10',0,1,NULL,NULL,0),(684,683,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:44:19',1,'2017-01-11 16:16:28',0,1,NULL,NULL,0),(685,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'YesNo',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:46:08',NULL,NULL,0,1,NULL,NULL,0),(686,685,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:46:22',NULL,NULL,0,1,NULL,NULL,0),(687,685,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 13:46:29',NULL,NULL,0,1,NULL,NULL,0),(703,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'New Field',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 16:42:31',NULL,NULL,0,1,1,'2016-10-18 16:42:52',1),(704,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-18 16:45:24',NULL,NULL,0,1,1,'2016-12-08 17:48:03',1),(718,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_name',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-20 18:36:01',1,'2016-10-21 12:56:47',0,1,1,'2017-01-11 19:18:04',1),(722,311,NULL,0,NULL,0,NULL,12,NULL,NULL,'_latlon',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-20 20:15:35',1,'2016-10-20 22:17:20',0,1,1,'2016-12-13 21:46:29',1),(845,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:13:31',1,'2017-01-11 16:17:03',0,1,NULL,NULL,0),(846,845,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:13:31',1,'2017-01-11 16:16:44',0,1,NULL,NULL,0),(847,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:20:43',1,'2017-01-11 16:15:54',0,1,NULL,NULL,0),(848,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:20:52',1,'2017-01-11 16:15:19',0,1,NULL,NULL,0),(849,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:14',1,'2016-10-21 16:09:08',0,1,1,NULL,3),(850,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:22',1,'2017-01-11 15:59:04',0,1,NULL,NULL,0),(851,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:31',1,'2017-01-11 16:01:43',0,1,NULL,NULL,0),(852,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:38',1,'2016-10-21 15:45:14',0,1,1,'2016-10-21 15:46:57',1),(853,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:51',1,'2017-01-11 16:12:30',0,1,NULL,NULL,0),(854,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:21:58',1,'2017-01-11 16:10:02',0,1,NULL,NULL,0),(855,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:06',1,'2016-10-21 16:11:06',0,1,1,'2016-12-13 21:39:49',2),(856,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:13',1,'2017-01-11 16:09:41',0,1,NULL,NULL,0),(857,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:20',1,'2017-01-11 16:09:21',0,1,NULL,NULL,0),(858,847,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:22:56',1,'2017-01-11 16:15:36',0,1,NULL,NULL,0),(859,848,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:04',1,'2017-01-11 16:15:02',0,1,NULL,NULL,0),(860,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:15',1,'2016-10-21 16:09:19',0,1,1,NULL,3),(861,850,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:21',1,'2017-01-11 15:58:47',0,1,NULL,NULL,0),(862,851,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:27',1,'2017-01-11 16:01:13',0,1,NULL,NULL,0),(863,853,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:35',1,'2017-01-11 16:12:17',0,1,NULL,NULL,0),(864,854,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:39',1,'2017-01-11 16:04:09',0,1,NULL,NULL,0),(865,467,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:46',1,'2016-10-21 16:11:22',0,1,1,'2016-12-13 21:39:49',2),(866,856,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:51',1,'2017-01-11 16:07:09',0,1,NULL,NULL,0),(867,857,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:23:56',1,'2017-01-11 16:09:01',0,1,NULL,NULL,0),(870,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'TestReferral',NULL,NULL,NULL,NULL,NULL,1,1,'2016-10-21 15:42:04',NULL,NULL,0,1,1,'2016-10-21 15:45:54',1),(897,150,NULL,0,NULL,0,NULL,5,NULL,NULL,'folder',NULL,NULL,NULL,NULL,NULL,1,10,'2016-10-24 15:11:24',NULL,NULL,0,10,10,'2016-10-24 15:11:36',1),(938,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:07',NULL,NULL,0,1,NULL,NULL,0),(939,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:18',NULL,NULL,0,1,NULL,NULL,0),(940,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'Don''t know',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:42',NULL,NULL,0,1,NULL,NULL,0),(941,347,NULL,0,NULL,0,NULL,8,NULL,NULL,'Refused',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-04 13:18:56',NULL,NULL,0,1,NULL,NULL,0),(952,136,NULL,0,NULL,0,NULL,5,NULL,NULL,'System folders',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:29:39',1,'2016-11-14 15:30:00',0,1,NULL,NULL,0),(953,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:30:26',NULL,NULL,0,1,NULL,NULL,0),(954,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:30:52',1,'2016-11-14 15:31:08',0,1,NULL,NULL,0),(955,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 15:30:59',NULL,NULL,0,1,NULL,NULL,0),(962,952,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 17:54:39',1,'2016-11-14 17:55:07',0,1,NULL,NULL,0),(963,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'AssessmentMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 17:57:19',1,'2016-11-14 20:18:41',0,1,NULL,NULL,0),(970,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'AssessmentsTest',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 18:18:58',NULL,NULL,0,1,1,'2016-12-08 17:47:23',1),(972,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:09:16',1,'2016-11-14 20:28:22',0,1,1,'2016-12-13 21:45:39',1),(973,972,NULL,0,NULL,0,NULL,12,NULL,NULL,'Assessment Start',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:15:12',NULL,NULL,0,1,1,'2016-12-13 21:45:39',2),(976,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'ClientIntake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:28:53',NULL,NULL,0,1,1,'2016-12-13 21:45:32',1),(977,976,NULL,0,NULL,0,NULL,12,NULL,NULL,'_startdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:29:21',NULL,NULL,0,1,1,'2016-12-13 21:45:32',2),(978,60,NULL,0,NULL,0,NULL,62,NULL,NULL,'ClientIntakeMenu',NULL,NULL,NULL,NULL,NULL,1,1,'2016-11-14 20:33:05',NULL,NULL,0,1,NULL,NULL,0),(1026,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Test  persons',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-08 21:29:34',1,'2016-12-08 21:31:42',0,1,1,'2016-12-14 00:00:07',1),(1027,1026,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-08 21:29:34',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1028,1026,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-08 21:29:34',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1029,1026,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-08 21:29:34',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1030,1026,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-08 21:29:34',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1031,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Test  Person2',NULL,NULL,NULL,NULL,NULL,1,21,'2016-12-12 02:30:48',NULL,NULL,0,21,1,'2016-12-14 00:00:07',1),(1032,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_street',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-12 13:50:20',1,'2016-12-13 14:25:30',0,1,NULL,NULL,0),(1033,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_maritalstatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-12 13:59:46',1,'2016-12-13 14:09:35',0,1,NULL,NULL,0),(1034,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_headofhousehold',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-12 14:01:14',1,'2017-01-12 02:53:14',0,1,NULL,NULL,0),(1035,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'MaritalStatus',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-12 14:02:20',NULL,NULL,0,1,NULL,NULL,0),(1036,1035,NULL,0,NULL,0,NULL,8,NULL,NULL,'Married',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-12 14:02:37',NULL,NULL,0,1,NULL,NULL,0),(1037,1035,NULL,0,NULL,0,NULL,8,NULL,NULL,'Single',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-12 14:02:50',NULL,NULL,0,1,NULL,NULL,0),(1038,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_addresstitle',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:14:42',1,'2016-12-13 14:15:00',0,1,NULL,NULL,0),(1039,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_city',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:26:04',1,'2016-12-13 14:26:32',0,1,NULL,NULL,0),(1040,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_state',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:33:35',1,'2016-12-13 15:08:12',0,1,NULL,NULL,0),(1041,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'State',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:34:02',NULL,NULL,0,1,NULL,NULL,0),(1042,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'AL',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:37:57',NULL,NULL,0,1,NULL,NULL,0),(1043,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'AK',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:09',NULL,NULL,0,1,NULL,NULL,0),(1044,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:15',1,'2016-12-13 14:46:10',0,1,NULL,NULL,0),(1045,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'AZ',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:23',NULL,NULL,0,1,NULL,NULL,0),(1046,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'AR',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:29',NULL,NULL,0,1,NULL,NULL,0),(1047,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'CA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:34',NULL,NULL,0,1,NULL,NULL,0),(1048,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'CO',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:41',NULL,NULL,0,1,NULL,NULL,0),(1049,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'CT',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:47',NULL,NULL,0,1,NULL,NULL,0),(1050,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'DE',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:38:54',NULL,NULL,0,1,NULL,NULL,0),(1051,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'FL',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:00',NULL,NULL,0,1,NULL,NULL,0),(1052,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'GA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:05',NULL,NULL,0,1,NULL,NULL,0),(1053,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'HI',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:11',NULL,NULL,0,1,NULL,NULL,0),(1054,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'ID',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:17',NULL,NULL,0,1,NULL,NULL,0),(1055,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'IL',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:23',NULL,NULL,0,1,NULL,NULL,0),(1056,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'IN',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:30',NULL,NULL,0,1,NULL,NULL,0),(1057,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'KY',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:36',1,'2016-12-13 14:40:32',0,1,NULL,NULL,0),(1058,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'LA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:44',1,'2016-12-13 14:40:41',0,1,NULL,NULL,0),(1059,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'IA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:39:53',NULL,NULL,0,1,NULL,NULL,0),(1060,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'KS',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:40:00',NULL,NULL,0,1,NULL,NULL,0),(1061,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'ME',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:41:27',NULL,NULL,0,1,NULL,NULL,0),(1062,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MD',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:41:32',NULL,NULL,0,1,NULL,NULL,0),(1063,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:41:38',NULL,NULL,0,1,NULL,NULL,0),(1064,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MN',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:41:48',NULL,NULL,0,1,NULL,NULL,0),(1065,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MI',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:06',NULL,NULL,0,1,NULL,NULL,0),(1066,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MS',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:15',NULL,NULL,0,1,NULL,NULL,0),(1067,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MO',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:22',NULL,NULL,0,1,NULL,NULL,0),(1068,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'MT',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:33',NULL,NULL,0,1,NULL,NULL,0),(1069,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NE',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:41',NULL,NULL,0,1,NULL,NULL,0),(1070,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NV',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:47',NULL,NULL,0,1,NULL,NULL,0),(1071,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NH',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:42:55',1,'2016-12-13 14:43:08',0,1,NULL,NULL,0),(1072,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NJ',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:20',NULL,NULL,0,1,NULL,NULL,0),(1073,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NM',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:27',NULL,NULL,0,1,NULL,NULL,0),(1074,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NY',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:32',NULL,NULL,0,1,NULL,NULL,0),(1075,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'NC',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:37',NULL,NULL,0,1,NULL,NULL,0),(1076,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'ND',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:42',NULL,NULL,0,1,NULL,NULL,0),(1077,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'OH',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:52',NULL,NULL,0,1,NULL,NULL,0),(1078,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'OK',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:43:59',NULL,NULL,0,1,NULL,NULL,0),(1079,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'OR',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:07',NULL,NULL,0,1,NULL,NULL,0),(1080,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'PA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:11',NULL,NULL,0,1,NULL,NULL,0),(1081,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'RI',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:17',NULL,NULL,0,1,NULL,NULL,0),(1082,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'SC',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:24',NULL,NULL,0,1,NULL,NULL,0),(1083,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'SD',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:30',NULL,NULL,0,1,NULL,NULL,0),(1084,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'TN',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:34',NULL,NULL,0,1,NULL,NULL,0),(1085,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'TX',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:45',NULL,NULL,0,1,NULL,NULL,0),(1086,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'UT',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:44:53',NULL,NULL,0,1,NULL,NULL,0),(1087,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'VT',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:45:03',NULL,NULL,0,1,NULL,NULL,0),(1088,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'VA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:45:09',NULL,NULL,0,1,NULL,NULL,0),(1089,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'WA',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:45:15',NULL,NULL,0,1,NULL,NULL,0),(1090,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'WV',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:45:20',NULL,NULL,0,1,NULL,NULL,0),(1091,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'WI',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:45:27',NULL,NULL,0,1,NULL,NULL,0),(1092,1041,NULL,0,NULL,0,NULL,8,NULL,NULL,'WY',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:45:33',NULL,NULL,0,1,NULL,NULL,0),(1093,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_zip',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 14:56:22',1,'2016-12-13 14:56:32',0,1,NULL,NULL,0),(1094,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_selfreportedtitle',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 15:09:33',1,'2016-12-13 16:12:46',0,1,1,'2017-01-10 15:44:08',1),(1095,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'childassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 15:39:13',1,'2017-01-04 15:48:56',0,1,1,'2017-01-10 15:39:08',1),(1096,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'seniorservicesassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 15:39:49',1,'2016-12-13 21:36:58',0,1,1,'2017-01-10 15:38:03',1),(1097,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'employmentassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:01:09',1,'2016-12-13 22:38:00',0,1,1,'2017-01-10 15:38:55',1),(1098,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'financialassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:02:13',1,'2016-12-13 21:38:17',0,1,1,'2017-01-10 15:38:43',1),(1099,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'foodassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:05:36',1,'2016-12-13 21:38:37',0,1,1,'2017-01-10 15:38:38',1),(1100,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'housingassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:06:05',1,'2016-12-13 21:40:20',0,1,1,'2017-01-10 15:38:21',1),(1101,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'medicalassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:06:33',1,'2016-12-13 21:41:52',0,1,1,'2017-01-10 15:38:13',1),(1102,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'transportationassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:09:28',1,'2017-01-04 15:48:37',0,1,1,'2017-01-10 15:37:58',1),(1103,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Jones  Tom',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:29:47',NULL,NULL,0,1,1,'2016-12-14 00:00:07',1),(1104,1103,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:29:48',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1105,1103,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:29:48',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1106,1103,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:29:48',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1107,1103,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 16:29:48',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1108,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Smith  Tom',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 17:42:23',1,'2016-12-13 18:30:05',0,1,1,'2016-12-14 00:00:07',1),(1109,1108,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 17:42:24',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1110,1108,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 17:42:24',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1111,1108,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 17:42:24',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1112,1108,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 17:42:24',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1113,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'assigned',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:20:32',1,'2017-01-18 20:14:27',0,1,NULL,NULL,0),(1114,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assignedheader',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:27:03',NULL,NULL,0,1,1,'2017-01-10 15:44:02',1),(1115,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'TOm  Jones',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:27:38',NULL,NULL,0,1,1,'2016-12-14 00:00:07',1),(1116,1115,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:27:38',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1117,1115,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:27:38',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1118,1115,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:27:38',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1119,1115,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:27:38',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1120,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'FEMAAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:40:56',1,'2017-01-04 20:44:18',0,1,NULL,NULL,0),(1121,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clienthavefemanumber',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:44:18',NULL,NULL,0,1,NULL,NULL,0),(1122,1121,NULL,0,NULL,0,NULL,12,NULL,NULL,'_femanumber',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:44:51',1,'2016-12-13 23:49:08',0,1,NULL,NULL,0),(1123,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_progressheader',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:45:37',1,'2016-12-14 00:19:59',0,1,NULL,NULL,0),(1124,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientnotreceived',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:46:53',1,'2016-12-13 18:48:08',0,1,NULL,NULL,0),(1125,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientthrewaway',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:48:00',1,'2016-12-13 18:48:17',0,1,NULL,NULL,0),(1126,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_submittedsba',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:58:00',NULL,NULL,0,1,NULL,NULL,0),(1127,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_submittedsbadate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 18:58:36',1,'2016-12-13 19:04:36',0,1,NULL,NULL,0),(1128,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientapproved',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 19:01:56',1,'2016-12-13 23:44:30',0,1,NULL,NULL,0),(1129,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clientapproveddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 19:02:15',1,'2016-12-13 23:44:39',0,1,NULL,NULL,0),(1130,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_submittedclaim',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 19:02:51',1,'2016-12-13 23:44:47',0,1,NULL,NULL,0),(1131,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_submittedclaimdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 19:03:11',1,'2016-12-13 23:44:55',0,1,NULL,NULL,0),(1132,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clienthasreceivednoncomp',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 19:04:06',1,'2016-12-13 23:45:05',0,1,NULL,NULL,0),(1133,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_clienthasreceivednoncompdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 19:05:23',1,'2016-12-13 23:45:28',0,1,NULL,NULL,0),(1134,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes - Another Hispanic, Latino, or Spanish Origin',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:12:22',1,'2016-12-13 20:13:43',0,1,NULL,NULL,0),(1135,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes - Cuban',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:12:29',1,'2016-12-13 20:13:32',0,1,NULL,NULL,0),(1136,226,NULL,0,NULL,0,NULL,8,NULL,NULL,'Yes - Puerto Rican',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:12:41',1,'2016-12-13 20:13:21',0,1,NULL,NULL,0),(1137,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Chinese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:15:24',NULL,NULL,0,1,NULL,NULL,0),(1138,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Filipino',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:15:37',NULL,NULL,0,1,NULL,NULL,0),(1139,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Asian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:15:44',NULL,NULL,0,1,NULL,NULL,0),(1140,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Japanese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:15:53',NULL,NULL,0,1,NULL,NULL,0),(1141,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Korean',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:16:01',NULL,NULL,0,1,NULL,NULL,0),(1142,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Vietnamese',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:16:10',NULL,NULL,0,1,NULL,NULL,0),(1143,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Native Hawaiian',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:16:23',NULL,NULL,0,1,NULL,NULL,0),(1144,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Guamanian or Chamorro',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:17:14',NULL,NULL,0,1,NULL,NULL,0),(1145,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Samoan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:18:21',NULL,NULL,0,1,NULL,NULL,0),(1146,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Other Pacific Islander',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:18:30',NULL,NULL,0,1,NULL,NULL,0),(1147,227,NULL,0,NULL,0,NULL,8,NULL,NULL,'Some other Race',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:18:39',NULL,NULL,0,1,NULL,NULL,0),(1148,279,NULL,0,NULL,0,NULL,12,NULL,NULL,'_specialneedscount',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:21:44',1,'2016-12-13 22:29:02',0,1,NULL,NULL,0),(1149,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_numberinhousehold',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:26:56',1,'2017-01-12 02:51:38',0,1,NULL,NULL,0),(1150,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_unmetneedsheader',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:28:46',1,'2016-12-13 20:30:32',0,1,1,'2017-01-10 15:43:54',1),(1151,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'TriageLevel',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:32:47',NULL,NULL,0,1,NULL,NULL,0),(1152,1151,NULL,0,NULL,0,NULL,8,NULL,NULL,'Emergent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:32:57',NULL,NULL,0,1,NULL,NULL,0),(1153,1151,NULL,0,NULL,0,NULL,8,NULL,NULL,'Urgent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:33:05',NULL,NULL,0,1,NULL,NULL,0),(1154,1151,NULL,0,NULL,0,NULL,8,NULL,NULL,'Non-Urgent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:33:17',NULL,NULL,0,1,NULL,NULL,0),(1155,1151,NULL,0,NULL,0,NULL,8,NULL,NULL,'Not Started',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 20:33:27',1,'2017-01-17 17:23:30',0,1,NULL,NULL,0),(1156,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',1,'2017-01-12 02:01:04',0,1,NULL,NULL,0),(1157,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentOrder',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1158,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_rent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1159,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_mortgage',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1160,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_maintenance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1161,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_carpayment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1162,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_carinsurance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1163,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_gasoline',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1164,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_medical',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1165,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_food',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1166,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_miscellaneous',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1167,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_totalExpenses',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1168,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_totalmonthlyamount',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',NULL,NULL,0,1,NULL,NULL,0),(1169,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',1,'2017-01-11 16:28:03',0,1,NULL,NULL,0),(1170,1169,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:39:32',1,'2017-01-11 16:28:16',0,1,NULL,NULL,0),(1171,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'clothingassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:44:04',NULL,NULL,0,1,1,'2017-01-10 15:39:00',1),(1172,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'femaassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:45:03',1,'2016-12-13 23:05:12',0,1,1,'2017-01-10 15:38:49',1),(1173,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'furnitureandappliancesassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:48:46',1,'2016-12-13 21:49:10',0,1,1,'2017-01-10 15:38:26',1),(1174,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'legalservicesassessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:53:30',NULL,NULL,0,1,1,'2017-01-10 15:38:17',1),(1175,140,NULL,0,NULL,0,NULL,11,NULL,NULL,'LegalServicesAssessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:58:33',1,'2017-01-04 20:45:34',0,1,NULL,NULL,0),(1176,1175,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 21:59:40',1,'2017-01-11 16:06:37',0,1,NULL,NULL,0),(1177,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 22:07:54',1,'2016-12-13 23:54:56',0,1,NULL,NULL,0),(1178,1175,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 22:08:23',NULL,NULL,0,1,NULL,NULL,0),(1179,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'  ',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:06:32',NULL,NULL,0,1,1,'2016-12-14 00:00:07',1),(1180,1179,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:06:32',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1181,1179,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:06:32',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1182,1179,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:06:32',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1183,1179,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:06:32',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1184,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'  ',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:16:40',NULL,NULL,0,1,1,'2016-12-14 00:00:07',1),(1185,1184,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:16:40',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1186,1184,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:16:40',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1187,1184,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:16:40',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1188,1184,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:16:40',NULL,NULL,0,1,1,'2016-12-14 00:00:07',2),(1189,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_iabenefit',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:25:51',1,'2016-12-13 23:54:39',0,1,NULL,NULL,0),(1190,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_iabenefitdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:26:14',1,'2016-12-13 23:46:17',0,1,NULL,NULL,0),(1191,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_maxgrant',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:26:47',1,'2016-12-13 23:46:24',0,1,NULL,NULL,0),(1192,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_maxgrantdate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:27:08',1,'2016-12-13 23:46:43',0,1,NULL,NULL,0),(1193,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_otherneedsassistance',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:27:59',1,'2016-12-13 23:46:52',0,1,NULL,NULL,0),(1194,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_otherneedsassistancedate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:28:46',1,'2016-12-13 23:47:02',0,1,NULL,NULL,0),(1195,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_onareceived',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:29:48',1,'2016-12-13 23:47:16',0,1,NULL,NULL,0),(1196,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_onareceiveddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:30:15',1,'2016-12-13 23:47:29',0,1,NULL,NULL,0),(1197,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_onadenied',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:32:05',1,'2016-12-13 23:47:36',0,1,NULL,NULL,0),(1198,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_onadenieddate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-13 23:33:00',1,'2016-12-13 23:47:45',0,1,NULL,NULL,0),(1199,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Test  ClientWorkflow',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 18:55:20',1,'2017-01-14 00:27:42',0,1,NULL,NULL,0),(1200,1199,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 18:55:20',NULL,NULL,0,1,1,'2016-12-15 19:56:09',1),(1201,1199,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 18:55:20',NULL,NULL,0,1,1,'2016-12-15 19:56:06',1),(1202,1199,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 18:55:20',NULL,NULL,0,1,1,'2016-12-15 19:56:15',1),(1203,1199,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 18:55:20',NULL,NULL,0,1,1,'2016-12-15 19:56:12',1),(1204,1,NULL,0,NULL,0,NULL,5,NULL,NULL,'Reports',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:20:52',NULL,NULL,0,1,NULL,NULL,0),(1205,3,NULL,0,NULL,0,NULL,11,NULL,NULL,'FEMA Report',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:21:16',NULL,NULL,0,1,NULL,NULL,0),(1206,1205,NULL,0,NULL,0,NULL,12,NULL,NULL,'Total Client Contact',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:21:27',1,'2016-12-15 19:25:28',0,1,NULL,NULL,0),(1207,1205,NULL,0,NULL,0,NULL,12,NULL,NULL,'ReportDate',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:24:44',NULL,NULL,0,1,NULL,NULL,0),(1208,1204,NULL,0,NULL,0,NULL,1205,NULL,NULL,'New FEMA Daily Report',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:27:11',NULL,NULL,0,1,NULL,NULL,0),(1209,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test',NULL,'2016-12-19 00:00:00',NULL,NULL,NULL,1,1,'2016-12-15 19:39:23',1,'2016-12-28 21:50:45',0,1,NULL,NULL,0),(1210,1199,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:41:39',1,'2016-12-15 20:47:39',0,1,NULL,NULL,0),(1211,1210,NULL,2,NULL,0,NULL,9,NULL,NULL,'Alls good with this assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:55:37',NULL,NULL,0,1,NULL,NULL,0),(1212,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Recovery  Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:57:15',1,'2017-01-14 04:58:28',0,1,NULL,NULL,0),(1213,1212,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:57:15',NULL,NULL,0,1,NULL,NULL,0),(1214,1212,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:57:15',NULL,NULL,0,1,NULL,NULL,0),(1215,1212,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:57:15',NULL,NULL,0,1,1,'2016-12-15 20:20:02',1),(1216,1212,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:57:15',NULL,NULL,0,1,1,'2016-12-15 20:19:58',1),(1217,1214,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:57:59',1,'2016-12-15 19:59:36',0,1,NULL,NULL,0),(1218,1214,NULL,0,NULL,0,NULL,482,NULL,NULL,'Employment Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 19:58:04',NULL,NULL,0,1,NULL,NULL,0),(1219,1218,NULL,0,NULL,0,NULL,527,NULL,NULL,'Case Note',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 20:08:27',NULL,NULL,0,1,NULL,NULL,0),(1220,1218,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 20:08:54',NULL,NULL,0,1,1,'2016-12-15 20:18:23',1),(1221,1212,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 20:21:25',1,'2017-01-11 21:05:28',0,1,NULL,NULL,0),(1222,1210,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 20:25:41',NULL,NULL,0,1,NULL,NULL,0),(1223,853,NULL,0,NULL,0,NULL,12,NULL,NULL,'referralrecoveryplan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 20:35:53',1,'2016-12-15 20:36:19',0,1,1,'2017-01-11 16:11:27',1),(1224,1212,NULL,0,NULL,0,NULL,440,NULL,NULL,'Housing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 20:37:11',NULL,NULL,0,1,NULL,NULL,0),(1225,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Jennifer  Simpson',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:11:09',1,'2017-01-09 01:35:52',0,1,NULL,NULL,0),(1226,1225,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:11:09',NULL,NULL,0,1,NULL,NULL,0),(1227,1225,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:11:09',NULL,NULL,0,1,NULL,NULL,0),(1228,1225,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:11:09',NULL,NULL,0,1,NULL,NULL,0),(1229,1225,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:11:09',NULL,NULL,0,1,NULL,NULL,0),(1230,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Ter  Whater',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:12:59',1,'2017-01-09 14:38:10',0,1,NULL,NULL,0),(1231,1230,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:12:59',NULL,NULL,0,1,1,'2016-12-15 21:16:49',1),(1232,1230,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:12:59',NULL,NULL,0,1,1,'2016-12-15 21:16:51',1),(1233,1230,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:12:59',NULL,NULL,0,1,1,'2016-12-15 21:17:43',1),(1234,1230,NULL,0,NULL,0,NULL,5,NULL,NULL,'Consent',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:12:59',NULL,NULL,0,1,NULL,NULL,0),(1235,1230,NULL,0,NULL,0,NULL,6,NULL,NULL,'Insider Threat Awareness.pdf','2016-12-15 21:18:17','2016-12-15 21:18:17',904453,NULL,NULL,1,1,'2016-12-15 21:18:17',1,'2016-12-15 21:18:17',0,1,NULL,NULL,0),(1236,1234,NULL,0,NULL,0,NULL,527,NULL,NULL,'Case Note',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:24:22',NULL,NULL,0,1,NULL,NULL,0),(1237,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Person  Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:31:30',1,'2017-01-13 14:58:40',0,1,NULL,NULL,0),(1238,1237,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:31:30',NULL,NULL,0,1,NULL,NULL,0),(1239,1237,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:31:30',NULL,NULL,0,1,NULL,NULL,0),(1240,1237,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:31:30',NULL,NULL,0,1,NULL,NULL,0),(1241,1237,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:31:30',NULL,NULL,0,1,NULL,NULL,0),(1242,1237,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-15 21:32:13',NULL,NULL,0,1,1,'2017-01-03 21:00:53',1),(1243,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Myname  Jonas',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-17 04:03:35',1,'2017-01-18 20:32:57',0,1,NULL,NULL,0),(1244,1243,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-17 04:03:35',NULL,NULL,0,1,NULL,NULL,0),(1245,1243,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-17 04:03:35',NULL,NULL,0,1,NULL,NULL,0),(1246,1243,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-17 04:03:35',NULL,NULL,0,1,NULL,NULL,0),(1247,1243,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-17 04:03:35',NULL,NULL,0,1,NULL,NULL,0),(1248,1237,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,27,'2016-12-17 06:29:49',NULL,NULL,0,27,1,'2017-01-03 21:00:56',1),(1249,1237,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:14:13',NULL,NULL,0,1,1,'2017-01-13 04:24:22',1),(1250,1237,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:14:18',NULL,NULL,0,1,1,'2017-01-13 04:24:20',1),(1251,1225,NULL,0,NULL,0,NULL,6,NULL,NULL,'josh.jpg','2016-12-30 01:18:48','2016-12-30 01:18:48',16401,NULL,NULL,1,1,'2016-12-30 01:18:48',1,'2016-12-30 01:18:48',0,1,NULL,NULL,0),(1252,1225,NULL,0,NULL,0,NULL,289,NULL,NULL,'Test Test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:20:59',NULL,NULL,0,1,NULL,NULL,0),(1253,1225,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:21:43',NULL,NULL,0,1,NULL,NULL,0),(1254,1225,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:21:55',NULL,NULL,0,1,NULL,NULL,0),(1255,1256,NULL,0,NULL,0,NULL,6,NULL,NULL,'josh (1).jpg','2016-12-30 01:22:10','2016-12-30 01:22:10',16401,NULL,NULL,1,1,'2016-12-30 01:22:10',1,'2016-12-30 01:22:10',0,1,1,'2017-01-04 17:48:12',2),(1256,1225,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:22:17',NULL,NULL,0,1,1,'2017-01-04 17:48:12',1),(1257,1258,NULL,0,NULL,0,NULL,6,NULL,NULL,'josh.jpg','2016-12-30 01:48:22','2016-12-30 01:48:22',16401,NULL,NULL,1,1,'2016-12-30 01:48:22',1,'2016-12-30 01:48:22',0,1,1,'2017-01-13 04:24:15',2),(1258,1237,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 01:48:27',NULL,NULL,0,1,1,'2017-01-13 04:24:15',1),(1259,1260,NULL,0,NULL,0,NULL,6,NULL,NULL,'josh.jpg','2016-12-30 02:54:31','2016-12-30 02:54:31',16401,NULL,NULL,1,1,'2016-12-30 02:54:31',1,'2016-12-30 02:54:32',0,1,1,'2017-01-04 15:06:19',2),(1260,1212,NULL,2,NULL,0,NULL,9,NULL,NULL,'test bug fix',NULL,NULL,NULL,NULL,NULL,1,1,'2016-12-30 02:54:35',NULL,NULL,0,1,1,'2017-01-04 15:06:19',1),(1261,1230,NULL,0,NULL,0,NULL,289,NULL,NULL,'Tommy Simpson',NULL,NULL,NULL,NULL,NULL,1,25,'2016-12-30 13:41:13',NULL,NULL,0,25,NULL,NULL,0),(1262,1230,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,25,'2016-12-30 13:41:35',1,'2017-01-11 16:17:29',0,25,NULL,NULL,0),(1263,668,NULL,0,NULL,0,NULL,669,NULL,NULL,'Test Service',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-03 16:31:09',NULL,NULL,0,1,1,'2017-01-11 14:39:14',1),(1264,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_phonenumber',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-03 16:33:28',1,'2017-01-12 02:47:03',0,1,NULL,NULL,0),(1265,1237,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-03 20:47:07',24,'2017-01-06 17:23:11',0,1,1,'2017-01-11 01:42:13',1),(1266,1230,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-03 20:52:33',1,'2017-01-11 16:17:43',0,1,NULL,NULL,0),(1267,1237,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-03 20:53:25',NULL,NULL,0,1,1,'2017-01-11 01:42:17',1),(1268,1237,NULL,0,NULL,0,NULL,440,NULL,NULL,'Housing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-04 20:18:36',NULL,NULL,0,1,1,'2017-01-11 01:42:24',1),(1269,1243,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-04 20:47:39',28,'2017-01-09 21:06:49',0,1,NULL,NULL,0),(1270,1243,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-04 20:55:36',NULL,NULL,0,1,NULL,NULL,0),(1271,1225,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 11:58:54',NULL,NULL,0,1,NULL,NULL,0),(1272,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'identified_unmet_needs',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 15:44:54',1,'2017-01-18 21:57:21',0,1,NULL,NULL,0),(1273,1243,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:34:24',NULL,NULL,0,1,1,'2017-01-11 21:06:50',1),(1274,1230,NULL,2,NULL,0,NULL,9,NULL,NULL,'testlongcomment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:37:05',NULL,NULL,0,1,NULL,NULL,0),(1275,1230,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:37:08',NULL,NULL,0,1,NULL,NULL,0),(1276,1230,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:37:11',NULL,NULL,0,1,NULL,NULL,0),(1277,1230,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:37:15',NULL,NULL,0,1,NULL,NULL,0),(1278,1230,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:37:19',NULL,NULL,0,1,NULL,NULL,0),(1279,1230,NULL,2,NULL,0,NULL,9,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:37:23',NULL,NULL,0,1,NULL,NULL,0),(1280,1230,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:38:32',NULL,NULL,0,1,NULL,NULL,0),(1281,1243,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:40:36',NULL,NULL,0,1,1,'2017-01-11 21:06:54',1),(1282,1243,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:44:55',NULL,NULL,0,1,1,'2017-01-11 21:06:57',1),(1283,1212,NULL,0,NULL,0,NULL,482,NULL,NULL,'Employment Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:50:22',NULL,NULL,0,1,NULL,NULL,0),(1284,1243,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:51:44',NULL,NULL,0,1,1,'2017-01-11 21:05:46',1),(1285,1237,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:55:48',1,'2017-01-13 04:23:47',0,1,NULL,NULL,0),(1286,1237,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 17:58:20',NULL,NULL,0,1,NULL,NULL,0),(1287,1237,NULL,0,NULL,0,NULL,489,NULL,NULL,'Health Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 18:00:15',NULL,NULL,0,1,NULL,NULL,0),(1288,1212,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 18:01:43',NULL,NULL,0,1,NULL,NULL,0),(1289,1212,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 18:01:54',NULL,NULL,0,1,NULL,NULL,0),(1290,1212,NULL,0,NULL,0,NULL,1120,NULL,NULL,'FEMA Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-05 18:05:45',NULL,NULL,0,1,NULL,NULL,0),(1291,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Hodges  Faith',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 10:31:58',NULL,NULL,0,24,NULL,NULL,0),(1292,1291,NULL,0,NULL,0,NULL,289,NULL,NULL,'John Hodges',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 10:43:36',NULL,NULL,0,24,NULL,NULL,0),(1293,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Bill  Johnson',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 10:44:27',NULL,NULL,0,24,NULL,NULL,0),(1294,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Bill  Johnson',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 10:44:46',NULL,NULL,0,24,NULL,NULL,0),(1295,1291,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:11:10',NULL,NULL,0,24,NULL,NULL,0),(1296,1291,NULL,0,NULL,0,NULL,482,NULL,NULL,'Employment Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:20:54',NULL,NULL,0,24,NULL,NULL,0),(1297,1291,NULL,0,NULL,0,NULL,455,NULL,NULL,'Financial Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:21:58',NULL,NULL,0,24,NULL,NULL,0),(1298,1291,NULL,0,NULL,0,NULL,505,NULL,NULL,'Food Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:23:17',NULL,NULL,0,24,NULL,NULL,0),(1299,1291,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:24:23',NULL,NULL,0,24,NULL,NULL,0),(1300,1291,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:25:26',NULL,NULL,0,24,NULL,NULL,0),(1301,1291,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:27:03',NULL,NULL,0,24,NULL,NULL,0),(1302,1291,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:32:23',NULL,NULL,0,24,NULL,NULL,0),(1303,1291,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:33:00',NULL,NULL,0,24,NULL,NULL,0),(1304,1291,NULL,0,NULL,0,NULL,527,NULL,NULL,'Case Note',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 11:34:42',NULL,NULL,0,24,NULL,NULL,0),(1305,1291,NULL,0,NULL,0,NULL,6,NULL,NULL,'Alert X.png','2017-01-06 13:37:23','2017-01-06 13:37:23',200056,NULL,NULL,1,24,'2017-01-06 13:37:23',24,'2017-01-06 13:37:23',0,24,NULL,NULL,0),(1306,1291,NULL,0,NULL,0,NULL,6,NULL,NULL,'New Page.png','2017-01-06 13:37:24','2017-01-06 13:37:24',138627,NULL,NULL,1,24,'2017-01-06 13:37:24',24,'2017-01-06 13:37:24',0,24,NULL,NULL,0),(1307,1,NULL,0,NULL,0,NULL,669,NULL,NULL,'Will''s Auto Body',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 15:32:33',NULL,NULL,0,24,NULL,NULL,0),(1308,1291,NULL,2,NULL,0,NULL,9,NULL,NULL,'blah blah blah',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 15:53:49',NULL,NULL,0,24,NULL,NULL,0),(1309,1291,NULL,2,NULL,0,NULL,9,NULL,NULL,'Super thanks for asking',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 15:54:03',NULL,NULL,0,24,NULL,NULL,0),(1310,1291,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 16:07:33',NULL,NULL,0,24,NULL,NULL,0),(1311,1294,NULL,2,NULL,0,NULL,9,NULL,NULL,'Wanted to make sure they had enough food so I sent them to a food bank',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 16:35:47',NULL,NULL,0,24,NULL,NULL,0),(1312,1294,NULL,2,NULL,0,NULL,9,NULL,NULL,'Talked to them on the phone and updated the notes for the referred serviecs',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 16:36:19',NULL,NULL,0,24,NULL,NULL,0),(1313,1294,NULL,2,NULL,0,NULL,9,NULL,NULL,'They got everything they needed and are back to normal',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-06 16:36:33',NULL,NULL,0,24,NULL,NULL,0),(1314,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Test  Test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 00:42:37',1,'2017-01-13 18:59:22',0,1,NULL,NULL,0),(1315,1314,NULL,0,NULL,0,NULL,5,NULL,NULL,'Client Intake',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 00:42:37',NULL,NULL,0,1,NULL,NULL,0),(1316,1314,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assessments',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 00:42:37',NULL,NULL,0,1,NULL,NULL,0),(1317,1314,NULL,0,NULL,0,NULL,5,NULL,NULL,'Referrals',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 00:42:37',NULL,NULL,0,1,NULL,NULL,0),(1318,1314,NULL,0,NULL,0,NULL,5,NULL,NULL,'Recovery Plan',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 00:42:37',NULL,NULL,0,1,NULL,NULL,0),(1319,3,NULL,0,NULL,0,NULL,11,NULL,NULL,'Responder',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 14:20:53',NULL,NULL,0,1,1,'2017-01-09 14:21:54',1),(1320,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Dan  Stoudt',NULL,NULL,NULL,NULL,NULL,1,29,'2017-01-09 20:28:31',NULL,NULL,0,29,NULL,NULL,0),(1321,1243,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-09 21:03:52',NULL,NULL,0,1,1,'2017-01-09 21:03:57',1),(1322,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_atriskheader',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:04:58',NULL,NULL,0,1,NULL,NULL,0),(1323,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_fematier',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:11:37',1,'2017-01-10 16:13:41',0,1,NULL,NULL,0),(1324,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'FEMATier',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:12:04',NULL,NULL,0,1,NULL,NULL,0),(1325,1324,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 1',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:12:15',NULL,NULL,0,1,NULL,NULL,0),(1326,1324,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 2',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:12:22',NULL,NULL,0,1,NULL,NULL,0),(1327,1324,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 3',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:12:29',NULL,NULL,0,1,NULL,NULL,0),(1328,1324,NULL,0,NULL,0,NULL,8,NULL,NULL,'Tier 4',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:12:36',NULL,NULL,0,1,NULL,NULL,0),(1329,150,NULL,0,NULL,0,NULL,141,NULL,NULL,'Test  Test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 16:19:10',1,'2017-01-18 15:19:42',0,1,NULL,NULL,0),(1330,1331,NULL,0,NULL,0,NULL,669,NULL,NULL,'Childcare',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:45:30',1,'2017-01-10 20:58:23',0,1,1,'2017-01-11 14:39:14',2),(1331,668,NULL,0,NULL,0,NULL,669,NULL,NULL,'Child Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:45:44',NULL,NULL,0,1,1,'2017-01-11 14:39:14',1),(1332,333,NULL,0,NULL,0,NULL,8,NULL,NULL,'ChildServices',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:46:36',NULL,NULL,0,1,1,'2017-01-10 21:20:04',1),(1333,1332,NULL,0,NULL,0,NULL,8,NULL,NULL,'Childcare',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:47:15',NULL,NULL,0,1,1,'2017-01-10 21:20:04',2),(1334,1332,NULL,0,NULL,0,NULL,8,NULL,NULL,'School District',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:47:32',NULL,NULL,0,1,1,'2017-01-10 21:20:04',2),(1335,1332,NULL,0,NULL,0,NULL,8,NULL,NULL,'Head Start/ Early Head Start',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:47:44',NULL,NULL,0,1,1,'2017-01-10 21:20:04',2),(1336,1332,NULL,0,NULL,0,NULL,8,NULL,NULL,'Social Services or Family Court for child support payment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:47:56',NULL,NULL,0,1,1,'2017-01-10 21:20:04',2),(1337,1330,NULL,0,NULL,0,NULL,669,NULL,NULL,'Bob''s Burgers',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:58:38',NULL,NULL,0,1,1,'2017-01-11 14:39:14',2),(1338,1331,NULL,0,NULL,0,NULL,669,NULL,NULL,'School District',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 20:59:06',NULL,NULL,0,1,1,'2017-01-11 14:39:14',2),(1339,668,NULL,0,NULL,0,NULL,669,NULL,NULL,'Bob''s Burgers Childcare',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:01:30',NULL,NULL,0,1,1,'2017-01-11 14:39:14',1),(1340,4,NULL,0,NULL,0,NULL,8,NULL,NULL,'Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:10:03',NULL,NULL,0,1,1,'2017-01-10 21:10:38',1),(1341,4,NULL,0,NULL,0,NULL,5,NULL,NULL,'Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:10:28',NULL,NULL,0,1,NULL,NULL,0),(1342,1341,NULL,0,NULL,0,NULL,8,NULL,NULL,'Child Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:11:17',NULL,NULL,0,1,NULL,NULL,0),(1343,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'School District',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:11:36',NULL,NULL,0,1,NULL,NULL,0),(1344,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Childcare',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:11:46',NULL,NULL,0,1,NULL,NULL,0),(1345,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Head Start / Early Head Start',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:12:00',NULL,NULL,0,1,NULL,NULL,0),(1346,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Social Services or Family Court for Child Support Payment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:12:23',NULL,NULL,0,1,NULL,NULL,0),(1347,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to Child Care and referral Agency',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:12:38',NULL,NULL,0,1,NULL,NULL,0),(1348,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to Disaster Distress Helpline',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:12:50',NULL,NULL,0,1,NULL,NULL,0),(1349,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to social services for TANF/ CCDF application',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:14:53',NULL,NULL,0,1,NULL,NULL,0),(1350,1342,NULL,0,NULL,0,NULL,8,NULL,NULL,'Referral to VOAD/ community group for school supplies',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:15:04',NULL,NULL,0,1,NULL,NULL,0),(1351,1329,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:17:26',NULL,NULL,0,1,1,'2017-01-17 18:18:06',1),(1352,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_servicetype',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:24:39',1,'2017-01-10 21:29:10',0,1,1,'2017-01-11 13:57:11',1),(1353,1352,NULL,0,NULL,0,NULL,12,NULL,NULL,'_servicesubtype',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:25:12',1,'2017-01-10 21:27:43',0,1,1,'2017-01-11 13:57:11',2),(1354,668,NULL,0,NULL,0,NULL,669,NULL,NULL,'New Service',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:32:55',NULL,NULL,0,1,1,'2017-01-11 14:39:14',1),(1355,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_service',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:54:17',NULL,NULL,0,1,1,'2017-01-11 17:00:07',1),(1356,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referraltype',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:54:57',1,'2017-01-11 20:32:16',0,1,NULL,NULL,0),(1357,1356,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:56:15',1,'2017-01-11 18:28:11',0,1,NULL,NULL,0),(1358,1357,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 21:56:59',1,'2017-01-11 17:02:18',0,1,1,'2017-01-11 18:28:00',1),(1359,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Child',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 22:11:23',NULL,NULL,0,1,NULL,NULL,0),(1360,1359,NULL,0,NULL,0,NULL,5,NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-10 22:11:33',NULL,NULL,0,1,1,'2017-01-11 14:20:59',1),(1361,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:33:03',NULL,NULL,0,1,NULL,NULL,0),(1362,1361,NULL,0,NULL,0,NULL,5,NULL,NULL,'FEMA -Transitional Shelter Assistance (TSA)',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:34:26',NULL,NULL,0,1,1,'2017-01-11 17:37:58',1),(1363,1361,NULL,0,NULL,0,NULL,5,NULL,NULL,'Emergency Housing Mass Care Shelter',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:35:28',NULL,NULL,0,1,1,'2017-01-11 17:37:58',1),(1364,1361,NULL,0,NULL,0,NULL,5,NULL,NULL,'Other Emergency Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:35:40',NULL,NULL,0,1,1,'2017-01-11 17:37:58',1),(1365,1361,NULL,0,NULL,0,NULL,5,NULL,NULL,'Assistance Housing Reservation (e.g.ARC)',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:35:56',NULL,NULL,0,1,1,'2017-01-11 17:37:58',1),(1366,1361,NULL,0,NULL,0,NULL,5,NULL,NULL,'Tarp / Blue Roof',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:36:10',NULL,NULL,0,1,1,'2017-01-11 17:37:58',1),(1367,1361,NULL,0,NULL,0,NULL,5,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:36:27',NULL,NULL,0,1,1,'2017-01-11 17:37:58',1),(1368,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:41:10',1,'2017-01-11 16:03:41',0,1,1,'2017-01-11 16:11:35',1),(1369,1365,NULL,0,NULL,0,NULL,669,NULL,NULL,'ARC',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:47:16',NULL,NULL,0,1,1,'2017-01-11 17:37:58',2),(1370,1212,NULL,0,NULL,0,NULL,440,NULL,NULL,'Housing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:48:36',NULL,NULL,0,1,NULL,NULL,0),(1371,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Behavioral Health',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:56:52',NULL,NULL,0,1,NULL,NULL,0),(1372,1371,NULL,0,NULL,0,NULL,669,NULL,NULL,'Community clinical provider',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 01:57:04',1,'2017-01-11 17:49:59',0,1,NULL,NULL,0),(1373,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'FEMA',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 13:57:59',NULL,NULL,0,1,NULL,NULL,0),(1374,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with appeal for SBA denial',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 13:59:26',NULL,NULL,0,1,NULL,NULL,0),(1375,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with completion of FEMA IA Application',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 13:59:57',NULL,NULL,0,1,NULL,NULL,0),(1376,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with completion of FEMA ONA Application',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:00:24',NULL,NULL,0,1,NULL,NULL,0),(1377,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with completion of SBA Loan Applications',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:00:34',NULL,NULL,0,1,NULL,NULL,0),(1378,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with FEMA IA denial',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:00:43',NULL,NULL,0,1,NULL,NULL,0),(1379,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with FEMA ONA denial',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:00:52',NULL,NULL,0,1,NULL,NULL,0),(1380,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assist with FEMA/SBA Sequence of Delivery',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:01:04',NULL,NULL,0,1,NULL,NULL,0),(1381,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Obtain signed FEMA Disclosure release from client',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:01:56',NULL,NULL,0,1,NULL,NULL,0),(1382,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Provide education regarding FEMA/SBA Sequence of Delivery',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:02:32',NULL,NULL,0,1,NULL,NULL,0),(1383,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Submit inquiry to FEMA IA Branch re: client''s IA',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:02:45',NULL,NULL,0,1,NULL,NULL,0),(1384,1373,NULL,0,NULL,0,NULL,669,NULL,NULL,'Submit inquiry to FEMA IA Branch: client''s ONA',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:02:53',NULL,NULL,0,1,NULL,NULL,0),(1385,1361,NULL,0,NULL,0,NULL,669,NULL,NULL,'FEMA -Transitional Shelter Assistance (TSA)',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:23:57',NULL,NULL,0,1,NULL,NULL,0),(1386,1361,NULL,0,NULL,0,NULL,669,NULL,NULL,'Emergency Housing Mass Care Shelter ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:24:08',NULL,NULL,0,1,NULL,NULL,0),(1387,1361,NULL,0,NULL,0,NULL,669,NULL,NULL,'Other Emergency Housing ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:24:23',NULL,NULL,0,1,NULL,NULL,0),(1388,1361,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance Housing Reservation (e.g.ARC)',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:24:33',NULL,NULL,0,1,NULL,NULL,0),(1389,1361,NULL,0,NULL,0,NULL,669,NULL,NULL,'Tarp / Blue Roof',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:24:43',NULL,NULL,0,1,NULL,NULL,0),(1390,1361,NULL,0,NULL,0,NULL,669,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:24:56',NULL,NULL,0,1,NULL,NULL,0),(1391,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Financial',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:28:49',1,'2017-01-11 14:29:05',0,1,NULL,NULL,0),(1392,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Transportation',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:29:59',NULL,NULL,0,1,NULL,NULL,0),(1393,1391,NULL,0,NULL,0,NULL,669,NULL,NULL,'Disaster Unemployment Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:32:06',NULL,NULL,0,1,NULL,NULL,0),(1394,1391,NULL,0,NULL,0,NULL,669,NULL,NULL,'Grant Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:33:53',NULL,NULL,0,1,NULL,NULL,0),(1395,1391,NULL,0,NULL,0,NULL,669,NULL,NULL,'Other',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:33:58',NULL,NULL,0,1,NULL,NULL,0),(1396,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Employment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:36:36',NULL,NULL,0,1,NULL,NULL,0),(1397,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Clothing',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:36:47',NULL,NULL,0,1,NULL,NULL,0),(1398,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Food',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:36:59',NULL,NULL,0,1,NULL,NULL,0),(1399,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Health',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:37:45',NULL,NULL,0,1,NULL,NULL,0),(1400,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Language',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:37:59',NULL,NULL,0,1,NULL,NULL,0),(1401,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Legal Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:38:19',NULL,NULL,0,1,NULL,NULL,0),(1402,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Medical',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:38:43',NULL,NULL,0,1,NULL,NULL,0),(1403,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Senior Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:39:00',NULL,NULL,0,1,NULL,NULL,0),(1404,1399,NULL,0,NULL,0,NULL,669,NULL,NULL,'Medication',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:52:45',NULL,NULL,0,1,NULL,NULL,0),(1405,1399,NULL,0,NULL,0,NULL,669,NULL,NULL,'Durable Medical Equipment (e.g. wheelchair,cane)',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:53:00',NULL,NULL,0,1,NULL,NULL,0),(1406,1399,NULL,0,NULL,0,NULL,669,NULL,NULL,'Clinic Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 14:53:13',NULL,NULL,0,1,NULL,NULL,0),(1407,1392,NULL,0,NULL,0,NULL,669,NULL,NULL,'Bus Pass',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:08:13',NULL,NULL,0,1,NULL,NULL,0),(1408,1392,NULL,0,NULL,0,NULL,669,NULL,NULL,'Bus Tokens',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:08:20',NULL,NULL,0,1,NULL,NULL,0),(1409,1392,NULL,0,NULL,0,NULL,669,NULL,NULL,'Transportation',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:08:30',1,'2017-01-11 15:12:17',0,1,NULL,NULL,0),(1410,1371,NULL,0,NULL,0,NULL,669,NULL,NULL,'Crisis Counseling Program',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:12:52',NULL,NULL,0,1,NULL,NULL,0),(1411,1371,NULL,0,NULL,0,NULL,669,NULL,NULL,'Disaster Distress Helpline',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:13:05',NULL,NULL,0,1,NULL,NULL,0),(1412,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'School District',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:14:14',NULL,NULL,0,1,NULL,NULL,0),(1413,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Childcare',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:14:22',NULL,NULL,0,1,NULL,NULL,0),(1414,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Head Start/ Early Head Start',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:14:30',NULL,NULL,0,1,NULL,NULL,0),(1415,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Social Services or Family Court for child support payment ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:14:37',NULL,NULL,0,1,NULL,NULL,0),(1416,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to Child Care and referral Agency',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:14:45',NULL,NULL,0,1,NULL,NULL,0),(1417,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to Disaster Distress Helpline',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:14:57',NULL,NULL,0,1,NULL,NULL,0),(1418,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to social services for TANF/ CCDF application',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:15:06',NULL,NULL,0,1,NULL,NULL,0),(1419,1359,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to VOAD/ community group for school supplies',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:15:17',NULL,NULL,0,1,NULL,NULL,0),(1420,1398,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with D-SNAP application',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:15:41',NULL,NULL,0,1,NULL,NULL,0),(1421,1398,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to community organizations for food needs',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:16:00',NULL,NULL,0,1,NULL,NULL,0),(1422,1398,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to mass care assistance  for immediate food needs',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:16:14',NULL,NULL,0,1,NULL,NULL,0),(1423,1398,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referred to Senior Meals on Wheels Services',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:16:25',NULL,NULL,0,1,NULL,NULL,0),(1424,1398,NULL,0,NULL,0,NULL,669,NULL,NULL,'Social Services for WIC/ SNAP/D-SNAP',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:16:35',NULL,NULL,0,1,NULL,NULL,0),(1425,1397,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with FEMA ONA',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:16:54',NULL,NULL,0,1,NULL,NULL,0),(1426,1397,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with insurance claim/ appeal',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:17:02',NULL,NULL,0,1,NULL,NULL,0),(1427,1397,NULL,0,NULL,0,NULL,669,NULL,NULL,'Laundry Assistance',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:17:08',NULL,NULL,0,1,NULL,NULL,0),(1428,1397,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to faith- based/ community organization for clothing',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:17:21',NULL,NULL,0,1,NULL,NULL,0),(1429,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Furniture And Appliances',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:25:10',NULL,NULL,0,1,NULL,NULL,0),(1430,1429,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with FEMA ONA',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:25:17',NULL,NULL,0,1,NULL,NULL,0),(1431,1429,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with install of new or removal of old',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:25:26',NULL,NULL,0,1,NULL,NULL,0),(1432,1429,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with insurance claim/ appeal',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:25:33',NULL,NULL,0,1,NULL,NULL,0),(1433,1429,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to faith- based/ community organization for replacement',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:26:08',NULL,NULL,0,1,NULL,NULL,0),(1434,1403,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with accessing VA benefits',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:28:12',NULL,NULL,0,1,NULL,NULL,0),(1435,1403,NULL,0,NULL,0,NULL,669,NULL,NULL,'Assistance with LIHEAP application',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:28:23',NULL,NULL,0,1,NULL,NULL,0),(1436,1403,NULL,0,NULL,0,NULL,669,NULL,NULL,'Home delivered meals (e.g., Meals on Wheels)',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:28:33',NULL,NULL,0,1,NULL,NULL,0),(1437,1403,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to Adult Day Health Care Center',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:28:41',NULL,NULL,0,1,NULL,NULL,0),(1438,1403,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to area agency on aging',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:28:53',NULL,NULL,0,1,NULL,NULL,0),(1439,1403,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to senior center',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:29:01',1,'2017-01-11 18:06:39',0,1,NULL,NULL,0),(1440,1400,NULL,0,NULL,0,NULL,669,NULL,NULL,'Language resources',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:29:20',NULL,NULL,0,1,NULL,NULL,0),(1441,1400,NULL,0,NULL,0,NULL,669,NULL,NULL,'State language telephone line',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:29:27',NULL,NULL,0,1,NULL,NULL,0),(1442,1401,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to Disaster Legal Services Program',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:31:32',NULL,NULL,0,1,NULL,NULL,0),(1443,1401,NULL,0,NULL,0,NULL,669,NULL,NULL,'Referral to Legal Aid',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:31:43',NULL,NULL,0,1,NULL,NULL,0),(1444,1401,NULL,0,NULL,0,NULL,669,NULL,NULL,'Other Legal Service ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:32:01',NULL,NULL,0,1,NULL,NULL,0),(1445,668,NULL,0,NULL,0,NULL,5,NULL,NULL,'Health Insurance And Health Care Access',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:37:32',1,'2017-01-11 15:38:26',0,1,1,'2017-01-11 15:38:55',1),(1446,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:45:31',1,'2017-01-11 16:34:23',0,1,NULL,NULL,0),(1447,1446,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 15:45:52',1,'2017-01-11 16:30:04',0,1,NULL,NULL,0),(1448,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralneeded',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 16:01:58',1,'2017-01-11 16:24:04',0,1,NULL,NULL,0),(1449,1448,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 16:01:58',1,'2017-01-11 16:25:04',0,1,NULL,NULL,0),(1450,1176,NULL,0,NULL,0,NULL,12,NULL,NULL,'_referralservice',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 16:04:45',1,'2017-01-11 16:05:04',0,1,NULL,NULL,0),(1451,1225,NULL,0,NULL,0,NULL,559,NULL,NULL,'Furniture and Appliances Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 16:21:16',NULL,NULL,0,1,NULL,NULL,0),(1452,1396,NULL,0,NULL,0,NULL,669,NULL,NULL,'Employment Placement Service',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 16:38:57',NULL,NULL,0,1,NULL,NULL,0),(1453,1396,NULL,0,NULL,0,NULL,669,NULL,NULL,'Job Hunting Resources',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 16:39:36',1,'2017-01-11 16:39:47',0,1,NULL,NULL,0),(1454,669,NULL,0,NULL,0,NULL,12,NULL,NULL,'_providers',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 17:49:15',NULL,NULL,0,1,NULL,NULL,0),(1455,1243,NULL,0,NULL,0,NULL,607,NULL,NULL,'Referral',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 20:30:16',NULL,NULL,0,1,1,'2017-01-11 21:07:00',1),(1456,1237,NULL,0,NULL,0,NULL,607,NULL,NULL,'Behavioral Health Referral - Referral Made Information Only',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 21:00:37',1,'2017-01-12 17:39:01',0,1,NULL,NULL,0),(1457,1212,NULL,0,NULL,0,NULL,607,NULL,NULL,'Behavioral Health Referral - Referral Made Rejected',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 21:03:33',1,'2017-01-13 19:37:53',0,1,NULL,NULL,0),(1458,1243,NULL,0,NULL,0,NULL,607,NULL,NULL,'Clothing Referral - Referral Made Information Only',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-11 21:07:18',1,'2017-01-11 21:11:46',0,1,NULL,NULL,0),(1459,510,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:13:57',NULL,NULL,0,1,NULL,NULL,0),(1460,533,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:14:10',1,'2017-01-12 01:20:27',0,1,NULL,NULL,0),(1461,553,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:14:19',1,'2017-01-12 01:20:43',0,1,NULL,NULL,0),(1462,482,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:14:26',1,'2017-01-12 01:31:12',0,1,NULL,NULL,0),(1463,1120,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:14:52',1,'2017-01-12 01:32:21',0,1,NULL,NULL,0),(1464,455,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:02',1,'2017-01-12 01:21:23',0,1,NULL,NULL,0),(1465,505,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:09',1,'2017-01-12 01:21:43',0,1,NULL,NULL,0),(1466,559,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:15',1,'2017-01-12 01:21:56',0,1,NULL,NULL,0),(1467,489,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:22',1,'2017-01-12 01:22:12',0,1,NULL,NULL,0),(1468,440,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:29',1,'2017-01-12 01:22:26',0,1,NULL,NULL,0),(1469,656,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:35',1,'2017-01-12 01:22:38',0,1,NULL,NULL,0),(1470,1175,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:15:41',1,'2017-01-12 01:22:49',0,1,NULL,NULL,0),(1471,607,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:16:03',NULL,NULL,0,1,1,'2017-01-12 01:16:08',1),(1472,651,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:16:13',1,'2017-01-12 01:23:00',0,1,NULL,NULL,0),(1473,172,NULL,0,NULL,0,NULL,12,NULL,NULL,'_assessmentnote',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:16:18',1,'2017-01-12 01:23:16',0,1,NULL,NULL,0),(1474,1199,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 01:20:03',NULL,NULL,0,1,NULL,NULL,0),(1475,1199,NULL,0,NULL,0,NULL,455,NULL,NULL,'Financial Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 02:01:54',NULL,NULL,0,1,NULL,NULL,0),(1476,1212,NULL,0,NULL,0,NULL,289,NULL,NULL,'Tom Jones',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 02:40:57',NULL,NULL,0,1,NULL,NULL,0),(1477,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'Test',NULL,'2017-01-11 01:45:00',NULL,NULL,NULL,1,1,'2017-01-12 03:40:49',NULL,NULL,0,1,NULL,NULL,0),(1478,1237,NULL,0,NULL,0,NULL,289,NULL,NULL,'Test Test - Dependent Child',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 15:25:13',NULL,NULL,0,1,NULL,NULL,0),(1479,141,NULL,0,NULL,0,NULL,12,NULL,NULL,'_familymembers',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 17:30:35',NULL,NULL,0,1,1,'2017-01-13 19:03:00',1),(1480,1237,NULL,0,NULL,0,NULL,607,NULL,NULL,'Child Referral - Referral Made ServiceProvided',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-12 17:37:26',NULL,NULL,0,1,NULL,NULL,0),(1481,1199,NULL,0,NULL,0,NULL,527,NULL,NULL,'Case Note',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 15:41:02',NULL,NULL,0,1,NULL,NULL,0),(1482,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Jillian  Sampson',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:04:14',1,'2017-01-18 20:02:00',0,1,NULL,NULL,0),(1483,1482,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:04:57',NULL,NULL,0,1,NULL,NULL,0),(1484,1482,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:05:22',NULL,NULL,0,1,NULL,NULL,0),(1485,1482,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:05:44',NULL,NULL,0,1,NULL,NULL,0),(1486,1482,NULL,0,NULL,0,NULL,482,NULL,NULL,'Employment Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:06:11',NULL,NULL,0,1,NULL,NULL,0),(1487,1482,NULL,0,NULL,0,NULL,607,NULL,NULL,'Behavioral Health Referral - Referral Made ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:06:30',NULL,NULL,0,1,NULL,NULL,0),(1488,1482,NULL,0,NULL,0,NULL,607,NULL,NULL,'Child Referral - Not Eligible ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:06:46',NULL,NULL,0,1,NULL,NULL,0),(1489,1482,NULL,2,NULL,0,NULL,9,NULL,NULL,'Awesome',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 16:46:45',NULL,NULL,0,1,NULL,NULL,0),(1490,1314,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 17:46:52',NULL,NULL,0,1,1,'2017-01-13 18:51:56',1),(1491,1314,NULL,0,NULL,0,NULL,1175,NULL,NULL,'Legal Services Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 18:52:54',1,'2017-01-13 18:53:02',0,1,NULL,NULL,0),(1492,1212,NULL,0,NULL,0,NULL,289,NULL,NULL,'Simpson Joes - Daughter',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 19:04:49',NULL,NULL,0,1,NULL,NULL,0),(1493,1212,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 19:37:28',NULL,NULL,0,1,NULL,NULL,0),(1494,1329,NULL,0,NULL,0,NULL,527,NULL,NULL,'Case Note',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 19:42:25',NULL,NULL,0,1,NULL,NULL,0),(1495,1329,NULL,0,NULL,0,NULL,527,NULL,NULL,'Case Note',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-13 19:42:33',NULL,NULL,0,1,NULL,NULL,0),(1496,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'AtRiskPopulations',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:38:18',1,'2017-01-14 00:49:25',0,1,NULL,NULL,0),(1497,1496,NULL,0,NULL,0,NULL,8,NULL,NULL,'Children',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:43:28',1,'2017-01-14 01:35:55',0,1,NULL,NULL,0),(1498,1496,NULL,0,NULL,0,NULL,8,NULL,NULL,'Elderly',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:46:26',1,'2017-01-14 01:36:18',0,1,NULL,NULL,0),(1499,1496,NULL,0,NULL,0,NULL,8,NULL,NULL,'Individual Disabilities in the household',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:47:16',1,'2017-01-14 01:37:06',0,1,NULL,NULL,0),(1500,1496,NULL,0,NULL,0,NULL,8,NULL,NULL,'Domestic Violence Survivors',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:47:39',1,'2017-01-14 01:37:37',0,1,NULL,NULL,0),(1501,1496,NULL,0,NULL,0,NULL,8,NULL,NULL,'Individuals with Limited English Proficiency',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:48:20',1,'2017-01-14 01:38:02',0,1,NULL,NULL,0),(1502,1496,NULL,0,NULL,0,NULL,8,NULL,NULL,'None Self-Reported',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:49:41',1,'2017-01-14 01:30:05',0,1,NULL,NULL,0),(1503,136,NULL,0,NULL,0,NULL,8,NULL,NULL,'IdentifiedNeeds',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:10',NULL,NULL,0,1,NULL,NULL,0),(1504,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Food',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:45',1,'2017-01-14 01:01:22',0,1,NULL,NULL,0),(1505,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Legal',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:45',1,'2017-01-14 01:19:49',0,1,NULL,NULL,0),(1506,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'FEMA Help',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:45',1,'2017-01-14 01:20:14',0,1,NULL,NULL,0),(1507,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Clothing',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:45',1,'2017-01-14 00:56:07',0,1,NULL,NULL,0),(1508,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Employment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:45',1,'2017-01-14 00:55:19',0,1,NULL,NULL,0),(1509,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'None Identified',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 00:50:45',1,'2017-01-14 01:19:17',0,1,NULL,NULL,0),(1510,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Furniture and/or appliances',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:02:02',1,'2017-01-14 01:21:16',0,1,NULL,NULL,0),(1511,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Behavioral Health',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:03:34',1,'2017-01-14 01:03:53',0,1,NULL,NULL,0),(1512,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Health Insurance or Health Access',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:04:19',1,'2017-01-14 01:04:46',0,1,NULL,NULL,0),(1513,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Transportation',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:05:30',NULL,NULL,0,1,NULL,NULL,0),(1514,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Housing',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:06:47',1,'2017-01-14 01:22:08',0,1,NULL,NULL,0),(1515,1503,NULL,0,NULL,0,NULL,8,NULL,NULL,'Finances',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:08:10',1,'2017-01-14 01:22:35',0,1,NULL,NULL,0),(1516,1,NULL,0,NULL,0,NULL,7,NULL,NULL,'test',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-14 01:30:52',NULL,NULL,0,1,NULL,NULL,0),(1517,1151,NULL,0,NULL,0,NULL,8,NULL,NULL,'Not Started',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 17:22:46',NULL,NULL,0,1,1,'2017-01-17 17:23:37',1),(1518,1482,NULL,0,NULL,0,NULL,607,NULL,NULL,'Language Referral - Referral Made ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:15:33',1,'2017-01-17 18:15:59',0,1,NULL,NULL,0),(1519,1482,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:15:33',NULL,NULL,0,1,NULL,NULL,0),(1520,1482,NULL,0,NULL,0,NULL,607,NULL,NULL,'Senior Services Referral - Not Started ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:16:24',NULL,NULL,0,1,NULL,NULL,0),(1521,1482,NULL,0,NULL,0,NULL,607,NULL,NULL,'Senior Services Referral - Not Started ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:16:24',NULL,NULL,0,1,NULL,NULL,0),(1522,1482,NULL,0,NULL,0,NULL,651,NULL,NULL,'Senior Services Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:16:24',NULL,NULL,0,1,NULL,NULL,0),(1523,1329,NULL,0,NULL,0,NULL,607,NULL,NULL,'Behavioral Health [Community clinical provider] Referral - Not Started ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:18:34',NULL,NULL,0,1,NULL,NULL,0),(1524,1329,NULL,0,NULL,0,NULL,607,NULL,NULL,'Behavioral Health [Crisis Counseling Program] Referral - Referral Made ',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:18:34',1,'2017-01-17 18:18:46',0,1,NULL,NULL,0),(1525,1329,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-17 18:18:34',NULL,NULL,0,1,NULL,NULL,0),(1526,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Johnson  Sara',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:08:06',NULL,NULL,0,24,NULL,NULL,0),(1527,1526,NULL,0,NULL,0,NULL,289,NULL,NULL,'Rebecca Johnson - Daughter',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:09:52',NULL,NULL,0,24,NULL,NULL,0),(1528,1526,NULL,0,NULL,0,NULL,289,NULL,NULL,'Rebecca Johnson - Daughter',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:12:05',NULL,NULL,0,24,NULL,NULL,0),(1529,1526,NULL,0,NULL,0,NULL,607,NULL,NULL,'Behavioral Health [Disaster Distress Helpline] Referral - Not Started ',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:13:35',24,'2017-01-18 14:15:18',0,24,NULL,NULL,0),(1530,1526,NULL,0,NULL,0,NULL,510,NULL,NULL,'Behavioral Health Advocacy Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:13:35',NULL,NULL,0,24,NULL,NULL,0),(1531,1526,NULL,0,NULL,0,NULL,607,NULL,NULL,'Child [Head Start/ Early Head Start] Referral - Not Started ',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:14:30',NULL,NULL,0,24,NULL,NULL,0),(1532,1526,NULL,0,NULL,0,NULL,533,NULL,NULL,'Children and Youth Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:14:30',NULL,NULL,0,24,NULL,NULL,0),(1533,1526,NULL,0,NULL,0,NULL,553,NULL,NULL,'Clothing Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:15:50',NULL,NULL,0,24,NULL,NULL,0),(1534,1526,NULL,0,NULL,0,NULL,607,NULL,NULL,'Food [Referral to mass care assistance  for immediate food needs] Referral - Not Started ',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:16:22',NULL,NULL,0,24,NULL,NULL,0),(1535,1526,NULL,0,NULL,0,NULL,505,NULL,NULL,'Food Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:16:23',NULL,NULL,0,24,NULL,NULL,0),(1536,1526,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:16:41',NULL,NULL,0,24,24,'2017-01-18 14:17:32',1),(1537,1526,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:16:50',NULL,NULL,0,24,NULL,NULL,0),(1538,1526,NULL,0,NULL,0,NULL,1175,NULL,NULL,'Legal Services Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:17:03',NULL,NULL,0,24,NULL,NULL,0),(1539,1526,NULL,0,NULL,0,NULL,607,NULL,NULL,'Transportation [Bus Pass] Referral - Referral Made ',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:17:19',24,'2017-01-18 20:36:22',0,24,NULL,NULL,0),(1540,1526,NULL,0,NULL,0,NULL,172,NULL,NULL,'Transportation Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:17:20',NULL,NULL,0,24,NULL,NULL,0),(1541,1526,NULL,0,NULL,0,NULL,656,NULL,NULL,'Language Assessment',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 14:18:31',NULL,NULL,0,24,NULL,NULL,0),(1542,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'jones  tom',NULL,NULL,NULL,NULL,NULL,1,1,'2017-01-18 20:01:05',NULL,NULL,0,1,NULL,NULL,0),(1543,1,NULL,0,NULL,0,NULL,141,NULL,NULL,'Catherine  Smoot',NULL,NULL,NULL,NULL,NULL,1,24,'2017-01-18 20:14:47',NULL,NULL,0,24,NULL,NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_acl`
--

LOCK TABLES `tree_acl` WRITE;
/*!40000 ALTER TABLE `tree_acl` DISABLE KEYS */;
INSERT INTO `tree_acl` VALUES (20,1,2,2175,0,1,'2016-10-21 00:36:35',1,'2016-10-21 00:36:39'),(29,150,22,2431,0,1,'2016-12-12 02:27:30',1,'2016-12-12 02:27:32'),(33,150,2,2175,0,1,'2016-12-12 02:37:43',1,'2016-12-12 02:37:48'),(40,1031,2,0,2431,1,'2016-12-12 02:46:38',1,'2016-12-12 03:21:24'),(45,1026,2,0,256,1,'2016-12-12 03:18:33',1,'2016-12-12 03:20:41'),(46,1199,2,0,4095,1,'2016-12-15 19:32:54',NULL,NULL),(47,1204,22,2431,0,1,'2016-12-15 19:36:55',1,'2016-12-15 19:37:01'),(48,1204,2,0,2175,1,'2016-12-15 19:36:56',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tree_acl_security_sets`
--

LOCK TABLES `tree_acl_security_sets` WRITE;
/*!40000 ALTER TABLE `tree_acl_security_sets` DISABLE KEYS */;
INSERT INTO `tree_acl_security_sets` VALUES (2,'7','8f14e45fceea167a5a36dedd4bea2543',0),(4,'664','2291d2ec3b3048d1a6f86c2c4591b7e0',0),(5,'675','8fecb20817b3847419bb3de39a609afe',0),(7,'1','c4ca4238a0b923820dcc509a6f75849b',0),(11,'150','7ef605fc8dba5425d6965fbd4c8fbe1f',0),(13,'150,1031','28c3ffafd00c70617c635e3582f906c0',0),(14,'150,1026','bb8110dd1ce54936a2fbced44c54f060',0),(15,'150,1199','4225f617be717d72b24dc6b9ebb28066',0),(16,'1,1204','4384913502c7ec338af15ee74a5aee15',0);
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
INSERT INTO `tree_acl_security_sets_result` VALUES (7,2,1,1,1,1,1,1,1,0,0,0,0,1),(11,2,1,1,1,1,1,1,1,0,0,0,0,1),(11,21,1,1,1,1,1,1,1,0,1,0,0,1),(11,24,1,1,1,1,1,1,1,0,1,0,0,1),(11,27,1,1,1,1,1,1,1,0,1,0,0,1),(13,2,0,0,0,0,0,0,0,0,0,0,0,0),(13,21,1,1,1,1,1,1,1,0,1,1,1,1),(13,24,0,0,0,0,0,0,0,0,0,0,0,0),(13,27,0,0,0,0,0,0,0,0,0,0,0,0),(14,2,1,1,1,1,1,1,1,0,0,0,0,1),(14,21,1,1,1,1,1,1,1,0,0,0,0,1),(14,24,1,1,1,1,1,1,1,0,0,0,0,1),(14,27,1,1,1,1,1,1,1,0,0,0,0,1),(15,2,0,0,0,0,0,0,0,0,0,0,0,0),(15,21,0,0,0,0,0,0,0,0,0,0,0,0),(15,24,0,0,0,0,0,0,0,0,0,0,0,0),(15,27,0,0,0,0,0,0,0,0,0,0,0,0),(16,2,0,0,0,0,0,0,0,0,0,0,0,0),(16,21,1,1,1,1,1,1,1,0,1,0,0,1),(16,24,1,1,1,1,1,1,1,0,1,0,0,1),(16,27,1,1,1,1,1,1,1,0,1,0,0,1);
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
INSERT INTO `tree_info` VALUES (1,'1','',NULL,1,7,0),(2,'1,2','/',NULL,0,NULL,0),(3,'1,2,3','/System/',NULL,0,NULL,0),(4,'1,2,4','/System/',NULL,0,NULL,0),(5,'1,2,3,88,5','/System/Templates/',NULL,0,NULL,0),(6,'1,2,3,88,6','/System/Templates/',NULL,0,NULL,0),(7,'1,2,3,88,7','/System/Templates/',NULL,1,2,0),(8,'1,2,3,88,8','/System/Templates/',NULL,0,NULL,0),(9,'1,2,3,88,9','/System/Templates/',NULL,0,NULL,0),(10,'1,2,3,88,10','/System/Templates/',NULL,0,NULL,0),(11,'1,2,3,88,11','/System/Templates/',NULL,0,NULL,0),(12,'1,2,3,88,12','/System/Templates/',NULL,0,NULL,0),(13,'1,2,3,88,10,13','/System/Templates/User/',NULL,0,NULL,0),(14,'1,2,3,88,10,14','/System/Templates/User/',NULL,0,NULL,0),(15,'1,2,3,88,10,15','/System/Templates/User/',NULL,0,NULL,0),(16,'1,2,3,88,10,16','/System/Templates/User/',NULL,0,NULL,0),(17,'1,2,3,88,10,17','/System/Templates/User/',NULL,0,NULL,0),(18,'1,2,3,88,10,18','/System/Templates/User/',NULL,0,NULL,0),(19,'1,2,3,88,10,19','/System/Templates/User/',NULL,0,NULL,0),(20,'1,2,3,88,10,20','/System/Templates/User/',NULL,0,NULL,0),(21,'1,2,3,88,10,21','/System/Templates/User/',NULL,0,NULL,0),(22,'1,2,3,88,10,22','/System/Templates/User/',NULL,0,NULL,0),(23,'1,2,3,88,10,23','/System/Templates/User/',NULL,0,NULL,0),(24,'1,2,3,88,6,24','/System/Templates/file/',NULL,0,NULL,0),(25,'1,2,3,88,12,25','/System/Templates/Fields template/',NULL,0,NULL,0),(26,'1,2,3,88,12,26','/System/Templates/Fields template/',NULL,0,NULL,0),(27,'1,2,3,88,12,27','/System/Templates/Fields template/',NULL,0,NULL,0),(28,'1,2,3,88,12,28','/System/Templates/Fields template/',NULL,0,NULL,0),(29,'1,2,3,88,12,29','/System/Templates/Fields template/',NULL,0,NULL,0),(30,'1,2,3,88,12,30','/System/Templates/Fields template/',NULL,0,NULL,0),(31,'1,2,3,88,11,31','/System/Templates/Templates template/',NULL,0,NULL,0),(32,'1,2,3,88,11,32','/System/Templates/Templates template/',NULL,0,NULL,0),(33,'1,2,3,88,11,33','/System/Templates/Templates template/',NULL,0,NULL,0),(34,'1,2,3,88,11,34','/System/Templates/Templates template/',NULL,0,NULL,0),(35,'1,2,3,88,11,35','/System/Templates/Templates template/',NULL,0,NULL,0),(36,'1,2,3,88,11,36','/System/Templates/Templates template/',NULL,0,NULL,0),(37,'1,2,3,88,11,37','/System/Templates/Templates template/',NULL,0,NULL,0),(38,'1,2,3,88,11,38','/System/Templates/Templates template/',NULL,0,NULL,0),(39,'1,2,3,88,8,39','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(40,'1,2,3,88,8,40','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(41,'1,2,3,88,8,41','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(42,'1,2,3,88,8,42','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(43,'1,2,3,88,8,43','/System/Templates/Thesauri Item/',NULL,0,NULL,0),(44,'1,2,3,88,7,44','/System/Templates/task/',NULL,0,2,0),(45,'1,2,3,88,7,45','/System/Templates/task/',NULL,0,2,0),(46,'1,2,3,88,7,46','/System/Templates/task/',NULL,0,2,0),(47,'1,2,3,88,7,47','/System/Templates/task/',NULL,0,2,0),(48,'1,2,3,88,5,48','/System/Templates/folder/',NULL,0,NULL,0),(49,'1,2,3,88,9,49','/System/Templates/Comment/',NULL,0,NULL,0),(50,'1,2,3,88,7,50','/System/Templates/task/',NULL,0,2,0),(51,'1,2,3,88,7,51','/System/Templates/task/',NULL,0,2,0),(52,'1,2,4,52',NULL,NULL,0,NULL,0),(53,'1,2,4,52,53',NULL,NULL,0,NULL,0),(54,'1,2,4,52,53,54',NULL,NULL,0,NULL,0),(55,'1,2,4,52,53,55',NULL,NULL,0,NULL,0),(56,'1,2,4,52,53,56',NULL,NULL,0,NULL,0),(57,'1,2,4,52,53,57',NULL,NULL,0,NULL,0),(58,'1,2,3,88,58',NULL,NULL,0,NULL,0),(59,'1,2,3,88,59',NULL,NULL,0,NULL,0),(60,'1,2,60',NULL,NULL,0,NULL,0),(61,'1,2,3,88,59,61',NULL,NULL,0,NULL,0),(62,'1,2,3,88,59,62',NULL,NULL,0,NULL,0),(63,'1,2,3,88,59,62,63',NULL,NULL,0,NULL,0),(64,'1,2,3,88,59,62,64',NULL,NULL,0,NULL,0),(65,'1,2,3,88,59,62,65',NULL,NULL,0,NULL,0),(66,'1,2,3,88,59,62,66',NULL,NULL,0,NULL,0),(67,'1,2,3,88,59,62,67',NULL,NULL,0,NULL,0),(68,'1,2,60,68',NULL,NULL,0,NULL,0),(69,'1,2,60,69',NULL,NULL,0,NULL,0),(70,'1,2,60,70',NULL,NULL,0,NULL,0),(71,'1,2,60,71',NULL,NULL,0,NULL,0),(72,'1,2,60,72',NULL,NULL,0,NULL,0),(73,'1,2,60,73',NULL,NULL,0,NULL,0),(74,'1,2,4,74',NULL,NULL,0,NULL,0),(75,'1,2,4,74,75',NULL,NULL,0,NULL,0),(76,'1,2,4,74,75,76',NULL,NULL,0,NULL,0),(77,'1,2,4,74,75,77',NULL,NULL,0,NULL,0),(78,'1,2,4,74,75,78',NULL,NULL,0,NULL,0),(79,'1,2,4,74,75,79',NULL,NULL,0,NULL,0),(80,'1,2,4,74,75,80',NULL,NULL,0,NULL,0),(81,'1,2,4,74,75,81',NULL,NULL,0,NULL,0),(82,'1,2,4,74,82',NULL,NULL,0,NULL,0),(83,'1,2,3,88,83',NULL,NULL,0,NULL,0),(84,'1,2,3,88,83,84',NULL,NULL,0,NULL,0),(85,'1,2,3,88,83,85',NULL,NULL,0,NULL,0),(86,'1,2,3,88,83,86',NULL,NULL,0,NULL,0),(87,'1,2,3,88,83,87',NULL,NULL,0,NULL,0),(88,'1,2,3,88',NULL,NULL,0,NULL,0),(89,'1,2,3,89',NULL,NULL,0,NULL,0),(90,'1,2,90',NULL,NULL,0,NULL,0),(91,'1,2,3,89,91',NULL,NULL,0,NULL,0),(92,'1,2,3,89,91,92',NULL,NULL,0,NULL,0),(93,'1,2,3,89,91,93',NULL,NULL,0,NULL,0),(94,'1,2,3,89,94',NULL,NULL,0,NULL,0),(95,'1,2,3,89,94,95',NULL,NULL,0,NULL,0),(96,'1,2,3,89,94,96',NULL,NULL,0,NULL,0),(97,'1,2,3,89,97',NULL,NULL,0,NULL,0),(98,'1,2,3,89,97,98',NULL,NULL,0,NULL,0),(99,'1,2,3,89,97,99',NULL,NULL,0,NULL,0),(100,'1,2,3,89,100',NULL,NULL,0,NULL,0),(101,'1,2,3,89,100,101',NULL,NULL,0,NULL,0),(102,'1,2,3,89,100,102',NULL,NULL,0,NULL,0),(103,'1,2,3,89,100,103',NULL,NULL,0,NULL,0),(104,'1,2,90,104',NULL,NULL,0,NULL,0),(105,'1,2,90,105',NULL,NULL,0,NULL,0),(106,'1,2,90,106',NULL,NULL,0,NULL,0),(107,'1,2,90,107',NULL,NULL,0,NULL,0),(108,'1,2,90,108',NULL,NULL,0,NULL,0),(109,'1,2,90,109',NULL,NULL,0,NULL,0),(110,'1,2,90,110',NULL,NULL,0,NULL,0),(111,'1,2,90,111',NULL,NULL,0,NULL,0),(112,'1,2,90,112',NULL,NULL,0,NULL,0),(113,'1,2,90,113',NULL,NULL,0,NULL,0),(114,'1,2,90,113,114',NULL,NULL,0,NULL,0),(115,'1,2,90,113,115',NULL,NULL,0,NULL,0),(116,'1,2,90,113,116',NULL,NULL,0,NULL,0),(117,'1,2,60,117',NULL,NULL,0,NULL,0),(118,'1,2,90,118',NULL,NULL,0,NULL,0),(119,'1,2,90,119',NULL,NULL,0,NULL,0),(120,'1,2,90,120',NULL,NULL,0,NULL,0),(121,'1,2,90,121',NULL,NULL,0,NULL,0),(122,'1,2,90,122',NULL,NULL,0,NULL,0),(123,'1,2,90,123',NULL,NULL,0,NULL,0),(124,'1,2,90,124',NULL,NULL,0,NULL,0),(125,'1,2,90,125',NULL,NULL,0,NULL,0),(126,'1,2,90,126',NULL,NULL,0,NULL,0),(127,'1,2,90,127',NULL,NULL,0,NULL,0),(128,'1,2,90,128',NULL,NULL,0,NULL,0),(129,'1,2,90,129',NULL,NULL,0,NULL,0),(130,'1,2,90,129,130',NULL,NULL,0,NULL,0),(131,'1,2,90,129,131',NULL,NULL,0,NULL,0),(132,'1,2,90,132',NULL,NULL,0,NULL,0),(134,'1,2,4,134',NULL,NULL,0,NULL,0),(135,'1,2,4,135',NULL,NULL,0,NULL,0),(136,'1,2,4,136',NULL,NULL,0,NULL,0),(137,'1,2,4,136,137',NULL,NULL,0,NULL,0),(138,'1,2,4,136,137,138',NULL,NULL,0,NULL,0),(139,'1,2,4,136,137,139',NULL,NULL,0,NULL,0),(140,'1,2,3,140',NULL,NULL,0,NULL,0),(141,'1,2,3,140,141',NULL,NULL,0,NULL,0),(142,'1,2,3,140,141,142',NULL,NULL,0,NULL,0),(143,'1,2,3,140,141,143',NULL,NULL,0,NULL,0),(144,'1,2,3,140,141,144',NULL,NULL,0,NULL,0),(145,'1,2,3,140,141,145',NULL,NULL,0,NULL,0),(146,'1,2,60,146',NULL,NULL,0,NULL,0),(147,'1,2,60,147',NULL,NULL,0,NULL,0),(149,'1,149',NULL,NULL,0,7,0),(150,'1,150',NULL,NULL,2,11,0),(156,'1,150,156',NULL,NULL,0,11,0),(167,'1,2,4,136,167',NULL,NULL,0,NULL,0),(168,'1,2,4,136,168',NULL,NULL,0,NULL,0),(169,'1,2,4,136,168,169',NULL,NULL,0,NULL,0),(170,'1,2,4,136,168,170',NULL,NULL,0,NULL,0),(172,'1,2,3,140,172',NULL,NULL,0,NULL,0),(173,'1,2,60,173',NULL,NULL,0,NULL,0),(201,'1,150,201',NULL,NULL,0,11,0),(205,'1,2,3,205',NULL,NULL,0,NULL,0),(206,'1,2,3,205,206',NULL,NULL,0,NULL,0),(207,'1,2,3,207',NULL,NULL,0,NULL,0),(208,'1,2,3,207,208',NULL,NULL,0,NULL,0),(209,'1,2,3,140,141,209',NULL,NULL,0,NULL,0),(210,'1,2,3,140,141,210',NULL,NULL,0,NULL,0),(211,'1,2,3,140,141,211',NULL,NULL,0,NULL,0),(212,'1,2,3,140,141,212',NULL,NULL,0,NULL,0),(213,'1,2,4,136,213',NULL,NULL,0,NULL,0),(214,'1,2,4,136,167,214',NULL,NULL,0,NULL,0),(215,'1,2,4,136,167,215',NULL,NULL,0,NULL,0),(216,'1,2,4,136,167,216',NULL,NULL,0,NULL,0),(217,'1,2,4,136,167,217',NULL,NULL,0,NULL,0),(218,'1,2,4,136,167,218',NULL,NULL,0,NULL,0),(219,'1,2,4,136,167,219',NULL,NULL,0,NULL,0),(220,'1,2,4,136,167,220',NULL,NULL,0,NULL,0),(221,'1,2,4,136,221',NULL,NULL,0,NULL,0),(222,'1,2,4,136,221,222',NULL,NULL,0,NULL,0),(223,'1,2,4,136,221,223',NULL,NULL,0,NULL,0),(224,'1,2,4,136,221,224',NULL,NULL,0,NULL,0),(225,'1,2,4,136,221,225',NULL,NULL,0,NULL,0),(226,'1,2,4,136,226',NULL,NULL,0,NULL,0),(227,'1,2,4,136,227',NULL,NULL,0,NULL,0),(228,'1,2,4,136,228',NULL,NULL,0,NULL,0),(229,'1,2,4,136,226,229',NULL,NULL,0,NULL,0),(230,'1,2,4,136,226,230',NULL,NULL,0,NULL,0),(231,'1,2,4,136,226,231',NULL,NULL,0,NULL,0),(232,'1,2,4,136,226,232',NULL,NULL,0,NULL,0),(233,'1,2,4,136,226,233',NULL,NULL,0,NULL,0),(234,'1,2,4,136,227,234',NULL,NULL,0,NULL,0),(235,'1,2,4,136,227,235',NULL,NULL,0,NULL,0),(236,'1,2,4,136,227,236',NULL,NULL,0,NULL,0),(237,'1,2,4,136,227,237',NULL,NULL,0,NULL,0),(238,'1,2,4,136,227,238',NULL,NULL,0,NULL,0),(239,'1,2,4,136,227,239',NULL,NULL,0,NULL,0),(240,'1,2,4,136,227,240',NULL,NULL,0,NULL,0),(241,'1,2,4,136,227,241',NULL,NULL,0,NULL,0),(242,'1,2,4,136,228,242',NULL,NULL,0,NULL,0),(243,'1,2,4,136,228,243',NULL,NULL,0,NULL,0),(244,'1,2,4,136,228,244',NULL,NULL,0,NULL,0),(245,'1,2,4,136,228,245',NULL,NULL,0,NULL,0),(246,'1,2,4,136,228,246',NULL,NULL,0,NULL,0),(247,'1,2,4,136,228,247',NULL,NULL,0,NULL,0),(248,'1,2,4,136,228,248',NULL,NULL,0,NULL,0),(249,'1,2,4,136,228,249',NULL,NULL,0,NULL,0),(250,'1,2,4,136,228,250',NULL,NULL,0,NULL,0),(251,'1,2,4,136,228,251',NULL,NULL,0,NULL,0),(252,'1,2,4,136,228,252',NULL,NULL,0,NULL,0),(253,'1,2,4,136,228,253',NULL,NULL,0,NULL,0),(254,'1,2,4,136,228,254',NULL,NULL,0,NULL,0),(255,'1,2,4,136,228,255',NULL,NULL,0,NULL,0),(256,'1,2,4,136,228,256',NULL,NULL,0,NULL,0),(257,'1,2,4,136,228,257',NULL,NULL,0,NULL,0),(258,'1,2,4,136,228,258',NULL,NULL,0,NULL,0),(259,'1,2,4,136,228,259',NULL,NULL,0,NULL,0),(260,'1,2,4,136,228,260',NULL,NULL,0,NULL,0),(261,'1,2,4,136,228,261',NULL,NULL,0,NULL,0),(262,'1,2,4,136,228,262',NULL,NULL,0,NULL,0),(263,'1,2,4,136,228,263',NULL,NULL,0,NULL,0),(264,'1,2,4,136,228,264',NULL,NULL,0,NULL,0),(265,'1,2,4,136,228,265',NULL,NULL,0,NULL,0),(266,'1,2,4,136,228,266',NULL,NULL,0,NULL,0),(267,'1,2,4,136,228,267',NULL,NULL,0,NULL,0),(268,'1,2,4,136,228,268',NULL,NULL,0,NULL,0),(269,'1,2,4,136,228,269',NULL,NULL,0,NULL,0),(270,'1,2,4,136,228,270',NULL,NULL,0,NULL,0),(271,'1,2,4,136,228,271',NULL,NULL,0,NULL,0),(272,'1,2,3,140,141,272',NULL,NULL,0,NULL,0),(274,'1,2,3,140,141,274',NULL,NULL,0,NULL,0),(275,'1,2,3,140,141,275',NULL,NULL,0,NULL,0),(276,'1,2,3,140,141,276',NULL,NULL,0,NULL,0),(277,'1,2,3,140,141,277',NULL,NULL,0,NULL,0),(278,'1,2,3,140,141,278',NULL,NULL,0,NULL,0),(279,'1,2,3,140,141,279',NULL,NULL,0,NULL,0),(280,'1,2,3,140,141,280',NULL,NULL,0,NULL,0),(286,'1,150,201,286',NULL,NULL,0,11,0),(287,'1,150,201,287',NULL,NULL,0,11,0),(288,'1,2,90,113,288',NULL,NULL,0,NULL,0),(289,'1,2,3,140,289',NULL,NULL,0,NULL,0),(290,'1,2,3,140,289,290',NULL,NULL,0,NULL,0),(291,'1,2,3,140,289,291',NULL,NULL,0,NULL,0),(292,'1,2,3,140,289,292',NULL,NULL,0,NULL,0),(293,'1,2,3,140,289,293',NULL,NULL,0,NULL,0),(294,'1,2,3,140,289,294',NULL,NULL,0,NULL,0),(295,'1,2,3,140,289,295',NULL,NULL,0,NULL,0),(296,'1,2,3,140,289,296',NULL,NULL,0,NULL,0),(297,'1,2,3,140,289,297',NULL,NULL,0,NULL,0),(298,'1,2,3,140,289,298',NULL,NULL,0,NULL,0),(299,'1,2,4,136,299',NULL,NULL,0,NULL,0),(300,'1,2,4,136,299,300',NULL,NULL,0,NULL,0),(301,'1,2,4,136,299,301',NULL,NULL,0,NULL,0),(302,'1,2,4,136,299,302',NULL,NULL,0,NULL,0),(303,'1,2,4,136,299,303',NULL,NULL,0,NULL,0),(304,'1,2,4,136,299,304',NULL,NULL,0,NULL,0),(305,'1,2,4,136,299,305',NULL,NULL,0,NULL,0),(306,'1,2,4,136,299,306',NULL,NULL,0,NULL,0),(307,'1,2,4,136,299,307',NULL,NULL,0,NULL,0),(308,'1,2,4,136,299,308',NULL,NULL,0,NULL,0),(309,'1,2,4,136,299,309',NULL,NULL,0,NULL,0),(310,'1,2,4,136,299,310',NULL,NULL,0,NULL,0),(311,'1,2,3,140,311',NULL,NULL,0,NULL,0),(312,'1,2,3,140,311,312',NULL,NULL,0,NULL,0),(313,'1,2,3,140,311,313',NULL,NULL,0,NULL,0),(314,'1,2,3,140,311,314',NULL,NULL,0,NULL,0),(315,'1,2,3,140,311,315',NULL,NULL,0,NULL,0),(316,'1,2,3,140,311,316',NULL,NULL,0,NULL,0),(317,'1,2,3,140,311,317',NULL,NULL,0,NULL,0),(318,'1,2,3,140,311,318',NULL,NULL,0,NULL,0),(319,'1,2,3,140,311,319',NULL,NULL,0,NULL,0),(320,'1,2,3,140,311,320',NULL,NULL,0,NULL,0),(321,'1,2,4,136,321',NULL,NULL,0,NULL,0),(322,'1,2,4,136,321,322',NULL,NULL,0,NULL,0),(323,'1,2,4,136,321,323',NULL,NULL,0,NULL,0),(324,'1,2,4,136,321,324',NULL,NULL,0,NULL,0),(325,'1,2,4,136,321,325',NULL,NULL,0,NULL,0),(326,'1,2,4,136,321,326',NULL,NULL,0,NULL,0),(327,'1,2,4,136,321,327',NULL,NULL,0,NULL,0),(328,'1,2,4,136,321,328',NULL,NULL,0,NULL,0),(329,'1,2,4,136,321,329',NULL,NULL,0,NULL,0),(330,'1,2,4,136,321,330',NULL,NULL,0,NULL,0),(331,'1,2,4,136,321,331',NULL,NULL,0,NULL,0),(332,'1,2,4,136,321,332',NULL,NULL,0,NULL,0),(333,'1,2,4,333',NULL,NULL,0,NULL,0),(334,'1,2,4,333,334',NULL,NULL,0,NULL,0),(335,'1,2,4,333,334,335',NULL,NULL,0,NULL,0),(336,'1,2,4,333,334,336',NULL,NULL,0,NULL,0),(337,'1,2,4,333,334,337',NULL,NULL,0,NULL,0),(338,'1,2,4,333,334,338',NULL,NULL,0,NULL,0),(339,'1,2,4,333,334,339',NULL,NULL,0,NULL,0),(340,'1,2,4,333,334,340',NULL,NULL,0,NULL,0),(341,'1,2,4,333,334,341',NULL,NULL,0,NULL,0),(342,'1,2,4,333,334,342',NULL,NULL,0,NULL,0),(343,'1,2,4,333,334,343',NULL,NULL,0,NULL,0),(344,'1,2,4,333,334,344',NULL,NULL,0,NULL,0),(345,'1,2,4,333,334,345',NULL,NULL,0,NULL,0),(346,'1,2,4,333,346',NULL,NULL,0,NULL,0),(347,'1,2,4,333,346,347',NULL,NULL,0,NULL,0),(348,'1,2,4,333,346,348',NULL,NULL,0,NULL,0),(349,'1,2,4,333,346,349',NULL,NULL,0,NULL,0),(350,'1,2,4,333,346,350',NULL,NULL,0,NULL,0),(351,'1,2,4,333,351',NULL,NULL,0,NULL,0),(352,'1,2,4,333,351,352',NULL,NULL,0,NULL,0),(353,'1,2,4,333,351,353',NULL,NULL,0,NULL,0),(354,'1,2,4,333,351,354',NULL,NULL,0,NULL,0),(355,'1,2,4,333,355',NULL,NULL,0,NULL,0),(356,'1,2,4,333,355,356',NULL,NULL,0,NULL,0),(357,'1,2,4,333,355,357',NULL,NULL,0,NULL,0),(358,'1,2,4,333,355,358',NULL,NULL,0,NULL,0),(359,'1,2,4,333,355,359',NULL,NULL,0,NULL,0),(360,'1,2,4,333,355,360',NULL,NULL,0,NULL,0),(361,'1,2,4,333,355,361',NULL,NULL,0,NULL,0),(362,'1,2,4,333,362',NULL,NULL,0,NULL,0),(363,'1,2,4,333,362,363',NULL,NULL,0,NULL,0),(364,'1,2,4,333,362,364',NULL,NULL,0,NULL,0),(365,'1,2,4,333,362,365',NULL,NULL,0,NULL,0),(366,'1,2,4,333,362,366',NULL,NULL,0,NULL,0),(367,'1,2,4,333,362,367',NULL,NULL,0,NULL,0),(368,'1,2,4,333,362,368',NULL,NULL,0,NULL,0),(369,'1,2,4,333,362,369',NULL,NULL,0,NULL,0),(370,'1,2,4,333,362,370',NULL,NULL,0,NULL,0),(371,'1,2,4,333,362,371',NULL,NULL,0,NULL,0),(372,'1,2,4,333,372',NULL,NULL,0,NULL,0),(373,'1,2,4,333,372,373',NULL,NULL,0,NULL,0),(374,'1,2,4,333,372,374',NULL,NULL,0,NULL,0),(375,'1,2,4,333,372,375',NULL,NULL,0,NULL,0),(376,'1,2,4,333,372,376',NULL,NULL,0,NULL,0),(377,'1,2,4,333,372,377',NULL,NULL,0,NULL,0),(378,'1,2,4,333,372,378',NULL,NULL,0,NULL,0),(379,'1,2,4,333,372,379',NULL,NULL,0,NULL,0),(380,'1,2,4,333,380',NULL,NULL,0,NULL,0),(381,'1,2,4,333,380,381',NULL,NULL,0,NULL,0),(382,'1,2,4,333,380,382',NULL,NULL,0,NULL,0),(383,'1,2,4,333,380,383',NULL,NULL,0,NULL,0),(384,'1,2,4,333,380,384',NULL,NULL,0,NULL,0),(385,'1,2,4,333,380,385',NULL,NULL,0,NULL,0),(386,'1,2,4,333,380,386',NULL,NULL,0,NULL,0),(387,'1,2,4,333,380,387',NULL,NULL,0,NULL,0),(388,'1,2,4,333,380,388',NULL,NULL,0,NULL,0),(389,'1,2,4,333,389',NULL,NULL,0,NULL,0),(390,'1,2,4,333,389,390',NULL,NULL,0,NULL,0),(391,'1,2,4,333,389,391',NULL,NULL,0,NULL,0),(392,'1,2,4,333,392',NULL,NULL,0,NULL,0),(393,'1,2,4,333,392,393',NULL,NULL,0,NULL,0),(394,'1,2,4,333,392,394',NULL,NULL,0,NULL,0),(395,'1,2,4,333,392,395',NULL,NULL,0,NULL,0),(396,'1,2,4,333,392,396',NULL,NULL,0,NULL,0),(397,'1,2,4,333,392,397',NULL,NULL,0,NULL,0),(398,'1,2,4,333,392,398',NULL,NULL,0,NULL,0),(399,'1,2,4,333,392,399',NULL,NULL,0,NULL,0),(400,'1,2,4,333,392,400',NULL,NULL,0,NULL,0),(401,'1,2,4,333,401',NULL,NULL,0,NULL,0),(402,'1,2,4,333,401,402',NULL,NULL,0,NULL,0),(403,'1,2,4,333,401,403',NULL,NULL,0,NULL,0),(404,'1,2,4,333,401,404',NULL,NULL,0,NULL,0),(405,'1,2,4,333,401,405',NULL,NULL,0,NULL,0),(406,'1,2,4,333,401,406',NULL,NULL,0,NULL,0),(407,'1,2,4,333,401,407',NULL,NULL,0,NULL,0),(408,'1,2,4,333,401,408',NULL,NULL,0,NULL,0),(409,'1,2,4,333,401,409',NULL,NULL,0,NULL,0),(410,'1,2,4,333,410',NULL,NULL,0,NULL,0),(411,'1,2,4,333,411',NULL,NULL,0,NULL,0),(412,'1,2,4,333,410,412',NULL,NULL,0,NULL,0),(413,'1,2,4,333,410,413',NULL,NULL,0,NULL,0),(414,'1,2,4,333,410,414',NULL,NULL,0,NULL,0),(415,'1,2,4,333,410,415',NULL,NULL,0,NULL,0),(416,'1,2,4,333,416',NULL,NULL,0,NULL,0),(417,'1,2,4,333,416,417',NULL,NULL,0,NULL,0),(418,'1,2,4,333,416,418',NULL,NULL,0,NULL,0),(419,'1,2,4,333,416,419',NULL,NULL,0,NULL,0),(420,'1,2,4,333,416,420',NULL,NULL,0,NULL,0),(421,'1,2,4,333,416,421',NULL,NULL,0,NULL,0),(422,'1,2,4,333,416,422',NULL,NULL,0,NULL,0),(423,'1,2,4,333,423',NULL,NULL,0,NULL,0),(424,'1,2,4,333,411,424',NULL,NULL,0,NULL,0),(425,'1,2,4,333,411,425',NULL,NULL,0,NULL,0),(426,'1,2,4,333,411,426',NULL,NULL,0,NULL,0),(427,'1,2,4,333,411,427',NULL,NULL,0,NULL,0),(428,'1,2,4,333,411,428',NULL,NULL,0,NULL,0),(429,'1,2,4,333,429',NULL,NULL,0,NULL,0),(430,'1,2,4,333,429,430',NULL,NULL,0,NULL,0),(431,'1,2,4,333,429,431',NULL,NULL,0,NULL,0),(432,'1,2,3,140,172,432',NULL,NULL,0,NULL,0),(433,'1,2,3,140,172,433',NULL,NULL,0,NULL,0),(434,'1,2,3,140,172,433,434',NULL,NULL,0,NULL,0),(435,'1,2,3,140,172,435',NULL,NULL,0,NULL,0),(436,'1,2,3,140,172,433,434,436',NULL,NULL,0,NULL,0),(437,'1,2,3,140,172,433,434,437',NULL,NULL,0,NULL,0),(438,'1,2,3,140,172,433,434,438',NULL,NULL,0,NULL,0),(439,'1,2,3,140,172,433,434,439',NULL,NULL,0,NULL,0),(440,'1,2,3,140,440',NULL,NULL,0,NULL,0),(441,'1,2,3,140,440,441',NULL,NULL,0,NULL,0),(442,'1,2,3,140,440,442',NULL,NULL,0,NULL,0),(443,'1,2,3,140,440,443',NULL,NULL,0,NULL,0),(444,'1,2,3,140,440,443,444',NULL,NULL,0,NULL,0),(445,'1,2,3,140,440,445',NULL,NULL,0,NULL,0),(446,'1,2,3,140,440,446',NULL,NULL,0,NULL,0),(447,'1,2,3,140,440,447',NULL,NULL,0,NULL,0),(448,'1,2,3,140,440,448',NULL,NULL,0,NULL,0),(449,'1,2,3,140,440,448,449',NULL,NULL,0,NULL,0),(450,'1,2,3,140,440,450',NULL,NULL,0,NULL,0),(451,'1,2,3,140,440,450,451',NULL,NULL,0,NULL,0),(452,'1,2,3,140,440,452',NULL,NULL,0,NULL,0),(453,'1,2,3,140,440,453',NULL,NULL,0,NULL,0),(454,'1,2,3,140,440,454',NULL,NULL,0,NULL,0),(455,'1,2,3,140,455',NULL,NULL,0,NULL,0),(456,'1,2,3,140,455,456',NULL,NULL,0,NULL,0),(457,'1,2,3,140,455,457',NULL,NULL,0,NULL,0),(458,'1,2,3,140,455,458',NULL,NULL,0,NULL,0),(459,'1,2,3,140,455,459',NULL,NULL,0,NULL,0),(460,'1,2,3,140,455,460',NULL,NULL,0,NULL,0),(461,'1,2,3,140,455,461',NULL,NULL,0,NULL,0),(462,'1,2,3,140,455,462',NULL,NULL,0,NULL,0),(463,'1,2,3,140,455,463',NULL,NULL,0,NULL,0),(464,'1,2,3,140,455,464',NULL,NULL,0,NULL,0),(465,'1,2,3,140,455,465',NULL,NULL,0,NULL,0),(466,'1,2,3,140,455,466',NULL,NULL,0,NULL,0),(467,'1,2,3,140,467',NULL,NULL,0,NULL,0),(468,'1,2,3,140,467,468',NULL,NULL,0,NULL,0),(469,'1,2,3,140,467,469',NULL,NULL,0,NULL,0),(470,'1,2,3,140,467,470',NULL,NULL,0,NULL,0),(471,'1,2,3,140,467,471',NULL,NULL,0,NULL,0),(472,'1,2,3,140,467,472',NULL,NULL,0,NULL,0),(473,'1,2,3,140,467,473',NULL,NULL,0,NULL,0),(474,'1,2,3,140,467,474',NULL,NULL,0,NULL,0),(475,'1,2,3,140,467,475',NULL,NULL,0,NULL,0),(476,'1,2,3,140,467,476',NULL,NULL,0,NULL,0),(477,'1,2,3,140,467,477',NULL,NULL,0,NULL,0),(478,'1,2,3,140,467,478',NULL,NULL,0,NULL,0),(479,'1,2,3,140,467,479',NULL,NULL,0,NULL,0),(480,'1,2,3,140,467,480',NULL,NULL,0,NULL,0),(481,'1,2,3,140,467,481',NULL,NULL,0,NULL,0),(482,'1,2,3,140,482',NULL,NULL,0,NULL,0),(483,'1,2,3,140,482,483',NULL,NULL,0,NULL,0),(484,'1,2,3,140,482,484',NULL,NULL,0,NULL,0),(485,'1,2,3,140,482,485',NULL,NULL,0,NULL,0),(486,'1,2,3,140,482,485,486',NULL,NULL,0,NULL,0),(487,'1,2,3,140,482,485,487',NULL,NULL,0,NULL,0),(488,'1,2,3,140,482,488',NULL,NULL,0,NULL,0),(489,'1,2,3,140,489',NULL,NULL,0,NULL,0),(490,'1,2,3,140,489,490',NULL,NULL,0,NULL,0),(491,'1,2,3,140,489,491',NULL,NULL,0,NULL,0),(492,'1,2,3,140,489,492',NULL,NULL,0,NULL,0),(493,'1,2,3,140,489,493',NULL,NULL,0,NULL,0),(494,'1,2,3,140,489,494',NULL,NULL,0,NULL,0),(495,'1,2,3,140,489,495',NULL,NULL,0,NULL,0),(496,'1,2,3,140,489,496',NULL,NULL,0,NULL,0),(497,'1,2,3,140,489,497',NULL,NULL,0,NULL,0),(498,'1,2,3,140,489,498',NULL,NULL,0,NULL,0),(499,'1,2,3,140,489,499',NULL,NULL,0,NULL,0),(500,'1,2,3,140,489,500',NULL,NULL,0,NULL,0),(501,'1,2,4,333,501',NULL,NULL,0,NULL,0),(502,'1,2,4,333,501,502',NULL,NULL,0,NULL,0),(503,'1,2,4,333,501,503',NULL,NULL,0,NULL,0),(504,'1,2,4,333,501,504',NULL,NULL,0,NULL,0),(505,'1,2,3,140,505',NULL,NULL,0,NULL,0),(506,'1,2,3,140,505,506',NULL,NULL,0,NULL,0),(507,'1,2,3,140,505,507',NULL,NULL,0,NULL,0),(508,'1,2,3,140,505,508',NULL,NULL,0,NULL,0),(509,'1,2,3,140,505,509',NULL,NULL,0,NULL,0),(510,'1,2,3,140,510',NULL,NULL,0,NULL,0),(511,'1,2,3,140,510,511',NULL,NULL,0,NULL,0),(512,'1,2,3,140,510,512',NULL,NULL,0,NULL,0),(513,'1,2,3,140,510,513',NULL,NULL,0,NULL,0),(514,'1,2,3,140,510,514',NULL,NULL,0,NULL,0),(515,'1,2,3,140,510,515',NULL,NULL,0,NULL,0),(516,'1,2,4,333,516',NULL,NULL,0,NULL,0),(517,'1,2,4,333,516,517',NULL,NULL,0,NULL,0),(518,'1,2,4,333,516,518',NULL,NULL,0,NULL,0),(519,'1,2,4,333,516,519',NULL,NULL,0,NULL,0),(520,'1,2,4,333,516,520',NULL,NULL,0,NULL,0),(521,'1,2,4,333,516,521',NULL,NULL,0,NULL,0),(522,'1,2,4,136,522',NULL,NULL,0,NULL,0),(523,'1,2,4,136,522,523',NULL,NULL,0,NULL,0),(524,'1,2,4,136,522,524',NULL,NULL,0,NULL,0),(525,'1,2,4,136,522,525',NULL,NULL,0,NULL,0),(526,'1,2,4,136,522,526',NULL,NULL,0,NULL,0),(527,'1,2,3,140,527',NULL,NULL,0,NULL,0),(528,'1,2,3,140,527,528',NULL,NULL,0,NULL,0),(529,'1,2,3,140,527,529',NULL,NULL,0,NULL,0),(530,'1,2,3,140,527,530',NULL,NULL,0,NULL,0),(531,'1,2,3,140,527,531',NULL,NULL,0,NULL,0),(532,'1,2,3,140,527,532',NULL,NULL,0,NULL,0),(533,'1,2,3,140,533',NULL,NULL,0,NULL,0),(534,'1,2,3,140,533,534',NULL,NULL,0,NULL,0),(535,'1,2,3,140,533,535',NULL,NULL,0,NULL,0),(536,'1,2,3,140,533,536',NULL,NULL,0,NULL,0),(537,'1,2,3,140,533,535,537',NULL,NULL,0,NULL,0),(538,'1,2,3,140,533,535,538',NULL,NULL,0,NULL,0),(539,'1,2,3,140,533,535,538,539',NULL,NULL,0,NULL,0),(540,'1,2,3,140,533,535,540',NULL,NULL,0,NULL,0),(541,'1,2,3,140,533,535,540,541',NULL,NULL,0,NULL,0),(542,'1,2,3,140,533,535,540,542',NULL,NULL,0,NULL,0),(543,'1,2,3,140,533,543',NULL,NULL,0,NULL,0),(544,'1,2,3,140,533,544',NULL,NULL,0,NULL,0),(545,'1,2,3,140,533,545',NULL,NULL,0,NULL,0),(546,'1,2,3,140,533,546',NULL,NULL,0,NULL,0),(547,'1,2,3,140,533,535,547',NULL,NULL,0,NULL,0),(548,'1,2,3,140,533,535,547,548',NULL,NULL,0,NULL,0),(549,'1,2,3,140,533,535,547,549',NULL,NULL,0,NULL,0),(550,'1,2,3,140,533,535,550',NULL,NULL,0,NULL,0),(551,'1,2,3,140,533,535,551',NULL,NULL,0,NULL,0),(552,'1,2,3,140,533,535,551,552',NULL,NULL,0,NULL,0),(553,'1,2,3,140,553',NULL,NULL,0,NULL,0),(554,'1,2,3,140,553,554',NULL,NULL,0,NULL,0),(555,'1,2,3,140,553,555',NULL,NULL,0,NULL,0),(556,'1,2,3,140,553,556',NULL,NULL,0,NULL,0),(557,'1,2,3,140,553,557',NULL,NULL,0,NULL,0),(558,'1,2,3,140,553,555,558',NULL,NULL,0,NULL,0),(559,'1,2,3,140,559',NULL,NULL,0,NULL,0),(560,'1,2,3,140,559,560',NULL,NULL,0,NULL,0),(561,'1,2,3,140,559,561',NULL,NULL,0,NULL,0),(562,'1,2,3,140,559,561,562',NULL,NULL,0,NULL,0),(563,'1,2,3,140,559,561,563',NULL,NULL,0,NULL,0),(564,'1,2,3,140,559,561,564',NULL,NULL,0,NULL,0),(565,'1,2,3,140,559,561,564,565',NULL,NULL,0,NULL,0),(566,'1,2,3,140,559,566',NULL,NULL,0,NULL,0),(567,'1,2,3,140,559,561,567',NULL,NULL,0,NULL,0),(568,'1,2,3,140,559,561,568',NULL,NULL,0,NULL,0),(569,'1,2,3,140,559,561,569',NULL,NULL,0,NULL,0),(570,'1,2,4,136,570',NULL,NULL,0,NULL,0),(571,'1,2,4,136,570,571',NULL,NULL,0,NULL,0),(572,'1,2,4,136,570,572',NULL,NULL,0,NULL,0),(573,'1,2,4,136,570,573',NULL,NULL,0,NULL,0),(574,'1,2,4,136,570,574',NULL,NULL,0,NULL,0),(575,'1,2,4,136,570,575',NULL,NULL,0,NULL,0),(576,'1,2,4,136,570,576',NULL,NULL,0,NULL,0),(577,'1,2,4,136,570,577',NULL,NULL,0,NULL,0),(578,'1,2,4,136,570,578',NULL,NULL,0,NULL,0),(579,'1,2,4,136,570,579',NULL,NULL,0,NULL,0),(580,'1,2,4,136,570,580',NULL,NULL,0,NULL,0),(581,'1,2,4,136,570,581',NULL,NULL,0,NULL,0),(582,'1,2,4,136,570,582',NULL,NULL,0,NULL,0),(583,'1,2,4,136,570,583',NULL,NULL,0,NULL,0),(584,'1,2,4,136,570,584',NULL,NULL,0,NULL,0),(585,'1,2,4,136,570,585',NULL,NULL,0,NULL,0),(586,'1,2,4,136,570,586',NULL,NULL,0,NULL,0),(587,'1,2,4,136,570,587',NULL,NULL,0,NULL,0),(588,'1,2,4,136,570,588',NULL,NULL,0,NULL,0),(589,'1,2,4,136,570,589',NULL,NULL,0,NULL,0),(590,'1,2,4,136,570,590',NULL,NULL,0,NULL,0),(591,'1,2,4,136,570,591',NULL,NULL,0,NULL,0),(592,'1,2,4,136,570,592',NULL,NULL,0,NULL,0),(593,'1,2,4,136,593',NULL,NULL,0,NULL,0),(594,'1,2,4,136,593,594',NULL,NULL,0,NULL,0),(595,'1,2,4,136,593,595',NULL,NULL,0,NULL,0),(596,'1,2,4,136,593,596',NULL,NULL,0,NULL,0),(597,'1,2,4,136,597',NULL,NULL,0,NULL,0),(598,'1,2,4,136,597,598',NULL,NULL,0,NULL,0),(599,'1,2,4,136,597,599',NULL,NULL,0,NULL,0),(600,'1,2,4,136,597,600',NULL,NULL,0,NULL,0),(601,'1,2,4,136,597,601',NULL,NULL,0,NULL,0),(602,'1,2,4,136,602',NULL,NULL,0,NULL,0),(603,'1,2,4,136,602,603',NULL,NULL,0,NULL,0),(604,'1,2,4,136,602,604',NULL,NULL,0,NULL,0),(605,'1,2,4,136,602,605',NULL,NULL,0,NULL,0),(606,'1,2,4,136,602,606',NULL,NULL,0,NULL,0),(607,'1,2,3,140,607',NULL,NULL,0,NULL,0),(608,'1,2,3,140,607,617,608',NULL,NULL,0,NULL,0),(609,'1,2,3,140,607,609',NULL,NULL,0,NULL,0),(610,'1,2,3,140,607,617,610',NULL,NULL,0,NULL,0),(611,'1,2,3,140,607,611',NULL,NULL,0,NULL,0),(612,'1,2,3,140,607,617,612',NULL,NULL,0,NULL,0),(613,'1,2,3,140,607,617,613',NULL,NULL,0,NULL,0),(614,'1,2,3,140,607,617,614',NULL,NULL,0,NULL,0),(615,'1,2,3,140,607,617,615',NULL,NULL,0,NULL,0),(616,'1,2,3,140,607,616',NULL,NULL,0,NULL,0),(617,'1,2,3,140,607,617',NULL,NULL,0,NULL,0),(618,'1,2,3,140,607,618',NULL,NULL,0,NULL,0),(619,'1,2,3,140,607,619',NULL,NULL,0,NULL,0),(620,'1,2,3,140,607,620',NULL,NULL,0,NULL,0),(621,'1,2,3,140,607,621',NULL,NULL,0,NULL,0),(622,'1,2,3,140,607,622',NULL,NULL,0,NULL,0),(623,'1,2,3,140,607,623',NULL,NULL,0,NULL,0),(624,'1,2,3,140,607,624',NULL,NULL,0,NULL,0),(625,'1,2,3,140,607,625',NULL,NULL,0,NULL,0),(626,'1,2,3,140,607,626',NULL,NULL,0,NULL,0),(627,'1,2,3,140,607,627',NULL,NULL,0,NULL,0),(628,'1,2,3,140,607,628',NULL,NULL,0,NULL,0),(629,'1,2,3,140,607,617,629',NULL,NULL,0,NULL,0),(630,'1,2,3,140,607,617,630',NULL,NULL,0,NULL,0),(631,'1,2,3,140,607,617,631',NULL,NULL,0,NULL,0),(632,'1,2,3,140,607,617,632',NULL,NULL,0,NULL,0),(633,'1,2,3,140,607,617,633',NULL,NULL,0,NULL,0),(634,'1,2,3,140,141,634',NULL,NULL,0,NULL,0),(635,'1,2,4,136,137,635',NULL,NULL,0,NULL,0),(636,'1,2,4,136,137,636',NULL,NULL,0,NULL,0),(642,'1,642',NULL,NULL,0,7,0),(643,'1,2,3,140,141,643',NULL,NULL,0,NULL,0),(644,'1,2,4,136,644',NULL,NULL,0,NULL,0),(645,'1,2,4,136,644,645',NULL,NULL,0,NULL,0),(646,'1,2,4,136,644,646',NULL,NULL,0,NULL,0),(651,'1,2,3,140,651',NULL,NULL,0,NULL,0),(652,'1,2,3,140,651,652',NULL,NULL,0,NULL,0),(653,'1,2,3,140,651,653',NULL,NULL,0,NULL,0),(654,'1,2,3,140,651,653,654',NULL,NULL,0,NULL,0),(655,'1,2,3,140,651,653,654,655',NULL,NULL,0,NULL,0),(656,'1,2,3,140,656',NULL,NULL,0,NULL,0),(657,'1,2,3,140,656,657',NULL,NULL,0,NULL,0),(658,'1,2,3,140,656,658',NULL,NULL,0,NULL,0),(659,'1,2,3,140,656,659',NULL,NULL,0,NULL,0),(660,'1,2,3,140,656,660',NULL,NULL,0,NULL,0),(661,'1,2,3,140,656,661',NULL,NULL,0,NULL,0),(663,'1,2,90,129,663',NULL,NULL,0,NULL,0),(666,'1,150,666',NULL,NULL,0,11,0),(667,'1,150,667',NULL,NULL,0,11,0),(668,'1,668',NULL,NULL,0,NULL,0),(669,'1,2,3,140,669',NULL,NULL,0,NULL,0),(670,'1,2,3,140,669,670',NULL,NULL,0,NULL,0),(671,'1,2,3,140,669,671',NULL,NULL,0,NULL,0),(672,'1,2,3,140,669,672',NULL,NULL,0,NULL,0),(674,'1,150,674',NULL,NULL,0,11,0),(678,'1,150,678',NULL,NULL,0,11,0),(679,'1,150,679',NULL,NULL,0,11,0),(680,'1,150,680',NULL,NULL,0,11,0),(683,'1,2,3,140,533,683',NULL,NULL,0,NULL,0),(684,'1,2,3,140,533,683,684',NULL,NULL,0,NULL,0),(685,'1,2,4,333,685',NULL,NULL,0,NULL,0),(686,'1,2,4,333,685,686',NULL,NULL,0,NULL,0),(687,'1,2,4,333,685,687',NULL,NULL,0,NULL,0),(703,'1,2,3,140,141,703',NULL,NULL,0,NULL,0),(704,'1,150,704',NULL,NULL,0,11,0),(718,'1,2,3,140,607,718',NULL,NULL,0,NULL,0),(722,'1,2,3,140,311,722',NULL,NULL,0,NULL,0),(845,'1,2,3,140,510,845',NULL,NULL,0,NULL,0),(846,'1,2,3,140,510,845,846',NULL,NULL,0,NULL,0),(847,'1,2,3,140,553,847',NULL,NULL,0,NULL,0),(848,'1,2,3,140,482,848',NULL,NULL,0,NULL,0),(849,'1,2,3,140,455,849',NULL,NULL,0,NULL,0),(850,'1,2,3,140,505,850',NULL,NULL,0,NULL,0),(851,'1,2,3,140,559,851',NULL,NULL,0,NULL,0),(852,'1,2,3,140,489,852',NULL,NULL,0,NULL,0),(853,'1,2,3,140,440,853',NULL,NULL,0,NULL,0),(854,'1,2,3,140,656,854',NULL,NULL,0,NULL,0),(855,'1,2,3,140,467,855',NULL,NULL,0,NULL,0),(856,'1,2,3,140,651,856',NULL,NULL,0,NULL,0),(857,'1,2,3,140,172,857',NULL,NULL,0,NULL,0),(858,'1,2,3,140,553,847,858',NULL,NULL,0,NULL,0),(859,'1,2,3,140,482,848,859',NULL,NULL,0,NULL,0),(860,'1,2,3,140,455,860',NULL,NULL,0,NULL,0),(861,'1,2,3,140,505,850,861',NULL,NULL,0,NULL,0),(862,'1,2,3,140,559,851,862',NULL,NULL,0,NULL,0),(863,'1,2,3,140,440,853,863',NULL,NULL,0,NULL,0),(864,'1,2,3,140,656,854,864',NULL,NULL,0,NULL,0),(865,'1,2,3,140,467,865',NULL,NULL,0,NULL,0),(866,'1,2,3,140,651,856,866',NULL,NULL,0,NULL,0),(867,'1,2,3,140,172,857,867',NULL,NULL,0,NULL,0),(870,'1,2,3,140,651,870',NULL,NULL,0,NULL,0),(897,'1,150,897',NULL,NULL,0,11,0),(938,'1,2,4,333,346,347,938',NULL,NULL,0,NULL,0),(939,'1,2,4,333,346,347,939',NULL,NULL,0,NULL,0),(940,'1,2,4,333,346,347,940',NULL,NULL,0,NULL,0),(941,'1,2,4,333,346,347,941',NULL,NULL,0,NULL,0),(952,'1,2,4,136,952',NULL,NULL,0,NULL,0),(953,'1,2,4,136,952,953',NULL,NULL,0,NULL,0),(954,'1,2,4,136,952,954',NULL,NULL,0,NULL,0),(955,'1,2,4,136,952,955',NULL,NULL,0,NULL,0),(962,'1,2,4,136,952,962',NULL,NULL,0,NULL,0),(963,'1,2,60,963',NULL,NULL,0,NULL,0),(970,'1,2,3,140,970',NULL,NULL,0,NULL,0),(972,'1,2,3,140,972',NULL,NULL,0,NULL,0),(973,'1,2,3,140,972,973',NULL,NULL,0,NULL,0),(976,'1,2,3,140,976',NULL,NULL,0,NULL,0),(977,'1,2,3,140,976,977',NULL,NULL,0,NULL,0),(978,'1,2,60,978',NULL,NULL,0,NULL,0),(1026,'1,150,1026',NULL,1026,1,14,0),(1027,'1,150,1026,1027',NULL,1026,0,14,0),(1028,'1,150,1026,1028',NULL,1026,0,14,0),(1029,'1,150,1026,1029',NULL,1026,0,14,0),(1030,'1,150,1026,1030',NULL,1026,0,14,0),(1031,'1,150,1031',NULL,1031,1,13,0),(1032,'1,2,3,140,141,1032',NULL,NULL,0,NULL,0),(1033,'1,2,3,140,141,1033',NULL,NULL,0,NULL,0),(1034,'1,2,3,140,141,1034',NULL,NULL,0,NULL,0),(1035,'1,2,4,136,1035',NULL,NULL,0,NULL,0),(1036,'1,2,4,136,1035,1036',NULL,NULL,0,NULL,0),(1037,'1,2,4,136,1035,1037',NULL,NULL,0,NULL,0),(1038,'1,2,3,140,141,1038',NULL,NULL,0,NULL,0),(1039,'1,2,3,140,141,1039',NULL,NULL,0,NULL,0),(1040,'1,2,3,140,141,1040',NULL,NULL,0,NULL,0),(1041,'1,2,4,136,1041',NULL,NULL,0,NULL,0),(1042,'1,2,4,136,1041,1042',NULL,NULL,0,NULL,0),(1043,'1,2,4,136,1041,1043',NULL,NULL,0,NULL,0),(1044,'1,2,4,136,1041,1044',NULL,NULL,0,NULL,0),(1045,'1,2,4,136,1041,1045',NULL,NULL,0,NULL,0),(1046,'1,2,4,136,1041,1046',NULL,NULL,0,NULL,0),(1047,'1,2,4,136,1041,1047',NULL,NULL,0,NULL,0),(1048,'1,2,4,136,1041,1048',NULL,NULL,0,NULL,0),(1049,'1,2,4,136,1041,1049',NULL,NULL,0,NULL,0),(1050,'1,2,4,136,1041,1050',NULL,NULL,0,NULL,0),(1051,'1,2,4,136,1041,1051',NULL,NULL,0,NULL,0),(1052,'1,2,4,136,1041,1052',NULL,NULL,0,NULL,0),(1053,'1,2,4,136,1041,1053',NULL,NULL,0,NULL,0),(1054,'1,2,4,136,1041,1054',NULL,NULL,0,NULL,0),(1055,'1,2,4,136,1041,1055',NULL,NULL,0,NULL,0),(1056,'1,2,4,136,1041,1056',NULL,NULL,0,NULL,0),(1057,'1,2,4,136,1041,1057',NULL,NULL,0,NULL,0),(1058,'1,2,4,136,1041,1058',NULL,NULL,0,NULL,0),(1059,'1,2,4,136,1041,1059',NULL,NULL,0,NULL,0),(1060,'1,2,4,136,1041,1060',NULL,NULL,0,NULL,0),(1061,'1,2,4,136,1041,1061',NULL,NULL,0,NULL,0),(1062,'1,2,4,136,1041,1062',NULL,NULL,0,NULL,0),(1063,'1,2,4,136,1041,1063',NULL,NULL,0,NULL,0),(1064,'1,2,4,136,1041,1064',NULL,NULL,0,NULL,0),(1065,'1,2,4,136,1041,1065',NULL,NULL,0,NULL,0),(1066,'1,2,4,136,1041,1066',NULL,NULL,0,NULL,0),(1067,'1,2,4,136,1041,1067',NULL,NULL,0,NULL,0),(1068,'1,2,4,136,1041,1068',NULL,NULL,0,NULL,0),(1069,'1,2,4,136,1041,1069',NULL,NULL,0,NULL,0),(1070,'1,2,4,136,1041,1070',NULL,NULL,0,NULL,0),(1071,'1,2,4,136,1041,1071',NULL,NULL,0,NULL,0),(1072,'1,2,4,136,1041,1072',NULL,NULL,0,NULL,0),(1073,'1,2,4,136,1041,1073',NULL,NULL,0,NULL,0),(1074,'1,2,4,136,1041,1074',NULL,NULL,0,NULL,0),(1075,'1,2,4,136,1041,1075',NULL,NULL,0,NULL,0),(1076,'1,2,4,136,1041,1076',NULL,NULL,0,NULL,0),(1077,'1,2,4,136,1041,1077',NULL,NULL,0,NULL,0),(1078,'1,2,4,136,1041,1078',NULL,NULL,0,NULL,0),(1079,'1,2,4,136,1041,1079',NULL,NULL,0,NULL,0),(1080,'1,2,4,136,1041,1080',NULL,NULL,0,NULL,0),(1081,'1,2,4,136,1041,1081',NULL,NULL,0,NULL,0),(1082,'1,2,4,136,1041,1082',NULL,NULL,0,NULL,0),(1083,'1,2,4,136,1041,1083',NULL,NULL,0,NULL,0),(1084,'1,2,4,136,1041,1084',NULL,NULL,0,NULL,0),(1085,'1,2,4,136,1041,1085',NULL,NULL,0,NULL,0),(1086,'1,2,4,136,1041,1086',NULL,NULL,0,NULL,0),(1087,'1,2,4,136,1041,1087',NULL,NULL,0,NULL,0),(1088,'1,2,4,136,1041,1088',NULL,NULL,0,NULL,0),(1089,'1,2,4,136,1041,1089',NULL,NULL,0,NULL,0),(1090,'1,2,4,136,1041,1090',NULL,NULL,0,NULL,0),(1091,'1,2,4,136,1041,1091',NULL,NULL,0,NULL,0),(1092,'1,2,4,136,1041,1092',NULL,NULL,0,NULL,0),(1093,'1,2,3,140,141,1093',NULL,NULL,0,NULL,0),(1094,'1,2,3,140,141,1094',NULL,NULL,0,NULL,0),(1095,'1,2,3,140,141,1095',NULL,NULL,0,NULL,0),(1096,'1,2,3,140,141,1096',NULL,NULL,0,NULL,0),(1097,'1,2,3,140,141,1097',NULL,NULL,0,NULL,0),(1098,'1,2,3,140,141,1098',NULL,NULL,0,NULL,0),(1099,'1,2,3,140,141,1099',NULL,NULL,0,NULL,0),(1100,'1,2,3,140,141,1100',NULL,NULL,0,NULL,0),(1101,'1,2,3,140,141,1101',NULL,NULL,0,NULL,0),(1102,'1,2,3,140,141,1102',NULL,NULL,0,NULL,0),(1103,'1,150,1103',NULL,1103,0,11,0),(1104,'1,150,1103,1104',NULL,1103,0,11,0),(1105,'1,150,1103,1105',NULL,1103,0,11,0),(1106,'1,150,1103,1106',NULL,1103,0,11,0),(1107,'1,150,1103,1107',NULL,1103,0,11,0),(1108,'1,150,1108',NULL,1108,0,11,0),(1109,'1,150,1108,1109',NULL,1108,0,11,0),(1110,'1,150,1108,1110',NULL,1108,0,11,0),(1111,'1,150,1108,1111',NULL,1108,0,11,0),(1112,'1,150,1108,1112',NULL,1108,0,11,0),(1113,'1,2,3,140,141,1113',NULL,NULL,0,NULL,0),(1114,'1,2,3,140,141,1114',NULL,NULL,0,NULL,0),(1115,'1,150,1115',NULL,1115,0,11,0),(1116,'1,150,1115,1116',NULL,1115,0,11,0),(1117,'1,150,1115,1117',NULL,1115,0,11,0),(1118,'1,150,1115,1118',NULL,1115,0,11,0),(1119,'1,150,1115,1119',NULL,1115,0,11,0),(1120,'1,2,3,140,1120',NULL,NULL,0,NULL,0),(1121,'1,2,3,140,1120,1121',NULL,NULL,0,NULL,0),(1122,'1,2,3,140,1120,1121,1122',NULL,NULL,0,NULL,0),(1123,'1,2,3,140,1120,1123',NULL,NULL,0,NULL,0),(1124,'1,2,3,140,1120,1124',NULL,NULL,0,NULL,0),(1125,'1,2,3,140,1120,1125',NULL,NULL,0,NULL,0),(1126,'1,2,3,140,1120,1126',NULL,NULL,0,NULL,0),(1127,'1,2,3,140,1120,1127',NULL,NULL,0,NULL,0),(1128,'1,2,3,140,1120,1128',NULL,NULL,0,NULL,0),(1129,'1,2,3,140,1120,1129',NULL,NULL,0,NULL,0),(1130,'1,2,3,140,1120,1130',NULL,NULL,0,NULL,0),(1131,'1,2,3,140,1120,1131',NULL,NULL,0,NULL,0),(1132,'1,2,3,140,1120,1132',NULL,NULL,0,NULL,0),(1133,'1,2,3,140,1120,1133',NULL,NULL,0,NULL,0),(1134,'1,2,4,136,226,1134',NULL,NULL,0,NULL,0),(1135,'1,2,4,136,226,1135',NULL,NULL,0,NULL,0),(1136,'1,2,4,136,226,1136',NULL,NULL,0,NULL,0),(1137,'1,2,4,136,227,1137',NULL,NULL,0,NULL,0),(1138,'1,2,4,136,227,1138',NULL,NULL,0,NULL,0),(1139,'1,2,4,136,227,1139',NULL,NULL,0,NULL,0),(1140,'1,2,4,136,227,1140',NULL,NULL,0,NULL,0),(1141,'1,2,4,136,227,1141',NULL,NULL,0,NULL,0),(1142,'1,2,4,136,227,1142',NULL,NULL,0,NULL,0),(1143,'1,2,4,136,227,1143',NULL,NULL,0,NULL,0),(1144,'1,2,4,136,227,1144',NULL,NULL,0,NULL,0),(1145,'1,2,4,136,227,1145',NULL,NULL,0,NULL,0),(1146,'1,2,4,136,227,1146',NULL,NULL,0,NULL,0),(1147,'1,2,4,136,227,1147',NULL,NULL,0,NULL,0),(1148,'1,2,3,140,141,279,1148',NULL,NULL,0,NULL,0),(1149,'1,2,3,140,141,1149',NULL,NULL,0,NULL,0),(1150,'1,2,3,140,141,1150',NULL,NULL,0,NULL,0),(1151,'1,2,4,333,1151',NULL,NULL,0,NULL,0),(1152,'1,2,4,333,1151,1152',NULL,NULL,0,NULL,0),(1153,'1,2,4,333,1151,1153',NULL,NULL,0,NULL,0),(1154,'1,2,4,333,1151,1154',NULL,NULL,0,NULL,0),(1155,'1,2,4,333,1151,1155',NULL,NULL,0,NULL,0),(1156,'1,2,3,140,455,1156',NULL,NULL,0,NULL,0),(1157,'1,2,3,140,455,1157',NULL,NULL,0,NULL,0),(1158,'1,2,3,140,455,1158',NULL,NULL,0,NULL,0),(1159,'1,2,3,140,455,1159',NULL,NULL,0,NULL,0),(1160,'1,2,3,140,455,1160',NULL,NULL,0,NULL,0),(1161,'1,2,3,140,455,1161',NULL,NULL,0,NULL,0),(1162,'1,2,3,140,455,1162',NULL,NULL,0,NULL,0),(1163,'1,2,3,140,455,1163',NULL,NULL,0,NULL,0),(1164,'1,2,3,140,455,1164',NULL,NULL,0,NULL,0),(1165,'1,2,3,140,455,1165',NULL,NULL,0,NULL,0),(1166,'1,2,3,140,455,1166',NULL,NULL,0,NULL,0),(1167,'1,2,3,140,455,1167',NULL,NULL,0,NULL,0),(1168,'1,2,3,140,455,1168',NULL,NULL,0,NULL,0),(1169,'1,2,3,140,455,1169',NULL,NULL,0,NULL,0),(1170,'1,2,3,140,455,1169,1170',NULL,NULL,0,NULL,0),(1171,'1,2,3,140,141,1171',NULL,NULL,0,NULL,0),(1172,'1,2,3,140,141,1172',NULL,NULL,0,NULL,0),(1173,'1,2,3,140,141,1173',NULL,NULL,0,NULL,0),(1174,'1,2,3,140,141,1174',NULL,NULL,0,NULL,0),(1175,'1,2,3,140,1175',NULL,NULL,0,NULL,0),(1176,'1,2,3,140,1175,1176',NULL,NULL,0,NULL,0),(1177,'1,2,3,140,1120,1177',NULL,NULL,0,NULL,0),(1178,'1,2,3,140,1175,1178',NULL,NULL,0,NULL,0),(1179,'1,150,1179',NULL,1179,0,11,0),(1180,'1,150,1179,1180',NULL,1179,0,11,0),(1181,'1,150,1179,1181',NULL,1179,0,11,0),(1182,'1,150,1179,1182',NULL,1179,0,11,0),(1183,'1,150,1179,1183',NULL,1179,0,11,0),(1184,'1,150,1184',NULL,1184,0,11,0),(1185,'1,150,1184,1185',NULL,1184,0,11,0),(1186,'1,150,1184,1186',NULL,1184,0,11,0),(1187,'1,150,1184,1187',NULL,1184,0,11,0),(1188,'1,150,1184,1188',NULL,1184,0,11,0),(1189,'1,2,3,140,1120,1189',NULL,NULL,0,NULL,0),(1190,'1,2,3,140,1120,1190',NULL,NULL,0,NULL,0),(1191,'1,2,3,140,1120,1191',NULL,NULL,0,NULL,0),(1192,'1,2,3,140,1120,1192',NULL,NULL,0,NULL,0),(1193,'1,2,3,140,1120,1193',NULL,NULL,0,NULL,0),(1194,'1,2,3,140,1120,1194',NULL,NULL,0,NULL,0),(1195,'1,2,3,140,1120,1195',NULL,NULL,0,NULL,0),(1196,'1,2,3,140,1120,1196',NULL,NULL,0,NULL,0),(1197,'1,2,3,140,1120,1197',NULL,NULL,0,NULL,0),(1198,'1,2,3,140,1120,1198',NULL,NULL,0,NULL,0),(1199,'1,150,1199',NULL,1199,1,15,0),(1200,'1,150,1199,1200',NULL,1199,0,15,0),(1201,'1,150,1199,1201',NULL,1199,0,15,0),(1202,'1,150,1199,1202',NULL,1199,0,15,0),(1203,'1,150,1199,1203',NULL,1199,0,15,0),(1204,'1,1204',NULL,NULL,2,16,0),(1205,'1,2,3,1205',NULL,NULL,0,NULL,0),(1206,'1,2,3,1205,1206',NULL,NULL,0,NULL,0),(1207,'1,2,3,1205,1207',NULL,NULL,0,NULL,0),(1208,'1,1204,1208',NULL,NULL,0,16,0),(1209,'1,1209',NULL,NULL,0,7,0),(1210,'1,150,1199,1210',NULL,1199,0,15,0),(1211,'1,150,1199,1210,1211',NULL,1199,0,15,0),(1212,'1,150,1212',NULL,1212,0,11,0),(1213,'1,150,1212,1213',NULL,1212,0,11,0),(1214,'1,150,1212,1214',NULL,1212,0,11,0),(1215,'1,150,1212,1215',NULL,1212,0,11,0),(1216,'1,150,1212,1216',NULL,1212,0,11,0),(1217,'1,150,1212,1214,1217',NULL,1212,0,11,0),(1218,'1,150,1212,1214,1218',NULL,1212,0,11,0),(1219,'1,150,1212,1214,1218,1219',NULL,1212,0,11,0),(1220,'1,150,1212,1214,1218,1220',NULL,1212,0,11,0),(1221,'1,150,1212,1221',NULL,1212,0,11,0),(1222,'1,150,1199,1210,1222',NULL,1199,0,15,0),(1223,'1,2,3,140,440,853,1223',NULL,NULL,0,NULL,0),(1224,'1,150,1212,1224',NULL,1212,0,11,0),(1225,'1,150,1225',NULL,1225,0,11,0),(1226,'1,150,1225,1226',NULL,1225,0,11,0),(1227,'1,150,1225,1227',NULL,1225,0,11,0),(1228,'1,150,1225,1228',NULL,1225,0,11,0),(1229,'1,150,1225,1229',NULL,1225,0,11,0),(1230,'1,150,1230',NULL,1230,0,11,0),(1231,'1,150,1230,1231',NULL,1230,0,11,0),(1232,'1,150,1230,1232',NULL,1230,0,11,0),(1233,'1,150,1230,1233',NULL,1230,0,11,0),(1234,'1,150,1230,1234',NULL,1230,0,11,0),(1235,'1,150,1230,1235',NULL,1230,0,11,0),(1236,'1,150,1230,1234,1236',NULL,1230,0,11,0),(1237,'1,150,1237',NULL,1237,0,11,0),(1238,'1,150,1237,1238',NULL,1237,0,11,0),(1239,'1,150,1237,1239',NULL,1237,0,11,0),(1240,'1,150,1237,1240',NULL,1237,0,11,0),(1241,'1,150,1237,1241',NULL,1237,0,11,0),(1242,'1,150,1237,1242',NULL,1237,0,11,0),(1243,'1,150,1243',NULL,1243,0,11,0),(1244,'1,150,1243,1244',NULL,1243,0,11,0),(1245,'1,150,1243,1245',NULL,1243,0,11,0),(1246,'1,150,1243,1246',NULL,1243,0,11,0),(1247,'1,150,1243,1247',NULL,1243,0,11,0),(1248,'1,150,1237,1248',NULL,1237,0,11,0),(1249,'1,150,1237,1249',NULL,1237,0,11,0),(1250,'1,150,1237,1250',NULL,1237,0,11,0),(1251,'1,150,1225,1251',NULL,1225,0,11,0),(1252,'1,150,1225,1252',NULL,1225,0,11,0),(1253,'1,150,1225,1253',NULL,1225,0,11,0),(1254,'1,150,1225,1254',NULL,1225,0,11,0),(1255,'1,150,1225,1256,1255',NULL,1225,0,11,0),(1256,'1,150,1225,1256',NULL,1225,0,11,0),(1257,'1,150,1237,1258,1257',NULL,1237,0,11,0),(1258,'1,150,1237,1258',NULL,1237,0,11,0),(1259,'1,150,1212,1260,1259',NULL,1212,0,11,0),(1260,'1,150,1212,1260',NULL,1212,0,11,0),(1261,'1,150,1230,1261',NULL,1230,0,11,0),(1262,'1,150,1230,1262',NULL,1230,0,11,0),(1263,'1,668,1263',NULL,NULL,0,NULL,0),(1264,'1,2,3,140,141,1264',NULL,NULL,0,NULL,0),(1265,'1,150,1237,1265',NULL,1237,0,11,0),(1266,'1,150,1230,1266',NULL,1230,0,11,0),(1267,'1,150,1237,1267',NULL,1237,0,11,0),(1268,'1,150,1237,1268',NULL,1237,0,11,0),(1269,'1,150,1243,1269',NULL,1243,0,11,0),(1270,'1,150,1243,1270',NULL,1243,0,11,0),(1271,'1,150,1225,1271',NULL,1225,0,11,0),(1272,'1,2,3,140,141,1272',NULL,NULL,0,NULL,0),(1273,'1,150,1243,1273',NULL,1243,0,11,0),(1274,'1,150,1230,1274',NULL,1230,0,11,0),(1275,'1,150,1230,1275',NULL,1230,0,11,0),(1276,'1,150,1230,1276',NULL,1230,0,11,0),(1277,'1,150,1230,1277',NULL,1230,0,11,0),(1278,'1,150,1230,1278',NULL,1230,0,11,0),(1279,'1,150,1230,1279',NULL,1230,0,11,0),(1280,'1,150,1230,1280',NULL,1230,0,11,0),(1281,'1,150,1243,1281',NULL,1243,0,11,0),(1282,'1,150,1243,1282',NULL,1243,0,11,0),(1283,'1,150,1212,1283',NULL,1212,0,11,0),(1284,'1,150,1243,1284',NULL,1243,0,11,0),(1285,'1,150,1237,1285',NULL,1237,0,11,0),(1286,'1,150,1237,1286',NULL,1237,0,11,0),(1287,'1,150,1237,1287',NULL,1237,0,11,0),(1288,'1,150,1212,1288',NULL,1212,0,11,0),(1289,'1,150,1212,1289',NULL,1212,0,11,0),(1290,'1,150,1212,1290',NULL,1212,0,11,0),(1291,'1,1291',NULL,1291,0,7,0),(1292,'1,1291,1292',NULL,1291,0,7,0),(1293,'1,1293',NULL,1293,0,7,0),(1294,'1,1294',NULL,1294,0,7,0),(1295,'1,1291,1295',NULL,1291,0,7,0),(1296,'1,1291,1296',NULL,1291,0,7,0),(1297,'1,1291,1297',NULL,1291,0,7,0),(1298,'1,1291,1298',NULL,1291,0,7,0),(1299,'1,1291,1299',NULL,1291,0,7,0),(1300,'1,1291,1300',NULL,1291,0,7,0),(1301,'1,1291,1301',NULL,1291,0,7,0),(1302,'1,1291,1302',NULL,1291,0,7,0),(1303,'1,1291,1303',NULL,1291,0,7,0),(1304,'1,1291,1304',NULL,1291,0,7,0),(1305,'1,1291,1305',NULL,1291,0,7,0),(1306,'1,1291,1306',NULL,1291,0,7,0),(1307,'1,1307',NULL,NULL,0,7,0),(1308,'1,1291,1308',NULL,1291,0,7,0),(1309,'1,1291,1309',NULL,1291,0,7,0),(1310,'1,1291,1310',NULL,1291,0,7,0),(1311,'1,1294,1311',NULL,1294,0,7,0),(1312,'1,1294,1312',NULL,1294,0,7,0),(1313,'1,1294,1313',NULL,1294,0,7,0),(1314,'1,150,1314',NULL,1314,0,11,0),(1315,'1,150,1314,1315',NULL,1314,0,11,0),(1316,'1,150,1314,1316',NULL,1314,0,11,0),(1317,'1,150,1314,1317',NULL,1314,0,11,0),(1318,'1,150,1314,1318',NULL,1314,0,11,0),(1319,'1,2,3,1319',NULL,NULL,0,NULL,0),(1320,'1,1320',NULL,1320,0,7,0),(1321,'1,150,1243,1321',NULL,1243,0,11,0),(1322,'1,2,3,140,141,1322',NULL,NULL,0,NULL,0),(1323,'1,2,3,140,141,1323',NULL,NULL,0,NULL,0),(1324,'1,2,4,136,1324',NULL,NULL,0,NULL,0),(1325,'1,2,4,136,1324,1325',NULL,NULL,0,NULL,0),(1326,'1,2,4,136,1324,1326',NULL,NULL,0,NULL,0),(1327,'1,2,4,136,1324,1327',NULL,NULL,0,NULL,0),(1328,'1,2,4,136,1324,1328',NULL,NULL,0,NULL,0),(1329,'1,150,1329',NULL,1329,0,11,0),(1330,'1,668,1331,1330',NULL,NULL,0,NULL,0),(1331,'1,668,1331',NULL,NULL,0,NULL,0),(1332,'1,2,4,333,1332',NULL,NULL,0,NULL,0),(1333,'1,2,4,333,1332,1333',NULL,NULL,0,NULL,0),(1334,'1,2,4,333,1332,1334',NULL,NULL,0,NULL,0),(1335,'1,2,4,333,1332,1335',NULL,NULL,0,NULL,0),(1336,'1,2,4,333,1332,1336',NULL,NULL,0,NULL,0),(1337,'1,668,1331,1330,1337',NULL,NULL,0,NULL,0),(1338,'1,668,1331,1338',NULL,NULL,0,NULL,0),(1339,'1,668,1339',NULL,NULL,0,NULL,0),(1340,'1,2,4,1340',NULL,NULL,0,NULL,0),(1341,'1,2,4,1341',NULL,NULL,0,NULL,0),(1342,'1,2,4,1341,1342',NULL,NULL,0,NULL,0),(1343,'1,2,4,1341,1342,1343',NULL,NULL,0,NULL,0),(1344,'1,2,4,1341,1342,1344',NULL,NULL,0,NULL,0),(1345,'1,2,4,1341,1342,1345',NULL,NULL,0,NULL,0),(1346,'1,2,4,1341,1342,1346',NULL,NULL,0,NULL,0),(1347,'1,2,4,1341,1342,1347',NULL,NULL,0,NULL,0),(1348,'1,2,4,1341,1342,1348',NULL,NULL,0,NULL,0),(1349,'1,2,4,1341,1342,1349',NULL,NULL,0,NULL,0),(1350,'1,2,4,1341,1342,1350',NULL,NULL,0,NULL,0),(1351,'1,150,1329,1351',NULL,1329,0,11,0),(1352,'1,2,3,140,669,1352',NULL,NULL,0,NULL,0),(1353,'1,2,3,140,669,1352,1353',NULL,NULL,0,NULL,0),(1354,'1,668,1354',NULL,NULL,0,NULL,0),(1355,'1,2,3,140,607,1355',NULL,NULL,0,NULL,0),(1356,'1,2,3,140,607,1356',NULL,NULL,0,NULL,0),(1357,'1,2,3,140,607,1356,1357',NULL,NULL,0,NULL,0),(1358,'1,2,3,140,607,1356,1357,1358',NULL,NULL,0,NULL,0),(1359,'1,668,1359',NULL,NULL,0,NULL,0),(1360,'1,668,1359,1360',NULL,NULL,0,NULL,0),(1361,'1,668,1361',NULL,NULL,0,NULL,0),(1362,'1,668,1361,1362',NULL,NULL,0,NULL,0),(1363,'1,668,1361,1363',NULL,NULL,0,NULL,0),(1364,'1,668,1361,1364',NULL,NULL,0,NULL,0),(1365,'1,668,1361,1365',NULL,NULL,0,NULL,0),(1366,'1,668,1361,1366',NULL,NULL,0,NULL,0),(1367,'1,668,1361,1367',NULL,NULL,0,NULL,0),(1368,'1,2,3,140,440,1368',NULL,NULL,0,NULL,0),(1369,'1,668,1361,1365,1369',NULL,NULL,0,NULL,0),(1370,'1,150,1212,1370',NULL,1212,0,11,0),(1371,'1,668,1371',NULL,NULL,0,NULL,0),(1372,'1,668,1371,1372',NULL,NULL,0,NULL,0),(1373,'1,668,1373',NULL,NULL,0,NULL,0),(1374,'1,668,1373,1374',NULL,NULL,0,NULL,0),(1375,'1,668,1373,1375',NULL,NULL,0,NULL,0),(1376,'1,668,1373,1376',NULL,NULL,0,NULL,0),(1377,'1,668,1373,1377',NULL,NULL,0,NULL,0),(1378,'1,668,1373,1378',NULL,NULL,0,NULL,0),(1379,'1,668,1373,1379',NULL,NULL,0,NULL,0),(1380,'1,668,1373,1380',NULL,NULL,0,NULL,0),(1381,'1,668,1373,1381',NULL,NULL,0,NULL,0),(1382,'1,668,1373,1382',NULL,NULL,0,NULL,0),(1383,'1,668,1373,1383',NULL,NULL,0,NULL,0),(1384,'1,668,1373,1384',NULL,NULL,0,NULL,0),(1385,'1,668,1361,1385',NULL,NULL,0,NULL,0),(1386,'1,668,1361,1386',NULL,NULL,0,NULL,0),(1387,'1,668,1361,1387',NULL,NULL,0,NULL,0),(1388,'1,668,1361,1388',NULL,NULL,0,NULL,0),(1389,'1,668,1361,1389',NULL,NULL,0,NULL,0),(1390,'1,668,1361,1390',NULL,NULL,0,NULL,0),(1391,'1,668,1391',NULL,NULL,0,NULL,0),(1392,'1,668,1392',NULL,NULL,0,NULL,0),(1393,'1,668,1391,1393',NULL,NULL,0,NULL,0),(1394,'1,668,1391,1394',NULL,NULL,0,NULL,0),(1395,'1,668,1391,1395',NULL,NULL,0,NULL,0),(1396,'1,668,1396',NULL,NULL,0,NULL,0),(1397,'1,668,1397',NULL,NULL,0,NULL,0),(1398,'1,668,1398',NULL,NULL,0,NULL,0),(1399,'1,668,1399',NULL,NULL,0,NULL,0),(1400,'1,668,1400',NULL,NULL,0,NULL,0),(1401,'1,668,1401',NULL,NULL,0,NULL,0),(1402,'1,668,1402',NULL,NULL,0,NULL,0),(1403,'1,668,1403',NULL,NULL,0,NULL,0),(1404,'1,668,1399,1404',NULL,NULL,0,NULL,0),(1405,'1,668,1399,1405',NULL,NULL,0,NULL,0),(1406,'1,668,1399,1406',NULL,NULL,0,NULL,0),(1407,'1,668,1392,1407',NULL,NULL,0,NULL,0),(1408,'1,668,1392,1408',NULL,NULL,0,NULL,0),(1409,'1,668,1392,1409',NULL,NULL,0,NULL,0),(1410,'1,668,1371,1410',NULL,NULL,0,NULL,0),(1411,'1,668,1371,1411',NULL,NULL,0,NULL,0),(1412,'1,668,1359,1412',NULL,NULL,0,NULL,0),(1413,'1,668,1359,1413',NULL,NULL,0,NULL,0),(1414,'1,668,1359,1414',NULL,NULL,0,NULL,0),(1415,'1,668,1359,1415',NULL,NULL,0,NULL,0),(1416,'1,668,1359,1416',NULL,NULL,0,NULL,0),(1417,'1,668,1359,1417',NULL,NULL,0,NULL,0),(1418,'1,668,1359,1418',NULL,NULL,0,NULL,0),(1419,'1,668,1359,1419',NULL,NULL,0,NULL,0),(1420,'1,668,1398,1420',NULL,NULL,0,NULL,0),(1421,'1,668,1398,1421',NULL,NULL,0,NULL,0),(1422,'1,668,1398,1422',NULL,NULL,0,NULL,0),(1423,'1,668,1398,1423',NULL,NULL,0,NULL,0),(1424,'1,668,1398,1424',NULL,NULL,0,NULL,0),(1425,'1,668,1397,1425',NULL,NULL,0,NULL,0),(1426,'1,668,1397,1426',NULL,NULL,0,NULL,0),(1427,'1,668,1397,1427',NULL,NULL,0,NULL,0),(1428,'1,668,1397,1428',NULL,NULL,0,NULL,0),(1429,'1,668,1429',NULL,NULL,0,NULL,0),(1430,'1,668,1429,1430',NULL,NULL,0,NULL,0),(1431,'1,668,1429,1431',NULL,NULL,0,NULL,0),(1432,'1,668,1429,1432',NULL,NULL,0,NULL,0),(1433,'1,668,1429,1433',NULL,NULL,0,NULL,0),(1434,'1,668,1403,1434',NULL,NULL,0,NULL,0),(1435,'1,668,1403,1435',NULL,NULL,0,NULL,0),(1436,'1,668,1403,1436',NULL,NULL,0,NULL,0),(1437,'1,668,1403,1437',NULL,NULL,0,NULL,0),(1438,'1,668,1403,1438',NULL,NULL,0,NULL,0),(1439,'1,668,1403,1439',NULL,NULL,0,NULL,0),(1440,'1,668,1400,1440',NULL,NULL,0,NULL,0),(1441,'1,668,1400,1441',NULL,NULL,0,NULL,0),(1442,'1,668,1401,1442',NULL,NULL,0,NULL,0),(1443,'1,668,1401,1443',NULL,NULL,0,NULL,0),(1444,'1,668,1401,1444',NULL,NULL,0,NULL,0),(1445,'1,668,1445',NULL,NULL,0,NULL,0),(1446,'1,2,3,140,1120,1446',NULL,NULL,0,NULL,0),(1447,'1,2,3,140,1120,1446,1447',NULL,NULL,0,NULL,0),(1448,'1,2,3,140,489,1448',NULL,NULL,0,NULL,0),(1449,'1,2,3,140,489,1448,1449',NULL,NULL,0,NULL,0),(1450,'1,2,3,140,1175,1176,1450',NULL,NULL,0,NULL,0),(1451,'1,150,1225,1451',NULL,1225,0,11,0),(1452,'1,668,1396,1452',NULL,NULL,0,NULL,0),(1453,'1,668,1396,1453',NULL,NULL,0,NULL,0),(1454,'1,2,3,140,669,1454',NULL,NULL,0,NULL,0),(1455,'1,150,1243,1455',NULL,1243,0,11,0),(1456,'1,150,1237,1456',NULL,1237,0,11,0),(1457,'1,150,1212,1457',NULL,1212,0,11,0),(1458,'1,150,1243,1458',NULL,1243,0,11,0),(1459,'1,2,3,140,510,1459',NULL,NULL,0,NULL,0),(1460,'1,2,3,140,533,1460',NULL,NULL,0,NULL,0),(1461,'1,2,3,140,553,1461',NULL,NULL,0,NULL,0),(1462,'1,2,3,140,482,1462',NULL,NULL,0,NULL,0),(1463,'1,2,3,140,1120,1463',NULL,NULL,0,NULL,0),(1464,'1,2,3,140,455,1464',NULL,NULL,0,NULL,0),(1465,'1,2,3,140,505,1465',NULL,NULL,0,NULL,0),(1466,'1,2,3,140,559,1466',NULL,NULL,0,NULL,0),(1467,'1,2,3,140,489,1467',NULL,NULL,0,NULL,0),(1468,'1,2,3,140,440,1468',NULL,NULL,0,NULL,0),(1469,'1,2,3,140,656,1469',NULL,NULL,0,NULL,0),(1470,'1,2,3,140,1175,1470',NULL,NULL,0,NULL,0),(1471,'1,2,3,140,607,1471',NULL,NULL,0,NULL,0),(1472,'1,2,3,140,651,1472',NULL,NULL,0,NULL,0),(1473,'1,2,3,140,172,1473',NULL,NULL,0,NULL,0),(1474,'1,150,1199,1474',NULL,1199,0,15,0),(1475,'1,150,1199,1475',NULL,1199,0,15,0),(1476,'1,150,1212,1476',NULL,1212,0,11,0),(1477,'1,1477',NULL,NULL,0,7,0),(1478,'1,150,1237,1478',NULL,1237,0,11,0),(1479,'1,2,3,140,141,1479',NULL,NULL,0,NULL,0),(1480,'1,150,1237,1480',NULL,1237,0,11,0),(1481,'1,150,1199,1481',NULL,1199,0,15,0),(1482,'1,1482',NULL,1482,0,7,0),(1483,'1,1482,1483',NULL,1482,0,7,0),(1484,'1,1482,1484',NULL,1482,0,7,0),(1485,'1,1482,1485',NULL,1482,0,7,0),(1486,'1,1482,1486',NULL,1482,0,7,0),(1487,'1,1482,1487',NULL,1482,0,7,0),(1488,'1,1482,1488',NULL,1482,0,7,0),(1489,'1,1482,1489',NULL,1482,0,7,0),(1490,'1,150,1314,1490',NULL,1314,0,11,0),(1491,'1,150,1314,1491',NULL,1314,0,11,0),(1492,'1,150,1212,1492',NULL,1212,0,11,0),(1493,'1,150,1212,1493',NULL,1212,0,11,0),(1494,'1,150,1329,1494',NULL,1329,0,11,0),(1495,'1,150,1329,1495',NULL,1329,0,11,0),(1496,'1,2,4,136,1496',NULL,NULL,0,NULL,0),(1497,'1,2,4,136,1496,1497',NULL,NULL,0,NULL,0),(1498,'1,2,4,136,1496,1498',NULL,NULL,0,NULL,0),(1499,'1,2,4,136,1496,1499',NULL,NULL,0,NULL,0),(1500,'1,2,4,136,1496,1500',NULL,NULL,0,NULL,0),(1501,'1,2,4,136,1496,1501',NULL,NULL,0,NULL,0),(1502,'1,2,4,136,1496,1502',NULL,NULL,0,NULL,0),(1503,'1,2,4,136,1503',NULL,NULL,0,NULL,0),(1504,'1,2,4,136,1503,1504',NULL,NULL,0,NULL,0),(1505,'1,2,4,136,1503,1505',NULL,NULL,0,NULL,0),(1506,'1,2,4,136,1503,1506',NULL,NULL,0,NULL,0),(1507,'1,2,4,136,1503,1507',NULL,NULL,0,NULL,0),(1508,'1,2,4,136,1503,1508',NULL,NULL,0,NULL,0),(1509,'1,2,4,136,1503,1509',NULL,NULL,0,NULL,0),(1510,'1,2,4,136,1503,1510',NULL,NULL,0,NULL,0),(1511,'1,2,4,136,1503,1511',NULL,NULL,0,NULL,0),(1512,'1,2,4,136,1503,1512',NULL,NULL,0,NULL,0),(1513,'1,2,4,136,1503,1513',NULL,NULL,0,NULL,0),(1514,'1,2,4,136,1503,1514',NULL,NULL,0,NULL,0),(1515,'1,2,4,136,1503,1515',NULL,NULL,0,NULL,0),(1516,'1,1516',NULL,NULL,0,7,0),(1517,'1,2,4,333,1151,1517',NULL,NULL,0,NULL,0),(1518,'1,1482,1518',NULL,1482,0,7,0),(1519,'1,1482,1519',NULL,1482,0,7,0),(1520,'1,1482,1520',NULL,1482,0,7,0),(1521,'1,1482,1521',NULL,1482,0,7,0),(1522,'1,1482,1522',NULL,1482,0,7,0),(1523,'1,150,1329,1523',NULL,1329,0,11,0),(1524,'1,150,1329,1524',NULL,1329,0,11,0),(1525,'1,150,1329,1525',NULL,1329,0,11,0),(1526,'1,1526',NULL,1526,0,7,0),(1527,'1,1526,1527',NULL,1526,0,7,0),(1528,'1,1526,1528',NULL,1526,0,7,0),(1529,'1,1526,1529',NULL,1526,0,7,0),(1530,'1,1526,1530',NULL,1526,0,7,0),(1531,'1,1526,1531',NULL,1526,0,7,0),(1532,'1,1526,1532',NULL,1526,0,7,0),(1533,'1,1526,1533',NULL,1526,0,7,0),(1534,'1,1526,1534',NULL,1526,0,7,0),(1535,'1,1526,1535',NULL,1526,0,7,0),(1536,'1,1526,1536',NULL,1526,0,7,0),(1537,'1,1526,1537',NULL,1526,0,7,0),(1538,'1,1526,1538',NULL,1526,0,7,0),(1539,'1,1526,1539',NULL,1526,0,7,0),(1540,'1,1526,1540',NULL,1526,0,7,0),(1541,'1,1526,1541',NULL,1526,0,7,0),(1542,'1,1542',NULL,1542,0,7,0),(1543,'1,1543',NULL,1543,0,7,0);
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
INSERT INTO `tree_user_config` VALUES ('3-recycleBin',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"cid\":{\"idx\":2,\"width\":200,\"sortable\":true},\"ddate\":{\"idx\":3,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"ASC\"},\"group\":null}'),('7-cases',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"assigned\":{\"idx\":2,\"width\":100,\"sortable\":true},\"cdate\":{\"idx\":3,\"width\":130,\"sortable\":true},\"task_d_closed\":{\"idx\":4,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"nid\",\"direction\":\"ASC\"},\"group\":null}'),('7-cases',24,'{\"columns\":{\"name\":{\"idx\":0,\"width\":264,\"sortable\":true},\"assigned\":{\"idx\":1,\"width\":143,\"sortable\":true},\"task_d_closed\":{\"idx\":2,\"width\":130,\"sortable\":true},\"cdate\":{\"idx\":3,\"width\":125,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"assigned\",\"direction\":\"ASC\"},\"group\":null}'),('default',1,'{\"columns\":{\"name\":{\"idx\":0,\"width\":362,\"sortable\":true},\"nid\":{\"idx\":1,\"width\":80,\"sortable\":true},\"date\":{\"idx\":2,\"width\":130,\"sortable\":true},\"size\":{\"idx\":3,\"width\":80,\"sortable\":true},\"cid\":{\"idx\":4,\"width\":200,\"sortable\":true},\"oid\":{\"idx\":5,\"width\":200,\"sortable\":true},\"cdate\":{\"idx\":6,\"width\":130,\"sortable\":true},\"udate\":{\"idx\":7,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"ASC\"},\"group\":null}'),('template_11',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"type\":{\"idx\":2,\"width\":100,\"sortable\":true},\"cfg\":{\"idx\":3,\"width\":169,\"sortable\":true},\"order\":{\"idx\":4,\"width\":98,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"DESC\"},\"group\":null}'),('template_141',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"cid\":{\"idx\":2,\"width\":200,\"sortable\":true},\"cdate\":{\"idx\":3,\"width\":166,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"name\",\"direction\":\"ASC\"},\"group\":null}'),('template_5',1,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":45,\"sortable\":true},\"name\":{\"idx\":1,\"width\":253,\"sortable\":true},\"oid\":{\"idx\":2,\"width\":115,\"sortable\":true},\"cid\":{\"idx\":3,\"width\":106,\"sortable\":true},\"cdate\":{\"idx\":4,\"width\":207,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"nid\",\"direction\":\"DESC\"},\"group\":null}'),('template_5',21,'{\"columns\":{\"nid\":{\"idx\":0,\"width\":80,\"sortable\":true},\"name\":{\"idx\":1,\"width\":300,\"sortable\":true},\"oid\":{\"idx\":2,\"width\":200,\"sortable\":true},\"cid\":{\"idx\":3,\"width\":200,\"sortable\":true},\"cdate\":{\"idx\":4,\"width\":130,\"sortable\":true}},\"sort\":{\"root\":\"data\",\"property\":\"nid\",\"direction\":\"ASC\"},\"group\":null}');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
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
INSERT INTO `users_groups_association` VALUES (21,22,1,'2016-12-12 02:19:03',NULL,NULL),(24,22,1,'2016-12-15 18:51:41',NULL,NULL),(27,22,1,'2016-12-16 16:21:23',NULL,NULL);
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

-- Dump completed on 2017-01-19 21:19:12
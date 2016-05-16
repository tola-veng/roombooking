# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.1.13-MariaDB)
# Database: roombooking_db
# Generation Time: 2016-05-16 00:12:41 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table tb_attendant
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_attendant`;

CREATE TABLE `tb_attendant` (
  `att_id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `att_firstname` varchar(32) DEFAULT NULL,
  `att_lastname` varchar(32) DEFAULT NULL,
  `att_more` tinytext,
  PRIMARY KEY (`att_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tb_block
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_block`;

CREATE TABLE `tb_block` (
  `block_id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` tinyint(4) DEFAULT NULL,
  `block_date` date DEFAULT NULL,
  `block_from` time DEFAULT NULL,
  `block_to` time DEFAULT NULL,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tb_booking
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_booking`;

CREATE TABLE `tb_booking` (
  `booking_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` tinyint(4) NOT NULL,
  `user_id` varchar(11) NOT NULL DEFAULT '',
  `booking_date` date NOT NULL,
  `booking_time` time NOT NULL,
  `booking_session` tinyint(4) DEFAULT NULL,
  `booking_on` datetime DEFAULT NULL,
  `cancelled` tinyint(1) DEFAULT '0',
  `admitted` tinyint(1) DEFAULT '1',
  `notified` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tb_room
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_room`;

CREATE TABLE `tb_room` (
  `room_id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `room_num` varchar(128) NOT NULL DEFAULT '',
  `building_id` tinyint(4) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `hidden` tinyint(1) DEFAULT NULL,
  `session` tinyint(1) NOT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tb_setting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_setting`;

CREATE TABLE `tb_setting` (
  `id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `smtp` varchar(255) DEFAULT NULL,
  `clean_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tb_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `user_id` varchar(11) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(32) NOT NULL DEFAULT '',
  `lastname` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(64) DEFAULT '',
  `phone` varchar(16) DEFAULT NULL,
  `verify_code` varchar(32) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `attempted` tinyint(1) DEFAULT NULL,
  `role` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

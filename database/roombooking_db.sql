-- phpMyAdmin SQL Dump
-- version 4.6.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 18, 2016 at 07:25 am
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `roombooking_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_attendant`
--

CREATE TABLE `tb_attendant` (
  `att_id` tinyint(4) UNSIGNED NOT NULL,
  `booking_id` int(11) NOT NULL,
  `att_firstname` varchar(32) DEFAULT NULL,
  `att_lastname` varchar(32) DEFAULT NULL,
  `att_more` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_block`
--

CREATE TABLE `tb_block` (
  `block_id` tinyint(4) UNSIGNED NOT NULL,
  `room_id` tinyint(4) DEFAULT NULL,
  `block_date` date DEFAULT NULL,
  `block_from` time DEFAULT NULL,
  `block_to` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_booking`
--

CREATE TABLE `tb_booking` (
  `booking_id` int(11) UNSIGNED NOT NULL,
  `room_id` tinyint(4) NOT NULL,
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `booking_date` date NOT NULL,
  `booking_time` time NOT NULL,
  `booking_session` tinyint(4) DEFAULT NULL,
  `booking_on` datetime DEFAULT NULL,
  `cancelled` tinyint(1) DEFAULT '0',
  `admitted` tinyint(1) DEFAULT '1',
  `notified` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_room`
--

CREATE TABLE `tb_room` (
  `room_id` tinyint(4) UNSIGNED NOT NULL,
  `room_num` varchar(128) NOT NULL DEFAULT '',
  `building_id` tinyint(4) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `hidden` tinyint(1) DEFAULT NULL,
  `session` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_room`
--

INSERT INTO `tb_room` (`room_id`, `room_num`, `building_id`, `description`, `hidden`, `session`) VALUES
(1, 'TD 303 Photography', NULL, 'Photography computer lab', NULL, 0),
(2, 'TC 101', NULL, 'Computer lab', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tb_setting`
--

CREATE TABLE `tb_setting` (
  `key` varchar(16) NOT NULL DEFAULT '',
  `val` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(32) NOT NULL DEFAULT '',
  `lastname` varchar(32) NOT NULL DEFAULT '',
  `phone` varchar(16) DEFAULT NULL,
  `verify_code` varchar(6) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `role` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`user_id`, `password`, `firstname`, `lastname`, `phone`, `verify_code`, `verified`, `blocked`, `role`) VALUES
('', '', '', '', NULL, NULL, NULL, NULL, NULL),
('123@swin.edu.au', 'd9b1d7db4cd6e70935368a1efb10e377', '123', '456', '123456', '0af1b3', 0, 0, 0),
('aaa@swin.edu.au', 'd4fbb7d8d5603db43ac2094f5955787c', 'aaa', 'aaa', '', 'd93b4a', 0, 0, 0),
('abc@test.com', '28c8edde3d61a0411511d3b1866f0636', 'first name', 'admin', 'admin', 'a182c4', 0, 0, 0),
('admin@swin.edu.au', 'c3284d0f94606de1fd2af172aba15bf3', 'Admin', 'Admin', '', '7e7da4', 0, 0, 1),
('bbb', 'c1c25df8f8f22eefed0ef135c19b8394', 'bbb', 'bbb', '', 'ce21db', 0, 0, 0),
('ccc@ccc.com', '069a5dccefea1206d0a6cb426dede833', 'ccc', 'ccc', '', 'fb029a', 0, 0, 0),
('ddd', '1d8922d005309356634c3114859436f2', 'ddd', 'ddd', 'ddd', '956652', 0, 1, 0),
('demo@student.edu.au', '6c5ac7b4d3bd3311f033f971196cfa75', 'Demo User', 'Last Name', '', '907598', 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_attendant`
--
ALTER TABLE `tb_attendant`
  ADD PRIMARY KEY (`att_id`);

--
-- Indexes for table `tb_block`
--
ALTER TABLE `tb_block`
  ADD PRIMARY KEY (`block_id`);

--
-- Indexes for table `tb_booking`
--
ALTER TABLE `tb_booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `tb_room`
--
ALTER TABLE `tb_room`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `tb_setting`
--
ALTER TABLE `tb_setting`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_attendant`
--
ALTER TABLE `tb_attendant`
  MODIFY `att_id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tb_block`
--
ALTER TABLE `tb_block`
  MODIFY `block_id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tb_booking`
--
ALTER TABLE `tb_booking`
  MODIFY `booking_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tb_room`
--
ALTER TABLE `tb_room`
  MODIFY `room_id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

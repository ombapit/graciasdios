-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 25, 2014 at 11:44 AM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `gudang`
--

-- --------------------------------------------------------

--
-- Table structure for table `tipe_barang`
--

CREATE TABLE IF NOT EXISTS `tipe_barang` (
  `idtipe_barang` int(11) NOT NULL AUTO_INCREMENT,
  `nama_tipe` varchar(45) DEFAULT NULL,
  `related_table` varchar(25) NOT NULL,
  PRIMARY KEY (`idtipe_barang`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tipe_barang`
--

INSERT INTO `tipe_barang` (`idtipe_barang`, `nama_tipe`, `related_table`) VALUES
(1, 'Upright', 'ref_tinggi'),
(2, 'Beam', 'ref_beam'),
(3, 'Ambalan', 'ref_ambalan'),
(4, 'Footplate', 'ref_footplate'),
(5, 'Accessories', 'ref_accessories'),
(6, 'Center Support', 'ref_center_support');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

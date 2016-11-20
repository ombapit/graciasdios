-- phpMyAdmin SQL Dump
-- version 4.1.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 22, 2014 at 03:05 PM
-- Server version: 5.5.34-cll-lve
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mombpcom_dios`
--

-- --------------------------------------------------------

--
-- Table structure for table `ak_account`
--

CREATE TABLE IF NOT EXISTS `ak_account` (
  `idaccount` int(11) NOT NULL AUTO_INCREMENT,
  `idsubgroup` int(11) NOT NULL,
  `idmata_uang` int(11) NOT NULL,
  `kode` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idaccount`,`idsubgroup`,`idmata_uang`),
  KEY `fk_akun_subgroup1_idx` (`idsubgroup`),
  KEY `fk_akun_mata_uang1_idx` (`idmata_uang`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ak_account`
--

INSERT INTO `ak_account` (`idaccount`, `idsubgroup`, `idmata_uang`, `kode`, `nama`) VALUES
(1, 4, 1, '4100', 'Penjualan'),
(2, 1, 1, '123', 'kas'),
(3, 4, 1, '1130', 'Piutang Dagang');

-- --------------------------------------------------------

--
-- Table structure for table `ak_group`
--

CREATE TABLE IF NOT EXISTS `ak_group` (
  `idgroup` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idgroup`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ak_group`
--

INSERT INTO `ak_group` (`idgroup`, `nama`) VALUES
(1, '1'),
(2, '2');

-- --------------------------------------------------------

--
-- Table structure for table `ak_jurnal_umum`
--

CREATE TABLE IF NOT EXISTS `ak_jurnal_umum` (
  `idjurnal` int(11) NOT NULL AUTO_INCREMENT,
  `idperiode` int(11) NOT NULL,
  `idtipe_jurnal` int(11) NOT NULL,
  `tanggal_jurnal` date DEFAULT NULL,
  `no_bukti` varchar(50) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`idjurnal`,`idperiode`,`idtipe_jurnal`),
  KEY `fk_jurnal_periode1_idx` (`idperiode`),
  KEY `fk_jurnal_tipe_jurnal1_idx` (`idtipe_jurnal`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ak_jurnal_umum`
--

INSERT INTO `ak_jurnal_umum` (`idjurnal`, `idperiode`, `idtipe_jurnal`, `tanggal_jurnal`, `no_bukti`, `keterangan`, `created_date`, `created_by`) VALUES
(3, 2, 1, '2014-05-19', '123', 'Penjualan', '2014-05-19 12:47:52', 3);

-- --------------------------------------------------------

--
-- Table structure for table `ak_jurnal_umum_detail`
--

CREATE TABLE IF NOT EXISTS `ak_jurnal_umum_detail` (
  `idjurnal_detail` int(11) NOT NULL AUTO_INCREMENT,
  `idjurnal` int(11) NOT NULL,
  `idaccount` int(11) NOT NULL,
  `debet` decimal(10,0) DEFAULT NULL,
  `kredit` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`idjurnal_detail`,`idjurnal`,`idaccount`),
  KEY `fk_jurnal_detail_jurnal1_idx` (`idjurnal`),
  KEY `fk_jurnal_detail_akun1_idx` (`idaccount`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ak_jurnal_umum_detail`
--

INSERT INTO `ak_jurnal_umum_detail` (`idjurnal_detail`, `idjurnal`, `idaccount`, `debet`, `kredit`) VALUES
(1, 3, 1, '0', '5000000'),
(2, 3, 3, '5000000', '0');

-- --------------------------------------------------------

--
-- Table structure for table `ak_mata_uang`
--

CREATE TABLE IF NOT EXISTS `ak_mata_uang` (
  `idmata_uang` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idmata_uang`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ak_mata_uang`
--

INSERT INTO `ak_mata_uang` (`idmata_uang`, `kode`, `nama`) VALUES
(1, 'IDR', 'Rupiah'),
(2, 'USD', 'US Dollar');

-- --------------------------------------------------------

--
-- Table structure for table `ak_periode`
--

CREATE TABLE IF NOT EXISTS `ak_periode` (
  `idperiode` int(11) NOT NULL AUTO_INCREMENT,
  `nama_periode` varchar(50) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  PRIMARY KEY (`idperiode`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ak_periode`
--

INSERT INTO `ak_periode` (`idperiode`, `nama_periode`, `start`, `end`) VALUES
(1, 'April 2014', '2014-04-01', '2014-04-30'),
(2, 'Mei 2014', '2013-05-01', '2014-05-31');

-- --------------------------------------------------------

--
-- Table structure for table `ak_saldo_awal`
--

CREATE TABLE IF NOT EXISTS `ak_saldo_awal` (
  `idsaldo_awal` int(11) NOT NULL AUTO_INCREMENT,
  `idaccount` int(11) NOT NULL,
  `idperiode` int(11) NOT NULL,
  `debet` float DEFAULT NULL,
  `kredit` float DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsaldo_awal`,`idaccount`,`idperiode`),
  KEY `fk_saldo_awal_akun1_idx` (`idaccount`),
  KEY `fk_saldo_awal_periode1_idx` (`idperiode`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ak_saldo_awal`
--

INSERT INTO `ak_saldo_awal` (`idsaldo_awal`, `idaccount`, `idperiode`, `debet`, `kredit`, `created_date`, `created_by`) VALUES
(1, 1, 1, 0, 125000, '2014-04-22 09:16:32', 3),
(2, 2, 1, 100000, 0, '2014-04-22 10:25:50', 3),
(3, 2, 1, 500000, 0, '2014-04-22 10:26:13', 3);

-- --------------------------------------------------------

--
-- Table structure for table `ak_subgroup`
--

CREATE TABLE IF NOT EXISTS `ak_subgroup` (
  `idsubgroup` int(11) NOT NULL AUTO_INCREMENT,
  `idgroup` int(11) NOT NULL,
  `kode` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsubgroup`,`idgroup`),
  KEY `fk_ak_subgroup_group1_idx` (`idgroup`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `ak_subgroup`
--

INSERT INTO `ak_subgroup` (`idsubgroup`, `idgroup`, `kode`, `nama`, `created_date`, `created_by`) VALUES
(1, 1, '1', 'Harta', NULL, NULL),
(2, 2, '2', 'Kewajiban', NULL, NULL),
(3, 2, '3', 'Modal', NULL, NULL),
(4, 2, '4', 'Pendapatan', NULL, NULL),
(5, 1, '5', 'Biaya atas Pendapatan', NULL, NULL),
(6, 1, '6', 'Pengeluaran Operasional', NULL, NULL),
(7, 1, '7', 'Pengeluaran Non Operasional', NULL, NULL),
(8, 2, '8', 'Pendapatan Lain', NULL, NULL),
(9, 1, '9', 'Pengeluaran Lain', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ak_tipe_jurnal`
--

CREATE TABLE IF NOT EXISTS `ak_tipe_jurnal` (
  `idtipe_jurnal` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtipe_jurnal`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ak_tipe_jurnal`
--

INSERT INTO `ak_tipe_jurnal` (`idtipe_jurnal`, `kode`, `nama`) VALUES
(1, 'J-Pn', 'Jurnal Penjualan');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE IF NOT EXISTS `barang` (
  `idbarang` int(11) NOT NULL AUTO_INCREMENT,
  `idtipe_barang` int(11) NOT NULL,
  `idref` int(11) NOT NULL,
  `kode_barang` varchar(45) DEFAULT NULL,
  `nama_barang` varchar(100) DEFAULT NULL,
  `berat` decimal(11,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  `quantity_sby` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idbarang`),
  KEY `fk_barang_tipe_barang_idx` (`idtipe_barang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `idcustomer` int(11) NOT NULL AUTO_INCREMENT,
  `nama_customer` varchar(100) DEFAULT NULL,
  `tipe_customer` varchar(50) NOT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `contact_person` varchar(300) NOT NULL,
  `alamat` varchar(500) DEFAULT NULL,
  `telp` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `npwp` varchar(100) NOT NULL,
  PRIMARY KEY (`idcustomer`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`idcustomer`, `nama_customer`, `tipe_customer`, `jenis_kelamin`, `contact_person`, `alamat`, `telp`, `fax`, `email`, `npwp`) VALUES
(1, 'Gunita febriyanti', 'perseorangan', 'P', '', 'Citra indah cluster cendana\nJonggol - bogor', '081394255691', '02121122382', 'gunita.febryiyanti@gmail.com', 'gunita'),
(2, 'Aditya Martin', 'perseorangan', 'L', '', 'Jl Jatiwaringin \nBekasi', '0812312312312', '', 'ajmartin@yahoo.com', 'ajmartin'),
(3, 'David Suwandi', 'perseorangan', 'L', '', 'Jl. Dr. Satrio\nSetiabudi Kuningan\nJakarta Selatan', '08889451452', '', 'davidsuwandi@gmail.com', 'davidsuwandi'),
(4, 'Maju Terus', 'pt', '', 'Andi M, Hp: 08123123121, Hp2: 081123123123', 'Mampang Prapatan', '08112312312', '', 'majuterus@yahoo.com', '12312312312312');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'Super Admin', 'Administrator'),
(17, 'Public', 'View Stock Only'),
(18, 'Inputter', 'Transaction Only');

-- --------------------------------------------------------

--
-- Table structure for table `gudang`
--

CREATE TABLE IF NOT EXISTS `gudang` (
  `idstock_history` int(11) NOT NULL AUTO_INCREMENT,
  `ref_code` varchar(45) DEFAULT NULL,
  `idtransaksi_penjualan_detail` int(11) NOT NULL,
  `idbarang` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `jumlah_sby` int(11) NOT NULL,
  `type` enum('keluar','masuk') DEFAULT NULL,
  `no_surat_jalan` varchar(45) DEFAULT NULL,
  `deskripsi` text,
  `date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`idstock_history`),
  KEY `fk_stock_history_barang1_idx` (`idbarang`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=113 ;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Table structure for table `ref_accessories`
--

CREATE TABLE IF NOT EXISTS `ref_accessories` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(100) NOT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ref_accessories`
--

INSERT INTO `ref_accessories` (`idref`, `nilai`) VALUES
(1, 'All Size');

-- --------------------------------------------------------

--
-- Table structure for table `ref_ambalan`
--

CREATE TABLE IF NOT EXISTS `ref_ambalan` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `ref_ambalan`
--

INSERT INTO `ref_ambalan` (`idref`, `nilai`) VALUES
(1, 'SV 600 x 1800'),
(2, 'PW 600 x 1800'),
(3, 'CS 600 x 1800'),
(4, 'SV 450 x 1800'),
(5, 'SV 400 x 1800'),
(6, 'SV 300 x 1800'),
(7, 'SV 600 x 1200'),
(8, 'SV 450 x 1200'),
(9, 'SV 400 x 1200'),
(10, 'SV 300 x 1200'),
(11, 'SV 600 x 900'),
(12, 'SV 450 x 900'),
(13, 'SV 400 x 900'),
(14, 'SV 300 x 900'),
(15, 'CS 450 x 1800'),
(16, 'CS 400 x 1800'),
(17, 'CS 300 x 1800'),
(18, 'CS 600 x 1200'),
(19, 'CS 450 x 1200'),
(20, 'CS 400 x 1200'),
(21, 'CS 300 x 1200'),
(38, 'MPW 600 x 1800'),
(41, 'MPW 450 x 1800'),
(40, 'MPW 600 x 900'),
(39, 'MPW 600 x 1200'),
(22, 'CS 600 x 900'),
(23, 'CS 450 x 900'),
(24, 'CS 400 x 900'),
(25, 'CS 300 x 900'),
(27, 'PW 600 x 1200'),
(28, 'PW 600 x 900'),
(29, 'PW 450 x 1800'),
(30, 'PW 450 x 1200'),
(31, 'PW 450 x 900'),
(32, 'PW 400 x 1800'),
(33, 'PW 400 x 1200'),
(34, 'PW 400 x 900'),
(35, 'PW 300 x 1800'),
(36, 'PW 300 x 1200'),
(37, 'PW 300 x 900'),
(43, 'MPW 450 x 900'),
(44, 'MPW 400 x 900'),
(45, 'MPW 450 x 1200'),
(47, 'MPW 400 x 1800'),
(48, 'MPW 400 x 1200'),
(50, 'MPW 300 x 1800'),
(51, 'MPW 300 x 1200'),
(52, 'MPW 300 x 900');

-- --------------------------------------------------------

--
-- Table structure for table `ref_beam`
--

CREATE TABLE IF NOT EXISTS `ref_beam` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(25) DEFAULT NULL,
  `satuan` enum('MM') DEFAULT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `ref_beam`
--

INSERT INTO `ref_beam` (`idref`, `nilai`, `satuan`) VALUES
(1, '450', 'MM'),
(2, '300', 'MM'),
(3, '400', 'MM'),
(4, '600', 'MM'),
(5, '900', 'MM'),
(6, '1000', 'MM'),
(7, '1200', 'MM'),
(8, '1500', 'MM'),
(9, '1800', 'MM');

-- --------------------------------------------------------

--
-- Table structure for table `ref_center_support`
--

CREATE TABLE IF NOT EXISTS `ref_center_support` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ref_footplate`
--

CREATE TABLE IF NOT EXISTS `ref_footplate` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18446744073709551615 ;

--
-- Dumping data for table `ref_footplate`
--

INSERT INTO `ref_footplate` (`idref`, `nilai`) VALUES
(1, 'Plastic'),
(2, 'Steel foot 40mm x 40mm');

-- --------------------------------------------------------

--
-- Table structure for table `ref_level`
--

CREATE TABLE IF NOT EXISTS `ref_level` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` int(11) DEFAULT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18446744073709551615 ;

--
-- Dumping data for table `ref_level`
--

INSERT INTO `ref_level` (`idref`, `nilai`) VALUES
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9);

-- --------------------------------------------------------

--
-- Table structure for table `ref_tinggi`
--

CREATE TABLE IF NOT EXISTS `ref_tinggi` (
  `idref` int(11) NOT NULL AUTO_INCREMENT,
  `nilai` int(11) DEFAULT NULL,
  `satuan` enum('MM') DEFAULT NULL,
  PRIMARY KEY (`idref`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18446744073709551615 ;

--
-- Dumping data for table `ref_tinggi`
--

INSERT INTO `ref_tinggi` (`idref`, `nilai`, `satuan`) VALUES
(1, 1800, 'MM'),
(2, 2100, 'MM'),
(3, 2700, 'MM'),
(4, 3100, 'MM'),
(5, 3500, 'MM');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `idsupplier` int(11) NOT NULL AUTO_INCREMENT,
  `idsupplier_type` int(11) NOT NULL,
  `nama_supplier` varchar(100) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `telp` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idsupplier`),
  KEY `idsupplier_type` (`idsupplier_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`idsupplier`, `idsupplier_type`, `nama_supplier`, `alamat`, `telp`, `fax`) VALUES
(2, 1, 'Default Supplier', 'Default', '0888888888', ''),
(3, 2, 'Supplier 2', 'Lebak bulus', '08123123', '08123123');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers_type`
--

CREATE TABLE IF NOT EXISTS `suppliers_type` (
  `idsupplier_type` int(11) NOT NULL AUTO_INCREMENT,
  `nama_tipe` varchar(100) NOT NULL,
  PRIMARY KEY (`idsupplier_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `suppliers_type`
--

INSERT INTO `suppliers_type` (`idsupplier_type`, `nama_tipe`) VALUES
(1, 'Ambalan Supplier'),
(2, 'Foot Plate Supplier');

-- --------------------------------------------------------

--
-- Table structure for table `tipe_barang`
--

CREATE TABLE IF NOT EXISTS `tipe_barang` (
  `idtipe_barang` int(11) NOT NULL AUTO_INCREMENT,
  `nama_tipe` varchar(45) DEFAULT NULL,
  `related_table` varchar(25) NOT NULL,
  PRIMARY KEY (`idtipe_barang`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tipe_barang`
--

INSERT INTO `tipe_barang` (`idtipe_barang`, `nama_tipe`, `related_table`) VALUES
(1, 'Upright', 'ref_tinggi'),
(2, 'Beam', 'ref_lebar'),
(4, 'Ambalan', 'ref_ambalan'),
(5, 'Footplate', 'ref_footplate'),
(6, 'Accessories', 'ref_accessories');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_pembelian`
--

CREATE TABLE IF NOT EXISTS `transaksi_pembelian` (
  `idtransaksi_pembelian` int(11) NOT NULL AUTO_INCREMENT,
  `idsupplier` int(11) NOT NULL,
  `ref_code` varchar(45) DEFAULT NULL,
  `tanggal_pembelian` date DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`idtransaksi_pembelian`),
  KEY `idsupplier` (`idsupplier`),
  KEY `idsupplier_2` (`idsupplier`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_pembelian_detail`
--

CREATE TABLE IF NOT EXISTS `transaksi_pembelian_detail` (
  `idtransaksi_pembelian_detail` int(11) NOT NULL AUTO_INCREMENT,
  `idtransaksi_pembelian` int(11) NOT NULL,
  `idbarang` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `jumlah_sby` int(11) NOT NULL,
  PRIMARY KEY (`idtransaksi_pembelian_detail`),
  KEY `idtransaksi_pembelian` (`idtransaksi_pembelian`),
  KEY `idbarang` (`idbarang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_penjualan`
--

CREATE TABLE IF NOT EXISTS `transaksi_penjualan` (
  `idtransaksi_penjualan` int(11) NOT NULL AUTO_INCREMENT,
  `idcustomer` int(11) NOT NULL,
  `ref_code` varchar(45) DEFAULT NULL,
  `po_customer` varchar(100) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `status` enum('in progress','on delivery','done') NOT NULL,
  `tanggal_penjualan` date DEFAULT NULL,
  `type` enum('retail','project') NOT NULL,
  `created_date` datetime NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`idtransaksi_penjualan`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_penjualan_detail`
--

CREATE TABLE IF NOT EXISTS `transaksi_penjualan_detail` (
  `idtransaksi_penjualan_detail` int(11) NOT NULL AUTO_INCREMENT,
  `ref_code` varchar(45) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `idref_level` int(11) NOT NULL,
  `idref_tinggi` int(11) NOT NULL,
  `idref_lebar` int(11) NOT NULL,
  `idref_depth` int(11) NOT NULL,
  `idref_ambalan` int(11) NOT NULL,
  `idref_footplate` int(11) NOT NULL,
  `idref_accessories` int(11) NOT NULL,
  `stock` varchar(10) NOT NULL,
  PRIMARY KEY (`idtransaksi_penjualan_detail`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'super_admin', 'b98af4c2f41747d26f23214abebe59231f6d63db', 'c789377284', 'admin@admin.com', '', NULL, NULL, '4b49c3499c206f2d5a07e9efe6c8b58acd9e8fb3', 1268889823, 1413545145, 1, 'Admin', 'istrator', 'ADMIN', '0'),
(3, '::1', 'ruth', 'f0724ed1f28fc4c7f6b40d0a2b2cf6040f1ecfeb', 'c789377284', 'ruth@graciasdios.com', NULL, NULL, NULL, 'e7755daebfdea2df1e14cccbc04bf3edcf13ff3b', 1396678916, 1401084154, 1, 'ruth', '-', '-', '-'),
(4, '::1', 'public', '3b7ffd433050394954a6cff2aff4ceeaaf69216d', '59ce60015b', 'public@graciasdios.com', NULL, NULL, NULL, NULL, 1397039928, 1401532605, 1, 'public', '-', ' -', '081231231212'),
(6, '::1', 'anjar', '9c1a42db466f5b695669fc36c352794d62551e38', '47ecbee102', 'anjar@graciasdios.com', NULL, NULL, NULL, NULL, 1401083491, 1401531913, 1, 'Anjar', '-', '-', '-');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  KEY `fk_users_groups_groups1_idx` (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=68 ;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(64, 1, 1),
(67, 3, 18),
(66, 4, 17),
(65, 6, 18);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_user_groups`
--
CREATE TABLE IF NOT EXISTS `v_user_groups` (
`user_id` int(11) unsigned
,`group_name` text
);
-- --------------------------------------------------------

--
-- Structure for view `v_user_groups`
--
DROP TABLE IF EXISTS `v_user_groups`;

CREATE ALGORITHM=UNDEFINED DEFINER=`mombpcom`@`localhost` SQL SECURITY DEFINER VIEW `v_user_groups` AS select `aaa`.`user_id` AS `user_id`,group_concat(`bbb`.`name` order by `bbb`.`name` ASC separator ', ') AS `group_name` from (`users_groups` `aaa` join `groups` `bbb` on((`aaa`.`group_id` = `bbb`.`id`))) group by `aaa`.`user_id`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

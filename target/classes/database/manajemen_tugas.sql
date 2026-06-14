-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2026 at 10:52 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `manajemen_tugas`
--

-- Nonaktifkan foreign key checks untuk menghindari error saat dropping/creating tables
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `tugas_pribadi`;
DROP TABLE IF EXISTS `tugas_mahasiswa`;
DROP TABLE IF EXISTS `tugas`;
DROP TABLE IF EXISTS `dosen_mk`;
DROP TABLE IF EXISTS `mahasiswa`;
DROP TABLE IF EXISTS `dosen`;
DROP TABLE IF EXISTS `mata_kuliah`;
DROP TABLE IF EXISTS `user`;

SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('MAHASISWA','DOSEN') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `email`, `password`, `role`) VALUES
(1, 'Aziz', 'aziz@gmail.com', '123', 'MAHASISWA'),
(2, 'Fajar', 'fajar@gmail.com', '123', 'MAHASISWA'),
(3, 'Nabila', 'nabila@gmail.com', '123', 'MAHASISWA'),
(4, 'Pak Ardian', 'ardian@gmail.com', '123', 'DOSEN'),
(5, 'Bu Affifah', 'affifah@gmail.com', '123', 'DOSEN');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nim` varchar(20) NOT NULL,
  `semester` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nim`, `semester`, `id_user`) VALUES
(1, '103072400103', 4, 1),
(2, '103072400104', 4, 2),
(3, '103072400105', 4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `nidn` varchar(20) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nidn`, `id_user`) VALUES
(1, 'D001', 4),
(2, 'D002', 5);

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id_mk` int(11) NOT NULL,
  `kode_mk` varchar(20) NOT NULL,
  `nama_mk` varchar(100) NOT NULL,
  `semester` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id_mk`, `kode_mk`, `nama_mk`, `semester`) VALUES
(1, 'DKAI', 'Dasar Kecerdasan Artifisial', 4),
(2, 'IMK', 'Interaksi Manusia Komputer', 4),
(3, 'JARKOM', 'Jaringan Komputer', 4),
(4, 'PBO', 'Pemrograman Berorientasi Objek', 4),
(5, 'SA', 'Strategi Algoritma', 4),
(6, 'WGT', 'Wawasan Global TIK', 4);

-- --------------------------------------------------------

--
-- Table structure for table `dosen_mk`
--

CREATE TABLE `dosen_mk` (
  `id` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL,
  `id_mk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dosen_mk`
--

INSERT INTO `dosen_mk` (`id`, `id_dosen`, `id_mk`) VALUES
(1, 1, 4), -- Pak Ardian mengampu PBO
(2, 2, 2); -- Bu Affifah mengampu IMK

-- --------------------------------------------------------

--
-- Table structure for table `tugas`
--

CREATE TABLE `tugas` (
  `id_tugas` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `tanggal_dibuat` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_mk` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `judul`, `deskripsi`, `deadline`, `tanggal_dibuat`, `id_mk`, `id_dosen`) VALUES
(1, 'Tugas PBO: inheritance', 'Implementasikan inheritance dan polymorphism pada program Java.', '2026-06-20', '2026-06-09 03:00:00', 4, 1),
(2, 'Tugas IMK: Figma Design', 'Buat high-fidelity prototype aplikasi mobile menggunakan Figma.', '2026-06-25', '2026-06-09 03:15:00', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tugas_mahasiswa`
--

CREATE TABLE `tugas_mahasiswa` (
  `id` int(11) NOT NULL,
  `id_tugas` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `status` enum('BELUM','SELESAI') DEFAULT 'BELUM',
  `tanggal_selesai` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tugas_mahasiswa`
--

INSERT INTO `tugas_mahasiswa` (`id`, `id_tugas`, `id_mahasiswa`, `status`, `tanggal_selesai`) VALUES
(1, 1, 1, 'BELUM', NULL),
(2, 1, 2, 'BELUM', NULL),
(3, 1, 3, 'BELUM', NULL),
(4, 2, 1, 'BELUM', NULL),
(5, 2, 2, 'BELUM', NULL),
(6, 2, 3, 'BELUM', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tugas_pribadi`
--

CREATE TABLE `tugas_pribadi` (
  `id_tugas_pribadi` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `id_mk` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `status` enum('BELUM','SELESAI') DEFAULT 'BELUM',
  `tanggal_dibuat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tugas_pribadi`
--

INSERT INTO `tugas_pribadi` (`id_tugas_pribadi`, `id_mahasiswa`, `id_mk`, `judul`, `deskripsi`, `deadline`, `status`, `tanggal_dibuat`) VALUES
(1, 1, 4, 'Belajar Git', 'Mempelajari branching dan merging di Git.', '2026-06-12', 'BELUM', '2026-06-09 03:30:00'),
(2, 2, 4, 'Beli Buku Catatan', 'Membeli buku catatan baru untuk kuliah.', '2026-06-10', 'SELESAI', '2026-06-09 03:32:00'),
(3, 3, 2, 'Persiapan Presentasi', 'Membuat slide presentasi untuk projek kelompok.', '2026-06-14', 'BELUM', '2026-06-09 03:35:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD KEY `fk_mahasiswa_user` (`id_user`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`),
  ADD UNIQUE KEY `nidn` (`nidn`),
  ADD KEY `fk_dosen_user` (`id_user`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id_mk`);

--
-- Indexes for table `dosen_mk`
--
ALTER TABLE `dosen_mk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dosen` (`id_dosen`),
  ADD KEY `id_mk` (`id_mk`);

--
-- Indexes for table `tugas`
--
ALTER TABLE `tugas`
  ADD PRIMARY KEY (`id_tugas`),
  ADD KEY `id_mk` (`id_mk`),
  ADD KEY `id_dosen` (`id_dosen`);

--
-- Indexes for table `tugas_mahasiswa`
--
ALTER TABLE `tugas_mahasiswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_tugas` (`id_tugas`,`id_mahasiswa`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`);

--
-- Indexes for table `tugas_pribadi`
--
ALTER TABLE `tugas_pribadi`
  ADD PRIMARY KEY (`id_tugas_pribadi`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_mk` (`id_mk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `id_mk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dosen_mk`
--
ALTER TABLE `dosen_mk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tugas`
--
ALTER TABLE `tugas`
  MODIFY `id_tugas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tugas_mahasiswa`
--
ALTER TABLE `tugas_mahasiswa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tugas_pribadi`
--
ALTER TABLE `tugas_pribadi`
  MODIFY `id_tugas_pribadi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `fk_mahasiswa_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `fk_dosen_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `dosen_mk`
--
ALTER TABLE `dosen_mk`
  ADD CONSTRAINT `dosen_mk_ibfk_1` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE,
  ADD CONSTRAINT `dosen_mk_ibfk_2` FOREIGN KEY (`id_mk`) REFERENCES `mata_kuliah` (`id_mk`) ON DELETE CASCADE;

--
-- Constraints for table `tugas`
--
ALTER TABLE `tugas`
  ADD CONSTRAINT `tugas_ibfk_1` FOREIGN KEY (`id_mk`) REFERENCES `mata_kuliah` (`id_mk`),
  ADD CONSTRAINT `tugas_ibfk_2` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`);

--
-- Constraints for table `tugas_mahasiswa`
--
ALTER TABLE `tugas_mahasiswa`
  ADD CONSTRAINT `tugas_mahasiswa_ibfk_1` FOREIGN KEY (`id_tugas`) REFERENCES `tugas` (`id_tugas`) ON DELETE CASCADE,
  ADD CONSTRAINT `tugas_mahasiswa_ibfk_2` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE;

--
-- Constraints for table `tugas_pribadi`
--
ALTER TABLE `tugas_pribadi`
  ADD CONSTRAINT `fk_tugas_pribadi_mahasiswa` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tugas_pribadi_mk` FOREIGN KEY (`id_mk`) REFERENCES `mata_kuliah` (`id_mk`) ON DELETE CASCADE;

COMMIT;

-- --------------------------------------------------------
-- QUERY SELECT UNTUK DASHBOARD
-- --------------------------------------------------------

-- 1. QUERY DASHBOARD MAHASISWA
-- Mengambil tugas perkuliahan dosen yang relevan dengan mahasiswa tersebut (berdasarkan semester mata kuliah & penugasan)
-- digabungkan dengan tugas pribadi/mandiri milik mahasiswa yang sedang login.
-- Ganti '?' dengan id_mahasiswa mahasiswa yang sedang login (contoh: id_mahasiswa = 1).
--
-- SELECT 
--     t.id_tugas AS id, 
--     'PERKULIAHAN' AS tipe, 
--     t.judul, 
--     t.deskripsi, 
--     t.deadline, 
--     t.tanggal_dibuat, 
--     tm.status, 
--     tm.tanggal_selesai, 
--     mk.nama_mk, 
--     mk.kode_mk
-- FROM tugas_mahasiswa tm
-- JOIN tugas t ON tm.id_tugas = t.id_tugas
-- JOIN mata_kuliah mk ON t.id_mk = mk.id_mk
-- WHERE tm.id_mahasiswa = ?
-- 
-- UNION ALL
-- 
-- SELECT 
--     tp.id_tugas_pribadi AS id, 
--     'PRIBADI' AS tipe, 
--     tp.judul, 
--     tp.deskripsi, 
--     tp.deadline, 
--     tp.tanggal_dibuat, 
--     tp.status, 
--     NULL AS tanggal_selesai, 
--     mk.nama_mk, 
--     mk.kode_mk
-- FROM tugas_pribadi tp
-- JOIN mata_kuliah mk ON tp.id_mk = mk.id_mk
-- WHERE tp.id_mahasiswa = ?
-- 
-- ORDER BY deadline ASC;


-- 2. QUERY DASHBOARD DOSEN
-- Mengambil hanya tugas perkuliahan dari mata kuliah yang diampu oleh dosen yang sedang login.
-- Ganti '?' dengan id_dosen dosen yang sedang login (contoh: id_dosen = 1).
--
-- SELECT 
--     t.id_tugas, 
--     t.judul, 
--     t.deskripsi, 
--     t.deadline, 
--     t.tanggal_dibuat, 
--     t.id_mk, 
--     mk.nama_mk, 
--     mk.kode_mk
-- FROM tugas t
-- JOIN mata_kuliah mk ON t.id_mk = mk.id_mk
-- JOIN dosen_mk dmk ON t.id_mk = dmk.id_mk
-- WHERE dmk.id_dosen = ?
-- ORDER BY t.tanggal_dibuat DESC;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

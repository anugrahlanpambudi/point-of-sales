-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 02 Des 2025 pada 03.01
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_point_of_sales_2025`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(35) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `category_name`, `created_at`, `updated_at`) VALUES
(6, 'Food', '2025-10-17 07:38:56', '2025-10-17 07:38:56'),
(14, 'Drink', '2025-10-23 04:06:08', '2025-10-23 04:06:08'),
(15, 'Snacks', '2025-10-27 04:16:18', '2025-10-27 04:16:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_code` varchar(25) NOT NULL,
  `order_date` datetime NOT NULL,
  `order_amount` decimal(10,2) DEFAULT NULL,
  `order_change` decimal(10,2) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL DEFAULT 0,
  `order_subtotal` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`id`, `order_code`, `order_date`, `order_amount`, `order_change`, `order_status`, `order_subtotal`, `created_at`, `updated_at`) VALUES
(40, 'ODR-20251028134850', '2025-10-28 13:48:50', 93500.00, 0.00, 1, 0, '2025-10-28 06:48:50', '2025-10-28 06:48:50'),
(41, 'ODR-20251028140240', '2025-10-28 14:02:40', 115500.00, 0.00, 1, 0, '2025-10-28 07:02:40', '2025-10-28 07:02:40'),
(42, 'ODR-20251028151213', '2025-10-28 15:12:13', 38500.00, NULL, 1, 35000, '2025-10-28 08:12:13', '2025-10-28 08:12:13'),
(43, 'ODR-20251029083835', '2025-10-29 08:38:35', 38500.00, NULL, 1, 35000, '2025-10-29 01:38:35', '2025-10-29 01:38:35'),
(44, 'ORD-291020250044', '2025-10-29 08:44:48', 38500.00, NULL, 1, 35000, '2025-10-29 01:44:48', '2025-10-29 01:44:48'),
(45, 'ORD-291020250045', '0000-00-00 00:00:00', 38500.00, NULL, 1, 0, '2025-10-29 02:17:54', '2025-10-29 02:17:54'),
(46, 'ORD-291020250046', '2025-10-29 09:22:47', 38500.00, NULL, 1, 0, '2025-10-29 02:22:47', '2025-10-29 02:22:47'),
(47, 'ORD-291020250047', '2025-10-29 09:25:54', 38500.00, NULL, 1, 35000, '2025-10-29 02:25:54', '2025-10-29 02:25:54'),
(48, 'ORD-291020250047', '2025-10-29 09:40:13', 115500.00, NULL, 1, 105000, '2025-10-29 02:40:13', '2025-10-29 02:40:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(3) NOT NULL,
  `order_price` decimal(10,2) NOT NULL,
  `order_subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `qty`, `order_price`, `order_subtotal`) VALUES
(23, 40, 0, 1, 50000.00, 50000.00),
(24, 40, 0, 1, 35000.00, 35000.00),
(25, 41, 0, 1, 40000.00, 40000.00),
(26, 41, 0, 1, 50000.00, 50000.00),
(27, 41, 0, 1, 15000.00, 15000.00),
(28, 42, 7, 1, 35000.00, 35000.00),
(29, 43, 7, 1, 35000.00, 35000.00),
(30, 44, 7, 1, 35000.00, 35000.00),
(31, 45, 7, 1, 35000.00, 35000.00),
(32, 46, 7, 1, 35000.00, 35000.00),
(33, 47, 7, 1, 35000.00, 35000.00),
(34, 48, 7, 3, 35000.00, 105000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_name` varchar(35) DEFAULT NULL,
  `product_photo` varchar(255) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  `product_description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_photo`, `product_price`, `product_description`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 6, 'sandwich', 'assets/uploads1761203453-pexels-rajesh-tp-749235-1603898.jpg', 40000.00, 'hehehe\r\n', NULL, '2025-10-20 06:16:22', '2025-10-20 06:16:22'),
(6, 6, 'hamburger', 'assets/uploads/1761203287-pexels-robinstickel-70497.jpg', 50000.00, 'nice hamburger', NULL, '2025-10-23 07:08:07', '2025-10-23 07:08:07'),
(7, 6, 'sushi', 'assets/uploads1761204141-pexels-frans-van-heerden-201846-670705.jpg', 35000.00, 'sushi', NULL, '2025-10-23 07:12:58', '2025-10-23 07:12:58'),
(8, 14, 'tea ', 'assets/uploads/1761204551-pexels-bluerhinomedia-2789328.jpg', 15000.00, 'ice tea', NULL, '2025-10-23 07:29:11', '2025-10-23 07:29:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', '2025-10-16 02:38:57', '2025-10-16 02:38:57'),
(2, 'Admin', '2025-10-16 02:38:57', '2025-10-16 02:38:57'),
(3, 'operator', '2025-10-16 02:38:57', '2025-10-16 02:38:57');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `role_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`, `role_id`, `deleted_at`) VALUES
(1, 'Alan', 'alan@gmail.com', '3a44f52a6b79964df9e4a117856a8ff635ff9d36', '2025-10-16 01:59:28', '2025-10-21 04:11:32', 1, NULL),
(3, 'enrio', 'enrio@gmail.com', 'rio123', '2025-10-16 02:10:40', '2025-10-16 07:33:21', 2, NULL),
(4, 'reza', 'reza@gmail.com', '123455433', '2025-10-16 02:10:40', '2025-10-17 04:02:23', 3, NULL),
(9, 'Ardian', 'ardian@gmail.com', '12324678', '2025-10-16 05:25:49', '2025-10-16 05:25:49', 2, NULL),
(10, 'Sandy', 'sandy@gmail.com', '12344678', '2025-10-16 05:44:08', '2025-10-17 04:07:31', 3, NULL),
(11, 'Soleh', 'soleh@gmail.com', 'soleh123', '2025-10-16 07:00:34', '2025-10-20 02:12:40', 3, NULL),
(13, 'aaaa', 'ersaistary31@gmail.com', '1234', '2025-10-20 01:52:15', '2025-10-20 01:59:25', NULL, '2025-10-20 08:59:25'),
(14, 'aaaa', 'ersaistary31@gmail.com', '1234', '2025-10-20 01:56:31', '2025-10-20 01:59:23', NULL, '2025-10-20 08:59:23'),
(15, 'fafasasf', 'ersaistary31@gmail.com', '1234455', '2025-10-20 01:56:45', '2025-10-20 01:59:17', NULL, '2025-10-20 08:59:17'),
(16, 'aftafgasdgf', 'ersaistary31@gmail.com', '123456', '2025-10-20 01:59:31', '2025-10-20 02:07:45', NULL, '2025-10-20 09:07:45'),
(17, 'nisa', 'nisa@gmail.com', 'eb6933edbd40d2e1bdaf2fd572c4eb3a67c48cec', '2025-10-21 03:59:37', '2025-10-21 03:59:37', NULL, NULL),
(18, 'Anugrah Lan Pambudi', 'alan@gmail.com', 'd582f06649b7bb375a5ef3ca8f95c84d4dbec45e', '2025-11-03 04:15:06', '2025-11-03 04:15:06', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_id_to_order` (`order_id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT untuk tabel `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_order_id_to_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

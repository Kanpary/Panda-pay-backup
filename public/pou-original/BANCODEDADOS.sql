-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 18/05/2026 às 21:53
-- Versão do servidor: 11.8.6-MariaDB-log
-- Versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u311589817_redstjhr`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_user_id` char(36) NOT NULL,
  `action` varchar(120) NOT NULL,
  `target_user_id` char(36) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `ip_address` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `admin_logs`
--

INSERT INTO `admin_logs` (`id`, `admin_user_id`, `action`, `target_user_id`, `metadata`, `ip_address`, `created_at`) VALUES
(1, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 17:42:48'),
(2, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 17:42:50'),
(3, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 17:42:52'),
(4, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.2', '2026-05-04 17:43:17'),
(5, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:11:57'),
(6, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:07'),
(7, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:19'),
(8, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:12:21'),
(9, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:12:22'),
(10, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:24'),
(11, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:25'),
(12, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:25'),
(13, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:26'),
(14, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:28'),
(15, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:29'),
(16, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:12:39'),
(17, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:15:01'),
(18, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:15:02'),
(19, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:15:09'),
(20, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:15:13'),
(21, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:15:15'),
(22, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:15:22'),
(23, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:15:25'),
(24, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:15:30'),
(25, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:15:38'),
(26, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:15:52'),
(27, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:16:01'),
(28, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:16:03'),
(29, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:16:04'),
(30, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:05'),
(31, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:06'),
(32, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:06'),
(33, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:07'),
(34, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:09'),
(35, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:10'),
(36, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.2', '2026-05-04 19:16:12'),
(37, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:12'),
(38, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:16:17'),
(39, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:20:03'),
(40, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:20:03'),
(41, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:20:36'),
(42, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:20:47'),
(43, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.2', '2026-05-04 19:20:53'),
(44, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:20:53'),
(45, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:21:17'),
(46, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:21:18'),
(47, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:21:21'),
(48, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:21:27'),
(49, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:21:35'),
(50, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:21:36'),
(51, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:21:38'),
(52, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:21:40'),
(53, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:21:41'),
(54, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:21:44'),
(55, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.wallet.adjust', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"wallet_type\":\"player\",\"operation\":\"credit\",\"amount\":100,\"reason\":\"deposito\",\"balance_before\":0,\"balance_after\":100}', '201.222.31.2', '2026-05-04 19:21:57'),
(56, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.2', '2026-05-04 19:21:57'),
(57, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.2', '2026-05-04 19:21:57'),
(58, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:24:24'),
(59, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:24:35'),
(60, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:24:35'),
(61, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.2', '2026-05-04 19:31:53'),
(62, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:31:53'),
(63, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:31:53'),
(64, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:31:58'),
(65, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:31:58'),
(66, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.2', '2026-05-04 19:32:52'),
(67, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:32:52'),
(68, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:32:52'),
(69, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.2', '2026-05-04 19:32:55'),
(70, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.create', NULL, '{\"banner_id\":\"1b3d0b0b-c9bf-44a7-90f2-a729d77f3a36\"}', '201.222.31.2', '2026-05-04 19:33:10'),
(71, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.2', '2026-05-04 19:33:10'),
(72, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:33:25'),
(73, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:33:25'),
(74, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.2', '2026-05-04 19:34:17'),
(75, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:34:17'),
(76, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:34:17'),
(77, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:37:25'),
(78, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:37:31'),
(79, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:37:34'),
(80, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:37:36'),
(81, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.2', '2026-05-04 19:37:36'),
(82, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.2', '2026-05-04 19:47:06'),
(83, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:47:09'),
(84, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.2', '2026-05-04 19:47:12'),
(85, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:47:14'),
(86, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 19:47:14'),
(87, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.2', '2026-05-04 20:12:40'),
(88, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 20:12:40'),
(89, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 20:12:40'),
(90, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.2', '2026-05-04 20:12:53'),
(91, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 20:12:53'),
(92, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.2', '2026-05-04 20:12:53'),
(93, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 01:57:54'),
(94, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 01:57:56'),
(95, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 01:57:56'),
(96, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 01:57:57'),
(97, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-15 01:57:58'),
(98, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:57:58'),
(99, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:57:58'),
(100, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:58:04'),
(101, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:58:04'),
(102, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:58:05'),
(103, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:58:06'),
(104, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 01:58:06'),
(105, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 01:58:06'),
(106, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:00:42'),
(107, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-15 02:00:45'),
(108, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:00:47'),
(109, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:00:47'),
(110, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.86', '2026-05-15 02:00:52'),
(111, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.update', NULL, '{\"updated_fields\":[\"game_title\",\"game_subtitle\",\"login_banner_url\",\"register_banner_url\"]}', '201.222.31.86', '2026-05-15 02:00:52'),
(112, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:00:52'),
(113, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:00:52'),
(114, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:05:33'),
(115, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 02:05:35'),
(116, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-15 02:05:36'),
(117, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:05:38'),
(118, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 02:05:44'),
(119, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 02:05:45'),
(120, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:05:49'),
(121, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 02:05:50'),
(122, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 02:05:51'),
(123, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 02:05:52'),
(124, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-15 02:05:53'),
(125, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:05:57'),
(126, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:07:41'),
(127, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:07:46'),
(128, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:20:39'),
(129, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:21:09'),
(130, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:21:22'),
(131, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:21:22'),
(132, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"token\",\"secret\",\"webhook_secret_validation\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\",\"api_base_url\"],\"is_active\":0}', '201.222.31.86', '2026-05-15 02:21:43'),
(133, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:21:43'),
(134, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:21:43'),
(135, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"webhook_secret_validation\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\",\"api_base_url\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 02:23:13'),
(136, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:23:13'),
(137, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:23:13'),
(138, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:23:20'),
(139, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:23:20'),
(140, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"token\",\"secret\",\"webhook_secret_validation\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\",\"api_base_url\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 02:23:29'),
(141, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:23:29'),
(142, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:23:29'),
(143, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:25:38'),
(144, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:25:38'),
(145, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:26:21'),
(146, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:26:21'),
(147, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:26:25'),
(148, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:26:25'),
(149, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:26:34'),
(150, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:26:34'),
(151, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:26:59'),
(152, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:27:00'),
(153, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:29:14'),
(154, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:29:15'),
(155, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"gain_multiplier\",\"difficulty_reduction\",\"coin_return\",\"jump_multiplier\",\"influencer_coin_percentage\",\"influencer_calculation_mode\"]}', '201.222.31.86', '2026-05-15 02:29:23'),
(156, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:29:23'),
(157, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:32:40'),
(158, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:42'),
(159, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:42'),
(160, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:45'),
(161, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:45'),
(162, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:45'),
(163, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:45'),
(164, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:56'),
(165, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:56'),
(166, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:58'),
(167, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:58'),
(168, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:58'),
(169, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:58'),
(170, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:59'),
(171, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:59'),
(172, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:59'),
(173, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:59'),
(174, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:32:59'),
(175, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:32:59'),
(176, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:00'),
(177, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:00'),
(178, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:02'),
(179, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:02'),
(180, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:02'),
(181, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:02'),
(182, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:03'),
(183, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:03'),
(184, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:03'),
(185, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:03'),
(186, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:33:16'),
(187, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:22'),
(188, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:36'),
(189, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:52'),
(190, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:52'),
(191, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:56'),
(192, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:56'),
(193, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:57'),
(194, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:57'),
(195, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:57'),
(196, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:57'),
(197, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:33:57'),
(198, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:33:57'),
(199, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:52'),
(200, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:52'),
(201, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:53'),
(202, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:53'),
(203, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:53'),
(204, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:53'),
(205, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:53'),
(206, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:53'),
(207, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:53'),
(208, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:53'),
(209, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:54'),
(210, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:54'),
(211, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:54'),
(212, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:54'),
(213, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:37:54'),
(214, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:37:54'),
(215, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 02:39:01'),
(216, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:39:02'),
(217, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:39:04'),
(218, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:39:04'),
(219, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 02:39:08'),
(220, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.webhook_logs.list', NULL, '{\"provider\":null,\"type\":null,\"status\":null,\"limit\":50}', '201.222.31.86', '2026-05-15 02:39:08'),
(221, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:06:22'),
(222, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:14:00'),
(223, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:14:01'),
(224, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"api_base_url\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\",\"token\",\"secret\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 04:14:39'),
(225, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"api_base_url\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 04:14:45'),
(226, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:14:47'),
(227, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:14:53'),
(228, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:15:46'),
(229, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:15:47'),
(230, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:17:26'),
(231, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:17:27'),
(232, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:17:29'),
(233, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:18:05'),
(234, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:18:06'),
(235, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:18:07'),
(236, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:22:03'),
(237, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:22:04'),
(238, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:22:49'),
(239, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:22:50'),
(240, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"token\",\"secret\",\"api_base_url\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 04:24:24'),
(241, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"token\",\"secret\",\"api_base_url\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 04:24:38'),
(242, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 04:24:38'),
(243, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:39:47'),
(244, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 04:49:56'),
(245, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 05:11:48'),
(246, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 05:11:50'),
(247, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 05:13:57'),
(248, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 05:13:59'),
(249, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 05:14:00'),
(250, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"token\",\"secret\",\"api_base_url\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 05:15:23'),
(251, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 05:18:02'),
(252, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 05:26:18'),
(253, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 05:26:21'),
(254, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 05:27:00'),
(255, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 05:27:02'),
(256, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 05:27:02'),
(257, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.update', NULL, '{\"updated_fields\":[\"api_base_url\",\"deposit_callback_url\",\"withdrawal_callback_url\",\"is_active\",\"token\",\"secret\"],\"is_active\":1}', '201.222.31.86', '2026-05-15 05:27:28'),
(258, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 18:31:44'),
(259, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 18:31:46'),
(260, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-15 18:31:48'),
(261, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 18:42:02'),
(262, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 18:42:04'),
(263, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.update', NULL, '{\"updated_fields\":[\"min_deposit\",\"minimum_withdrawal_amount\",\"deposit_bonus_enabled\",\"deposit_bonus_percent\",\"deposit_bonus_min_amount\",\"min_withdrawal_player\",\"min_withdrawal_affiliate\"]}', '201.222.31.86', '2026-05-15 18:42:08'),
(264, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 18:42:08'),
(265, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 18:43:24'),
(266, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 18:43:25'),
(267, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 18:43:26'),
(268, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 18:43:31'),
(269, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 18:43:53'),
(270, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 18:44:54'),
(271, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 18:44:58'),
(272, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 18:45:04'),
(273, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 19:00:04'),
(274, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 19:00:06'),
(275, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 19:13:55'),
(276, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 19:13:57'),
(277, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 19:14:00'),
(278, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.approve', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"deposit_id\":\"3d83546b-7f0a-47c8-972d-f43e24bc6ed9\",\"amount\":5,\"bonus_amount\":0,\"total_credited\":5,\"commission_result\":{\"status\":\"ignored\",\"reason\":\"no_referrer\"}}', '201.222.31.86', '2026-05-15 19:14:09'),
(279, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 19:14:09'),
(280, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.approve', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"deposit_id\":\"8113e923-b316-45fb-a00f-96199cc73ba5\",\"amount\":5,\"bonus_amount\":0,\"total_credited\":5,\"commission_result\":{\"status\":\"ignored\",\"reason\":\"no_referrer\"}}', '201.222.31.86', '2026-05-15 19:14:12'),
(281, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 19:14:12'),
(282, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 19:44:45'),
(283, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 19:44:46'),
(284, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 20:39:10'),
(285, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 20:39:11'),
(286, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.update', NULL, '{\"updated_fields\":[\"min_deposit\",\"minimum_withdrawal_amount\",\"deposit_bonus_enabled\",\"deposit_bonus_percent\",\"deposit_bonus_min_amount\",\"min_withdrawal_player\",\"min_withdrawal_affiliate\"]}', '201.222.31.86', '2026-05-15 20:39:15'),
(287, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 20:39:15'),
(288, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 20:40:06'),
(289, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.approve', NULL, '{\"withdrawal_id\":\"4b62b76c-9266-4843-9847-8f5ff0006095\",\"amount\":5,\"wallet_type\":\"player\"}', '201.222.31.86', '2026-05-15 20:40:11'),
(290, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 20:40:11'),
(291, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.process', NULL, '{\"withdrawal_id\":\"4b62b76c-9266-4843-9847-8f5ff0006095\",\"status\":\"approved\",\"http_status\":401,\"transaction_id\":null}', '201.222.31.86', '2026-05-15 20:40:21'),
(292, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 20:40:21'),
(293, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.process', NULL, '{\"withdrawal_id\":\"4b62b76c-9266-4843-9847-8f5ff0006095\",\"status\":\"approved\",\"http_status\":429,\"transaction_id\":null}', '201.222.31.86', '2026-05-15 20:40:32'),
(294, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 20:40:32'),
(295, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 20:49:03'),
(296, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 20:50:26'),
(297, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 21:36:05'),
(298, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 21:36:05'),
(299, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 21:36:46'),
(300, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 21:36:48'),
(301, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 21:36:54'),
(302, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 21:37:01'),
(303, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-15 21:37:31'),
(304, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 21:37:33'),
(305, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-15 21:37:36'),
(306, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-15 21:37:41'),
(307, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 21:37:41'),
(308, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-15 21:37:41'),
(309, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 21:39:34'),
(310, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-15 22:27:47'),
(311, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-15 22:43:25');
INSERT INTO `admin_logs` (`id`, `admin_user_id`, `action`, `target_user_id`, `metadata`, `ip_address`, `created_at`) VALUES
(312, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 23:01:00'),
(313, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:02'),
(314, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:03'),
(315, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:04'),
(316, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-15 23:01:13'),
(317, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:43'),
(318, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:43'),
(319, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:49'),
(320, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:51'),
(321, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:53'),
(322, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:53'),
(323, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:01:55'),
(324, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:06'),
(325, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:06'),
(326, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:09'),
(327, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:09'),
(328, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:10'),
(329, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:10'),
(330, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:12'),
(331, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 23:02:20'),
(332, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 23:02:22'),
(333, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 23:02:24'),
(334, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-15 23:02:26'),
(335, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:27'),
(336, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:29'),
(337, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:02:29'),
(338, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 23:20:15'),
(339, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:20:21'),
(340, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:20:22'),
(341, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-15 23:20:23'),
(342, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-15 23:20:31'),
(343, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-15 23:21:31'),
(344, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-15\",\"to\":\"2026-05-15\"}', '201.222.31.86', '2026-05-15 23:26:44'),
(345, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 23:26:47'),
(346, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-15 23:26:49'),
(347, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-15 23:26:53'),
(348, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-15 23:26:53'),
(349, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-15 23:26:53'),
(350, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:01:00'),
(351, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:01:03'),
(352, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:01:03'),
(353, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.update', NULL, '{\"updated_fields\":[\"game_title\",\"game_subtitle\",\"login_banner_url\",\"register_banner_url\"]}', '201.222.31.86', '2026-05-16 00:04:19'),
(354, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.86', '2026-05-16 00:04:19'),
(355, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:04:19'),
(356, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:04:19'),
(357, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.86', '2026-05-16 00:04:38'),
(358, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.update', NULL, '{\"updated_fields\":[\"game_title\",\"game_subtitle\",\"login_banner_url\",\"register_banner_url\"]}', '201.222.31.86', '2026-05-16 00:04:38'),
(359, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:04:38'),
(360, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:04:38'),
(361, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 00:15:41'),
(362, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 00:15:44'),
(363, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-16 00:16:02'),
(364, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-16 00:16:05'),
(365, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 00:16:05'),
(366, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-16 00:16:05'),
(367, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 00:16:48'),
(368, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 00:16:53'),
(369, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:17:08'),
(370, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 00:17:09'),
(371, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:17:10'),
(372, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:17:10'),
(373, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:17:10'),
(374, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:17:12'),
(375, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:17:17'),
(376, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:17:22'),
(377, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:17:25'),
(378, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:17:27'),
(379, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 00:17:27'),
(380, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 00:18:18'),
(381, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:18:19'),
(382, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:18:20'),
(383, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:21'),
(384, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:21'),
(385, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:21'),
(386, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:25'),
(387, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:28'),
(388, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:30'),
(389, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.gateway.akadpay.config.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:31'),
(390, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:33'),
(391, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:34'),
(392, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:41'),
(393, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:42'),
(394, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:43'),
(395, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:43'),
(396, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:47'),
(397, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:48'),
(398, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:48'),
(399, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:18:49'),
(400, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:18:50'),
(401, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 00:18:50'),
(402, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 00:18:51'),
(403, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:52'),
(404, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:53'),
(405, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:18:53'),
(406, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_assets.upload', NULL, '{\"filename\":\"swing-street-simon-folwar-main-version-33786-01-04_20260516002028_977c5cac.mp3\",\"mime\":\"audio\\/mpeg\",\"size\":2623771}', '201.222.31.86', '2026-05-16 00:20:28'),
(407, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.update', NULL, '{\"updated_fields\":[\"game_title\",\"game_subtitle\",\"login_banner_url\",\"register_banner_url\"]}', '201.222.31.86', '2026-05-16 00:20:32'),
(408, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.86', '2026-05-16 00:20:32'),
(409, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:20:32'),
(410, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:20:32'),
(411, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:22:48'),
(412, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.update', NULL, '{\"updated_fields\":[\"influencer_jump_multiplier_v2\",\"influencer_fixed_coin_value_v2\",\"influencer_double_coins_v2\"]}', '201.222.31.86', '2026-05-16 00:22:57'),
(413, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:47'),
(414, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:49'),
(415, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:49'),
(416, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:50'),
(417, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:50'),
(418, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:56'),
(419, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:52:56'),
(420, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_assets.upload', NULL, '{\"filename\":\"swing-street-simon-folwar-main-version-33786-01-04_20260516005301_330c36c6.mp3\",\"mime\":\"audio\\/mpeg\",\"size\":2623771}', '201.222.31.86', '2026-05-16 00:53:01'),
(421, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.86', '2026-05-16 00:53:02'),
(422, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.update', NULL, '{\"updated_fields\":[\"game_title\",\"game_subtitle\",\"login_banner_url\",\"register_banner_url\"]}', '201.222.31.86', '2026-05-16 00:53:02'),
(423, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:53:02'),
(424, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:53:02'),
(425, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.update', NULL, '{\"updated_fields\":[\"character_name\",\"character_image_url\",\"bg_music_url\",\"bg_music_enabled\",\"jump_sound_url\",\"land_sound_url\",\"spring_sound_url\",\"coin_sound_url\"]}', '201.222.31.86', '2026-05-16 00:53:16'),
(426, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.update', NULL, '{\"updated_fields\":[\"game_title\",\"game_subtitle\",\"login_banner_url\",\"register_banner_url\"]}', '201.222.31.86', '2026-05-16 00:53:16'),
(427, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:53:16'),
(428, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 00:53:16'),
(429, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 17:26:55'),
(430, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:01'),
(431, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:01'),
(432, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:07'),
(433, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:07'),
(434, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:12'),
(435, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:13'),
(436, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 17:27:44'),
(437, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:27:44'),
(438, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 17:28:03'),
(439, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-16 17:28:05'),
(440, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:05'),
(441, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:05'),
(442, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:06'),
(443, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:08'),
(444, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.update', NULL, '{\"updated_fields\":[\"min_deposit\",\"minimum_withdrawal_amount\",\"deposit_bonus_enabled\",\"deposit_bonus_percent\",\"deposit_bonus_min_amount\",\"min_withdrawal_player\",\"min_withdrawal_affiliate\"]}', '201.222.31.86', '2026-05-16 17:28:29'),
(445, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:29'),
(446, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:34'),
(447, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:35'),
(448, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 17:28:42'),
(449, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:42'),
(450, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 17:28:52'),
(451, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 17:28:52'),
(452, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 17:52:06'),
(453, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-16 17:52:08'),
(454, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 17:52:43'),
(455, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 21:20:15'),
(456, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 21:20:17'),
(457, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 21:22:28'),
(458, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 21:22:29'),
(459, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 21:24:03'),
(460, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 21:24:06'),
(461, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 21:24:11'),
(462, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 21:44:37'),
(463, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 21:44:41'),
(464, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 21:44:44'),
(465, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 23:20:04'),
(466, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 23:20:06'),
(467, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-16\",\"to\":\"2026-05-16\"}', '201.222.31.86', '2026-05-16 23:20:07'),
(468, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 23:20:17'),
(469, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 23:20:26'),
(470, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', NULL, '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-16 23:20:40'),
(471, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 23:20:40'),
(472, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 23:20:40'),
(473, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:32:41'),
(474, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:32:54'),
(475, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:32:54'),
(476, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:33:01'),
(477, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:33:01'),
(478, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:33:11'),
(479, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:33:11'),
(480, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:43:53'),
(481, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:43:53'),
(482, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:43:56'),
(483, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:43:56'),
(484, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:47:49'),
(485, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:47:49'),
(486, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:49:35'),
(487, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:49:35'),
(488, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:56:54'),
(489, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-16 23:56:59'),
(490, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-16 23:56:59'),
(491, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 23:59:44'),
(492, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 23:59:48'),
(493, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 23:59:49'),
(494, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', NULL, '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-16 23:59:55'),
(495, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-16 23:59:55'),
(496, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-16 23:59:55'),
(497, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:01:35'),
(498, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:01:40'),
(499, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:01:52'),
(500, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 00:01:55'),
(501, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', NULL, '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-17 00:02:36'),
(502, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:02:36'),
(503, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 00:02:36'),
(504, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:09:08'),
(505, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 00:09:12'),
(506, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:09:27'),
(507, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:09:30'),
(508, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-17\",\"to\":\"2026-05-17\"}', '201.222.31.86', '2026-05-17 00:38:13'),
(509, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:38:15'),
(510, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:17'),
(511, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-17 00:38:21'),
(512, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:21'),
(513, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-17 00:38:22'),
(514, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:22'),
(515, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-17 00:38:22'),
(516, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:22'),
(517, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-17 00:38:22'),
(518, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:22'),
(519, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.update', NULL, '{\"updated_fields\":[\"default_commission_percent\",\"default_commission_percent_level2\",\"first_deposit_only\",\"min_deposit_for_commission\",\"affiliate_skip_interval\",\"is_active\"]}', '201.222.31.86', '2026-05-17 00:38:22'),
(520, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:22'),
(521, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:38:24'),
(522, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:39:39'),
(523, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 00:39:41'),
(524, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.profile.update', NULL, '{\"updated_fields\":[\"full_name\",\"username\",\"phone\",\"cpf\",\"is_influencer\",\"referred_by\",\"comissao_cpa\",\"comissao_cpa_nivel2\",\"custom_commission_percent\",\"custom_game_difficulty\",\"custom_coin_return\",\"custom_game_speed\",\"custom_jump_height\",\"custom_bonus_percent\"]}', '201.222.31.86', '2026-05-17 00:39:45'),
(525, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:39:45'),
(526, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 00:39:45'),
(527, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:41:46'),
(528, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 00:41:48'),
(529, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:46'),
(530, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:47'),
(531, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:49'),
(532, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:49'),
(533, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:50'),
(534, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:58'),
(535, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:58'),
(536, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.banners.list', NULL, NULL, '201.222.31.86', '2026-05-17 00:44:59'),
(537, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-17 00:44:59'),
(538, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.deposits.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-17 00:45:00'),
(539, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 00:45:01'),
(540, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-17\",\"to\":\"2026-05-17\"}', '201.222.31.86', '2026-05-17 00:45:02'),
(541, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-17 01:15:18'),
(542, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-17 02:03:15'),
(543, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 02:03:44'),
(544, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-17 02:03:52'),
(545, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-18\",\"to\":\"2026-05-18\"}', '201.222.31.86', '2026-05-18 21:02:34'),
(546, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:02:39'),
(547, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:44'),
(548, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:45'),
(549, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:48'),
(550, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:48'),
(551, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.withdrawals.list', NULL, '{\"status\":null,\"user_id\":null,\"limit\":200}', '201.222.31.86', '2026-05-18 21:02:49'),
(552, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:50'),
(553, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:50'),
(554, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(555, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(556, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(557, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(558, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(559, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(560, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(561, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:02:52'),
(562, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.stats.view', NULL, '{\"from\":\"2026-04-18\",\"to\":\"2026-05-18\"}', '201.222.31.86', '2026-05-18 21:04:12'),
(563, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.financial_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:04:13'),
(564, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.game_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:04:14'),
(565, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.character_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:04:14'),
(566, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.influencer_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:04:14'),
(567, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.commission_settings.view', NULL, NULL, '201.222.31.86', '2026-05-18 21:04:19'),
(568, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:05:11'),
(569, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:05:12'),
(570, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-18 21:05:45'),
(571, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.wallet.adjust', 'a0126999-6f42-4ffc-93c1-817662bcf900', '{\"wallet_type\":\"affiliate\",\"operation\":\"credit\",\"amount\":100,\"reason\":\"qtoa\",\"balance_before\":0,\"balance_after\":100}', '201.222.31.86', '2026-05-18 21:06:39'),
(572, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:06:39'),
(573, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '201.222.31.86', '2026-05-18 21:06:39'),
(574, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:17'),
(575, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:22'),
(576, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:22'),
(577, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:23'),
(578, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:25'),
(579, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:25'),
(580, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:25'),
(581, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:27'),
(582, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:27'),
(583, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:28'),
(584, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:30'),
(585, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:30'),
(586, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:30'),
(587, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:33'),
(588, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:33'),
(589, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:33'),
(590, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:35'),
(591, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:35'),
(592, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:42'),
(593, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:44'),
(594, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:44'),
(595, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:47'),
(596, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:49'),
(597, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:49'),
(598, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:50'),
(599, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:52'),
(600, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:52'),
(601, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:53'),
(602, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:55'),
(603, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:55'),
(604, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:56'),
(605, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:58'),
(606, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:07:58'),
(607, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:07:59'),
(608, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:01'),
(609, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:01'),
(610, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:03'),
(611, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:05'),
(612, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:05'),
(613, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:07'),
(614, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:09'),
(615, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:09'),
(616, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:10'),
(617, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:11'),
(618, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:11'),
(619, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:12'),
(620, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:14'),
(621, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:15'),
(622, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:16'),
(623, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:17'),
(624, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:17'),
(625, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:18'),
(626, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:21'),
(627, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:21'),
(628, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:25'),
(629, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:27'),
(630, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:27'),
(631, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:28'),
(632, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:30'),
(633, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:30'),
(634, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:32');
INSERT INTO `admin_logs` (`id`, `admin_user_id`, `action`, `target_user_id`, `metadata`, `ip_address`, `created_at`) VALUES
(635, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:34'),
(636, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:34'),
(637, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:36'),
(638, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:39'),
(639, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:39'),
(640, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:40'),
(641, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:43'),
(642, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:43'),
(643, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:44'),
(644, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:46'),
(645, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:46'),
(646, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:50'),
(647, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:53'),
(648, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:53'),
(649, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:54'),
(650, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:56'),
(651, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:08:56'),
(652, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:08:58'),
(653, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:09:00'),
(654, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:09:00'),
(655, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:09:01'),
(656, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:09:03'),
(657, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:09:03'),
(658, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.detail', NULL, NULL, '201.222.31.86', '2026-05-18 21:09:04'),
(659, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.soft_delete', NULL, NULL, '201.222.31.86', '2026-05-18 21:09:07'),
(660, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin.users.list', NULL, '{\"limit\":50}', '201.222.31.86', '2026-05-18 21:09:07');

-- --------------------------------------------------------

--
-- Estrutura para tabela `affiliate_commissions`
--

CREATE TABLE `affiliate_commissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `affiliate_user_id` char(36) NOT NULL,
  `referred_user_id` char(36) NOT NULL,
  `source_type` enum('deposit','game_loss','manual') NOT NULL DEFAULT 'manual',
  `source_id` varchar(80) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` enum('pending','available','paid','canceled') NOT NULL DEFAULT 'available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `akadpay_config`
--

CREATE TABLE `akadpay_config` (
  `id` char(36) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `api_base_url` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `api_secret` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `deposit_callback_url` varchar(500) DEFAULT NULL,
  `withdrawal_callback_url` varchar(500) DEFAULT NULL,
  `webhook_secret_validation` tinyint(1) NOT NULL DEFAULT 1,
  `webhook_secret` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `akadpay_config`
--

INSERT INTO `akadpay_config` (`id`, `is_enabled`, `is_active`, `api_base_url`, `api_key`, `api_secret`, `token`, `secret`, `client_id`, `client_secret`, `deposit_callback_url`, `withdrawal_callback_url`, `webhook_secret_validation`, `webhook_secret`, `created_at`, `updated_at`) VALUES
('1d60f0a8-47e0-11f1-8ebe-45693cf4117a', 0, 1, 'https://painel.akadpay.com.br/api', NULL, NULL, 'ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78', 'cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c', NULL, NULL, 'https://pou-pou.fun/api/payments/webhook/akadpay', 'https://pou-pou.fun/api/payments/webhook/akadpay', 1, NULL, '2026-05-04 17:38:51', '2026-05-15 05:27:28');

-- --------------------------------------------------------

--
-- Estrutura para tabela `onixpay_config`
--

CREATE TABLE `onixpay_config` (
  `id` char(36) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `api_base_url` varchar(255) DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `deposit_callback_url` varchar(500) DEFAULT NULL,
  `withdrawal_callback_url` varchar(500) DEFAULT NULL,
  `webhook_secret` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_sessions`
--

CREATE TABLE `auth_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `user_id` char(36) NOT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp(),
  `revoked_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `auth_sessions`
--

INSERT INTO `auth_sessions` (`id`, `session_id`, `user_id`, `ip_address`, `user_agent`, `created_at`, `last_activity`, `revoked_at`) VALUES
(1, 'l1ai7p61oh5t185jm5sib3aust', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 17:39:45', '2026-05-04 17:43:17', NULL),
(2, 'a83hkam1m1gb81aat6h6hara6n', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 19:11:35', '2026-05-04 19:12:39', NULL),
(3, 'u9deifch9db9v5ghpdjni14lpe', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 19:14:59', '2026-05-04 19:21:57', '2026-05-04 19:22:02'),
(4, 'rnuub2srv5dnalta65il8rbr4n', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 19:22:05', '2026-05-04 19:22:09', NULL),
(5, '9duf0o4afho6gc8h96okf5cvrq', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 19:24:22', '2026-05-04 19:33:10', NULL),
(6, '44njrpvussffr9tam6532h92ne', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 19:33:17', '2026-05-04 20:12:53', NULL),
(7, 'gip33ru7i29md4tsn0rdt96ck0', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 01:57:53', '2026-05-15 01:59:02', NULL),
(8, 'ns5tu7mji16vvmtgqme8l3h4k8', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 01:59:06', '2026-05-15 02:00:52', '2026-05-15 02:00:56'),
(9, '58p7eda5dn41vr5j8rlvaf4opk', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:02:59', '2026-05-15 02:20:34', NULL),
(10, 'r7s903bo7cn919n76569j2vtu0', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:07:39', '2026-05-15 02:07:46', NULL),
(11, '7mdebk8tpb117qr3tu007l8nik', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:20:38', '2026-05-15 02:32:36', NULL),
(12, '2f95irbu68pov71p42o3argt5a', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:21:07', '2026-05-15 02:33:57', NULL),
(13, '67sdsui3l4b7tf6ocdn3sjf9ji', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:26:57', '2026-05-15 02:29:39', NULL),
(14, 'l02erffvk9m3fugjhcclpe1dve', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:32:39', '2026-05-15 02:37:54', NULL),
(15, 'cgsfql3srfs282cdcmkfu6bqi5', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:33:14', '2026-05-15 02:36:19', NULL),
(16, 'v6jmqq1vsh1080sgm5tl63e4ni', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:34', '2026-05-15 02:38:34', NULL),
(17, 'ebd2289ok0t23osja98vohon3p', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:38', '2026-05-15 02:38:38', NULL),
(18, '2nt5ugvrakq2o6k5ravqlcqaa0', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:39', '2026-05-15 02:38:39', NULL),
(19, 'cg4et46ech1ire4rbldfr452vu', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:45', '2026-05-15 02:38:45', NULL),
(20, 'c3nradvl76fsmovpe3j26967dn', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:47', '2026-05-15 02:38:47', NULL),
(21, 'jd238h4cdsckijsan890cjo8oh', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:47', '2026-05-15 02:38:47', NULL),
(22, 'q7a2gubin0ufgs09l07to5fqb3', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:48', '2026-05-15 02:38:48', NULL),
(23, 'i9ee9c84fbo5e562eof8mgd2rj', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:48', '2026-05-15 02:38:48', NULL),
(24, 'clf1vltlo7i2346gdq60quvloa', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:49', '2026-05-15 02:38:49', NULL),
(25, 'r4pjk5qjrrjev80pkq2437p4nn', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:50', '2026-05-15 02:38:50', NULL),
(26, '6p7en34sm24t712ss1e2v8jhae', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:50', '2026-05-15 02:38:50', NULL),
(27, 'qla6rpjspsct98sgbf10kojdus', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 02:38:59', '2026-05-15 03:59:57', NULL),
(28, 'h1g25kqm50ncjr2kuvit1ul6fg', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 03:59:59', '2026-05-15 04:16:02', '2026-05-15 04:18:29'),
(29, 'rpie6ahho0udr4vchj031h11oq', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:13:57', '2026-05-15 04:17:29', NULL),
(30, '0at4uapbfckusljigh2sji6t8q', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:18:01', '2026-05-15 04:18:07', '2026-05-15 04:18:20'),
(31, '7fvbrfcgo70i28fghcraph8n1h', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:18:30', '2026-05-15 04:22:04', NULL),
(32, '0q6lfjvdteijuacennhq43n8il', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:22:47', '2026-05-15 04:24:53', NULL),
(33, 'k298hoj5uiegm1e72ovmoish3m', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:25:04', '2026-05-15 04:25:09', NULL),
(34, 'f68hn2e0hidscdgmog8t10a6f8', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:39:44', '2026-05-15 04:48:21', NULL),
(35, 'osgbiut90ibek7ne5doaf2g061', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 04:49:54', '2026-05-15 04:49:56', '2026-05-15 05:10:27'),
(36, '1182448e8n3aklfacrl5e14hcb', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 05:10:28', '2026-05-15 05:26:21', NULL),
(37, 'elraf33ein4gl5nfoihqo0bjkv', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 05:13:56', '2026-05-15 05:15:23', '2026-05-15 05:15:26'),
(38, '20in6j3rshps4892oairv66e4m', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 05:15:29', '2026-05-15 05:15:32', NULL),
(39, 'qmjlq7jvqpka3hra7qf05jen7p', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 05:26:53', '2026-05-15 05:27:28', '2026-05-15 05:27:37'),
(40, 'p5alv0bd997hcqttl25llsnh74', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 05:27:43', '2026-05-15 05:27:47', NULL),
(41, 'shnl0j87j8is4jor49dv66up0g', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 05:28:33', '2026-05-15 05:28:39', NULL),
(42, 'c255bnk3n2fjjosnsvsjpajm0a', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 18:31:13', '2026-05-15 18:31:59', NULL),
(43, 'b8250prfhclb8p2ujv57i8qh6e', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 18:32:08', '2026-05-15 18:42:08', '2026-05-15 18:42:12'),
(44, 'r1hd8v5t7itmrlkhp4cjjshill', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 18:42:21', '2026-05-15 18:45:04', '2026-05-15 18:58:54'),
(45, '6pehk2nnmda8rqvjbuljjiajl7', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 18:59:00', '2026-05-15 19:00:06', '2026-05-15 19:13:00'),
(46, '9k6c448d6ku93chrjbk6nfuba1', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 19:13:06', '2026-05-15 19:14:12', '2026-05-15 19:14:14'),
(47, 'skm1am5i9dc151rustmqbkhd47', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 19:14:20', '2026-05-15 19:44:46', NULL),
(49, 'urvm2mcjmj6gdrq491g0u662qr', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 20:39:09', '2026-05-15 21:36:05', NULL),
(50, 'eaihhmjjjo8vutbphh1slqhgga', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 21:36:40', '2026-05-15 21:37:48', NULL),
(51, 'i01g3svop2tobb2kgvfv7u70n1', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 21:37:52', '2026-05-15 23:01:18', NULL),
(52, '1d2kkcoiqiaebbmln90ae4l9gq', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 21:39:17', '2026-05-15 21:39:31', NULL),
(53, 'hrcgl8fpg4i3ps96mb30b2b9o0', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 23:01:21', '2026-05-15 23:03:49', NULL),
(54, 'lc0754qg1qc1qa2hpd7hs7eplo', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 23:20:09', '2026-05-15 23:20:41', NULL),
(55, '864shp5p6ubjkkorfdttg4q7dm', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 23:20:46', '2026-05-15 23:27:02', NULL),
(56, '9ff5k04pq6vbs8mo73g4ro8vlq', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-15 23:27:04', '2026-05-16 00:01:15', '2026-05-16 00:01:21'),
(57, 'msd5qo0fm5ag0erqqlhc0q285j', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 00:01:26', '2026-05-16 00:17:33', NULL),
(58, '9kcutann7k715ma5r4hpbompmd', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 00:15:30', '2026-05-16 00:55:34', NULL),
(59, 'agcdg3spfc3ld0vcka9hdedt8j', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 00:17:40', '2026-05-16 00:53:32', NULL),
(60, 'd41pa2nm9rpkv9q64n5kv4au5d', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 00:54:29', '2026-05-16 00:54:35', NULL),
(61, '86amgkvfl1tr9pd0v3s3enaf20', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 00:55:55', '2026-05-16 01:14:03', NULL),
(62, 'mvfvh89v8ke1e3q8h0lj0f4nqg', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 00:56:19', '2026-05-16 01:26:51', NULL),
(63, 'r7f3531dt160h3ub8cfmq7pqnb', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 01:27:15', '2026-05-16 01:28:03', NULL),
(64, 'f027sl76sf3bg19kcd4to7u27q', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 01:28:31', '2026-05-16 01:31:46', NULL),
(65, 's2ga5rg7rcm35542put906e6f4', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 17:26:48', '2026-05-16 17:52:43', NULL),
(70, 'q9b6c37gu1t5o07io7mka8dqtn', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 21:20:14', '2026-05-16 21:20:17', NULL),
(71, '8062fnmqrs3arsa0jvuh41q6vj', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 21:22:27', '2026-05-16 21:44:44', NULL),
(77, 'o1sdqhkmvj73fmk5nvd864s19u', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-16 23:20:02', '2026-05-17 00:37:49', NULL),
(83, '02on42fe19c52qsdkfade3u5g5', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-17 00:37:53', '2026-05-17 02:03:52', NULL),
(98, 'd351jqv2ktksfou4g784g99i8h', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-18 21:02:32', '2026-05-18 21:29:42', NULL),
(99, 'e2qu2ld9sfjm77psm8nj9vnu0i', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-18 21:04:07', '2026-05-18 21:09:07', NULL),
(100, '4e2ft90gd5mnk2kf9aahsuaicq', 'a0126999-6f42-4ffc-93c1-817662bcf900', '201.222.31.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-18 21:29:47', '2026-05-18 21:49:30', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `banners`
--

CREATE TABLE `banners` (
  `id` char(36) NOT NULL,
  `title` varchar(120) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `image_url` varchar(500) NOT NULL,
  `placement` enum('landing','login','register','dashboard','global') NOT NULL DEFAULT 'global',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `banners`
--

INSERT INTO `banners` (`id`, `title`, `subtitle`, `image_url`, `placement`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES
('1b3d0b0b-c9bf-44a7-90f2-a729d77f3a36', NULL, NULL, 'https://ik.imagekit.io/zspm7ezmf/kujyaFSGFBLoasiegftb345.jpg?updatedAt=1776222596697', 'global', 1, 0, '2026-05-04 19:33:10', '2026-05-04 19:33:10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `character_settings`
--

CREATE TABLE `character_settings` (
  `id` char(36) NOT NULL,
  `character_name` varchar(120) NOT NULL DEFAULT 'PO',
  `character_image_url` varchar(500) DEFAULT NULL,
  `bg_music_url` varchar(500) DEFAULT NULL,
  `bg_music_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `jump_sound_url` varchar(500) DEFAULT NULL,
  `land_sound_url` varchar(500) DEFAULT NULL,
  `spring_sound_url` varchar(500) DEFAULT NULL,
  `coin_sound_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `character_settings`
--

INSERT INTO `character_settings` (`id`, `character_name`, `character_image_url`, `bg_music_url`, `bg_music_enabled`, `jump_sound_url`, `land_sound_url`, `spring_sound_url`, `coin_sound_url`, `created_at`, `updated_at`) VALUES
('1d5cfe86-47e0-11f1-8ebe-45693cf4117a', '', 'https://ik.imagekit.io/zspm7ezmf/Pou%20em%20fundo%20transparente.png?updatedAt=1776238194756', '/uploads/game-assets/audio/swing-street-simon-folwar-main-version-33786-01-04_20260516005301_330c36c6.mp3', 0, NULL, NULL, NULL, NULL, '2026-05-04 17:38:51', '2026-05-16 00:53:16');

-- --------------------------------------------------------

--
-- Estrutura para tabela `commission_settings`
--

CREATE TABLE `commission_settings` (
  `id` char(36) NOT NULL,
  `default_commission_percent` decimal(6,2) NOT NULL DEFAULT 10.00,
  `default_commission_percent_level2` decimal(6,2) NOT NULL DEFAULT 2.00,
  `first_deposit_only` tinyint(1) NOT NULL DEFAULT 1,
  `min_deposit_for_commission` decimal(12,2) NOT NULL DEFAULT 0.00,
  `affiliate_skip_interval` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `commission_settings`
--

INSERT INTO `commission_settings` (`id`, `default_commission_percent`, `default_commission_percent_level2`, `first_deposit_only`, `min_deposit_for_commission`, `affiliate_skip_interval`, `is_active`, `created_at`, `updated_at`) VALUES
('1d54324d-47e0-11f1-8ebe-45693cf4117a', 50.00, 30.00, 1, 10.00, 0, 1, '2026-05-04 17:38:51', '2026-05-17 00:38:22');

-- --------------------------------------------------------

--
-- Estrutura para tabela `deposits`
--

CREATE TABLE `deposits` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `bonus_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_credited` decimal(12,2) DEFAULT NULL,
  `status` enum('pending','paid','failed','rejected','canceled') NOT NULL DEFAULT 'pending',
  `provider` varchar(40) NOT NULL DEFAULT 'manual',
  `gateway` varchar(40) DEFAULT NULL,
  `external_id` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) DEFAULT NULL,
  `admin_id` char(36) DEFAULT NULL,
  `qr_code` text DEFAULT NULL,
  `qrcode` text DEFAULT NULL,
  `pix_code` text DEFAULT NULL,
  `pix_qr_image` varchar(500) DEFAULT NULL,
  `qr_code_image_url` varchar(500) DEFAULT NULL,
  `payment_link` varchar(500) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`response`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `paid_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `deposits`
--

INSERT INTO `deposits` (`id`, `user_id`, `amount`, `bonus_amount`, `total_credited`, `status`, `provider`, `gateway`, `external_id`, `transaction_id`, `admin_id`, `qr_code`, `qrcode`, `pix_code`, `pix_qr_image`, `qr_code_image_url`, `payment_link`, `payload`, `response`, `metadata`, `created_at`, `updated_at`, `paid_at`, `rejected_at`) VALUES
('05fb7271-ef51-41f3-b499-64bf029a04ca', 'a0126999-6f42-4ffc-93c1-817662bcf900', 100.00, 0.00, 100.00, 'failed', 'akadpay', 'akadpay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"sdgadfhgadfh26362346sdfhbd\",\"secret\":\"asdgasdfghaerhger23462456fdhg\",\"amount\":100,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/shdfhfadhbpayments\\/webhook\\/akadpay\"}', '{\"error\":\"akadpay_http_error:Could not resolve host: painel.akadpay.cosfdjhshjm.br\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 04:18:39', '2026-05-15 04:18:39', NULL, NULL),
('0adbbea0-9f5e-48c5-9ff9-c6f21b52829c', 'a0126999-6f42-4ffc-93c1-817662bcf900', 60.00, 0.00, 60.00, 'failed', 'akadpay', 'akadpay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"ci_******************************************a78\",\"secret\":\"cs_******************************************b5c\",\"amount\":60,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/shdfhfadhbpayments\\/webhook\\/akadpay\"}', '{\"error\":\"akadpay_http_error:Could not resolve host: painel.akadpay.cosfdjhshjm.br\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 04:25:09', '2026-05-15 04:25:10', NULL, NULL),
('0e72d43d-9147-4e95-af08-29777ac9f010', 'a0126999-6f42-4ffc-93c1-817662bcf900', 60.00, 0.00, 60.00, 'pending', 'akadpay', 'akadpay', '0e72d43d-9147-4e95-af08-29777ac9f010', 'd6ac578f-dbe0-4e7d-a3af-cabf811f9d9a', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/e72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048AA4', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/e72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048AA4', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/e72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048AA4', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fe72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048AA4', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fe72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048AA4', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":60,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"d6ac578f-dbe0-4e7d-a3af-cabf811f9d9a\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/e72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048AA4\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fe72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048AA4\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"d6ac578f-dbe0-4e7d-a3af-cabf811f9d9a\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/e72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048AA4\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fe72c46bc-0727-40b6-a95d-3a6f408b2a695204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048AA4\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 18:32:12', '2026-05-15 18:32:12', NULL, NULL),
('360aaeee-2518-46dc-8836-2db4f7c26889', 'a0126999-6f42-4ffc-93c1-817662bcf900', 50.00, 0.00, 50.00, 'pending', 'akadpay', 'akadpay', '360aaeee-2518-46dc-8836-2db4f7c26889', 'c39358eb-df07-4306-922c-36aa396c4175', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/a5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304662B', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/a5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304662B', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/a5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304662B', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fa5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304662B', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fa5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304662B', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":50,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"c39358eb-df07-4306-922c-36aa396c4175\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/a5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304662B\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fa5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304662B\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"c39358eb-df07-4306-922c-36aa396c4175\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/a5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304662B\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fa5c4ea56-eccf-47d7-92bb-521ecae148f75204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304662B\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 18:41:44', '2026-05-15 18:41:45', NULL, NULL),
('3d83546b-7f0a-47c8-972d-f43e24bc6ed9', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 0.00, 5.00, 'paid', 'akadpay', 'akadpay', '3d83546b-7f0a-47c8-972d-f43e24bc6ed9', '47c6ba85-fcb8-4129-a651-2aa1fa6f1e68', 'a0126999-6f42-4ffc-93c1-817662bcf900', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630474F6', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630474F6', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630474F6', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630474F6', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630474F6', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":5,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"47c6ba85-fcb8-4129-a651-2aa1fa6f1e68\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630474F6\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630474F6\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"47c6ba85-fcb8-4129-a651-2aa1fa6f1e68\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630474F6\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3e337752-d7f1-417f-9f77-835a7bf316c15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630474F6\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 18:42:25', '2026-05-15 19:14:09', '2026-05-15 19:14:09', NULL),
('4318c2ba-86b6-49d7-8bda-39a25ec3150b', 'a0126999-6f42-4ffc-93c1-817662bcf900', 25.00, 0.00, 25.00, 'failed', 'akadpay', 'akadpay', '4318c2ba-86b6-49d7-8bda-39a25ec3150b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"ci_******************************************a78\",\"secret\":\"cs_******************************************b5c\",\"amount\":25,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":401,\"json\":{\"status\":\"error\",\"message\":\"Token ou Secret inválidos\"},\"raw_body\":\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"Token ou Secret inv\\\\u00e1lidos\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 05:15:32', '2026-05-15 05:15:32', NULL, NULL),
('492cd2be-c2fe-4e15-b57f-0fb577cd16ad', 'a0126999-6f42-4ffc-93c1-817662bcf900', 11.00, 11.00, 22.00, 'pending', 'akadpay', 'akadpay', '492cd2be-c2fe-4e15-b57f-0fb577cd16ad', 'b21f106c-713b-406a-aef9-642bd07d9029', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304141B', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304141B', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304141B', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304141B', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304141B', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":11,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"b21f106c-713b-406a-aef9-642bd07d9029\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304141B\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304141B\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"b21f106c-713b-406a-aef9-642bd07d9029\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304141B\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F3b39150e-993e-4335-9a32-027019fd4e4e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304141B\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":true,\"bonus_percent\":100,\"bonus_min_amount\":10}', '2026-05-18 21:30:24', '2026-05-18 21:30:25', NULL, NULL),
('4a8ac5b8-6474-4e5f-80f0-58de89574e31', 'a0126999-6f42-4ffc-93c1-817662bcf900', 20.00, 20.00, 40.00, 'paid', 'akadpay', 'akadpay', '4a8ac5b8-6474-4e5f-80f0-58de89574e31', 'eaf715f2-4c54-4a04-91b9-01cd7923534b', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/d4ede054-7007-418f-97f0-a06a171f55645204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630464E4', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/d4ede054-7007-418f-97f0-a06a171f55645204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630464E4', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/d4ede054-7007-418f-97f0-a06a171f55645204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630464E4', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fd4ede054-7007-418f-97f0-a06a171f55645204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630464E4', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fd4ede054-7007-418f-97f0-a06a171f55645204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630464E4', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":20,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\",\"split\":[{\"receiver_clientId\":\"ci__27ae24d7-5e77-4944-bc9e-974d3c343a83\",\"percent\":10}]}', '{\"webhook_status\":\"paid\",\"payload\":{\"status\":\"paid\",\"idTransaction\":\"eaf715f2-4c54-4a04-91b9-01cd7923534b\",\"typeTransaction\":\"PIX\"}}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":true,\"bonus_percent\":100,\"bonus_min_amount\":10}', '2026-05-18 21:38:16', '2026-05-18 21:38:58', '2026-05-18 21:38:58', NULL),
('58c6e929-a9a5-4715-ba74-32d2e2c38471', 'a0126999-6f42-4ffc-93c1-817662bcf900', 11.00, 11.00, 22.00, 'failed', 'akadpay', 'akadpay', '58c6e929-a9a5-4715-ba74-32d2e2c38471', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":null,\"secret\":null,\"amount\":11,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\",\"split\":[{\"receiver_clientId\":\"ci__27ae24d7-5e77-4944-bc9e-974d3c343a83\",\"percent\":10}]}', '{\"http_status\":400,\"json\":{\"error\":\"Token ou Secret ausentes\",\"message\":\"Você precisa fornecer tanto o token quanto o secret.\"},\"raw_body\":\"{\\\"error\\\":\\\"Token ou Secret ausentes\\\",\\\"message\\\":\\\"Voc\\\\u00ea precisa fornecer tanto o token quanto o secret.\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":true,\"bonus_percent\":100,\"bonus_min_amount\":10}', '2026-05-18 21:30:10', '2026-05-18 21:30:10', NULL, NULL),
('5b3b1436-8a1b-48ce-89fd-3c259fddf93c', 'a0126999-6f42-4ffc-93c1-817662bcf900', 25.00, 0.00, 25.00, 'failed', 'akadpay', 'akadpay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"ci_******************************************a78\",\"secret\":\"cs_******************************************b5c\",\"amount\":25,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/shdfhfadhbpayments\\/webhook\\/akadpay\"}', '{\"error\":\"akadpay_http_error:Could not resolve host: painel.akadpay.cosfdjhshjm.br\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 05:10:46', '2026-05-15 05:10:46', NULL, NULL),
('5c52bdd2-4581-4634-9136-3b928b6b31f5', 'a0126999-6f42-4ffc-93c1-817662bcf900', 50.00, 0.00, 50.00, 'pending', 'akadpay', 'akadpay', '5c52bdd2-4581-4634-9136-3b928b6b31f5', '196754aa-fd4b-4984-9828-67ae7e18b0b7', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630459F9', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630459F9', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630459F9', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630459F9', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630459F9', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":50,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"196754aa-fd4b-4984-9828-67ae7e18b0b7\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630459F9\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630459F9\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"196754aa-fd4b-4984-9828-67ae7e18b0b7\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***630459F9\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F8114d761-31b4-4a0c-856c-d916bbfe668b5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A630459F9\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 05:27:47', '2026-05-15 05:27:47', NULL, NULL),
('5e403308-cd87-454f-a745-fe00b11d9332', 'a0126999-6f42-4ffc-93c1-817662bcf900', 60.00, 0.00, 60.00, 'pending', 'akadpay', 'akadpay', '5e403308-cd87-454f-a745-fe00b11d9332', '25a001b0-202d-4968-9781-92d5c8c0ba6c', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048655', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048655', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048655', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048655', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048655', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":60,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"25a001b0-202d-4968-9781-92d5c8c0ba6c\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048655\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048655\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"25a001b0-202d-4968-9781-92d5c8c0ba6c\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048655\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F6a8a70c9-7ac1-4a45-afb8-6916889efeba5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048655\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 18:31:36', '2026-05-15 18:31:37', NULL, NULL),
('6b30c3ec-c68e-4047-a801-e2580ca37688', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 0.00, 5.00, 'pending', 'akadpay', 'akadpay', '6b30c3ec-c68e-4047-a801-e2580ca37688', '2bce0bfc-bd7b-4e85-835d-46adafa3d01b', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/cd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304817C', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/cd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304817C', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/cd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304817C', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fcd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304817C', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fcd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304817C', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":5,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"2bce0bfc-bd7b-4e85-835d-46adafa3d01b\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/cd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304817C\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fcd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304817C\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"2bce0bfc-bd7b-4e85-835d-46adafa3d01b\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/cd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304817C\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fcd2aa826-4e1c-4a67-968d-ea10b16bba115204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304817C\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 19:13:17', '2026-05-15 19:13:18', NULL, NULL),
('74eea9ad-9276-4d05-b2b9-c0c5e4b1d832', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 0.00, 5.00, 'failed', 'akadpay', 'akadpay', '74eea9ad-9276-4d05-b2b9-c0c5e4b1d832', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":5,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":502,\"json\":{\"status\":\"error\",\"message\":\"Erro na comunicacao com o servidor SyncPayments.\"},\"raw_body\":\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"Erro na comunicacao com o servidor SyncPayments.\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 19:36:55', '2026-05-15 19:36:57', NULL, NULL),
('8113e923-b316-45fb-a00f-96199cc73ba5', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 0.00, 5.00, 'paid', 'akadpay', 'akadpay', '8113e923-b316-45fb-a00f-96199cc73ba5', '2785e37d-c100-41b1-b136-e7b7fd60846c', 'a0126999-6f42-4ffc-93c1-817662bcf900', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304D963', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304D963', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304D963', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304D963', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304D963', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":5,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"2785e37d-c100-41b1-b136-e7b7fd60846c\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304D963\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304D963\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"2785e37d-c100-41b1-b136-e7b7fd60846c\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304D963\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F608d232c-767c-477a-a02b-4c3cc947fc3e5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304D963\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 18:59:04', '2026-05-15 19:14:12', '2026-05-15 19:14:12', NULL),
('88f9cb7f-5aae-4c6c-a6b6-aa2aae42932d', 'a0126999-6f42-4ffc-93c1-817662bcf900', 50.00, 0.00, 50.00, 'pending', 'akadpay', 'akadpay', '88f9cb7f-5aae-4c6c-a6b6-aa2aae42932d', '81bc2355-5ae1-4a32-bce5-0082a2ca43e0', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/d26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304E76E', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/d26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304E76E', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/d26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304E76E', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fd26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304E76E', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fd26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304E76E', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":50,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"81bc2355-5ae1-4a32-bce5-0082a2ca43e0\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/d26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304E76E\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fd26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304E76E\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"81bc2355-5ae1-4a32-bce5-0082a2ca43e0\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/d26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***6304E76E\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2Fd26f294e-9fb0-4459-b7a3-9f217ac324745204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A6304E76E\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 05:28:38', '2026-05-15 05:28:38', NULL, NULL),
('89933666-54dd-48d8-a843-a4a4424e82cd', 'a0126999-6f42-4ffc-93c1-817662bcf900', 6.00, 0.00, 6.00, 'failed', 'akadpay', 'akadpay', '89933666-54dd-48d8-a843-a4a4424e82cd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":6,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":502,\"json\":{\"status\":\"error\",\"message\":\"Erro na comunicacao com o servidor SyncPayments.\"},\"raw_body\":\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"Erro na comunicacao com o servidor SyncPayments.\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 19:37:08', '2026-05-15 19:37:09', NULL, NULL),
('b8a69d07-1735-48f8-a429-78eb78a2f819', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 0.00, 5.00, 'pending', 'akadpay', 'akadpay', 'b8a69d07-1735-48f8-a429-78eb78a2f819', '1a09b717-8789-4098-93fa-611de3187a06', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63049DDA', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63049DDA', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63049DDA', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63049DDA', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63049DDA', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":5,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"1a09b717-8789-4098-93fa-611de3187a06\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63049DDA\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63049DDA\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"1a09b717-8789-4098-93fa-611de3187a06\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63049DDA\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F5b293258-8f5a-439d-bbec-1ca4d320f4d55204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63049DDA\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 19:23:40', '2026-05-15 19:23:41', NULL, NULL),
('ba3792af-f556-4da0-aa3f-b3aacf8b4adf', 'a0126999-6f42-4ffc-93c1-817662bcf900', 10.00, 0.00, 10.00, 'pending', 'akadpay', 'akadpay', 'ba3792af-f556-4da0-aa3f-b3aacf8b4adf', '9776acaa-7ca2-4580-b6d6-ec74c9af2c08', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63047B7E', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63047B7E', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63047B7E', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63047B7E', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63047B7E', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":10,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"9776acaa-7ca2-4580-b6d6-ec74c9af2c08\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63047B7E\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63047B7E\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"9776acaa-7ca2-4580-b6d6-ec74c9af2c08\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63047B7E\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F2caf8460-6bfb-48fe-a818-e61a8e1e11705204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63047B7E\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 19:42:58', '2026-05-15 19:42:58', NULL, NULL),
('bea63219-0a59-4145-a269-bf722f94a978', 'a0126999-6f42-4ffc-93c1-817662bcf900', 59.97, 0.00, 59.97, 'pending', 'akadpay', 'akadpay', 'bea63219-0a59-4145-a269-bf722f94a978', '2e373c5e-88e1-4bd6-aa8f-70a90838349f', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048553', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048553', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048553', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048553', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048553', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":59.97,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":200,\"json\":{\"idTransaction\":\"2e373c5e-88e1-4bd6-aa8f-70a90838349f\",\"qrcode\":\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\/qr\\/v3\\/at\\/9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048553\",\"qr_code_image_url\":\"https:\\/\\/quickchart.io\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048553\"},\"raw_body\":\"{\\\"idTransaction\\\":\\\"2e373c5e-88e1-4bd6-aa8f-70a90838349f\\\",\\\"qrcode\\\":\\\"00020126850014br.gov.bcb.pix2563pix.onlyup.com.br\\\\\\/qr\\\\\\/v3\\\\\\/at\\\\\\/9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63048553\\\",\\\"qr_code_image_url\\\":\\\"https:\\\\\\/\\\\\\/quickchart.io\\\\\\/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F9fec94d4-bee0-462f-be97-a76a171e718a5204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63048553\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 18:41:36', '2026-05-15 18:41:37', NULL, NULL),
('bf06e740-9f4e-4e2a-9563-7fe43a72c21e', 'a0126999-6f42-4ffc-93c1-817662bcf900', 39.97, 0.00, 39.97, 'failed', 'akadpay', 'akadpay', 'bf06e740-9f4e-4e2a-9563-7fe43a72c21e', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":\"ci_******************************************a78\",\"secret\":\"cs_******************************************b5c\",\"amount\":39.97,\"debtor_name\":\"jonathan\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\"}', '{\"http_status\":401,\"json\":{\"status\":\"error\",\"message\":\"Token ou Secret inválidos\"},\"raw_body\":\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"Token ou Secret inv\\\\u00e1lidos\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":false,\"bonus_percent\":0,\"bonus_min_amount\":0}', '2026-05-15 05:26:57', '2026-05-15 05:26:57', NULL, NULL),
('f3045fc7-09b5-4f31-a2d6-f4715c724709', 'a0126999-6f42-4ffc-93c1-817662bcf900', 10.00, 10.00, 20.00, 'paid', 'akadpay', 'akadpay', 'f3045fc7-09b5-4f31-a2d6-f4715c724709', '484fcba9-3308-4374-ad8a-a25a3b335ff2', NULL, '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/049c2c42-407f-46b0-96cb-2dcde07d26a15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63045CD4', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/049c2c42-407f-46b0-96cb-2dcde07d26a15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63045CD4', '00020126850014br.gov.bcb.pix2563pix.onlyup.com.br/qr/v3/at/049c2c42-407f-46b0-96cb-2dcde07d26a15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503***63045CD4', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F049c2c42-407f-46b0-96cb-2dcde07d26a15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63045CD4', 'https://quickchart.io/qr?text=00020126850014br.gov.bcb.pix2563pix.onlyup.com.br%2Fqr%2Fv3%2Fat%2F049c2c42-407f-46b0-96cb-2dcde07d26a15204000053039865802BR5925MARKETPLACE_BRASIL_SYNC_L6008BRASILIA62070503%2A%2A%2A63045CD4', NULL, '{\"token\":\"ci_jonathan_f3ae8085-654c-4431-9c16-ba994bf03a78\",\"secret\":\"cs_jonathan_2ff7fc0d-bf3d-4ee5-a060-d831f06eab5c\",\"amount\":10,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\",\"split\":[{\"receiver_clientId\":\"ci__27ae24d7-5e77-4944-bc9e-974d3c343a83\",\"percent\":10}]}', '{\"webhook_status\":\"paid\",\"payload\":{\"status\":\"paid\",\"idTransaction\":\"484fcba9-3308-4374-ad8a-a25a3b335ff2\",\"typeTransaction\":\"PIX\"}}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":true,\"bonus_percent\":100,\"bonus_min_amount\":10}', '2026-05-18 21:49:29', '2026-05-18 21:50:12', '2026-05-18 21:50:12', NULL),
('fdfbeb1d-30d7-438b-848e-21071499fa7a', 'a0126999-6f42-4ffc-93c1-817662bcf900', 10.00, 10.00, 20.00, 'failed', 'akadpay', 'akadpay', 'fdfbeb1d-30d7-438b-848e-21071499fa7a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"token\":null,\"secret\":null,\"amount\":10,\"debtor_name\":\"jonathan Rodriogues\",\"email\":\"jonathansrodrigues9@gmail.com\",\"debtor_document_number\":\"12964879621\",\"phone\":\"37999382087\",\"method_pay\":\"pix\",\"postback\":\"https:\\/\\/pou-pou.fun\\/api\\/payments\\/webhook\\/akadpay\",\"split\":[{\"receiver_clientId\":\"ci__27ae24d7-5e77-4944-bc9e-974d3c343a83\",\"percent\":10}]}', '{\"http_status\":400,\"json\":{\"error\":\"Token ou Secret ausentes\",\"message\":\"Você precisa fornecer tanto o token quanto o secret.\"},\"raw_body\":\"{\\\"error\\\":\\\"Token ou Secret ausentes\\\",\\\"message\\\":\\\"Voc\\\\u00ea precisa fornecer tanto o token quanto o secret.\\\"}\"}', '{\"source\":\"akadpay_real\",\"created_via\":\"payments_deposit_create\",\"bonus_enabled\":true,\"bonus_percent\":100,\"bonus_min_amount\":10}', '2026-05-18 21:29:52', '2026-05-18 21:29:52', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `financial_settings`
--

CREATE TABLE `financial_settings` (
  `id` char(36) NOT NULL,
  `min_deposit` decimal(12,2) NOT NULL DEFAULT 20.00,
  `min_withdrawal_player` decimal(12,2) NOT NULL DEFAULT 50.00,
  `min_withdrawal_affiliate` decimal(12,2) NOT NULL DEFAULT 50.00,
  `deposit_bonus_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `deposit_bonus_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `deposit_bonus_min_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `deposit_card_1` decimal(12,2) DEFAULT NULL,
  `deposit_card_2` decimal(12,2) DEFAULT NULL,
  `deposit_card_3` decimal(12,2) DEFAULT NULL,
  `deposit_card_4` decimal(12,2) DEFAULT NULL,
  `withdrawal_fee_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `withdrawal_fee_fixed` decimal(12,2) NOT NULL DEFAULT 0.00,
  `pix_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `financial_settings`
--

INSERT INTO `financial_settings` (`id`, `min_deposit`, `min_withdrawal_player`, `min_withdrawal_affiliate`, `deposit_bonus_enabled`, `deposit_bonus_percent`, `deposit_bonus_min_amount`, `deposit_card_1`, `deposit_card_2`, `deposit_card_3`, `deposit_card_4`, `withdrawal_fee_percent`, `withdrawal_fee_fixed`, `pix_enabled`, `created_at`, `updated_at`) VALUES
('1d4fba04-47e0-11f1-8ebe-45693cf4117a', 10.00, 5.00, 5.00, 1, 100.00, 10.00, 50.00, 100.00, 200.00, 500.00, 0.00, 0.00, 1, '2026-05-04 17:38:51', '2026-05-16 17:28:29');

-- --------------------------------------------------------

--
-- Estrutura para tabela `game_sessions`
--

CREATE TABLE `game_sessions` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `bet_amount` decimal(12,2) NOT NULL,
  `target_amount` decimal(12,2) NOT NULL,
  `coin_value` decimal(12,4) NOT NULL,
  `max_payout_amount` decimal(12,2) NOT NULL,
  `difficulty` decimal(6,2) NOT NULL DEFAULT 50.00,
  `coin_return` decimal(6,2) NOT NULL DEFAULT 5.00,
  `game_speed` decimal(6,2) NOT NULL DEFAULT 1.00,
  `jump_height` decimal(6,2) NOT NULL DEFAULT 12.00,
  `status` enum('active','lost','cashed_out','won') NOT NULL DEFAULT 'active',
  `coins_collected` int(11) NOT NULL DEFAULT 0,
  `payout_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ended_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `game_sessions`
--

INSERT INTO `game_sessions` (`id`, `user_id`, `bet_amount`, `target_amount`, `coin_value`, `max_payout_amount`, `difficulty`, `coin_return`, `game_speed`, `jump_height`, `status`, `coins_collected`, `payout_amount`, `created_at`, `ended_at`, `updated_at`) VALUES
('00c357e3-5b8d-4781-9bca-4f89a4163d85', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 7.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 22:43:31', '2026-05-15 22:43:41', '2026-05-15 22:43:41'),
('0ea5c4c1-3d06-4a28-bb49-58eac19fa5b4', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-04 20:12:08', '2026-05-04 20:12:14', '2026-05-04 20:12:14'),
('0ed67eb6-7667-4178-a6ad-a17a2375c617', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-04 19:53:20', '2026-05-04 19:53:23', '2026-05-04 19:53:23'),
('10ef72cc-930e-4d39-8283-31f612265bf2', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-16 00:19:03', '2026-05-16 00:19:21', '2026-05-16 00:19:21'),
('118d5ba1-e11b-42d9-a4bf-8008ea59a601', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-16 00:22:28', NULL, '2026-05-16 00:22:28'),
('181e8516-36e5-4644-8356-c78d568da98e', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 5, 0.00, '2026-05-16 01:13:37', '2026-05-16 01:13:52', '2026-05-16 01:13:52'),
('24a892c9-4ea1-4a2b-9f04-b40330ff332e', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 5.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-15 22:27:53', '2026-05-15 22:28:06', '2026-05-15 22:28:06'),
('2eb1068b-c3b0-48cb-98c1-cb8384ee6bd2', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 10.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 1, 5.00, '2026-05-15 22:27:20', '2026-05-15 22:27:25', '2026-05-15 22:27:25'),
('345e52be-3cd5-4501-982c-359103f52a48', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 4.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 2, 5.00, '2026-05-15 23:20:48', '2026-05-15 23:21:05', '2026-05-15 23:21:05'),
('35e111e7-a24d-4b8a-8aca-6b8155f8b42c', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 3, 0.00, '2026-05-16 00:19:26', '2026-05-16 00:19:36', '2026-05-16 00:19:36'),
('3b461bfd-09d6-4147-95ee-a65ae6f668bf', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-16 01:31:39', NULL, '2026-05-16 01:31:39'),
('3bad765a-9cd3-403d-9d04-6853811a3ca0', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 2, 5.00, '2026-05-15 23:24:23', '2026-05-15 23:24:28', '2026-05-15 23:24:28'),
('3e55a20d-0d2a-4d3e-820f-9aac587ed7b7', 'a0126999-6f42-4ffc-93c1-817662bcf900', 10.00, 50.00, 1.0000, 50.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 23:03:42', '2026-05-15 23:03:48', '2026-05-15 23:03:48'),
('4e7dd5fc-b734-4da1-8f05-8579fc205d0a', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-04 20:03:12', NULL, '2026-05-04 20:03:12'),
('4f869e6e-6f6a-4a88-909f-6e9834470a9e', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 2, 0.00, '2026-05-15 23:27:06', '2026-05-15 23:27:28', '2026-05-15 23:27:28'),
('5083de43-953a-4ed7-93dd-d8cd4f382f9b', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-04 19:53:24', NULL, '2026-05-04 19:53:24'),
('51855938-7e25-4ecb-ba67-bd0a54a330b6', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-16 00:53:08', '2026-05-16 00:53:19', '2026-05-16 00:53:19'),
('5924f77c-9426-4f97-8b59-8612bd5b7378', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-16 00:52:29', NULL, '2026-05-16 00:52:29'),
('5f7733dd-5628-4561-961e-bf2a811be54b', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 5, 5.00, '2026-05-15 23:21:56', '2026-05-15 23:22:23', '2026-05-15 23:22:23'),
('698ceea5-5e1a-4cd7-994f-3148b6232029', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 00:55:57', '2026-05-16 00:56:02', '2026-05-16 00:56:02'),
('6b4f8143-ce2a-44f2-812f-a45e580a8d43', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 10.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 22:26:34', '2026-05-15 22:26:42', '2026-05-15 22:26:42'),
('7bf2b04b-c61a-4cdf-aca3-2087b8376f6f', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 01:14:01', '2026-05-16 01:14:03', '2026-05-16 01:14:03'),
('7e69a957-c875-4a04-be7f-220092f33393', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 10.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 22:26:27', '2026-05-15 22:26:33', '2026-05-15 22:26:33'),
('7eb368f0-4650-4799-815d-5164f0679667', 'a0126999-6f42-4ffc-93c1-817662bcf900', 0.50, 2.50, 3.0000, 2.50, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 00:54:30', '2026-05-16 00:54:34', '2026-05-16 00:54:34'),
('804dc1dd-5956-44aa-bce0-81994060de29', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 3, 0.00, '2026-05-15 21:38:23', '2026-05-15 21:38:38', '2026-05-15 21:38:38'),
('82116a8c-dc30-4033-bca2-0100cb040de2', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 25.00, 0.2500, 25.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 21:37:58', '2026-05-15 21:38:05', '2026-05-15 21:38:05'),
('8318c04c-f670-4d42-8e27-0b1dcdcd195a', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 1.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 2, 0.00, '2026-05-15 23:01:23', '2026-05-15 23:01:37', '2026-05-15 23:01:37'),
('869a6e15-6326-4e85-9328-148f418fe0f8', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-04 20:03:18', '2026-05-04 20:04:51', '2026-05-04 20:04:51'),
('8bdcc098-3518-4cfe-b5a2-fb7d11eed78f', 'a0126999-6f42-4ffc-93c1-817662bcf900', 5.00, 25.00, 0.2500, 25.00, 50.00, 5.00, 1.00, 12.00, 'lost', 3, 0.00, '2026-05-15 21:38:06', '2026-05-15 21:38:21', '2026-05-15 21:38:21'),
('8dfcada8-6554-467b-8bc4-a5a6857cb45b', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-04 19:52:08', '2026-05-04 19:52:16', '2026-05-04 19:52:16'),
('8fdc3163-fea2-4ade-9af2-5ae8d06ec84c', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 7, 140.00, '2026-05-16 00:16:10', '2026-05-16 00:16:31', '2026-05-16 00:16:31'),
('9d2b748b-0aee-43dd-a3f2-0297797215e1', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 5.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 1, 5.00, '2026-05-15 22:28:07', '2026-05-15 22:28:16', '2026-05-15 22:28:16'),
('a25980c2-38d6-4ce7-9192-aaa364f9c331', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 8, 0.00, '2026-05-16 00:20:36', '2026-05-16 00:22:23', '2026-05-16 00:22:23'),
('a469cfef-5803-4fe7-940f-cc0426915618', 'a0126999-6f42-4ffc-93c1-817662bcf900', 0.50, 2.50, 3.0000, 2.50, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-16 00:54:35', NULL, '2026-05-16 00:54:35'),
('ac687390-c2d6-4129-8314-1cd4d36bf347', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 21:39:21', '2026-05-15 21:39:31', '2026-05-15 21:39:31'),
('ad5990f3-32c6-4515-b15f-6bae2919b23a', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 2, 6.00, '2026-05-16 00:53:23', '2026-05-16 00:53:32', '2026-05-16 00:53:32'),
('ada6e5e8-d98c-44dd-84ea-ec680a2118b8', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 01:27:18', '2026-05-16 01:27:26', '2026-05-16 01:27:26'),
('c37bd43c-6ab0-4da6-9977-e002572f9c8c', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 00:15:32', '2026-05-16 00:15:36', '2026-05-16 00:15:36'),
('c8047891-a634-4047-bf3a-734a3759f60e', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 10.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 1, 5.00, '2026-05-15 22:26:43', '2026-05-15 22:26:52', '2026-05-15 22:26:52'),
('cd9e5308-c558-45b0-994f-5d7723164c46', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 4, 0.00, '2026-05-15 23:21:35', '2026-05-15 23:21:55', '2026-05-15 23:21:55'),
('d527fe50-d207-45b9-a007-cd5a89b7fc74', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 01:28:41', '2026-05-16 01:28:50', '2026-05-16 01:28:50'),
('d9717b04-2cec-4362-8839-67a01a8f262d', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-16 01:31:46', NULL, '2026-05-16 01:31:46'),
('d9da4272-0ec5-412a-b0af-2802fb27591a', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-16 00:15:52', '2026-05-16 00:15:57', '2026-05-16 00:15:57'),
('da351946-9748-4f25-83bc-50a58acc9a3e', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 20.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'cashed_out', 5, 5.00, '2026-05-15 23:22:29', '2026-05-15 23:22:48', '2026-05-15 23:22:48'),
('dc9c917f-407f-4b4c-adeb-9090b37ba7b6', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 10.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 2, 0.00, '2026-05-15 22:26:00', '2026-05-15 22:26:23', '2026-05-15 22:26:23'),
('ddd74b5a-f4e2-47f2-ac25-91968bdc46ce', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 10.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 1, 0.00, '2026-05-15 22:27:11', '2026-05-15 22:27:18', '2026-05-15 22:27:18'),
('e0715154-b495-4018-bed0-4863a4b30178', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 3.0000, 5.00, 50.00, 5.00, 1.00, 12.00, 'active', 0, 0.00, '2026-05-16 00:52:33', NULL, '2026-05-16 00:52:33'),
('ee1777d1-5152-4be4-b8d2-17aff5134dee', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-04 19:34:01', '2026-05-04 19:34:05', '2026-05-04 19:34:05'),
('ffe335cd-64d0-4c28-84fb-95914754b3d9', 'a0126999-6f42-4ffc-93c1-817662bcf900', 1.00, 5.00, 0.0500, 5.00, 50.00, 5.00, 1.00, 12.00, 'lost', 0, 0.00, '2026-05-04 20:07:43', '2026-05-04 20:07:48', '2026-05-04 20:07:48');

-- --------------------------------------------------------

--
-- Estrutura para tabela `game_settings`
--

CREATE TABLE `game_settings` (
  `id` char(36) NOT NULL,
  `difficulty` decimal(6,2) NOT NULL DEFAULT 50.00,
  `difficulty_per_level` int(11) NOT NULL DEFAULT 8,
  `coin_return` decimal(6,2) NOT NULL DEFAULT 5.00,
  `game_speed` decimal(6,2) NOT NULL DEFAULT 1.00,
  `jump_height` decimal(6,2) NOT NULL DEFAULT 12.00,
  `game_title` varchar(80) NOT NULL DEFAULT 'PO',
  `game_subtitle` varchar(255) NOT NULL DEFAULT 'Suba alto e ganhe moedas!',
  `login_banner_url` varchar(500) DEFAULT NULL,
  `register_banner_url` varchar(500) DEFAULT NULL,
  `rtp_global` decimal(6,2) NOT NULL DEFAULT 95.00,
  `coin_frequency` decimal(6,2) NOT NULL DEFAULT 1.00,
  `spring_frequency` decimal(6,2) NOT NULL DEFAULT 1.00,
  `spring_boost` decimal(6,2) NOT NULL DEFAULT 1.00,
  `moving_platform_speed_multiplier` decimal(6,2) NOT NULL DEFAULT 1.00,
  `progressive_distance_multiplier` decimal(6,2) NOT NULL DEFAULT 1.00,
  `difficulty_rtp_balance` decimal(6,2) NOT NULL DEFAULT 50.00,
  `common_player_coin_percentage` decimal(6,2) NOT NULL DEFAULT 5.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `game_settings`
--

INSERT INTO `game_settings` (`id`, `difficulty`, `difficulty_per_level`, `coin_return`, `game_speed`, `jump_height`, `game_title`, `game_subtitle`, `login_banner_url`, `register_banner_url`, `rtp_global`, `coin_frequency`, `spring_frequency`, `spring_boost`, `moving_platform_speed_multiplier`, `progressive_distance_multiplier`, `difficulty_rtp_balance`, `common_player_coin_percentage`, `created_at`, `updated_at`) VALUES
('1d4cbd5f-47e0-11f1-8ebe-45693cf4117a', 50.00, 8, 5.00, 1.00, 12.00, 'POU', 'Suba alto e ganhe moedas!', 'https://ik.imagekit.io/zspm7ezmf/ChatGPT%20Image%2016_04_2026,%2006_32_08.png?updatedAt=1777923055365', 'https://ik.imagekit.io/zspm7ezmf/ChatGPT%20Image%2016_04_2026,%2006_31_08.png?updatedAt=1777923058356', 95.00, 1.00, 1.00, 1.00, 1.00, 1.00, 50.00, 5.00, '2026-05-04 17:38:51', '2026-05-16 00:53:16');

-- --------------------------------------------------------

--
-- Estrutura para tabela `influencer_settings`
--

CREATE TABLE `influencer_settings` (
  `id` char(36) NOT NULL,
  `gain_multiplier` decimal(6,2) NOT NULL DEFAULT 1.00,
  `difficulty_reduction` decimal(6,2) NOT NULL DEFAULT 0.00,
  `coin_return` decimal(6,2) NOT NULL DEFAULT 5.00,
  `jump_multiplier` decimal(6,2) NOT NULL DEFAULT 1.00,
  `influencer_coin_percentage` decimal(6,2) NOT NULL DEFAULT 5.00,
  `influencer_calculation_mode` varchar(40) NOT NULL DEFAULT 'multiplier',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `influencer_jump_multiplier_v2` decimal(6,2) NOT NULL DEFAULT 1.00,
  `influencer_fixed_coin_value_v2` decimal(12,2) NOT NULL DEFAULT 1.00,
  `influencer_double_coins_v2` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `influencer_settings`
--

INSERT INTO `influencer_settings` (`id`, `gain_multiplier`, `difficulty_reduction`, `coin_return`, `jump_multiplier`, `influencer_coin_percentage`, `influencer_calculation_mode`, `created_at`, `updated_at`, `influencer_jump_multiplier_v2`, `influencer_fixed_coin_value_v2`, `influencer_double_coins_v2`) VALUES
('1d5890cc-47e0-11f1-8ebe-45693cf4117a', 1.00, 0.00, 5.00, 1.00, 5.00, 'percentage', '2026-05-04 17:38:51', '2026-05-16 00:22:57', 3.00, 3.00, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `profiles`
--

CREATE TABLE `profiles` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `full_name` varchar(190) NOT NULL DEFAULT '',
  `username` varchar(80) DEFAULT NULL,
  `email` varchar(190) NOT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `cpf` varchar(30) DEFAULT NULL,
  `is_influencer` tinyint(1) NOT NULL DEFAULT 0,
  `comissao_cpa` decimal(12,2) DEFAULT NULL,
  `comissao_cpa_nivel2` decimal(12,2) DEFAULT NULL,
  `custom_commission_percent` decimal(6,2) DEFAULT NULL,
  `custom_game_difficulty` decimal(6,2) DEFAULT NULL,
  `custom_coin_return` decimal(6,2) DEFAULT NULL,
  `custom_game_speed` decimal(6,2) DEFAULT NULL,
  `custom_jump_height` decimal(6,2) DEFAULT NULL,
  `custom_bonus_percent` decimal(6,2) DEFAULT NULL,
  `referral_code` varchar(80) DEFAULT NULL,
  `referred_by` char(36) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `full_name`, `username`, `email`, `phone`, `cpf`, `is_influencer`, `comissao_cpa`, `comissao_cpa_nivel2`, `custom_commission_percent`, `custom_game_difficulty`, `custom_coin_return`, `custom_game_speed`, `custom_jump_height`, `custom_bonus_percent`, `referral_code`, `referred_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
('c97e573c-bbaa-46d8-b2cb-7dfe4ec614f9', 'a0126999-6f42-4ffc-93c1-817662bcf900', 'jonathan Rodriogues', NULL, 'jonathansrodrigues9@gmail.com', '37999382087', '129.648.796-21', 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'fa022084', NULL, NULL, '2026-05-04 17:39:45', '2026-05-16 00:16:05');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `deleted_at`, `created_at`, `updated_at`) VALUES
('a0126999-6f42-4ffc-93c1-817662bcf900', 'jonathansrodrigues9@gmail.com', '$2y$10$aNSrawI0zKuCjFTR5tqkyOgXS1t3BxsJGCy7uYi1OXkYnW7uk6blK', NULL, '2026-05-04 17:39:45', '2026-05-04 17:39:45');

-- --------------------------------------------------------

--
-- Estrutura para tabela `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` char(36) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role`, `created_at`) VALUES
(1, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'admin', '2026-05-04 17:39:45');

-- --------------------------------------------------------

--
-- Estrutura para tabela `wallets`
--

CREATE TABLE `wallets` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `player_balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `affiliate_balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `comissao_disponivel` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_deposited` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_withdrawn` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_affiliate_earned` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `player_balance`, `affiliate_balance`, `comissao_disponivel`, `total_deposited`, `total_withdrawn`, `total_affiliate_earned`, `created_at`, `updated_at`) VALUES
('2e0bfafd-3405-4a6a-b16b-2968236fceb1', 'a0126999-6f42-4ffc-93c1-817662bcf900', 286.00, 100.00, 0.00, 70.00, 0.00, 0.00, '2026-05-04 17:39:45', '2026-05-18 21:50:12');

-- --------------------------------------------------------

--
-- Estrutura para tabela `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` char(36) NOT NULL,
  `admin_id` char(36) DEFAULT NULL,
  `game_session_id` char(36) DEFAULT NULL,
  `type` enum('bet','win','deposit','commission','withdrawal_player','withdrawal_affiliate','withdrawal_refund','admin_credit_player','admin_debit_player','admin_credit_affiliate','admin_debit_affiliate') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `balance_before` decimal(12,2) NOT NULL,
  `balance_after` decimal(12,2) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `user_id`, `admin_id`, `game_session_id`, `type`, `amount`, `balance_before`, `balance_after`, `reason`, `description`, `created_at`) VALUES
(1, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'admin_credit_player', 100.00, 0.00, 100.00, 'deposito', 'Admin wallet adjustment', '2026-05-04 19:21:57'),
(2, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ee1777d1-5152-4be4-b8d2-17aff5134dee', 'bet', -1.00, 100.00, 99.00, NULL, 'Game bet placed', '2026-05-04 19:34:01'),
(3, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '8dfcada8-6554-467b-8bc4-a5a6857cb45b', 'bet', -1.00, 99.00, 98.00, NULL, 'Game bet placed', '2026-05-04 19:52:08'),
(4, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '0ed67eb6-7667-4178-a6ad-a17a2375c617', 'bet', -1.00, 98.00, 97.00, NULL, 'Game bet placed', '2026-05-04 19:53:20'),
(5, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '5083de43-953a-4ed7-93dd-d8cd4f382f9b', 'bet', -1.00, 97.00, 96.00, NULL, 'Game bet placed', '2026-05-04 19:53:24'),
(6, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '4e7dd5fc-b734-4da1-8f05-8579fc205d0a', 'bet', -1.00, 96.00, 95.00, NULL, 'Game bet placed', '2026-05-04 20:03:12'),
(7, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '869a6e15-6326-4e85-9328-148f418fe0f8', 'bet', -1.00, 95.00, 94.00, NULL, 'Game bet placed', '2026-05-04 20:03:18'),
(8, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ffe335cd-64d0-4c28-84fb-95914754b3d9', 'bet', -1.00, 94.00, 93.00, NULL, 'Game bet placed', '2026-05-04 20:07:43'),
(9, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '0ea5c4c1-3d06-4a28-bb49-58eac19fa5b4', 'bet', -1.00, 93.00, 92.00, NULL, 'Game bet placed', '2026-05-04 20:12:08'),
(10, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'deposit', 5.00, 92.00, 97.00, 'Manual deposit approval', 'Admin approved deposit', '2026-05-15 19:14:09'),
(11, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'deposit', 5.00, 97.00, 102.00, 'Manual deposit approval', 'Admin approved deposit', '2026-05-15 19:14:12'),
(14, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '82116a8c-dc30-4033-bca2-0100cb040de2', 'bet', -5.00, 102.00, 97.00, NULL, 'Game bet placed', '2026-05-15 21:37:58'),
(15, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '8bdcc098-3518-4cfe-b5a2-fb7d11eed78f', 'bet', -5.00, 97.00, 92.00, NULL, 'Game bet placed', '2026-05-15 21:38:06'),
(16, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '804dc1dd-5956-44aa-bce0-81994060de29', 'bet', -1.00, 92.00, 91.00, NULL, 'Game bet placed', '2026-05-15 21:38:23'),
(17, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ac687390-c2d6-4129-8314-1cd4d36bf347', 'bet', -1.00, 91.00, 90.00, NULL, 'Game bet placed', '2026-05-15 21:39:21'),
(18, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'dc9c917f-407f-4b4c-adeb-9090b37ba7b6', 'bet', -1.00, 90.00, 89.00, NULL, 'Game bet placed', '2026-05-15 22:26:00'),
(19, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '7e69a957-c875-4a04-be7f-220092f33393', 'bet', -1.00, 89.00, 88.00, NULL, 'Game bet placed', '2026-05-15 22:26:27'),
(20, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '6b4f8143-ce2a-44f2-812f-a45e580a8d43', 'bet', -1.00, 88.00, 87.00, NULL, 'Game bet placed', '2026-05-15 22:26:34'),
(21, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'c8047891-a634-4047-bf3a-734a3759f60e', 'bet', -1.00, 87.00, 86.00, NULL, 'Game bet placed', '2026-05-15 22:26:43'),
(22, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'c8047891-a634-4047-bf3a-734a3759f60e', 'win', 5.00, 86.00, 91.00, NULL, 'Game payout', '2026-05-15 22:26:52'),
(23, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ddd74b5a-f4e2-47f2-ac25-91968bdc46ce', 'bet', -1.00, 91.00, 90.00, NULL, 'Game bet placed', '2026-05-15 22:27:11'),
(24, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '2eb1068b-c3b0-48cb-98c1-cb8384ee6bd2', 'bet', -1.00, 90.00, 89.00, NULL, 'Game bet placed', '2026-05-15 22:27:20'),
(25, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '2eb1068b-c3b0-48cb-98c1-cb8384ee6bd2', 'win', 5.00, 89.00, 94.00, NULL, 'Game payout', '2026-05-15 22:27:25'),
(26, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '24a892c9-4ea1-4a2b-9f04-b40330ff332e', 'bet', -1.00, 94.00, 93.00, NULL, 'Game bet placed', '2026-05-15 22:27:53'),
(27, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '9d2b748b-0aee-43dd-a3f2-0297797215e1', 'bet', -1.00, 93.00, 92.00, NULL, 'Game bet placed', '2026-05-15 22:28:07'),
(28, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '9d2b748b-0aee-43dd-a3f2-0297797215e1', 'win', 5.00, 92.00, 97.00, NULL, 'Game payout', '2026-05-15 22:28:16'),
(29, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '00c357e3-5b8d-4781-9bca-4f89a4163d85', 'bet', -1.00, 97.00, 96.00, NULL, 'Game bet placed', '2026-05-15 22:43:31'),
(30, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '8318c04c-f670-4d42-8e27-0b1dcdcd195a', 'bet', -1.00, 96.00, 95.00, NULL, 'Game bet placed', '2026-05-15 23:01:23'),
(31, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '3e55a20d-0d2a-4d3e-820f-9aac587ed7b7', 'bet', -10.00, 95.00, 85.00, NULL, 'Game bet placed', '2026-05-15 23:03:42'),
(32, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '345e52be-3cd5-4501-982c-359103f52a48', 'bet', -1.00, 85.00, 84.00, NULL, 'Game bet placed', '2026-05-15 23:20:48'),
(33, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '345e52be-3cd5-4501-982c-359103f52a48', 'win', 5.00, 84.00, 89.00, NULL, 'Game payout', '2026-05-15 23:21:05'),
(34, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'cd9e5308-c558-45b0-994f-5d7723164c46', 'bet', -1.00, 89.00, 88.00, NULL, 'Game bet placed', '2026-05-15 23:21:35'),
(35, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '5f7733dd-5628-4561-961e-bf2a811be54b', 'bet', -1.00, 88.00, 87.00, NULL, 'Game bet placed', '2026-05-15 23:21:56'),
(36, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '5f7733dd-5628-4561-961e-bf2a811be54b', 'win', 5.00, 87.00, 92.00, NULL, 'Game payout', '2026-05-15 23:22:23'),
(37, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'da351946-9748-4f25-83bc-50a58acc9a3e', 'bet', -1.00, 92.00, 91.00, NULL, 'Game bet placed', '2026-05-15 23:22:29'),
(38, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'da351946-9748-4f25-83bc-50a58acc9a3e', 'win', 5.00, 91.00, 96.00, NULL, 'Game payout', '2026-05-15 23:22:48'),
(39, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '3bad765a-9cd3-403d-9d04-6853811a3ca0', 'bet', -1.00, 96.00, 95.00, NULL, 'Game bet placed', '2026-05-15 23:24:23'),
(40, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '3bad765a-9cd3-403d-9d04-6853811a3ca0', 'win', 5.00, 95.00, 100.00, NULL, 'Game payout', '2026-05-15 23:24:28'),
(41, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '4f869e6e-6f6a-4a88-909f-6e9834470a9e', 'bet', -1.00, 100.00, 99.00, NULL, 'Game bet placed', '2026-05-15 23:27:06'),
(42, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'c37bd43c-6ab0-4da6-9977-e002572f9c8c', 'bet', -1.00, 99.00, 98.00, NULL, 'Game bet placed', '2026-05-16 00:15:32'),
(43, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'd9da4272-0ec5-412a-b0af-2802fb27591a', 'bet', -1.00, 98.00, 97.00, NULL, 'Game bet placed', '2026-05-16 00:15:52'),
(44, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '8fdc3163-fea2-4ade-9af2-5ae8d06ec84c', 'bet', -1.00, 97.00, 96.00, NULL, 'Game bet placed', '2026-05-16 00:16:10'),
(45, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '8fdc3163-fea2-4ade-9af2-5ae8d06ec84c', 'win', 140.00, 96.00, 236.00, NULL, 'Game payout', '2026-05-16 00:16:31'),
(46, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '10ef72cc-930e-4d39-8283-31f612265bf2', 'bet', -1.00, 236.00, 235.00, NULL, 'Game bet placed', '2026-05-16 00:19:03'),
(47, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '35e111e7-a24d-4b8a-8aca-6b8155f8b42c', 'bet', -1.00, 235.00, 234.00, NULL, 'Game bet placed', '2026-05-16 00:19:26'),
(48, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'a25980c2-38d6-4ce7-9192-aaa364f9c331', 'bet', -1.00, 234.00, 233.00, NULL, 'Game bet placed', '2026-05-16 00:20:36'),
(49, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '118d5ba1-e11b-42d9-a4bf-8008ea59a601', 'bet', -1.00, 233.00, 232.00, NULL, 'Game bet placed', '2026-05-16 00:22:28'),
(50, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '5924f77c-9426-4f97-8b59-8612bd5b7378', 'bet', -1.00, 232.00, 231.00, NULL, 'Game bet placed', '2026-05-16 00:52:29'),
(51, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'e0715154-b495-4018-bed0-4863a4b30178', 'bet', -1.00, 231.00, 230.00, NULL, 'Game bet placed', '2026-05-16 00:52:33'),
(52, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '51855938-7e25-4ecb-ba67-bd0a54a330b6', 'bet', -1.00, 230.00, 229.00, NULL, 'Game bet placed', '2026-05-16 00:53:08'),
(53, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ad5990f3-32c6-4515-b15f-6bae2919b23a', 'bet', -1.00, 229.00, 228.00, NULL, 'Game bet placed', '2026-05-16 00:53:23'),
(54, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ad5990f3-32c6-4515-b15f-6bae2919b23a', 'win', 6.00, 228.00, 234.00, NULL, 'Game payout', '2026-05-16 00:53:32'),
(55, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '7eb368f0-4650-4799-815d-5164f0679667', 'bet', -0.50, 234.00, 233.50, NULL, 'Game bet placed', '2026-05-16 00:54:30'),
(56, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'a469cfef-5803-4fe7-940f-cc0426915618', 'bet', -0.50, 233.50, 233.00, NULL, 'Game bet placed', '2026-05-16 00:54:35'),
(57, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '698ceea5-5e1a-4cd7-994f-3148b6232029', 'bet', -1.00, 233.00, 232.00, NULL, 'Game bet placed', '2026-05-16 00:55:57'),
(58, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '181e8516-36e5-4644-8356-c78d568da98e', 'bet', -1.00, 232.00, 231.00, NULL, 'Game bet placed', '2026-05-16 01:13:37'),
(59, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '7bf2b04b-c61a-4cdf-aca3-2087b8376f6f', 'bet', -1.00, 231.00, 230.00, NULL, 'Game bet placed', '2026-05-16 01:14:01'),
(60, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'ada6e5e8-d98c-44dd-84ea-ec680a2118b8', 'bet', -1.00, 230.00, 229.00, NULL, 'Game bet placed', '2026-05-16 01:27:18'),
(61, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'd527fe50-d207-45b9-a007-cd5a89b7fc74', 'bet', -1.00, 229.00, 228.00, NULL, 'Game bet placed', '2026-05-16 01:28:41'),
(62, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, '3b461bfd-09d6-4147-95ee-a65ae6f668bf', 'bet', -1.00, 228.00, 227.00, NULL, 'Game bet placed', '2026-05-16 01:31:39'),
(63, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'd9717b04-2cec-4362-8839-67a01a8f262d', 'bet', -1.00, 227.00, 226.00, NULL, 'Game bet placed', '2026-05-16 01:31:46'),
(92, 'a0126999-6f42-4ffc-93c1-817662bcf900', 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, 'admin_credit_affiliate', 100.00, 0.00, 100.00, 'qtoa', 'Admin wallet adjustment', '2026-05-18 21:06:39'),
(93, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, NULL, 'deposit', 40.00, 226.00, 266.00, 'AkadPay webhook deposit confirmation', 'Deposit credited automatically from webhook', '2026-05-18 21:38:58'),
(94, 'a0126999-6f42-4ffc-93c1-817662bcf900', NULL, NULL, 'deposit', 20.00, 266.00, 286.00, 'AkadPay webhook deposit confirmation', 'Deposit credited automatically from webhook', '2026-05-18 21:50:12');

-- --------------------------------------------------------

--
-- Estrutura para tabela `webhook_logs`
--

CREATE TABLE `webhook_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `provider` varchar(40) NOT NULL,
  `event_type` varchar(120) DEFAULT NULL,
  `external_id` varchar(191) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `signature` varchar(255) DEFAULT NULL,
  `status_code` int(11) DEFAULT NULL,
  `processing_status` enum('received','processed','ignored','error') NOT NULL DEFAULT 'received',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `webhook_logs`
--

INSERT INTO `webhook_logs` (`id`, `provider`, `event_type`, `external_id`, `payload`, `signature`, `status_code`, `processing_status`, `created_at`) VALUES
(1, 'akadpay', 'PIX', '47c6ba85-fcb8-4129-a651-2aa1fa6f1e68', '{\"status\":\"paid\",\"idTransaction\":\"47c6ba85-fcb8-4129-a651-2aa1fa6f1e68\",\"typeTransaction\":\"PIX\"}', NULL, 401, 'error', '2026-05-15 18:43:03'),
(2, 'akadpay', 'PIX', '2785e37d-c100-41b1-b136-e7b7fd60846c', '{\"status\":\"paid\",\"idTransaction\":\"2785e37d-c100-41b1-b136-e7b7fd60846c\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'error', '2026-05-15 18:59:50'),
(3, 'akadpay', 'PIX', '2bce0bfc-bd7b-4e85-835d-46adafa3d01b', '{\"status\":\"paid\",\"idTransaction\":\"2bce0bfc-bd7b-4e85-835d-46adafa3d01b\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'error', '2026-05-15 19:13:47'),
(4, 'akadpay', 'PIX', '1a09b717-8789-4098-93fa-611de3187a06', '{\"webhook_payload\":{\"status\":\"paid\",\"idTransaction\":\"1a09b717-8789-4098-93fa-611de3187a06\",\"typeTransaction\":\"PIX\"},\"idTransaction\":\"1a09b717-8789-4098-93fa-611de3187a06\",\"typeTransaction\":\"PIX\",\"error_message\":\"SQLSTATE[HY093]: Invalid parameter number\",\"error_file\":\"\\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php\",\"error_line\":309,\"error_trace\":\"#0 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(309): PDOStatement->execute()\\n#1 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(59): payments_webhook_akadpay()\\n#2 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(91): {closure}()\\n#3 {main}\"}', NULL, 200, 'error', '2026-05-15 19:24:44'),
(5, 'akadpay', 'PIX', '9776acaa-7ca2-4580-b6d6-ec74c9af2c08', '{\"webhook_payload\":{\"status\":\"paid\",\"idTransaction\":\"9776acaa-7ca2-4580-b6d6-ec74c9af2c08\",\"typeTransaction\":\"PIX\"},\"idTransaction\":\"9776acaa-7ca2-4580-b6d6-ec74c9af2c08\",\"typeTransaction\":\"PIX\",\"error_message\":\"SQLSTATE[HY000]: General error: 1267 Illegal mix of collations (utf8mb4_general_ci,COERCIBLE) and (utf8mb4_unicode_ci,COERCIBLE) for operation \'<>\'\",\"error_file\":\"\\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php\",\"error_line\":309,\"error_trace\":\"#0 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(309): PDOStatement->execute()\\n#1 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(59): payments_webhook_akadpay()\\n#2 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(91): {closure}()\\n#3 {main}\"}', NULL, 200, 'error', '2026-05-15 19:44:21'),
(6, 'akadpay', 'PIX', '05394c94-e5d6-4531-b019-a4ae25c84de3', '{\"webhook_payload\":{\"status\":\"paid\",\"idTransaction\":\"05394c94-e5d6-4531-b019-a4ae25c84de3\",\"typeTransaction\":\"PIX\"},\"idTransaction\":\"05394c94-e5d6-4531-b019-a4ae25c84de3\",\"typeTransaction\":\"PIX\",\"error_message\":\"SQLSTATE[HY000]: General error: 1267 Illegal mix of collations (utf8mb4_general_ci,COERCIBLE) and (utf8mb4_unicode_ci,COERCIBLE) for operation \'nullif\'\",\"error_file\":\"\\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php\",\"error_line\":388,\"error_trace\":\"#0 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(388): PDOStatement->execute()\\n#1 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(59): payments_webhook_akadpay()\\n#2 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(91): {closure}()\\n#3 {main}\"}', NULL, 200, 'error', '2026-05-15 20:28:21'),
(7, 'akadpay', 'PIX', '3a874868-af4d-46b9-adf5-44d0d869a023', '{\"status\":\"paid\",\"idTransaction\":\"3a874868-af4d-46b9-adf5-44d0d869a023\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-15 20:38:06'),
(8, 'akadpay', 'affiliate_commission', '66cbf863-35a2-4860-9578-d7ba3e974c79', '{\"status\":\"ignored\",\"reason\":\"no_referrer\"}', NULL, 200, 'processed', '2026-05-15 20:38:06'),
(9, 'akadpay', 'PIX', '55734bea-f193-419d-b0e0-4c67ca941b9b', '{\"status\":\"paid\",\"idTransaction\":\"55734bea-f193-419d-b0e0-4c67ca941b9b\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 17:50:40'),
(10, 'akadpay', 'affiliate_commission_error', 'e0c992b5-13ec-490b-a768-4b741605f172', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 17:50:40'),
(11, 'akadpay', 'PIX', '8cc14473-a7cd-4757-bf5e-4af6253fd638', '{\"status\":\"paid\",\"idTransaction\":\"8cc14473-a7cd-4757-bf5e-4af6253fd638\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 17:53:33'),
(12, 'akadpay', 'affiliate_commission_error', '9593ece8-1d34-490f-bd40-483c537a3335', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 17:53:33'),
(13, 'akadpay', 'PIX', '7f2df1ff-51d9-4ccf-9b9c-cf633fd5c18e', '{\"status\":\"paid\",\"idTransaction\":\"7f2df1ff-51d9-4ccf-9b9c-cf633fd5c18e\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 21:26:08'),
(14, 'akadpay', 'affiliate_commission_error', '8c617de9-606a-4a15-ad82-1e318d043223', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 21:26:08'),
(15, 'akadpay', 'PIX', '61072c2b-c3ff-49c2-8369-6bd050fbc4d9', '{\"status\":\"paid\",\"idTransaction\":\"61072c2b-c3ff-49c2-8369-6bd050fbc4d9\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 21:28:51'),
(16, 'akadpay', 'affiliate_commission_error', 'e81fdb8e-e9e4-4c78-b201-807b9d2d72f4', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 21:28:51'),
(17, 'akadpay', 'PIX', '5bec3386-edb7-403f-96df-4e4231c72338', '{\"status\":\"paid\",\"idTransaction\":\"5bec3386-edb7-403f-96df-4e4231c72338\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:18:35'),
(18, 'akadpay', 'affiliate_commission_error', '9df323c6-734c-471b-bfb2-13fc6553c0e5', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:18:35'),
(19, 'akadpay', 'PIX', 'd593a69a-8d5e-43b4-ac9f-6185be2dd62b', '{\"status\":\"paid\",\"idTransaction\":\"d593a69a-8d5e-43b4-ac9f-6185be2dd62b\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:21:49'),
(20, 'akadpay', 'affiliate_commission_error', '9f4e1d2b-d895-4c25-8530-668b4e8953f1', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:21:49'),
(21, 'akadpay', 'PIX', 'f1e277d2-9e84-4319-85b1-3e7b69dadb83', '{\"status\":\"paid\",\"idTransaction\":\"f1e277d2-9e84-4319-85b1-3e7b69dadb83\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:23:16'),
(22, 'akadpay', 'affiliate_commission_error', '15ef494d-3bf6-4cbd-b064-384b39780a55', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:23:16'),
(23, 'akadpay', 'PIX', '55b877b6-dc1f-460a-a863-5117557de9f9', '{\"status\":\"paid\",\"idTransaction\":\"55b877b6-dc1f-460a-a863-5117557de9f9\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:30:45'),
(24, 'akadpay', 'affiliate_commission', '56b3211e-e082-4527-b63b-29905f25dd4c', '{\"status\":\"ignored\",\"reason\":\"first_deposit_only_rule\",\"paid_count\":2}', NULL, 200, 'processed', '2026-05-16 23:30:45'),
(25, 'akadpay', 'PIX', '7ce697cc-2c4a-4e6e-ac1d-27f4d745d2bb', '{\"status\":\"paid\",\"idTransaction\":\"7ce697cc-2c4a-4e6e-ac1d-27f4d745d2bb\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:33:54'),
(26, 'akadpay', 'affiliate_commission_error', '6e7205e8-1052-48c0-a599-9be67e8e06bd', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:33:54'),
(27, 'akadpay', 'PIX', 'a088171d-cf69-48f6-a29b-f63d1f7ce7cb', '{\"status\":\"paid\",\"idTransaction\":\"a088171d-cf69-48f6-a29b-f63d1f7ce7cb\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:36:18'),
(28, 'akadpay', 'affiliate_commission_error', '02fb35d0-4bd1-4bdf-8947-2ccbcaa1467d', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:36:18'),
(29, 'akadpay', 'PIX', '5b24cb70-34c6-40e8-9ce0-34b6c4d7294d', '{\"status\":\"paid\",\"idTransaction\":\"5b24cb70-34c6-40e8-9ce0-34b6c4d7294d\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:48:55'),
(30, 'akadpay', 'affiliate_commission_error', 'abd9ebff-36c2-472f-8ede-e73ef9c2ed8a', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:48:55'),
(31, 'akadpay', 'PIX', '01bd2328-ce07-47cc-9869-555ab393283f', '{\"status\":\"paid\",\"idTransaction\":\"01bd2328-ce07-47cc-9869-555ab393283f\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-16 23:50:06'),
(32, 'akadpay', 'affiliate_commission_error', 'd2617d64-bdcc-4717-a80c-448fa0f7aa27', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-16 23:50:06'),
(33, 'akadpay', 'PIX', '6db85237-9e87-40b6-99ad-bba0b39a0d7f', '{\"status\":\"paid\",\"idTransaction\":\"6db85237-9e87-40b6-99ad-bba0b39a0d7f\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 00:01:01'),
(34, 'akadpay', 'affiliate_commission', '2f38ab04-c957-4212-88dd-f0f284fad471', '{\"status\":\"ignored\",\"reason\":\"no_positive_commission\"}', NULL, 200, 'processed', '2026-05-17 00:01:01'),
(35, 'akadpay', 'PIX', 'fe6f9c26-3e27-4a6c-a04e-86e5f9b9fd2a', '{\"status\":\"paid\",\"idTransaction\":\"fe6f9c26-3e27-4a6c-a04e-86e5f9b9fd2a\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 00:41:24'),
(36, 'akadpay', 'affiliate_commission', '1fb4b7cc-5e21-4295-a7f0-740086f329a2', '{\"status\":\"ignored\",\"reason\":\"no_positive_commission\"}', NULL, 200, 'processed', '2026-05-17 00:41:24'),
(37, 'akadpay', 'PIX', 'aa410612-920d-426b-a126-6bde0ab77b89', '{\"status\":\"paid\",\"idTransaction\":\"aa410612-920d-426b-a126-6bde0ab77b89\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 00:52:38'),
(38, 'akadpay', 'affiliate_commission_error', '47c6f57c-bc75-4174-8e90-774d3b06ee27', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-17 00:52:38'),
(39, 'akadpay', 'PIX', 'bd6914e0-0e13-48ee-9e40-cd6c53358cf3', '{\"status\":\"paid\",\"idTransaction\":\"bd6914e0-0e13-48ee-9e40-cd6c53358cf3\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 00:57:43'),
(40, 'akadpay', 'affiliate_commission_error', '4e1c6500-74ab-4bc3-b1d0-1cab9c6a73f3', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-17 00:57:43'),
(41, 'akadpay', 'PIX', 'cde59df5-d85c-478b-99cb-6c1c6eeaa106', '{\"status\":\"paid\",\"idTransaction\":\"cde59df5-d85c-478b-99cb-6c1c6eeaa106\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:17:25'),
(42, 'akadpay', 'affiliate_commission_error', 'f15fdad0-b48b-4c5c-be99-dfcab16ae2a1', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-17 01:17:25'),
(43, 'akadpay', 'PIX', '6e66a134-5994-4bbe-a813-6312f1c67c84', '{\"status\":\"paid\",\"idTransaction\":\"6e66a134-5994-4bbe-a813-6312f1c67c84\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:19:25'),
(44, 'akadpay', 'affiliate_commission_error', '44f3d17d-9889-46a0-9f56-b1197cc1fe85', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-17 01:19:25'),
(45, 'akadpay', 'PIX', 'e65bec66-f6e0-4b6f-aca8-43469d4cb5b4', '{\"status\":\"paid\",\"idTransaction\":\"e65bec66-f6e0-4b6f-aca8-43469d4cb5b4\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:31:44'),
(46, 'akadpay', 'affiliate_commission_error', 'd200e3fd-df5f-49cc-b53b-1887b88b5bf8', '{\"error_message\":\"SQLSTATE[HY093]: Invalid parameter number\",\"error_file\":\"\\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php\",\"error_line\":675,\"error_trace\":\"#0 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(675): PDOStatement->execute()\\n#1 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(417): process_affiliate_commission_for_paid_deposit()\\n#2 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(59): payments_webhook_akadpay()\\n#3 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(91): {closure}()\\n#4 {main}\",\"deposit_id\":\"d200e3fd-df5f-49cc-b53b-1887b88b5bf8\",\"referred_user_id\":\"ea9fbc29-cb80-4116-8c9e-c454e8ab7609\"}', NULL, 200, 'error', '2026-05-17 01:31:44'),
(47, 'akadpay', 'PIX', '1d6d99d8-7149-46a0-a183-91c6e87af528', '{\"status\":\"paid\",\"idTransaction\":\"1d6d99d8-7149-46a0-a183-91c6e87af528\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:40:45'),
(48, 'akadpay', 'affiliate_commission_error', 'be138e55-275a-4484-bc57-31e99a733cad', '{\"message\":\"SQLSTATE[HY093]: Invalid parameter number\"}', NULL, 200, 'error', '2026-05-17 01:40:45'),
(49, 'akadpay', 'PIX', 'c6d6915a-5395-427c-9515-103d68891307', '{\"status\":\"paid\",\"idTransaction\":\"c6d6915a-5395-427c-9515-103d68891307\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:46:45'),
(50, 'akadpay', 'affiliate_commission_error', '1ecdf576-e4d0-43b2-bbc0-0325b046c868', '{\"error_message\":\"SQLSTATE[HY093]: Invalid parameter number\",\"error_file\":\"\\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php\",\"error_line\":675,\"error_trace\":\"#0 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(675): PDOStatement->execute()\\n#1 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/controllers\\/payments.php(417): process_affiliate_commission_for_paid_deposit()\\n#2 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(59): payments_webhook_akadpay()\\n#3 \\/home\\/u311589817\\/domains\\/pou-pou.fun\\/public_html\\/api\\/index.php(91): {closure}()\\n#4 {main}\",\"deposit_id\":\"1ecdf576-e4d0-43b2-bbc0-0325b046c868\",\"referred_user_id\":\"8a565f1a-37f1-4d70-93c0-c8bc6a7567bb\"}', NULL, 200, 'error', '2026-05-17 01:46:46'),
(51, 'akadpay', 'PIX', 'e358e16d-03f4-4f1a-a73c-8ee9036a3bdc', '{\"status\":\"paid\",\"idTransaction\":\"e358e16d-03f4-4f1a-a73c-8ee9036a3bdc\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:53:45'),
(52, 'akadpay', 'affiliate_commission', 'ef622408-c0eb-4f11-9ecf-35253af0c7cf', '{\"status\":\"paid\",\"deposit_id\":\"ef622408-c0eb-4f11-9ecf-35253af0c7cf\",\"items\":[{\"affiliate_user_id\":\"ea9fbc29-cb80-4116-8c9e-c454e8ab7609\",\"level\":1,\"percent\":50,\"amount\":6},{\"affiliate_user_id\":\"c869894b-f9af-4da0-b7a1-5a021cfba015\",\"level\":2,\"percent\":30,\"amount\":3.6}]}', NULL, 200, 'processed', '2026-05-17 01:53:45'),
(53, 'akadpay', 'PIX', '5e67f4ee-0364-472e-b855-e6d8fc274a25', '{\"status\":\"paid\",\"idTransaction\":\"5e67f4ee-0364-472e-b855-e6d8fc274a25\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-17 01:56:12'),
(54, 'akadpay', 'affiliate_commission', '778ce851-6119-4aa0-b670-06c86e148ef4', '{\"status\":\"paid\",\"deposit_id\":\"778ce851-6119-4aa0-b670-06c86e148ef4\",\"items\":[{\"affiliate_user_id\":\"ced0cbf1-e963-40e4-a158-2b28ddc54d33\",\"level\":1,\"percent\":50,\"amount\":5},{\"affiliate_user_id\":\"ea9fbc29-cb80-4116-8c9e-c454e8ab7609\",\"level\":2,\"percent\":30,\"amount\":3}]}', NULL, 200, 'processed', '2026-05-17 01:56:12'),
(55, 'akadpay', 'PIX', 'eaf715f2-4c54-4a04-91b9-01cd7923534b', '{\"status\":\"paid\",\"idTransaction\":\"eaf715f2-4c54-4a04-91b9-01cd7923534b\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-18 21:38:58'),
(56, 'akadpay', 'affiliate_commission', '4a8ac5b8-6474-4e5f-80f0-58de89574e31', '{\"status\":\"ignored\",\"reason\":\"no_referrer\"}', NULL, 200, 'processed', '2026-05-18 21:38:58'),
(57, 'akadpay', 'PIX', '484fcba9-3308-4374-ad8a-a25a3b335ff2', '{\"status\":\"paid\",\"idTransaction\":\"484fcba9-3308-4374-ad8a-a25a3b335ff2\",\"typeTransaction\":\"PIX\"}', NULL, 200, 'processed', '2026-05-18 21:50:12'),
(58, 'akadpay', 'affiliate_commission', 'f3045fc7-09b5-4f31-a2d6-f4715c724709', '{\"status\":\"ignored\",\"reason\":\"no_referrer\"}', NULL, 200, 'processed', '2026-05-18 21:50:12');

-- --------------------------------------------------------

--
-- Estrutura para tabela `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `wallet_type` enum('player','affiliate') NOT NULL DEFAULT 'player',
  `amount` decimal(12,2) NOT NULL,
  `fee_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','approved','processing','rejected','paid','canceled') NOT NULL DEFAULT 'pending',
  `admin_id` char(36) DEFAULT NULL,
  `external_id` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) DEFAULT NULL,
  `pix_key` varchar(190) DEFAULT NULL,
  `pix_key_type` varchar(40) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`response`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `processed_at` timestamp NULL DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_admin_logs_target_user` (`target_user_id`),
  ADD KEY `idx_admin_logs_admin_created` (`admin_user_id`,`created_at`),
  ADD KEY `idx_admin_logs_action_created` (`action`,`created_at`);

--
-- Índices de tabela `affiliate_commissions`
--
ALTER TABLE `affiliate_commissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_aff_comm_deposit_once` (`affiliate_user_id`,`referred_user_id`,`source_type`,`source_id`),
  ADD KEY `fk_aff_comm_ref_user` (`referred_user_id`),
  ADD KEY `idx_aff_comm_aff_created` (`affiliate_user_id`,`created_at`),
  ADD KEY `idx_aff_comm_status` (`status`);

--
-- Índices de tabela `akadpay_config`
--
ALTER TABLE `akadpay_config`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `onixpay_config`
--
ALTER TABLE `onixpay_config`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `auth_sessions`
--
ALTER TABLE `auth_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD KEY `idx_auth_sessions_user` (`user_id`),
  ADD KEY `idx_auth_sessions_active` (`revoked_at`,`last_activity`);

--
-- Índices de tabela `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banners_active_sort` (`is_active`,`sort_order`);

--
-- Índices de tabela `character_settings`
--
ALTER TABLE `character_settings`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `commission_settings`
--
ALTER TABLE `commission_settings`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_deposits_admin` (`admin_id`),
  ADD KEY `idx_deposits_user_created` (`user_id`,`created_at`),
  ADD KEY `idx_deposits_status` (`status`),
  ADD KEY `idx_deposits_transaction_id` (`transaction_id`),
  ADD KEY `idx_deposits_external_id` (`external_id`);

--
-- Índices de tabela `financial_settings`
--
ALTER TABLE `financial_settings`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `game_sessions`
--
ALTER TABLE `game_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_game_sessions_user_status` (`user_id`,`status`);

--
-- Índices de tabela `game_settings`
--
ALTER TABLE `game_settings`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `influencer_settings`
--
ALTER TABLE `influencer_settings`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `referral_code` (`referral_code`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_role` (`user_id`,`role`);

--
-- Índices de tabela `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Índices de tabela `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_wallet_tx_admin` (`admin_id`),
  ADD KEY `fk_wallet_tx_game` (`game_session_id`),
  ADD KEY `idx_wallet_tx_user_created` (`user_id`,`created_at`);

--
-- Índices de tabela `webhook_logs`
--
ALTER TABLE `webhook_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_webhook_provider_created` (`provider`,`created_at`),
  ADD KEY `idx_webhook_external_id` (`external_id`);

--
-- Índices de tabela `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_withdrawals_admin` (`admin_id`),
  ADD KEY `idx_withdrawals_user_created` (`user_id`,`created_at`),
  ADD KEY `idx_withdrawals_status` (`status`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=661;

--
-- AUTO_INCREMENT de tabela `affiliate_commissions`
--
ALTER TABLE `affiliate_commissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `auth_sessions`
--
ALTER TABLE `auth_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de tabela `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT de tabela `webhook_logs`
--
ALTER TABLE `webhook_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD CONSTRAINT `fk_admin_logs_admin_user` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_admin_logs_target_user` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `affiliate_commissions`
--
ALTER TABLE `affiliate_commissions`
  ADD CONSTRAINT `fk_aff_comm_aff_user` FOREIGN KEY (`affiliate_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_aff_comm_ref_user` FOREIGN KEY (`referred_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `auth_sessions`
--
ALTER TABLE `auth_sessions`
  ADD CONSTRAINT `fk_auth_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `fk_deposits_admin` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_deposits_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `game_sessions`
--
ALTER TABLE `game_sessions`
  ADD CONSTRAINT `fk_game_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `fk_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `fk_wallets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD CONSTRAINT `fk_wallet_tx_admin` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_wallet_tx_game` FOREIGN KEY (`game_session_id`) REFERENCES `game_sessions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_wallet_tx_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `fk_withdrawals_admin` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_withdrawals_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

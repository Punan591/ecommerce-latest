-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2021 at 07:57 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecom6`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `type`, `mobile`, `email`, `email_verified_at`, `password`, `image`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'SE Member', 'admin', '1230000000', 'admin@admin.com', NULL, '$2y$10$l0PdwaVyyGTr1cWZIhdWv.QaZJvdEFYR6zRZ6vmTWVkjPp/BeJSLu', '50547.png', 1, NULL, NULL, '2021-12-06 00:55:05');

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `image`, `link`, `title`, `alt`, `status`, `created_at`, `updated_at`) VALUES
(1, '1.jpg', 'NULL', 'Black Jacket', 'Black Jacket', 1, '2020-08-06 09:56:49', '2020-08-09 07:46:42'),
(2, '2.jpg', NULL, NULL, NULL, 1, '2020-08-06 09:57:06', '2020-08-09 07:46:43'),
(3, '3.jpg', NULL, 'Blue T-Shirt', 'Blue T-Shirt on discount', 1, '2020-08-06 09:57:17', '2020-08-09 07:46:44');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Gap', 1, '2020-07-02 08:45:52', '2020-07-02 09:00:29'),
(2, 'Lee', 1, '2020-07-02 08:49:32', '2020-07-02 08:59:47'),
(3, 'Monte Carlo', 1, '2020-07-02 08:53:21', '2020-07-05 06:16:08'),
(4, 'Arrow', 1, '2020-07-02 08:53:32', '2020-07-02 08:53:32');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `session_id`, `user_id`, `product_id`, `size`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 'smeX4AsuliCX9wzoAiS3gJM21oz0z5oX51Lda1ys', 7, 1, 'Medium', 1, '2020-11-17 09:55:19', '2020-11-17 09:56:38'),
(2, 'qFqmckNo240vbQD2woGIo1mXkCZwHKZ59DE6F1Ni', 13, 1, 'Medium', 2, '2020-12-05 21:39:48', '2020-12-05 21:46:44'),
(3, 'JdVKxho1dYTMU58N8ybfmE4GLwoR6onQbEJWDs9y', 0, 1, 'Large', 4, '2020-12-16 09:39:05', '2020-12-16 09:47:30'),
(5, 'gTSArsLvUHoUt6LbC6vNhx7G2KKZJHAXy7oi5aJq', 0, 1, 'Large', 1, '2020-12-19 21:59:32', '2020-12-19 21:59:32'),
(13, 'vWx87rhQPW4MErzMc2voXH7Rdsy7myRE2aIDwIwC', 0, 1, 'Medium', 2, '2021-01-14 09:47:30', '2021-01-14 09:47:30'),
(25, 'SNrXiHim33q6yzEMLZVfBy9rKrqFoJIyH6zey6X8', 0, 1, 'Large', 3, '2021-03-01 20:25:57', '2021-03-01 20:26:13'),
(26, 'SNrXiHim33q6yzEMLZVfBy9rKrqFoJIyH6zey6X8', 0, 2, 'Medium', 1, '2021-03-01 20:26:10', '2021-03-01 20:26:10'),
(28, '5HFkOSzg1MObIEjsdsIn8YYFPF8u6D5jThSp2pia', 1, 1, 'Large', 1, '2021-03-17 08:59:17', '2021-03-17 08:59:17'),
(29, '5HFkOSzg1MObIEjsdsIn8YYFPF8u6D5jThSp2pia', 1, 2, 'Medium', 2, '2021-03-17 08:59:24', '2021-03-17 08:59:29');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_discount` double(8,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `section_id`, `category_name`, `category_image`, `category_discount`, `description`, `url`, `meta_title`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 'T-Shirts', '70905.jpg', 20.00, 'T-Shirts is having lot of variety', 'tshirts', 'T-Shirts', 'T-Shirts is having lot of variety', 't-shirts, good quality', 1, '2020-04-05 03:17:17', '2020-08-13 09:52:39'),
(2, 0, 1, 'Shirts', '', 0.00, '', 'shirts', '', '', '', 1, '2020-04-05 03:25:46', '2020-08-13 09:14:45'),
(3, 0, 1, 'Denims', '', 0.00, '', 'denims', '', '', '', 1, '2020-04-05 03:26:55', '2020-07-25 09:23:49'),
(4, 1, 1, 'Casual T-Shirts', '', 0.00, 'This is the Casual T-Shirts Category having the variety of casual t-shirts of various brands.', 'casual-t-shirts', '', '', '', 1, '2020-04-30 11:09:53', '2020-10-08 09:53:54'),
(5, 0, 2, 'Denims', '', 0.00, '', 'denims-women', '', '', '', 1, '2020-05-09 22:30:55', '2020-05-09 22:30:55'),
(6, 0, 3, 'T-Shirts', '', 0.00, '', 'kids-tshirts', '', '', '', 1, '2020-07-21 09:23:07', '2020-07-25 09:22:38'),
(7, 1, 1, 'Formal T-shirts', '', 0.00, '', 'formal-t-shirts', '', '', '', 1, '2020-07-21 09:24:13', '2020-07-25 09:23:50'),
(9, 8, 1, 'testa', '', 0.00, '', 'testa', '', '', '', 1, '2020-07-30 08:22:02', '2020-07-30 08:22:02'),
(10, 8, 1, 'testb', '', 0.00, '', 'testb', '', '', '', 1, '2020-07-30 08:22:25', '2020-07-30 08:22:25');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(100) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_code`, `country_name`, `status`) VALUES
(1, 'AF', 'Afghanistan', 1),
(2, 'AL', 'Albania', 1),
(3, 'DZ', 'Algeria', 1),
(4, 'DS', 'American Samoa', 1),
(5, 'AD', 'Andorra', 1),
(6, 'AO', 'Angola', 1),
(7, 'AI', 'Anguilla', 1),
(8, 'AQ', 'Antarctica', 1),
(9, 'AG', 'Antigua and Barbuda', 1),
(10, 'AR', 'Argentina', 1),
(11, 'AM', 'Armenia', 1),
(12, 'AW', 'Aruba', 1),
(13, 'AU', 'Australia', 1),
(14, 'AT', 'Austria', 1),
(15, 'AZ', 'Azerbaijan', 1),
(16, 'BS', 'Bahamas', 1),
(17, 'BH', 'Bahrain', 1),
(18, 'BD', 'Bangladesh', 1),
(19, 'BB', 'Barbados', 1),
(20, 'BY', 'Belarus', 1),
(21, 'BE', 'Belgium', 1),
(22, 'BZ', 'Belize', 1),
(23, 'BJ', 'Benin', 1),
(24, 'BM', 'Bermuda', 1),
(25, 'BT', 'Bhutan', 1),
(26, 'BO', 'Bolivia', 1),
(27, 'BA', 'Bosnia and Herzegovina', 1),
(28, 'BW', 'Botswana', 1),
(29, 'BV', 'Bouvet Island', 1),
(30, 'BR', 'Brazil', 1),
(31, 'IO', 'British Indian Ocean Territory', 1),
(32, 'BN', 'Brunei Darussalam', 1),
(33, 'BG', 'Bulgaria', 1),
(34, 'BF', 'Burkina Faso', 1),
(35, 'BI', 'Burundi', 1),
(36, 'KH', 'Cambodia', 1),
(37, 'CM', 'Cameroon', 1),
(38, 'CA', 'Canada', 1),
(39, 'CV', 'Cape Verde', 1),
(40, 'KY', 'Cayman Islands', 1),
(41, 'CF', 'Central African Republic', 1),
(42, 'TD', 'Chad', 1),
(43, 'CL', 'Chile', 1),
(44, 'CN', 'China', 1),
(45, 'CX', 'Christmas Island', 1),
(46, 'CC', 'Cocos (Keeling) Islands', 1),
(47, 'CO', 'Colombia', 1),
(48, 'KM', 'Comoros', 1),
(49, 'CD', 'Democratic Republic of the Congo', 1),
(50, 'CG', 'Republic of Congo', 1),
(51, 'CK', 'Cook Islands', 1),
(52, 'CR', 'Costa Rica', 1),
(53, 'HR', 'Croatia (Hrvatska)', 1),
(54, 'CU', 'Cuba', 1),
(55, 'CY', 'Cyprus', 1),
(56, 'CZ', 'Czech Republic', 1),
(57, 'DK', 'Denmark', 1),
(58, 'DJ', 'Djibouti', 1),
(59, 'DM', 'Dominica', 1),
(60, 'DO', 'Dominican Republic', 1),
(61, 'TP', 'East Timor', 1),
(62, 'EC', 'Ecuador', 1),
(63, 'EG', 'Egypt', 1),
(64, 'SV', 'El Salvador', 1),
(65, 'GQ', 'Equatorial Guinea', 1),
(66, 'ER', 'Eritrea', 1),
(67, 'EE', 'Estonia', 1),
(68, 'ET', 'Ethiopia', 1),
(69, 'FK', 'Falkland Islands (Malvinas)', 1),
(70, 'FO', 'Faroe Islands', 1),
(71, 'FJ', 'Fiji', 1),
(72, 'FI', 'Finland', 1),
(73, 'FR', 'France', 1),
(74, 'FX', 'France, Metropolitan', 1),
(75, 'GF', 'French Guiana', 1),
(76, 'PF', 'French Polynesia', 1),
(77, 'TF', 'French Southern Territories', 1),
(78, 'GA', 'Gabon', 1),
(79, 'GM', 'Gambia', 1),
(80, 'GE', 'Georgia', 1),
(81, 'DE', 'Germany', 1),
(82, 'GH', 'Ghana', 1),
(83, 'GI', 'Gibraltar', 1),
(84, 'GK', 'Guernsey', 1),
(85, 'GR', 'Greece', 1),
(86, 'GL', 'Greenland', 1),
(87, 'GD', 'Grenada', 1),
(88, 'GP', 'Guadeloupe', 1),
(89, 'GU', 'Guam', 1),
(90, 'GT', 'Guatemala', 1),
(91, 'GN', 'Guinea', 1),
(92, 'GW', 'Guinea-Bissau', 1),
(93, 'GY', 'Guyana', 1),
(94, 'HT', 'Haiti', 1),
(95, 'HM', 'Heard and Mc Donald Islands', 1),
(96, 'HN', 'Honduras', 1),
(97, 'HK', 'Hong Kong', 1),
(98, 'HU', 'Hungary', 1),
(99, 'IS', 'Iceland', 1),
(100, 'IN', 'India', 1),
(101, 'IM', 'Isle of Man', 1),
(102, 'ID', 'Indonesia', 1),
(103, 'IR', 'Iran (Islamic Republic of)', 1),
(104, 'IQ', 'Iraq', 1),
(105, 'IE', 'Ireland', 1),
(106, 'IL', 'Israel', 1),
(107, 'IT', 'Italy', 1),
(108, 'CI', 'Ivory Coast', 1),
(109, 'JE', 'Jersey', 1),
(110, 'JM', 'Jamaica', 1),
(111, 'JP', 'Japan', 1),
(112, 'JO', 'Jordan', 1),
(113, 'KZ', 'Kazakhstan', 1),
(114, 'KE', 'Kenya', 1),
(115, 'KI', 'Kiribati', 1),
(116, 'KP', 'Korea, Democratic People\'s Republic of', 1),
(117, 'KR', 'Korea, Republic of', 1),
(118, 'XK', 'Kosovo', 1),
(119, 'KW', 'Kuwait', 1),
(120, 'KG', 'Kyrgyzstan', 1),
(121, 'LA', 'Lao People\'s Democratic Republic', 1),
(122, 'LV', 'Latvia', 1),
(123, 'LB', 'Lebanon', 1),
(124, 'LS', 'Lesotho', 1),
(125, 'LR', 'Liberia', 1),
(126, 'LY', 'Libyan Arab Jamahiriya', 1),
(127, 'LI', 'Liechtenstein', 1),
(128, 'LT', 'Lithuania', 1),
(129, 'LU', 'Luxembourg', 1),
(130, 'MO', 'Macau', 1),
(131, 'MK', 'North Macedonia', 1),
(132, 'MG', 'Madagascar', 1),
(133, 'MW', 'Malawi', 1),
(134, 'MY', 'Malaysia', 1),
(135, 'MV', 'Maldives', 1),
(136, 'ML', 'Mali', 1),
(137, 'MT', 'Malta', 1),
(138, 'MH', 'Marshall Islands', 1),
(139, 'MQ', 'Martinique', 1),
(140, 'MR', 'Mauritania', 1),
(141, 'MU', 'Mauritius', 1),
(142, 'TY', 'Mayotte', 1),
(143, 'MX', 'Mexico', 1),
(144, 'FM', 'Micronesia, Federated States of', 1),
(145, 'MD', 'Moldova, Republic of', 1),
(146, 'MC', 'Monaco', 1),
(147, 'MN', 'Mongolia', 1),
(148, 'ME', 'Montenegro', 1),
(149, 'MS', 'Montserrat', 1),
(150, 'MA', 'Morocco', 1),
(151, 'MZ', 'Mozambique', 1),
(152, 'MM', 'Myanmar', 1),
(153, 'NA', 'Namibia', 1),
(154, 'NR', 'Nauru', 1),
(155, 'NP', 'Nepal', 1),
(156, 'NL', 'Netherlands', 1),
(157, 'AN', 'Netherlands Antilles', 1),
(158, 'NC', 'New Caledonia', 1),
(159, 'NZ', 'New Zealand', 1),
(160, 'NI', 'Nicaragua', 1),
(161, 'NE', 'Niger', 1),
(162, 'NG', 'Nigeria', 1),
(163, 'NU', 'Niue', 1),
(164, 'NF', 'Norfolk Island', 1),
(165, 'MP', 'Northern Mariana Islands', 1),
(166, 'NO', 'Norway', 1),
(167, 'OM', 'Oman', 1),
(168, 'PK', 'Pakistan', 1),
(169, 'PW', 'Palau', 1),
(170, 'PS', 'Palestine', 1),
(171, 'PA', 'Panama', 1),
(172, 'PG', 'Papua New Guinea', 1),
(173, 'PY', 'Paraguay', 1),
(174, 'PE', 'Peru', 1),
(175, 'PH', 'Philippines', 1),
(176, 'PN', 'Pitcairn', 1),
(177, 'PL', 'Poland', 1),
(178, 'PT', 'Portugal', 1),
(179, 'PR', 'Puerto Rico', 1),
(180, 'QA', 'Qatar', 1),
(181, 'RE', 'Reunion', 1),
(182, 'RO', 'Romania', 1),
(183, 'RU', 'Russian Federation', 1),
(184, 'RW', 'Rwanda', 1),
(185, 'KN', 'Saint Kitts and Nevis', 1),
(186, 'LC', 'Saint Lucia', 1),
(187, 'VC', 'Saint Vincent and the Grenadines', 1),
(188, 'WS', 'Samoa', 1),
(189, 'SM', 'San Marino', 1),
(190, 'ST', 'Sao Tome and Principe', 1),
(191, 'SA', 'Saudi Arabia', 1),
(192, 'SN', 'Senegal', 1),
(193, 'RS', 'Serbia', 1),
(194, 'SC', 'Seychelles', 1),
(195, 'SL', 'Sierra Leone', 1),
(196, 'SG', 'Singapore', 1),
(197, 'SK', 'Slovakia', 1),
(198, 'SI', 'Slovenia', 1),
(199, 'SB', 'Solomon Islands', 1),
(200, 'SO', 'Somalia', 1),
(201, 'ZA', 'South Africa', 1),
(202, 'GS', 'South Georgia South Sandwich Islands', 1),
(203, 'SS', 'South Sudan', 1),
(204, 'ES', 'Spain', 1),
(205, 'LK', 'Sri Lanka', 1),
(206, 'SH', 'St. Helena', 1),
(207, 'PM', 'St. Pierre and Miquelon', 1),
(208, 'SD', 'Sudan', 1),
(209, 'SR', 'Suriname', 1),
(210, 'SJ', 'Svalbard and Jan Mayen Islands', 1),
(211, 'SZ', 'Swaziland', 1),
(212, 'SE', 'Sweden', 1),
(213, 'CH', 'Switzerland', 1),
(214, 'SY', 'Syrian Arab Republic', 1),
(215, 'TW', 'Taiwan', 1),
(216, 'TJ', 'Tajikistan', 1),
(217, 'TZ', 'Tanzania, United Republic of', 1),
(218, 'TH', 'Thailand', 1),
(219, 'TG', 'Togo', 1),
(220, 'TK', 'Tokelau', 1),
(221, 'TO', 'Tonga', 1),
(222, 'TT', 'Trinidad and Tobago', 1),
(223, 'TN', 'Tunisia', 1),
(224, 'TR', 'Turkey', 1),
(225, 'TM', 'Turkmenistan', 1),
(226, 'TC', 'Turks and Caicos Islands', 1),
(227, 'TV', 'Tuvalu', 1),
(228, 'UG', 'Uganda', 1),
(229, 'UA', 'Ukraine', 1),
(230, 'AE', 'United Arab Emirates', 1),
(231, 'GB', 'United Kingdom', 1),
(232, 'US', 'United States', 1),
(233, 'UM', 'United States minor outlying islands', 1),
(234, 'UY', 'Uruguay', 1),
(235, 'UZ', 'Uzbekistan', 1),
(236, 'VU', 'Vanuatu', 1),
(237, 'VA', 'Vatican City State', 1),
(238, 'VE', 'Venezuela', 1),
(239, 'VN', 'Vietnam', 1),
(240, 'VG', 'Virgin Islands (British)', 1),
(241, 'VI', 'Virgin Islands (U.S.)', 1),
(242, 'WF', 'Wallis and Futuna Islands', 1),
(243, 'EH', 'Western Sahara', 1),
(244, 'YE', 'Yemen', 1),
(245, 'ZM', 'Zambia', 1),
(246, 'ZW', 'Zimbabwe', 1);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_02_16_103242_create_admins_table', 2),
(5, '2020_03_19_164829_create_sections_table', 3),
(6, '2020_04_05_064412_create_categories_table', 4),
(7, '2020_04_30_161949_create_products_table', 5),
(8, '2020_05_29_021158_create_products_attributes_table', 6),
(9, '2020_06_19_142017_create_products_images_table', 7),
(10, '2020_06_28_125628_create_brands_table', 8),
(11, '2020_07_05_113748_add_column_to_products', 9),
(12, '2020_08_03_120709_create_banners_table', 10),
(13, '2020_09_24_124906_create_carts_table', 11),
(15, '2020_11_08_032234_add_columns_to_users_table', 12),
(16, '2020_12_20_033905_create_coupons_table', 13),
(17, '2021_01_16_142144_create_delivery_addresses_table', 14),
(18, '2021_01_31_035657_create_orders_table', 15),
(19, '2021_01_31_040129_create_orders_products_table', 16),
(20, '2021_02_18_144535_create_order_statuses_table', 17),
(21, '2021_03_04_135909_create_orders_logs_table', 18),
(22, '2021_03_06_135124_update_orders_table', 19);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_price` double(8,2) NOT NULL,
  `product_discount` double(8,2) DEFAULT 0.00,
  `product_weight` double(8,2) DEFAULT NULL,
  `product_video` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `main_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wash_care` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fabric` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pattern` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sleeve` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occasion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` enum('No','Yes') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `section_id`, `brand_id`, `product_name`, `product_code`, `product_color`, `product_price`, `product_discount`, `product_weight`, `product_video`, `main_image`, `description`, `wash_care`, `fabric`, `pattern`, `sleeve`, `fit`, `occasion`, `meta_title`, `meta_description`, `meta_keywords`, `is_featured`, `status`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 4, 'Blue Casual T-shirt', 'BT001', 'Blue', 500.00, 10.00, NULL, '', '8.jpg', 'This is the cotton Blue Casual T-Shirt for every person. You can wear in summers and feel good.', NULL, 'Cotton', NULL, 'Half Sleeve', 'Slim', NULL, NULL, NULL, NULL, 'Yes', 1, '2020-05-13 09:23:42', '2020-10-08 09:54:24'),
(2, 4, 1, 1, 'Red Casual Tshirt', 'RC001', 'Red', 500.00, 15.00, NULL, '', '7.jpg', NULL, NULL, 'Cotton', 'Plain', 'Half Sleeve', 'Slim', 'Casual', NULL, NULL, NULL, 'Yes', 1, '2020-05-16 22:27:58', '2020-10-11 06:08:42'),
(3, 4, 1, 2, 'Red Casual Tshirt', 'Red101', 'Red', 1500.00, 0.00, NULL, 'SampleVideo_640x360_1mb.mp4-1163624454.mp4', '6.jpg', NULL, NULL, 'Polyester', 'Checked', 'Full Sleeve', 'Regular', 'Formal', NULL, NULL, NULL, 'Yes', 1, '2020-05-16 22:37:47', '2020-10-08 09:33:10'),
(4, 4, 1, 2, 'Black Casual T-Shirt', 'BL0001', 'Black', 1500.00, NULL, NULL, '', '5.jpg', NULL, NULL, 'Polyester', 'Printed', 'Half Sleeve', 'Regular', 'Casual', 'test title', 'test desc', 'test keywords', 'Yes', 1, '2020-05-20 08:51:34', '2020-09-05 08:59:52'),
(5, 4, 1, 1, 'Purple Casual T-Shirt', 'PCT001', 'Purple', 300.00, 0.00, NULL, '', '1.jpg', 'test product', NULL, 'Cotton', 'Plain', 'Half Sleeve', 'Regular', 'Casual', NULL, NULL, NULL, 'Yes', 1, '2020-07-05 06:28:25', '2020-10-11 06:32:31'),
(6, 4, 1, 3, 'MC Casual Tshirt', 'MCT001', 'Blue', 1000.00, NULL, NULL, '', '3.jpg', NULL, NULL, 'Cotton', 'Plain', 'Half Sleeve', 'Regular', 'Casual', NULL, NULL, NULL, 'Yes', 1, '2020-07-30 08:34:44', '2020-09-05 09:00:37'),
(7, 7, 1, 1, 'Blue Formal T-shirt', 'BDT001', 'Blue', 1500.00, NULL, NULL, '', '2.jpg', NULL, NULL, 'Wool', 'Self', 'Full Sleeve', 'Regular', 'Formal', NULL, NULL, NULL, 'No', 1, '2020-08-13 09:39:15', '2020-09-05 09:01:00'),
(8, 9, 1, 1, 'testa pro', 'testapro', 'red', 1000.00, NULL, NULL, '', '4.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 1, '2020-10-04 21:13:26', '2020-10-04 21:13:26');

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes`
--

CREATE TABLE `products_attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_attributes`
--

INSERT INTO `products_attributes` (`id`, `product_id`, `size`, `price`, `stock`, `sku`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Small', 500.00, 10, 'BTS001-S', 0, '2020-06-05 09:24:45', '2020-10-08 09:07:32'),
(2, 1, 'Medium', 600.00, 20, 'BTS001-M', 1, '2020-06-05 09:24:45', '2020-10-08 09:07:32'),
(5, 4, 'Small', 1500.00, 10, 'BL0001-S', 0, '2020-06-09 09:13:27', '2020-06-09 09:13:27'),
(6, 4, 'Medium', 1600.00, 10, 'BL0001-M', 0, '2020-06-09 09:13:27', '2020-06-09 09:13:27'),
(7, 4, 'Large', 1700.00, 10, 'BL0002-L', 0, '2020-06-09 09:13:27', '2020-06-09 09:13:27'),
(8, 1, 'Large', 700.00, 10, 'BTS001-L', 1, '2020-06-16 09:12:17', '2020-10-08 09:07:32'),
(9, 5, 'Small', 1000.00, 10, 'PCT001-S', 1, '2020-10-02 08:11:22', '2020-10-02 08:11:22'),
(10, 5, 'Medium', 1100.00, 10, 'PCT001-M', 1, '2020-10-02 08:11:22', '2020-10-02 08:11:22'),
(11, 2, 'Small', 500.00, 5, 'RC001-S', 1, '2020-10-02 08:58:45', '2020-10-02 08:58:45'),
(12, 2, 'Medium', 600.00, 10, 'RC001-M', 1, '2020-10-02 08:58:45', '2020-10-02 08:58:45');

-- --------------------------------------------------------

--
-- Table structure for table `products_images`
--

CREATE TABLE `products_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_images`
--

INSERT INTO `products_images` (`id`, `product_id`, `image`, `status`, `created_at`, `updated_at`) VALUES
(5, 1, '9.jpg', 1, '2020-06-26 09:21:54', '2020-06-26 09:21:54'),
(6, 1, '10.jpg', 1, '2020-06-26 09:21:54', '2020-06-26 09:21:54');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Men', 1, NULL, '2020-07-25 09:21:34'),
(2, 'Women', 1, NULL, '2020-07-25 09:21:36'),
(3, 'Kids', 1, NULL, '2020-07-25 09:21:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pincode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`(191));

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products_attributes`
--
ALTER TABLE `products_attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products_images`
--
ALTER TABLE `products_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products_attributes`
--
ALTER TABLE `products_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products_images`
--
ALTER TABLE `products_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

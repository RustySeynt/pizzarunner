-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2023 at 01:55 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_runner`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `most_ordered_pizza_in_a_day` (IN `p_OrderDate` DATE)   BEGIN
    SELECT p.pizza_name, COUNT(cu.order_id) as 'num_of_pizzas_ordered'
    FROM pizza_names p
    JOIN customer_orders cu
    ON p.pizza_id = cu.pizza_id
    WHERE DATE(cu.order_date) = p_OrderDate
    GROUP BY p.pizza_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `number_of_customer_orders` ()   BEGIN
	SELECT DISTINCT customer_id, COUNT(DISTINCT order_id) AS 'num_of_orders', exclusions, extras, order_date
FROM customer_orders
GROUP BY customer_id
ORDER BY num_of_orders;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_customer_orders_in_a_day` (IN `p_OrderDate` DATE)   BEGIN

SELECT DATE(order_date) as 'order_date', COUNT(order_id) as 'num_of_orders'
FROM customer_orders
WHERE DATE(order_date) = p_OrderDate;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_customer_orders_per_day` ()   BEGIN 

SELECT DISTINCT DATE(order_date) as 'order_date', COUNT(order_id) as 'num_of_orders'
FROM customer_orders
GROUP BY DATE(order_date);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `email` varchar(30) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `email`, `address`, `created_at`) VALUES
(1, 'admin123', 'admin123', 'admin@email.com', 'adminAddressUniversal', '2023-06-07 03:24:03');

-- --------------------------------------------------------

--
-- Table structure for table `audit_table`
--

CREATE TABLE `audit_table` (
  `order_id` int(11) DEFAULT NULL,
  `runner_id` int(11) DEFAULT NULL,
  `time_cancellation` time DEFAULT NULL,
  `date_of_cancellation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_table`
--

INSERT INTO `audit_table` (`order_id`, `runner_id`, `time_cancellation`, `date_of_cancellation`) VALUES
(6, 3, '11:07:50', '2023-06-02');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(25) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `registration_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `registration_date`) VALUES
(1, 'Marc', 'Flipsen', 'mflipsen0@tinyurl.com', 'atguhwhikUD773Kns+', '184-465-9080', '121.31.19.174', 'Labuhankananga', NULL, NULL, 'Indonesia', '2023-06-12 14:20:20'),
(2, 'Flin', 'Dessent', 'fdessent1@hugedomains.com', 'ukgntqgylZO935`cw(ue)nL\"Y', '486-917-1316', '3.246.123.179', 'Paris 13', 'Île-de-France', '75638 CEDEX 13', 'France', '2023-06-12 14:20:20'),
(3, 'Hailee', 'Joslow', 'hjoslow2@drupal.org', 'huqxkcsxoWR2629KoFqjzJe8}', '692-647-2879', '104.137.42.113', 'Fortaleza', NULL, '60000-000', 'Brazil', '2023-06-12 14:20:20'),
(4, 'Aindrea', 'Lunnon', 'alunnon3@moonfruit.com', 'csesstzbxBQ951QKdZ', '654-334-0178', '37.244.7.48', 'Geshan', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(5, 'Vassili', 'Ludmann', 'vludmann4@google.co.uk', 'vxneyxucnLI547okD', '780-195-8957', '124.210.87.54', 'Mesopotam', NULL, NULL, 'Albania', '2023-06-12 14:20:20'),
(6, 'Jennie', 'Winspire', 'jwinspire5@state.gov', 'zxjabdozfAM221Hc4!3a5su', '189-742-6922', '245.130.120.105', 'Kultayevo', NULL, '614520', 'Russia', '2023-06-12 14:20:20'),
(7, 'Kevina', 'Enticknap', 'kenticknap6@intel.com', 'lzdhnhtwkWX571XoQ_T8Luq$%', '444-970-9489', '169.143.134.225', 'Unanu', NULL, NULL, 'Micronesia', '2023-06-12 14:20:20'),
(8, 'Cortie', 'Snoden', 'csnoden7@bandcamp.com', 'xrhtslacvDG619\"%Y%5VPGuBD', '167-272-4049', '107.42.118.115', 'Yangji', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(9, 'Rhetta', 'Kettles', 'rkettles8@oakley.com', 'tcbjvsiveEZ512wJM8A(=V>!N', '579-551-0975', '37.74.154.250', 'Chadi', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(10, 'Darren', 'O\'Corrigane', 'docorrigane9@canalblog.com', 'fbvansqnaGY134O72Db6uGYA', '269-871-1246', '33.108.145.176', 'Khoroshëvo-Mnevniki', NULL, '676280', 'Russia', '2023-06-12 14:20:20'),
(11, 'Morgan', 'Amphlett', 'mamphletta@google.fr', 'fiudxvuvjKD892/!/pu5', '600-738-0795', '131.225.106.48', 'Kolomyagi', NULL, '198264', 'Russia', '2023-06-12 14:20:20'),
(12, 'Katti', 'Rainforth', 'krainforthb@mac.com', 'drstpqpkjWA0767', '200-393-5672', '141.3.222.201', 'Drayton Valley', 'Alberta', 'T7A', 'Canada', '2023-06-12 14:20:20'),
(13, 'Eugenia', 'Saint', 'esaintc@g.co', 'fucfneeiiQM7897$i.2<DN', '950-277-4588', '21.36.14.175', 'Bordeaux', 'Aquitaine', '33100', 'France', '2023-06-12 14:20:20'),
(14, 'Fielding', 'Haye', 'fhayed@geocities.com', 'tnlekyjwyLO206842NBC+IT', '461-561-2023', '109.178.46.214', 'Huaikan', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(15, 'Alanna', 'Fomichkin', 'afomichkine@howstuffworks.com', 'fxqhbvtofOO4146_1/c4qgRi8', '585-337-3440', '6.212.60.9', 'Rochester', 'New York', '14604', 'United States', '2023-06-12 14:20:20'),
(16, 'Alejoa', 'Falco', 'afalcof@pcworld.com', 'kltejvquhSP3390am_Qw#lx', '921-823-1331', '28.194.158.81', 'Vorontsovka', NULL, '353664', 'Russia', '2023-06-12 14:20:20'),
(17, 'Edyth', 'Lindmark', 'elindmarkg@google.it', 'wjadrkihoOR486`!', '300-486-1063', '62.70.14.199', 'Ansheng', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(18, 'Ingrim', 'Cockitt', 'icockitth@blogspot.com', 'jgoxovgtiFE151(m#7', '366-905-3238', '60.157.155.234', 'Tanshan', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(19, 'Vi', 'Carneck', 'vcarnecki@utexas.edu', 'soodqqymyKV136li|zr', '792-776-5075', '92.158.155.127', 'Concordia', NULL, '3200', 'Argentina', '2023-06-12 14:20:20'),
(20, 'Gray', 'Tafani', 'gtafanij@virginia.edu', 'zfriybvpqWA7324Pt1wqx9u_9', '155-508-3283', '152.220.116.225', 'Norrköping', 'Östergötland', '602 34', 'Sweden', '2023-06-12 14:20:20'),
(21, 'Elizabet', 'Keaton', 'ekeatonk@hugedomains.com', 'llicsdknyDH291~n#_P!~%\'Jk', '319-189-1446', '10.148.110.33', 'Kamieniec Ząbkowicki', NULL, '57-230', 'Poland', '2023-06-12 14:20:20'),
(29, 'Liam', 'Klagge', 'lklagges@myspace.com', 'sscfyzryvSB407vN1cgQ#JV3', '408-663-7605', '205.147.240.236', 'Niitsu-honchō', NULL, '959-1855', 'Japan', '2023-06-12 14:20:20'),
(30, 'Kane', 'Brisland', 'kbrislandt@bloglines.com', 'yatuxltizDI084UyBry', '961-416-4601', '41.198.185.236', 'Vitória de Santo Antão', NULL, '55600-000', 'Brazil', '2023-06-12 14:20:20'),
(31, 'Jameson', 'Zouch', 'jzouchu@utexas.edu', 'qiojwemcqWA945IyI{S4~B', '633-634-9399', '231.29.140.15', 'Kanzaki', NULL, '842-0001', 'Japan', '2023-06-12 14:20:20'),
(32, 'Ronalda', 'McLagain', 'rmclagainv@msn.com', 'bqukdkxpiOB8323laky=B9~o', '179-781-9954', '118.215.137.58', 'Infanta', NULL, '4336', 'Philippines', '2023-06-12 14:20:20'),
(33, 'Aprilette', 'Hekkert', 'ahekkertw@slashdot.org', 'tsieyrukuZS454o<CFjZ_,,\'', '381-942-6979', '138.243.247.53', 'Daxin', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(34, 'Darby', 'Morling', 'dmorlingx@quantcast.com', 'enuwzpjncPQ7071D0RKVHO', '542-262-5944', '222.37.46.217', 'Sanchang', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(35, 'Katharyn', 'Flanagan', 'kflanagany@histats.com', 'cwnzbvkexRA546E`u', '560-783-7163', '161.162.88.24', 'Wangmo', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(36, 'Ganny', 'Kernermann', 'gkernermannz@storify.com', 'hcuueysjnQC068fNa07g', '108-732-3555', '133.233.253.217', 'Letovice', NULL, '679 61', 'Czech Republic', '2023-06-12 14:20:20'),
(37, 'Guy', 'Swaby', 'gswaby10@discovery.com', 'rzrrkrocyJL570agn', '433-322-8647', '118.135.58.228', 'Jingxiyuan', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(38, 'Wyn', 'Carous', 'wcarous11@ehow.com', 'ffyxtamnrQE861F8csc0Yl', '549-434-6944', '64.254.183.31', 'Kétou', NULL, NULL, 'Benin', '2023-06-12 14:20:20'),
(39, 'Danni', 'Bellson', 'dbellson12@shutterfly.com', 'zahnuvuudEN887sLkvlDp+', '176-195-8784', '11.7.75.59', 'Rengasdengklok', NULL, NULL, 'Indonesia', '2023-06-12 14:20:20'),
(40, 'Ula', 'Leile', 'uleile13@xinhuanet.com', 'yhmjutssnRT377{py7|=t#', '398-808-5712', '95.119.128.42', 'Shenshu', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(41, 'Bridgette', 'Gaw', 'bgaw14@ed.gov', 'drljfksaeEY339tn\"#c9QM(lD', '799-687-0230', '152.224.195.155', 'La Paz Centro', NULL, NULL, 'Nicaragua', '2023-06-12 14:20:20'),
(42, 'Adrea', 'Jammet', 'ajammet15@thetimes.co.uk', 'roagaqnrrKR957BA}6', '674-550-3352', '129.51.110.85', 'Santos Evos', 'Viseu', '3505-318', 'Portugal', '2023-06-12 14:20:20'),
(43, 'Brody', 'Demoge', 'bdemoge16@wired.com', 'lpfxyochvRQ026pjQ8\",*QOLh', '850-634-7558', '157.2.29.188', 'La Cumbre', NULL, '760518', 'Colombia', '2023-06-12 14:20:20'),
(44, 'Creighton', 'Kunisch', 'ckunisch17@nydailynews.com', 'cdsgurgeyFR5739TTL', '155-145-7287', '218.51.235.46', 'Safonovo', NULL, '308510', 'Russia', '2023-06-12 14:20:20'),
(45, 'Alano', 'Miliffe', 'amiliffe18@phpbb.com', 'rnduckyulRG937HsP$MfBBGh', '345-712-2674', '167.8.141.92', 'Gracias', NULL, NULL, 'Honduras', '2023-06-12 14:20:20'),
(46, 'Kora', 'Pedlow', 'kpedlow19@blog.com', 'zroxfgicrFV432Qm=xOD~xw_', '231-526-2736', '11.66.60.137', 'Stavanger', 'Rogaland', '4025', 'Norway', '2023-06-12 14:20:20'),
(47, 'Alleen', 'Mayze', 'amayze1a@spiegel.de', 'yxdunsvxzZE569+WvNY=`q>%G', '223-374-8716', '218.213.214.186', 'Zernograd', NULL, '347743', 'Russia', '2023-06-12 14:20:20'),
(48, 'Kattie', 'Mouat', 'kmouat1b@utexas.edu', 'sutzuqaczCZ194m6tor&agSVY', '274-616-8060', '18.110.107.181', 'Kemiri', NULL, NULL, 'Indonesia', '2023-06-12 14:20:20'),
(49, 'Angil', 'Tomsen', 'atomsen1c@youtube.com', 'sopoxxgkrUO115h8O}nIY~m4p', '201-102-5576', '62.176.94.196', 'Zhaoqing', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(50, 'Arlene', 'Dulinty', 'adulinty1d@illinois.edu', 'metlloperJA208bV5QT', '293-439-5119', '134.201.209.244', 'Uyskoye', NULL, '456470', 'Russia', '2023-06-12 14:20:20'),
(51, 'Parsifal', 'Stanbra', 'pstanbra1e@discovery.com', 'ifrejhydpOC5263\'', '812-721-6989', '198.223.134.27', 'Tangjia', NULL, NULL, 'China', '2023-06-12 14:20:20'),
(52, 'Terri', 'Tramel', 'ttramel1f@jiathis.com', 'dxxfjkiefAS2871S(Q?0%C+=r', '439-529-2708', '93.27.253.180', 'Basqal', NULL, NULL, 'Azerbaijan', '2023-06-12 14:20:20'),
(53, 'Putnem', 'Bramley', 'pbramley1g@google.com.au', 'kabqlkgkdBK9360', '299-338-6454', '52.57.33.241', 'Nova Viçosa', NULL, '45920-000', 'Brazil', '2023-06-12 14:20:20'),
(54, 'Kira', 'Coopper', 'kcoopper1h@hubpages.com', 'uasqszdjgUH691Aa6}', '964-696-9206', '112.33.94.196', 'Buriram', NULL, '31180', 'Thailand', '2023-06-12 14:20:20'),
(55, 'Kendall', 'Randle', 'krandle1i@sitemeter.com', 'vdvgtfahnET717URJU=', '260-181-5538', '8.54.246.103', 'Tagoloan', NULL, '9222', 'Philippines', '2023-06-12 14:20:20'),
(56, 'Briny', 'Blueman', 'bblueman1j@hatena.ne.jp', 'ouxitddnoMB97188', '860-625-5674', '130.218.209.175', 'Aūa', NULL, '96799', 'American Samoa', '2023-06-12 14:20:20'),
(57, 'Taffy', 'Barthelme', 'tbarthelme1k@ca.gov', 'ubsuokambYN595\"H_', '715-344-9423', '27.29.239.2', 'Takāb', NULL, NULL, 'Iran', '2023-06-12 14:20:20');

-- --------------------------------------------------------

--
-- Table structure for table `customer_orders`
--

CREATE TABLE `customer_orders` (
  `order_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `pizza_id` int(11) DEFAULT NULL,
  `exclusions` varchar(4) DEFAULT NULL,
  `extras` varchar(4) DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_orders`
--

INSERT INTO `customer_orders` (`order_id`, `customer_id`, `pizza_id`, `exclusions`, `extras`, `order_date`) VALUES
(1, 101, 1, '', '', '2021-01-01 18:05:02'),
(2, 101, 1, '', '', '2021-01-01 19:00:52'),
(3, 102, 1, '', '', '2021-01-02 23:51:23'),
(3, 102, 2, '', 'NaN', '2021-01-02 23:51:23'),
(4, 103, 1, '4', '', '2021-01-04 13:23:46'),
(4, 103, 1, '4', '', '2021-01-04 13:23:46'),
(4, 103, 2, '4', '', '2021-01-04 13:23:46'),
(5, 104, 1, NULL, '1', '2021-01-08 21:00:29');

-- --------------------------------------------------------

--
-- Table structure for table `denormalized_table`
--

CREATE TABLE `denormalized_table` (
  `order_id` int(11) DEFAULT NULL,
  `runner_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `pizza_id` int(11) NOT NULL DEFAULT 0,
  `pizza_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `denormalized_table`
--

INSERT INTO `denormalized_table` (`order_id`, `runner_id`, `customer_id`, `pizza_id`, `pizza_name`) VALUES
(1, 1, 101, 1, 'Meat Lovers'),
(2, 1, 101, 1, 'Meat Lovers'),
(3, 1, 102, 1, 'Meat Lovers'),
(3, 1, 102, 2, 'Vegetarian'),
(4, 2, 103, 1, 'Meat Lovers'),
(4, 2, 103, 1, 'Meat Lovers'),
(4, 2, 103, 2, 'Vegetarian'),
(5, 3, 104, 1, 'Meat Lovers');

-- --------------------------------------------------------

--
-- Table structure for table `pizza_names`
--

CREATE TABLE `pizza_names` (
  `pizza_id` int(11) NOT NULL,
  `pizza_name` text DEFAULT NULL,
  `pizza_image` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pizza_names`
--

INSERT INTO `pizza_names` (`pizza_id`, `pizza_name`, `pizza_image`) VALUES
(1, 'Meat Lovers', NULL),
(2, 'Vegetarian', NULL),
(10, 'Hawaiian Pizza', ''),
(11, 'Mozarella Cheese', ''),
(12, 'Ham and Cheese Pizzawrap', ''),
(13, 'Spam Hawaiian Pizzawrap', ''),
(14, 'Chorizo Pepperoni Pizzawrap', ''),
(15, 'Spam Hawaiian Pizzawrap Value Meal', ''),
(16, 'Chorizo Pepperoni Pizzawrap Value Meal', '');

-- --------------------------------------------------------

--
-- Table structure for table `pizza_recipes`
--

CREATE TABLE `pizza_recipes` (
  `pizza_id` int(11) NOT NULL,
  `toppings` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pizza_recipes`
--

INSERT INTO `pizza_recipes` (`pizza_id`, `toppings`) VALUES
(1, '1,2,3,4,5,6,7,8,10'),
(2, '4,6,7,9,11,12');

-- --------------------------------------------------------

--
-- Table structure for table `pizza_toppings`
--

CREATE TABLE `pizza_toppings` (
  `topping_id` int(11) NOT NULL,
  `topping_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pizza_toppings`
--

INSERT INTO `pizza_toppings` (`topping_id`, `topping_name`) VALUES
(642, 'Onions'),
(643, 'Italian Sausage'),
(644, 'Bacon'),
(645, 'Black Olive'),
(646, 'Spinach'),
(647, 'Pineapple'),
(648, 'Jalapeno'),
(649, 'Mozarella Cheese'),
(650, 'Roasted Red Peppers'),
(651, 'Fresh Origano'),
(652, 'Cheddar Cheese'),
(653, 'Pharmizan'),
(654, 'Chicken'),
(655, 'Mushroom'),
(656, 'Pepperoni'),
(657, 'Pesto Sauce'),
(658, 'Fresh Mint Leaves'),
(659, 'Fresh Pine Trees'),
(660, 'Sweet Corn'),
(661, 'Guchi'),
(662, 'Ham'),
(663, 'Green Olives'),
(664, 'Ricotta'),
(665, 'Fresh Silantro'),
(666, 'Alfredo Sauce'),
(667, 'Peppers'),
(668, 'Fita Cheese');

--
-- Triggers `pizza_toppings`
--
DELIMITER $$
CREATE TRIGGER `prevent_duplicate_toppings` BEFORE INSERT ON `pizza_toppings` FOR EACH ROW BEGIN
    -- Check if the topping already exists for the pizza
    IF EXISTS (
        SELECT 1
        FROM pizza_toppings
        WHERE topping_id = NEW.topping_id
        AND topping_name = NEW.topping_name
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate topping for pizza.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `runners`
--

CREATE TABLE `runners` (
  `runner_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `registration_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `runners`
--

INSERT INTO `runners` (`runner_id`, `first_name`, `last_name`, `age`, `birth_date`, `registration_date`) VALUES
(1, '', '', NULL, NULL, '2021-01-01'),
(2, '', '', NULL, NULL, '2021-01-03'),
(3, '', '', NULL, NULL, '2021-01-08'),
(4, '', '', NULL, NULL, '2021-01-15'),
(22, 'Washington', 'Aguilar', 43, '1980-01-01', '2023-06-13'),
(23, 'Hans Zin', 'Sanchez', 21, '2002-11-08', '2023-06-13'),
(24, 'Jeffrey', 'Roa', 53, '1970-11-12', '2023-06-14');

--
-- Triggers `runners`
--
DELIMITER $$
CREATE TRIGGER `before_insert_runner` BEFORE INSERT ON `runners` FOR EACH ROW BEGIN
    SET NEW.registration_date = CURDATE();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `runner_orders`
--

CREATE TABLE `runner_orders` (
  `order_id` int(11) NOT NULL,
  `runner_id` int(11) DEFAULT NULL,
  `pickup_time` varchar(19) DEFAULT NULL,
  `distance` varchar(7) DEFAULT NULL,
  `duration` varchar(10) DEFAULT NULL,
  `cancellation` varchar(23) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `runner_orders`
--

INSERT INTO `runner_orders` (`order_id`, `runner_id`, `pickup_time`, `distance`, `duration`, `cancellation`) VALUES
(1, 1, '2021-01-01 18:15:34', '20km', '32 minutes', ''),
(2, 1, '2021-01-01 19:10:54', '20km', '27 minutes', ''),
(3, 1, '2021-01-03 00:12:37', '13.4km', '20 minutes', ''),
(4, 2, '2021-01-04 13:53:03', '23.4 km', '40 minutes', 'NaN'),
(5, 3, '2021-01-08 21:10:57', '10 km', '15 minutes', 'NaN'),
(6, 3, NULL, NULL, NULL, 'NaN'),
(7, 2, '2020-01-08 21:30:45', '25 km', '25 minutes', NULL),
(8, 2, '2020-01-10 00:15:02', '23.4 km', '15 minutes', NULL),
(9, 2, '2020-01-08 21:30:45', '25 km', '25 minutes', NULL),
(10, 2, '2020-01-10 00:15:02', '23.4 km', '15 minutes', NULL),
(11, 2, NULL, NULL, NULL, 'Customer Cancellation'),
(12, 1, '2020-01-11 18:50:20', '10 km', '10 minutes', NULL);

--
-- Triggers `runner_orders`
--
DELIMITER $$
CREATE TRIGGER `after_update_on_runners_orders` AFTER UPDATE ON `runner_orders` FOR EACH ROW BEGIN
	IF NEW.cancellation = 'NaN' OR NEW.cancellation is NULL OR NEW.cancellation LIKE 'Cancellation%' THEN
		INSERT INTO audit_table VALUES(NEW.order_id, NEW.runner_id, CURRENT_TIME, CURRENT_DATE);
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `birth_date` varchar(255) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_table`
--
ALTER TABLE `audit_table`
  ADD KEY `fk_audit_table_order_id` (`order_id`),
  ADD KEY `fk_audit_table_runner_id` (`runner_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD KEY `fk_order_id_customer` (`order_id`),
  ADD KEY `fk_pizza_id_customer` (`pizza_id`);

--
-- Indexes for table `pizza_names`
--
ALTER TABLE `pizza_names`
  ADD PRIMARY KEY (`pizza_id`);

--
-- Indexes for table `pizza_recipes`
--
ALTER TABLE `pizza_recipes`
  ADD PRIMARY KEY (`pizza_id`),
  ADD KEY `pizza_id` (`pizza_id`);

--
-- Indexes for table `pizza_toppings`
--
ALTER TABLE `pizza_toppings`
  ADD PRIMARY KEY (`topping_id`);

--
-- Indexes for table `runners`
--
ALTER TABLE `runners`
  ADD PRIMARY KEY (`runner_id`);

--
-- Indexes for table `runner_orders`
--
ALTER TABLE `runner_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_runner_id` (`runner_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `pizza_names`
--
ALTER TABLE `pizza_names`
  MODIFY `pizza_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `pizza_toppings`
--
ALTER TABLE `pizza_toppings`
  MODIFY `topping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=669;

--
-- AUTO_INCREMENT for table `runners`
--
ALTER TABLE `runners`
  MODIFY `runner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `runner_orders`
--
ALTER TABLE `runner_orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_table`
--
ALTER TABLE `audit_table`
  ADD CONSTRAINT `fk_audit_table_order_id` FOREIGN KEY (`order_id`) REFERENCES `runner_orders` (`order_id`),
  ADD CONSTRAINT `fk_audit_table_runner_id` FOREIGN KEY (`runner_id`) REFERENCES `runners` (`runner_id`);

--
-- Constraints for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD CONSTRAINT `fk_order_id_customer` FOREIGN KEY (`order_id`) REFERENCES `runner_orders` (`order_id`),
  ADD CONSTRAINT `fk_pizza_id_customer` FOREIGN KEY (`pizza_id`) REFERENCES `pizza_names` (`pizza_id`);

--
-- Constraints for table `pizza_recipes`
--
ALTER TABLE `pizza_recipes`
  ADD CONSTRAINT `fk_pizza_id` FOREIGN KEY (`pizza_id`) REFERENCES `pizza_names` (`pizza_id`);

--
-- Constraints for table `runner_orders`
--
ALTER TABLE `runner_orders`
  ADD CONSTRAINT `fk_runner_id` FOREIGN KEY (`runner_id`) REFERENCES `runners` (`runner_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
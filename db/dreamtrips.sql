-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2018 at 08:08 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dreamtrips`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCity` (IN `cityName` VARCHAR(255), IN `regionId` INT)  NO SQL
INSERT INTO `cities`(`name`, `country`, `region`) VALUES (cityName, (SELECT country from regions where id = regionId), regionId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addCountry` (IN `countryName` VARCHAR(255))  NO SQL
INSERT INTO `countries` (name) VALUES (countryName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addRegion` (IN `regionName` VARCHAR(255), IN `countryId` INT)  NO SQL
INSERT INTO `regions`(`name`, `country`) VALUES (regionName, countryId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countries` ()  NO SQL
SELECT * from countries$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dreamtrip` (IN `id` INT)  NO SQL
SELECT dreamtrips.id, dreamtrips.name, dreamtrips.start_date, dreamtrips.end_date, countries.name as country,regions.name as region, cities.name as city, destination_desc.description as destination_desc, dreamtrips.open_date, hotels.name as hotel, dreamtrips.about, dreamtrips.what_we_love, dreamtrips.whats_included, dreamtrips.transportation, dreamtrips.platinum_inclusions, dreamtrips.itinerary, dreamtrips.additional_information, dreamtrips.policies FROM `dreamtrips`
INNER JOIN
countries on countries.id = dreamtrips.country
INNER JOIN 
cities on cities.id = dreamtrips.city
INNER JOIN
regions on regions.id = dreamtrips.region
left join 
destination_desc on destination_desc.city = cities.id
left join 
hotels on hotels.id = dreamtrips.hotel
where dreamtrips.id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dreamtrips` ()  SELECT dreamtrips.id, dreamtrips.name, dreamtrips.start_date, dreamtrips.end_date, countries.name as country,regions.name as region, cities.name as city, destination_desc.description as destination_desc, dreamtrips.open_date, hotels.name as hotel, dreamtrips.about, dreamtrips.what_we_love, dreamtrips.whats_included, dreamtrips.transportation, dreamtrips.platinum_inclusions, dreamtrips.itinerary, dreamtrips.additional_information, dreamtrips.policies FROM `dreamtrips`
INNER JOIN
countries on countries.id = dreamtrips.country
INNER JOIN 
cities on cities.id = dreamtrips.city
INNER JOIN
regions on regions.id = dreamtrips.region
left join 
destination_desc on destination_desc.city = cities.id
left join 
hotels on hotels.id = dreamtrips.hotel$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `regions` (IN `countryId` INT)  NO SQL
SELECT id, name from regions where country = countryId$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` int(11) NOT NULL,
  `region` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `country`, `region`) VALUES
(1, 'Tel-Aviv', 1, 1),
(2, 'Eilat', 1, 2),
(3, 'Kfar Sava', 1, 1),
(4, '\'Be\'er Sheva\'', 1, 2),
(5, 'Raanana', 1, 1),
(6, 'Ramat Hasharon', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`) VALUES
(3, 'Brazil'),
(4, 'Great Britian'),
(1, 'Israel'),
(2, 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `country_to_languages`
--

CREATE TABLE `country_to_languages` (
  `country_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `country_to_languages`
--

INSERT INTO `country_to_languages` (`country_id`, `language_id`, `id`) VALUES
(1, 1, 1),
(1, 3, 2),
(1, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `destination_desc`
--

CREATE TABLE `destination_desc` (
  `id` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `description` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `destination_desc`
--

INSERT INTO `destination_desc` (`id`, `city`, `description`) VALUES
(1, 2, '<p>Year-round sunshine, a temperate climate, and blue-ribbon beaches draw people from all over the world to Eilat, Israel. The maritime city is perched at the southernmost tip of the country at the head of the Gulf of Aqaba. Eilat dates back to biblical times, and is featured in both the Torah and the Old Testament.</p><br/><br/> <p>In addition to the plentiful resorts, restaurants, and nightclubs, Eilat makes for an excellent ecotourism base. Its nearby natural attractions like the Red Sea coral reefs, coastal staging grounds for migrant birds, and the Negev Desert wildlife viewable in the Yotvata Hai-Bar Nature Reserve make it a popular destination for travelers drawn to nature.</p>');

-- --------------------------------------------------------

--
-- Table structure for table `dreamtrips`
--

CREATE TABLE `dreamtrips` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `country` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `region` int(11) NOT NULL,
  `end_date` date NOT NULL,
  `open_date` date NOT NULL,
  `hotel` int(11) NOT NULL,
  `about` varchar(255) NOT NULL,
  `what_we_love` int(11) NOT NULL,
  `whats_included` int(11) NOT NULL,
  `transportation` int(11) NOT NULL,
  `platinum_inclusions` int(11) NOT NULL,
  `itinerary` int(11) NOT NULL,
  `additional_information` int(11) NOT NULL,
  `policies` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dreamtrips`
--

INSERT INTO `dreamtrips` (`id`, `name`, `start_date`, `country`, `city`, `region`, `end_date`, `open_date`, `hotel`, `about`, `what_we_love`, `whats_included`, `transportation`, `platinum_inclusions`, `itinerary`, `additional_information`, `policies`) VALUES
(1, 'Sail by Yacht in Eilat', '2018-07-19', 1, 2, 2, '2018-07-22', '2018-05-13', 1, '', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `city` int(11) NOT NULL,
  `hotel features` int(11) NOT NULL,
  `stars` int(11) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `name`, `city`, `hotel features`, `stars`, `address`) VALUES
(1, 'The Astral Maris ', 2, 0, 4, 'Durban 6');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`) VALUES
(1, 'Hebrew'),
(3, 'Arabic'),
(4, 'English');

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

CREATE TABLE `pictures` (
  `id` int(11) NOT NULL,
  `src` varchar(255) NOT NULL,
  `region` int(11) NOT NULL,
  `country` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `hotel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pictures`
--

INSERT INTO `pictures` (`id`, `src`, `region`, `country`, `city`, `hotel`) VALUES
(1, 'Gallery_TelAvivn400X740_1.jpg', 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`, `country`) VALUES
(1, 'Merkaz', 1),
(2, 'Southen District', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `country` (`country`),
  ADD KEY `region` (`region`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `country_to_languages`
--
ALTER TABLE `country_to_languages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `language_id` (`language_id`);

--
-- Indexes for table `destination_desc`
--
ALTER TABLE `destination_desc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `dreamtrips`
--
ALTER TABLE `dreamtrips`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countries` (`country`),
  ADD KEY `city` (`city`),
  ADD KEY `region` (`region`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region` (`region`),
  ADD KEY `country` (`country`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `country` (`country`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `country_to_languages`
--
ALTER TABLE `country_to_languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `destination_desc`
--
ALTER TABLE `destination_desc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `dreamtrips`
--
ALTER TABLE `dreamtrips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `cities_ibfk_2` FOREIGN KEY (`region`) REFERENCES `regions` (`id`);

--
-- Constraints for table `country_to_languages`
--
ALTER TABLE `country_to_languages`
  ADD CONSTRAINT `country_to_languages_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `country_to_languages_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`);

--
-- Constraints for table `destination_desc`
--
ALTER TABLE `destination_desc`
  ADD CONSTRAINT `destination_desc_ibfk_1` FOREIGN KEY (`city`) REFERENCES `cities` (`id`);

--
-- Constraints for table `dreamtrips`
--
ALTER TABLE `dreamtrips`
  ADD CONSTRAINT `countries` FOREIGN KEY (`country`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `dreamtrips_ibfk_1` FOREIGN KEY (`city`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `dreamtrips_ibfk_2` FOREIGN KEY (`region`) REFERENCES `regions` (`id`);

--
-- Constraints for table `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`city`) REFERENCES `cities` (`id`);

--
-- Constraints for table `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `pictures_ibfk_1` FOREIGN KEY (`region`) REFERENCES `regions` (`id`),
  ADD CONSTRAINT `pictures_ibfk_2` FOREIGN KEY (`country`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `pictures_ibfk_3` FOREIGN KEY (`city`) REFERENCES `cities` (`id`);

--
-- Constraints for table `regions`
--
ALTER TABLE `regions`
  ADD CONSTRAINT `regions_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

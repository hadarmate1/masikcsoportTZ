-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2026. Nov 16. 13:58
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `szerviz_db`
--
CREATE DATABASE IF NOT EXISTS `szerviz_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `szerviz_db`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jarmuvek`
--

CREATE TABLE `jarmuvek` (
  `id` int(11) NOT NULL,
  `tulajdonos_id` int(11) DEFAULT NULL,
  `rendszam` varchar(15) NOT NULL,
  `modell` varchar(80) NOT NULL,
  `javitasi_koltseg` int(11) NOT NULL,
  `kesz_van` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `jarmuvek`
--

INSERT INTO `jarmuvek` (`id`, `tulajdonos_id`, `rendszam`, `modell`, `javitasi_koltseg`, `kesz_van`) VALUES
(1, 1, 'AA-BB-101', 'Ford Focus 1.6', 45000, 1),
(2, 1, 'AA-BB-102', 'Ford Fiesta 1.2', 120000, 0),
(3, 1, 'AA-CC-203', 'Opel Astra H', 32000, 1),
(4, 2, 'BB-DD-304', 'Volkswagen Golf VII', 85000, 1),
(5, 2, 'BB-EE-405', 'Volkswagen Passat B8', 210000, 0),
(6, 2, 'BB-FF-506', 'Skoda Octavia 2.0', 62000, 1),
(7, 3, 'CC-GG-607', 'Toyota Yaris Hybrid', 28000, 1),
(8, 3, 'CC-HH-708', 'Toyota Corolla Sedan', 94000, 0),
(9, 3, 'CC-II-809', 'BMW 320d Touring', 175000, 1),
(10, 1, 'AA-JJ-910', 'Ford Mondeo Titanium', 140000, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kategoriak`
--

CREATE TABLE `kategoriak` (
  `id` int(11) NOT NULL,
  `nev` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kategoriak`
--

INSERT INTO `kategoriak` (`id`, `nev`) VALUES
(1, 'Futómű és Fék'),
(3, 'Időszakos Karbantartás'),
(2, 'Motor és Erőátvitel');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szolgaltatasok`
--

CREATE TABLE `szolgaltatasok` (
  `id` int(11) NOT NULL,
  `kategoria_id` int(11) NOT NULL,
  `megnevezes` varchar(100) NOT NULL,
  `alapar` int(11) NOT NULL,
  `munkaido_perc` int(11) NOT NULL,
  `aktiv` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `szolgaltatasok`
--

INSERT INTO `szolgaltatasok` (`id`, `kategoria_id`, `megnevezes`, `alapar`, `munkaido_perc`, `aktiv`) VALUES
(1, 1, 'Első fékbetét és féktárcsa csere', 24900, 60, 1),
(2, 1, 'Lézeres futómű beállítás', 16500, 45, 1),
(3, 1, 'Kerékcsapágy csere prémium', 32000, 90, 0),
(4, 2, 'Teljes kuplungszett csere', 85000, 240, 1),
(5, 2, 'Vezérműszíj és vízpumpa készlet csere', 72000, 180, 1),
(6, 2, 'Turbófeltöltő diagnosztika és beállítás', 28000, 75, 0),
(7, 3, 'Kis szerviz (olaj és olajszűrő csere)', 14900, 40, 1),
(8, 3, 'Klímatisztítás és ózonos fertőtlenítés', 9900, 30, 1),
(9, 3, 'Műszaki vizsgára felkészítés és átvizsgálás', 19500, 60, 1),
(10, 1, 'Lengéscsillapító és porvédő csere', 29900, 80, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tulajdonosok`
--

CREATE TABLE `tulajdonosok` (
  `id` int(11) NOT NULL,
  `nev` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `tulajdonosok`
--

INSERT INTO `tulajdonosok` (`id`, `nev`) VALUES
(1, 'Kovács Péter'),
(2, 'Nagy Anna'),
(3, 'Szabó Gábor');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `jarmuvek`
--
ALTER TABLE `jarmuvek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tulajdonos` (`tulajdonos_id`);

--
-- A tábla indexei `kategoriak`
--
ALTER TABLE `kategoriak`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nev` (`nev`);

--
-- A tábla indexei `szolgaltatasok`
--
ALTER TABLE `szolgaltatasok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategoria_id` (`kategoria_id`);

--
-- A tábla indexei `tulajdonosok`
--
ALTER TABLE `tulajdonosok`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `jarmuvek`
--
ALTER TABLE `jarmuvek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `kategoriak`
--
ALTER TABLE `kategoriak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `szolgaltatasok`
--
ALTER TABLE `szolgaltatasok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `tulajdonosok`
--
ALTER TABLE `tulajdonosok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `jarmuvek`
--
ALTER TABLE `jarmuvek`
  ADD CONSTRAINT `fk_tulajdonos` FOREIGN KEY (`tulajdonos_id`) REFERENCES `tulajdonosok` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jarmuvek_ibfk_1` FOREIGN KEY (`tulajdonos_id`) REFERENCES `tulajdonosok` (`id`);

--
-- Megkötések a táblához `szolgaltatasok`
--
ALTER TABLE `szolgaltatasok`
  ADD CONSTRAINT `szolgaltatasok_ibfk_1` FOREIGN KEY (`kategoria_id`) REFERENCES `kategoriak` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

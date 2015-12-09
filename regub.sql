-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 09 Décembre 2015 à 12:35
-- Version du serveur :  5.6.20
-- Version de PHP :  5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `regub`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLogin`(IN `log` VARCHAR(64) CHARSET utf8, IN `pass` VARCHAR(64) CHARSET utf8)
    NO SQL
    DETERMINISTIC
BEGIN
	SELECT Compte.idCompte AS id, Compte.nom,Compte.prenom,Compte.login,Compte.creation,TypeCompte.libelle AS type,TypeCompte.dblogin,TypeCompte.dbpassword
	FROM Compte INNER JOIN TypeCompte ON Compte.idTypeCompte = TypeCompte.idTypeCompte
	WHERE (log = Compte.login AND Compte.password = SHA2( CONCAT( pass , Compte.salt),256));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updPass`(IN `login` VARCHAR(64) CHARSET utf8, IN `oldpass` VARCHAR(64) CHARSET utf8, IN `newpass` VARCHAR(64) CHARSET utf8)
    NO SQL
BEGIN
	DECLARE cmpt INT(10);

	SELECT COUNT(*) INTO cmpt
	FROM `Compte` 
	WHERE(`Compte`.`login` = login AND `Compte`.`password` = SHA2(CONCAT(oldpass,Compte.salt),256));
	IF cmpt =1 THEN
		UPDATE `Compte`
		SET `password` = newpass
		WHERE(`Compte`.`login` = login AND
      		`Compte`.`password` = SHA2(CONCAT(oldpass,Compte.salt),256));  
	END IF;
    SELECT cmpt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
`idClient` int(8) NOT NULL,
  `societe` varchar(64) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `email` varchar(32) NOT NULL,
  `addr_ligne1` varchar(128) DEFAULT NULL,
  `addr_ligne2` varchar(128) DEFAULT NULL,
  `ville` varchar(64) DEFAULT NULL,
  `code_postal` char(5) NOT NULL,
  `mot_de_passe` varchar(64) NOT NULL,
  `salt` char(32) NOT NULL,
  `valide` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=99 ;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`idClient`, `societe`, `telephone`, `email`, `addr_ligne1`, `addr_ligne2`, `ville`, `code_postal`, `mot_de_passe`, `salt`, `valide`) VALUES
(48, 'Leclerc', '0800865286', 'Francklin@yahoo.com', 'Rue Henri Giffard', '', 'Limoges', '87280', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(50, 'lagoma', '55222', 'fjkd@kdokdlm.com', 'rueee', NULL, 'jiji', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(52, 'mesmer', '0625649875', 'm@g.fr', '45 rue fjknlk', NULL, 'l,lfsk', '05611', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(57, 'yu', 'yu', 'yu@ft.fop', 'yu', 'yu', 'yu', 'yuyyu', '79c1d49d56ec48dafc5bb45bb7c777309a1e1a98553e5e112414644cc6521b91', '05620579050a1f4486f3effd7e50426e', 0),
(58, 'Messy', '0624912407', 'mesmerloic@gmail.com', '185 avenue Alber thomas', '', 'Limoges', '87100', 'c63d9e996e6d8c43185a1842e815c1a9ea2c3689936b5694738af4512f01d742', '0cf186aef6c797ce83e8f09b49d2b3d3', 0),
(59, 'Messy', '0624912407', 'mesmerloic@gmail.com', '185 avenue Alber thomas', '', 'Limoges', '87100', 'e57950c5706f6486834bd5532d3b0cad63d94080cc5143fc679b3f1eb5fdfc68', 'f1c7d90b33dcb48cf956b921933b4030', 0),
(60, 'op', 'op', 'op@gmail.com', 'op', 'op', 'op', 'op', '8a5deecd85f788492c5876676eea3afa2d4160f47c0fe24f96795ccc8a745e3d', 'a2ae490cf648b79f9bb3dd55d40817c5', 0),
(61, 'op', 'op', 'op@gmail.com', 'op', 'op', 'op', 'op', 'ef96fbccb164717c3128e6c9c0338407ce9c13d7ef9943674ab93d00fe07fa46', '51f44a7f737579757f76e6b7f2d7310c', 0),
(62, 'op', 'op', 'op@gmail.com', 'op', 'op', 'op', 'op', '350d267df9639cc2e4207ba8b773b3ddea1902c175d99227feab12ed68e6762c', 'a13a3d31c131147afdb556b251d12698', 0),
(63, 'op', 'op', 'op@gmail.com', 'op', 'op', 'op', 'op', 'c0fe5819d99e4b5e5d44078a937194fec12e3115691f96c801e628ec8726f4d1', '86797ead88197e30acd58c0f331881d5', 0),
(64, 'ty', 'ty', 'ty@ty.try', 'ty', 'ty', 'rt', 'ty', '8f0c62fd2c0f7ab0a9c480d035d45b81abfc148bcd893dd39aad41957f7350ca', 'e36f47213965f325ac8f1d1107b37d05', 0),
(65, 'op', 'op', 'op@gmail.com', 'po', 'op', 'op', 'op', '67f97bc99357fb94984ba6a820fed05f1a4e0a1b6e8e2edf5a59e55c89d1ad4a', '7de266039bc0f4b8b5df40894d6d88f8', 0),
(67, 'toto', 'ty', 'ty@ty.try', 'ty', 're', 'ze', 'ze', 'e5793d0801ea8b26eb0fae1638df14bc96e996abc6eac76a5ac0ba5cf250127c', '3a586af791428b09dd899578326529aa', 0),
(68, 'titi', 'titi', 'ty@ty.try', 'ty', 'y', 'rt', 'ty', 'f937294f02a5e19b916ef5073ed3603da22728fb66ad8cca2980357586a28704', '2e5e8ad86bdc1a42dbbff1f47ffed86f', 0),
(69, 'Client', '06255', 'cli@gmail.com', 'rue', 'ligne2', 'Limoges', '8700', '3584a748e52457ba99d38d761ead3fc77fdcdffe21ba189bc08dc9442226e7c4', '6ec42fe6ed6f68cd9e04855c1072dd6d', 0),
(70, 'x', 'x', 'x@jk.fr', 'x', 'x', 'x', 'x', '065a252626bea321ee864437e7857ef47c3e95b1a9858ea462d015e2f11770f1', 'dbce6ae7a359d0bdcff12eec6c3a59fd', 0),
(71, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'ccff517607f10a6e47ce9e33690c3043b4faf323ca6a6ac6045a849f873593b8', '9fcb5d0db322ad58c6c9aa3cf880e7a0', 0),
(72, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '25935f441941a0a4e2530b06dd62c2ebd7d115c86e634e2e68ff457c3c818a04', '2877aa1aaec2c700c069d2f543f305f8', 0),
(73, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'd2c323e16b2a6a8b1765a73543a4d02b5415f2076bebd34036c1d666a813bef9', '06b1f056edb14805c4369ddff72ac401', 0),
(74, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '85f82836b828c8e101ef7acdc13ccc3683f85a0d3f9255d9a82a7ce788f6f88f', '65ddd77f724e3d1a06fe7ce8b03864c1', 0),
(75, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'e06c1cd2e105a1ad37eb870da0b60b2cbfeaeb85ab232fbe2b1178c5fa799330', '1a90202ebe639f300538758000c59385', 0),
(76, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'cca9477eb3f3f7cac60b7bc50be256b34ffaf10d998aeb516c58b54f7609b3ef', 'eb6307bfd02ecf93caadf2eac410a896', 0),
(77, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '4e41dda9025678a8c5f17204375eb895b717c42ebbf956f74715a0877cfcc905', '9e26832cb4fe34b66163437ebf15b3ab', 0),
(78, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'c36bb1ce08b853fbd98a333533b6f3206fe535b4414a2996a087053860228d95', '8acc577da97f6ad8b741462eb17b0e46', 0),
(79, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '6da987480c656caac3def7f3d8377646b6e14fbe7779e2f8494b2d723724b412', '852601f3f98ae1286db4f9ca8c3a3470', 0),
(80, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'f1eb1e871e912d8661dec5c722e0567a2e3b546b9fb77d81da084ef639f4e472', '186876aaa044d83699fc479e1187a2b0', 0),
(81, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '26a77bc3516dd7f985ac72eb7d8e85748999e115b373aa8396a79db0cb607df2', '74b6ecbe57762862738289b247ca679f', 0),
(82, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '1cdec8eb08c9cde36f4227da81d701bc0fceb27105f7fcb535b700faabc81f1f', 'fa8aaa5820dad01a078405acb52a09b8', 0),
(83, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '809ed292e40e5480b3d626f8fe5c308bf632395ae380b92599055984febad13f', 'cbc4933b55c4ed68d6ff938057f224ad', 0),
(84, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', 'e8c7d1131ee4d367dd11d9d496c12647d4a93e89275c33b6430ca40e0d27b785', '0b9c993950da2e8348e2d649313f6314', 0),
(85, 'sdfsdf', 'sdfsdf', 'sdfsdf@ffsd', 'sdf', 'sdf', 'sdf', 'sdf', '0f1a462076efe06d7f6276cac50e05eda1c8ae9370d07ffd3f42cdb720f3de06', '11078f9280223b62c20cac690ad4408e', 0),
(86, 'dfg', 'dfg', 'ty@glm.fr', 'dfg', 'dfg', 'dfg', 'dfg', 'cb68429267a5af48d42a1dbff47496883b00a7800b1a5be822e403cd57c100d5', 'bdd4673b050282838ab1f0abab850f09', 0),
(87, 'dfg', 'dfg', 'ty@glm.fr', 'dfg', 'dfg', 'dfg', 'dfg', '13bc5d08f3c5004de6892d974cbc217a72ef8eedb3552c6acd50ad551b2a3b11', '8ba6a76e8f71b7eef8bb611388822a7e', 0),
(88, 'dfg', 'dfg', 'ty@glm.fr', 'dfg', 'dfg', 'dfg', 'dfg', '8c6bd553f32d1aa8aaf2928c9e47473d4c5db9849169f3ece597cbb867bef91b', 'cfa7e082094b6a2f653d027fe996308a', 0),
(89, 'dfg', 'dfg', 'ty@glm.fr', 'dfg', 'dfg', 'dfg', 'dfg', 'ae6d41a667f803c10e549311570e8a7a2f59d6d3e0889cf140d8101b47a447a0', '223b9b26db2cb3cc6a9b2bcbfcf06ad9', 0),
(90, 'dfg', 'dfg', 'ty@glm.fr', 'dfg', 'dfg', 'dfg', 'dfg', '484a7d22abdae8afca237b5c6253d6c9362f57ab110126dd6b21428d91ef53a9', 'bd579254b749f04a8a73bbd1574132de', 0),
(91, 'dfg', 'dfg', 'ty@glm.fr', 'dfg', 'dfg', 'dfg', 'dfg', '5bba07ab59136c7ec46a160b09a9d08121a10e6de21c32ec7f1676032e3ebdf9', 'c280206afd7db7958d93d34523a0f328', 0),
(92, 'tytyt', 'tr', 'ytr@gh', 'yr', 'r', 'ytr', 'yr', '55c3684332f33cff2bfbf9577f485d696d8769efb3c0668bd179a851314c1440', '36ed6b3479fc11238fc32c9243bc942e', 0),
(93, 'rrtete', 'ertert', 'ertee@eze', 'ertert', 'ert', 'ert', 'ert', '227cab511d35e20be0280c74c1f1b08d0e23cf5bdef6f62cac9357861ede0600', '0cfbd4e959aacf3febf860cb7bb53c49', 0),
(94, 'test', 'test', 'test@fr', 'test', 'test', 'test', 'test', '49e89331e6fee4da9be6bcec1cf1637348fb63041ea165a57d747fa71fb9b194', '98fec7dce8d5d6ac248a9c573ed77309', 0),
(95, 'toto', 'toto', 'toto@gmail.com', 'toto', 'toto', 'toto', 'toto', 'df7d4471b7425c412c88d1e2e81cb4512cfd4b456c6db1257fb0e9be83bc7851', '71342ef222dd6869f8ba9f6ed3d62561', 0),
(96, ' aaaz', 'az', 'a@fgh.Fr', 'az', 'az', 'z', 'aza', '460815d2ea72bd0215edff3b89aaa54078d22cde9ce0c04a8719848a7eba11e9', 'bdb432820970731ba5a0a8efd9b42b24', 0),
(97, 'rt', 'rt', 'rt@jk', 'rt', 'rt', 'rt', 'rt', 'da3b7748501a9edfce92fcd500c91cf44f940a41da4e6c7fd9e3ece9c0fdf6d4', '612f774132e6dc04411ef1bcca5ad332', 0),
(98, 'tyuy', 'tr', 'trt@ty', 'rtrt', 'er', 'tr', 'tyr', 'fb87a45d10f4aeeaa2e5513c25cb2ea8d7d1e3ab876924eff183fbe04e3ca03e', 'c86cad28ba8459fba0d0043e11e1f6bd', 0);

--
-- Déclencheurs `client`
--
DELIMITER //
CREATE TRIGGER `insCli` BEFORE INSERT ON `client`
 FOR EACH ROW BEGIN
	SET NEW.salt = md5(uuid());            
	SET NEW.mot_de_passe =SHA2(CONCAT(NEW.mot_de_passe,NEW.salt),256);            
END
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `updCli` BEFORE UPDATE ON `client`
 FOR EACH ROW BEGIN
	IF ( NEW.mot_de_passe <> OLD.mot_de_passe ) THEN
		SET NEW.salt = md5(uuid());            
		SET NEW.mot_de_passe =SHA2(CONCAT(NEW.mot_de_passe,NEW.salt),256); 
	ELSE
		SET NEW.salt = OLD.salt;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

CREATE TABLE IF NOT EXISTS `compte` (
`idCompte` int(8) NOT NULL,
  `nom` varchar(32) NOT NULL,
  `prenom` varchar(32) NOT NULL,
  `login` varchar(32) NOT NULL,
  `password` char(64) NOT NULL,
  `salt` char(32) NOT NULL,
  `creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idTypeCompte` int(8) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `nom`, `prenom`, `login`, `password`, `salt`, `creation`, `idTypeCompte`) VALUES
(1, 'toto', 'toto', 'toto', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', '2015-03-17 23:00:00', 2),
(2, 'titi', 'titi', 'titi', 'a90dacbe58f3aa6825c04ff467030b36472ef80fbca958934871d1a73a8c4dbd', '8493cf52b4a630b881bb235ee121d17c', '2015-03-24 23:00:00', 1),
(3, 'tutu', 'tutu', 'tutu', '4cecb6cfba32ffba55400fccb7086f0b9bd52b44b1af40bd818a5171d29edd85', 'e7d188513a6f973f16010ae88ca6ba41', '2015-03-25 22:08:28', 1),
(4, 'aurelien', 'toto', 'totis', 'e263215d3c0d74c1d74924627fd0b9b8fdb3f1b4185f5a33be03007ea2510e4b', 'a91c2f6c452065cd36704d9d0d2873dc', '2015-05-19 12:33:49', 1);

--
-- Déclencheurs `compte`
--
DELIMITER //
CREATE TRIGGER `insCmpt` BEFORE INSERT ON `compte`
 FOR EACH ROW BEGIN
	SET NEW.salt = md5(uuid());            
	SET NEW.password =SHA2(CONCAT(NEW.password,NEW.salt),256);            
END
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `updCmpt` BEFORE UPDATE ON `compte`
 FOR EACH ROW BEGIN
	IF ( NEW.password <> OLD.password ) THEN
		SET NEW.salt = md5(uuid());            
		SET NEW.password =SHA2(CONCAT(NEW.password,NEW.salt),256); 
	ELSE
		SET NEW.salt = OLD.salt;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `diffusionregions`
--

CREATE TABLE IF NOT EXISTS `diffusionregions` (
  `idVideo` int(8) NOT NULL,
  `idRegion` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `diffusionregions`
--

INSERT INTO `diffusionregions` (`idVideo`, `idRegion`) VALUES
(2, 5),
(9, 5),
(10, 5),
(11, 5),
(12, 5),
(4, 6),
(11, 6),
(5, 7),
(9, 14),
(10, 14),
(3, 17),
(9, 17),
(9, 21),
(12, 21),
(13, 21),
(13, 30);

-- --------------------------------------------------------

--
-- Structure de la table `diffusions`
--

CREATE TABLE IF NOT EXISTS `diffusions` (
`idDiffusion` int(8) NOT NULL,
  `idVideo` int(8) NOT NULL,
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL,
  `dateDiffusion` datetime NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `diffusions`
--

INSERT INTO `diffusions` (`idDiffusion`, `idVideo`, `idMagasin`, `idTypeRayon`, `dateDiffusion`) VALUES
(1, 2, 3, 5, '2015-04-23 16:00:00'),
(2, 2, 3, 6, '2015-04-23 16:00:00'),
(3, 5, 3, 4, '2015-04-24 13:00:00'),
(5, 5, 7, 5, '2015-04-22 09:00:00'),
(6, 5, 7, 5, '2015-04-22 10:00:00'),
(7, 4, 5, 9, '2015-04-29 10:00:00'),
(8, 4, 5, 5, '2015-04-29 20:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `diffusionstypesrayons`
--

CREATE TABLE IF NOT EXISTS `diffusionstypesrayons` (
  `idVideo` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `diffusionstypesrayons`
--

INSERT INTO `diffusionstypesrayons` (`idVideo`, `idTypeRayon`) VALUES
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(4, 2),
(11, 2),
(9, 3),
(10, 3),
(12, 3),
(13, 3),
(10, 4),
(5, 5),
(5, 6),
(4, 7),
(9, 7),
(12, 7),
(13, 7),
(3, 8),
(2, 9),
(9, 9),
(11, 9),
(12, 9);

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE IF NOT EXISTS `entreprise` (
`idEntreprise` int(8) NOT NULL,
  `nom` varchar(64) CHARACTER SET utf8 NOT NULL,
  `adresse` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `code` char(5) CHARACTER SET utf8 NOT NULL,
  `ville` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `telephone` varchar(10) CHARACTER SET utf8 NOT NULL,
  `mail` varchar(32) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `entreprise`
--

INSERT INTO `entreprise` (`idEntreprise`, `nom`, `adresse`, `code`, `ville`, `telephone`, `mail`) VALUES
(1, 'HYPERMARCHE', '22 Avenue Lelons', '75000', 'Paris', '0555662020', 'regub@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `magasin`
--

CREATE TABLE IF NOT EXISTS `magasin` (
`idMagasin` int(11) NOT NULL,
  `nom` varchar(32) NOT NULL,
  `addr_ligne1` varchar(32) DEFAULT NULL,
  `addr_ligne2` varchar(32) DEFAULT NULL,
  `code_postal` char(5) NOT NULL,
  `idRegion` int(8) NOT NULL,
  `ville` varchar(64) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Contenu de la table `magasin`
--

INSERT INTO `magasin` (`idMagasin`, `nom`, `addr_ligne1`, `addr_ligne2`, `code_postal`, `idRegion`, `ville`) VALUES
(1, 'Carouf', '3 rue de la soif', 'les 7 chemins', '87100', 17, 'Limoges'),
(2, 'U', 'Avenue Emile Labussiere', '', '87100', 17, 'Limoges'),
(3, 'Alinéa', 'Rue Amédée Gordini ', '', '87280', 17, 'Limoges'),
(4, 'Fnac', '8 rue des Combles', '', '87000', 17, 'Limoges'),
(5, 'Micromania', '101 Avenue du Général de Gaulle', '', '94000', 14, 'Créteil'),
(6, 'Galeries Lafayette', '6 Rue Porte Tourny', '', '87000', 17, 'Limoges'),
(7, 'Darty ', 'Rue Thomas Dumorey', '', '71100', 5, 'Chalon-Sur-Saone'),
(8, 'Conforama', '1 Rue Gaston Plante', '', '29200', 6, 'Brest'),
(9, 'Conforama', 'Rue de la Chartreuse', '', '56100', 6, 'Lorient'),
(10, 'Darty', 'Rue de la Tuilerie Porte de Gram', '', '31130', 21, 'Toulouse'),
(11, 'aldy', 'rue de monpassant', '', '13000', 30, 'Marseille');

-- --------------------------------------------------------

--
-- Structure de la table `rayons`
--

CREATE TABLE IF NOT EXISTS `rayons` (
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `rayons`
--

INSERT INTO `rayons` (`idMagasin`, `idTypeRayon`) VALUES
(1, 1),
(6, 1),
(1, 2),
(2, 3),
(5, 3),
(6, 3),
(2, 4),
(3, 4),
(5, 4),
(6, 4),
(2, 7),
(6, 7),
(5, 8),
(5, 9);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE IF NOT EXISTS `region` (
`idRegion` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Contenu de la table `region`
--

INSERT INTO `region` (`idRegion`, `libelle`) VALUES
(1, 'Alsace'),
(2, 'Aquitaine'),
(3, 'Auvergne'),
(4, 'Basse-Normandie'),
(30, 'batchanou'),
(5, 'Bourgogne'),
(6, 'Bretagne'),
(7, 'Centre'),
(8, 'Champagne-Ardenne'),
(9, 'Corse'),
(10, 'Franche-Comté'),
(11, 'Guadeloupe'),
(12, 'Guyane'),
(13, 'Haute-Normandie'),
(14, 'Île-de-France'),
(15, 'La Réunion'),
(16, 'Languedoc-Roussillon'),
(17, 'Limousin'),
(18, 'Lorraine'),
(19, 'Martinique'),
(20, 'Mayotte'),
(21, 'Midi-Pyrénées'),
(22, 'Nord-Pas-de-Calais'),
(23, 'Pays de la Loire'),
(24, 'Picardie'),
(25, 'Poitou-Charentes'),
(26, 'Provence-Alpes-Côte d''Azur'),
(27, 'Rhône-Alpes');

-- --------------------------------------------------------

--
-- Structure de la table `typecompte`
--

CREATE TABLE IF NOT EXISTS `typecompte` (
`idTypeCompte` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL,
  `dblogin` varchar(64) NOT NULL,
  `dbpassword` varchar(64) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `typecompte`
--

INSERT INTO `typecompte` (`idTypeCompte`, `libelle`, `dblogin`, `dbpassword`) VALUES
(1, 'administrateur', 'adm', 'adm'),
(2, 'commercial', 'com', 'com'),
(3, 'gestionnaire', 'ges', 'ges');

-- --------------------------------------------------------

--
-- Structure de la table `typerayon`
--

CREATE TABLE IF NOT EXISTS `typerayon` (
`idTypeRayon` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `typerayon`
--

INSERT INTO `typerayon` (`idTypeRayon`, `libelle`) VALUES
(5, 'Boucherie'),
(2, 'Charcuterie'),
(9, 'Crèmerie'),
(8, 'Frais'),
(6, 'Fruits et Légumes '),
(1, 'Poissonerie'),
(3, 'Soins femmes'),
(7, 'Vins'),
(4, 'Volaille');

-- --------------------------------------------------------

--
-- Structure de la table `video`
--

CREATE TABLE IF NOT EXISTS `video` (
`idVideo` int(8) NOT NULL,
  `titre` varchar(32) NOT NULL,
  `frequence` int(11) NOT NULL,
  `duree` int(11) NOT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `dateReception` date NOT NULL,
  `dateValidation` date NOT NULL,
  `tarif` double NOT NULL,
  `statut` int(1) NOT NULL,
  `idCommercial` int(8) NOT NULL,
  `idClient` int(8) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Contenu de la table `video`
--

INSERT INTO `video` (`idVideo`, `titre`, `frequence`, `duree`, `dateDebut`, `dateFin`, `dateReception`, `dateValidation`, `tarif`, `statut`, `idCommercial`, `idClient`) VALUES
(2, 'Test', 3, 26, '2015-04-16', '2015-05-21', '2015-03-11', '2015-03-13', 25, 3, 1, 1),
(3, 'Controlla', 4, 30, '2015-03-11', '2015-05-30', '2015-03-31', '2015-03-27', 111, 1, 2, 45),
(4, 'Danza kuduro', 7, 100, '2015-03-26', '2015-06-19', '2015-03-23', '2015-03-27', 155, 1, 2, 46),
(5, 'Ser Exclu', 2, 85, '2015-03-18', '2015-07-16', '2015-03-01', '2015-03-02', 1222, 1, 1, 47),
(9, 'test', 10, 10, '2015-05-20', '2015-05-21', '2015-05-19', '2015-05-19', 10, 3, 1, 1),
(10, 'm', 12, 10, '2015-05-22', '2015-05-21', '2015-05-21', '2015-05-21', 12, 3, 1, 52),
(11, '8.mp4', 10, 12, '2015-05-22', '2015-05-21', '2015-05-21', '2015-05-21', 1, 3, 1, 52),
(12, 'TestLons', 6, 8, '2015-10-20', '2015-10-24', '2015-10-20', '2015-10-20', 1.2, 1, 1, 50),
(13, 'Retest', 2, 2, '2015-11-17', '2015-11-17', '2015-11-16', '2015-11-16', 2, 1, 1, 1);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
 ADD PRIMARY KEY (`idClient`);

--
-- Index pour la table `compte`
--
ALTER TABLE `compte`
 ADD PRIMARY KEY (`idCompte`), ADD UNIQUE KEY `login` (`login`), ADD KEY `idTypeCompte` (`idTypeCompte`);

--
-- Index pour la table `diffusionregions`
--
ALTER TABLE `diffusionregions`
 ADD PRIMARY KEY (`idVideo`,`idRegion`), ADD KEY `fk_idRegion` (`idRegion`);

--
-- Index pour la table `diffusions`
--
ALTER TABLE `diffusions`
 ADD PRIMARY KEY (`idDiffusion`), ADD KEY `idVideo` (`idVideo`), ADD KEY `idMagasin` (`idMagasin`), ADD KEY `idTypeRayon` (`idTypeRayon`);

--
-- Index pour la table `diffusionstypesrayons`
--
ALTER TABLE `diffusionstypesrayons`
 ADD PRIMARY KEY (`idVideo`,`idTypeRayon`), ADD KEY `fk_typerayon` (`idTypeRayon`);

--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
 ADD PRIMARY KEY (`idEntreprise`);

--
-- Index pour la table `magasin`
--
ALTER TABLE `magasin`
 ADD PRIMARY KEY (`idMagasin`), ADD KEY `idRegion` (`idRegion`);

--
-- Index pour la table `rayons`
--
ALTER TABLE `rayons`
 ADD PRIMARY KEY (`idMagasin`,`idTypeRayon`), ADD KEY `fk_typRay` (`idTypeRayon`);

--
-- Index pour la table `region`
--
ALTER TABLE `region`
 ADD PRIMARY KEY (`idRegion`), ADD UNIQUE KEY `libelle` (`libelle`);

--
-- Index pour la table `typecompte`
--
ALTER TABLE `typecompte`
 ADD PRIMARY KEY (`idTypeCompte`);

--
-- Index pour la table `typerayon`
--
ALTER TABLE `typerayon`
 ADD PRIMARY KEY (`idTypeRayon`), ADD UNIQUE KEY `libelle` (`libelle`);

--
-- Index pour la table `video`
--
ALTER TABLE `video`
 ADD PRIMARY KEY (`idVideo`), ADD KEY `idCommercial` (`idCommercial`), ADD KEY `idClient` (`idClient`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
MODIFY `idClient` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT pour la table `compte`
--
ALTER TABLE `compte`
MODIFY `idCompte` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `diffusions`
--
ALTER TABLE `diffusions`
MODIFY `idDiffusion` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pour la table `entreprise`
--
ALTER TABLE `entreprise`
MODIFY `idEntreprise` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `magasin`
--
ALTER TABLE `magasin`
MODIFY `idMagasin` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `region`
--
ALTER TABLE `region`
MODIFY `idRegion` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT pour la table `typecompte`
--
ALTER TABLE `typecompte`
MODIFY `idTypeCompte` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `typerayon`
--
ALTER TABLE `typerayon`
MODIFY `idTypeRayon` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT pour la table `video`
--
ALTER TABLE `video`
MODIFY `idVideo` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

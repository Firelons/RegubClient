-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- G�n�r� le le: Ven 13 Novembre 2015 � 12:48
-- Version du serveur: 5.5.44-MariaDB-1ubuntu0.14.04.1
-- Version de PHP: 5.5.9-1ubuntu4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de donn�es :  `regub`
--

DELIMITER $$
--
-- Proc�dures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLogin`(IN `log` VARCHAR(64) CHARSET utf8, IN `pass` VARCHAR(64) CHARSET utf8)
    NO SQL
    DETERMINISTIC
BEGIN
	SELECT Compte.idCompte AS id, Compte.nom,Compte.prenom,Compte.login,Compte.creation,TypeCompte.libelle AS type,TypeCompte.dblogin,TypeCompte.dbpassword
	FROM Compte INNER JOIN TypeCompte ON Compte.idTypeCompte = TypeCompte.idTypeCompte
	WHERE (log = Compte.login AND Compte.password = SHA2( CONCAT( pass , Compte.salt),256));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkLogin`(IN `email` VARCHAR(32) CHARSET utf8, IN `mdp` VARCHAR(64) CHARSET utf8)
    NO SQL
    DETERMINISTIC
BEGIN
	SELECT Client.idClient AS id, Client.societe,Client.telephone,Client.email,Client.addr_ligne1,Client.salt,Client.assr_ligne2,Client.ville,Client.code_postal,Client.mot_de_passe
	FROM Client 
	WHERE (email = Client.email AND Client.mot_de_passe = SHA2( CONCAT( mdp , Client.salt),256));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updcli`(IN `email` VARCHAR(32) CHARSET utf8, IN `oldpass` VARCHAR(64) CHARSET utf8, IN `newpass` VARCHAR(64) CHARSET utf8)
    NO SQL
BEGIN
	DECLARE cli INT(10);

	SELECT COUNT(*) INTO cli
	FROM `Client` 
	WHERE(`Client`.`email` = email AND `Client`.`mot_de_passe` = SHA2(CONCAT(oldpass,Client.salt),256));
	IF cli =1 THEN
		UPDATE `Client`
		SET `mot_de_passe` = newpass
		WHERE(`Client`.`email` = email AND
      		`Client`.`mot_de_passe` = SHA2(CONCAT(oldpass,Compte.salt),256));  
	END IF;
    SELECT cmpt;
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
-- Structure de la table `Client`
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
  `salt` char(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `client`
--


INSERT INTO `client` (`idClient`, `societe`, `telephone`, `email`, `addr_ligne1`, `addr_ligne2`, `ville`, `code_postal`,`mot_de_passe`,`salt`) VALUES
(1, 'TF1', '0606060606', 'tf1@gmail.com', '10 rue de la loi', '', 'Paris', '75000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(3, 'Camlait', '0647696161', 'lons@lons.fr', '43 rue du petit tour', '', 'Limoges', '87000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(45, '3il', '0555316729', 'e3il@3il.fr', '43 rue Sainte-Anne', '', 'Limoges', '87000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(46, 'Carrefour', '0555500370', 'panelcarrefour@cospirit.com', '36 Avenue Baudin\r\n', '', 'Limoges', '87000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(47, 'Intermarche', '0800008180', 'landryl@yahoo.com', '24 rue Auguste Chabrieres ', '', ' Paris', '75737','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(48, 'Leclerc', '0800865286', 'Francklin@yahoo.com', 'Rue Henri Giffard', '', 'Limoges', '87280','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(49, 'Leader Price', '0782584292', 'leader@yahoo.com', 'Rue de la soif', '', 'Lyon', '69000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(50, 'Ginseng', '0641295609', 'ginseng@yahoo.fr', 'Rue des Tanniers', '', 'Lille', '59000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86'),
(51, 'Leader mESMER', '067582235', 'leaderm@yahoo.com', 'Rue de la merde', NULL, 'Lyon', '69000','fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86');

--
-- D�clencheurs `client`
--

DELIMITER $$
CREATE TRIGGER `insCli` BEFORE INSERT ON `client`
FOR EACH ROW BEGIN
	SET NEW.salt = md5(uuid());            
	SET NEW.mot_de_passe =SHA2(CONCAT(NEW.mot_de_passe,NEW.salt),256);            
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `updCli` BEFORE UPDATE ON `client`
 FOR EACH ROW BEGIN
	IF ( NEW.mot_de_passe <> OLD.mot_de_passe ) THEN
		SET NEW.salt = md5(uuid());            
		SET NEW.mot_de_passe =SHA2(CONCAT(NEW.mot_de_passe,NEW.salt),256); 
	ELSE
		SET NEW.salt = OLD.salt;
	END IF;
END
$$
DELIMITER ;



-- --------------------------------------------------------

--
-- Structure de la table `Compte`
--

CREATE TABLE IF NOT EXISTS `Compte` (
  `idCompte` int(8) NOT NULL AUTO_INCREMENT,
  `nom` varchar(32) NOT NULL,
  `prenom` varchar(32) NOT NULL,
  `login` varchar(32) NOT NULL,
  `password` char(64) NOT NULL,
  `salt` char(32) NOT NULL,
  `creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idTypeCompte` int(8) NOT NULL,
  PRIMARY KEY (`idCompte`),
  UNIQUE KEY `login` (`login`),
  KEY `idTypeCompte` (`idTypeCompte`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `Compte`
--

INSERT INTO `Compte` (`idCompte`, `nom`, `prenom`, `login`, `password`, `salt`, `creation`, `idTypeCompte`) VALUES
(1, 'toto', 'toto', 'toto', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', '2015-03-17 23:00:00', 2),
(2, 'titi', 'titi', 'titi', 'a90dacbe58f3aa6825c04ff467030b36472ef80fbca958934871d1a73a8c4dbd', '8493cf52b4a630b881bb235ee121d17c', '2015-03-24 23:00:00', 1),
(3, 'tutu', 'tutu', 'tutu', '4cecb6cfba32ffba55400fccb7086f0b9bd52b44b1af40bd818a5171d29edd85', 'e7d188513a6f973f16010ae88ca6ba41', '2015-03-25 22:08:28', 1),
(4, 'aurelien', 'toto', 'totis', 'e263215d3c0d74c1d74924627fd0b9b8fdb3f1b4185f5a33be03007ea2510e4b', 'a91c2f6c452065cd36704d9d0d2873dc', '2015-05-19 12:33:49', 1);

--
-- Déclencheurs `Compte`
--
DROP TRIGGER IF EXISTS `insCmpt`;
DELIMITER //
CREATE TRIGGER `insCmpt` BEFORE INSERT ON `Compte`
 FOR EACH ROW BEGIN
	SET NEW.salt = md5(uuid());            
	SET NEW.password =SHA2(CONCAT(NEW.password,NEW.salt),256);            
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `updCmpt`;
DELIMITER //
CREATE TRIGGER `updCmpt` BEFORE UPDATE ON `Compte`
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
-- Structure de la table `DiffusionRegions`
--

CREATE TABLE IF NOT EXISTS `DiffusionRegions` (
  `idVideo` int(8) NOT NULL,
  `idRegion` int(8) NOT NULL,
  PRIMARY KEY (`idVideo`,`idRegion`),
  KEY `fk_idRegion` (`idRegion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `DiffusionRegions`
--

INSERT INTO `DiffusionRegions` (`idVideo`, `idRegion`) VALUES
(2, 5),
(3, 17),
(4, 6),
(5, 7),
(9, 5),
(9, 14),
(9, 17),
(9, 21),
(10, 5),
(10, 14),
(11, 5),
(11, 6),
(12, 5),
(12, 21);

-- --------------------------------------------------------

--
-- Structure de la table `Diffusions`
--

CREATE TABLE IF NOT EXISTS `Diffusions` (
  `idDiffusion` int(8) NOT NULL AUTO_INCREMENT,
  `idVideo` int(8) NOT NULL,
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL,
  `dateDiffusion` datetime NOT NULL,
  PRIMARY KEY (`idDiffusion`),
  KEY `idVideo` (`idVideo`),
  KEY `idMagasin` (`idMagasin`),
  KEY `idTypeRayon` (`idTypeRayon`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `Diffusions`
--

INSERT INTO `Diffusions` (`idDiffusion`, `idVideo`, `idMagasin`, `idTypeRayon`, `dateDiffusion`) VALUES
(1, 2, 3, 5, '2015-04-23 16:00:00'),
(2, 2, 3, 6, '2015-04-23 16:00:00'),
(3, 5, 3, 4, '2015-04-24 13:00:00'),
(5, 5, 7, 5, '2015-04-22 09:00:00'),
(6, 5, 7, 5, '2015-04-22 10:00:00'),
(7, 4, 5, 9, '2015-04-29 10:00:00'),
(8, 4, 5, 5, '2015-04-29 20:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `DiffusionsTypesRayons`
--

CREATE TABLE IF NOT EXISTS `DiffusionsTypesRayons` (
  `idVideo` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL,
  PRIMARY KEY (`idVideo`,`idTypeRayon`),
  KEY `fk_typerayon` (`idTypeRayon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `DiffusionsTypesRayons`
--

INSERT INTO `DiffusionsTypesRayons` (`idVideo`, `idTypeRayon`) VALUES
(2, 1),
(2, 9),
(3, 1),
(3, 8),
(4, 1),
(4, 2),
(4, 7),
(5, 1),
(5, 5),
(5, 6),
(9, 3),
(9, 7),
(9, 9),
(10, 3),
(10, 4),
(11, 2),
(11, 9),
(12, 3),
(12, 7),
(12, 9);

-- --------------------------------------------------------

--
-- Structure de la table `Magasin`
--

CREATE TABLE IF NOT EXISTS `Magasin` (
  `idMagasin` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(32) NOT NULL,
  `addr_ligne1` varchar(32) DEFAULT NULL,
  `addr_ligne2` varchar(32) DEFAULT NULL,
  `code_postal` char(5) NOT NULL,
  `idRegion` int(8) NOT NULL,
  `ville` varchar(64) NOT NULL,
  PRIMARY KEY (`idMagasin`),
  KEY `idRegion` (`idRegion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Contenu de la table `Magasin`
--

INSERT INTO `Magasin` (`idMagasin`, `nom`, `addr_ligne1`, `addr_ligne2`, `code_postal`, `idRegion`, `ville`) VALUES
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
-- Structure de la table `Rayons`
--

CREATE TABLE IF NOT EXISTS `Rayons` (
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL,
  PRIMARY KEY (`idMagasin`,`idTypeRayon`),
  KEY `fk_typRay` (`idTypeRayon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `Rayons`
--

INSERT INTO `Rayons` (`idMagasin`, `idTypeRayon`) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 7),
(3, 4),
(5, 3),
(5, 4),
(5, 8),
(5, 9),
(6, 1),
(6, 3),
(6, 4),
(6, 7);

-- --------------------------------------------------------

--
-- Structure de la table `Region`
--

CREATE TABLE IF NOT EXISTS `Region` (
  `idRegion` int(8) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(32) NOT NULL,
  PRIMARY KEY (`idRegion`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Contenu de la table `Region`
--

INSERT INTO `Region` (`idRegion`, `libelle`) VALUES
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
-- Structure de la table `TypeCompte`
--

CREATE TABLE IF NOT EXISTS `TypeCompte` (
  `idTypeCompte` int(8) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(32) NOT NULL,
  `dblogin` varchar(64) NOT NULL,
  `dbpassword` varchar(64) NOT NULL,
  PRIMARY KEY (`idTypeCompte`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `TypeCompte`
--

INSERT INTO `TypeCompte` (`idTypeCompte`, `libelle`, `dblogin`, `dbpassword`) VALUES
(1, 'administrateur', 'adm', 'adm'),
(2, 'commercial', 'com', 'com'),
(3, 'gestionnaire', 'ges', 'ges');

-- --------------------------------------------------------

--
-- Structure de la table `TypeRayon`
--

CREATE TABLE IF NOT EXISTS `TypeRayon` (
  `idTypeRayon` int(8) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(32) NOT NULL,
  PRIMARY KEY (`idTypeRayon`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `TypeRayon`
--

INSERT INTO `TypeRayon` (`idTypeRayon`, `libelle`) VALUES
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
-- Structure de la table `Video`
--

CREATE TABLE IF NOT EXISTS `Video` (
  `idVideo` int(8) NOT NULL AUTO_INCREMENT,
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
  `idClient` int(8) NOT NULL,
  PRIMARY KEY (`idVideo`),
  KEY `idCommercial` (`idCommercial`),
  KEY `idClient` (`idClient`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `Video`
--

INSERT INTO `Video` (`idVideo`, `titre`, `frequence`, `duree`, `dateDebut`, `dateFin`, `dateReception`, `dateValidation`, `tarif`, `statut`, `idCommercial`, `idClient`) VALUES
(2, 'Test', 3, 26, '2015-04-16', '2015-05-21', '2015-03-11', '2015-03-13', 25, 3, 1, 1),
(3, 'Controlla', 4, 30, '2015-03-11', '2015-05-30', '2015-03-31', '2015-03-27', 111, 1, 2, 45),
(4, 'Danza kuduro', 7, 100, '2015-03-26', '2015-06-19', '2015-03-23', '2015-03-27', 155, 1, 2, 46),
(5, 'Ser Exclu', 2, 85, '2015-03-18', '2015-07-16', '2015-03-01', '2015-03-02', 1222, 1, 1, 47),
(9, 'test', 10, 10, '2015-05-20', '2015-05-21', '2015-05-19', '2015-05-19', 10, 3, 1, 1),
(10, 'm', 12, 10, '2015-05-22', '2015-05-21', '2015-05-21', '2015-05-21', 12, 3, 1, 52),
(11, '8.mp4', 10, 12, '2015-05-22', '2015-05-21', '2015-05-21', '2015-05-21', 1, 3, 1, 52),
(12, 'TestLons', 6, 8, '2015-10-20', '2015-10-24', '2015-10-20', '2015-10-20', 1.2, 1, 1, 50);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Compte`
--
ALTER TABLE `Compte`
  ADD CONSTRAINT `foreikeyTypeCompte` FOREIGN KEY (`idTypeCompte`) REFERENCES `TypeCompte` (`idTypeCompte`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `DiffusionRegions`
--
ALTER TABLE `DiffusionRegions`
  ADD CONSTRAINT `DiffusionRegions_ibfk_1` FOREIGN KEY (`idVideo`) REFERENCES `Video` (`idVideo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_idRegion` FOREIGN KEY (`idRegion`) REFERENCES `Region` (`idRegion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `Diffusions`
--
ALTER TABLE `Diffusions`
  ADD CONSTRAINT `fk_magasin` FOREIGN KEY (`idMagasin`) REFERENCES `Magasin` (`idMagasin`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `foreikeyTypeRayon` FOREIGN KEY (`idTypeRayon`) REFERENCES `TypeRayon` (`idTypeRayon`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `foreikeyVideo` FOREIGN KEY (`idVideo`) REFERENCES `Video` (`idVideo`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `DiffusionsTypesRayons`
--
ALTER TABLE `DiffusionsTypesRayons`
  ADD CONSTRAINT `fk_typerayon` FOREIGN KEY (`idTypeRayon`) REFERENCES `TypeRayon` (`idTypeRayon`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `foreikeyidVideo` FOREIGN KEY (`idVideo`) REFERENCES `Video` (`idVideo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Magasin`
--
ALTER TABLE `Magasin`
  ADD CONSTRAINT `fk_region` FOREIGN KEY (`idRegion`) REFERENCES `Region` (`idRegion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `Rayons`
--
ALTER TABLE `Rayons`
  ADD CONSTRAINT `fk_typRay` FOREIGN KEY (`idTypeRayon`) REFERENCES `TypeRayon` (`idTypeRayon`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `foreikeyMagasin` FOREIGN KEY (`idMagasin`) REFERENCES `Magasin` (`idMagasin`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `Video`
--
ALTER TABLE `Video`
  ADD CONSTRAINT `fk_client` FOREIGN KEY (`idClient`) REFERENCES `Client` (`idClient`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `foreikeyCom` FOREIGN KEY (`idCommercial`) REFERENCES `Compte` (`idCompte`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

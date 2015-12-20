-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 07 Décembre 2015 à 12:36
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=104 ;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`idClient`, `societe`, `telephone`, `email`, `addr_ligne1`, `addr_ligne2`, `ville`, `code_postal`, `mot_de_passe`, `salt`, `valide`) VALUES
(1, 'TF1', '0624912564', 'tf1@gmail.com', '10 rue de la loi', '', 'Paris', '75000', 'ebb918fc66572e10029d05e49cc2b2256d7728e7a985c740805d110fc0f5189e', 'ec746e58619f5c757d1eb91e4eb10571', 1),
(3, 'Camlait', '0647696161', 'lons@lons.fr', '43 rue du petit tour', '', 'Limoges', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(45, '3il', '0555316729', 'e3il@3il.fr', '43 rue Sainte-Anne', '', 'Limoges', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(46, 'Carrefour', '0555500370', 'panelcarrefour@cospirit.com', '36 Avenue Baudin\r\n', '', 'Limoges', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(47, 'Intermarche', '0800008180', 'landryl@yahoo.com', '24 rue Auguste Chabrieres ', '', ' Paris', '75737', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(48, 'Leclerc', '0800865286', 'Francklin@yahoo.com', 'Rue Henri Giffard', '', 'Limoges', '87280', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(50, 'lagoma', '55222', 'fjkd@kdokdlm.com', 'rueee', NULL, 'jiji', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(52, 'mesmer', '0625649875', 'm@g.fr', '45 rue fjknlk', NULL, 'l,lfsk', '05611', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 0),
(57, 'yu', 'yu', 'yu@ft.fop', 'yu', 'yu', 'yu', 'yuyyu', '79c1d49d56ec48dafc5bb45bb7c777309a1e1a98553e5e112414644cc6521b91', '05620579050a1f4486f3effd7e50426e', 0),
(58, 'Messy', '0624912407', 'mesmerloic@gmail.com', '185 avenue Alber thomas', '', 'Limoges', '87100', 'c63d9e996e6d8c43185a1842e815c1a9ea2c3689936b5694738af4512f01d742', '0cf186aef6c797ce83e8f09b49d2b3d3', 0),
(59, 'Messy', '0624912407', 'mesmerloic@gmail.com', '185 avenue Alber thomas', '', 'Limoges', '87100', 'e57950c5706f6486834bd5532d3b0cad63d94080cc5143fc679b3f1eb5fdfc68', 'f1c7d90b33dcb48cf956b921933b4030', 0),
(102, 'uy', 'yu', 'mesmerloic@gmail.com', 'yu', 'yuy', 'yu', 'u', '4d5654297c1bd3ff0c816ba419c312008e183ce5d381ee628fa06babc85d585e', 'c0eb6706f4274c91ee69b97de8968d0a', 1),
(103, 'io', 'io', 'mesmerloic@gmail.com', 'io', 'io', 'io', 'io', 'b489116259ca531e15f8e3687f58fd9bdf870ff0210cdd8a9afc8ad6595cf457', '27c4341f2c1824ac1f06b344e04c0d06', 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `entreprise`
--

INSERT INTO `entreprise` (`idEntreprise`, `nom`, `adresse`, `code`, `ville`, `telephone`, `mail`) VALUES
(1, 'HYPERMARCHE', '22 Avenue Lelons', '75000', 'Paris', '0555662020', 'regub@gmail.com'),
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
MODIFY `idClient` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=104;
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
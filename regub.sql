-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 13 Janvier 2016 à 15:11
-- Version du serveur :  10.1.9-MariaDB
-- Version de PHP :  5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `regub`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLogin` (IN `log` VARCHAR(64) CHARSET utf8, IN `pass` VARCHAR(64) CHARSET utf8)  NO SQL
    DETERMINISTIC
BEGIN
	SELECT Compte.idCompte AS id, Compte.nom,Compte.prenom,Compte.login,Compte.creation,TypeCompte.libelle AS type,TypeCompte.dblogin,TypeCompte.dbpassword
	FROM Compte INNER JOIN TypeCompte ON Compte.idTypeCompte = TypeCompte.idTypeCompte
	WHERE (log = Compte.login AND Compte.password = SHA2( CONCAT( pass , Compte.salt),256));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updPass` (IN `login` VARCHAR(64) CHARSET utf8, IN `oldpass` VARCHAR(64) CHARSET utf8, IN `newpass` VARCHAR(64) CHARSET utf8)  NO SQL
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

CREATE TABLE `client` (
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
  `valide` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`idClient`, `societe`, `telephone`, `email`, `addr_ligne1`, `addr_ligne2`, `ville`, `code_postal`, `mot_de_passe`, `salt`, `valide`) VALUES
(1, 'TF1 ', '0606060606', 'tf1@gmail.com', '10 rue de la loi', '', 'Paris', '75000', '9fb68d2dbc4907b4ec57f0927a67e18d48a86ef709c61ccba3e5117a026ece21', 'a2068f59964559d8cfd7ca015593ee09', 1),
(3, 'Camlait', '0647696161', 'lons@lons.fr', '43 rue du petit tour', '', 'Limoges', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(45, '3il', '0555316729', 'e3il@3il.fr', '43 rue Sainte-Anne', '', 'Limoges', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(46, 'Carrefour', '0555500370', 'panelcarrefour@cospirit.com', '36 Avenue Baudin\r\n', '', 'Limoges', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(47, 'Intermarche', '0800008180', 'landryl@yahoo.com', '24 rue Auguste Chabrieres ', '', ' Paris', '75737', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(48, 'Leclerc', '0800865286', 'Francklin@yahoo.com', 'Rue Henri Giffard', '', 'Limoges', '87280', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(50, 'lagoma', '55222', 'fjkd@kdokdlm.com', 'rueee', NULL, 'jiji', '87000', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1),
(52, 'mesmer', '0625649875', 'm@g.fr', '45 rue fjknlk', NULL, 'l,lfsk', '05611', 'fe2ee7f067e9a92ac3ea5d5f8f36efe146100993d5bf7c4a1fe5a9637030ce47', 'e2234b4fb4ee9e3ab61ef18cab406d86', 1);

--
-- Déclencheurs `client`
--
DELIMITER $$
CREATE TRIGGER `insCli` BEFORE INSERT ON `client` FOR EACH ROW BEGIN
	SET NEW.salt = md5(uuid());            
	SET NEW.mot_de_passe =SHA2(CONCAT(NEW.mot_de_passe,NEW.salt),256);            
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updCli` BEFORE UPDATE ON `client` FOR EACH ROW BEGIN
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
-- Structure de la table `compte`
--

CREATE TABLE `compte` (
  `idCompte` int(8) NOT NULL,
  `nom` varchar(32) NOT NULL,
  `prenom` varchar(32) NOT NULL,
  `login` varchar(32) NOT NULL,
  `password` char(64) NOT NULL,
  `salt` char(32) NOT NULL,
  `creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idTypeCompte` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
DELIMITER $$
CREATE TRIGGER `insCmpt` BEFORE INSERT ON `compte` FOR EACH ROW BEGIN
	SET NEW.salt = md5(uuid());            
	SET NEW.password =SHA2(CONCAT(NEW.password,NEW.salt),256);            
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updCmpt` BEFORE UPDATE ON `compte` FOR EACH ROW BEGIN
	IF ( NEW.password <> OLD.password ) THEN
		SET NEW.salt = md5(uuid());            
		SET NEW.password =SHA2(CONCAT(NEW.password,NEW.salt),256); 
	ELSE
		SET NEW.salt = OLD.salt;
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `diffusionregions`
--

CREATE TABLE `diffusionregions` (
  `idVideo` int(8) NOT NULL,
  `idRegion` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `diffusionregions`
--

INSERT INTO `diffusionregions` (`idVideo`, `idRegion`) VALUES
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
(12, 21),
(13, 21),
(13, 30),
(14, 17);

-- --------------------------------------------------------

--
-- Structure de la table `diffusions`
--

CREATE TABLE `diffusions` (
  `idDiffusion` int(8) NOT NULL,
  `idVideo` int(8) NOT NULL,
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL,
  `dateDiffusion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `diffusionstypesrayons`
--

CREATE TABLE `diffusionstypesrayons` (
  `idVideo` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `diffusionstypesrayons`
--

INSERT INTO `diffusionstypesrayons` (`idVideo`, `idTypeRayon`) VALUES
(2, 1),
(2, 9),
(3, 2),
(3, 8),
(4, 1),
(4, 2),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 6),
(9, 2),
(9, 7),
(9, 9),
(10, 2),
(10, 3),
(10, 4),
(11, 2),
(12, 3),
(12, 7),
(12, 9),
(13, 3),
(13, 7),
(14, 1);

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
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
(1, 'HYPERMARCHE', '22 Avenue Lelons', '75000', 'Paris', '0555662020', 'regub@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `magasin`
--

CREATE TABLE `magasin` (
  `idMagasin` int(11) NOT NULL,
  `nom` varchar(32) NOT NULL,
  `addr_ligne1` varchar(32) DEFAULT NULL,
  `addr_ligne2` varchar(32) DEFAULT NULL,
  `code_postal` char(5) NOT NULL,
  `idRegion` int(8) NOT NULL,
  `ville` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `rayons` (
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `rayons`
--

INSERT INTO `rayons` (`idMagasin`, `idTypeRayon`) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 7),
(3, 4),
(5, 2),
(5, 3),
(5, 4),
(5, 8),
(5, 9),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 7);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE `region` (
  `idRegion` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `typecompte` (
  `idTypeCompte` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL,
  `dblogin` varchar(64) NOT NULL,
  `dbpassword` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `typerayon` (
  `idTypeRayon` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `video` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `video`
--

INSERT INTO `video` (`idVideo`, `titre`, `frequence`, `duree`, `dateDebut`, `dateFin`, `dateReception`, `dateValidation`, `tarif`, `statut`, `idCommercial`, `idClient`) VALUES
(0, 'wololo', 10, 12, '2015-11-20', '2015-12-06', '2015-05-21', '2015-05-21', 1, 3, 1, 52),
(1, 'TestLons', 6, 8, '2015-10-20', '2016-01-20', '2015-10-20', '2015-10-20', 1.2, 1, 1, 50),
(2, 'Test', 3, 26, '2015-04-16', '2015-05-21', '2015-03-11', '2015-03-13', 25, 3, 1, 1),
(3, 'Controlla', 4, 5, '2015-11-20', '2016-01-20', '2015-03-31', '2015-03-27', 111, 1, 2, 45),
(4, 'Danza kuduro', 7, 5, '2015-05-19', '2015-10-14', '2015-03-23', '2015-03-27', 155, 1, 2, 46),
(5, 'Ser Exclu', 2, 4, '2015-11-17', '2016-01-20', '2015-03-01', '2015-03-02', 1222, 1, 1, 47),
(6, 'Retest', 2, 2, '2015-11-17', '2015-11-17', '2015-11-16', '2015-11-16', 2, 1, 1, 1),
(7, 'Dernier_Test', 20, 6, '2015-11-23', '2015-12-18', '2015-11-23', '2015-11-23', 1, 1, 1, 1),
(9, 'test', 10, 115, '2015-05-20', '2016-01-20', '2015-05-19', '2015-05-19', 10, 3, 1, 1),
(10, 'm', 12, 10, '2015-05-22', '2015-05-21', '2015-05-21', '2015-05-21', 12, 3, 1, 52);

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
  ADD PRIMARY KEY (`idCompte`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `idTypeCompte` (`idTypeCompte`);

--
-- Index pour la table `diffusionregions`
--
ALTER TABLE `diffusionregions`
  ADD PRIMARY KEY (`idVideo`,`idRegion`),
  ADD KEY `fk_idRegion` (`idRegion`);

--
-- Index pour la table `diffusions`
--
ALTER TABLE `diffusions`
  ADD PRIMARY KEY (`idDiffusion`),
  ADD KEY `idVideo` (`idVideo`),
  ADD KEY `idMagasin` (`idMagasin`),
  ADD KEY `idTypeRayon` (`idTypeRayon`);

--
-- Index pour la table `diffusionstypesrayons`
--
ALTER TABLE `diffusionstypesrayons`
  ADD PRIMARY KEY (`idVideo`,`idTypeRayon`),
  ADD KEY `fk_typerayon` (`idTypeRayon`);

--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD PRIMARY KEY (`idEntreprise`);

--
-- Index pour la table `magasin`
--
ALTER TABLE `magasin`
  ADD PRIMARY KEY (`idMagasin`),
  ADD KEY `idRegion` (`idRegion`);

--
-- Index pour la table `rayons`
--
ALTER TABLE `rayons`
  ADD PRIMARY KEY (`idMagasin`,`idTypeRayon`),
  ADD KEY `fk_typRay` (`idTypeRayon`);

--
-- Index pour la table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`idRegion`),
  ADD UNIQUE KEY `libelle` (`libelle`);

--
-- Index pour la table `typecompte`
--
ALTER TABLE `typecompte`
  ADD PRIMARY KEY (`idTypeCompte`);

--
-- Index pour la table `typerayon`
--
ALTER TABLE `typerayon`
  ADD PRIMARY KEY (`idTypeRayon`),
  ADD UNIQUE KEY `libelle` (`libelle`);

--
-- Index pour la table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`idVideo`),
  ADD KEY `idCommercial` (`idCommercial`),
  ADD KEY `idClient` (`idClient`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `idClient` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT pour la table `compte`
--
ALTER TABLE `compte`
  MODIFY `idCompte` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `diffusions`
--
ALTER TABLE `diffusions`
  MODIFY `idDiffusion` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `entreprise`
--
ALTER TABLE `entreprise`
  MODIFY `idEntreprise` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `magasin`
--
ALTER TABLE `magasin`
  MODIFY `idMagasin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `region`
--
ALTER TABLE `region`
  MODIFY `idRegion` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT pour la table `typecompte`
--
ALTER TABLE `typecompte`
  MODIFY `idTypeCompte` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `typerayon`
--
ALTER TABLE `typerayon`
  MODIFY `idTypeRayon` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT pour la table `video`
--
ALTER TABLE `video`
  MODIFY `idVideo` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

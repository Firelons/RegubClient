-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 03 Décembre 2015 à 16:40
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
  `salt` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `nom`, `prenom`, `login`, `password`, `salt`, `creation`, `idTypeCompte`) VALUES
(1, 'admin', 'admin', 'admin', '0ab121c9d0a4a893e135457cf36835d1aadeb7316b74bea8747b59919cddccc2', 'a95fdafdd1d56646ca7d7014097c4489', '0000-00-00 00:00:00', 1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `diffusionstypesrayons`
--

CREATE TABLE IF NOT EXISTS `diffusionstypesrayons` (
  `idVideo` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `rayons`
--

CREATE TABLE IF NOT EXISTS `rayons` (
  `idMagasin` int(8) NOT NULL,
  `idTypeRayon` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE IF NOT EXISTS `region` (
`idRegion` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Contenu de la table `region`
--

INSERT INTO `region` (`idRegion`, `libelle`) VALUES
(1, 'Alsace'),
(2, 'Aquitaine'),
(3, 'Auvergne'),
(4, 'Basse-Normandie'),
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
(1, 'administrateur', 'regub_adm', 'regub_adm'),
(2, 'commercial', 'regub_com', 'regub_com'),
(3, 'gestionnaire', 'regub_ges', 'regub_ges');

-- --------------------------------------------------------

--
-- Structure de la table `typerayon`
--

CREATE TABLE IF NOT EXISTS `typerayon` (
`idTypeRayon` int(8) NOT NULL,
  `libelle` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
MODIFY `idClient` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `compte`
--
ALTER TABLE `compte`
MODIFY `idCompte` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `diffusions`
--
ALTER TABLE `diffusions`
MODIFY `idDiffusion` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `entreprise`
--
ALTER TABLE `entreprise`
MODIFY `idEntreprise` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `magasin`
--
ALTER TABLE `magasin`
MODIFY `idMagasin` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `region`
--
ALTER TABLE `region`
MODIFY `idRegion` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT pour la table `typecompte`
--
ALTER TABLE `typecompte`
MODIFY `idTypeCompte` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `typerayon`
--
ALTER TABLE `typerayon`
MODIFY `idTypeRayon` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `video`
--
ALTER TABLE `video`
MODIFY `idVideo` int(8) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `compte`
--
ALTER TABLE `compte`
ADD CONSTRAINT `foreikeyTypeCompte` FOREIGN KEY (`idTypeCompte`) REFERENCES `typecompte` (`idTypeCompte`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `diffusionregions`
--
ALTER TABLE `diffusionregions`
ADD CONSTRAINT `DiffusionRegions_ibfk_1` FOREIGN KEY (`idVideo`) REFERENCES `video` (`idVideo`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_idRegion` FOREIGN KEY (`idRegion`) REFERENCES `region` (`idRegion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `diffusions`
--
ALTER TABLE `diffusions`
ADD CONSTRAINT `fk_magasin` FOREIGN KEY (`idMagasin`) REFERENCES `magasin` (`idMagasin`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `foreikeyTypeRayon` FOREIGN KEY (`idTypeRayon`) REFERENCES `typerayon` (`idTypeRayon`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `foreikeyVideo` FOREIGN KEY (`idVideo`) REFERENCES `video` (`idVideo`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `diffusionstypesrayons`
--
ALTER TABLE `diffusionstypesrayons`
ADD CONSTRAINT `fk_typerayon` FOREIGN KEY (`idTypeRayon`) REFERENCES `typerayon` (`idTypeRayon`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `foreikeyidVideo` FOREIGN KEY (`idVideo`) REFERENCES `video` (`idVideo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `magasin`
--
ALTER TABLE `magasin`
ADD CONSTRAINT `fk_region` FOREIGN KEY (`idRegion`) REFERENCES `region` (`idRegion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `rayons`
--
ALTER TABLE `rayons`
ADD CONSTRAINT `fk_typRay` FOREIGN KEY (`idTypeRayon`) REFERENCES `typerayon` (`idTypeRayon`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `foreikeyMagasin` FOREIGN KEY (`idMagasin`) REFERENCES `magasin` (`idMagasin`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `video`
--
ALTER TABLE `video`
ADD CONSTRAINT `fk_client` FOREIGN KEY (`idClient`) REFERENCES `client` (`idClient`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `foreikeyCom` FOREIGN KEY (`idCommercial`) REFERENCES `compte` (`idCompte`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

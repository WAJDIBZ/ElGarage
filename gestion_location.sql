-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 20 mai 2025 à 17:54
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_location`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `CodeClient` int(11) NOT NULL,
  `Ncin` varchar(20) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `Prenom` varchar(50) NOT NULL,
  `NumTel` varchar(15) NOT NULL,
  `Adresse` varchar(255) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `client`
--

-- Données de démonstration supprimées (repo public). Ajoutez vos propres INSERT si besoin.

-- --------------------------------------------------------

--
-- Structure de la table `location`
--

CREATE TABLE `location` (
  `id` int(11) NOT NULL,
  `codeClient` int(11) NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `montant` double NOT NULL,
  `statut` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `location`
--

-- Données de démonstration supprimées (repo public). Ajoutez vos propres INSERT si besoin.

-- --------------------------------------------------------

--
-- Structure de la table `parc`
--

CREATE TABLE `parc` (
  `codeParc` int(11) NOT NULL,
  `nomParc` varchar(50) NOT NULL,
  `capaciteMax` int(11) NOT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `responsable` varchar(100) DEFAULT NULL,
  `telResponsable` varchar(20) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `parc`
--

-- Données de démonstration supprimées (repo public). Ajoutez vos propres INSERT si besoin.

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `client_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `passwordHash` varchar(255) NOT NULL,
  `role` enum('ADMIN','CLIENT') NOT NULL,
  `clientId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

-- Données de démonstration supprimées (repo public). Ajoutez vos propres INSERT si besoin.

-- --------------------------------------------------------

--
-- Structure de la table `vehicule_parc`
--

CREATE TABLE `vehicule_parc` (
  `id` int(11) NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `codeParc` int(11) NOT NULL,
  `dateArrivee` datetime NOT NULL,
  `dateDepart` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vehicule_parc`
--

-- Données de démonstration supprimées (repo public). Ajoutez vos propres INSERT si besoin.

-- --------------------------------------------------------

--
-- Structure de la table `voiture`
--

CREATE TABLE `voiture` (
  `matricule` varchar(20) NOT NULL,
  `marque` varchar(50) NOT NULL,
  `modele` varchar(50) NOT NULL,
  `kilometrage` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `acceleration` double NOT NULL,
  `typeEnergie` varchar(30) NOT NULL,
  `image` varchar(800) DEFAULT NULL,
  `tarif` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `voiture`
--

-- Données de démonstration supprimées (repo public). Ajoutez vos propres INSERT si besoin.

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`CodeClient`),
  ADD UNIQUE KEY `Ncin` (`Ncin`),
  ADD UNIQUE KEY `NumTel` (`NumTel`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Index pour la table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `matricule` (`matricule`),
  ADD KEY `codeClient` (`codeClient`);

--
-- Index pour la table `parc`
--
ALTER TABLE `parc`
  ADD PRIMARY KEY (`codeParc`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UK_sb8bbouer5wak8vyiiy4pf2bx` (`username`),
  ADD UNIQUE KEY `UK_rb7eox526ilbewv2wuv5bnsrt` (`client_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `clientId` (`clientId`);

--
-- Index pour la table `vehicule_parc`
--
ALTER TABLE `vehicule_parc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `matricule` (`matricule`),
  ADD KEY `idx_vp_parc_active` (`codeParc`,`dateDepart`);

--
-- Index pour la table `voiture`
--
ALTER TABLE `voiture`
  ADD PRIMARY KEY (`matricule`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `CodeClient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `parc`
--
ALTER TABLE `parc`
  MODIFY `codeParc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `vehicule_parc`
--
ALTER TABLE `vehicule_parc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`matricule`) REFERENCES `voiture` (`matricule`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`codeClient`) REFERENCES `client` (`CodeClient`);

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FKrl8au09hfjd9742b89li2rb3` FOREIGN KEY (`client_id`) REFERENCES `client` (`CodeClient`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `client` (`CodeClient`);

--
-- Contraintes pour la table `vehicule_parc`
--
ALTER TABLE `vehicule_parc`
  ADD CONSTRAINT `vehicule_parc_ibfk_1` FOREIGN KEY (`matricule`) REFERENCES `voiture` (`matricule`),
  ADD CONSTRAINT `vehicule_parc_ibfk_2` FOREIGN KEY (`codeParc`) REFERENCES `parc` (`codeParc`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

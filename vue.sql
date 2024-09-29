/***********************
** CREATIONS DES VUES **
************************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

--VUE N°1, Réalisé par Roméo BOURDELET--
--Vue permettant de voire les relations entre les personnages--
CREATE OR REPLACE view Relations_personnage (idPersonnage1, SurnomPerso1 ,PrenomPerso1, NomPerso1, idPersonnage2, SurnomPerso2, PrenomPerso2, NomPerso2, TypeRelation)AS(
  SELECT DISTINCT Personnage1, P1.SurnomPersonnage, P1.PrenomPersonnage, P1.NomPersonnage, Personnage1, P2.SurnomPersonnage, P2.PrenomPersonnage, P2.NomPersonnage, TypeRelation
  FROM est_en_lien
  INNER JOIN Personnage P1 ON P1.idPersonnage = Personnage1
  INNER JOIN Personnage P2 ON P2.idPersonnage = Personnage2
);

SELECT * FROM Relations_personnage; 

--VUE N°2, Réalisé par Roméo BOURDELET--
-- Vue permettant de voir quel acteur interprête quel personnage--
CREATE OR REPLACE view Acteur_personnage (NomActeur, PrenomActeur, NomPersonnage, PrenomPersonnage, SurnomPersonnage)AS(
  SELECT Nomindividu,PrenomIndividu,SurnomPersonnage,PrenomPersonnage,NomPersonnage
  FROM INDIVIDU INNER JOIN PERSONNAGE ON INDIVIDU.idIndividu = PERSONNAGE.idPersonnage
);

SELECT * FROM Acteur_personnage; 

--VUE N°3, Réalisé par Estelle BOISSERIE--
--Vue permettant de voir quel réalisateur à réalisé quel épisode--
CREATE OR REPLACE VIEW Realisateur_De (NomRealisateur, PrenomRealisateur, EpisodeRealise, Partie) 
AS(
    SELECT Nomindividu, PrenomIndividu, NumeroEpisode, PartieEpisode
    FROM INDIVIDU
    INNER JOIN EPISODE ON INDIVIDU.idIndividu = EPISODE.idEpisode
    INNER JOIN PARTIE ON EPISODE.PartieEpisode = PARTIE.idPartie
);

SELECT * FROM Realisateur_De ORDER BY NomRealisateur ASC;

--VUE N°4, , Réalisé par Estelle BOISSERIE--
--Vue permettant de voir les personnages non réapparu et quand ils ont disparût--
CREATE OR REPLACE VIEW PersonnageDisparu (NomPersonnage, PrenomPersonnage, EpisodeDisparu, Partie)
AS(
    SELECT PERSONNAGE.NomPersonnage, PERSONNAGE.PrenomPersonnage, PERSONNAGE.DerniereApparition, EPISODE.PartieEpisode
    FROM PERSONNAGE
    INNER JOIN EPISODE ON PERSONNAGE.DerniereApparition = EPISODE.idEpisode
    WHERE PERSONNAGE.DerniereApparition < 30
    OR PERSONNAGE.DerniereApparition IS NULL
);

SELECT * FROM PersonnageDisparu ORDER BY EpisodeDisparu ASC;
/****************************
** CREATIONS DES FONCTIONS **
*****************************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

SET SERVEROUTPUT ON;

--FONCTION N°1, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre d'épisode qu'a réalisé un réalisateur --
CREATE OR REPLACE FUNCTION nbEpisode(NomIndividuRecherche INDIVIDU.Nomindividu%TYPE, PrenomIndividuRecherche INDIVIDU.Prenomindividu%TYPE)
RETURN NUMBER is 
    nbEpisode NUMBER(5) := 0;
    Erreur Exception;
BEGIN
    SELECT COUNT(DISTINCT EPISODE.idEpisode) INTO nbEpisode
    FROM EPISODE
    INNER JOIN INDIVIDU ON EPISODE.Realisateur = INDIVIDU.idIndividu
    WHERE INDIVIDU.nomindividu LIKE(NomIndividuRecherche)
    AND INDIVIDU.prenomindividu LIKE (PrenomIndividuRecherche);
    IF nbEpisode<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbEpisode;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucun épisode.');
    RETURN nbEpisode;
END;
/
DECLARE
BEGIN
DBMS_OUTPUT.PUT_LINE(nbEpisode('Rodrigo','Alex'));
END;
/

--FONCTION N°2, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre de relation d'un personnage --
CREATE OR REPLACE FUNCTION nbRelation(SurnomPersonnageRecherche PERSONNAGE.SurnomPersonnage%TYPE)
RETURN NUMBER is 
    nbRelation NUMBER(5) := 0;
    Erreur EXCEPTION;
BEGIN
    SELECT COUNT(est_en_lien.idLien) INTO nbRelation
    FROM est_en_lien
    INNER JOIN PERSONNAGE p1 ON p1.idPersonnage = est_en_lien.Personnage1
    INNER JOIN PERSONNAGE p2 ON p2.idPersonnage = est_en_lien.Personnage2
    WHERE p1.SurnomPersonnage LIKE(SurnomPersonnageRecherche);
    IF nbRelation<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbRelation;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucune relation');
    RETURN nbRelation;
END;
/
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbRelation('Rio'));
END;
/

--FONCTION N°3, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre d'évènement se déroulant dans un lieu --
CREATE OR REPLACE FUNCTION nbEvenement(NomLieuCherche LIEU.NomLieu%TYPE)
RETURN NUMBER is 
    nbEvenement NUMBER(5) := 0;
    Erreur EXCEPTION;
BEGIN
    SELECT COUNT(EVENEMENT.idEvenement) INTO nbEvenement
    FROM EVENEMENT
    INNER JOIN LIEU ON LIEU.idLieu = EVENEMENT.LieuEvenement
    WHERE Lieu.NomLieu LIKE(NomLieuCherche);
    IF nbEvenement<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbEvenement;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucun évènement');
    RETURN nbEvenement;
END;
/
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbEvenement('Fabrique de la Monnaie'));
END;
/

--FONCTION N°4, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre d'évènement dans une partie --
CREATE OR REPLACE FUNCTION nbEvenement2(PartieCherche EPISODE.PartieEpisode%TYPE)
RETURN NUMBER is 
    nbEvenement NUMBER(5) := 0;
    Erreur EXCEPTION;
BEGIN
    SELECT COUNT(EVENEMENT.idEvenement) INTO nbEvenement
    FROM EVENEMENT
    INNER JOIN EPISODE ON EVENEMENT.EpisodeEvenement = EPISODE.idEpisode
    WHERE EPISODE.PartieEpisode LIKE(PartieCherche);
    IF nbEvenement<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbEvenement;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucun évènement');
    RETURN nbEvenement;
END;
/
DECLARE
BEGIN
DBMS_OUTPUT.PUT_LINE(nbEvenement2(1));
END;
/

--FONCTION N°5, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre d'évènement provoqué par un personnage --
CREATE OR REPLACE FUNCTION nbEvenement3(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE)
RETURN NUMBER is 
    nbEvenement NUMBER(5) := 0;
    Erreur EXCEPTION;
BEGIN
    SELECT COUNT(EVENEMENT.idEvenement) INTO nbEvenement
    FROM EVENEMENT
    INNER JOIN EPISODE ON EPISODE.idEpisode = EVENEMENT.EpisodeEvenement
    INNER JOIN PERSONNAGE ON EPISODE.idEpisode = PERSONNAGE.PremiereApparition
    WHERE PERSONNAGE.NomPersonnage LIKE(NomPersonnageCherche);
    IF nbEvenement<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbEvenement;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucun évènement');
    RETURN nbEvenement;
END;
/
DECLARE
BEGIN
DBMS_OUTPUT.PUT_LINE(nbEvenement3('Ramos'));
END;
/

--FONCTION N°6, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre de morts dans une partie --
CREATE OR REPLACE FUNCTION NbMort(Partie PARTIE.idPartie%TYPE)
RETURN NUMBER is 
    nbMort NUMBER(5) := 0;
    Erreur EXCEPTION;
BEGIN
    SELECT COUNT(PERSONNAGE.idPersonnage) INTO nbMort
    FROM PERSONNAGE
    INNER JOIN EPISODE ON EPISODE.idEpisode = PERSONNAGE.MortPersonnage
    INNER JOIN PARTIE ON EPISODE.PartieEpisode = PARTIE.idPartie
    WHERE PARTIE.idPartie = Partie;
    IF nbMort<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbMort;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucun mort');
    RETURN nbMort;
END;
/
DECLARE
BEGIN
DBMS_OUTPUT.PUT_LINE(nbMort(2));
END;
/
  
--FONCTION N°7, Réalisé par Estelle BOISSERIE--
-- Fonction permettant de compter le nombre d'épisode dans une partie --
CREATE OR REPLACE FUNCTION nbEpisode_Partie(Partie PARTIE.idPartie%TYPE)
RETURN NUMBER is 
    nbEpisode NUMBER(5) := 0;
    Erreur EXCEPTION;
BEGIN
    SELECT COUNT(EPISODE.idEpisode) INTO nbEpisode
    FROM EPISODE
    INNER JOIN PARTIE ON EPISODE.PartieEpisode = PARTIE.idPartie
    WHERE PARTIE.idPartie = Partie;
    IF nbEpisode<=0 THEN RAISE Erreur;
    END IF;
    RETURN nbEpisode;
    EXCEPTION
    WHEN Erreur THEN dbms_output.put_line('ERREUR: il n y a aucun épisode');
    RETURN nbEpisode;
END;
/
DECLARE
BEGIN
DBMS_OUTPUT.PUT_LINE(nbEpisode_Partie(2));
END;
/
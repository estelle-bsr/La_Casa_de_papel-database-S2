/*****************************
** CREATIONS DES PROCEDURES **
******************************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

SET SERVEROUTPUT ON;

--PROCEDURE n°1, Réalisé par Estelle BOISSERIE--
--Procédure permettant de connaître les relations d'un personnage à partir d'un surnom--
CREATE OR REPLACE PROCEDURE RelationDe(SurnomPersonnageCherche PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesRelations is 
    SELECT DISTINCT p2.NomPersonnage, p2.PrenomPersonnage, TypeRelation
        FROM PERSONNAGE p2
        INNER JOIN est_en_lien ON est_en_lien.Personnage1 = p2.idPersonnage
        INNER JOIN PERSONNAGE p1 ON est_en_lien.Personnage2 = p1.idPersonnage
        WHERE p1.SurnomPersonnage LIKE (SurnomPersonnageCherche);
BEGIN
    dbms_output.put_line('Parmi les ' || nbRelation(SurnomPersonnageCherche) || ' il y a : ');
    dbms_output.put_line('');
    FOR UneRelation in LesRelations
    LOOP
        dbms_output.put_line(UneRelation.NomPersonnage || ' ' || UneRelation.PrenomPersonnage || '. Ils sont ' || UneRelation.TypeRelation || '.');
    END LOOP;
    EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Pas de relation existante');
END RelationDe;
/
DECLARE
BEGIN
RelationDe('Rio');
END;
/
--PROCEDURE n°2, Réalisé par Estelle BOISSERIE--
--Procédure permettant de connaître les relations d'un personnage à partir d'un nom et prénom--
CREATE OR REPLACE PROCEDURE RelationParNomDe(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE,PrenomPersonnageCherche PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesRelations is 
    SELECT DISTINCT p2.NomPersonnage, p2.PrenomPersonnage, TypeRelation
        FROM PERSONNAGE p2
        INNER JOIN est_en_lien ON est_en_lien.Personnage1 = p2.idPersonnage
        INNER JOIN PERSONNAGE p1 ON est_en_lien.Personnage2 = p1.idPersonnage
        WHERE p1.NomPersonnage LIKE (NomPersonnageCherche)
        AND p1.PrenomPersonnage LIKE (PrenomPersonnageCherche);
BEGIN
    dbms_output.put_line('Parmi les relations il y a : ');
    dbms_output.put_line('');
    FOR UneRelation in LesRelations
    LOOP
        dbms_output.put_line(UneRelation.NomPersonnage || ' ' || UneRelation.PrenomPersonnage || '. Ils sont ' || UneRelation.TypeRelation || '.');
    END LOOP;
    EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Pas de relation existante');
END RelationParNomDe;
/
DECLARE
BEGIN
RelationParNomDe('Marquina', 'Sergio');
END;
/

  
--PROCEDURE n°3, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de savoir quels évènement ont été causés par un personnage selon son surnom--
CREATE OR REPLACE PROCEDURE Evenement_Cause_Par(SurnomPersonnageCherche PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesEvenement is 
    SELECT DISTINCT DescriptionEvenement
    FROM EVENEMENT 
    INNER JOIN cause_par ON EVENEMENT.idEvenement = cause_par.EvenementProduit
    INNER JOIN PERSONNAGE ON PERSONNAGE.idPersonnage = cause_par.PersonnageDeclencheur
    WHERE PERSONNAGE.SurnomPersonnage LIKE(SurnomPersonnageCherche);
BEGIN
    dbms_output.put_line(SurnomPersonnageCherche || ' a causé : ');
    FOR UnEvenement in LesEvenement
    LOOP
        dbms_output.put_line(UnEvenement.DescriptionEvenement);
    END LOOP;
    EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END Evenement_Cause_Par;
/
DECLARE
BEGIN
Evenement_Cause_Par('Lisbonne');
END;
/
  --PROCEDURE n°4, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de savoir quels évènement ont été causés par un personnage selon son nom et prénom --
CREATE OR REPLACE PROCEDURE Evenement_Cause_Par_Nom(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE,PrenomPersonnageCherche PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesEvenement is 
    SELECT DISTINCT DescriptionEvenement
    FROM EVENEMENT 
    INNER JOIN cause_par ON EVENEMENT.idEvenement = cause_par.EvenementProduit
    INNER JOIN PERSONNAGE ON PERSONNAGE.idPersonnage = cause_par.PersonnageDeclencheur
    WHERE PERSONNAGE.NomPersonnage LIKE (NomPersonnageCherche)
    AND PERSONNAGE.PrenomPersonnage LIKE (PrenomPersonnageCherche);
BEGIN
    dbms_output.put_line(NomPersonnageCherche ||' '|| PrenomPersonnageCherche || ' a causé : ');
    FOR UnEvenement in LesEvenement
    LOOP
        dbms_output.put_line(UnEvenement.DescriptionEvenement);
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END Evenement_Cause_Par_Nom;
/
DECLARE
BEGIN
  Evenement_Cause_Par_Nom('Murillo', 'Raquel');
END;
/
  
--PROCEDURE N°5, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de voir quel lieux ont été visité par un personnage selon son surnom--
CREATE OR REPLACE PROCEDURE A_Visite(SurnomPersonnageCherche PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesVisites is 
    SELECT DISTINCT NomLieu, NomVille, NomPays
    FROM LIEU 
    INNER JOIN VILLE ON LIEU.VilleLieu = VILLE.idVille
    INNER JOIN PAYS ON VILLE.VillePays= PAYS.idPays
    INNER JOIN EVENEMENT ON EVENEMENT.idEvenement = Lieu.idLieu
    INNER JOIN cause_par ON EVENEMENT.idEvenement = cause_par.EvenementProduit
    INNER JOIN PERSONNAGE ON PERSONNAGE.idPersonnage = cause_par.PersonnageDeclencheur
    INNER JOIN EPISODE ON PERSONNAGE.PremiereApparition = EPISODE.idEpisode
    WHERE PERSONNAGE.SurnomPersonnage LIKE(SurnomPersonnageCherche);
BEGIN
    dbms_output.put_line(SurnomPersonnageCherche || ' a visité : ');
    FOR UneVisite in LesVisites
    LOOP
        dbms_output.put_line(UneVisite.NomLieu || ' à ' || UneVisite.NomVille || ' dans le pays de ' || UneVisite.NomPays ||'.');
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun lieu n a été visité');
END A_Visite;
/
DECLARE
BEGIN
A_Visite('Lisbonne');
END;
/
  --PROCEDURE N°6, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de voir quel lieux ont été visité par un personnage selon son nom et prénom--
CREATE OR REPLACE PROCEDURE A_Visite_Nom(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE,PrenomPersonnageCherche PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesVisites is 
    SELECT DISTINCT NomLieu, NomVille, NomPays
    FROM LIEU 
    INNER JOIN VILLE ON LIEU.VilleLieu = VILLE.idVille
    INNER JOIN PAYS ON VILLE.VillePays= PAYS.idPays
    INNER JOIN EVENEMENT ON EVENEMENT.idEvenement = Lieu.idLieu
    INNER JOIN cause_par ON EVENEMENT.idEvenement = cause_par.EvenementProduit
    INNER JOIN PERSONNAGE ON PERSONNAGE.idPersonnage = cause_par.PersonnageDeclencheur
    INNER JOIN EPISODE ON PERSONNAGE.PremiereApparition = EPISODE.idEpisode
    WHERE PERSONNAGE.NomPersonnage LIKE (NomPersonnageCherche)
    AND PERSONNAGE.PrenomPersonnage LIKE (PrenomPersonnageCherche);
BEGIN
    dbms_output.put_line(NomPersonnageCherche ||' '||  PrenomPersonnageCherche || ' a visité : ');
    FOR UneVisite in LesVisites
    LOOP
        dbms_output.put_line(UneVisite.NomLieu || ' à ' || UneVisite.NomVille || ' dans le pays de ' || UneVisite.NomPays ||'.');
    END LOOP;
   EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun lieu a été visité');
END A_Visite_Nom;
/
DECLARE
BEGIN
A_Visite_Nom('Murillo', 'Raquel');
END;
/

  --PROCEDURE N°7, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de voir l'âge d'un personnage selon son nom et prénom--
CREATE OR REPLACE PROCEDURE Nom_Age_De(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE,PrenomPersonnageCherche PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesAges is 
   SELECT AgeIndividu
    FROM INDIVIDU 
    JOIN PERSONNAGE  ON PERSONNAGE.Acteur = INDIVIDU.idIndividu
    WHERE PERSONNAGE.NomPersonnage = NomPersonnageCherche
    AND PERSONNAGE.PrenomPersonnage = PrenomPersonnageCherche;
BEGIN
    dbms_output.put('L acteur de  ' || NomPersonnageCherche ||' '||  PrenomPersonnageCherche || ' est âgé de ');
    FOR UnAge in LesAges
    LOOP
        dbms_output.put_line(UnAge.AgeIndividu|| ' ans.');
    END LOOP;
  EXCEPTION
    WHEN TOO_MANY_ROWS then DBMS_OUTPUT.PUT_LINE('Trop d âge trouvé');
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun âge trouvé');
END Nom_Age_De;
/
DECLARE
BEGIN
Nom_Age_De('Murillo', 'Raquel');
END;
/
  --PROCEDURE N°8, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de voir l'âge d'un personnage selon son surnom--
CREATE OR REPLACE PROCEDURE Age_De(SurnomPersonnageCherche PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesAges is 
   SELECT AgeIndividu
    FROM INDIVIDU 
    JOIN PERSONNAGE  ON PERSONNAGE.Acteur = INDIVIDU.idIndividu
    WHERE PERSONNAGE.SurnomPersonnage = SurnomPersonnageCherche;
BEGIN
    dbms_output.put( 'L''acteur de  ' || SurnomPersonnageCherche || ' est âgé de ');
    FOR UnAge in LesAges
    LOOP
        dbms_output.put_line(UnAge.AgeIndividu|| ' ans.');
    END LOOP;
EXCEPTION
    WHEN TOO_MANY_ROWS then DBMS_OUTPUT.PUT_LINE('Trop d âge trouvé');
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun âge trouvé');
END Age_De;
/
DECLARE
BEGIN
Age_De('Lisbonne');
END;
/

  --PROCEDURE N°9, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de connaître le nombre d'évènement dans une partie--
CREATE OR REPLACE PROCEDURE Nombre_Evenement(PartieCherche PARTIE.idPartie%TYPE)
is
Cursor LesParties is 
   SELECT COUNT(EVENEMENT.idEvenement) AS nbEvenement
    FROM EVENEMENT
    INNER JOIN EPISODE ON EPISODE.idEpisode = EVENEMENT.EpisodeEvenement
    INNER JOIN PARTIE ON EPISODE.PartieEpisode = PARTIE.idPartie
    WHERE PARTIE.idPartie LIKE(PartieCherche);
BEGIN
    FOR UnePartie in LesParties
    LOOP
        dbms_output.put_line('Il s''est déroulé ' || UnePartie.nbEvenement || ' évènement dans la partie ' || PartieCherche || '.' );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END Nombre_Evenement;
/
DECLARE
BEGIN
  Nombre_Evenement(1);
END;
/

  --PROCEDURE N°10, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de connaître le nombre d'évènement dans une partie causé par un personnage selon son nom et prénom--
CREATE OR REPLACE PROCEDURE Nombre_Evenement_Cause_Par(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE, PrenomPersonnageCherche PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesEvenements is 
    SELECT COUNT(EVENEMENT.idEvenement) AS nbEvenement
    FROM EVENEMENT
    INNER JOIN EPISODE ON EPISODE.idEpisode = EVENEMENT.EpisodeEvenement
    INNER JOIN PERSONNAGE ON EPISODE.idEpisode = PERSONNAGE.PremiereApparition
    WHERE PERSONNAGE.NomPersonnage LIKE(NomPersonnageCherche)
    AND PERSONNAGE.PrenomPersonnage LIKE(PrenomPersonnageCherche);
BEGIN
    FOR UnEvenement in LesEvenements
    LOOP
        dbms_output.put_line('Le personnage ' || NomPersonnageCherche ||' '|| PrenomPersonnageCherche ||' a causé ' || UnEvenement.nbEvenement ||' évènements.' );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END Nombre_Evenement_Cause_Par;
/
DECLARE
BEGIN
Nombre_Evenement_Cause_Par('Murillo', 'Raquel');
END;
/
  --PROCEDURE N°11, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de connaître le nombre d'évènement dans une partie causé par un personnage selon son surnom-
CREATE OR REPLACE PROCEDURE Nombre_Evenement_Cause_Par_Surnom(SurnomPersonnageCherche PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesEvenements is 
    SELECT COUNT(EVENEMENT.idEvenement) AS nbEvenement
    FROM EVENEMENT
    INNER JOIN EPISODE ON EPISODE.idEpisode = EVENEMENT.EpisodeEvenement
    INNER JOIN PERSONNAGE ON EPISODE.idEpisode = PERSONNAGE.PremiereApparition
    WHERE PERSONNAGE.SurnomPersonnage LIKE(SurnomPersonnageCherche);
BEGIN
    FOR UnEvenement in LesEvenements
    LOOP
        dbms_output.put_line('Le personnage ' || SurnomPersonnageCherche ||' a causé ' || UnEvenement.nbEvenement ||' évènements.' );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END Nombre_Evenement_Cause_Par_Surnom;
/
DECLARE
BEGIN
  Nombre_Evenement_Cause_Par_Surnom('Lisbonne');
END;
/
  --PROCEDURE N°12, Réalisé par Estelle BOISSERIE--
-- Procédure permettant de savoir quels acteurs sont présent dans une partie--
CREATE OR REPLACE PROCEDURE ActeurPresent(PartieCherche PARTIE.idPartie%TYPE)
is
Cursor LesActeurs is 
    SELECT DISTINCT INDIVIDU.NomIndividu, INDIVIDU.PrenomIndividu
    FROM PERSONNAGE 
    INNER JOIN INDIVIDU ON PERSONNAGE.Acteur = INDIVIDU.idIndividu
    INNER JOIN EPISODE ON PERSONNAGE.PremiereApparition = EPISODE.idEpisode
    INNER JOIN EPISODE ON PERSONNAGE.DerniereApparition = EPISODE.idEpisode
    INNER JOIN EPISODE ON PERSONNAGE.MortPersonnage = EPISODE.idEpisode
    INNER JOIN PARTIE ON EPISODE.PartieEpisode = PARTIE.idPartie
    WHERE PARTIE.idPartie = PartieCherche
    AND PERSONNAGE.PremiereApparition is NOT NULL 
    AND PERSONNAGE.DerniereApparition NOT IN (SELECT PERSONNAGE.DerniereApparition
                                                FROM PERSONNAGE
                                                INNER JOIN EPISODE ON PERSONNAGE.DerniereApparition = EPISODE.idEpisode
                                                INNER JOIN PARTIE ON PARTIE.idPartie = EPISODE.PartieEpisode
                                                WHERE PARTIE.idPartie < PartieCherche)
    AND PERSONNAGE.MortPersonnage NOT IN (SELECT PERSONNAGE.MortPersonnage
                                                FROM PERSONNAGE
                                                INNER JOIN EPISODE ON PERSONNAGE.MortPersonnage = EPISODE.idEpisode
                                                INNER JOIN PARTIE ON PARTIE.idPartie = EPISODE.PartieEpisode
                                                WHERE PARTIE.idPartie < PartieCherche);
BEGIN
    dbms_output.put_line('Les acteurs présents dans la partie ' || PartieCherche || ' sont : ');
    FOR UnActeur in LesActeurs
    LOOP
        dbms_output.put_line(UnActeur.NomIndividu || ' ' || UnActeur.PrenomIndividu );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun acteur');
END ActeurPresent;
/
DECLARE
BEGIN
  ActeurPresent(2);
END;
/

  --PROCEDURE N°13, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de compter le nombre d'évènement réalisé par un personnage à un lieu--
CREATE OR REPLACE PROCEDURE NbEvenement_Cause_Par_Nom_Lieu(NomPersonnageCherche PERSONNAGE.NomPersonnage%TYPE, PrenomPersonnageCherche PERSONNAGE.PrenomPersonnage%TYPE, LieuCherche LIEU.NomLieu%TYPE)
is
Cursor LesEvenements is 
    SELECT COUNT(EVENEMENT.idEvenement) AS Nb
   FROM EVENEMENT 
    INNER JOIN cause_par ON EVENEMENT.idEvenement = cause_par.EvenementProduit
    INNER JOIN PERSONNAGE ON PERSONNAGE.idPersonnage = cause_par.PersonnageDeclencheur
    INNER JOIN LIEU ON LIEU.idLieu = EVENEMENT.LieuEvenement
    WHERE PERSONNAGE.NomPersonnage LIKE(NomPersonnageCherche)
    AND PERSONNAGE.PrenomPersonnage LIKE(PrenomPersonnageCherche)
    AND LIEU.NomLieu LIKE(LieuCherche);
BEGIN
    FOR UnEvenement in LesEvenements
    LOOP
        dbms_output.put_line('Le personnage ' || NomPersonnageCherche ||' '|| PrenomPersonnageCherche ||' a causé ' || UnEvenement.Nb ||' évènements à ' || LieuCherche || '.' );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END NbEvenement_Cause_Par_Nom_Lieu;
/
DECLARE
BEGIN
NbEvenement_Cause_Par_Nom_Lieu('Murillo', 'Raquel', 'Banque d Espagne');
END;
/

  --PROCEDURE N°14, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir quel réalisateur on réalisé une partie--
CREATE OR REPLACE PROCEDURE Realisateur_De_Partie(PartieCherche PARTIE.idPartie%TYPE)
is
Cursor LesRealisateurs is 
    SELECT DISTINCT NomIndividu, PrenomIndividu
    FROM INDIVIDU 
    INNER JOIN EPISODE ON EPISODE.Realisateur = INDIVIDU.idIndividu
    INNER JOIN PARTIE ON EPISODE.PartieEpisode = PARTIE.idPartie
    WHERE PartieEpisode = PartieCherche
    AND RoleIndividu = 'Réalisateur';
BEGIN
    dbms_output.put_line('Les réalisateurs de la partie ' || PartieCherche || ' sont : ');
    FOR UnRealisateur in LesRealisateurs
    LOOP
        dbms_output.put_line(UnRealisateur.NomIndividu || ' ' || UnRealisateur.PrenomIndividu);
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun réalisateur');
END Realisateur_De_Partie;
/
DECLARE
BEGIN
Realisateur_De_Partie(3);
END;
/

    --PROCEDURE N°15, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir la relation entre deux personnages selon leur surnom--
CREATE OR REPLACE PROCEDURE Relation_Entre(Surnom1 PERSONNAGE.SurnomPErsonnage%TYPE, Surnom2 PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesRelations is 
    SELECT TypeRelation
    FROM PERSONNAGE p1
    JOIN est_en_lien ON p1.idPersonnage = est_en_lien.Personnage1
    JOIN PERSONNAGE p2 ON p2.idPersonnage = est_en_lien.Personnage2
    WHERE p1.SurnomPersonnage = Surnom1 
    AND p2.SurnomPersonnage = Surnom2;
BEGIN
    FOR UneRelation in LesRelations
    LOOP
        dbms_output.put_line('La relation entre ' || Surnom1 || ' et ' || Surnom2 || 'est de type ' || UneRelation.TypeRelation || '.');
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Ils n ont aucune relation');
END Relation_Entre;
/
DECLARE
BEGIN
Relation_Entre('Tokyo', 'Rio');
END;
/
  
--PROCEDURE N°16, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir la relation entre deux personnages selon leur prénom et nom--
CREATE OR REPLACE PROCEDURE Relation_Entre_Nom(Nom1 PERSONNAGE.NomPersonnage%TYPE, Prenom1 PERSONNAGE.PrenomPersonnage%TYPE, Nom2 PERSONNAGE.NomPersonnage%TYPE, Prenom2 PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesRelations is 
    SELECT TypeRelation
    FROM PERSONNAGE p1
    JOIN est_en_lien ON p1.idPersonnage = est_en_lien.Personnage1
    JOIN PERSONNAGE p2 ON p2.idPersonnage = est_en_lien.Personnage2
    WHERE p1.NomPersonnage = Nom1
    AND p1.PrenomPersonnage = Prenom1
    AND p2.NomPersonnage = Nom2
    AND p2.PrenomPersonnage = Prenom2;
BEGIN
    FOR UneRelation in LesRelations
    LOOP
        dbms_output.put_line('La relation entre ' || Nom1 || ' ' || Prenom1 || ' et ' || Nom2 || ' ' || Prenom2 || 'est de type ' || UneRelation.TypeRelation || '.');
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Ils n ont aucune relation');
END Relation_Entre_Nom;
/

    --PROCEDURE N°17, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir l'apparition d'un personnage selon son surnom--
CREATE OR REPLACE PROCEDURE Apparition_Partie_Surnom(SurnomCherche PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesParties is 
    SELECT DISTINCT idPartie
    FROM Partie
    INNER JOIN EPISODE ON PARTIE.idPartie = EPISODE.PartieEpisode
    INNER JOIN PERSONNAGE ON EPISODE.idEpisode = PERSONNAGE.PremiereApparition
    WHERE PERSONNAGE.SurnomPersonnage = SurnomCherche;
BEGIN
    FOR UnePartie in LesParties
    LOOP
        dbms_output.put_line('Le personnage ' || SurnomCherche || ' est apparût dans la partie numéro ' || UnePartie.idPartie || '.');
    END LOOP;
END Apparition_Partie_Surnom;
/
DECLARE
BEGIN
Apparition_Partie_Surnom('Tokyo');
END;
/

--PROCEDURE N°18, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir l'apparition d'un personnage selon son nom et prénom--
CREATE OR REPLACE PROCEDURE Apparition_Partie_Nom(Nom PERSONNAGE.NomPersonnage%TYPE, Prenom PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesParties is 
    SELECT DISTINCT idPartie
    FROM Partie
    INNER JOIN EPISODE ON PARTIE.idPartie = EPISODE.PartieEpisode
    INNER JOIN PERSONNAGE ON EPISODE.idEpisode = PERSONNAGE.PremiereApparition
    WHERE PERSONNAGE.PrenomPersonnage = Prenom
    AND PERSONNAGE.NomPersonnage = Nom;
BEGIN
    FOR UnePartie in LesParties
    LOOP
        dbms_output.put_line('Le personnage ' || Nom || ' ' || Prenom || ' est apparût dans la partie numéro ' || UnePartie.idPartie || '.');
    END LOOP;
END Apparition_Partie_Nom;
/

--PROCEDURE N°19, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir dans quel épisode est mort un personnage selon son surnom--
CREATE OR REPLACE PROCEDURE Mort_A(Surnom PERSONNAGE.SurnomPersonnage%TYPE)
is
Cursor LesEpisodes is 
    SELECT NumeroEpisode,PartieEpisode
    FROM EPISODE
    JOIN PERSONNAGE ON PERSONNAGE.MortPersonnage = EPISODE.idEpisode
    WHERE PERSONNAGE.SurnomPersonnage = Surnom;
BEGIN
    FOR UnEpisode in LesEpisodes
    LOOP
        dbms_output.put_line('Le personnage ' || Surnom || ' est mort dans l épisode ' || UnEpisode.NumeroEpisode || ' de la parti numéro ' || UnEpisode.PartieEpisode || '.' );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Le personage n est pas mort.');
END Mort_A;
/
DECLARE
BEGIN
Mort_A('Tokyo');
END;
/
  
  --PROCEDURE N°20, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir dans quel épisode est mort un personnage selon son nom et prénom--
CREATE OR REPLACE PROCEDURE Mort_A(Nom PERSONNAGE.NomPersonnage%TYPE, Prenom PERSONNAGE.PrenomPersonnage%TYPE)
is
Cursor LesEpisodes is 
    SELECT NumeroEpisode,PartieEpisode
    FROM EPISODE
    JOIN PERSONNAGE ON PERSONNAGE.MortPersonnage = EPISODE.idEpisode
    WHERE PERSONNAGE.NomPersonnage = Nom
    AND PERSONNAGE.PrenomPersonnage = Prenom;
BEGIN
    FOR UnEpisode in LesEpisodes
    LOOP
        dbms_output.put_line('Le personnage ' || Nom || ' ' || Prenom || ' est mort dans l épisode ' || UnEpisode.NumeroEpisode || ' de la parti numéro ' || UnEpisode.PartieEpisode || '.' );
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Le personnage n est pas mort');
END Mort_A;
/

 --PROCEDURE N°21, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir quel évènements se sont déroulé dans un lieu-
CREATE OR REPLACE PROCEDURE Evenement_Lieu(Nom LIEU.NomLieu%TYPE)
is
Cursor LesEvenements is 
    SELECT DISTINCT EVENEMENT.DescriptionEvenement
    FROM EVENEMENT 
    JOIN LIEU ON EVENEMENT.LieuEvenement = LIEU.idLieu
    WHERE LIEU.NomLieu LIKE(Nom);
BEGIN
    dbms_output.put_line('Les évènements ayant eu lieu à '|| Nom || ' sont : ');
    FOR UnEvenement in LesEvenements
    LOOP
        dbms_output.put_line(UnEvenement.DescriptionEvenement);
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun évènement');
END Evenement_Lieu;
/
DECLARE
BEGIN
Evenement_Lieu('Banque d Espagne');
END;
/

 --PROCEDURE N°22, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir quel épisode ont tourné un réalisateur-
CREATE OR REPLACE PROCEDURE Episode_Par(Nom INDIVIDU.NomIndividu%TYPE, Prenom INDIVIDU.PrenomIndividu%TYPE)
is
Cursor LesEpisodes is 
    SELECT DISTINCT EPISODE.NumeroEpisode, EPISODE.PartieEpisode, EPISODE.TitreEpisodeVO, EPISODE.TitreEpisodeVF
    FROM EPISODE 
    JOIN INDIVIDU ON EPISODE.Realisateur = INDIVIDU.idIndividu
    WHERE INDIVIDU.NomIndividu LIKE(Nom)
    AND INDIVIDU.PrenomIndividu LIKE(Prenom);
BEGIN
    dbms_output.put_line('Le réalisateur ' || Nom || ' ' || Prenom || ' a réalisé les épisodes suivants : ');
    FOR UnEpisode in LesEpisodes
    LOOP
        dbms_output.put_line(UnEpisode.NumeroEpisode || ' de la partie ' || UnEpisode.PartieEpisode || ' dont le titre original est ' || UnEpisode.TitreEpisodeVO || '. La traduction est' || UnEpisode.TitreEpisodeVF ||'.');
    END LOOP;
  EXCEPTION
    WHEN NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Aucun épisode');
END Episode_Par;
/

DECLARE
BEGIN
Episode_Par('Quintas', 'Javier');
END;
/
   --PROCEDURE N°23, Réalisé par Estelle BOISSERIE--
-- Procedure permettant de savoir quel personnage ont des relations de certains type-
CREATE OR REPLACE PROCEDURE Relation_De_Type(Type est_en_lien.TypeRelation%TYPE)
is
Cursor LesPersonnages is 
    SELECT DISTINCT PERSONNAGE.NomPersonnage, PERSONNAGE.PrenomPersonnage
    FROM PERSONNAGE 
    INNER JOIN est_en_lien ON PERSONNAGE.idPersonnage = est_en_lien.Personnage1
    WHERE est_en_lien.TypeRelation = Type;
BEGIN
    dbms_output.put_line('Les personnages dont la relation est ' || Type || ' sont : ');
    FOR UnPersonnage in LesPersonnages
    LOOP
        dbms_output.put_line(UnPersonnage.NomPersonnage || ' ' || UnPersonnage.PrenomPersonnage);
    END LOOP;
END Relation_De_Type;
/
DECLARE
BEGIN
Relation_De_Type('Coéquipier');
END;
/


  --PROCEDURE N°24, Réalisé par Cathy MARTIN--
-- Procedure permettant de connaitre les differents evenement en fonction d'une ville donnée-
CREATE OR REPLACE PROCEDURE Evenement_Ville(NomV Ville.NomVille%TYPE)
is
Cursor LesEvenements is 
    SELECT EV.DescriptionEvenement
    FROM EVENEMENT EV
    JOIN LIEU L ON EV.LieuEvenement = L.idLieu
    JOIN VILLE V ON L.VilleLieu = V.idVille
    JOIN EPISODE E ON E.idEpisode = EV.EpisodeEvenement
    WHERE V.NomVille = NomV
    ORDER BY E.idEpisode;
BEGIN
    dbms_output.put_line('Les evenements qui ont lui à '||NomV || ' sont : ');
    FOR UnEvenement in LesEvenements
    LOOP
        dbms_output.put_line(' - ' || UnEvenement.DescriptionEvenement);
    END LOOP;
END Evenement_Ville;
/
EXECUTE Evenement_Ville('Madrid')
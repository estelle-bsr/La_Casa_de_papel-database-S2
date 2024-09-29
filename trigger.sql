/***************************
** CREATIONS DES TRIGGERS **
****************************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

--TRIGGER N°1, Réalisé par Roméo BOURDELET--
--Déclencheur permettant de vérifier l'identité des auteurs de changement sur les tables --
CREATE OR REPLACE TRIGGER check_user_permission_partie
BEFORE INSERT OR UPDATE ON PARTIE
FOR EACH ROW
BEGIN
    IF USER NOT IN ('eboiss1', 'rbourde', 'cmarti23', 'mperei16') THEN
        RAISE_APPLICATION_ERROR(-20011, 'Permissions non accordée');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER check_user_permission_pays
BEFORE INSERT OR UPDATE ON PAYS
FOR EACH ROW
BEGIN
    IF USER NOT IN ('eboiss1', 'rbourde', 'cmarti23', 'mperei16') THEN
        RAISE_APPLICATION_ERROR(-20012, 'Permissions non accordée');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER check_user_permission_personnage
BEFORE INSERT OR UPDATE ON PERSONNAGE
FOR EACH ROW
BEGIN
    IF USER NOT IN ('eboiss1', 'rbourde', 'cmarti23', 'mperei16') THEN
        RAISE_APPLICATION_ERROR(-20013, 'Permissions non accordée');
    END IF;
END;
/

--TRIGGER N°2, Réalisé par Roméo BOURDELET--
-- Déclencheur permettant d'interdir les insertions d'épisodes dans les parties 1 à 4 --
CREATE OR REPLACE TRIGGER check_partie_limit
BEFORE INSERT ON EPISODE
FOR EACH ROW
DECLARE
    partie_id NUMBER(5);
BEGIN
    SELECT PartieEpisode INTO partie_id FROM PARTIE WHERE idPartie = :new.PartieEpisode;
    IF partie_id BETWEEN 1 AND 4 THEN
        RAISE_APPLICATION_ERROR(-20020, 'L''insertion d''épisodes dans les parties de 1 à 4 est interdite.');
    END IF;
END;
/

--TRIGGER N°3, Réalisé par Roméo BOURDELET--
--Trigger permettant d'empêcher la suppression d'un individu dans la table INDIVIDU s'il est associé à des épisodes en tant que réalisateur--
CREATE OR REPLACE TRIGGER verif_suppression_realisateur
BEFORE DELETE ON INDIVIDU
FOR EACH ROW
DECLARE
    existing_episodes NUMBER(5);
BEGIN
    SELECT COUNT(*) INTO existing_episodes
    FROM EPISODE
    WHERE RealisateurEpisode = :old.idIndividu;

    IF existing_episodes > 0 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Impossible de supprimer l''individu car il est associé en tant que réalisateur à des épisodes.');
    END IF;
END;
/

--TRIGGER N°4, Réalisé par Roméo BOURDELET--
--Trigger permettant d'empêcher l'insertion d'un nouvel épisode si le réalisateur n'est pas un individu existant dans la table INDIVIDU--
CREATE OR REPLACE TRIGGER verif_realisateur_existant
BEFORE INSERT ON EPISODE
FOR EACH ROW
DECLARE
    existing_director NUMBER(5);
BEGIN
    SELECT COUNT(*) INTO existing_director
    FROM INDIVIDU
    WHERE idIndividu = :new.RealisateurEpisode;

    IF existing_director = 0 THEN
        RAISE_APPLICATION_ERROR(-20022, 'Le réalisateur spécifié n''existe pas dans la table INDIVIDU.');
    END IF;
END;
/

--TRIGGER N°5, Réalisé par Roméo BOURDELET--
--Trigger permettant d'empêcher l'insertion d'un nouveau personnage si l'acteur n'est pas un individu existant dans la table INDIVIDU--
CREATE OR REPLACE TRIGGER verif_personnage_existant
BEFORE INSERT ON PERSONNAGE
FOR EACH ROW
DECLARE
    existing_character NUMBER(5);
BEGIN
    SELECT COUNT(*) INTO existing_character
    FROM INDIVIDU
    WHERE idIndividu = :new.Acteur;

    IF existing_character = 0 THEN
        RAISE_APPLICATION_ERROR(-20023, 'L''acteur spécifié n''existe pas dans la table INDIVIDU.');
    END IF;
END;
/

--TRIGGER N°6, Réalisé par Roméo BOURDELET--
--Ce déclencheur permet d'empecher la suppression d'un pays tant qu'il est associé à des villes.--
CREATE OR REPLACE TRIGGER verif_pays_utilise
BEFORE DELETE ON PAYS
FOR EACH ROW
DECLARE
    existing_usage NUMBER(5);
BEGIN
    SELECT COUNT(*) INTO existing_usage
    FROM VILLE
    WHERE idPays = :old.idPays;

    IF existing_usage > 0 THEN
        RAISE_APPLICATION_ERROR(-20024, 'Impossible de supprimer le pays car il est utilisé par une ou plusieurs villes.');
    END IF;
END;
/

--TRIGGER N°7, Réalisé par Estelle BOISSERIE--
--Trigger permettant de lancé une alerte si une modification incohérent de l'âge d'un individu est essayé--
CREATE OR REPLACE TRIGGER Alerte_Age
BEFORE UPDATE OF AgeIndividu
    ON INDIVIDU FOR EACH ROW
BEGIN
    IF : new.AgeIndividu < (:old.AgeIndividu) 
        THEN dbms_output.put_line('L âge est incohérent.');
    END IF;
END;
/
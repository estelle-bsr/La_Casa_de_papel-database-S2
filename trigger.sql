/***************************
** CREATIONS DES TRIGGERS **
****************************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

--TRIGGER N�1, R�alis� par Rom�o BOURDELET--
--D�clencheur permettant de v�rifier l'identit� des auteurs de changement sur les tables --
CREATE OR REPLACE TRIGGER check_user_permission_partie
BEFORE INSERT OR UPDATE ON PARTIE
FOR EACH ROW
BEGIN
    IF USER NOT IN ('eboiss1', 'rbourde', 'cmarti23', 'mperei16') THEN
        RAISE_APPLICATION_ERROR(-20011, 'Permissions non accord�e');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER check_user_permission_pays
BEFORE INSERT OR UPDATE ON PAYS
FOR EACH ROW
BEGIN
    IF USER NOT IN ('eboiss1', 'rbourde', 'cmarti23', 'mperei16') THEN
        RAISE_APPLICATION_ERROR(-20012, 'Permissions non accord�e');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER check_user_permission_personnage
BEFORE INSERT OR UPDATE ON PERSONNAGE
FOR EACH ROW
BEGIN
    IF USER NOT IN ('eboiss1', 'rbourde', 'cmarti23', 'mperei16') THEN
        RAISE_APPLICATION_ERROR(-20013, 'Permissions non accord�e');
    END IF;
END;
/

--TRIGGER N�2, R�alis� par Rom�o BOURDELET--
-- D�clencheur permettant d'interdir les insertions d'�pisodes dans les parties 1 � 4 --
CREATE OR REPLACE TRIGGER check_partie_limit
BEFORE INSERT ON EPISODE
FOR EACH ROW
DECLARE
    partie_id NUMBER(5);
BEGIN
    SELECT PartieEpisode INTO partie_id FROM PARTIE WHERE idPartie = :new.PartieEpisode;
    IF partie_id BETWEEN 1 AND 4 THEN
        RAISE_APPLICATION_ERROR(-20020, 'L''insertion d''�pisodes dans les parties de 1 � 4 est interdite.');
    END IF;
END;
/

--TRIGGER N�3, R�alis� par Rom�o BOURDELET--
--Trigger permettant d'emp�cher la suppression d'un individu dans la table INDIVIDU s'il est associ� � des �pisodes en tant que r�alisateur--
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
        RAISE_APPLICATION_ERROR(-20021, 'Impossible de supprimer l''individu car il est associ� en tant que r�alisateur � des �pisodes.');
    END IF;
END;
/

--TRIGGER N�4, R�alis� par Rom�o BOURDELET--
--Trigger permettant d'emp�cher l'insertion d'un nouvel �pisode si le r�alisateur n'est pas un individu existant dans la table INDIVIDU--
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
        RAISE_APPLICATION_ERROR(-20022, 'Le r�alisateur sp�cifi� n''existe pas dans la table INDIVIDU.');
    END IF;
END;
/

--TRIGGER N�5, R�alis� par Rom�o BOURDELET--
--Trigger permettant d'emp�cher l'insertion d'un nouveau personnage si l'acteur n'est pas un individu existant dans la table INDIVIDU--
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
        RAISE_APPLICATION_ERROR(-20023, 'L''acteur sp�cifi� n''existe pas dans la table INDIVIDU.');
    END IF;
END;
/

--TRIGGER N�6, R�alis� par Rom�o BOURDELET--
--Ce d�clencheur permet d'empecher la suppression d'un pays tant qu'il est associ� � des villes.--
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
        RAISE_APPLICATION_ERROR(-20024, 'Impossible de supprimer le pays car il est utilis� par une ou plusieurs villes.');
    END IF;
END;
/

--TRIGGER N�7, R�alis� par Estelle BOISSERIE--
--Trigger permettant de lanc� une alerte si une modification incoh�rent de l'�ge d'un individu est essay�--
CREATE OR REPLACE TRIGGER Alerte_Age
BEFORE UPDATE OF AgeIndividu
    ON INDIVIDU FOR EACH ROW
BEGIN
    IF : new.AgeIndividu < (:old.AgeIndividu) 
        THEN dbms_output.put_line('L �ge est incoh�rent.');
    END IF;
END;
/
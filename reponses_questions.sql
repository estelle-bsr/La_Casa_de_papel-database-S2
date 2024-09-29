/**************
** REPONSES **
**************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

-- QUESTION 1 : Quel est l’age de l’actrice de Lisbonne ? --
/*Selon le surnom*/
DECLARE
BEGIN
  Age_De('Lisbonne'); --Voir Procedure n°8--
END;
/
/*Selon le nom*/
DECLARE
BEGIN
  Nom_Age_De('Murillo', 'Raquel'); --Voir Procedure n°7--
END;
/

-- QUESTION 2 : Quels sont les lieux que « NomPersonnage » a visité ? --
/*Selon le nom*/
DECLARE
BEGIN
  A_Visite_Nom('Marquina', 'Sergio'); --Voir Procedure n°6--
END;
/
/*Selon le surnom*/
DECLARE
BEGIN
  A_Visite('le Professeur'); --Voir Procedure n°5--
END;
/
  
-- QUESTION 3 : Combien d’évènement se déroule dans la partie 1 ? --
DECLARE
BEGIN
  Nombre_Evenement(1); --Voir Procedure n°9--
END;
/
  
-- QUESTION 4 : Combien d’évènement à causé le personnage de Raquel Murillo durant l’épisode de son apparition ? -- 
/*Selon le nom et prénom*/
  DECLARE
BEGIN
  Nombre_Evenement_Cause_Par('Murillo', 'Raquel'); -- Voir Procedure n°10--
END;
/
/*Selon le surnom*/
DECLARE
BEGIN
  Nombre_Evenement_Cause_Par_Surnom('Lisbonne'); -- Voir Procedure n°11--
END;
/
  
-- QUESTION 5 : Quels sont les évènements causé par le personnage de Raquel Murillo ? -- 
/* Selon le surnom*/
DECLARE
BEGIN
  Evenement_Cause_Par('Lisbonne'); -- Voir Procedure n°4--
END;
/
/* Selon le nom et prénom*/
DECLARE
BEGIN
  Evenement_Cause_Par_Nom('Murillo', 'Raquel'); -- Voir Procedure n°3--
END;
/

-- QUESTION 6 : Quels sont les personnages qui ne sont pas réapparu ? --
SELECT * FROM PersonnageDisparu ORDER BY EpisodeDisparu ASC; --Voir vue n°4--

-- QUESTION 7 : Quels sont les acteurs qui sont présent dans la partie 2 ? --
DECLARE
BEGIN
  ActeurPresent(2);--Voir Procédure n°12--
END;
/

-- QUESTION 8 : Combien d’évènement a causé le personnage Murillo à la Banque d'Espagne ? --
BEGIN
  NbEvenement_Cause_Par_Nom_Lieu('Murillo', 'Raquel', 'Banque d Espagne');--Voir Procédure n°13--
END;
/


-- QUESTION 9 : Quelle est la liste des réalisateurs de la partie 3 ? --
DECLARE
BEGIN
  Realisateur_De_Partie(3);--Voir Procédure n°14--
END;
/

-- QUESTION 10 : Quel est la relation entre les personnages Tokyo et Rio ? --
DECLARE
BEGIN
  Relation_Entre('Tokyo', 'Rio');--Voir Procédure n°15--
END;
/

-- QUESTION 11 : Dans quel partie apparaît le personnage Tokyo ? --
DECLARE
BEGIN
  Apparition_Partie_Surnom('Tokyo');--Voir Procédure n°17--
END;
/

-- QUESTION 12 : Combien de personnage sont mort dans la partie 2 ? --
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbMort(2));--Voir Fonction n°6--
END;
/

-- QUESTION 13 : Quels sont les évènements causé dans le lieu à la Banque? --
EXECUTE Evenement_Ville('Madrid') ;--Voir Procédure n°X--

-- QUESTION 14 : Quels sont les personnages reliés au personnage « NomPersonnage » ? -- 
DECLARE
BEGIN
  RelationDe('Rio');--Voir Procédure n°1--
END;
/

-- QUESTION 15 : Dans quel épisode le personnage Tokyo est mort ? --
DECLARE
BEGIN
  Mort_A('Tokyo');--Voir Procédure n°19--
END;
/

-- QUESTION 16 : Quels sont les évènements causé dans la ville Madrid ? --
DECLARE
BEGIN
  Evenement_Lieu('Banque d Espagne') --Voir Procédure n°21--
END;


-- QUESTION 17 : Combien y a-t-il d’épisode dans la partie 2 ? --
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbEpisode_Partie(2)); -- Voir fonction n°7--
END;
/

-- QUESTION 18 : Quels sont les épisodes que le réalisateur Quintas Javier a réalisé ? --
DECLARE
BEGIN
  Episode_Par('Quintas', 'Javier'); -- Voir Procédure n°22--
END;
/

-- QUESTION 19 : Quels sont les personnages en relation de type « TypeRelation » ? --
DECLARE
BEGIN
  Relation_De_Type('Coéquipier'); --Voir Procédure n°23--
END;
/

-- QUESTION 20: Combien d'épisode a réalisé Rodiguo Alex ? --
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbEpisode('Rodrigo','Alex')); -- Voir fonction numéro 1--
END;
/


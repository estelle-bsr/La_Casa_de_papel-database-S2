/**************
** REPONSES **
**************/
--PEREIRA--LOUNIS, BOURDELET, BOISSERIE, MARTIN--

-- QUESTION 1 : Quel est l�age de l�actrice de Lisbonne ? --
/*Selon le surnom*/
DECLARE
BEGIN
  Age_De('Lisbonne'); --Voir Procedure n�8--
END;
/
/*Selon le nom*/
DECLARE
BEGIN
  Nom_Age_De('Murillo', 'Raquel'); --Voir Procedure n�7--
END;
/

-- QUESTION 2 : Quels sont les lieux que � NomPersonnage � a visit� ? --
/*Selon le nom*/
DECLARE
BEGIN
  A_Visite_Nom('Marquina', 'Sergio'); --Voir Procedure n�6--
END;
/
/*Selon le surnom*/
DECLARE
BEGIN
  A_Visite('le Professeur'); --Voir Procedure n�5--
END;
/
  
-- QUESTION 3 : Combien d��v�nement se d�roule dans la partie 1 ? --
DECLARE
BEGIN
  Nombre_Evenement(1); --Voir Procedure n�9--
END;
/
  
-- QUESTION 4 : Combien d��v�nement � caus� le personnage de Raquel Murillo durant l��pisode de son apparition ? -- 
/*Selon le nom et pr�nom*/
  DECLARE
BEGIN
  Nombre_Evenement_Cause_Par('Murillo', 'Raquel'); -- Voir Procedure n�10--
END;
/
/*Selon le surnom*/
DECLARE
BEGIN
  Nombre_Evenement_Cause_Par_Surnom('Lisbonne'); -- Voir Procedure n�11--
END;
/
  
-- QUESTION 5 : Quels sont les �v�nements caus� par le personnage de Raquel Murillo ? -- 
/* Selon le surnom*/
DECLARE
BEGIN
  Evenement_Cause_Par('Lisbonne'); -- Voir Procedure n�4--
END;
/
/* Selon le nom et pr�nom*/
DECLARE
BEGIN
  Evenement_Cause_Par_Nom('Murillo', 'Raquel'); -- Voir Procedure n�3--
END;
/

-- QUESTION 6 : Quels sont les personnages qui ne sont pas r�apparu ? --
SELECT * FROM PersonnageDisparu ORDER BY EpisodeDisparu ASC; --Voir vue n�4--

-- QUESTION 7 : Quels sont les acteurs qui sont pr�sent dans la partie 2 ? --
DECLARE
BEGIN
  ActeurPresent(2);--Voir Proc�dure n�12--
END;
/

-- QUESTION 8 : Combien d��v�nement a caus� le personnage Murillo � la Banque d'Espagne ? --
BEGIN
  NbEvenement_Cause_Par_Nom_Lieu('Murillo', 'Raquel', 'Banque d Espagne');--Voir Proc�dure n�13--
END;
/


-- QUESTION 9 : Quelle est la liste des r�alisateurs de la partie 3 ? --
DECLARE
BEGIN
  Realisateur_De_Partie(3);--Voir Proc�dure n�14--
END;
/

-- QUESTION 10 : Quel est la relation entre les personnages Tokyo et Rio ? --
DECLARE
BEGIN
  Relation_Entre('Tokyo', 'Rio');--Voir Proc�dure n�15--
END;
/

-- QUESTION 11 : Dans quel partie appara�t le personnage Tokyo ? --
DECLARE
BEGIN
  Apparition_Partie_Surnom('Tokyo');--Voir Proc�dure n�17--
END;
/

-- QUESTION 12 : Combien de personnage sont mort dans la partie 2 ? --
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbMort(2));--Voir Fonction n�6--
END;
/

-- QUESTION 13 : Quels sont les �v�nements caus� dans le lieu � la Banque? --
EXECUTE Evenement_Ville('Madrid') ;--Voir Proc�dure n�X--

-- QUESTION 14 : Quels sont les personnages reli�s au personnage � NomPersonnage � ? -- 
DECLARE
BEGIN
  RelationDe('Rio');--Voir Proc�dure n�1--
END;
/

-- QUESTION 15 : Dans quel �pisode le personnage Tokyo est mort ? --
DECLARE
BEGIN
  Mort_A('Tokyo');--Voir Proc�dure n�19--
END;
/

-- QUESTION 16 : Quels sont les �v�nements caus� dans la ville Madrid ? --
DECLARE
BEGIN
  Evenement_Lieu('Banque d Espagne') --Voir Proc�dure n�21--
END;


-- QUESTION 17 : Combien y a-t-il d��pisode dans la partie 2 ? --
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbEpisode_Partie(2)); -- Voir fonction n�7--
END;
/

-- QUESTION 18 : Quels sont les �pisodes que le r�alisateur Quintas Javier a r�alis� ? --
DECLARE
BEGIN
  Episode_Par('Quintas', 'Javier'); -- Voir Proc�dure n�22--
END;
/

-- QUESTION 19 : Quels sont les personnages en relation de type � TypeRelation � ? --
DECLARE
BEGIN
  Relation_De_Type('Co�quipier'); --Voir Proc�dure n�23--
END;
/

-- QUESTION 20: Combien d'�pisode a r�alis� Rodiguo Alex ? --
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(nbEpisode('Rodrigo','Alex')); -- Voir fonction num�ro 1--
END;
/



SELECT * FROM Livre WHERE disponible = TRUE;

SELECT * FROM Utilisateurs WHERE role = 'bibliothecaire';

SELECT * FROM Emprunts 
WHERE date_retour_reelle IS NULL AND date_retour_prevue < CURRENT_DATE;

SELECT COUNT(*) AS total_emprunts FROM Emprunts;

SELECT u.nom, l.titre, c.texte, c.note
FROM Commentaires c
JOIN Utilisateurs u ON c.id_utilisateur = u.id_utilisateur
JOIN Livre l ON c.id_livre = l.id_livre
ORDER BY c.id_commentaire DESC
LIMIT 5;

SELECT u.nom, COUNT(e.id_emprunts) AS nb_emprunts
FROM Utilisateurs u
LEFT JOIN Emprunts e ON u.id_utilisateur = e.id_utilisateur
GROUP BY u.nom;

SELECT * FROM Livre
WHERE id_livre NOT IN (SELECT id_livre FROM Emprunts);

SELECT id_livre, AVG(DATE_PART('day', date_retour_reelle - date_emprunt)) AS duree_moyenne
FROM Emprunts
WHERE date_retour_reelle IS NOT NULL
GROUP BY id_livre;

SELECT l.titre, AVG(c.note) AS note_moyenne
FROM Commentaires c
JOIN Livre l ON c.id_livre = l.id_livre
GROUP BY l.titre
ORDER BY note_moyenne DESC
LIMIT 3;

SELECT DISTINCT u.nom
FROM Utilisateurs u
JOIN Emprunts e ON u.id_utilisateur = e.id_utilisateur
JOIN Livre l ON e.id_livre = l.id_livre
WHERE l.categorie = 'Science-fiction';

UPDATE Livre
SET disponible = FALSE
WHERE id_livre IN (
    SELECT id_livre FROM Emprunts WHERE date_retour_reelle IS NULL
);

BEGIN;
INSERT INTO Emprunts (id_utilisateur, id_livre, date_emprunt, date_retour_prevue)
VALUES (1, 5, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days');

UPDATE Livre SET disponible = FALSE WHERE id_livre = 5;
COMMIT;

DELETE FROM Commentaires
WHERE id_utilisateur IN (
    SELECT u.id_utilisateur
    FROM Utilisateurs u
    LEFT JOIN Emprunts e ON u.id_utilisateur = e.id_utilisateur
    WHERE e.id_emprunts IS NULL
);

CREATE VIEW Vue_Emprunts_Actifs AS
SELECT * FROM Emprunts
WHERE date_retour_reelle IS NULL;

CREATE OR REPLACE FUNCTION nb_emprunts_utilisateur(id_utilisateur INT)
RETURNS INT AS $$
DECLARE
    nb INT;
BEGIN
    SELECT COUNT(*) INTO nb FROM Emprunts WHERE id_utilisateur = nb_emprunts_utilisateur.id_utilisateur;
    RETURN nb;
END;
$$ LANGUAGE plpgsql;

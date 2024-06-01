-- Suppression des tables existantes pour éviter les conflits
DROP TABLE IF EXISTS emprunts CASCADE CONSTRAINTS;
DROP TABLE IF EXISTS livres CASCADE CONSTRAINTS;
DROP TABLE IF EXISTS auteurs CASCADE CONSTRAINTS;
DROP TABLE IF EXISTS utilisateurs CASCADE CONSTRAINTS;

-- Création de la table auteurs
CREATE TABLE auteurs (
    id_auteur   NUMBER NOT NULL,
    nom         VARCHAR2(100) NOT NULL,
    date_naissance DATE,
    nationalite VARCHAR2(100),
    CONSTRAINT auteurs_pk PRIMARY KEY (id_auteur)
);

-- Création de la table livres
CREATE TABLE livres (
    id_livre     NUMBER NOT NULL,
    titre        VARCHAR2(100) NOT NULL,
    auteur_id    NUMBER NOT NULL,
    genre        VARCHAR2(100),
    date_publication DATE,
    CONSTRAINT livres_pk PRIMARY KEY (id_livre),
    CONSTRAINT livres_fk_auteur FOREIGN KEY (auteur_id) REFERENCES auteurs (id_auteur)
);

-- Création de la table utilisateurs
CREATE TABLE utilisateurs (
    id_utilisateur NUMBER NOT NULL,
    nom            VARCHAR2(100) NOT NULL,
    courriel       VARCHAR2(100) NOT NULL,
    mot_de_passe   VARCHAR2(100) NOT NULL,
    date_adhesion  DATE DEFAULT SYSDATE,
    CONSTRAINT utilisateurs_pk PRIMARY KEY (id_utilisateur)
);

-- Création de la table emprunts
CREATE TABLE emprunts (
    id_emprunt   NUMBER NOT NULL,
    id_livre     NUMBER NOT NULL,
    id_utilisateur NUMBER NOT NULL,
    date_emprunt DATE DEFAULT SYSDATE,
    date_retour  DATE,
    CONSTRAINT emprunts_pk PRIMARY KEY (id_emprunt),
    CONSTRAINT emprunts_fk_livre FOREIGN KEY (id_livre) REFERENCES livres (id_livre),
    CONSTRAINT emprunts_fk_utilisateur FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs (id_utilisateur)
);

-- Insérer des données dans la table auteurs
INSERT INTO auteurs (id_auteur, nom, date_naissance, nationalite)
VALUES (1, 'J.K. Rowling', TO_DATE('1965-07-31', 'YYYY-MM-DD'), 'Britannique');

INSERT INTO auteurs (id_auteur, nom, date_naissance, nationalite)
VALUES (2, 'George R.R. Martin', TO_DATE('1948-09-20', 'YYYY-MM-DD'), 'Américain');

-- Insérer des données dans la table livres
INSERT INTO livres (id_livre, titre, auteur_id, genre, date_publication)
VALUES (1, 'Harry Potter à l\'école des sorciers', 1, 'Fantaisie', TO_DATE('1997-06-26', 'YYYY-MM-DD'));

INSERT INTO livres (id_livre, titre, auteur_id, genre, date_publication)
VALUES (2, 'Le Trône de fer', 2, 'Fantaisie', TO_DATE('1996-08-06', 'YYYY-MM-DD'));

-- Insérer des données dans la table utilisateurs
INSERT INTO utilisateurs (id_utilisateur, nom, courriel, mot_de_passe)
VALUES (1, 'John Doe', 'john.doe@example.com', 'motdepasse123');

INSERT INTO utilisateurs (id_utilisateur, nom, courriel, mot_de_passe)
VALUES (2, 'Meryam Lola', 'meryam004@gmail.com', 'abcd123//t');

INSERT INTO utilisateurs (id_utilisateur, nom, courriel, mot_de_passe)
VALUES (3, 'Jana Doha', 'doha004@gmail.com', 'jjj3457//00');

-- Insérer des données dans la table emprunts
INSERT INTO emprunts (id_emprunt, id_livre, id_utilisateur, date_emprunt, date_retour)
VALUES (1, 2, 3, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-20', 'YYYY-MM-DD'));

-- Confirmation des données insérées
SELECT * FROM auteurs;
SELECT * FROM livres;
SELECT * FROM utilisateurs;
SELECT * FROM emprunts;

-- Ceci va créer un URI sous le URL qui pourra être utilisé pour y activer les tables en mode REST
BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'RESTSCOTT',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'hr2',
    p_auto_rest_auth      => FALSE
  );
    
  COMMIT;
END;
/

-- Activation de la table auteurs pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'RESTSCOTT', 
    p_object       => 'AUTEURS',
    p_object_type  => 'TABLE',
    p_object_alias => 'auteurs'
  );
  COMMIT;
END;
/

-- Activation de la table livres pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'RESTSCOTT',
    p_object       => 'LIVRES',
    p_object_type  => 'TABLE',
    p_object_alias => 'livres'
  );
  COMMIT;
END;
/

-- Activation de la table utilisateurs pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'RESTSCOTT', 
    p_object       => 'UTILISATEURS',
    p_object_type  => 'TABLE',
    p_object_alias => 'utilisateurs'
  );
  COMMIT;
END;
/

-- Activation de la table emprunts pour accès REST
BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE,
    p_schema       => 'RESTSCOTT', 
    p_object       => 'EMPRUNTS',
    p_object_type  => 'TABLE',
    p_object_alias => 'emprunts'
  );
  COMMIT;
END;
/

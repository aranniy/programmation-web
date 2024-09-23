DROP TABLE IF EXISTS vetement CASCADE;
DROP TABLE IF EXISTS panier CASCADE;
DROP TABLE IF EXISTS photos CASCADE;
DROP TABLE IF EXISTS taille_disponible CASCADE;
DROP TABLE IF EXISTS gerant CASCADE;
DROP TABLE IF EXISTS commande CASCADE;
DROP TABLE IF EXISTS panier_copie CASCADE;
DROP TABLE IF EXISTS commentaire CASCADE;

CREATE TABLE vetement(
    id SERIAL PRIMARY KEY,
    prix DECIMAL(10,2) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    genre TEXT NOT NULL,
    categorie TEXT NOT NULL,
    sous_categorie TEXT NOT NULL,
    couleur TEXT NOT NULL,
    style TEXT NOT NULL,
    id_accessoire INT DEFAULT 0
);

CREATE TABLE photos(
    id SERIAL PRIMARY KEY,
    lien TEXT NOT NULL,
    id_vetement INT NOT NULL,
    FOREIGN KEY (id_vetement) REFERENCES vetement(id) ON DELETE CASCADE
);

CREATE TABLE taille_disponible(
    id SERIAL PRIMARY KEY,
    taille INT NOT NULL,
    id_vetement INT NOT NULL,
    FOREIGN KEY (id_vetement) REFERENCES vetement(id) ON DELETE CASCADE
);

CREATE TABLE panier(
    id SERIAL PRIMARY KEY,
    id_vetement INT,
    taille INT,
    FOREIGN KEY (id_vetement) REFERENCES vetement(id) ON DELETE CASCADE
);

CREATE TABLE commande(
    id SERIAL PRIMARY KEY,
    nom_client TEXT NOT NULL,
    prenom_client TEXT NOT NULL,
    date_de_naissance TEXT,
    telephone VARCHAR(100),
    email TEXT,
    adresse TEXT,
    heure VARCHAR(100)
);

CREATE TABLE panier_copie(
    id SERIAL PRIMARY KEY,
    id_commande INT,
    id_vetement INT,
    taille INT,
    FOREIGN KEY (id_commande) REFERENCES commande(id) ON DELETE CASCADE,
    FOREIGN KEY (id_vetement) REFERENCES vetement(id) ON DELETE CASCADE
);

CREATE TABLE gerant(
    id SERIAL PRIMARY KEY,
    pseudo TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE commentaire(
    id SERIAL PRIMARY KEY,
    contenu TEXT,
    id_vetement INT,
    FOREIGN KEY (id_vetement) REFERENCES vetement(id) ON DELETE CASCADE
);

INSERT INTO gerant (pseudo, password) VALUES ('Fafa', 'fafa');
INSERT INTO gerant (pseudo, password) VALUES ('Aranniy', 'aranniy');

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (40.21, 'Pull trop stylé', 'Homme', 'Veste', 'Sweat-shirt', 'Vert', 'décontracté');

INSERT INTO commentaire (contenu, id_vetement) 
VALUES ('cool',1);

INSERT INTO photos (lien, id_vetement) VALUES ('images/a.jpeg', 1);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (36, 1);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (36, 1);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 1);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 1);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (44.30, 'Robe méga stylé', 'Femme', 'Robe', 'Robe courte', 'Rouge', 'décontracté', 65);

INSERT INTO photos (lien, id_vetement) VALUES ('images/b.jpeg', 2);
INSERT INTO photos (lien, id_vetement) VALUES ('images/h.jpeg', 2);
INSERT INTO photos (lien, id_vetement) VALUES ('images/i.jpeg', 2);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 2);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 2);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (44, 2);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (24.10, 'Veste stylé', 'Homme', 'Veste', 'Blazer', 'Blanc', 'décontracté', 44);

INSERT INTO photos (lien, id_vetement) VALUES ('images/c.jpeg', 3);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 3);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (44, 3);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (46, 3);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (43.24, 'Jean bcp trop stylé', 'Femme', 'Pantalon', 'Jean', 'Noir', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/e.jpeg', 4);
INSERT INTO photos (lien, id_vetement) VALUES ('images/f.jpeg', 4);
INSERT INTO photos (lien, id_vetement) VALUES ('images/g.jpeg', 4);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 4);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 4);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 4);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20, 'Chaussures super stylé', 'Homme', 'Chaussures', 'Basket', 'Blanc', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/j.jpeg', 5);
INSERT INTO photos (lien, id_vetement) VALUES ('images/j.avif', 5);
INSERT INTO photos (lien, id_vetement) VALUES ('images/j.webp', 5);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 5);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (39, 5);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 5);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (21.12, 'Robe de ville', 'Femme', 'Robe', 'Robe courte', 'Rose', 'décontracté', 64);

INSERT INTO photos (lien, id_vetement) VALUES ('images/aa.jpeg',6);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (36, 6);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 6);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 6);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull de Noël', 'Homme', 'Pull', 'Sweat-shirt', 'Vert', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/bb.jpeg',7);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 7);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 7);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 7);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull avec un flocon', 'Homme', 'Pull', 'Sweat-shirt', 'Vert', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/cc.jpeg',8);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 8);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 8);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 8);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull avec des boules de Noël', 'Homme', 'Pull', 'Sweat-shirt', 'Orange', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/dd.jpeg',9);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 9);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 9);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 9);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull moche', 'Homme', 'Pull', 'Sweat-shirt', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ee.jpeg',10);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 10);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 10);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 10);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull laid', 'Homme', 'Pull', 'Sweat-shirt', 'Jaune', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ff.jpeg',11);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 11);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 11);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 11);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull avec un sapin', 'Homme', 'Pull', 'Sweat-shirt', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/gg.jpeg',12);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 12);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 12);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 12);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull w/ bonhomme de neige', 'Homme', 'Pull', 'Sweat-shirt', 'Orange', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/hh.jpeg',13);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 13);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 13);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 13);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull avec du Houx', 'Homme', 'Pull', 'Sweat-shirt', 'Vert', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ii.jpeg',14);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 14);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 14);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 14);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull avec un reine', 'Homme', 'Pull', 'Sweat-shirt', 'Vert', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/jj.jpeg',15);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 15);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 15);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 15);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (7.00, 'Debardeur', 'Homme', 'Veste', 'Shirt', 'Blanc', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/kk.jpeg',16);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 16);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 16);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 16);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15.00, 'T-shirt plutôt sympa', 'Homme', 'T-Shirt', 'Shirt', 'Blanc', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ll.jpeg',17);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 17);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 17);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 17);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (19.99, 'Chemise de bureau', 'Homme', 'Veste', 'Shirt', 'Bleu', 'sophistiqué', 46);

INSERT INTO photos (lien, id_vetement) VALUES ('images/mm.jpeg',18);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 18);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 18);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 18);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (34.00, 'Veste de concert', 'Femme', 'Veste', 'Sweat-shirt', 'Violet', 'cool');

INSERT INTO photos (lien, id_vetement) VALUES ('images/nn.jpeg',19);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 19);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 19);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 19);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50.00, 'Manteau spécial froid', 'Homme', 'Veste', 'Manteau', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/oo.jpeg',20);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 20);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 20);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 20);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (25.00, 'Pull grave beau', 'Femme', 'Veste', 'Sweat-shirt', 'Rose', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/pp.jpeg',21);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 21);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 21);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 21);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'Chandail cosy', 'Femme', 'Veste', 'Sweat-shirt', 'Rose', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/qq.jpeg',22);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 22);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 22);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 22);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'Un pull,fin du tweet.', 'Femme', 'Veste', 'Sweat-shirt', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/rr.jpeg',23);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 23);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 23);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 23);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'Pull mouais', 'Femme', 'Veste', 'Sweat-shirt', 'Marron', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ss.jpeg',24);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 24);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 24);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 24);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'un Jean court', 'Femme', 'Pantalon', 'Jean', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/tt.jpeg',25);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 25);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 25);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 25);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'Pantalon de concert', 'Femme', 'Pantalon', 'Jean', 'Violet', 'cool');

INSERT INTO photos (lien, id_vetement) VALUES ('images/uu.jpeg',26);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 26);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 26);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 26);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'T-shirt rouge', 'Femme', 'T-Shirt', 'Shirt', 'Rouge', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/vv.jpeg',27);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 27);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 27);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 27);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'T-shirt orange', 'Femme', 'T-Shirt', 'Shirt', 'Orange', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ww.jpeg',28);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 28);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 28);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 28);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'T-shirt jaune', 'Femme', 'T-Shirt', 'Shirt', 'Jaune', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/xx.jpeg',29);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 29);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 29);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 29);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20.00, 'T-shirt bleu', 'Femme', 'T-Shirt', 'Shirt', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/yy.jpeg',30);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 30);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 30);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 30);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (20.00, 'Short basique', 'Homme', 'Pantalon', 'Short', 'Orange', 'décontracté', 57);

INSERT INTO photos (lien, id_vetement) VALUES ('images/zz.jpeg',31);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 31);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 31);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 31);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (20, 'Chaussures de concert', 'Femme', 'Chaussures', 'Basket', 'Violet', 'cool', 39);

INSERT INTO photos (lien, id_vetement) VALUES ('images/ab.jpeg',32);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 32);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 32);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 32);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (20, 'Chaussures de course', 'Femme', 'Chaussures', 'Basket', 'Vert', 'sport', 41);

INSERT INTO photos (lien, id_vetement) VALUES ('images/cd.jpeg',33);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 33);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 33);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 33);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20, 'Chaussures classe', 'Femme', 'Chaussures', 'Derbie', 'Violet', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ef.jpeg',34);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 34);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 34);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 34);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20, 'Basket ugh', 'Homme', 'Chaussures', 'Basket', 'Jaune', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/gh.jpeg',35);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 35);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 35);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 35);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20, 'Basket classique', 'Femme', 'Chaussures', 'Basket', 'Rose', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ij.jpeg',36);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 36);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 36);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 36);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (20, 'Mes chaussures', 'Femme', 'Chaussures', 'Palladium', 'Violet', 'décontracté', 40);

INSERT INTO photos (lien, id_vetement) VALUES ('images/kl.jpeg',37);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 37);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 37);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 37);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Chaussettes basiques', 'Homme', 'Chaussettes', 'Chaussettes', 'Vert', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/mn.jpeg',38);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 38);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 38);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 38);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Chaussettes sang', 'Homme', 'Chaussettes', 'Chaussettes', 'Rouge', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/op.jpeg',39);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 39);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 39);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 39);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Chaussettes dauphin', 'Femme', 'Chaussettes', 'Chaussettes', 'Noir', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/qr.jpeg',40);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 40);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 40);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 40);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Chaussettes simple', 'Femme', 'Chaussettes', 'Chaussettes', 'Orange', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/st.jpeg',41);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 41);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 41);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 41);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Noeud pap du pape', 'Homme', 'Noeud-Papillon', 'Noeud-Papillon', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/uv.jpeg',42);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 42);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 42);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 42);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Noeud classe', 'Homme', 'Noeud-Papillon', 'Noeud-Papillon', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/wx.jpeg',43);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 43);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 43);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 43);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Noeud papillon', 'Homme', 'Noeud-Papillon', 'Noeud-Papillon', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/yz.jpeg',44);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 44);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 44);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 44);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Noeud.', 'Homme', 'Noeud-Papillon', 'Noeud-Papillon', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/za.jpeg',45);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 45);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 45);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 45);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Cravate.', 'Homme', 'Cravate', 'Cravate', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/bc.jpeg',46);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 46);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 46);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 46);


INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Cravate jolie', 'Homme', 'Cravate', 'Cravate', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/de.jpeg',47);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 47);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 47);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 47);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (5, 'Cravate à acheter', 'Homme', 'Cravate', 'Cravate', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/fg.jpeg',48);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 48);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 48);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 48);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (14, 'Ruban cute', 'Femme', 'Ruban', 'Ruban', 'Violet', 'cute');

INSERT INTO photos (lien, id_vetement) VALUES ('images/hi.jpeg',49);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 49);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 49);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 49);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (14, 'Ruban awwwww', 'Femme', 'Ruban', 'Ruban', 'Bleu', 'cute');

INSERT INTO photos (lien, id_vetement) VALUES ('images/jk.jpeg',50);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 50);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 50);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 50);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (21, 'Baggi', 'Femme', 'Pantalon', 'Baggi', 'Marron', 'sophistiqué', 58);

INSERT INTO photos (lien, id_vetement) VALUES ('images/lm.jpeg',51);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 51);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 51);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 51);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (28, 'Pantalon avec ceinture', 'Femme', 'Pantalon', 'Jean', 'Rose', 'sophistiqué', 71);

INSERT INTO photos (lien, id_vetement) VALUES ('images/no.jpeg',52);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 52);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 52);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 52);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Pantalon 10/10', 'Femme', 'Pantalon', 'Jean', 'Violet', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/pq.jpeg',53);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 53);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 53);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 53);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Pantalon classico', 'Femme', 'Pantalon', 'Jean', 'Bleu', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/rs.jpeg',54);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 54);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 54);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 54);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Bretelles rouge', 'Femme', 'Bretelles', 'Bretelles', 'Bleu', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/tu.jpeg',55);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 55);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 55);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 55);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Bretelles vert', 'Femme', 'Bretelles', 'Bretelles', 'Vert', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/vw.jpeg',56);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 56);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 56);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 56);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Bretelles bleu', 'Homme', 'Bretelles', 'Bretelles', 'Bleu', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/xy.jpeg',57);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 57);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 57);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 57);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Bretelles jaune', 'Homme', 'Bretelles', 'Bretelles', 'Jaune', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/zaa.jpeg',58);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 58);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 58);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 58);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Manteau long', 'Homme', 'Veste', 'Manteau', 'Gris', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/aaa.jpeg',59);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 59);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 59);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 59);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Manteau long aussi', 'Homme', 'Veste', 'Manteau', 'Bleu', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/bbb.jpeg',60);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 60);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 60);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 60);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Manteau de pluie', 'Homme', 'Veste', 'Manteau', 'Jaune', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ccc.jpeg',61);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 61);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 61);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 61);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Chemise longue', 'Homme', 'Veste', 'Shirt', 'Bleu', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ddd.jpeg',62);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 62);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 62);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 62);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (28, 'Veste moto', 'Homme', 'Veste', 'Blazer', 'Gris', 'cool');

INSERT INTO photos (lien, id_vetement) VALUES ('images/eee.jpeg',63);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 63);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 63);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 63);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50, 'Sac noir', 'Femme', 'Sac', 'Sac-à-main', 'Noir', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/fff.jpeg',64);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 64);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 64);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 64);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50, 'Sac rouge', 'Femme', 'Sac', 'Sac-à-main', 'Rouge', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ggg.jpeg',65);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 65);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 65);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 65);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50, 'Sac orange', 'Femme', 'Sac', 'Sac-à-main', 'Orange', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/hhh.jpeg',66);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 66);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 66);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 66);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50, 'Sac bleu', 'Femme', 'Sac', 'Sac-à-main', 'Bleu', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/iii.jpeg',67);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 67);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 67);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 67);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50, 'Sac vert', 'Femme', 'Sac', 'Sac-à-main', 'Vert', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/jjj.jpeg',68);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 68);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 68);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 68);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (50, 'Sac violet', 'Femme', 'Sac', 'Sac-à-main', 'Violet', 'sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/kkk.jpeg',69);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 69);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 69);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 69);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (10, 'Tote-bag jaune', 'Femme', 'Sac', 'Tote-bag', 'Jaune', 'décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/lll.jpeg',70);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 70);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 70);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 70);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (4, 'Ceinture', 'Homme', 'Ceinture', 'Ceinture','Noir','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/mmm.jpeg',71);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 71);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 71);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 71);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15, 'Chapeau fraise', 'Femme', 'Chapeau', 'Casquette','Rose','décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/sss.jpeg',72);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 72);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 72);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 72);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15, 'Chapeau Chaplin', 'Femme', 'Chapeau', 'Melon','Bleu','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/ttt.jpeg',73);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 73);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 73);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 73);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15, 'Chapeau Layton', 'Femme', 'Chapeau','Haut-De-Forme','Noir','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/uuu.jpeg',74);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 74);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 74);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 74);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15, 'Echarge', 'Homme', 'Echarpe', 'Echarpe','Orange','décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/vvv.jpeg',75);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 75);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 75);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 75);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15, 'Chapeau One Piece', 'Femme', 'Chapeau', 'Chapeau-De-Paille','Jaune','cute');

INSERT INTO photos (lien, id_vetement) VALUES ('images/www.jpeg',76);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 76);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 76);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 76);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (15, 'Casquette blanche', 'Femme', 'Chapeau', 'Casquette','Blanc','décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/xxx.jpeg',77);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 77);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 77);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 77);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20, 'Combi basique rouge', 'Femme', 'CombiDeBase', 'CombiDeBase','Blanc','décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/b1.jpeg',78);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 78);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 78);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 78);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (20, 'Combi basique beige', 'Femme', 'CombiDeBase', 'CombiDeBase','Beige','décontracté');

INSERT INTO photos (lien, id_vetement) VALUES ('images/b2.jpeg',79);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 79);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 79);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 79);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style, id_accessoire) 
VALUES (20, 'Combi basique jaune', 'Homme', 'CombiDeBase', 'CombiDeBase','Jaune','décontracté', 70);

INSERT INTO photos (lien, id_vetement) VALUES ('images/b3.jpeg', 80);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 80);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 80);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 80);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (30, 'Combi business blanc', 'Homme', 'CombiBusiness', 'CombiBusiness','Blanc','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/bu1.jpeg',81);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 81);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 81);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 81);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (30, 'Combi business gris', 'Homme', 'CombiBusiness', 'CombiBusiness','Gris','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/bu2.jpeg',82);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 82);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 82);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 82);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (30, 'Combi business marron', 'Homme', 'CombiBusiness', 'CombiBusiness','Marron','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/bu3.jpeg',83);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 83);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 83);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 83);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (40, 'Combi de luxe blanc', 'Homme', 'CombiLuxe', 'CombiLuxe','Blanc','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/l1too.jpeg',84);
INSERT INTO photos (lien, id_vetement) VALUES ('images/l1.jpeg',84);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 84);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 84);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 84);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (40, 'Combi de luxe gris', 'Homme', 'CombiLuxe', 'CombiLuxe','Gris-Pourpre','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/l2f.jpeg',85);
INSERT INTO photos (lien, id_vetement) VALUES ('images/l2m.jpeg',85);
INSERT INTO photos (lien, id_vetement) VALUES ('images/l2b.jpeg',85);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 85);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 85);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 85);

INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) 
VALUES (40, 'Combi de luxe bleu', 'Homme', 'CombiLuxe', 'CombiLuxe','Bleu','sophistiqué');

INSERT INTO photos (lien, id_vetement) VALUES ('images/lu3f.jpeg',86);
INSERT INTO photos (lien, id_vetement) VALUES ('images/lu3b.jpeg',86);

INSERT INTO taille_disponible (taille, id_vetement) VALUES (38, 86);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (40, 86);
INSERT INTO taille_disponible (taille, id_vetement) VALUES (42, 86);







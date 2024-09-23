const pg = require('pg');
const pool = new pg.Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'friperie',
  password: '',
  port: 5432
});

function Base() {
  let client;

  this.connect = async function () {
    client = await pool.connect();
  }

  this.getVetementsDispo = async function () {
    const result = await client.query('SELECT DISTINCT vetement.id, nom, prix FROM vetement INNER JOIN taille_disponible ON vetement.id = taille_disponible.id_vetement;');
    return result.rows;
  };

  this.getAllVetements = async function () {
    const result = await client.query(`SELECT * FROM vetement`);
    return result.rows;
  };

  this.getCommentaires = async function (vetementId) {
    try {
      const result = await client.query(`SELECT * FROM commentaire WHERE id_vetement = $1`, [vetementId]);
      return result.rows;
    } catch (error) {
      console.error('Erreur lors de la récupération des commentaires:', error);
      throw error;
    }
  };  

  // Méthode pour ajouter un commentaire à un article
  this.ajouterCommentaire = async function (content, vetementId) {
    try {
      const query = 'INSERT INTO commentaire (contenu, id_vetement) VALUES ($1, $2)';
      const values = [content, vetementId];
      await client.query(query, values);
    } catch (error) {
      throw new Error("Erreur lors de l'ajout du commentaire : " + error.message);
    }
  };   

  this.getNombreTotalArticles = async function () {
    try {
      const result = await client.query('SELECT COUNT(*) AS total_articles FROM vetement');
      const total = parseInt(result.rows[0].total_articles, 10);
      return total;
    } catch (error) {
      console.error('Erreur lors de la récupération du nombre total d\'articles :', error);
      return 0; // En cas d'erreur, retourner 0
    }
  };

  this.getCommandes = async function () {
    const result = await client.query(`SELECT * FROM commande`);
    return result.rows;
  };

  this.getFiltre = async function () {
    const categories = await client.query(`SELECT DISTINCT categorie FROM vetement;`);
    const couleurs = await client.query(`SELECT DISTINCT couleur FROM vetement;`);
    const styles = await client.query(`SELECT DISTINCT style FROM vetement;`);
    const tailles = await client.query(`SELECT DISTINCT taille FROM taille_disponible ORDER BY taille ASC;`);

    const tab = {
      categories: categories.rows.map(row => row.categorie),
      couleurs: couleurs.rows.map(row => row.couleur),
      styles: styles.rows.map(row => row.style),
      tailles: tailles.rows.map(row => row.taille)
    };

    return tab;
  }

  this.getAllPhotos = async function () {
    const result = await client.query(`SELECT * FROM photos;`);
    return result.rows;
  };

  this.getPhotos = async function (id) {
    const result = await client.query(`SELECT * FROM photos WHERE id_vetement = ${id};`);
    return result.rows;
  };

  this.requeteFiltre = function (categorie, couleur, style, taille, prix) {
    let requete = 'SELECT DISTINCT vetement.id, nom, prix FROM vetement JOIN taille_disponible ON vetement.id = taille_disponible.id_vetement WHERE true';

    if (!Array.isArray(categorie))
      requete += ` AND categorie = '${categorie}'`;
    else {
      for (let i = 0; i < categorie.length; i++) {
        if (i === 0)
          requete += ` AND categorie = '${categorie[i]}'`;
        else
          requete += ` OR categorie = '${categorie[i]}'`;
      }
    }

    if (!Array.isArray(couleur))
      requete += ` AND couleur = '${couleur}'`;
    else {
      for (let i = 0; i < couleur.length; i++) {
        if (i === 0)
          requete += ` AND couleur = '${couleur[i]}'`;
        else
          requete += ` OR couleur = '${couleur[i]}'`;
      }
    }

    if (!Array.isArray(style))
      requete += ` AND style = '${style}'`;
    else {
      for (let i = 0; i < style.length; i++) {
        if (i === 0)
          requete += ` AND style = '${style[i]}'`;
        else
          requete += ` OR style = '${style[i]}'`;
      }
    }

    if (!Array.isArray(taille))
      requete += ` AND taille = ${taille}`;
    else {
      for (let i = 0; i < taille.length; i++) {
        if (i === 0)
          requete += ` AND taille = ${taille[i]}`;
        else
          requete += ` OR taille = ${taille[i]}`;
      }
    }

    if (prix != 0)
      requete += ` AND prix < ${prix}`;

    return requete;
  }

  this.filtre = async function (categorie, couleur, style, taille, prix) {
    const requete = this.requeteFiltre(categorie, couleur, style, taille, prix);
    const result = await client.query(requete);
    return result.rows;
  }

  this.filtreAvecGenre = async function (categorie, couleur, style, taille, prix, genre) {
    let requete = this.requeteFiltre(categorie, couleur, style, taille, prix);

    if (genre != "")
      requete += ` AND genre = '${genre}'`;

    let result = await client.query(requete);
    return result.rows;
  }

  this.filtreGenre = async function (genre) {
    const result = await client.query(`SELECT id, nom, prix FROM vetement WHERE genre = '${genre}';`);
    return result.rows;
  };

  this.panier = async function () {
    const result = await client.query('SELECT * FROM panier;');
    return result.rows;
  };

  this.getVetement = async function (id) {
    const result = await client.query(`SELECT * FROM vetement INNER JOIN taille_disponible ON vetement.id = taille_disponible.id_vetement WHERE id_vetement = ${id};`);
    return result.rows[0];
  };

  this.getTailles = async function (id) {
    const result = await client.query(`SELECT DISTINCT taille FROM taille_disponible WHERE id_vetement = ${id} ORDER BY taille ASC;`);
    return result.rows;
  };

  this.getAllTailles = async function () {
    const result = await client.query(`SELECT * FROM taille_disponible;`);
    return result.rows;
  };

  this.ajoutTaille = async function (taille, id) {
    await client.query(`INSERT INTO taille_disponible (taille, id_vetement) VALUES (${taille}, ${id})`);
  }

  this.retraitTaille = async function (taille, id) {
    await client.query(`DELETE FROM taille_disponible WHERE id = (SELECT id FROM taille_disponible WHERE taille = ${taille} AND id_vetement = ${id} LIMIT 1)`);

  }

  this.retrait = async function (id) {
    await client.query(`DELETE FROM vetement WHERE id = ${id}`);
  }

  this.ajout = async function (nom, prix, genre, categorie, sous_categorie, couleur, style, taille, accessoire, photo1, photo2, photo3) {
    await client.query(`INSERT INTO vetement (prix, nom, genre, categorie, sous_categorie, couleur, style) VALUES (${prix}, '${nom}', '${genre}', '${categorie}', '${sous_categorie}', '${couleur}', '${style}');`);

    const id = (await client.query(`SELECT id FROM vetement ORDER BY id DESC`)).rows[0].id;
    if (accessoire != '')
      await client.query(`UPDATE vetement SET id_accessoire = ${accessoire} WHERE id = ${id};`);

    await client.query(`INSERT INTO taille_disponible (taille, id_vetement) VALUES (${taille}, ${id})`);
    await client.query(`INSERT INTO photos (lien, id_vetement) VALUES ('images/${photo1}', ${id})`);
    if (photo2 != '')
      await client.query(`INSERT INTO photos (lien, id_vetement) VALUES ('images/${photo2}', ${id})`);
    if (photo3 != '')
      await client.query(`INSERT INTO photos (lien, id_vetement) VALUES ('images/${photo3}', ${id})`);

  }

  this.modifVetement = async function (id, nom, prix, genre, categorie, sous_categorie, couleur, style, accessoire) {
    if(accessoire === 0)
      accessoire = NULL;
    const query = `UPDATE vetement SET nom = $1, prix = $2, genre = $3, categorie = $4, sous_categorie = $5, style = $6, couleur = $7, id_accessoire = $8 WHERE id = $9;`;
    const values = [nom, prix, genre, categorie, sous_categorie, style, couleur, accessoire, id];
    await client.query(query, values);
  }

  this.ajoutCommande = async function(nom, prenom, date, telephone, email, adresse, heure) {
    try {
      const sql = `INSERT INTO commande (nom_client, prenom_client, date_de_naissance, telephone, email, adresse, heure)
                   VALUES ($1, $2, $3, $4, $5, $6, $7)
                   RETURNING id`;
    
      const params = [nom, prenom, date, telephone, email, adresse, heure];
    
      const result = await client.query(sql, params);
      const insertedId = result.rows[0].id;
    
      console.log('Commande ajoutée avec succès.');
    
      return insertedId;
    } catch (error) {
      console.error('Une erreur s\'est produite lors de l\'ajout de la commande :', error);
      throw error;
    }
  };
  
  this.ajoutPanier = async function (id_vetement, taille) {
    await client.query(`INSERT INTO panier (id_vetement, taille) VALUES (${id_vetement}, ${taille});`);
  };

  this.getAccessoire = async function (id) {
    const { rows } = await pool.query('SELECT * FROM accessoires WHERE id = $1', [id]);
    return rows[0];
  };

  this.panierInfo = async function (panier) {
    const produits = [];
    let total = 0;

    for (const produit of panier) {
      const vetement = await this.getVetement(produit.id_vetement);

      // Compter la quantité d'articles avec le même nom
      //const res = await pool.query("SELECT COUNT(*) as count FROM vetements WHERE nom = $1", [vetement.nom]);
      //const quantite = res.rows[0].count;
      const quantite = 1;

      produits.push({
        id: produit.id,
        id_vetement: vetement.id_vetement,
        nom: vetement.nom,
        prix: vetement.prix,
        quantite: quantite,
        taille: produit.taille
      });

      total += vetement.prix * quantite;
    }

    total = Number(total);
    total = total.toFixed(2);

    return {
      produits,
      total
    };
  };
  
  this.copiePanier = async function(id) {
    try {
      const query = 'INSERT INTO panier_copie (id_vetement, id_commande, taille) SELECT id_vetement, $1, taille FROM panier';
      const values = [id];
    
      await client.query(query, values);
    
      console.log('Copie du panier effectuée avec succès.');
    } catch (error) {
      console.error('Une erreur s\'est produite lors de la copie du panier :', error);
      throw error;
    }
  };
  
  this.supprimerProduitPanier = async function (idProduit) {
    await client.query(`DELETE FROM panier WHERE id=${idProduit};`);
  };

  this.supprimerCommande = async function (idCommande) {
    await client.query(`DELETE FROM commande WHERE id=${idCommande};`);
  };
  
  this.supprimerVetement = async function(idCommande) {
    try {
      // Récupérer les vêtements du panier copié de la commande spécifiée
      const vetementsPanier = await client.query('SELECT id_vetement, taille FROM panier_copie WHERE id_commande = $1', [idCommande]);
  
      // Supprimer un exemplaire de chaque vêtement du panier
      for (const vetement of vetementsPanier.rows) {
        await client.query('DELETE FROM taille_disponible WHERE id_vetement = $1 AND taille = $2 AND id IN (SELECT id FROM taille_disponible WHERE id_vetement = $1 AND taille = $2 LIMIT 1)', [vetement.id_vetement, vetement.taille]);
      }
  
      console.log('Suppression des vêtements effectuée avec succès.');
    } catch (error) {
      console.error('Erreur lors de la suppression des vêtements :', error);
    }
  };
    

  this.viderPanier = async function () {
    await client.query(`DELETE FROM panier`);
  };

  this.nbrArticlesPanier = async function () {
    return await client.query(`SELECT COUNT(*) AS count FROM panier`);
  };

  this.verifGerant = async function (pseudo, mdp) {
    const a = await client.query(`SELECT * FROM gerant WHERE pseudo = '${pseudo}' AND password = '${mdp}'`);
    return a.rows.length > 0;
  }

  this.getPrixMax = async function(){
    const result = await client.query('SELECT MAX(prix) FROM vetement;');
    return parseFloat(result.rows[0].max) + 5;
  }

  this.getNom = async function(id){
    const result = await client.query(`SELECT nom FROM vetement WHERE id = ${id};`);
    const row = result.rows[0];
    if(row != undefined)
      return row.nom;
    else
      return "";
  }

}

module.exports = new Base();

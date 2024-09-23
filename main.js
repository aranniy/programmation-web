const express = require('express');
const moment = require('moment');
const serveur = express();
const base = require('./Base');

serveur.set('view engine', 'ejs'); // configure le moteur de template
serveur.use(express.static('public'));
serveur.use(express.urlencoded({ extended: true })); // permet de récupérer les données du formulaire

// route pour la page du formulaire
serveur.get('/form', (req, res) => {
  res.render('form', {
    nom: "",
    prenom: "",
    birthdate: "",
    tel: "",
    email: "",
    heure: "",
    errorMessage: ""
  });
});

// Route qui mène à un article au hasard
serveur.get('/article/aleatoire', async (req, res) => {
    // Récupérer le nombre total d'articles
    const totalArticles = await base.getNombreTotalArticles();
  
    // Générer un nombre aléatoire entre 1 et le nombre total d'articles
    const randomId = Math.floor(Math.random() * totalArticles) + 1;
  
    // Récupérer l'article correspondant à l'ID aléatoire
    const vet = await base.getVetement(randomId);
    const tailles = await base.getTailles(randomId);
    const photos = await base.getPhotos(randomId);
  
    // Récupération des commentaires associés à l'article
    const commentaires = await base.getCommentaires(randomId);
    const nomAccesoire = await base.getNom(vet.id_accessoire);

    // Rendre la page de l'article au format souhaité
    res.render('article', { 
      vetement: vet,
      photos: photos, 
      tailles: tailles, 
      message: "", 
      commentaires: commentaires,
      nomAccesoire: nomAccesoire
    });
});

// Route qui gère la page panier
serveur.get('/panier', async (req, res) => {
  await base.connect(); // Se connecter à la base de données

  const panier = await base.panier(); // Récupérer le panier
  const panierInfo = await base.panierInfo(panier); // Récupérer les informations sur le panier (produits et total)

  // Passer la variable "produits" à la vue panier.ejs
  res.render('panier', { produits: panierInfo.produits, total: panierInfo.total });
});

// route qui permet de supprimer un article du panier 
serveur.delete('/produit/:id', async (req, res) => {
  const idProduit = req.params.id;
  try {
    await base.supprimerProduitPanier(idProduit);
    res.sendStatus(200);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

// route qui permet de supprimer une commande ET retirer les vetements associés à cette commande
serveur.delete('/commande/:id', async (req, res) => {
  const idCommande = req.params.id;
  try {
    await base.supprimerVetement(idCommande);
    await base.supprimerCommande(idCommande);
    res.sendStatus(200);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

// route qui permet de récupérer le nombre d'articles dans un panier (pour pouvoir désactiver le bouton payer)
serveur.get('/panier/nbrArticles', async (req, res) => {
  try {
    const result = await base.nbrArticlesPanier();
    const count = result.rows[0].count;
    res.send(count);
  } catch (err) {
    console.error(err);
    res.status(500).send("Erreur lors du comptage des articles dans le panier");
  }
});


async function run() {
  base.connect();

  // route menant à la page d'accueil
  serveur.get('/', async (req, res) => {
    res.render('accueil', {
      listeVet: await base.getVetementsDispo(),
      filtres: await base.getFiltre(),
      photos: await base.getAllPhotos(),
      message: '',
      prixMax: await base.getPrixMax()
    });
  });

  // route gérant les filtres
  serveur.post('/', async (req, res) => {
    const categorie = req.body.categorie || [];
    const couleur = req.body.couleur || [];
    const taille = req.body.taille || [];
    const style = req.body.style_vet || [];
    const prix = req.body.prix;
    res.render('accueil', {
      listeVet: await base.filtre(categorie, couleur, style, taille, prix),
      filtres: await base.getFiltre(),
      photos: await base.getAllPhotos(),
      message: '',
      prixMax: await base.getPrixMax()
    });
  });

  // route menant à la page du gérant
  serveur.post('/gestion', async (req, res) => {
    const pseudo = req.body.pseudo;
    const mdp = req.body.mdp;
    if (await base.verifGerant(pseudo, mdp)) {
      res.render('gestion', {
        listeVet: await base.getAllVetements(),
        photos: await base.getAllPhotos(),
        tailles: await base.getAllTailles(),
        commandes : await base.getCommandes()
      });
    } else {
      res.render('accueil', {
        listeVet: await base.getVetementsDispo(),
        filtres: await base.getFiltre(),
        photos: await base.getAllPhotos(),
        message: 'incorrect',
        prixMax: await base.getPrixMax()
      });
    }
  });

  // route qui permet d'ajouter des tailles à des vêtements
  serveur.post('/ajoutTaille', async (req, res) => {
    await base.ajoutTaille(req.body.taille, req.body.id);
    res.render('gestion', {
      listeVet: await base.getAllVetements(),
      photos: await base.getAllPhotos(),
      tailles: await base.getAllTailles(),
      commandes : await base.getCommandes()
    });
  });

  // route -> retire des tailles à des vêtements
  serveur.post('/retraitTaille', async (req, res) => {
    await base.retraitTaille(req.body.taille, req.body.id);
    res.render('gestion', {
      listeVet: await base.getAllVetements(),
      photos: await base.getAllPhotos(),
      tailles: await base.getAllTailles(),
      commandes : await base.getCommandes()
    });
  });

  // route menant au retrait de vêtements
  serveur.post('/retrait', async (req, res) => {
    await base.retrait(req.body.id);
    res.render('gestion', {
      listeVet: await base.getAllVetements(),
      photos: await base.getAllPhotos(),
      tailles: await base.getAllTailles(),
      commandes : await base.getCommandes()
    });
  });

  // Ajout de vêtements 
  serveur.post('/ajout', async (req, res) => {
    await base.ajout(req.body.nom, req.body.prix, req.body.genre, req.body.categorie, req.body.sous_categorie , req.body.couleur, req.body.style, req.body.taille, req.body.accessoire, req.body.photo1, req.body.photo2, req.body.photo3); 
    res.render('gestion', {
      listeVet: await base.getAllVetements(),
      photos: await base.getAllPhotos(),
      tailles: await base.getAllTailles(),
      commandes : await base.getCommandes()
    });
  });

  // Modifications de vêtements
  serveur.post('/modif', async (req, res) => {
    await base.modifVetement(req.body.id, req.body.nom, req.body.prix, req.body.genre, req.body.categorie, req.body.sous_categorie , req.body.couleur, req.body.style, req.body.accessoire); 
    res.render('gestion', {
      listeVet: await base.getAllVetements(),
      photos: await base.getAllPhotos(),
      tailles: await base.getAllTailles(),
      commandes : await base.getCommandes()
    });
  });

  // Filtre genre
  serveur.get('/:genre', async (req, res) => {
    const listeVet = await base.filtreGenre(req.params.genre);
    res.render('accueil', {
      listeVet: listeVet,
      filtres: await base.getFiltre(),
      photos: await base.getAllPhotos(),
      message: '',
      prixMax: await base.getPrixMax()
    });
  });

  // Filtre genre
  serveur.post('/:genre', async (req, res) => {
    const categorie = req.body.categorie || [];
    const couleur = req.body.couleur || [];
    const style = req.body.style_vet || [];
    const taille = req.body.taille || [];
    const prix = req.body.prix || [];
    const listeVet = await base.filtreAvecGenre(categorie, couleur, style, taille, prix, req.params.genre);
    
    res.render('accueil', {
      listeVet: listeVet,
      filtres: await base.getFiltre(),
      photos: await base.getAllPhotos(),
      message: '',
      prixMax: await base.getPrixMax()
    });
  });

  // Route permettant d'afficher la page associée à un article
  serveur.get('/article/:id', async (req, res) => {
    const id = parseInt(req.params.id);
    const vet = await base.getVetement(id);
    const photos = await base.getPhotos(id);
    const tailles = await base.getTailles(id);

    // Récupération des commentaires associés à l'article
    const commentaires = await base.getCommentaires(id);
    const nomAccesoire = await base.getNom(vet.id_accessoire);

    res.render('article', { 
      vetement: vet,
      photos: photos, 
      tailles: tailles, 
      message: "", 
      commentaires: commentaires,
      nomAccesoire: nomAccesoire
    });
  });

  serveur.post('/article/:id', async (req, res) => {
    const id = parseInt(req.params.id);
    let message = '';

    // gère le cas où on ajoute une taille d'un vetement au panier
    if (req.body.taille) {
      await base.ajoutPanier(id, req.body.taille);
      message = 'ajout';
    }
    const vet = await base.getVetement(id);
    const tailles = await base.getTailles(id);
    const photos = await base.getPhotos(id);
  
    // gère le cas où un commentaire a été posté
    const contenu = req.body.contenu;
    if (contenu) {
      await base.ajouterCommentaire(contenu,id);
      message = 'commentaire';
    }

    // Récupération des commentaires associés à l'article
    const commentaires = await base.getCommentaires(id);
    const nomAccesoire = await base.getNom(vet.id_accessoire);
  
    res.render('article', { 
      vetement: vet, 
      photos: photos, 
      tailles: tailles, 
      message: message, 
      commentaires: commentaires,
      nomAccesoire: nomAccesoire
    });
  });  

}

// Route permettant les vérifications du formulaire
serveur.post('/form', async (req, res) => {

  const { civil, nom, prenom, complet, birthdate, tel, email, adresse, heure } = req.body;
  let bool = true;
  let errorMessage = ""; // c'est là que l'on va stocker le (possible) message d'erreur 

  // Vérification de l'adresse
  const adresseRegex = /^[0-9]+(?:\s\w+)+\s\d{5}\s\w+$/;
  if (!adresseRegex.test(adresse)) {
    bool = false;
    errorMessage = "L'adresse n'est pas valide. Veuillez entrer une adresse au format suivant : 11 rue de la Paix 75000 Ville.";
  }

  // Vérification de la date de naissance
  const dateNaissance = moment(birthdate, 'YYYY-MM-DD');
  const maintenant = moment();
  const age = maintenant.diff(dateNaissance, 'years');

  if (age < 18) {
    bool = false;
    errorMessage = "Il faut avoir au moins 18 ans pour commander sur notre site.";
  }

  // Vérification du nom et prénom
  const lettresRegex = /^[a-zA-Z]+$/;
  if (!lettresRegex.test(nom) || !lettresRegex.test(prenom)) {
    bool = false;
    errorMessage = "Le nom et le prénom ne doivent contenir que des lettres. (ne mettez pas d'accents ou de caractères spéciaux)";
  }

  // Vérification de l'email
  const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  if (!emailRegex.test(email)) {
    bool = false;
    errorMessage = "L'email n'est pas valide. Veuillez entrer un email au format suivant : texte@texte.texte.";
  }

  // Vérification du numéro de téléphone
  const telRegex = /^(0|\+33)[1-9]([-. ]?[0-9]{2}){4}$/;
  if (!telRegex.test(tel)) {
    bool = false;
    errorMessage = "Le numéro de téléphone n'est pas valide. Veuillez entrer un numéro au format suivant : xx xx xx xx xx ou +33x xx xx xx xx.";
  }

  // si il y a une erreur
  if (!bool) {
    res.render('form', {
      nom: nom,
      prenom: prenom,
      birthdate: birthdate,
      tel: tel,
      email: email,
      heure: heure,
      errorMessage: errorMessage
    });
  // si tout va bien
  } else {
    // traitement des données et enregistrement dans la base de données
    res.render('confirmation', {
      nom,
      prenom,
      birthdate,
      tel,
      email,
      adresse,
      heure
    });

    // On ajoute la commande
    const id = await base.ajoutCommande(nom, prenom, birthdate, tel, email, adresse, heure);

    // On copie le contenu du panier pour le conserver avant de le vider
    await base.copiePanier(id);

    // On vide le panier 
    base.connect();
    panierVide = base.viderPanier();
  }

});

serveur.listen(8080, () => {
  console.log('Serveur lancé sur le port 8080');
});

run();

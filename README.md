# Projet de Programmation Web

Ceci est le git consacré à la réalisation d'une friperie solidaire !
Vous pourrez agir en tant que client, ou gérant (via un système d'authentification) !

Membres de l'équipe :
* BLIVI Fafa
* LINGESWARAN Aranniy

Pour lancer le site : `node main.js`

Page d'accueil : http://localhost:8080/

Gérants du site : 

| PSEUDO | MDP |
| ------ | ------ |
| Fafa | fafa |
| Aranniy | aranniy | 

*Comment gérer la connexion à la BD, etc. pour que cela marche sur une autre machine ?*

Tout d'abord, dans le fichier Base.js nous avons la configuration pour établir une connexion à une base de données PostgreSQL suivante : 
```
const pg = require('pg');
const pool = new pg.Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'friperie',
  password: '',
  port: 5432
});
```

Il va falloir créer une database (base de données) nommée friperie et executer le script sql depuis cette base dans postgres avec la commande :

`\i /Chemin/Vers/Le/Fichier/init.sql`

Le port, l'host et le mot de passe devra, peut être, être modifié en fonction de vos besoins.

Répartition des tâches :
* Gestion de l'accueil (Fafa)
* Gestion de la page d'article (Fafa)
* Gestion des filtres (Fafa)
* Gestion de l'ajout d'articles dans un panier (Fafa)
* Gestion du panier (Aranniy)
* Gestion du formulaire (Aranniy)
* Gestion des commandes (Aranniy)
* Gestion de la page aléatoire (Aranniy)
* Gestion des commentaires (Aranniy)
* Gestion du design (Aranniy)
* Gestion de la BDD (Fafa/Aranniy)
* Gestion du gérant (Fafa/Aranniy)


Vous savez à peu près l'essentiel, bon shopping ! 

Sources des images :
*  Articles : https://fr.dreamstime.com/ 
* Logo du site : WIX
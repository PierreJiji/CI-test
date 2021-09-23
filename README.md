# Site: 
- https://cqen-qdce.github.io/plateforme-accueil-centre-innovation/

### Pipeline de déploiement en production

Le pipeline est démarré par : 
-	Un Github Pull Request se faisant accepter sur la branche main OU tout autre push sur la branche main.
Le pipeline fonctionne sur : 
-	Github Actions
Le pipeline déploie le site vers : 
-	Amazon S3

Pour démarrer le pipeline de déploiement, il faut avoir soit poussé directement sur la branche principale des changements, créé et accepté un pull request, ou alors aller sur la dernière instance exécutée du pipeline dans la section « actions » et cliquer sur « rerun all jobs » sur le build du CI/CD.
 
Vous pourrez ensuite voir le processus s’exécuter et voir les détails de chaque étapes du fichier YAML en cliquant sur « build » : 
Si les secrets ne fonctionnent plus ou vous avez à changer de bucket ou de compte AWS pour le déploiement, vous pouvez aller dans les options du dépôt github, dans la section « secrets » et mettre à jour les différents secrets nécessaires au fonctionnement du workflow.
-	AWS_ACCESS_KEY_ID : Le nom de la clé (ID) de connexion du compte IAM utilisé.
-	AWS_DEFAULT_REGION : La région par défaut du bucket.
-	AWS_S3_BUCKET_NAME : Le nom du bucket utilisé.
-	AWS_SECRET_ACCESS_KEY : La valeur de la clé de connexion du compte IAM utilisé.


### Pour héberger le site localement:
1. Cloner le projet.
2. Faire la commande `git submodule init` pour initialiser le submodule dans votre répertoire local, puis `git submodule update` pour pull la dernière version du submodule.
3. Avoir ruby v2.4.0 ou + installé sur votre poste et faire la commande ```gem install jekyll bundler```.
4. Faire la commande ```bundle exec jekyll server``` à la racine du site.

### Pour mettre à jour le submodule (contenu du site): 
```bash
git submodule update --remote
``` 

### Explication des dossiers
- `_layouts` : fichiers html faisant office de template, un layout est le html qui englobe le contenu d'une page, plusieurs layouts peuvent être utilisés l'un dans l'autre
- `_include` : layouts imbriqués dans ceux plus généraux dans - `_layouts` :
- `_posts` : fichiers markdown contenant certains paramètres et son contenu, ce sont les articles qui seront utilisés et listés sur le site
- `_sass` : scss disponible du site et des thèmes
- `.github/workflow` : contient les paramètres de build pour github pages, notamment quel token utiliser
- `assets` : (à vérifier) contient les contenus multimédia du site ainsi que les feuilles de style utilisées, le css généré par le css se retrouvera dans ce dossier lors du build
- `_site` : (généré lors d'un push) site résultant du build

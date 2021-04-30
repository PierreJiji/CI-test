# Site: 
- https://nathan-gt.github.io/Jekyll-Actions-Demo/

### Explication des dossiers
- `_layouts` : fichiers html faisant office de template, un layout est le html qui englobe le contenu d'une page, plusieurs layouts peuvent être utilisés l'un dans l'autre
- `_include` : layouts imbriqués dans ceux plus généraux dans - `_layouts` :
- `_posts` : fichiers markdown contenant certains paramètres et son contenu, ce sont les articles qui seront utilisés et listés sur le site
- `_sass` : scss disponible du site et des thèmes
- `.github/workflow` : contient les paramètres de build pour github pages, notamment quel token utiliser
- `assets` : (à vérifier) contient les contenus multimédia du site ainsi que les feuilles de style utilisées, le css généré par le css se retrouvera dans ce dossier lors du build
- `_site` : (généré lors d'un push) site résultant du build

#### À noter:
Il n'est pas nécéssaire d'inclure les fichiers du thème pour qu'ils soit loadés lors du build, tant que les attributs `baseurl:` et `url:` sont valide, j'ai cependant inclu les fichiers originaux du thème pour voir la structure complète du site qui est pris en compte par le builder et expérimenter. 

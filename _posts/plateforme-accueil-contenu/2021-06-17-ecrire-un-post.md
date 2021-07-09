---
title:  "Écrire un post"
date:   2021-06-18 08:30:00 -0400
---
La plateforme d'accueil supporte la syntaxe markdown de [Github](https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax), cette page explique les quelque éléments à inclure dans votre fichier pour assurer son intégration au site de la plateforme d'accueil.


# En-tête du document
Chaque post doit inclure ce bloc de texte avant son contenu (les blocs entre <> doivent être remplacés par vous):

```markdown
---
layout: post
title:  "<titre de votre article>"
date:   <YYYY-MM-DD> <hh:mm:ss> <votre fuseau horaire>
categories: documentation
---
```
Voici par exemple celui utilisé pour cette page:
```markdown
---
layout: post
title:  "{{page.title}}"
date:   {{page.date}}
categories: documentation
---
```
Explication des attributs:
- `title`: Le titre de votre post.
- `date`: La date et heure à laquelle vous avez écrit le post

> NOTE: si vous mettez une date et heure future, votre post ne s’affichera pas sur le site avant cette date et heure.

# Nom du fichier
Le nom que vous devez donner au fichier doit respecter le format suivant:
```
<YYYY-MM-DD>-<titre>.md
```
ou
```
<YYYY-MM-DD>-<titre>.markdown
```

Par exemple, le nom du fichier de ce post est `2021-06-17-ecrire-un-post.md`.

# Inclure des images ou vidéos youtube à votre post
Voir la page dédiée à ce sujet: [Inclure des ressources à un post]({{site.baseurl}}/plateforme-accueil-contenu/documentation/2021/06/08/inclure-des-ressources-a-un-post.html)


---
layout: post
title:  "Inclure des ressources à un post"
date:   2021-06-08 10:14:02 -0400
categories: documentation
---
Il existe deux façons simples d'inclure une ressource multimédia dans un post, cette page vous montrera comment.

Bien que la manière recommandée d'ajouter des ressources multimédia à un post soit d'utiliser la syntaxe fourni par Jekyll, vous pouvez aussi ajouter directement n'importe quel code html (et scripts) désiré à votre post si besoin est. 

## Inclure une image
Pour inclure des fichiers locaux, veuillez inclure le fichier dans le dossier assets du dépôt du blog et référencez le comme suit:
{% highlight markdown %}
![<Titre de la ressource>]({{site.baseurl}}/assets/res_posts/<ficher-à-inclure.jpg>)
{% endhighlight %}

![Image test]({{site.baseurl}}/assets/res_posts/test-image.jpg)

## Inclure gif
![Animated image test]({{site.baseurl}}/assets/res_posts/test-gif.gif)

## Inclure vidéo (depuis lien)
Copier le lien avec l'option "intégrer" ("embeded" en anglais) fourni par la vidéo youtube/autre service. Insérez le dans un `<div>` avec la class scss "videoWrapper" qui permet à la vidéo d'avoir une taille adaptative gardant les proportions de la vidéo originelle.

Code de cette vidéo:
{% highlight html %}
  <div class="videoWrapper">
    <collez le code copié ici >
  </div>
{% endhighlight %}

<div class="videoWrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/9RHFFeQ2tu4" title="Test vidéo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
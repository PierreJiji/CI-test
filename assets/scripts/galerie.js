window.onload = init;

var noImageCourant = 0;
var noImage = 1;
var id = "image" + noImage;
document.getElementById(id).style.border="5px double #3a2cfc";

var tempsAttente;
var ilYADemarrage = false;

var imDescription = new Array();

for(j = 0; j < 11; j++)
{
	imDescription[j] = new Array();
}

imDescription[0]["titre"] = "Daniel Piché";
imDescription[0]["image"] = "image1.jpg";
imDescription[0]["nouveauTitre"] = "Directeur de l'innovation et de la performance";	

imDescription[1]["titre"] = "Viviane Orge";
imDescription[1]["image"] = "image2.jpg";
imDescription[1]["nouveauTitre"] = "Développeuse full stack";	

imDescription[2]["titre"] = "Rocio Philipps Valencia ";
imDescription[2]["image"] = "image3.jpg";
imDescription[2]["nouveauTitre"] = "Développeuse full stack";	

imDescription[3]["titre"] = "Diego Barreto";
imDescription[3]["image"] = "image4.jpg";
imDescription[3]["nouveauTitre"] = "Développeur full stack";	

imDescription[4]["titre"] = "Francis Gagné";
imDescription[4]["image"] = "image5.jpg";
imDescription[4]["nouveauTitre"] = "Développeur full stack";

imDescription[5]["titre"] = "Pierre Jiji";
imDescription[5]["image"] = "Pierre.jpg";
imDescription[5]["nouveauTitre"] = "Développeur full stack";

imDescription[6]["titre"] = "Philippe Foucault";
imDescription[6]["image"] = "Philippe.jpg";
imDescription[6]["nouveauTitre"] = "Responsable innovation";

imDescription[7]["titre"] = "Stéphane Paré";
imDescription[7]["image"] = "Stephane.jpg";
imDescription[7]["nouveauTitre"] = "Conseiller en architecture-innovation";

imDescription[8]["titre"] = "Basile M'vayi";
imDescription[8]["image"] = "Basile.jpg";
imDescription[8]["nouveauTitre"] = "Analyste en développement multiniveaux";

imDescription[9]["titre"] = "Ahmed Najjar,";
imDescription[9]["image"] = "Ahmed.jpg";
imDescription[9]["nouveauTitre"] = "Conseiller en IA";

imDescription[10]["titre"] = "Martin St-Pierre";
imDescription[10]["image"] = "Martin.jpg";
imDescription[10]["nouveauTitre"] = "Développeur full stack";

function init()
{
	document.getElementById("btnPrecedent").onclick = reculer;/*appel de la fonction reculer*/
	document.getElementById("btnSuivant").onclick = avancer; /*appel de la fonction avancer*/
	document.getElementById("btnDemarrer").onclick = demarrer;/*appel de la fonction demarrer*/
	document.getElementById("btnStop").onclick = arreter;/*appel de la fonction arreter*/

	for(i = 1; i <= 11; i++)
	{
		document.getElementById("image" + i).onclick = afficher;/*appel de la fonction afficher*/
	}
}

function demarrer()
{
	ilYADemarrage = true;
	tempsAttente = setInterval("avancer()", 2000);/*cette fonction sert à demarrer la visionneuse avec la boucle infinie*/
	
}


function avancer() /*cette fonction sert à avancer les images de la visionneuse manuellement*/
{
	noImage++;
	
	if (noImage > 11)
	{
		noImage = 1;
	}
	document.getElementById(id).style.border="none"; 		
	id = "image" + noImage;
    document.getElementById("persImg").src = "{{site.baseurl}}/assets/piv/" + imDescription[noImage-1]["image"];
	document.getElementById("nomTitre").innerHTML = imDescription[noImage-1]["titre"];
	document.getElementById("nouveauTitre").innerHTML = imDescription[noImage-1]["nouveauTitre"];
	document.getElementById(id).style.border="5px double #20107e";
}

function reculer()/*cette fonction sert à faire reculer les images la visionneuse manuellement*/
{
	noImage--;
		
	if (noImage == 0)
	{
		noImage = 11;
	}
	document.getElementById(id).style.border="none"; 	
	id = "image" + noImage;	
    document.getElementById("persImg").src = "{{site.baseurl}}/assets/piv/" + imDescription[noImage-1]["image"];
	document.getElementById("nomTitre").innerHTML = imDescription[noImage-1]["titre"];
	document.getElementById("nouveauTitre").innerHTML = imDescription[noImage-1]["nouveauTitre"];
	document.getElementById(id).style.border="5px double #20107e";
}

function afficher()/*cette fonction sert à afficher les images */
{
    document.getElementById(id).style.border="none"; 
    id = this.id;
    document.getElementById("persImg").src = "{{site.baseurl}}/assets/piv/" + imDescription[noImageCourant-1]["image"];
	document.getElementById("nomTitre").innerHTML = imDescription[noImageCourant-1]["titre"];
	document.getElementById("nouveauTitre").innerHTML = imDescription[noImageCourant-1]["nouveauTitre"];
    document.getElementById(id).style.border="5px double #20107e";
	
   for(i = 1; i <= 11; i++)/*pour aller d'une image à une autre*/
   {
		if (this.id == ("image" + i))
        {
            noImage = i;
            break;
        }
   }
}

function arreter()/*cette fonction sert à arreter la boucle infinie*/
{
	if(ilYADemarrage)
	{
		ilYADemarrage = false;
		clearInterval(tempsAttente);
	}
}
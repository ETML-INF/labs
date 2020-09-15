author: Jonathan Melly
summary: Animation
id: cosmos-base-02-animation
categories: dev
tags: msig
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Animation

## Bienvenue
Duration: 0:01:00

![02 Starwars](assets/cosmos-base/02-starwars.gif)

Une animation est une suite d'image qui défile à un certain rythme...
Il suffit donc de montrer une information à l'écran, puis de la changer et ainsi de suite pour créer
une animation...

### Objectifs

- Voir la console comme un écran à 2 dimensions (x=colonne, y=ligne)
- Créer une animation
- Créer l'illusion de contrôler un vaisseau avec le clavier

Survey
: Le cerveau humain croit à une animation à une fréquence de
<ul>
  <li>1 image par seconde</li>
  <li>2 images par seconde</li>
  <li>25 images par seconde</li>
  <li>Il sait toujours que ce n'est qu'une illusion</li>
</ul>

## Mouvements basiques
Duration: 0:15:00

### Horizontal

![02 Droite](assets/cosmos-base/02-droite.gif)

Pour réaliser cette animation, il faut imaginer que la console ressemble à un quadrillage avec des coordonnées:

![02 Quadrillage](assets/cosmos-base/02-quadrillage.png)

Ainsi, l'animation correspond à faire bouger le texte sur la grille:

![02 Quadrillage Anim1](assets/cosmos-base/02-quadrillage-anim1.png)

### Placer le curseur sur la grille
Pour placer le curseur à un endroit spécifique (avant d'écrire), on utilise les instructions suivantes:

``` cosmos
Placer le curseur à la colonne 5.
Placer le curseur à la ligne 1.
```

Si le numéro dépend d'une valeur stockée en mémoire, alors ça donne

``` cosmos
//Créer une zone mémoire nommée #colonne avec la valeur 1.
Placer le curseur à la colonne #colonne.
```

### Animation
À présent, nous sommes en mesure d'écrire une première version de l'animation horizontale qui est une répétition de l'élément suivant:

``` cosmos
Placer le curseur à la colonne 1.
Afficher "==>".
Attendre 200ms.
```

Et voici le code:

![02 Animation1 Diff](assets/cosmos-base/02-animation1-diff.png)

Negative
: Il manque encore un petit détail pour que l'animation ressemble à celle présentée au début... Ne penses-tu pas qu'il faudrait effacer le premier caractère de l'image précédente ?

Une fois la correction faite, voici le résultat:
![02 Animation 1b](assets/cosmos-base/02-animation-1b.gif)

### Simplification du code
Le code actuel ressemble un peu à du copier/coller et cela est très ennuyeux lorsqu'on doit faire des modifications (d'ailleurs c'est ce qui coûte cher en développement logiciel)...
Pour écrire du code **durable**, on a donc tout intérêt à opérer les modifications suivantes.

#### Stocker le symbole qui avance en mémoire
Comme pour le délai, on va utiliser une zone mémoire pour y enregistrer et référencer le symbole qui avance et on va même en profiter pour proposer à l'utilisateur de le choisir:

![02 Animation 1c](assets/cosmos-base/02-animation-1c.png)

#### Répéter des instructions
Peut-être as-tu remarqué que le code est très similaire et c'est un signe qu'on peut l'optimiser en utiliser une notion de **répétition**. D'ailleurs cette notion est la base de la force de l'informatique qui est capable de répéter des opérations de manière très rapide...

Pour cela on utilise le mot clé *Répéter* :

![02 Boucle1](assets/cosmos-base/02-boucle1.png)

Positive
: Étant donné que le numéro de colonne change à chaque *tour*, on doit le mettre dans une zone mémoire et l'incrémenter sinon l'animation ne fonctionnerait plus.

Désormais, en changeant juste le nombre de répétitions, on peut choisir la durée de l'animation !

#### Cacher les décors
Sur les vidéos présentées, le curseur (partie clignotante avant le texte à écrire) a été masqué.
Pour faire cela, il suffit d'ajouter la commande suivante:

``` cosmos
Masquer le curseur.
//Pour le réactiver: Afficher le curseur.
```

#### Dans la peau d'un réalisateur
Sauras-tu adapter le programme pour que l'utilisateur se prenne pour un réalisateur et puisse choisir le nombre de répétitions ?

### Défi vertical
En s'inspirant de ce qui a été fait précédemment, il est temps de réaliser le programme suivant:

![02 Vertical1](assets/cosmos-base/02-vertical1.gif)

Positive
: Pour réinitialiser la console (repartir du point d'origine 0:0), la commande suivante peut être utile:

``` bash
clear
```

## Synthèse
Duration: 0:03:00

Cet atelier était riche en découvertes, surtout quand on débute en programmation.
Voici donc un quizz récapitulatif:

![https://docs.google.com/forms/d/e/1FAIpQLSdS4Lba8WQbYRRttZOLCsR0tdGjQHRszhaiDvi9fp5LR4uq4g/viewform?embedded=true](codelabs/assets/linux.svg)
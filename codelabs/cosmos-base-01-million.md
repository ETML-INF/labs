author: Jonathan Melly
summary: Qui veut gagner des millions
id: cosmos-base-01-milion
categories: dev
tags: msig
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Qui veut gagner les millions ?

## Bienvenue
Duration: 0:01:00



Suite au [précédent épisode](https://labs.section-inf.ch/codelabs/cosmos-base-00-hello/index.html), il est temps d'en découvrir un peu plus sur la programmation en reprenant un jeu de questions / réponses à l'image de *Qui veut gagner des millions*.

### Objectifs

- Interagir avec l'utilisateur
- Écrire un programme s'adaptant au comportement de l'utilisateur


Survey
: Si tu gagnais un million, que ferais-tu ?
<ul>
  <li>Je les verserai intégralement à Greenpeace</li>
  <li>Je les flamberai en achats divers</li>
  <li>Ça demanderait réflexion...</li>
  <li>Autre</li>
</ul>

## Poser une question
Duration: 0:03:00



### Créer un nouveau programme

Pour rappel, on créée un nouveau programme avec la commande suivante:
``` bash
cosmos --nouveau Million
```

![Cosmos N Million](assets/cosmos-base/cosmos-n-million.png)

### Afficher la question

Pour afficher une question, il suffit d'éditer le fichier *Million.cosmos* et d'y ajouter:

``` cosmos
<TABULATION>Afficher "En quelle année est né le langage Cosmos ?" .
```

Une fois le fichier téléchargé, double-cliquez dessus.

Pour Windows, après avoir double-cliqué sur le fichier, cliquez sur *Extraire tout* et corrigez le chemin d'extraction en retirant la dernière partie après le dernier caractère \\ (antislash):

![Cosmos Extract Win2](assets/cosmos-base/cosmos-extract-win.gif)

## Première interaction
Duration: 0:15:00

### Console
Commençons par lancer une console :

- Windows : Clic dans le menu démarrer => Invite de commandes
- MacOS   : Clic sur spotlight => terminal
- Linux   : Si vous utilisez Linux, vous savez comment faire ;-)

### Avancer dans le cosmos
Une fois la console lancée, il faut aller à l'endroit où est le dossier décompressé et lancer le programme:

**Windows**
``` bash
cd Downloads\cosmos-win-x64
cosmos.exe
```
![Cosmos Run1win](assets/cosmos-base/cosmos-run1win.png)

**MacOS / Linux**
``` bash
cd Downloads/cosmos-osx-x64
./cosmos
```
![Cosmos Run1](assets/cosmos-base/cosmos-run1.png)

### Mode interactif
Par défaut, cosmos se lance en mode interactif, on peut donc éxécuter des commandes simples :

``` cosmos
Afficher "Bonjour Cosmos !".
```
![Cosmos Run2](assets/cosmos-base/cosmos-run2.png)

Positive
: Toute commande se valide avec la touche *ENTER*

Negative
: Pour quitter le mode interactif, écrivez *stop* et validez avec *ENTER*.

### Premier programme
Un programme cosmos complet est divisé en 2 parties:
1. Une entête
1. Le contenu du programme

L'entête est obligatoire. De la même manière qu'un TAG de fichier MP3, elle contient des informations sur le programme (auteur, date, ...) qu'on appelle *méta-données*.

#### Génération d'un squelette
Pour créer un squelette, on peut utiliser la commande suivante:
``` bash
cosmos -n <nomDuProgramme>
```

![Cosmos N](assets/cosmos-base/cosmos-n.png)

Positive
: Pour faciliter la mémorisation, il existe un alias (synonyme) plus parlant à cette commande:

``` bash
cosmos --nouveau <nomDuProgramme>
```

#### Ajout d'une instruction
En ouvrant le fichier avec un éditeur de texte (notepad sur windows et textedit sur MacOS par exemple), on peut y ajouter une instruction:
![Cosmos Textedit](assets/cosmos-base/cosmos-textedit.png)

Il ne reste plus qu'à lancer le programme:
``` bash
cosmos HelloCosmos
```

![Cosmos Hello1](assets/cosmos-base/cosmos-hello1.png)

Negative
: Pour arrêter un programme qui est bloqué, on utilise la combinaison des touches *ctrl-c*.

## Cheatsheet
Duration: 0:05:00

![Apprendre](assets/apprendre.png)

Pour parler couramment en langage Cosmos, un dictionnaire est disponible sous forme de *cheatsheet* (traduit littéralement par *feuille de triche*) en cliquant [ICI](https://github.com/jonathanMelly/cosmos/raw/master/doc/cheatsheet.pdf).

## Récapitulatif
Duration: 0:03:00

Pour terminer, un petit quizz facilitera la mémorisation à long terme des éléments pratiqués dans cet atelier.

![https://docs.google.com/forms/d/e/1FAIpQLSfsAHNKvVsGyf9ddx1_LPegiL5f4aEiTL8Z3H7bgbb1sjIDHg/viewform?embedded=true](codelabs/assets/linux.svg)
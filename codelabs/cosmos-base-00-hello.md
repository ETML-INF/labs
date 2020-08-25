author: Jonathan Melly
summary: Bonjour Cosmos
id: cosmos-base-00-hello
categories: cosmos,programmation
tags: cosmos
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Bonjour Cosmos

## Bienvenue
Duration: 0:01:00

![hello](assets/cosmos-base/hello.png)

Bienvenue dans le premier atelier autour du langage cosmos.

### Objectifs

- Installer Cosmos
- Tester le mode interactif
- Créer un premier programme qui dit 'Bonjour Cosmos'


Survey
: Quelle est votre conception de la programmation ?
<ul>
  <li>C'est un peu comme la lampe d'Aladdin, ça ouvre des portes infinies</li>
  <li>C'est un truc pour les autistes qui aiment les mathématiques</li>
  <li>J'attends la fin de cet atelier pour me faire une idée d'après une expérience réelle</li>
</ul>

## Installation
Duration: 0:02:00

![install-solar](assets/install-solar.jpg)

### Téléchargement

Cliquez sur le lien ci-dessous correspondant à votre plateforme pour télécharger cosmos.

#### [Windows](https://github.com/jonathanMelly/cosmos/releases/latest/download/cosmos-win-x64.zip) ![winlogo](assets/winlogo.png)

#### [MacOS](https://github.com/jonathanMelly/cosmos/releases/latest/download/cosmos-osx-x64.zip) ![Macos Logo](assets/macos-logo.png)

#### [Linux ](https://github.com/jonathanMelly/cosmos/releases/latest/download/cosmos-linux-x64.zip) ![Tux](assets/tux-mini.png)

### Décompression

Une fois le fichier téléchargé, on peut le décompresser en double-cliquant dessus.

## Premier programme

### Console
Il faut commencer par lancer une console :

- Windows : Clic dans le menu démarrer => commande
- MacOS   : Clic sur spotlight => terminal
- Linux   : Si vous utilisez Linux, vous savez comment faire ;-)

### Avancer dans le cosmos
Une fois la console lancée, il faut aller à l'endroit où est le dossier décompressé et lancer le programme:

Windows
``` bash
cd C:\Users\<VotreNomUtilisateur>\Downloads\cosmos<version>
cosmos.exe
```

MacOS / Linux
``` bash
cd ~\Downloads\cosmos<version>
./cosmos
```

## Mode interactif
Par défaut, cosmos se lance en mode interactif, on peut donc éxécuter des commandes simples :

``` cosmos
Afficher "Bonjour Cosmos !".
```

## Un premier programme
Un programme cosmos complet est divisé en 2 parties:
1. Un entête
1. Le contenu du programme

Pour créer un squelette, on peut utiliser la commande suivante:
``` bash
cosmos -n
```




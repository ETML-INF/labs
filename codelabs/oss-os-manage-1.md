author: Jonathan Melly
summary: Tuner un OS opensource - Partie 1
id: oss-os-manage-1
categories: system
tags: mem
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1


# Tuning d'un système d'exploitation open source #1

## Aperçu 
Duration: 1

![Tuxsw1](assets/oss-os-manage/tuxsw1.jpg)

### Compétences qui vont être acquises

- Visualiser la charge système
- Modifier la configuration du système
- Gérer les logiciels (Installation / Désinstallation)

Survey
: À ton avis, la commande 'TOP' sert à quoi ?
<ul>
  <li>Lister le top model du moment</li>
  <li>Trier Ou Partager (le noyau)</li>
  <li>Identifier les processus les plus gourmands</li>
</ul>

## Prérequis
Duration: 0:01:00

### Système d'exploitation
Toutes les activités sont basées sur les opérations décrites [ici](https://labs.section-inf.ch/codelabs/oss-os-install/index.html).


## Utilisation des ressources système
Duration: 0:15:00

Un système d'exploitation est un peu comme un chef d'orchestre ayant pour musiciens des composants électroniques.

![Orchestrate](assets/orchestrate.jpg)

### CPU et RAM
On peut observer le travail d'orchestration avec la commande *top* (écrire *top* puis valider avec la touche *enter*)
``` bash
top
```
![Top](assets/oss-os-manage/top.gif)

Negative
: Pour quitter la commande, il suffit d'appuyer sur la touche *q*

#### Décryptage du résultat
![TopDetail](assets/oss-os-manage/topDetail.png)

##### Partie 1 : Résumé
Cette partie comporte 3 points:

1. Le nombre de processus : 98 programmes chargés dont 1 en cours d'éxécution et 97 qui dorment.
1. L'utilisation du processeur: 0.3% utilisé et 99.7% en attente de travail.
1. L'utilisation de la RAM : 1987.8Mo disponible dont 148.3Mo utilisés et 1208.3Mo de libres.
1. L'utilisation du SWAP : 2Go au total dont 0 utilisé.

##### Partie 2 : Détail des processus
Le processus en haut de la liste est justement celui qui permet d'afficher les informations sur le processus.
Voici la traduction des colonnes:

1. PID: process id => Numéro d'identification du programme (géré par l'OS et permet de l'arrêter par exemple)
1. USER: utilisateur qui a lancé le processus
1. PR: priorité (-20 = priorité la plus importante)
1. NI: priorité demandée par le programme
1. VIRT: mémoire virtuelle utilisée par le programme
1. RES: mémoire RAM utilisée par le programme
1. SHR: partie de mémoire partagée dans RES
1. S: statut (R=running, s=sleeping, i=idle, etc...)
1. %CPU: pourcentage d'utilisation du processeur
1. %MEM: pourcentage d'utilisation de la mémoire
1. COMMAND: nom du programme

### Espace disque
Quand il n'y a plus d'espace pour stocker des nouvelles données, un ordinateur peut se bloquer. Il est donc utile de pouvoir contrôler l'espace sur les disques (SSD ou HDD) et aussi observer combien d'espace est pris par un dossier.

#### Lister les disques et leur partition
Une commande pratique est la suivante:

``` bash
sudo df -h
```

![Dfh](assets/oss-os-manage/dfh.png)

On voit que le disque de 20Go est rempli à 24%.

#### Calculer la taille d'un dossier
Pour savoir combien d'espace est utilisé par un utilisateur, il suffit de se loguer puis d'éxécuter la commande suivante:

``` bash
du -sh .
```

![Dush](assets/oss-os-manage/dush.png)

Ici, seulement 48Ko sont utilisés. Pour vérifier que c'est correct, on peut ajouter un fichier d'environ 150Mo et vérifier:

![Dush Grand](assets/oss-os-manage/dush-grand.png)

## Aide sur une commande
Duration: 0:10:00

![Helpsupport](assets/oss-os-manage/helpsupport.jpg)

Voulez-vous en savoir plus sur le résultat de la commande *top*, *du*, *df*, *dd* ou vous aimeriez savoir où on peut trouver les informations décrites précédemment sans l'utilisation d'Internet ?

Pour cela, il existe la commande *man* (manuel d'utilisation). Par exemple, pour *top*, on peut écrire:

``` bash
man top
```

Une fois la commande lancée, on peut:

1. Quitter en appuyant sur *q*
1. Tourner les pages (avancer la lecture) en appuyant sur *enter*
1. Chercher un terme en appuyant sur */* puis en saisissant un mot puis en appuyant sur *enter*. Ensuite, on appuie sur *n* (next=suivant) pour chercher le prochain terme

**En utilisant ce qui a été expliqué, que représentent les lettres *us* et *sy* à la deuxième ligne du résultat de la commande *top* ?**

Survey
: US et SY
<ul>
  <li>Pourcentage de métal provenant des US et de Syrie</li>
  <li>US=unité scientifique et SY=science yamakusa</li>
  <li>US=temps utilisateur et SY=temps noyau</li>
  <li>US=espace unique et SY=espace système</li>
</ul>

## Pimpage du login
Duration: 0:15:00

![Pimp](assets/oss-os-manage/pimp.jpg)

Un système Linux est basé sur des **fichiers de configuration**. Ces fichiers contiennent des indications que le système d'exploitation (au travers de ses programmes) interprète. C'est un peu  comme un automobiliste qui regarde les panneaux de signalisation pour savoir à quelle vitesse rouler à l'exception près qu'un programme, lui, ne fait jamais d'excès de vitesse ;-)

### Ajouter un message de bienvenue
Pour commencer, nous allons ajouter un message au login. Pour cela, nous avons donc besoin de 2 éléments:

1. Quel fichier de configuration ?
1. Comment éditer un fichier en ligne de commande ?

#### Bash
Pour la première question, un indice utile est que le programme lancé au login (interpréteur de commande) se nomme *bash*. Comme tout programme, on peut donc lire son manuel:
``` bash
man bash
```

Negative
: En cas de difficulté, un(e) camarade, votre professeur(e) ou Internet sauront vous aiguiller.

#### Nano
Il existe plusieurs éditeurs de fichier en ligne de commande et même si *vi* (visual editor) est le plus connu, *nano* a le mérite d'être plus facile à prendre en main et c'est donc celui qui va être utilisé.

En lien avec la partie précédente, pour éditer un fichier la commande est la suivante:
``` bash
nano unFichierAEditer
```

En remplaçant *unFichierAEditer* par le fichier de configuration de login, on peut alors ajouter une ligne tout en bas du fichier (descendre avec la flèche en bas) pour saluer l'utilisateur:

![NanoBashrc](assets/oss-os-manage/nanoBashrc.gif)

Résumé des commandes à effectuer:

1. Lancer l'éditeur (nano ...)
1. Se déplacer à la fin du fichier (flèche en bas)
1. Écrire la commande (echo "Bonjour Luke")
1. Sauvegarder (ctrl-o)
1. Quitter (ctrl-x)

Pour vérifier si cela fonctionne, il suffit de se déloguer :
``` bash
exit
```

Puis de se reloguer:

![LoginHello](assets/oss-os-manage/loginHello.png)


#### Défi
En s'inspirant de ce qui a été fait précédemment, votre mission est d'ajouter la date au moment du login:

![LoginDate](assets/oss-os-manage/loginDate.gif)

## Backup
Duration: 00:15:00

![Tuxbackup](assets/oss-os-manage/tuxbackup.png)

Il est souvent utile de sauvegarder certains fichiers ou dossiers pour les mettre en lieu sûr (clé USB ou cloud).
Avant de pouvoir faire un backup, il faut pouvoir se ballader dans le système de fichier sans l'aide d'un explorateur traditionnel qu'on contrôle avec une souris.

### Navigation dans le système de fichier

Quand on se logue, on arrive dans le répertoire de l'utilisateur qui est habituellement */home/nomUtilisateur*.
Pour savoir où on est dans la ligne de commande, on peut toujours utiliser *pwd* :

``` bash
pwd
```

![Pwd](assets/oss-os-manage/pwd.png)

À partir de là, on peut, par exemple, lister les éléments présents dans ce répertoire:

``` bash
ls -arth
```

![Ls1](assets/oss-os-manage/ls1.png)

#### Créer un répertoire
Pour ajouter un dossier (ou répertoire) la commande est *mkdir*:

``` bash
mkdir nouveauDossier
```

![Mkdir](assets/oss-os-manage/mkdir.png)

Pour 'ouvrir' le dossier, on utilise la commande *cd* et ensuite on peut vérifier que le dossier est bien vide avec la commande précédente de listing et aussi voir qu'on est dans un sous-dossier depuis la racine (/):

``` bash
cd nouveauDossier
```

![Cd1](assets/oss-os-manage/cd1.png)

Pour retourner dans le dossier parent, on utilise la même commande avec le paramètre '..':
``` bash
cd ..
```

### Zipper un répertoire
Un format traditionnel pour faire des backups de répertoires entiers est le *zip*.

Pour sauvegarder le répertoire qui a été créé précédemment, la commande est la suivante:

``` bash
tar czvf backup.zip nouveauDossier
```

![Tar1](assets/oss-os-manage/tar1.png)

Positive
: Il suffirait ensuite d'uploader ce fichier sur le cloud [exemple](https://stackoverflow.com/questions/27873017/example-of-dropbox-api-put-using-curl-and-oauth-2-to-upload-a-file-to-dropbox) ou le copier vers une clé USB.

Pour vérifier que cela fonctionne, supprimons le dossier et rechargeons-le depuis la sauvegarde:

``` bash
rm -rf nouveauDossier
```

![Rm1](assets/oss-os-manage/rm1.png)

``` bash
tar -xzvf backup.zip
```

![Restore1](assets/oss-os-manage/restore1.png)

## Synthèse récapitulative
Duration: 0:03:00

Sans être encore un hacker/une hackeuse chevronné(e), les activités réalisées t'ont montré quelques éléments des coulisses d'un système d'exploitation et il est temps de réviser ce que tu as découvert pour mieux t'en souvenir:

![https://docs.google.com/forms/d/e/1FAIpQLSdKPaqZDA0SJvYddbIxv1WZsTVa5lhfUZirwY-xdiDKLpuVew/viewform?embedded=true](codelabs/assets/linux.svg)


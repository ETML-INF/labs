author: Jonathan Melly
summary: Installer un OS opensource
id: oss-os-install
categories: system
tags: mem
environments: Web
status: Draft
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1


# Installation d'un système d'exploitation open source

## Aperçu 
Duration: 2

![Tux](assets/tux-petit-125.png)

### Compétences qui vont être acquises

- Créer une machine virtuelle
- Télécharger et installer un système d'exploitation
- Configurer le système en ligne de commande
- Installer une couche graphique et l'utiliser
- Obtenir des métriques système
- Installer les logiciels additionnels


Survey
: Sais-tu qui est tux ?
<ul>
  <li>Oui</li>
  <li>Non</li>
  <li>Peut-être</li>
</ul>

## Machine virtuelle
Duration: 0:05:00

### Installation
Au lieu de configurer un multiboot ou acheter un nouvel ordinateur, une **machine virtuelle** sera créee avec le logiciel VirtualBox disponible pour Windows, MacOS et Linux à l'adresse suivante : [Virtualbox](https://www.virtualbox.org/wiki/Downloads).

Positive
: Si ce logiciel est déjà installé sur l'ordinateur, on peut directement passer au point suivant.

#### Écran d'accueil de virtualbox
Voici à quoi devrait ressembler l'application une fois lancée :
![Accueil de Virtualbox](assets/oss-os-install/vbox-home.png)

### Démarrage et création
Pour commencer, une nouvelle machine virtuelle doit être créee:
![Vbox-new](assets/oss-os-install/vbox-new.png)

Ensuite, suivez les screenshots suivants pour la configuration:

1. Nom et système d'exploitation
![Vbox-os](assets/oss-os-install/vbox-os.png)

2. RAM (mémoire vive)
![Vbox-ram](assets/oss-os-install/vbox-ram.png)

3. Disque dur
![Vbox-hd1](assets/oss-os-install/vbox-hd1.png)
![Vbox-hd2](assets/oss-os-install/vbox-hd2.png)
![Vbox-hd3](assets/oss-os-install/vbox-hd3.png)
![Vbox-hd4](assets/oss-os-install/vbox-hd4.png)

4. Vérification
![Vbox-check](assets/oss-os-install/vbox-created.png)


## Distribution
Duration: 0:02:00

Il existe plusieurs systèmes d'exploitation opensource qu'on appelle communément *distribution*.
Ubuntu sera utilisé et il faut donc télécharger une image du système de base.

Negative
: Les systèmes open source sont des dérivés du système UNIX. Il y a deux branches principales que sont **BSD** et **Linux**.
Ce dernier est un noyau autour duquel gravite diverses distributions comme Ubuntu qui est lui-même dérivé de Debian...Vous trouverez plus d'informations [ici](https://fr.wikipedia.org/wiki/Liste_des_distributions_GNU/Linux).

### Téléchargement de l'image
L'adresse pour le téléchargement est la suivante : [https://ubuntu.com/download/server](https://ubuntu.com/download/server)

Positive
: Pour accélerer le téléchargement, une image a été placée sur le réseau à l'endroit habituel.

### Association du fichier image avec la machine virtuelle
Pour démarrer sur l'image récupérée, il faut configurer la machine virtuelle dans Virtualbox:

![Vbox-storage](assets/oss-os-install/vbox-storage.png)

![Vbox-iso](assets/oss-os-install/vbox-iso.png)

![Vbox-iso-inserted](assets/oss-os-install/vbox-iso-inserted.png)

### Démarrage
Ensuite la machine peut être démarrée :
![Vbox-start](assets/oss-os-install/vbox-start.png)

### Écran d'accueil
Si tout va bien, voici l'écran présenté:
![ubuntu-install-0](assets/oss-os-install/vbox-ui-0.png)

## Installation
Duration: 0:20:00

### Saisies en mode texte
L'installation se fait en mode *texte*, ainsi, les touches fléchées, ENTER, TAB et ESCAPE (retour en arrière) sont particulièrement utiles:

![Ui Usefull Inputs](assets/oss-os-install/ui-usefull-inputs.png)

### Langue
Pour faciliter la compréhension du système, celui-ci une fois installé, sélectionner la langue française:

![Ui 01 Lang](assets/oss-os-install/ui-01-lang.png)

### Mises à jour
Le programme d'installation peut inclure des mises à jour mais ceci sera fait après l'installation.
L'option par défaut est donc conservée:

![Ui 02 Noupdate](assets/oss-os-install/ui-02-noupdate.png)

### Clavier
Le clavier doit être configuré ainsi:

![Ui 03 Input1](assets/oss-os-install/ui-03-input1.png)

![Ui 04 Input2](assets/oss-os-install/ui-04-input2.png)

![Ui 05 Input Review](assets/oss-os-install/ui-05-input-review.png)


### Réseau
Sans entrer dans les détails, le choix par défaut est conservé :

![Ui 06 Net](assets/oss-os-install/ui-06-net.png)

#### Proxy
Il n'y a pas de proxy à configurer (utilisation de l'interfacée NAT de Virtualbox)
![Ui 07 Net Proxy](assets/oss-os-install/ui-07-net-proxy.png)

#### Miroir
Pour accélerer l'installation, un miroir proche doit être sélectionné.
Ce travail étant réalisé par le programme d'installation, l'option proposée est conservée:

![Ui 08 Mirror](assets/oss-os-install/ui-08-mirror.png)

### Disque
Lors de la création de la machine virtuelle, un seul disque virtuel avait été créé et c'est celui-ci qu'il faut choisir:

![Ui 09 Disk](assets/oss-os-install/ui-09-disk.png)

#### Partitions
Lors d'une installation professionnelle, un disque est compartimenté pour des raisons de **sécurité** et de **performance**.
Pour une utilisation amateur, l'option par défaut est adaptée:

![Ui 10 Disk Part](assets/oss-os-install/ui-10-disk-part.png)

#### Récapitulatif
Confirmer après la présentation du récapitulatif:

![Ui 11 Disk Confirm](assets/oss-os-install/ui-11-disk-confirm.png)

### Compte utilisateur
Un système d'exploitation est la plupart du temps *multi-utilisateur*, ce qui veut dire qu'on peut configurer plusieurs comptes.
Il s'agit maintenant de configurer le compte principal ainsi que le nom de la machine.
Voici l'exemple à suivre et adapter:

![Ui 12 User](assets/oss-os-install/ui-12-user.png)

### Logiciels additionnels
L'installateur propose d'ajouter automatiquement des élément additionnels communs.

#### SSH
Laisser l'option par défaut (NON installé) :

![Ui 13 Ssh](assets/oss-os-install/ui-13-ssh.png)

#### Autres
Aucun logiciel additionnel ajouté:

![Ui 14 Addons](assets/oss-os-install/ui-14-addons.png)

### Mises à jour
Le programme d'installation installe les mises à jour de sécurité critiques, il faut donc patienter.

![Ui 15 Updates](assets/oss-os-install/ui-15-updates.png)

Negative
: Si Internet ne fonctionne pas, on peut forcer la fin de l'installation en appuyant sur ENTER

### Redémarrage
L'installation est terminée, il est temps de redémarrer:

![Ui 16 Reboot](assets/oss-os-install/ui-16-reboot.png)


### Éjection du cdrom virtuel
Il se peut qu'une erreur se produise, dans ce cas, il faut juste appuyer sur ENTER:

![Ui 17 Eject](assets/oss-os-install/ui-17-eject.png)

### Premier login
À la fin du démarrage, on devrait voir apparaître une invite de login:

![Ui 18 Login](assets/oss-os-install/ui-18-login.png)

Il se peut toutefois que celle-ci soit masquée au premier démarrage :

![Ui 19 Login2](assets/oss-os-install/ui-19-login2.png)

Indépendemment de ce qui est affiché, on peut entrer dans le système en introduisant le nom d'utilisateur suivi de ENTER suivi du mot de passe et à nouveau ENTER:

![Ui 20 Login Success](assets/oss-os-install/ui-20-login-success.png)

Negative
: Il est tout à fait normal que les caractères du mot de passe ne soient pas affichés, c'est une manière d'augmenter la sécurité des mot de passe (au cas où quelqu'un serait en train d'espionner...)

## Récapitulatif
Duration: 0:05:00

Félicitations, l'installation d'Ubuntu est terminée est réussie.
Voici un questionnaire pour faciliter la mémorisation des éléments importants:

![https://docs.google.com/forms/d/e/1FAIpQLSc5RiVJBGGowXr66xmR056zLOBwVd9H5NGyd--eLEWHyLn45g/viewform?embedded=true](codelabs/assets/linux.svg)


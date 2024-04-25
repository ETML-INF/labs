author: Jonathan Melly
summary: mobile test
id: mobile-08-test
categories: android,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Qualité

## Introduction
Duration: 0:1:0

![Alt text](assets/mobile/test/test-intro-image.png)

La qualité d’un logiciel passe par les tests et idéalement ceux-ci sont automatisés car réaliser les tests à la main est fastidieux et **coûteux**.

Negative
: Il ne faut toutefois pas négliger les tests manuels dans un environnement mobile où même les émulateurs (que l’ont peut piloter par le code) pourraient montrer des disparités avec les vrais appareils.

La portée de ce tutorial se concentre sur la mise en place de *tests unitaires* et les tests d’intégration ne seront donc pas abordé ici.

## Structure du projet MAUI
Duration: 0:15:00

Pour pouvoir facilement tester un projet MAUI, il faut commencer par le *découper* en 2 parties sinon lorsqu’on veut tester du code, il y aura des problèmes d’initialisation... 

On aura donc les 2 projets suivants:

1. L’application en tant que telle (MauiAPP)
2. Le reste

Positive
: À ceux deux projets sera ajouté un 3ème, le projet de test !

### Ajout d’un projet de type "librairie"

**Ajouter un projet**

![Alt text](assets/mobile/test/add-project.png)


**Choisir le bon type**

![Alt text](assets/mobile/test/test-select-project-type-lib.png)

**À la fin, un nouveau projet fait partie de la solution:**

![Alt text](assets/mobile/test/test-lib-created.png)

### Ajout de la référence à partir du projet principal

Maintenant que la solution comporte 2 projets, il faut référencer la librairie à partir du projet principal:

**Attention: modifier le PROJET PRINCIPAL (pas la lib)**

![Alt text](assets/mobile/test/test-lib-ref1.png)


**Ajouter la lib comme référence**

![Alt text](assets/mobile/test/test-lib-ref2.png)

**Optionnellement, optimiser la compilation de la lib**

![Alt text](test-optim-lib.gif)

### Déplacement des classes

À partir de là, les éléments peuvent être migrés:


**Ajouter le dossier ViewModels**

![Alt text](assets/mobile/test/lib-add-folder.png)

![Alt text](assets/mobile/test/test-lib-add-folder2.png)

**Déplacer une classe VM**

![Alt text](assets/mobile/test/test-lib-move-from-app1.gif)

Negative
: Attention, VisualStudio fait une copie du fichier

**OOps, petit problème**

![Alt text](assets/mobile/test/test-lib-move-mvvm1-error-toolkit.png)

**Ajout du toolkit pour le projet lib**

![Alt text](assets/mobile/test/test-lib-move-mvvm1-fix-toolkit.png)

**Suppression de l’original**

![Alt text](assets/mobile/test/test-lib-del-mvvm1.gif)

**Déplacement d’un XAML**

![Alt text](assets/mobile/test/test-lib-move-xaml-from-app.gif)

**Suppresion du XAML original**

À toi de jouer ;-)

### Mise à jour du XMLNS
Il reste une petite adaptation à faire car actuellement le **shell** est défini dans le projet principal alors que la page *MVVM1* a été déplacée dans le projet de librairie.

Il faut donc ajuster cela:

**Ajouter un namespace pour la lib**
![Alt text](assets/mobile/test/test-lib-update-xmlns1.png)

**L’utiliser**
![Alt text](assets/mobile/test/test-lib-update-xmlns2.png)

Positive
: Idéalement, on changera aussi les namespaces du projet librairie, par exemple *HelloMauiLib* au lieu de celui récupéré du projet initial, soit *HelloMaui1*...

## Mise en place du projet de test
Duration: 0:5:00

Tout est désormais prêt pour tester le ViewModel déplacé dans le projet de librairie.

### Génération automatique
VisualStudio propose un assistant pour créer un test unitaire, voici donc comment l’utiliser:

**Identifier la méthode à tester**

Faire un clic droit sur la méthode
![Alt text](assets/mobile/test/test-create-ut.png)

**Oops**

![Alt text](assets/mobile/test/test-create-ut2-error.png)

**Correction et deuxième essai**

![Alt text](assets/mobile/test/test-create-ut3-fix.png)

**Paramètres**

Les paramètres proposés peuvent être laissés tels quels
![Alt text](assets/mobile/test/test-create-ut4-params.png)

**Vérification du projet généré**

![Alt text](assets/mobile/test/test-create-ut5-generated.png)

### Correction du projet auto-généré
Une erreur s’est glissée lors de la création automatique du projet, en effet, le premier build de l’application est pour Android et cela ne fonctionne pas pour tester le code C# pur.

Il faut donc corriger le *TargetFramework* du fichier *.csproject* du projet de test, par exemple en faisant un double-clic sur le projet :

![Alt text](assets/mobile/test/test-update-csproj-dblclick.png)

**Et en corrigeant ainsi**

![Alt text](assets/mobile/test/test-update-targetframework.gif)

Negative
: Attention, l’important est que la version corresponde avec celle du projet *librairie* pour la partie windows...


## Mon premier test unitaire
Duration: 0:5:00

On peut maintenant enfin coder la validation de la méthode

### **A**rrange **A**ct **A**ssert
Pour rappel, un test suit une structure AAA, voici donc comment cela se reflète dans le code:

![Alt text](assets/mobile/test/test-ut-example1.png)

### Lancer le test

Il y a plusieurs manières:

**Clic droit sur la méthode de test**

![Alt text](assets/mobile/test/test-run1.png)

**Menu Test**

![Alt text](assets/mobile/test/test-run2.png)

**Ligne de commande**

```shell
dotnet test
```
![Alt text](assets/mobile/test/test-run3.png)

### Résultat

![Alt text](assets/mobile/test/test-run-result.png)


## Synthèse
Duration: 0:1:00

Suite à cet exercice, les compétences suivantes ont été travaillées:

- Split d’un projet MAUI en un projet principal et une librairie
- Déplacer des éléments d’un projet à l’autre
- Créer un test pour une méthode d’un ViewModel
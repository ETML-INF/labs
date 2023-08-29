author: Jonathan Melly
summary: ant simulator setup
id: ant-simu-01
categories: dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Mise en place du simulateur de fourmi

## Vue d’ensemble
Duration: 0:01:00

![ant](assets/ant-simu-01/ant-01.png)

Survey
: Quelle est votre conception de la programmation orientée objet ?
<ul>
<li>C'est un peu comme la lampe d'Aladdin, ça ouvre des portes infinies</li>
<li>C'est un truc pour les autistes qui aiment les mathématiques</li>
<li>J'attends la fin de cet atelier pour me faire une idée d'après une expérience réelle</li>
</ul>

### Environnement fourmilier simplifié
Le simulateur offre un environnement dans lequel 3 fourmilières évoluent dans des conditions naturelles simplifiées elles aussi.

## Mise en place
Duration: 0:03:00

### Télécharger l’archive

Le programme est disponible [à cette adresse](https://github.com/ETML-INF/320-POO_2023/blob/main/assets/simulator.zip)

![bouton pour télécharger](assets/ant-simu-01/ant-simu-02-download.png)


### Installation

Dézipper l’archive

![unzip](assets/ant-simu-01/ant-03-extract.png)

### Lancer le simulateur

Double-clic sur *krohondesimulator.exe*

![](assets/ant-simu-01/04-exe.png)

Et l’écran suivant devrait apparaître:

![](assets/ant-simu-01/05-simu.png)


## Modifier le comportement des fourmis
Duration: 0:08:00

### Créer un projet CSharp
Créer un projet .NET 4.7 de type *bibliothèque*

![06-project.png](assets/ant-simu-01/06-project.png)
![07-fversion.png](assets/ant-simu-01/07-fversion.png)

### Ajouter une référence vers un DLL
![08-dll1.png](assets/ant-simu-01/08-dll1.png)

#### Sélectionner le DLL de l’archive *simulator*
```text
CustomStrategy.dll
```
![09-dll2.png](assets/ant-simu-01/09-dll2.png)

![10-dll3.png](assets/ant-simu-01/10-dll3.png)

### Ajouter une implémentation
 1. Créer une classe nommée XXXBlueQueen
 1. Ajouter un import : "using CustomStrategy"
 1. Faire hériter la nouvelle classe de QueenStrategy : "... : QueenStrategy" 
 1. Utiliser l’aide de l’IDE pour compléter la classe
![11-implem1.png](assets/ant-simu-01/11-implem1.png)

### Remplacer le code auto-généré (à adapter selon votre cas)
![19-code.png](assets/ant-simu-01/19-code.png)

#### Ajouter un override pour la méthode *GetMessage*
Choisir le texte à afficher, par exemple "Hello Demo" :
![12-getmessage.png](assets/ant-simu-01/12-getmessage.png)

### Générer le DLL
![13-gendll.png](assets/ant-simu-01/13-gendll.png)

### Copier le DLL vers le simulateur
![14-open.png](assets/ant-simu-01/14-open.png)
![15+select.png](assets/ant-simu-01/15-select.png)
![16-copy.png](assets/ant-simu-01/16-copy.png)

### Retirer le dll example
Ou le renommer pour qu’il soit ordré alphabétiquement après le nouveau plugin 
(premier arrivé, premier servi...)

### Tester

#### Activer le log
![17-log1.png](assets/ant-simu-01/17-log1.png)

#### Vérifier l’affichage du message
Le log devrait se trouver dans le répertoire *c:\temp*

**Défilement automatique**
Pour voir le log défiler, on peut faire un clic droit dans le répertoire
où est le log (via l’explorateur de fichier) et sélectionner *git bash here*.

Ensuite entrer la commande suivante dans la console qui est apparu:
```shell
tail -100f Krohonde.log
```
![18-message.png](assets/ant-simu-01/18-message.png)

Positive
: les options "-100f" impliquent qu’on affiche les 100 dernières lignes du fichier (100) et qu’on défile automatiquement (f)

## Améliorations
Duration: 0:03:00

### Automatiser la copie après le build
Pour copier directement une nouvelle version, on peut, par exemple ajouter une option de build dans le fichier *.csproject*

#### Exemple à adapter
```xml
<Target Name="copy strategy" AfterTargets="build">
        <Message Text="Copy example to krohonde" Importance="high" />
        <Copy 
		SourceFiles="$(OutputPath)\CustomStrategyZZZ.dll" 
		DestinationFolder="c:\temp\simulator\strategyZZZ" 
		SkipUnchangedFiles="true" />
    </Target>
```

## Synthèse
Duration: 0:02:00

Bravo, il est temps de faire le point sur les éléments travaillés

![https://docs.google.com/forms/d/e/1FAIpQLSfDlmUVAjTePaSqEOs0rAOJsxuExB-Ou_6OtvIZUKQuiTwPRA/viewform?embedded=true](codelabs/assets/linux.svg)

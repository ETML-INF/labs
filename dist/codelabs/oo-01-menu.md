author: Jonathan Melly
summary: menu console orienté objet avec instances
id: oo-01-menu
categories: csharp,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Menu Console OO : des fonctions aux instances

## Vue d'ensemble
Duration: 0:02:00

Ce tutorial reprend le menu console créé dans le codelab **preoo-01-menu** (étape 4 avec navigation au clavier) et le transforme en une **classe instanciable**.

### Contexte

Dans le codelab précédent, nous avions structuré le code avec des fonctions préfixées `Menu_` et des variables globales. Ce code fonctionne, mais il a une limitation : on ne peut avoir qu'**un seul menu** à la fois.

### Objectifs

À travers 4 étapes progressives, vous apprendrez à :
1. Identifier les champs et méthodes dans le code existant
2. Créer une classe `Menu` avec un constructeur
3. Utiliser la classe dans `Program.cs`
4. Créer **plusieurs menus** indépendants

Positive
: Ce codelab illustre le moment "aha" de la POO : quand on réalise que les instances permettent de réutiliser une classe pour créer plusieurs objets indépendants.

Survey
: Quel est votre niveau avec les classes ?
<ul>
<li>Je connais les classes statiques</li>
<li>J'ai déjà utilisé des instances</li>
<li>Je découvre les instances</li>
</ul>

## Étape 1 : Rappel du code actuel
Duration: 0:05:00

### Le code final de preoo-01-menu

Voici le code que nous avions à la fin du codelab précédent (étape 4 — navigation au clavier) :

```csharp
// Variables globales
string[] options = Array.Empty<string>();
int selectedIndex = 0;

// Programme principal
Menu_Init();
int choice = Menu_RunInteractive();
Menu_HandleChoice(choice);
Console.ReadKey();

// ============ FONCTIONS MENU ============

void Menu_Init()
{
    options = new string[] { "Play", "Options", "Highscores", "Quit" };
    selectedIndex = 0;
}

void Menu_ShowInteractive()
{
    Console.Clear();
    Console.WriteLine("=== SUPER GAME ===");
    Console.WriteLine("");
    Console.WriteLine("Use arrows to navigate, Enter to select");
    Console.WriteLine("");

    for (int i = 0; i < options.Length; i++)
    {
        if (i == selectedIndex)
        {
            Console.BackgroundColor = ConsoleColor.White;
            Console.ForegroundColor = ConsoleColor.Black;
            Console.WriteLine($"  > {options[i]} <  ");
            Console.ResetColor();
        }
        else
        {
            Console.WriteLine($"    {options[i]}    ");
        }
    }

    Console.WriteLine("");
}

int Menu_RunInteractive()
{
    ConsoleKey key;

    do
    {
        Menu_ShowInteractive();

        ConsoleKeyInfo keyInfo = Console.ReadKey(true);
        key = keyInfo.Key;

        if (key == ConsoleKey.UpArrow)
        {
            selectedIndex--;
            if (selectedIndex < 0)
            {
                selectedIndex = options.Length - 1;
            }
        }
        else if (key == ConsoleKey.DownArrow)
        {
            selectedIndex++;
            if (selectedIndex >= options.Length)
            {
                selectedIndex = 0;
            }
        }

    } while (key != ConsoleKey.Enter);

    return selectedIndex;
}

void Menu_HandleChoice(int choice)
{
    Console.Clear();
    Console.WriteLine($">>> {options[choice].ToUpper()} <<<");
}
```

### Identifier ce qui deviendra quoi

| Code actuel | Deviendra | Type |
| :--- | :--- | :--- |
| `string[] options` | Champ de la classe | **Champ** |
| `int selectedIndex` | Champ de la classe | **Champ** |
| `Menu_Init()` | Constructeur `Menu(...)` | **Constructeur** |
| `Menu_ShowInteractive()` | `ShowInteractive()` | **Méthode** |
| `Menu_RunInteractive()` | `RunInteractive()` | **Méthode** |
| `Menu_HandleChoice(int)` | reste dans `Program.cs` | (logique du jeu) |

Positive
: Le préfixe `Menu_` disparaît naturellement : quand la fonction est dans la classe `Menu`, écrire `Menu.Show()` suffit.

## Étape 2 : Créer la classe Menu
Duration: 0:15:00

### Objectif

Créer un fichier `Menu.cs` contenant la classe `Menu` instanciable.

### Créer le fichier Menu.cs

Ajouter un nouveau fichier `Menu.cs` au projet avec le contenu suivant :

```csharp
class Menu
{
    // Champs (ex-variables globales)
    string[] options;
    int selectedIndex;

    // Constructeur (ex-Menu_Init)
    public Menu(string[] options)
    {
        this.options = options;
        this.selectedIndex = 0;
    }

    // Méthode : afficher le menu (ex-Menu_ShowInteractive)
    void ShowInteractive()
    {
        Console.Clear();
        Console.WriteLine("Use arrows to navigate, Enter to select");
        Console.WriteLine("");

        for (int i = 0; i < this.options.Length; i++)
        {
            if (i == this.selectedIndex)
            {
                Console.BackgroundColor = ConsoleColor.White;
                Console.ForegroundColor = ConsoleColor.Black;
                Console.WriteLine($"  > {this.options[i]} <  ");
                Console.ResetColor();
            }
            else
            {
                Console.WriteLine($"    {this.options[i]}    ");
            }
        }

        Console.WriteLine("");
    }

    // Méthode : boucle interactive (ex-Menu_RunInteractive)
    public int RunInteractive()
    {
        ConsoleKey key;

        do
        {
            ShowInteractive();

            ConsoleKeyInfo keyInfo = Console.ReadKey(true);
            key = keyInfo.Key;

            if (key == ConsoleKey.UpArrow)
            {
                this.selectedIndex--;
                if (this.selectedIndex < 0)
                {
                    this.selectedIndex = this.options.Length - 1;
                }
            }
            else if (key == ConsoleKey.DownArrow)
            {
                this.selectedIndex++;
                if (this.selectedIndex >= this.options.Length)
                {
                    this.selectedIndex = 0;
                }
            }

        } while (key != ConsoleKey.Enter);

        return this.selectedIndex;
    }
}
```

### Ce qui a changé

| Avant (fonctions) | Après (classe) |
| :--- | :--- |
| `string[] options` (variable globale) | `string[] options` (champ de la classe) |
| `int selectedIndex` (variable globale) | `int selectedIndex` (champ de la classe) |
| `void Menu_Init()` | `public Menu(string[] options)` (constructeur) |
| `void Menu_ShowInteractive()` | `void ShowInteractive()` (méthode privée) |
| `int Menu_RunInteractive()` | `public int RunInteractive()` (méthode publique) |

Negative
: `ShowInteractive` n'a pas le mot-clé `public` car elle n'est appelée que depuis `RunInteractive`, à l'intérieur de la classe. C'est un premier aperçu de l'**encapsulation** (on cache les détails internes).

## Étape 3 : Utiliser la classe dans Program.cs
Duration: 0:10:00

### Objectif

Modifier `Program.cs` pour utiliser la classe `Menu` au lieu des fonctions.

### Nouveau Program.cs

Remplacer le contenu de `Program.cs` par :

```csharp
// Créer une instance de Menu
Menu mainMenu = new Menu(new string[] { "Play", "Options", "Highscores", "Quit" });

// Lancer le menu interactif
int choice = mainMenu.RunInteractive();

// Gérer le choix
Console.Clear();
switch (choice)
{
    case 0:
        Console.WriteLine("Starting game...");
        break;
    case 1:
        Console.WriteLine("Opening options...");
        break;
    case 2:
        Console.WriteLine("Showing highscores...");
        break;
    case 3:
        Console.WriteLine("Goodbye!");
        break;
}

Console.ReadKey();
```

### Test

Lancer l'application. Le comportement est identique à avant : navigation avec les flèches, sélection avec Enter.

### Comparaison

| Avant | Après |
| :--- | :--- |
| `Menu_Init();` | `new Menu(new string[] { ... });` |
| `Menu_RunInteractive();` | `mainMenu.RunInteractive();` |
| Variables globales (`options`, `selectedIndex`) | Encapsulées dans l'objet `mainMenu` |
| Fonctions "en vrac" dans Program.cs | Méthodes dans `Menu.cs` |

Positive
: Le code de `Program.cs` est beaucoup plus court et lisible. Toute la logique du menu est dans la classe `Menu`.

## Étape 4 : Plusieurs menus
Duration: 0:15:00

### Le moment "aha"

Voici l'avantage décisif des instances. Créons un **deuxième menu** pour les options du jeu :

```csharp
// Menu principal
Menu mainMenu = new Menu(new string[] { "Play", "Options", "Highscores", "Quit" });

int choice = mainMenu.RunInteractive();

if (choice == 1) // Options sélectionné
{
    // Menu des options — un DEUXIÈME menu, indépendant !
    Menu optionsMenu = new Menu(new string[] { "Sound", "Music", "Difficulty", "Back" });

    int optionChoice = optionsMenu.RunInteractive();

    Console.Clear();
    switch (optionChoice)
    {
        case 0:
            Console.WriteLine("Sound settings...");
            break;
        case 1:
            Console.WriteLine("Music settings...");
            break;
        case 2:
            Console.WriteLine("Difficulty settings...");
            break;
        case 3:
            Console.WriteLine("Back to main menu...");
            break;
    }
}
else if (choice == 3) // Quit
{
    Console.Clear();
    Console.WriteLine("Goodbye!");
}

Console.ReadKey();
```

### Pourquoi c'est impossible avec des fonctions `Menu_*` ?

Avec l'ancien code, `options` et `selectedIndex` étaient des **variables globales**. Lancer un deuxième menu aurait **écrasé** les données du premier.

Avec les instances :
- `mainMenu` a ses propres `options` et `selectedIndex`
- `optionsMenu` a ses propres `options` et `selectedIndex`
- Les deux sont **complètement indépendants**

Positive
: C'est la puissance des instances : une seule classe `Menu`, mais autant de menus différents que nécessaire !

## Bonus
Duration: 0:10:00

### 1. Ajouter un titre personnalisé par menu

Ajoutez un champ `title` à la classe `Menu` et adaptez le constructeur :

```csharp
class Menu
{
    string[] options;
    int selectedIndex;
    string title;

    public Menu(string title, string[] options)
    {
        this.title = title;
        this.options = options;
        this.selectedIndex = 0;
    }

    void ShowInteractive()
    {
        Console.Clear();
        Console.WriteLine($"=== {this.title} ===");
        Console.WriteLine("");
        // ... reste du code
    }

    // ...
}
```

Utilisation :

```csharp
Menu mainMenu = new Menu("SUPER GAME", new string[] { "Play", "Options", "Quit" });
Menu optionsMenu = new Menu("OPTIONS", new string[] { "Sound", "Music", "Back" });
```

### 2. Couleurs personnalisables par instance

Ajoutez des champs pour les couleurs de surbrillance :

```csharp
class Menu
{
    // ... champs existants ...
    ConsoleColor highlightBg;
    ConsoleColor highlightFg;

    public Menu(string title, string[] options,
                ConsoleColor highlightBg = ConsoleColor.White,
                ConsoleColor highlightFg = ConsoleColor.Black)
    {
        this.title = title;
        this.options = options;
        this.selectedIndex = 0;
        this.highlightBg = highlightBg;
        this.highlightFg = highlightFg;
    }

    // Utiliser this.highlightBg et this.highlightFg dans ShowInteractive
}
```

Utilisation :

```csharp
Menu mainMenu = new Menu("SUPER GAME", options, ConsoleColor.Cyan, ConsoleColor.Black);
Menu optionsMenu = new Menu("OPTIONS", optOptions, ConsoleColor.Yellow, ConsoleColor.Black);
```

Chaque menu a ses propres couleurs !

## Synthèse
Duration: 0:02:00

### Récapitulatif : fonctions → classe

| Avant (fonctions) | Après (classe) |
| :--- | :--- |
| Variables globales `options`, `selectedIndex` | Champs de la classe `Menu` |
| Fonctions `Menu_Init()`, `Menu_Show()` | Constructeur + méthodes |
| Préfixe `Menu_` pour regrouper | Classe `Menu` pour regrouper |
| Un seul menu possible | Autant de menus que voulu |
| Données accessibles partout | Données encapsulées dans l'objet |

### Ce qu'on a appris

1. **`class`** (sans `static`) = modèle pour créer des objets
2. **`new`** = créer une instance avec ses propres données
3. **Constructeur** = initialiser l'objet à la création
4. **`this`** = désigne l'instance courante
5. **Méthodes d'instance** = agissent sur les données de leur objet

### Spoiler : encapsulation

Pour l'instant, les champs de `Menu` sont accessibles depuis l'extérieur. La prochaine étape introduira les mots-clés `private` et `public` pour **protéger** les données de la classe.

Positive
: Félicitations ! Vous avez transformé du code procédural en code orienté objet. La classe `Menu` est désormais réutilisable dans n'importe quel projet.

Survey
: Quel aspect des instances trouvez-vous le plus utile ?
<ul>
<li>Pouvoir créer plusieurs objets indépendants</li>
<li>Le constructeur pour initialiser proprement</li>
<li>Les méthodes qui agissent sur leur propre objet</li>
<li>La séparation en fichiers (Menu.cs / Program.cs)</li>
</ul>

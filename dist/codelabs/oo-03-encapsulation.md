author: Jonathan Melly
summary: Protéger les données avec private et les propriétés
id: oo-03-encapsulation
categories: csharp,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Encapsulation OO : protéger les données de Snail et Menu

## Vue d'ensemble
Duration: 0:03:00

Ce tutorial reprend le code des codelabs **oo-02-snail** (escargot instanciable) et **oo-01-menu** (menu instanciable) et introduit l'**encapsulation** : protéger les données internes avec `private` et contrôler l'accès avec des **propriétés** C#.

### Contexte

À la fin du codelab précédent, la classe `Snail` a des champs `public` :

```csharp
class Snail
{
    public int X;
    public int Y;
    public int Energy;
    public string Name;
    public ConsoleColor Color;
    // ...
}
```

Le problème : **n'importe quel code peut modifier ces champs** avec des valeurs absurdes.

### Objectifs

À travers 5 étapes progressives, vous apprendrez à :
1. Démontrer le problème des champs publics
2. Utiliser `private` pour cacher les champs
3. Ajouter des propriétés C# pour un accès contrôlé
4. Écrire une propriété avec validation (full property)
5. Encapsuler la classe `Menu` de la même manière

Positive
: Ce codelab vous apprend à **protéger vos données**. Après cette étape, la triche sera impossible : `snail.Energy = 9999` ne compilera plus.

Survey
: Que pensez-vous des champs publics ?
<ul>
<li>Pratiques, je ne vois pas le problème</li>
<li>C'est risqué, on devrait contrôler l'accès</li>
<li>Je ne sais pas ce que ça change</li>
<li>J'ai déjà eu des bugs à cause de ça</li>
</ul>

## Étape 1 : Démontrer le problème
Duration: 0:05:00

### Objectif

Montrer concrètement que les champs `public` permettent la triche.

### Code tricheur

Dans `Program.cs`, **après** `Race.Init()` et **avant** la boucle de course, ajoutez ce code temporaire :

```csharp
// === CODE TRICHEUR (temporaire) ===
Snail tricheur = Race.Snails[0];

// Triche 1 : énergie infinie
tricheur.Energy = 9999;
Console.WriteLine($"{tricheur.Name} a {tricheur.Energy} d'énergie !");

// Triche 2 : victoire instantanée
tricheur.X = Race.FinishX;
Console.WriteLine($"{tricheur.Name} est déjà à la ligne d'arrivée !");
// === FIN DU CODE TRICHEUR ===
```

### Observer

Compilez et exécutez. Le premier escargot a 9999 d'énergie et gagne instantanément.

Negative
: Ce code **compile sans erreur**. La méthode `ReduceEnergy()` limite l'énergie à minimum 10, mais en écrivant directement `snail.Energy = 9999`, on **contourne** cette validation. C'est le problème fondamental des champs `public`.

### Supprimer le code tricheur

Supprimez le code tricheur avant de continuer. Il a servi à démontrer le problème.

## Étape 2 : Passer les champs en `private`
Duration: 0:10:00

### Objectif

Rendre les champs de `Snail` inaccessibles depuis l'extérieur.

### Modifier Snail.cs

Remplacez `public` par `private` pour **tous les champs** :

```csharp
class Snail
{
    // Tous les champs deviennent private
    private int x;
    private int y;
    private int energy;
    private string name;
    private ConsoleColor color;

    public Snail(string name, ConsoleColor color)
    {
        this.name = name;
        this.color = color;
        this.x = 0;
        this.y = 0;
        this.energy = 100;
    }

    // Les méthodes de la classe peuvent toujours accéder aux champs private
    public void Draw()
    {
        SuperConsole.WriteAtColor(this.x, this.y, "@", this.color);
    }

    public void Erase()
    {
        SuperConsole.WriteAtColor(this.x, this.y, ".", ConsoleColor.DarkGray);
    }

    public void Move(int dx, int dy)
    {
        this.x = this.x + dx;
        this.y = this.y + dy;
    }

    public void ReduceEnergy(int amount)
    {
        this.energy = this.energy - amount;
        if (this.energy < 10)
        {
            this.energy = 10;
        }
    }

    public void DrawEnergy(int displayX, int displayY)
    {
        Console.SetCursorPosition(displayX, displayY);
        Console.ForegroundColor = this.color;
        string bar = new string('#', this.energy / 10);
        string empty = new string('-', 10 - this.energy / 10);
        Console.Write($"{this.name,6}[{bar}{empty}] ");
        Console.ResetColor();
    }
}
```

### Observer les erreurs

Essayez de compiler. Vous obtenez de **nombreuses erreurs** dans `Program.cs` et `Race.cs` :

```
CS0122: 'Snail.energy' is inaccessible due to its protection level
CS0122: 'Snail.x' is inaccessible due to its protection level
CS0122: 'Snail.name' is inaccessible due to its protection level
```

Partout où le code extérieur accède aux champs de `Snail`, le compilateur refuse.

### Les erreurs typiques

| Code qui ne compile plus | Où ? | Pourquoi |
| :--- | :--- | :--- |
| `snail.Energy` | Program.cs (boucle de course) | Lecture du champ privé |
| `snail.X >= Race.FinishX` | Program.cs (test victoire) | Lecture du champ privé |
| `Snails[i].X = StartX` | Race.cs (`Init()`) | Écriture du champ privé |
| `Snails[i].Y = 2 + i * 2` | Race.cs (`Init()`) | Écriture du champ privé |
| `winner.Name` | Program.cs (affichage gagnant) | Lecture du champ privé |

Positive
: C'est **normal** que ça ne compile plus ! On a protégé les données. L'étape suivante va rétablir l'accès de manière **contrôlée** avec des propriétés.

## Étape 3 : Ajouter des propriétés
Duration: 0:15:00

### Objectif

Rétablir l'accès aux données via des **propriétés C#** avec le bon niveau de protection.

### Choix du niveau d'accès pour chaque donnée

Avant de coder, réfléchissons à ce dont on a besoin :

| Donnée | Lecture extérieure ? | Écriture extérieure ? | Choix |
| :--- | :--- | :--- | :--- |
| `Name` | Oui (affichage) | Non (ne change jamais) | `{ get; }` |
| `Color` | Oui (affichage) | Non (ne change jamais) | `{ get; }` |
| `X` | Oui (test victoire) | Non (via `Move()`) | `{ get; private set; }` |
| `Y` | Oui (possible) | Non (via `Move()`) | `{ get; private set; }` |
| `Energy` | Oui (boucle course) | Non (via `ReduceEnergy()`) | `{ get; private set; }` |

### Modifier Snail.cs

Ajoutez les propriétés au début de la classe, et supprimez les champs correspondants :

```csharp
class Snail
{
    // Propriétés
    public string Name { get; }
    public ConsoleColor Color { get; }
    public int X { get; private set; }
    public int Y { get; private set; }
    public int Energy { get; private set; }

    // Constructeur
    public Snail(string name, ConsoleColor color)
    {
        this.Name = name;
        this.Color = color;
        this.X = 0;
        this.Y = 0;
        this.Energy = 100;
    }

    public void Draw()
    {
        SuperConsole.WriteAtColor(this.X, this.Y, "@", this.Color);
    }

    public void Erase()
    {
        SuperConsole.WriteAtColor(this.X, this.Y, ".", ConsoleColor.DarkGray);
    }

    public void Move(int dx, int dy)
    {
        this.X = this.X + dx;
        this.Y = this.Y + dy;
    }

    public void ReduceEnergy(int amount)
    {
        this.Energy = this.Energy - amount;
        if (this.Energy < 10)
        {
            this.Energy = 10;
        }
    }

    public void DrawEnergy(int displayX, int displayY)
    {
        Console.SetCursorPosition(displayX, displayY);
        Console.ForegroundColor = this.Color;
        string bar = new string('#', this.Energy / 10);
        string empty = new string('-', 10 - this.Energy / 10);
        Console.Write($"{this.Name,6}[{bar}{empty}] ");
        Console.ResetColor();
    }
}
```

### Ce qui a changé

| Avant (champs privés) | Après (propriétés) |
| :--- | :--- |
| `private string name;` | `public string Name { get; }` |
| `private int x;` | `public int X { get; private set; }` |
| `private int energy;` | `public int Energy { get; private set; }` |
| `this.name` dans les méthodes | `this.Name` dans les méthodes |

### Corriger Race.cs

Dans `Race.Init()`, l'initialisation de `X` et `Y` utilise `private set`, ce qui est autorisé uniquement **dans la classe `Snail`**. Il faut modifier le constructeur pour accepter la position :

```csharp
// Constructeur mis à jour
public Snail(string name, ConsoleColor color, int x, int y)
{
    this.Name = name;
    this.Color = color;
    this.X = x;
    this.Y = y;
    this.Energy = 100;
}
```

Dans `Race.Init()` :

```csharp
public static void Init()
{
    Snails = new Snail[]
    {
        new Snail("Turbo", ConsoleColor.Yellow, StartX, 2),
        new Snail("Speedy", ConsoleColor.Cyan, StartX, 4),
        new Snail("Flash", ConsoleColor.Magenta, StartX, 6)
    };
}
```

### Compiler et tester

Le code devrait maintenant compiler. La lecture des propriétés fonctionne (`snail.Energy`, `snail.X`, `snail.Name`), mais l'écriture directe est interdite :

```csharp
snail.Energy = 9999;  // ERREUR de compilation !
snail.X = 50;         // ERREUR de compilation !
snail.Name = "Hack";  // ERREUR de compilation !
```

Positive
: La course fonctionne exactement comme avant, mais les données sont protégées. La triche n'est plus possible.

## Étape 4 : Propriété avec validation
Duration: 0:10:00

### Objectif

Ajouter une **validation** dans la propriété `Energy` pour garantir qu'elle reste toujours dans la plage [10, 100].

### Full property pour Energy

Remplacez l'auto-propriété `Energy` par une **full property** avec un champ privé :

```csharp
class Snail
{
    private int _energy;  // Convention Microsoft : préfixe _

    public string Name { get; }
    public ConsoleColor Color { get; }
    public int X { get; private set; }
    public int Y { get; private set; }

    public int Energy
    {
        get { return _energy; }
        private set
        {
            if (value < 10)
                _energy = 10;
            else if (value > 100)
                _energy = 100;
            else
                _energy = value;
        }
    }

    public Snail(string name, ConsoleColor color, int x, int y)
    {
        Name = name;
        Color = color;
        X = x;
        Y = y;
        Energy = 100;  // Passe par la propriété → validé
    }

    // ...
}
```

> **Convention `_`** : Microsoft recommande le préfixe underscore (`_energy`) pour les champs privés. Cela évite la confusion avec les propriétés (`Energy`) et rend `this.` inutile.

### Simplifier ReduceEnergy

Puisque la validation est dans la propriété, la méthode `ReduceEnergy` n'a plus besoin de vérifier :

```csharp
public void ReduceEnergy(int amount)
{
    this.Energy = this.Energy - amount;  // La propriété gère la limite
}
```

Si `Energy` vaut 20 et `amount` vaut 15, la propriété reçoit `value = 5`, qui est inférieur à 10, donc `energy` est mis à 10. La validation est **centralisée** dans la propriété.

### Tester la validation

La validation fonctionne partout, automatiquement :

```csharp
Snail turbo = new Snail("Turbo", ConsoleColor.Yellow, 2, 2);

turbo.ReduceEnergy(95);  // 100 - 95 = 5 → clamped à 10
Console.WriteLine(turbo.Energy);  // Affiche 10

turbo.ReduceEnergy(50);  // 10 - 50 = -40 → clamped à 10
Console.WriteLine(turbo.Energy);  // Affiche toujours 10
```

Positive
: La validation est maintenant **à un seul endroit** (la propriété `Energy`). Toute modification passe par là, que ce soit le constructeur, `ReduceEnergy()`, ou n'importe quel futur code dans la classe.

## Étape 5 : Encapsuler le Menu
Duration: 0:10:00

### Objectif

Appliquer le même traitement d'encapsulation à la classe `Menu` du codelab **oo-01-menu**.

### Rappel : la classe Menu actuelle

```csharp
class Menu
{
    public string[] Options;
    public int SelectedIndex;

    public Menu(string[] options)
    {
        this.Options = options;
        this.SelectedIndex = 0;
    }

    public void Display() { /* ... */ }
    public void MoveUp() { /* ... */ }
    public void MoveDown() { /* ... */ }
}
```

### Problèmes

```csharp
Menu menu = new Menu(new string[] { "Jouer", "Options", "Quitter" });

menu.SelectedIndex = 999;        // Index hors limites !
menu.Options = new string[] {};  // Tableau vide !
menu.SelectedIndex = -5;         // Index négatif !
```

### Encapsuler

Appliquez les mêmes principes :

```csharp
class Menu
{
    private string[] options;

    public int SelectedIndex { get; private set; }

    public Menu(string[] options)
    {
        this.options = options;
        this.SelectedIndex = 0;
    }

    public void MoveUp()
    {
        if (this.SelectedIndex > 0)
        {
            this.SelectedIndex = this.SelectedIndex - 1;
        }
    }

    public void MoveDown()
    {
        if (this.SelectedIndex < this.options.Length - 1)
        {
            this.SelectedIndex = this.SelectedIndex + 1;
        }
    }

    public void Display()
    {
        for (int i = 0; i < this.options.Length; i++)
        {
            if (i == this.SelectedIndex)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"> {this.options[i]}");
            }
            else
            {
                Console.ResetColor();
                Console.WriteLine($"  {this.options[i]}");
            }
        }
        Console.ResetColor();
    }
}
```

### Ce qui a changé

| Avant | Après | Pourquoi |
| :--- | :--- | :--- |
| `public string[] Options` | `private string[] options` | Le tableau ne doit pas être remplacé |
| `public int SelectedIndex` | `public int SelectedIndex { get; private set; }` | Modifiable uniquement via `MoveUp/MoveDown` |

```csharp
menu.SelectedIndex = 999;  // ERREUR de compilation !
menu.options = null;        // ERREUR de compilation !
```

Positive
: Le menu est maintenant protégé. L'index de sélection ne peut changer que via `MoveUp()` et `MoveDown()`, qui vérifient les bornes.

## Bonus : Améliorations
Duration: 0:10:00

### 1. Propriété calculée

Une propriété peut être **calculée** à partir d'autres données, sans champ dédié :

```csharp
// Dans la classe Snail
public bool IsExhausted => this.Energy <= 10;
```

Utilisation :

```csharp
if (snail.IsExhausted)
{
    Console.WriteLine($"{snail.Name} est épuisé !");
}
```

`=>` est une syntaxe raccourcie (expression-bodied member). C'est équivalent à :

```csharp
public bool IsExhausted
{
    get { return this.Energy <= 10; }
}
```

### 2. Méthode `ToString()` avec propriétés

```csharp
// Dans la classe Snail
public override string ToString()
{
    return $"{this.Name} (x={this.X}, y={this.Y}, energy={this.Energy})";
}
```

```csharp
Console.WriteLine(turbo);  // Affiche : Turbo (x=5, y=2, energy=87)
```

### 3. Accesseur `init` (C# 9+)

L'accesseur `init` permet d'assigner une valeur **uniquement à la création** de l'objet, y compris avec la syntaxe d'initialisation :

```csharp
class Snail
{
    public string Name { get; init; }
    public ConsoleColor Color { get; init; }
    // ...
}
```

```csharp
Snail turbo = new Snail("Turbo", ConsoleColor.Yellow, 0, 2)
{
    Name = "Super Turbo"  // OK : init permet ça à la création
};

turbo.Name = "Hack";  // ERREUR : interdit après la création
```

## Synthèse
Duration: 0:03:00

### Récapitulatif de la transformation

| Aspect | Avant (public) | Après (encapsulé) |
| :--- | :--- | :--- |
| Champs | `public int Energy` | `private int _energy` + propriété |
| Lecture | `snail.Energy` | `snail.Energy` (identique !) |
| Écriture | `snail.Energy = 9999` (triche) | `snail.Energy = 9999` → ERREUR |
| Modification | Directe, sans contrôle | Via `ReduceEnergy()` (contrôlée) |
| Validation | Dans la méthode (contournable) | Dans la propriété (impossible à contourner) |
| Nom | `snail.Name = ""` (modifiable) | `snail.Name` → lecture seule |
| Convention | — | `_prefixe` pour champs privés (Microsoft) |

### Concepts clés

1. **`private`** cache les données à l'extérieur de la classe
2. Les **propriétés** (`{ get; set; }`) remplacent les méthodes Get/Set de Java
3. **`{ get; private set; }`** = lecture partout, écriture interne seulement
4. **`{ get; }`** = immutable après le constructeur
5. **Full property** = propriété avec logique de validation
6. Le mot-clé **`value`** représente la valeur assignée dans le `set`

### Spoiler : héritage

Les données sont protégées, mais toute la logique est dans une seule classe `Snail`. Que se passe-t-il si on veut des **types** d'escargots (rapide, lent, à bonus) ? L'**héritage** permettra de créer des classes spécialisées.

Positive
: Félicitations ! Vos classes sont maintenant encapsulées. Les données sont protégées, la validation est centralisée, et la triche est impossible. Le code extérieur utilise les propriétés exactement comme des champs, sans savoir que la validation se fait en coulisses.

Survey
: Quel aspect de l'encapsulation vous semble le plus utile ?
<ul>
<li>La protection contre les valeurs absurdes</li>
<li>La centralisation de la validation</li>
<li>Les propriétés en lecture seule</li>
<li>La syntaxe simple des propriétés C#</li>
</ul>

author: Jonathan Melly
summary: Créer sa première classe dérivée — syntaxe de base de l'héritage
id: oo-04a-inheritance-intro
categories: csharp,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Héritage OO (intro) : créer sa première classe dérivée

## Vue d'ensemble
Duration: 0:03:00

Ce tutorial fait suite au codelab **oo-03-encapsulation** et aux slides **Partie A** de l'héritage. Il introduit la mécanique de base : créer une classe dérivée, appeler le constructeur parent, et ajouter des membres propres.

**Pas de `virtual` ni `override` ici** — c'est l'objet du codelab `oo-04-inheritance` (Partie B).

### Contexte

À la fin du codelab `oo-03-encapsulation`, la classe `Snail` est encapsulée :

```csharp
class Snail
{
    private int _energy;

    public string Name { get; }
    public ConsoleColor Color { get; }
    public int X { get; private set; }
    public int Y { get; private set; }

    public int Energy
    {
        get { return _energy; }
        private set { /* validation [10, 100] */ }
    }

    public Snail(string name, ConsoleColor color, int x, int y) { ... }
    public void Move(int dx, int dy) { ... }
    public void ReduceEnergy(int amount) { ... }
    public void Draw() { ... }
    public void Erase() { ... }
}
```

Tous les escargots se comportent de la même manière. On veut créer un type spécialisé **sans copier-coller** la classe.

### Objectifs

À travers 4 étapes, vous apprendrez à :

1. Déclarer une classe dérivée avec `: Snail`
2. Appeler le constructeur parent avec `base(...)`
3. Ajouter des membres propres à la classe dérivée
4. Comprendre la relation "est-un" (is-a)

Positive
: À la fin, vous aurez une classe `GlitterSnail` qui hérite de tout `Snail` et ajoute ses propres membres — sans modifier `Snail` et sans dupliquer de code.

Survey
: Comment ajouteriez-vous un type d'escargot spécialisé aujourd'hui ?
<ul>
<li>Je copierais Snail.cs et je modifierais ce dont j'ai besoin</li>
<li>J'ajouterais des paramètres ou des if dans Snail</li>
<li>Je créerais une classe dérivée (je connais déjà)</li>
<li>Je ne sais pas encore</li>
</ul>

## Étape 1 : Déclarer la première classe dérivée
Duration: 0:10:00

### Objectif

Créer `GlitterSnail.cs` avec la syntaxe `: Snail` et observer ce qui est hérité automatiquement.

### Créer GlitterSnail.cs (*glitter* = paillettes)

Créez un nouveau fichier `GlitterSnail.cs` dans le même projet que `Snail.cs` :

```csharp
class GlitterSnail : Snail
{
}
```

C'est intentionnellement minimal — on va voir ce que ça donne.

### Observer l'erreur de compilation

Compilez. Vous obtenez une erreur du type :

```
'GlitterSnail' does not contain a constructor that takes 0 arguments
```

ou

```
There is no argument given that corresponds to the required parameter 'name'
```

C# cherche un constructeur dans `GlitterSnail`, mais il n'y en a pas encore. La classe de base `Snail` exige `name`, `color`, `x`, `y` — il faut transmettre ces valeurs.

Negative
: Cette erreur est **attendue et normale**. Elle nous dit exactement quoi faire à l'étape suivante : ajouter un constructeur qui appelle `base(...)`.

### Ce qui est déjà hérité

Même sans constructeur, lisez le code : `GlitterSnail` hérite **automatiquement** de `Snail` :

- Propriétés : `Name`, `Color`, `X`, `Y`, `Energy`
- Méthodes : `Move()`, `ReduceEnergy()`, `Draw()`, `Erase()`

Dès qu'on aura un constructeur, un `GlitterSnail` pourra `Draw()`, `Move()`, etc. sans qu'on ait rien écrit.

## Étape 2 : Le constructeur et `base(...)`
Duration: 0:10:00

### Objectif

Ajouter le constructeur de `GlitterSnail` en transmettant les paramètres à `Snail` via `base(...)`.

### Ajouter le constructeur

Modifiez `GlitterSnail.cs` :

```csharp
class GlitterSnail : Snail
{
    public GlitterSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
        // Le constructeur de Snail s'exécute d'abord (initialise Name, Color, X, Y, Energy)
        // Le corps de GlitterSnail s'exécute ensuite (ici, rien de spécial pour l'instant)
    }
}
```

### Comprendre `: base(...)`

| Partie | Rôle |
| :----- | :--- |
| `GlitterSnail(string name, ...)` | Reçoit les paramètres |
| `: base(name, color, x, y)` | Les transmet au constructeur de `Snail` |
| Corps `{ }` | Code supplémentaire propre à `GlitterSnail` |

### Ordre d'exécution

```
new GlitterSnail("Stardust", ConsoleColor.Magenta, 0, 4)
  → 1. Snail(name, color, x, y) s'exécute : Name="Stardust", Energy=100, ...
  → 2. Corps de GlitterSnail() s'exécute : (rien pour l'instant)
```

### Tester l'instanciation

Dans `Program.cs`, instanciez un `GlitterSnail` et appelez ses méthodes héritées :

```csharp
GlitterSnail glitter = new GlitterSnail("Stardust", ConsoleColor.Magenta, 0, 4);
glitter.Draw();    // Hérité de Snail — fonctionne !
glitter.Move(2, 0); // Hérité de Snail — fonctionne !
Console.WriteLine(glitter.Name);    // "Stardust"
Console.WriteLine(glitter.Energy);  // 100
```

Compilez et exécutez. Tout fonctionne — sans avoir dupliqué une seule ligne de `Snail`.

Positive
: `base(...)` est obligatoire quand la classe parente n'a pas de constructeur sans paramètre. Sans `base(...)`, le compilateur cherche un constructeur vide dans `Snail` — qui n'existe pas.

## Étape 3 : Ajouter des membres propres à GlitterSnail
Duration: 0:10:00

### Objectif

`GlitterSnail` a quelque chose en plus : une intensité de scintillement et une méthode visuelle. Ces membres n'existent pas dans `Snail`.

### Ajouter GlitterIntensity et Sparkle() (*sparkle* = scintiller)

Modifiez `GlitterSnail.cs` :

```csharp
class GlitterSnail : Snail
{
    public int GlitterIntensity { get; }

    public GlitterSnail(string name, ConsoleColor color, int x, int y, int intensity)
        : base(name, color, x, y)
    {
        GlitterIntensity = intensity;
    }

    public void Sparkle()
    {
        Console.ForegroundColor = Color;
        for (int i = 0; i < GlitterIntensity; i++)
        {
            Console.Write("*");
        }
        Console.ResetColor();
    }
}
```

### Décortiquons les ajouts

| Membre | Appartient à | Accès depuis `Snail` ? |
| :----- | :----------- | :--------------------- |
| `GlitterIntensity` | `GlitterSnail` seulement | Non |
| `Sparkle()` | `GlitterSnail` seulement | Non |
| `Name`, `Move()`, etc. | `Snail` (hérité) | Oui |

### Tester les membres propres

```csharp
GlitterSnail glitter = new GlitterSnail("Stardust", ConsoleColor.Magenta, 0, 4, 3);

glitter.Draw();       // Hérité de Snail
glitter.Sparkle();    // Propre à GlitterSnail → affiche "***"
glitter.Move(2, 0);   // Hérité de Snail

Console.WriteLine(glitter.GlitterIntensity);  // 3

// Un Snail ordinaire ne connaît pas Sparkle() :
Snail normal = new Snail("Bob", ConsoleColor.White, 0, 2);
// normal.Sparkle();  // ERREUR de compilation — Snail n'a pas Sparkle()
```

Compilez et vérifiez que `Sparkle()` produit des étoiles colorées dans la console.

Negative
: `Sparkle()` et `GlitterIntensity` n'existent que dans `GlitterSnail`. Une variable de type `Snail` qui pointe vers un `GlitterSnail` ne peut pas appeler `Sparkle()` directement — on verra pourquoi avec `is` dans le codelab Partie B.

## Étape 4 : La relation "est-un"
Duration: 0:05:00

### Objectif

Découvrir que `GlitterSnail` peut coexister avec `Snail` dans un tableau — sans encore utiliser `override`.

### Un tableau mixte

```csharp
Snail[] snails = new Snail[]
{
    new Snail("Bob", ConsoleColor.White, 0, 2),
    new GlitterSnail("Stardust", ConsoleColor.Magenta, 0, 4, 3)
};

foreach (Snail snail in snails)
{
    snail.Move(2, 0);  // Les deux appellent Snail.Move() — identique pour l'instant
    snail.Draw();
}
```

Compilez et exécutez. Les deux escargots se déplacent et s'affichent. La boucle traite un `Snail` et un `GlitterSnail` de la même manière.

### Pourquoi ça fonctionne ?

`GlitterSnail` **est un** `Snail` (relation "is-a"). Partout où un `Snail` est attendu, un `GlitterSnail` peut être utilisé.

### Ce qu'on ne voit pas encore

Les deux escargots appellent **le même `Move()`** — celui de `Snail`. Le `GlitterSnail` ne se déplace pas différemment. Pour changer ça, il faut `virtual` + `override` — c'est l'objet de la Partie B (`oo-04-inheritance`).

Positive
: La boucle `foreach (Snail snail in snails)` fonctionne déjà avec des types mixtes. C'est le début du polymorphisme. La Partie B ira plus loin : chaque type aura son propre `Move()`.

## Synthèse
Duration: 0:02:00

### Récapitulatif

| Concept | Syntaxe | Ce qu'on a fait |
| :------ | :------ | :-------------- |
| Classe dérivée | `class GlitterSnail : Snail` | Hérite de tout sans duplication |
| Constructeur parent | `: base(name, color, x, y)` | Initialise la partie `Snail` |
| Membre propre (propriété) | `public int GlitterIntensity { get; }` | Propre à `GlitterSnail` |
| Membre propre (méthode) | `public void Sparkle()` | Propre à `GlitterSnail` |
| Relation is-a | `Snail[] snails = { ..., new GlitterSnail(...) }` | `GlitterSnail` utilisable comme `Snail` |

### Prochaine étape : Partie B

Dans `oo-04-inheritance`, vous apprendrez à :

- Marquer `Move()` comme `virtual` dans `Snail`
- Le redéfinir avec `override` dans les classes dérivées
- Comprendre le polymorphisme : chaque type a son propre comportement, la boucle ne change pas

Positive
: Félicitations ! Vous avez créé votre première classe dérivée, appelé le constructeur parent, et ajouté des membres spécifiques — sans copier-coller une seule ligne de `Snail`.

Survey
: Qu'est-ce qui vous a semblé le plus clair dans ce codelab ?
<ul>
<li>La syntaxe `: Snail` pour hériter</li>
<li>Le rôle de `base(...)` dans le constructeur</li>
<li>La différence entre membres hérités et membres propres</li>
<li>La relation "est-un" et le tableau mixte</li>
</ul>

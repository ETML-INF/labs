author: Jonathan Melly
summary: Créer des classes spécialisées avec l'héritage
id: oo-04-inheritance
categories: csharp,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Héritage OO : créer des types d'escargots spécialisés

## Vue d'ensemble
Duration: 0:03:00

Ce tutorial reprend le code du codelab **oo-03-encapsulation** (escargot encapsulé) et introduit l'**héritage** : créer des classes spécialisées (`FastSnail`, `SlowSnail`, `BonusSnail`) à partir de la classe de base `Snail`, sans dupliquer le code.

### Contexte

À la fin du codelab précédent, la classe `Snail` est encapsulée :

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

Le problème : tous les escargots se comportent **exactement de la même manière**. On aimerait des types spécialisés sans copier-coller la classe.

### Objectifs

À travers 5 étapes progressives, vous apprendrez à :
1. Préparer la classe de base pour l'héritage (`protected set`, `virtual`)
2. Créer une classe dérivée avec `: Snail` et `base(...)`
3. Redéfinir le comportement avec `override`
4. Utiliser le **polymorphisme** pour la course
5. Ajouter des membres spécifiques à une classe dérivée

Positive
: Ce codelab vous apprend à **spécialiser** des classes sans duplication. À la fin, votre course aura 4 types d'escargots différents, et la boucle de course ne changera pas d'une ligne.

Survey
: Comment créeriez-vous un escargot rapide aujourd'hui ?
<ul>
<li>Je copierais la classe Snail et je modifierais Move()</li>
<li>J'ajouterais un if/else dans Move() selon un type</li>
<li>J'utiliserais l'héritage (je connais déjà)</li>
<li>Je ne sais pas</li>
</ul>

## Étape 1 : Préparer Snail pour l'héritage
Duration: 0:10:00

### Objectif

Modifier la classe `Snail` pour qu'elle puisse servir de **classe de base** : les classes dérivées doivent pouvoir modifier certaines propriétés et redéfinir `Move()`.

### Changer `private set` en `protected set`

Ouvrez `Snail.cs` et modifiez les propriétés `X`, `Y` et `Energy` :

```csharp
class Snail
{
    private int _energy;

    public string Name { get; }
    public ConsoleColor Color { get; }
    public int X { get; protected set; }       // Changé : private → protected
    public int Y { get; protected set; }       // Changé : private → protected

    public int Energy
    {
        get { return _energy; }
        protected set                           // Changé : private → protected
        {
            if (value < 10)
                _energy = 10;
            else if (value > 100)
                _energy = 100;
            else
                _energy = value;
        }
    }

    // ... constructeur et méthodes inchangés pour l'instant
}
```

### Rappel : `protected`

Au chapitre encapsulation, on avait vu ce modificateur dans le tableau sans l'expliquer :

| Modificateur | Accès autorisé                             |
| :----------- | :----------------------------------------- |
| `public`     | Partout                                    |
| `private`    | Uniquement dans la classe                  |
| `protected`  | Dans la classe **et ses classes dérivées** |

`protected set` signifie : les classes dérivées (comme `FastSnail`) pourront modifier `X`, `Y` et `Energy`, mais le code extérieur (`Program.cs`) ne pourra toujours pas.

### Rendre `Move()` virtuel

Ajoutez le mot-clé `virtual` à la méthode `Move()` :

```csharp
public virtual void Move(int dx, int dy)
{
    X = X + dx;
    Y = Y + dy;
}
```

`virtual` signifie : "les classes dérivées **peuvent** remplacer cette méthode par leur propre version."

### Compiler et tester

Compiler et exécuter. La course fonctionne **exactement comme avant**. On n'a rien cassé — on a juste préparé `Snail` pour accueillir des classes dérivées.

Positive
: `protected set` et `virtual` ne changent rien au comportement actuel. Ils ouvrent des portes pour les classes dérivées qu'on va créer aux étapes suivantes.

## Étape 2 : Créer FastSnail
Duration: 0:10:00

### Objectif

Créer la première classe dérivée : un escargot **rapide** qui avance 2 fois plus vite.

### Créer le fichier FastSnail.cs

Créez un nouveau fichier `FastSnail.cs` dans le même projet :

```csharp
class FastSnail : Snail
{
    public FastSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
    }

    public override void Move(int dx, int dy)
    {
        base.Move(dx * 2, dy);  // Double la distance horizontale
    }
}
```

### Décortiquons le code

| Élément                     | Rôle                                                                          |
| :-------------------------- | :---------------------------------------------------------------------------- |
| `: Snail`                   | `FastSnail` hérite de `Snail` (toutes ses propriétés et méthodes)             |
| `: base(name, color, x, y)` | Appelle le constructeur de `Snail` pour initialiser Name, Color, X, Y, Energy |
| `override void Move(...)`   | Remplace le `Move()` de `Snail` par une version spécialisée                   |
| `base.Move(dx * 2, dy)`     | Appelle le `Move()` original de `Snail` avec le double de distance            |

### Tester FastSnail

Dans `Program.cs` ou dans `Race.Init()`, remplacer un escargot par un `FastSnail` :

```csharp
Snail[] snails = new Snail[]
{
    new Snail("Normal", ConsoleColor.White, 0, 2),
    new FastSnail("Turbo", ConsoleColor.Yellow, 0, 4),   // FastSnail !
    new Snail("Flash", ConsoleColor.Magenta, 0, 6)
};
```

Compiler et exécuter. **Turbo avance 2 fois plus vite** que les autres. Notez que le tableau est de type `Snail[]` mais contient un `FastSnail` — c'est le début du `polymorphisme`.

Negative
: Si vous obtenez une erreur `does not contain a parameterless constructor`, vérifiez que le constructeur de `FastSnail` appelle bien `: base(name, color, x, y)`. Sans `base(...)`, le compilateur cherche un constructeur sans paramètre dans `Snail`, qui n'existe pas.

## Étape 3 : Créer SlowSnail et BonusSnail
Duration: 0:10:00

### Objectif

Créer deux classes dérivées supplémentaires avec des comportements différents.

### SlowSnail.cs : avance si énergie > 30

Créez `SlowSnail.cs` :

```csharp
class SlowSnail : Snail
{
    public SlowSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
    }

    public override void Move(int dx, int dy)
    {
        if (Energy > 30)
        {
            base.Move(dx, dy);  // Avance normalement
        }
        // Sinon : ne bouge pas du tout (trop fatigué)
    }
}
```

`SlowSnail` utilise `Energy` (lecture publique) pour décider s'il bouge. Quand l'énergie descend sous 30, il s'arrête complètement.

### BonusSnail.cs : bonus aléatoire

Créez `BonusSnail.cs` :

```csharp
class BonusSnail : Snail
{
    private Random _rng = new Random();

    public BonusSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
    }

    public override void Move(int dx, int dy)
    {
        int bonus = _rng.Next(0, 3);  // Bonus entre 0 et 2
        base.Move(dx + bonus, dy);    // Avance de dx + bonus
    }
}
```

`BonusSnail` a un champ `_rng` en plus de ce qu'il hérite de `Snail`. À chaque déplacement, il ajoute un bonus aléatoire.

### Tester les 4 types ensemble

Mettez à jour le tableau d'escargots :

```csharp
Snail[] snails = new Snail[]
{
    new Snail("Normal", ConsoleColor.White, 0, 2),
    new FastSnail("Turbo", ConsoleColor.Yellow, 0, 4),
    new SlowSnail("Papy", ConsoleColor.Gray, 0, 6),
    new BonusSnail("Lucky", ConsoleColor.Green, 0, 8)
};
```

Compilez et exécutez. Observez les comportements différents :
- **Normal** avance régulièrement
- **Turbo** fonce en tête (2x plus vite)
- **Papy** s'arrête quand il est fatigué
- **Lucky** a des accélérations aléatoires

Positive
: Les 4 types coexistent dans un `Snail[]`. La boucle de course appelle `snail.Move(dx, 0)` pour tous, et C# choisit automatiquement le bon `Move()` selon le type réel. C'est le **polymorphisme**.

## Étape 4 : Le polymorphisme dans la course
Duration: 0:15:00

### Objectif

Comprendre et exploiter le polymorphisme : la boucle de course traite tous les escargots de manière **uniforme**, sans se soucier de leur type.

### La boucle de course (inchangée)

```csharp
Random rng = new Random();
bool raceOver = false;

while (!raceOver)
{
    foreach (Snail snail in snails)
    {
        snail.Erase();

        int dx = rng.Next(1, 4);
        snail.Move(dx, 0);         // Polymorphisme ici !
        snail.ReduceEnergy(dx);

        snail.Draw();

        if (snail.X >= Race.FinishX)
        {
            raceOver = true;
            Console.WriteLine($"{snail.Name} a gagné !");
            break;
        }
    }

    Thread.Sleep(100);
}
```

### Quel `Move()` est appelé ?

Quand la boucle exécute `snail.Move(dx, 0)`, C# regarde le **type réel** de l'objet (pas le type de la variable) :

| Variable    | Type réel    | `snail.Move(3, 0)` appelle...           |
| :---------- | :----------- | :-------------------------------------- |
| `snails[0]` | `Snail`      | `Snail.Move` → avance de 3              |
| `snails[1]` | `FastSnail`  | `FastSnail.Move` → avance de 6          |
| `snails[2]` | `SlowSnail`  | `SlowSnail.Move` → avance de 3 ou 0     |
| `snails[3]` | `BonusSnail` | `BonusSnail.Move` → avance de 3 + bonus |

### Pourquoi c'est puissant ?

Sans polymorphisme, il faudrait écrire :

```csharp
// MAUVAIS : sans polymorphisme
if (snail is FastSnail fast)
    fast.Move(dx, 0);
else if (snail is SlowSnail slow)
    slow.Move(dx, 0);
else if (snail is BonusSnail bonus)
    bonus.Move(dx, 0);
else
    snail.Move(dx, 0);
```

Avec le polymorphisme : **une seule ligne** `snail.Move(dx, 0)`. Et si on ajoute un 5ᵉ type d'escargot demain, la boucle ne change pas.

### Exercice : ajouter un compteur de tours

Ajouter un compteur qui affiche le nombre de tours de la course. Vérifier que tous les types fonctionnent correctement :

```csharp
int turn = 0;
while (!raceOver)
{
    turn++;
    Console.SetCursorPosition(0, 0);
    Console.Write($"Tour {turn}");

    foreach (Snail snail in snails)
    {
        // ... même code qu'avant
    }

    Thread.Sleep(100);
}
```

Positive
: Le polymorphisme est le concept le plus puissant de la POO. Il permet d'écrire du code **générique** qui fonctionne avec n'importe quel type dérivé, sans connaître les types à l'avance.

## Étape 5 : Comportement propre à BonusSnail
Duration: 0:10:00

### Objectif

Ajouter des membres **spécifiques** à `BonusSnail` : un compteur de bonus et une méthode `CollectBonus()` qui récupère de l'énergie.

### Ajouter BonusCount et CollectBonus()

Modifier `BonusSnail.cs` :

```csharp
class BonusSnail : Snail
{
    private Random _rng = new Random();

    public int BonusCount { get; private set; }

    public BonusSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
        BonusCount = 0;
    }

    public override void Move(int dx, int dy)
    {
        int bonus = _rng.Next(0, 3);
        base.Move(dx + bonus, dy);
    }

    public void CollectBonus()
    {
        Energy = Energy + 10;       // protected set → autorisé !
        BonusCount = BonusCount + 1;
    }
}
```

`CollectBonus()` utilise `protected set` sur `Energy` pour ajouter de l'énergie. La validation dans la propriété garantit que ça ne dépasse pas 100.

### Utiliser `is` pour accéder aux membres spécifiques

Dans la boucle de course, `snail` est de type `Snail`. Pour appeler `CollectBonus()`, il faut vérifier le type réel avec `is` :

```csharp
foreach (Snail snail in snails)
{
    snail.Erase();

    int dx = rng.Next(1, 4);
    snail.Move(dx, 0);
    snail.ReduceEnergy(dx);

    // Comportement spécifique à BonusSnail
    if (snail is BonusSnail bonusSnail)
    {
        if (rng.Next(0, 5) == 0)  // 1 chance sur 5
        {
            bonusSnail.CollectBonus();
        }
    }

    snail.Draw();
}
```

### Le mot-clé `is`

`is` fait deux choses en une :
1. **Vérifie** si `snail` est réellement un `BonusSnail`
2. **Convertit** dans la variable typée `bonusSnail` si c'est le cas

```csharp
if (snail is BonusSnail bonusSnail)
{
    // Ici, bonusSnail est de type BonusSnail
    // On peut accéder à BonusCount et CollectBonus()
    Console.WriteLine($"Bonus #{bonusSnail.BonusCount}");
}
```

### Compiler et tester

Lucky devrait parfois récupérer de l'énergie pendant la course, lui donnant un avantage sur la durée.

Negative
: `is` est utile pour les cas particuliers, mais **n'en abusez pas**. Si vous avez beaucoup de `if (snail is ...)`, c'est souvent le signe qu'il faudrait plutôt ajouter une méthode `virtual` dans la classe de base. Le polymorphisme est préférable aux tests de type.

## Bonus : Améliorations
Duration: 0:10:00

### 1. ToString() pour chaque type

Ajoutez une méthode `ToString()` dans `Snail` et redéfinissez-la dans les dérivées :

```csharp
// Dans Snail :
public override string ToString()
{
    return $"{Name} (x={X}, energy={Energy})";
}

// Dans FastSnail :
public override string ToString()
{
    return $"{Name} [RAPIDE] (x={X}, energy={Energy})";
}

// Dans BonusSnail :
public override string ToString()
{
    return $"{Name} [BONUS x{BonusCount}] (x={X}, energy={Energy})";
}
```

`ToString()` est une méthode `virtual` de la classe `object` (dont toutes les classes héritent). En la redéfinissant avec `override`, on personnalise l'affichage.

### 2. PoisonSnail : nouveau type

Créez un `PoisonSnail` qui empoisonne l'escargot devant lui :

```csharp
class PoisonSnail : Snail
{
    public PoisonSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
    }

    public override void Move(int dx, int dy)
    {
        base.Move(dx, dy);  // Avance normalement
    }

    public void Poison(Snail target)
    {
        target.ReduceEnergy(15);  // Fait perdre 15 d'énergie à la cible
    }
}
```

### 3. Utiliser base.Move() de manière créative

Chaque `override` de `Move()` appelle `base.Move(...)` avec des paramètres différents. C'est un pattern courant : la dérivée **enrichit** le comportement de base au lieu de le remplacer complètement.

Essayez de créer un `ZigZagSnail` qui avance en zigzag :

```csharp
class ZigZagSnail : Snail
{
    private int _direction = 1;

    public ZigZagSnail(string name, ConsoleColor color, int x, int y)
        : base(name, color, x, y)
    {
    }

    public override void Move(int dx, int dy)
    {
        base.Move(dx, _direction);  // Alterne haut/bas
        _direction = _direction * -1;
    }
}
```

## Synthèse
Duration: 0:03:00

### Récapitulatif de la transformation

| Aspect            | Avant (une seule classe)      | Après (héritage)                      |
| :---------------- | :---------------------------- | :------------------------------------ |
| Types d'escargots | 1 seul (`Snail`)              | 4+ types spécialisés                  |
| Comportement Move | Identique pour tous           | Spécialisé par type (`override`)      |
| Ajout d'un type   | Copier-coller toute la classe | Créer une classe `: Snail`            |
| Boucle de course  | `foreach (Snail ...)`         | `foreach (Snail ...)` — **identique** |
| Duplication       | Massive si plusieurs types    | Zéro                                  |
| Accès dérivées    | `private set` (bloqué)        | `protected set` (autorisé)            |

### Concepts clés

1. **`: Snail`** crée une classe dérivée qui hérite de tout
2. **`base(...)`** appelle le constructeur de la classe parente
3. **`protected`** ouvre l'accès aux dérivées, pas à l'extérieur
4. **`virtual`** autorise la redéfinition d'une méthode
5. **`override`** remplace le comportement dans la dérivée
6. **`base.Move(...)`** appelle la version originale
7. **Polymorphisme** : `Snail[]` contient tous les types, la boucle est identique
8. **`is`** permet de vérifier et convertir le type réel

### Spoiler : classes abstraites

`Snail` peut encore être instancié directement. Mais un escargot "générique" a-t-il du sens ? Les **classes abstraites** forceront chaque type à implémenter son propre comportement.

Positive
: Félicitations ! Votre course a maintenant 4 types d'escargots avec des comportements uniques, sans une seule ligne de code dupliquée. La boucle de course est identique — c'est la puissance du polymorphisme.

Survey
: Quel concept de l'héritage vous semble le plus utile ?
<ul>
<li>La réutilisation du code (pas de duplication)</li>
<li>Le polymorphisme (un tableau, plusieurs types)</li>
<li>virtual/override (redéfinir le comportement)</li>
<li>protected (accès contrôlé pour les dérivées)</li>
</ul>

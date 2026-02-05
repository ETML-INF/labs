author: Jonathan Melly
summary: Transformer la course d'escargots en instances
id: oo-02-snail
categories: csharp,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Course d'Escargots OO : des classes statiques aux instances

## Vue d'ensemble
Duration: 0:03:00

Ce tutorial reprend la course d'escargots du codelab **preoo-03-static-classes** et la transforme en code orienté objet avec des **instances**.

### Contexte

À la fin du codelab précédent, le code était organisé en classes statiques :

```
SnailRaceRefactoring/
├── Program.cs
├── Game/
│   ├── Race.cs          // static class Race (données + logique)
│   └── Snail.cs         // static class Snail (Draw/Clear)
└── Display/
    └── SuperConsole.cs  // static class SuperConsole
```

La classe `Race` contient des **tableaux parallèles** (`SnailX[]`, `SnailY[]`, `SnailEnergy[]`, `SnailNames[]`, `SnailColors[]`) pour gérer les escargots. Ça fonctionne, mais c'est fragile et difficile à étendre.

### Objectifs

À travers 5 étapes progressives, vous apprendrez à :
1. Identifier le problème des tableaux parallèles
2. Créer une classe `Snail` instanciable avec un constructeur
3. Ajouter des méthodes d'instance (Move, Draw, Erase)
4. Remplacer les tableaux parallèles par un tableau d'objets `Snail[]`
5. Simplifier la boucle de course

Positive
: Ce codelab est le passage clé de la formation : vous allez voir concrètement pourquoi les instances sont plus puissantes que les tableaux parallèles.

Survey
: Comment trouvez-vous les tableaux parallèles ?
<ul>
<li>Pratiques mais un peu fragiles</li>
<li>Difficiles à maintenir</li>
<li>Je n'ai jamais eu de problème avec</li>
<li>Je ne sais pas ce que c'est</li>
</ul>

## Étape 1 : Le problème
Duration: 0:05:00

### Rappel du code actuel dans Race.cs

La classe `Race` contient 5 tableaux parallèles pour gérer 3 escargots :

```csharp
static class Race
{
    public static int NumberOfSnails = 3;

    public static int[] SnailX = new int[3];
    public static int[] SnailY = new int[3];
    public static int[] SnailEnergy = new int[3];
    public static string[] SnailNames = { "Turbo", "Speedy", "Flash" };
    public static ConsoleColor[] SnailColors = {
        ConsoleColor.Yellow, ConsoleColor.Cyan, ConsoleColor.Magenta
    };
    // ...
}
```

### Pourquoi c'est problématique ?

Pour accéder aux données de l'escargot `i`, il faut fouiller dans **5 tableaux** :

```csharp
// Tout ça concerne le MÊME escargot !
Race.SnailX[i]
Race.SnailY[i]
Race.SnailEnergy[i]
Race.SnailNames[i]
Race.SnailColors[i]
```

| Problème | Exemple |
| :--- | :--- |
| Données éclatées | 5 tableaux pour décrire un escargot |
| Indices fragiles | Se tromper d'indice = bug silencieux |
| Pas extensible | Ajouter un champ (vitesse max ?) = 1 tableau de plus |
| Fonctions lourdes | `Snail.Draw(Race.SnailX[i], Race.SnailY[i], Race.SnailColors[i])` |

### L'objectif

Chaque escargot devrait être un **objet** qui transporte ses propres données :

```csharp
// Au lieu de 5 tableaux...
snails[i].Move(step, 0);
snails[i].Draw();
// L'escargot connaît sa position, sa couleur, son énergie !
```

Negative
: Avec les tableaux parallèles, si on ajoute un 4e escargot, il faut modifier **5 tableaux** et s'assurer que tous les indices restent cohérents. Avec des instances, il suffit d'ajouter un objet au tableau.

## Étape 2 : Créer la classe Snail instanciable
Duration: 0:15:00

### Objectif

Transformer `Snail.cs` : passer d'une classe statique avec juste Draw/Clear à une classe instanciable complète qui contient toutes les données d'un escargot.

### Nouveau contenu de Snail.cs

Remplacer le contenu de `Snail.cs` par :

```csharp
namespace SnailRaceRefactoring.Game
{
    class Snail
    {
        // Champs : chaque instance a ses propres valeurs
        public int X;
        public int Y;
        public int Energy;
        public string Name;
        public ConsoleColor Color;

        // Constructeur : initialise un escargot
        public Snail(string name, ConsoleColor color)
        {
            this.Name = name;
            this.Color = color;
            this.X = 0;
            this.Y = 0;
            this.Energy = 100;
        }
    }
}
```

### Ce qui a changé

| Avant | Après |
| :--- | :--- |
| `static class Snail` | `class Snail` (instanciable) |
| Pas de données (juste Draw/Clear) | Champs `X`, `Y`, `Energy`, `Name`, `Color` |
| Pas de constructeur | Constructeur `Snail(name, color)` |

### Comprendre le constructeur

Le constructeur reçoit les données qui **identifient** l'escargot (`name`, `color`). Les données de position (`X`, `Y`) et d'énergie (`Energy`) sont initialisées à des valeurs par défaut car elles seront configurées au moment de la course.

### Le mot-clé `this`

`this` désigne l'instance en cours de création :

```csharp
public Snail(string name, ConsoleColor color)
{
    this.Name = name;    // this.Name = champ de l'objet
                         // name = paramètre du constructeur
    this.Color = color;
}
```

### Tester la création d'instances

Dans `Program.cs`, on peut maintenant écrire (juste pour tester, on intégrera dans la course plus tard) :

```csharp
Snail turbo = new Snail("Turbo", ConsoleColor.Yellow);
Snail speedy = new Snail("Speedy", ConsoleColor.Cyan);
Snail flash = new Snail("Flash", ConsoleColor.Magenta);

Console.WriteLine($"{turbo.Name} a {turbo.Energy} d'énergie");
Console.WriteLine($"{speedy.Name} a {speedy.Energy} d'énergie");
Console.WriteLine($"{flash.Name} a {flash.Energy} d'énergie");
```

Chaque escargot est **indépendant** : modifier `turbo.Energy` ne change pas `speedy.Energy`.

Positive
: La classe `Snail` est maintenant un vrai "moule" : chaque `new Snail(...)` crée un escargot avec ses propres données.

## Étape 3 : Ajouter les méthodes d'instance
Duration: 0:15:00

### Objectif

Ajouter les méthodes `Draw`, `Erase` et `Move` à la classe `Snail`. Ces méthodes utilisent les données de **leur** instance (via `this`).

### Snail.cs complet

```csharp
using SnailRaceRefactoring.Display;

namespace SnailRaceRefactoring.Game
{
    class Snail
    {
        // Champs
        public int X;
        public int Y;
        public int Energy;
        public string Name;
        public ConsoleColor Color;

        // Constructeur
        public Snail(string name, ConsoleColor color)
        {
            this.Name = name;
            this.Color = color;
            this.X = 0;
            this.Y = 0;
            this.Energy = 100;
        }

        // Dessiner l'escargot à sa position
        public void Draw()
        {
            SuperConsole.WriteAtColor(this.X, this.Y, "@", this.Color);
        }

        // Effacer l'escargot de sa position actuelle
        public void Erase()
        {
            SuperConsole.WriteAtColor(this.X, this.Y, ".", ConsoleColor.DarkGray);
        }

        // Déplacer l'escargot
        public void Move(int dx, int dy)
        {
            this.X = this.X + dx;
            this.Y = this.Y + dy;
        }

        // Réduire l'énergie
        public void ReduceEnergy(int amount)
        {
            this.Energy = this.Energy - amount;
            if (this.Energy < 10)
            {
                this.Energy = 10;
            }
        }

        // Afficher la barre d'énergie
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
}
```

### Analyse des méthodes

| Méthode | Rôle | Utilise |
| :--- | :--- | :--- |
| `Draw()` | Dessine l'escargot | `this.X`, `this.Y`, `this.Color` |
| `Erase()` | Efface l'escargot | `this.X`, `this.Y` |
| `Move(dx, dy)` | Déplace l'escargot | `this.X`, `this.Y` |
| `ReduceEnergy(amount)` | Réduit l'énergie (min 10) | `this.Energy` |
| `DrawEnergy(x, y)` | Affiche la barre d'énergie | `this.Name`, `this.Energy`, `this.Color` |

### Avant / Après : appels

| Avant (tableaux parallèles) | Après (instance) |
| :--- | :--- |
| `Snail.Draw(Race.SnailX[i], Race.SnailY[i], Race.SnailColors[i])` | `snails[i].Draw()` |
| `Snail.Clear(Race.SnailX[i], Race.SnailY[i])` | `snails[i].Erase()` |
| `Race.SnailX[i]++` | `snails[i].Move(1, 0)` |
| `Race.SnailEnergy[i] -= amount` | `snails[i].ReduceEnergy(amount)` |

Positive
: Les appels sont beaucoup plus simples ! L'escargot "sait" où il est et comment se dessiner. Plus besoin de passer position et couleur en paramètres.

## Étape 4 : Transformer la classe Race
Duration: 0:20:00

### Objectif

Remplacer les tableaux parallèles dans `Race` par un **tableau d'objets** `Snail[]`.

### Nouveau contenu de Race.cs

```csharp
namespace SnailRaceRefactoring.Game
{
    static class Race
    {
        // Configuration de la piste
        public static int ScreenWidth = 50;
        public static int StartX = 2;
        public static int FinishX = ScreenWidth - 3;

        // Tableau d'objets (remplace les 5 tableaux parallèles !)
        public static Snail[] Snails = Array.Empty<Snail>();

        public static void Init()
        {
            // Créer les escargots
            Snails = new Snail[]
            {
                new Snail("Turbo", ConsoleColor.Yellow),
                new Snail("Speedy", ConsoleColor.Cyan),
                new Snail("Flash", ConsoleColor.Magenta)
            };

            // Positionner chaque escargot sur la piste
            for (int i = 0; i < Snails.Length; i++)
            {
                Snails[i].X = StartX;
                Snails[i].Y = 2 + i * 2;
                Snails[i].Energy = 100;
            }
        }

        public static void DrawTrack()
        {
            for (int i = 0; i < Snails.Length; i++)
            {
                int y = 2 + i * 2;

                Console.SetCursorPosition(StartX - 1, y);
                Console.ForegroundColor = ConsoleColor.White;
                Console.Write("|");

                for (int x = StartX; x < FinishX; x++)
                {
                    Console.SetCursorPosition(x, y);
                    Console.ForegroundColor = ConsoleColor.DarkGray;
                    Console.Write(".");
                }

                Console.SetCursorPosition(FinishX, y);
                Console.ForegroundColor = ConsoleColor.Green;
                Console.Write("|");
            }
            Console.ResetColor();
        }

        public static void DrawAllSnails()
        {
            foreach (Snail snail in Snails)
            {
                snail.Draw();
            }
        }

        public static void ShowEnergy()
        {
            for (int i = 0; i < Snails.Length; i++)
            {
                Snails[i].DrawEnergy(0, 10 + i);
            }
        }
    }
}
```

### Ce qui a changé

| Avant (5 tableaux parallèles) | Après (1 tableau d'objets) |
| :--- | :--- |
| `int[] SnailX = new int[3]` | Supprimé (dans chaque `Snail`) |
| `int[] SnailY = new int[3]` | Supprimé (dans chaque `Snail`) |
| `int[] SnailEnergy = new int[3]` | Supprimé (dans chaque `Snail`) |
| `string[] SnailNames = { ... }` | Supprimé (dans chaque `Snail`) |
| `ConsoleColor[] SnailColors = { ... }` | Supprimé (dans chaque `Snail`) |
| `int NumberOfSnails = 3` | `Snails.Length` (calculé automatiquement) |
| — | `Snail[] Snails` (un seul tableau !) |

### DrawAllSnails simplifié

Observez la méthode `DrawAllSnails` :

```csharp
// Avant : il fallait passer toutes les données en paramètres
Snail.Draw(SnailX[i], SnailY[i], SnailColors[i]);

// Après : l'escargot sait tout de lui-même
snail.Draw();
```

Le `foreach` est possible car chaque `Snail` est un objet complet.

### Ajouter un 4e escargot ?

C'est trivial — il suffit d'ajouter une ligne dans `Init()` :

```csharp
Snails = new Snail[]
{
    new Snail("Turbo", ConsoleColor.Yellow),
    new Snail("Speedy", ConsoleColor.Cyan),
    new Snail("Flash", ConsoleColor.Magenta),
    new Snail("Rocket", ConsoleColor.Red)       // Nouveau !
};
```

Aucun autre changement nécessaire : `Snails.Length` s'adapte automatiquement, les boucles `foreach` fonctionnent.

Negative
: Avec les tableaux parallèles, ajouter un escargot nécessitait de modifier **5 tableaux** et la variable `NumberOfSnails`. Avec les instances, une seule ligne suffit.

## Étape 5 : Simplifier Program.cs
Duration: 0:15:00

### Objectif

Réécrire la boucle de course dans `Program.cs` en utilisant les instances.

### Nouveau Program.cs

```csharp
using SnailRaceRefactoring.Game;
using SnailRaceRefactoring.Display;

// Initialisation
Console.Clear();
Console.CursorVisible = false;

Race.Init();
Race.DrawTrack();
Race.DrawAllSnails();

SuperConsole.WriteAt(0, 12, "Appuyez sur ENTER pour lancer la course !");
Console.ReadLine();

// Boucle de course
Random random = new Random();
bool raceFinished = false;
Snail? winner = null;

while (!raceFinished)
{
    foreach (Snail snail in Race.Snails)
    {
        // Tenter d'avancer selon l'énergie
        if (random.Next(100) < snail.Energy)
        {
            snail.Erase();
            snail.Move(1, 0);
            snail.Draw();

            snail.ReduceEnergy(random.Next(1, 4));
        }

        // Vérifier si cet escargot a franchi la ligne
        if (snail.X >= Race.FinishX)
        {
            winner = snail;
            raceFinished = true;
            break;
        }
    }

    Race.ShowEnergy();
    Thread.Sleep(100);
}

// Afficher le gagnant
Console.SetCursorPosition(0, 14);
SuperConsole.WriteLineColor($"{winner!.Name} a gagné la course !", winner.Color);
Console.ReadKey();
```

### Comparaison de la boucle de course

**Avant** (tableaux parallèles) :

```csharp
for (int i = 0; i < Race.NumberOfSnails; i++)
{
    if (random.Next(100) < Race.SnailEnergy[i])
    {
        Snail.Clear(Race.SnailX[i], Race.SnailY[i]);
        Race.SnailX[i]++;
        Snail.Draw(Race.SnailX[i], Race.SnailY[i], Race.SnailColors[i]);

        Race.SnailEnergy[i] -= random.Next(1, 4);
        if (Race.SnailEnergy[i] < 10) Race.SnailEnergy[i] = 10;
    }

    if (Race.SnailX[i] >= Race.FinishX)
    {
        winner = i;
        // ...
    }
}
```

**Après** (instances) :

```csharp
foreach (Snail snail in Race.Snails)
{
    if (random.Next(100) < snail.Energy)
    {
        snail.Erase();
        snail.Move(1, 0);
        snail.Draw();

        snail.ReduceEnergy(random.Next(1, 4));
    }

    if (snail.X >= Race.FinishX)
    {
        winner = snail;
        // ...
    }
}
```

### Les gains

| Aspect | Avant | Après |
| :--- | :--- | :--- |
| Variable gagnant | `int winner = -1` (indice) | `Snail? winner = null` (objet) |
| Accès au nom du gagnant | `Race.SnailNames[winner]` | `winner.Name` |
| Boucle | `for (int i = 0; ...)` | `foreach (Snail snail in ...)` |
| Déplacement | 3 lignes avec indices | `snail.Move(1, 0)` |
| Dessin | `Snail.Draw(x, y, color)` (3 params) | `snail.Draw()` (0 param) |

### Tester

Compiler et exécuter. La course doit fonctionner exactement comme avant !

### Structure finale du projet

```
SnailRaceRefactoring/
├── Program.cs                    // Boucle de course simplifiée
├── Game/
│   ├── Race.cs                   // Piste + tableau Snail[]
│   └── Snail.cs                  // Classe instanciable complète
└── Display/
    └── SuperConsole.cs           // Utilitaires console (inchangé)
```

Positive
: Le code est plus court, plus lisible et plus extensible. Chaque escargot est un objet autonome qui sait se dessiner, s'effacer et se déplacer.

## Étape 6 : Comprendre les références
Duration: 0:10:00

### Objectif

Comprendre que les variables d'objet contiennent des **références**, pas des copies — et les conséquences dans le code de la course.

### `null` dans la course

Dans `Program.cs`, on a écrit :

```csharp
Snail? winner = null;
```

Le `?` après `Snail` indique que la variable peut valoir `null` (ne pointer vers aucun objet). Au départ, on ne connaît pas le gagnant, donc `winner` ne pointe vers rien.

À la fin de la course, `winner` pointe vers l'escargot gagnant :

```csharp
winner = snail;  // winner pointe maintenant vers le même objet que snail
```

Et on peut écrire :

```csharp
SuperConsole.WriteLineColor($"{winner!.Name} a gagné !", winner.Color);
```

Le `!` après `winner` dit au compilateur : "je sais que ce n'est pas null ici".

Negative
: Si `winner` est encore `null` à ce moment (aucun escargot n'a gagné), on obtient une `NullReferenceException`. C'est l'erreur la plus fréquente en C# !

### Expérience : deux variables, un seul escargot

Ajouter ce code temporaire dans `Program.cs` après `Race.Init()` pour observer le comportement des références :

```csharp
Snail a = Race.Snails[0];
Snail b = Race.Snails[0];  // a et b pointent vers le MÊME objet

b.X = 99;
Console.WriteLine(a.X);  // Affiche 99 ! (même objet)
```

C'est exactement ce qui se passe dans la boucle de course : quand on écrit `snail.Move(1, 0)` dans le `foreach`, la variable `snail` et `Race.Snails[i]` pointent vers le **même** objet. La modification est visible partout.

### Passer un escargot à une fonction

Créer une fonction utilitaire pour tester :

```csharp
void Boost(Snail s)
{
    s.Energy = 100;
}

// Utilisation
Boost(Race.Snails[0]);  // Remet l'énergie de Turbo à 100
Console.WriteLine(Race.Snails[0].Energy);  // Affiche 100
```

La fonction reçoit une **référence** vers l'escargot : elle modifie l'original, pas une copie. C'est très différent d'un `int` :

```csharp
void DoubleScore(int score)
{
    score = score * 2;  // Modifie une COPIE locale
}

int points = 50;
DoubleScore(points);
Console.WriteLine(points);  // Affiche 50 (inchangé !)
```

### Tableau récapitulatif

| Type | `=` (assignation) | Passage en paramètre | Valeur par défaut |
| :--- | :--- | :--- | :--- |
| `int`, `double`, `bool` | Copie la valeur | Copie (indépendante) | `0`, `false` |
| `Snail`, `string[]`, tout `class` | Copie la référence (même objet) | Référence (même objet) | `null` |

Positive
: C'est pour cela que `foreach (Snail snail in Race.Snails)` fonctionne : `snail` pointe vers le vrai escargot dans le tableau, et `snail.Move()` déplace réellement cet escargot.

## Bonus : Améliorations
Duration: 0:10:00

### 1. Ajouter une vitesse maximale par escargot

Chaque escargot peut avoir une vitesse différente :

```csharp
class Snail
{
    // ... champs existants ...
    public int MaxSpeed;

    public Snail(string name, ConsoleColor color, int maxSpeed = 1)
    {
        // ... initialisations existantes ...
        this.MaxSpeed = maxSpeed;
    }
}
```

Dans `Race.Init()` :

```csharp
Snails = new Snail[]
{
    new Snail("Turbo", ConsoleColor.Yellow, 2),     // Rapide
    new Snail("Speedy", ConsoleColor.Cyan, 1),      // Normal
    new Snail("Flash", ConsoleColor.Magenta, 3)     // Très rapide
};
```

Dans la boucle de course :

```csharp
int step = random.Next(1, snail.MaxSpeed + 1);
snail.Move(step, 0);
```

### 2. Ajouter un symbole personnalisé

Au lieu de `@` pour tous, chaque escargot affiche son propre symbole :

```csharp
class Snail
{
    // ... champs existants ...
    public string Symbol;

    public Snail(string name, ConsoleColor color, string symbol = "@")
    {
        // ...
        this.Symbol = symbol;
    }

    public void Draw()
    {
        SuperConsole.WriteAtColor(this.X, this.Y, this.Symbol, this.Color);
    }

    public void Erase()
    {
        SuperConsole.WriteAtColor(this.X, this.Y, ".", ConsoleColor.DarkGray);
    }
}
```

Utilisation :

```csharp
Snails = new Snail[]
{
    new Snail("Turbo", ConsoleColor.Yellow) { Symbol = "🐌" },
    new Snail("Speedy", ConsoleColor.Cyan) { Symbol = "🐢" },
    new Snail("Flash", ConsoleColor.Magenta) { Symbol = "🐇" }
};
```

### 3. Méthode ToString()

Ajouter une méthode pour afficher les infos de l'escargot :

```csharp
public override string ToString()
{
    return $"{this.Name} (x={this.X}, y={this.Y}, energy={this.Energy})";
}
```

Utilisation :

```csharp
Console.WriteLine(turbo);  // Affiche : Turbo (x=5, y=2, energy=87)
```

### 4. Plusieurs courses

Puisque `Race` reste statique pour l'instant, essayer de lancer **plusieurs courses** successives en réinitialisant avec `Race.Init()`. Observer que les escargots sont recréés à chaque fois.

## Synthèse
Duration: 0:03:00

### Récapitulatif de la transformation

| Aspect | Classes statiques | Instances |
| :--- | :--- | :--- |
| Données escargot | 5 tableaux parallèles | Champs dans chaque objet `Snail` |
| Création | Remplir 5 tableaux à l'indice `i` | `new Snail("Turbo", ConsoleColor.Yellow)` |
| Accès | `Race.SnailNames[i]` | `snail.Name` |
| Dessin | `Snail.Draw(x, y, color)` | `snail.Draw()` |
| Ajout d'un escargot | Modifier 5 tableaux + `NumberOfSnails` | Ajouter un `new Snail(...)` |
| Ajout d'un champ | Créer un 6e tableau | Ajouter un champ à la classe |
| Boucle | `for` avec indices | `foreach` sur les objets |

### Concepts clés

1. **`class`** (sans `static`) = modèle pour créer des objets
2. **`new`** = créer une instance avec ses propres données
3. **Constructeur** = initialiser l'objet à la création
4. **`this`** = désigne l'instance courante
5. **Méthodes d'instance** = agissent sur les données de leur objet
6. **Tableau d'objets** = remplace les tableaux parallèles

### Spoiler : encapsulation

Pour l'instant, tous les champs de `Snail` sont `public` : n'importe quel code peut écrire `snail.Energy = 9999`. La prochaine étape introduira `private` et les **propriétés** pour protéger les données.

Positive
: Félicitations ! Vous avez réalisé la transformation fondamentale de la POO. Chaque escargot est un objet autonome qui transporte ses données et son comportement. Le code est plus court, plus lisible et plus extensible.

Survey
: Quel aspect de la transformation vous a le plus convaincu ?
<ul>
<li>La simplification de la boucle de course (foreach + méthodes)</li>
<li>La facilité d'ajouter un escargot</li>
<li>Le fait que Draw() n'a plus besoin de paramètres</li>
<li>Le remplacement de 5 tableaux par 1 seul</li>
</ul>

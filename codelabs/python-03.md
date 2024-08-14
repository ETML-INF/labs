author: Jonathan Melly
summary: python tuto
id: python-03
categories: python,dev
tags: ict
environments: Web
status: Published
feedback link: https://git.section-inf.ch/jmy/labs/issues
analytics account: UA-170792591-1

# Snake


## Contexte
Duration: 0:1:00

Le second programme consistera à une version simplifiée du célèbre jeu "snake"

![Alt text](assets/python/Snake_can_be_completed.gif)

## Point de départ
Duration: 0:10:00

Créer un nouveau script Python et lui ajouter le contenu suivant:

```python
import term
import cursor
import time


def init():
    # Initialise le terminal en 0,0
    term.clear()
    term.homePos()
    cursor.hide()


def game():
    title()


def title():
    # Faire clignoter le titre
    for i in range(10):
        term.write('Snake'.center(40, ' '))
        time.sleep(0.4)
        term.clearLine()
        time.sleep(0.3)
        term.pos(0, 0)


try:
    init()
    game()

finally:
    # Remettre le curseur
    cursor.show()

```

### Tester
Vérifier que le programme affiche bien un titre qui clignote.

### Théorie




## Synthèse
Duration: 0:01:00

Normalement écrire un programme en Python est relativement confortable quand on a l’habitude du C# et cette entrée en matière permet de se familiariser avec cette syntaxe.
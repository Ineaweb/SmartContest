# Construire une compétition

Avec SmartContest, vous pouvez organiser votre concours comme vous le souhaitez. Poules, Qualification, Repechage, Eliminatoire. Tout ou presque est possible. 

## Introduction

Le designer de compétition permet de construire son concours à sa guise.
Il permet de définir le processus du concours avec les poules, les phases de qualification et d'éliminatoire.
Il permet de définir les règles de chaque phase.

## Comment y accéder

1. Créer ou ouvrir une compétition.
2. Cliquer sur **Détails de la compétition**
 ![detail de la compétition](img/design-competition/1.jpg)

## Démarrage rapide

Avant toute chose, pour que votre concours fonctionne, il faut une phase d'enregistrement des équipes.

### Ajout d'une phase d'enregistrement

1. Réalisez un glisser-déposer de l'icon ![icon phase d'enregistrement](img/design-competition/2.jpg) sur la zone centrale.
2. Renseigner le nom de cette phase dans la popin puis cliquer sur **Enregistrer**.
 ![phase d'enregistrement](img/design-competition/3.jpg)

### Ajout d'une phase de qualification ou d'éliminatoire

1. Pour ajouter une phase de qualification, réalisez un glisser-déposer de l'icon ![icon phase de qualification](img/design-competition/4.jpg) sur la zone centrale.
 Vous pouvez aussi ajouter une phase d'éliminatoire en realisant un glisser-déposer de l'icon ![icon phase éliminatoire](img/design-competition/5.jpg) sur la zone centrale.
 ![phase de qualification](img/design-competition/6.jpg)

### Ajout d'un module de liaison

1. Pour permettre aux équipes de passer de la phase d'enregistrement à la phase de qualification, il vous faut ajouter un module de liaison en réalisant un glisser-déposer de l'icon ![icon module de liaison](img/design-competition/7.jpg) sur la zone centrale.  
 ![module de liaison](img/design-competition/8.jpg)
2. Avec la souris, cliquez sur une ancre de la phase d'enregistrement et maintenir enfoncé jusqu'à l'ancre du module de liaison.  
 ![lien module de laison](img/design-competition/9.jpg)
3. Reproduisez, pour lié le module de liaison et la phase de qualification.
 ![lien module de liaison](img/design-competition/10.jpg)
4. Définisez les règles pour passer d'une phase à l'autre en cliquant sur l'icon ![icon règles](img/design-competition/11.jpg) du module de liaison. Une popin s'ouvre.  
 ![popin règles](img/design-competition/12.jpg)
5. Cliquez sur **Ajouter une règle**. Une nouvelle popin s'ouvre.  
 ![popin règle](img/design-competition/13.jpg)
6. Remplissez les champs **Type de sélection**, **Source** et **Destination**. Vous pouvez définir aussi le **Nombre d'équipe à prendre** et le **Nombre d'équipe à passer**.  
 ![popin règle](img/design-competition/14.jpg)
7. Cliquez sur **Enregistrer**. La popin se referme et la nouvelle règles s'affiche dans la liste des règles du module de liaison.  
 ![popin règles](img/design-competition/15.jpg)
8. Cliquez sur **Fermer**.

### Configurer une phase de qualification

1. Cliquez sur l'icon ![icon édition](img/design-competition/16.jpg) de la phase de Qualification. Une popin s'ouvre.
 ![popin édition phase de qualification](img/design-competition/17.jpg)
2. Remplissez les champs **Nom de la phase**, **Jouer contre chaque équipe**, **Nombre de tour** et **Publier le classement**.
3. Cliquez sur **Enregistrer**.
4. Cliquez ensuite sur l'icon ![icon règles](img/design-competition/11.jpg). Une nouvelle popin s'ouvre.  
 ![popin règles de classement](img/design-competition/18.jpg)
5. Sur cette popin, vous définissez les règles de classement des équipe dans votre phase. Vous pouvez avoir jusqu'à 4 règles de trie consécutives.  
 En cochant la case **Cumuler le classement avec la précédente phase** Vous prenez en compte (additionné) le nombre de victoire les points pour et contres de la phase précédente pour déterminer le classement de la phase.
 Vous pouvez définir de ne prendre en compte que les X meilleur matchs de chaque équipe pour le classement en cochant la case **Classer sur les meilleurs matchs**.  
 ![popin règles de classement](img/design-competition/19.jpg)
6. Cliquez sur **Enregistrer**. Une nouvelle popin s'ouvre.  
 ![popin règles des matchs](img/design-competition/20.jpg)
7. Sur cet écran, vous définissez les règles des matchs. Remplissez les différents champs.
 ![popin règles des matchs](img/design-competition/21.jpg)
8. Cliquez sur **Enregistrer**.

### Tester le design de la compétition

1. cliquez sur **Tester la compétition**.  
 ![bouton tester la compétition](img/design-competition/22.jpg)
2. Attendez la fin du traitement. Une popin s'ouvre alors et vous informe si votre design de concours est valide ou pas. Vous avez une indication sur le nombre maximum et minimum géré par votre design de concours.
 ![resultat du test de la compétition](img/design-competition/23.jpg)  
  Vous pouvez aussi vérifier les résultat de la simulation sur chacune des phases en cliquant sur l'icon ![icon resultat du test sur la phase](img/design-competition/24.jpg). Une popin s'ouvre et affiche les informations sur le **Nombre d'équipes**, le **Nombre de terrains** et le **Nombre de matchs** nécessaire.  
  ![resultat du test de la compétition](img/design-competition/25.jpg)

## Les Phases

Il existe 3 type de phases :
+ **Les phases d'enregistrement**  
 Les phases d'enregistrement permettent de définir un point d'entrée à votre concours. C'est d'une phase d'enregistrement que les équipes inscrites vont commencer votre concours. Il est donc nécessaire d'avoir une phase d'enreigrement dans le design de votre concours pour que celui-ci fonctionne.  
+ **Les phases de qualification**  
 Les phases de qualification permettent de faire jouer des équipes entre elles dans cette phases. Elle fonctionne par nombre de tour. Ainsi, si votre phases est configuré pour 3 tour. Chaque équipe à l'intérieur de cette phase jouera 3 matchs. C'est le principe de la poule!
+ **Les phases éliminatoire**  
 Les phases éliminatoire permettent de procéder à l'élimination des équipes avec le principe de quart, demi et finale. Les phases éliminatoires doivent avoir obligatoirement un nombre d'équipes bien précis. A savoir : 64, 32, 16, 8, 4 ou 2 équipes.

### Phase d'enregistrement

### Phase de qualification

### Phase éliminatoire
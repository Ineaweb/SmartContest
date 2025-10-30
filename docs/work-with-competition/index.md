# Gestion d'une compétition

Cette section de la documentation vous guide à travers les différentes étapes de la gestion de votre compétition à l'aide de SmartContest. Vous y trouverez des instructions détaillées sur la configuration, la gestion des participants, la planification des épreuves, et bien plus encore.

Dans smartcontest, une compétition se déroule selon le flux suivant :

```mermaid
flowchart TB
    A[Activation] --> B
    B[Enregistrement des participants] --> C
    C[Création des zones de compétition] --> D
    D[Affectation des équipes] --> E
    subgraph sb1 [Gestion d'une phase]
        E[Tirage au sort] --> F
        F[Lancer les matchs] --> G
        G[Saisie des résultats] --> I
        I[Procéder au classement]
    end
    sb1 --> J{Autre phase ?}
    J -- Oui --> D
    J -- Non --> K[Clôture de la compétition]
```

## Sections disponibles

- [Configuration générale](general-configuration.md)
- [Gérer les zones](manage-area.md)
- [Gérer les participants](manage-participant.md)
- [Gérer les matchs](manage-contest.md)
- [Concevoir une compétition](design-competition.md)

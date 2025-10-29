# Documentation SmartContest - Format Markdown

Cette documentation a été convertie du format RST (reStructuredText) vers Markdown pour une meilleure lisibilité et une maintenance plus simple.

## Structure de la documentation

```text
docs/
├── index.md                          # Page d'accueil
├── create-account.md                 # Création de compte
├── buy-credit.md                     # Achat de crédits
├── create-competition.md             # Création d'une compétition
├── work-with-competition/
│   ├── index.md                      # Index des guides de gestion
│   ├── manage-participant.md         # Gestion des participants
│   ├── manage-area.md               # Gestion des zones
│   ├── general-configuration.md      # Configuration générale
│   └── design-competition.md         # Conception de compétition
├── mkdocs.yml                       # Configuration MkDocs
└── img/                             # Images de la documentation
```

## Génération de la documentation

### Avec MkDocs (recommandé)

1. Installez MkDocs et le thème Material :

   ```bash
   pip install mkdocs mkdocs-material
   ```

2. Générez la documentation :

   ```bash
   cd docs
   mkdocs serve
   ```

3. La documentation sera accessible sur <http://127.0.0.1:8000>

### Pour la production

```bash
mkdocs build
```

La documentation sera générée dans le dossier `site/`.

## Améliorations apportées lors de la conversion

### Format et syntaxe

- ✅ Conversion des titres RST (`===`) vers Markdown (`#`)
- ✅ Conversion des listes RST vers Markdown
- ✅ Conversion des images RST (`.. image::`) vers Markdown (`![alt](url)`)
- ✅ Conversion des liens RST (`:doc:`) vers Markdown (`[text](url)`)
- ✅ Conversion des notes RST (`.. note::`) vers blockquotes Markdown (`>`)

### Corrections linguistiques

- ✅ Correction des fautes d'orthographe
- ✅ Amélioration de la grammaire
- ✅ Harmonisation de la terminologie
- ✅ Correction de la ponctuation

### Structure et navigation

- ✅ Création d'une navigation claire avec MkDocs
- ✅ Organisation logique des sections
- ✅ Liens internes corrigés
- ✅ Table des matières automatique

## Outils de validation

La documentation Markdown est validée avec :

- Markdownlint pour la syntaxe
- Vérification des liens internes
- Validation des images

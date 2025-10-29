# Script PowerShell pour compiler la documentation SmartContest
# avec un style moderne inspiré du site www.smartcontest.fr
# Usage: .\build-docs.ps1 [serve|build|deploy]

param(
    [string]$Action = "serve",
    [string]$Port = "8000"
)

$DocsPath = $PSScriptRoot
$BuildPath = Join-Path $DocsPath "site"
$ThemePath = Join-Path $DocsPath "theme"

Write-Host "🚀 SmartContest Documentation Builder" -ForegroundColor Green
Write-Host "📁 Répertoire: $DocsPath" -ForegroundColor Cyan
Write-Host "🎨 Thème personnalisé: SmartContest Style" -ForegroundColor Magenta

# Fonction pour vérifier les dépendances
function Test-Dependencies {
    Write-Host "🔍 Vérification des dépendances..." -ForegroundColor Yellow
    
    try {
        $mkdocsVersion = mkdocs --version
        Write-Host "✅ MkDocs: $mkdocsVersion" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ MkDocs non trouvé. Installation..." -ForegroundColor Red
        pip install mkdocs mkdocs-material mkdocs-awesome-pages-plugin
        Write-Host "✅ MkDocs installé" -ForegroundColor Green
    }
    
    try {
        python --version | Out-Null
        Write-Host "✅ Python détecté" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Python requis. Veuillez installer Python 3.8+" -ForegroundColor Red
        exit 1
    }
}

# Fonction pour mettre à jour la configuration MkDocs
function Update-MkDocsConfig {
    Write-Host "📝 Mise à jour de la configuration MkDocs..." -ForegroundColor Yellow
    
    $configPath = Join-Path $DocsPath "mkdocs.yml"
    
    # Sauvegarde de la config actuelle
    if (Test-Path $configPath) {
        Copy-Item $configPath "$configPath.backup" -Force
    }
    
    # Configuration complète avec thème personnalisé
    $config = @"
site_name: Documentation SmartContest
site_description: Documentation utilisateur de SmartContest - Solution complète pour organiser vos tournois et concours
site_author: Ineaweb
site_url: https://smartcontest.fr
copyright: '© 2025 SmartContest - Ineaweb. Tous droits réservés.'

# Repository
repo_name: Ineaweb/SmartContest
repo_url: https://github.com/Ineaweb/SmartContest
edit_uri: edit/master/docs/

# Configuration
theme:
  name: material
  language: fr
  logo: https://www.smartcontest.fr/images/smartcontest/logo-white.svg
  favicon: https://www.smartcontest.fr/favicon.ico
  
  palette:
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: blue
      accent: green
      toggle:
        icon: material/brightness-7
        name: Passer au mode sombre
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: blue
      accent: green
      toggle:
        icon: material/brightness-4
        name: Passer au mode clair
  
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.top
    - navigation.tracking
    - search.highlight
    - search.share
    - search.suggest
    - content.code.copy
    - content.action.edit
    - toc.follow

  custom_dir: theme/

# CSS personnalisé
extra_css:
  - theme/smartcontest.css

# JavaScript personnalisé
extra_javascript:
  - https://unpkg.com/tablesort@5.3.0/dist/tablesort.min.js

# Navigation
nav:
  - Accueil: index.md
  - Guide utilisateur:
    - Créer un compte: create-account.md
    - Acheter des crédits: buy-credit.md
    - Lier son compte à HelloAsso: link-helloasso.md
    - Créer une compétition: create-competition.md
    - Gestion d'une compétition:
      - work-with-competition/index.md
      - Configuration générale: work-with-competition/general-configuration.md
      - Gérer les aires de compétition: work-with-competition/manage-area.md
      - Gérer les participants: work-with-competition/manage-participant.md
      - Concevoir une compétition: work-with-competition/design-competition.md

# Extensions Markdown
markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.highlight:
      anchor_linenums: true
      line_spans: __span
      pygments_lang_class: true
  - pymdownx.inlinehilite
  - pymdownx.snippets
  - pymdownx.tabbed:
      alternate_style: true
  - attr_list
  - md_in_html
  - tables
  - footnotes
  - pymdownx.critic
  - pymdownx.caret
  - pymdownx.keys
  - pymdownx.mark
  - pymdownx.tilde
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
  - def_list
  - pymdownx.tasklist:
      custom_checkbox: true

# Plugins
plugins:
  - search:
      lang: fr
  - minify:
      minify_html: true
      htmlmin_opts:
        remove_comments: true
  - git-revision-date-localized:
      enable_creation_date: true
      type: datetime
      locale: fr

# Extra
extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/Ineaweb/SmartContest
    - icon: fontawesome/solid/globe
      link: https://www.smartcontest.fr
    - icon: fontawesome/solid/envelope
      link: mailto:contact@ineaweb.net
  
  analytics:
    feedback:
      title: Cette page vous a-t-elle été utile ?
      ratings:
        - icon: material/emoticon-happy-outline
          name: Cette page m'a été utile
          data: 1
          note: >-
            Merci pour votre retour ! Aidez-nous à améliorer cette page en
            <a href="https://github.com/Ineaweb/SmartContest/issues/new/?title=[Feedback]+{title}+-+{url}" target="_blank" rel="noopener">nous signalant ce qui pourrait être amélioré</a>.
        - icon: material/emoticon-sad-outline
          name: Cette page pourrait être améliorée
          data: 0
          note: >- 
            Merci pour votre retour ! Aidez-nous à améliorer cette page en
            <a href="https://github.com/Ineaweb/SmartContest/issues/new/?title=[Feedback]+{title}+-+{url}" target="_blank" rel="noopener">nous signalant ce qui ne va pas</a>.

# Validation
strict: false
"@
    
    Set-Content -Path $configPath -Value $config -Encoding UTF8
    Write-Host "✅ Configuration MkDocs mise à jour" -ForegroundColor Green
}

# Fonction pour créer les templates personnalisés
function New-CustomTemplates {
    Write-Host "🎨 Création des templates personnalisés..." -ForegroundColor Yellow
    
    $templatesDir = Join-Path $ThemePath "partials"
    New-Item -ItemType Directory -Path $templatesDir -Force | Out-Null
    
    # Header personnalisé
    $headerTemplate = @"
<header class="md-header" data-md-component="header">
  <nav class="md-header__inner md-grid" aria-label="En-tête">
    <a href="{{ config.site_url | default(nav.homepage.url, true) | url }}" 
       title="{{ config.site_name }}" 
       class="md-header__button md-logo" 
       aria-label="{{ config.site_name }}" 
       data-md-component="logo">
      <img src="https://www.smartcontest.fr/images/smartcontest/logo-white.svg" 
           alt="SmartContest Logo" 
           style="height: 32px;">
    </a>
    <label class="md-header__button md-icon" for="__drawer">
      {% include ".icons/material/menu.svg" %}
    </label>
    <div class="md-header__title" data-md-component="header-title">
      <div class="md-header__ellipsis">
        <div class="md-header__topic">
          <span class="md-ellipsis">
            {{ config.site_name }}
          </span>
        </div>
        <div class="md-header__topic" data-md-component="header-topic">
          <span class="md-ellipsis">
            {% if page.title and not page.is_homepage %}
              {{ page.title }}
            {% else %}
              {{ config.site_name }}
            {% endif %}
          </span>
        </div>
      </div>
    </div>
    {% if config.repo_url %}
      <div class="md-header__option">
        <div class="md-select">
          <button class="md-select__inner md-icon" aria-label="Dépôt">
            {% include ".icons/material/git.svg" %}
          </button>
        </div>
      </div>
    {% endif %}
    <label class="md-header__button md-icon" for="__search">
      {% include ".icons/material/magnify.svg" %}
    </label>
    {% include "partials/search.html" %}
  </nav>
</header>
"@
    
    Set-Content -Path (Join-Path $templatesDir "header.html") -Value $headerTemplate -Encoding UTF8
    
    Write-Host "✅ Templates personnalisés créés" -ForegroundColor Green
}

# Fonction principale de construction
function Build-Documentation {
    param([string]$BuildAction)
    
    Test-Dependencies
    Update-MkDocsConfig
    New-CustomTemplates
    
    Set-Location $DocsPath
    
    switch ($BuildAction.ToLower()) {
        "serve" {
            Write-Host "🌐 Démarrage du serveur de développement..." -ForegroundColor Yellow
            Write-Host "📍 URL: http://localhost:$Port" -ForegroundColor Cyan
            Write-Host "⏹️  Arrêt: Ctrl+C" -ForegroundColor Gray
            
            mkdocs serve --dev-addr "localhost:$Port"
        }
        
        "build" {
            Write-Host "🔨 Construction de la documentation..." -ForegroundColor Yellow
            
            # Nettoyage du dossier de build
            if (Test-Path $BuildPath) {
                Remove-Item $BuildPath -Recurse -Force
                Write-Host "🧹 Dossier de build nettoyé" -ForegroundColor Gray
            }
            
            mkdocs build --clean --strict
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Documentation construite avec succès !" -ForegroundColor Green
                Write-Host "📁 Sortie: $BuildPath" -ForegroundColor Cyan
                
                # Statistiques du build
                $files = Get-ChildItem -Path $BuildPath -Recurse -File
                $totalSize = ($files | Measure-Object -Property Length -Sum).Sum
                $sizeInMB = [math]::Round($totalSize / 1MB, 2)
                
                Write-Host "📊 Statistiques:" -ForegroundColor Yellow
                Write-Host "   - Fichiers: $($files.Count)" -ForegroundColor Gray
                Write-Host "   - Taille: $sizeInMB MB" -ForegroundColor Gray
            } else {
                Write-Host "❌ Erreur lors de la construction" -ForegroundColor Red
                exit 1
            }
        }
        
        "deploy" {
            Write-Host "🚀 Déploiement de la documentation..." -ForegroundColor Yellow
            
            # Build d'abord
            mkdocs build --clean --strict
            
            if ($LASTEXITCODE -eq 0) {
                # Déploiement sur GitHub Pages (si configuré)
                mkdocs gh-deploy --clean
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "✅ Documentation déployée avec succès !" -ForegroundColor Green
                    Write-Host "🌐 Disponible sur GitHub Pages" -ForegroundColor Cyan
                } else {
                    Write-Host "❌ Erreur lors du déploiement" -ForegroundColor Red
                    exit 1
                }
            }
        }
        
        "clean" {
            Write-Host "🧹 Nettoyage des fichiers temporaires..." -ForegroundColor Yellow
            
            $pathsToClean = @($BuildPath, "$DocsPath\.mkdocs_cache")
            
            foreach ($path in $pathsToClean) {
                if (Test-Path $path) {
                    Remove-Item $path -Recurse -Force
                    Write-Host "🗑️  Supprimé: $path" -ForegroundColor Gray
                }
            }
            
            Write-Host "✅ Nettoyage terminé" -ForegroundColor Green
        }
        
        "validate" {
            Write-Host "🔍 Validation de la documentation..." -ForegroundColor Yellow
            
            # Vérification des liens internes
            $markdownFiles = Get-ChildItem -Path $DocsPath -Filter "*.md" -Recurse
            $brokenLinks = @()
            
            foreach ($file in $markdownFiles) {
                $content = Get-Content $file.FullName -Raw
                $links = [regex]::Matches($content, '\[([^\]]+)\]\(([^)]+)\.md\)')
                
                foreach ($link in $links) {
                    $linkedFile = $link.Groups[2].Value
                    $fullPath = Join-Path (Split-Path $file.FullName) ($linkedFile + ".md")
                    
                    if (!(Test-Path $fullPath)) {
                        $brokenLinks += "$($file.Name): $linkedFile"
                    }
                }
            }
            
            if ($brokenLinks.Count -gt 0) {
                Write-Host "⚠️  Liens internes brisés détectés:" -ForegroundColor Yellow
                $brokenLinks | ForEach-Object { Write-Host "   - $_" -ForegroundColor Red }
            } else {
                Write-Host "✅ Tous les liens internes sont valides" -ForegroundColor Green
            }
            
            # Vérification des images
            $missingImages = @()
            foreach ($file in $markdownFiles) {
                $content = Get-Content $file.FullName -Raw
                $images = [regex]::Matches($content, '!\[[^\]]*\]\(([^)]+)\)')
                
                foreach ($image in $images) {
                    $imagePath = $image.Groups[1].Value
                    if (!$imagePath.StartsWith("http")) {
                        $fullImagePath = Join-Path (Split-Path $file.FullName) $imagePath
                        
                        if (!(Test-Path $fullImagePath)) {
                            $missingImages += "$($file.Name): $imagePath"
                        }
                    }
                }
            }
            
            if ($missingImages.Count -gt 0) {
                Write-Host "⚠️  Images manquantes détectées:" -ForegroundColor Yellow
                $missingImages | ForEach-Object { Write-Host "   - $_" -ForegroundColor Red }
            } else {
                Write-Host "✅ Toutes les images sont présentes" -ForegroundColor Green
            }
            
            Write-Host "📄 Fichiers Markdown: $($markdownFiles.Count)" -ForegroundColor Cyan
        }
        
        default {
            Write-Host "❌ Action non reconnue: $BuildAction" -ForegroundColor Red
            Write-Host "Actions disponibles:" -ForegroundColor Yellow
            Write-Host "  - serve    : Démarre le serveur de développement" -ForegroundColor Gray
            Write-Host "  - build    : Construit la documentation" -ForegroundColor Gray
            Write-Host "  - deploy   : Déploie sur GitHub Pages" -ForegroundColor Gray
            Write-Host "  - clean    : Nettoie les fichiers temporaires" -ForegroundColor Gray
            Write-Host "  - validate : Valide les liens et images" -ForegroundColor Gray
            exit 1
        }
    }
}

# Gestion des erreurs
trap {
    Write-Host "💥 Erreur inattendue: $_" -ForegroundColor Red
    exit 1
}

# Exécution
try {
    Build-Documentation -BuildAction $Action
    Write-Host "🎉 Opération terminée avec succès !" -ForegroundColor Green
}
catch {
    Write-Host "💥 Erreur: $_" -ForegroundColor Red
    exit 1
}

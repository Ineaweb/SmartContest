#!/usr/bin/env pwsh
# Script pour tester différents thèmes MkDocs compatibles avec SmartContest
# Usage: .\test-theme.ps1 -Theme "windmill|cerulean|cinder|material"

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("material", "windmill", "cerulean", "cinder", "mkdocs")]
    [string]$Theme,
    
    [Parameter(Mandatory=$false)]
    [switch]$Install,
    
    [Parameter(Mandatory=$false)]
    [switch]$Restore,
    
    [Parameter(Mandatory=$false)]
    [switch]$Serve
)

$ConfigBackup = "mkdocs.yml.backup"
$ThemeBackup = "docs/theme.backup"

function Show-Help {
    Write-Host "🎨 Testeur de Thèmes MkDocs pour SmartContest" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host "  .\test-theme.ps1 -Theme <theme_name> [-Install] [-Serve]" -ForegroundColor White
    Write-Host ""
    Write-Host "Thèmes disponibles:" -ForegroundColor Yellow
    Write-Host "  material  - Material for MkDocs (actuel)" -ForegroundColor Green
    Write-Host "  windmill  - MkDocs Windmill (recommandé)" -ForegroundColor Blue  
    Write-Host "  cerulean  - Bootstrap Cerulean (bleu SmartContest)" -ForegroundColor Blue
    Write-Host "  cinder    - MkDocs Cinder (moderne)" -ForegroundColor Magenta
    Write-Host "  mkdocs    - Thème par défaut MkDocs" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "  -Install  Installer les dépendances du thème" -ForegroundColor White
    Write-Host "  -Serve    Démarrer le serveur après changement" -ForegroundColor White
    Write-Host "  -Restore  Restaurer la configuration originale" -ForegroundColor Red
    Write-Host ""
    Write-Host "Exemples:" -ForegroundColor Yellow
    Write-Host "  .\test-theme.ps1 -Theme windmill -Install -Serve" -ForegroundColor White
    Write-Host "  .\test-theme.ps1 -Restore" -ForegroundColor Red
}

function Backup-Config {
    if (-not (Test-Path $ConfigBackup)) {
        Write-Host "📂 Sauvegarde de la configuration actuelle..." -ForegroundColor Yellow
        Copy-Item "mkdocs.yml" $ConfigBackup -Force
        
        if (Test-Path "docs/theme") {
            Copy-Item "docs/theme" $ThemeBackup -Recurse -Force
            Write-Host "✅ Configuration et thème sauvegardés" -ForegroundColor Green
        }
    }
}

function Restore-Config {
    Write-Host "🔄 Restauration de la configuration originale..." -ForegroundColor Yellow
    
    if (Test-Path $ConfigBackup) {
        Copy-Item $ConfigBackup "mkdocs.yml" -Force
        Write-Host "✅ mkdocs.yml restauré" -ForegroundColor Green
    }
    
    if (Test-Path $ThemeBackup) {
        Remove-Item "docs/theme" -Recurse -Force -ErrorAction SilentlyContinue
        Copy-Item $ThemeBackup "docs/theme" -Recurse -Force
        Write-Host "✅ Thème personnalisé restauré" -ForegroundColor Green
    }
    
    Write-Host "🎉 Configuration originale Material + SmartContest CSS restaurée !" -ForegroundColor Cyan
    return
}

function Install-Theme {
    param([string]$ThemeName)
    
    Write-Host "📦 Installation des dépendances pour $ThemeName..." -ForegroundColor Yellow
    
    switch ($ThemeName) {
        "windmill" {
            pip install mkdocs-windmill
        }
        "cerulean" {
            pip install mkdocs-bootswatch
        }
        "cinder" {
            pip install mkdocs-cinder
        }
        "material" {
            pip install mkdocs-material
        }
        "mkdocs" {
            # Thème par défaut, pas d'installation nécessaire
            Write-Host "ℹ️  Thème par défaut MkDocs, aucune installation requise" -ForegroundColor Blue
        }
    }
    
    if ($LASTEXITCODE -eq 0 -and $ThemeName -ne "mkdocs") {
        Write-Host "✅ $ThemeName installé avec succès" -ForegroundColor Green
    }
}

function Set-Theme {
    param([string]$ThemeName)
    
    Write-Host "🎨 Configuration du thème $ThemeName..." -ForegroundColor Yellow
    
    # Lire le fichier mkdocs.yml actuel
    $config = Get-Content "mkdocs.yml" -Raw
    
    # Templates de configuration pour chaque thème
    $themeConfigs = @{
        "material" = @"
theme:
  name: material
  custom_dir: docs/theme/
  language: fr
  palette:
    - scheme: default
      primary: indigo
      accent: green
  features:
    - navigation.tabs
    - navigation.sections
    - search.highlight
    - content.code.copy
"@
        
        "windmill" = @"
theme:
  name: windmill
  # Navigation moderne et couleurs bleues par défaut
"@
        
        "cerulean" = @"
theme:
  name: cerulean
  # Thème Bootstrap bleu similaire à SmartContest
"@
        
        "cinder" = @"
theme:
  name: cinder
  colorscheme: github
  # Design moderne professionnel
"@
        
        "mkdocs" = @"
theme:
  name: mkdocs
  # Thème par défaut MkDocs
"@
    }
    
    # Remplacer la section theme dans mkdocs.yml
    $newConfig = $config -replace '(?s)theme:.*?(?=\n\w|\n$|\Z)', $themeConfigs[$ThemeName]
    
    # Désactiver CSS/JS personnalisés pour les thèmes non-Material
    if ($ThemeName -ne "material") {
        $newConfig = $newConfig -replace '(?s)extra_css:.*?(?=\n\w|\n$|\Z)', '# extra_css: # Désactivé pour test thème'
        $newConfig = $newConfig -replace '(?s)extra_javascript:.*?(?=\n\w|\n$|\Z)', '# extra_javascript: # Désactivé pour test thème'
    }
    
    # Sauvegarder la nouvelle configuration
    $newConfig | Set-Content "mkdocs.yml" -Encoding UTF8
    
    Write-Host "✅ Thème $ThemeName configuré" -ForegroundColor Green
}

function Test-Build {
    Write-Host "🏗️  Test de build avec le nouveau thème..." -ForegroundColor Yellow
    
    $result = mkdocs build 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Build réussi avec le nouveau thème !" -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ Erreur de build:" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
        return $false
    }
}

function Start-Server {
    Write-Host "🚀 Démarrage du serveur de développement..." -ForegroundColor Cyan
    Write-Host "📍 Accès : http://localhost:8000" -ForegroundColor Yellow
    Write-Host "⏹️  Appuyez sur Ctrl+C pour arrêter" -ForegroundColor Yellow
    Write-Host ""
    
    mkdocs serve
}

# ==== SCRIPT PRINCIPAL ====

Clear-Host
Write-Host "🎨 Testeur de Thèmes MkDocs - SmartContest" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Gestion des paramètres
if ($Restore) {
    Restore-Config
    exit 0
}

if ($Theme -eq "help" -or $Theme -eq "") {
    Show-Help
    exit 0
}

# Sauvegarde automatique
Backup-Config

# Installation si demandée
if ($Install) {
    Install-Theme -ThemeName $Theme
    Write-Host ""
}

# Configuration du thème
Set-Theme -ThemeName $Theme

# Test de build
Write-Host ""
if (Test-Build) {
    Write-Host ""
    Write-Host "🎉 Thème $Theme configuré avec succès !" -ForegroundColor Green
    Write-Host ""
    
    # Informations sur le thème
    switch ($Theme) {
        "material" {
            Write-Host "ℹ️  Material for MkDocs - Le plus populaire et personnalisable" -ForegroundColor Blue
            Write-Host "   Fonctionnalités : Search avancée, navigation moderne, modes sombre/clair" -ForegroundColor Gray
        }
        "windmill" {
            Write-Host "ℹ️  Windmill - Design clean avec couleurs bleues par défaut" -ForegroundColor Blue  
            Write-Host "   Très proche du style SmartContest sans personnalisation" -ForegroundColor Gray
        }
        "cerulean" {
            Write-Host "ℹ️  Cerulean (Bootstrap) - Thème bleu professionnel" -ForegroundColor Blue
            Write-Host "   Couleurs similaires à SmartContest, design Bootstrap" -ForegroundColor Gray
        }
        "cinder" {
            Write-Host "ℹ️  Cinder - Design moderne avec syntax highlighting avancé" -ForegroundColor Magenta
            Write-Host "   Navigation top + sidebar, style professionnel" -ForegroundColor Gray
        }
        "mkdocs" {
            Write-Host "ℹ️  MkDocs par défaut - Simple et léger" -ForegroundColor Gray
            Write-Host "   Minimaliste, bon pour débuter" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
    Write-Host "Actions disponibles :" -ForegroundColor Yellow
    Write-Host "  • Consulter : http://localhost:8000 (si serveur démarré)" -ForegroundColor White
    Write-Host "  • Serveur  : .\test-theme.ps1 -Theme $Theme -Serve" -ForegroundColor White  
    Write-Host "  • Restaurer: .\test-theme.ps1 -Restore" -ForegroundColor Red
    Write-Host ""
    
    # Démarrage du serveur si demandé
    if ($Serve) {
        Start-Server
    }
    
} else {
    Write-Host ""
    Write-Host "❌ Échec de configuration du thème $Theme" -ForegroundColor Red
    Write-Host "💡 Essayez d'installer les dépendances : .\test-theme.ps1 -Theme $Theme -Install" -ForegroundColor Yellow
}

Write-Host ""

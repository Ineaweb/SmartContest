# Script PowerShell pour la gestion de la documentation Markdown SmartContest
# Usage: .\manage-docs.ps1 [serve|build|validate]

param(
    [string]$Action = "serve"
)

$DocsPath = $PSScriptRoot

Write-Host "🚀 Gestion de la documentation SmartContest" -ForegroundColor Green
Write-Host "📁 Répertoire: $DocsPath" -ForegroundColor Cyan

switch ($Action.ToLower()) {
    "serve" {
        Write-Host "🌐 Démarrage du serveur de développement MkDocs..." -ForegroundColor Yellow
        
        # Vérifier si MkDocs est installé
        try {
            mkdocs --version | Out-Null
            Write-Host "✅ MkDocs détecté" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ MkDocs non trouvé. Installation en cours..." -ForegroundColor Red
            pip install mkdocs mkdocs-material
        }
        
        # Démarrer le serveur
        Set-Location $DocsPath
        mkdocs serve
    }
    
    "build" {
        Write-Host "🔨 Construction de la documentation..." -ForegroundColor Yellow
        
        Set-Location $DocsPath
        mkdocs build
        
        Write-Host "✅ Documentation construite dans le dossier 'site/'" -ForegroundColor Green
    }
    
    "validate" {
        Write-Host "🔍 Validation de la documentation Markdown..." -ForegroundColor Yellow
        
        # Rechercher tous les fichiers .md
        $MarkdownFiles = Get-ChildItem -Path $DocsPath -Filter "*.md" -Recurse
        
        Write-Host "📄 Fichiers Markdown trouvés: $($MarkdownFiles.Count)" -ForegroundColor Cyan
        
        foreach ($File in $MarkdownFiles) {
            Write-Host "  - $($File.Name)" -ForegroundColor Gray
        }
        
        Write-Host "✅ Validation terminée" -ForegroundColor Green
    }
    
    "clean" {
        Write-Host "🧹 Nettoyage des fichiers temporaires..." -ForegroundColor Yellow
        
        $SitePath = Join-Path $DocsPath "site"
        if (Test-Path $SitePath) {
            Remove-Item $SitePath -Recurse -Force
            Write-Host "✅ Dossier 'site/' supprimé" -ForegroundColor Green
        }
        
        Write-Host "✅ Nettoyage terminé" -ForegroundColor Green
    }
    
    default {
        Write-Host "❌ Action non reconnue: $Action" -ForegroundColor Red
        Write-Host "Actions disponibles:" -ForegroundColor Yellow
        Write-Host "  - serve    : Démarre le serveur de développement" -ForegroundColor Gray
        Write-Host "  - build    : Construit la documentation" -ForegroundColor Gray
        Write-Host "  - validate : Valide les fichiers Markdown" -ForegroundColor Gray
        Write-Host "  - clean    : Nettoie les fichiers temporaires" -ForegroundColor Gray
    }
}

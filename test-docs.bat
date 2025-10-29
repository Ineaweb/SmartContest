@echo off
REM Test rapide du système de documentation SmartContest
echo.
echo ========================================
echo   SmartContest Documentation - Test
echo ========================================
echo.

REM Vérifier que PowerShell est disponible
powershell -Command "Get-Command python" >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Python n'est pas installé ou pas dans le PATH
    echo Veuillez installer Python 3.8+ depuis https://python.org
    pause
    exit /b 1
)

echo [INFO] Python détecté - OK
echo.

REM Vérifier MkDocs
powershell -Command "pip show mkdocs" >nul 2>&1
if errorlevel 1 (
    echo [INFO] MkDocs non installé - Installation automatique...
    echo.
    powershell -ExecutionPolicy Bypass -File "build-docs.ps1" -Action install
    if errorlevel 1 (
        echo [ERREUR] Échec de l'installation des dépendances
        pause
        exit /b 1
    )
) else (
    echo [INFO] MkDocs détecté - OK
)

echo.
echo [SUCCESS] Système prêt !
echo.
echo Actions disponibles :
echo   1. Démarrer le serveur de développement
echo   2. Build de production  
echo   3. Validation de la documentation
echo   4. Quitter
echo.

set /p choice="Votre choix (1-4) : "

if "%choice%"=="1" (
    echo.
    echo [INFO] Démarrage du serveur sur http://localhost:8000...
    echo [INFO] Appuyez sur Ctrl+C pour arrêter
    echo.
    powershell -ExecutionPolicy Bypass -File "build-docs.ps1" -Action serve
) else if "%choice%"=="2" (
    echo.
    echo [INFO] Build de production en cours...
    powershell -ExecutionPolicy Bypass -File "build-docs.ps1" -Action build
    echo.
    echo [SUCCESS] Build terminé ! Fichiers dans le dossier 'site/'
) else if "%choice%"=="3" (
    echo.
    echo [INFO] Validation en cours...
    powershell -ExecutionPolicy Bypass -File "build-docs.ps1" -Action validate
) else if "%choice%"=="4" (
    echo Au revoir !
    exit /b 0
) else (
    echo Choix invalide.
)

echo.
pause

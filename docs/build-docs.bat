@echo off
REM Script batch pour compiler la documentation SmartContest
REM Usage: build-docs.bat [serve|build|deploy|clean|validate]

setlocal enabledelayedexpansion

REM Configuration
set "ACTION=%1"
if "%ACTION%"=="" set "ACTION=serve"
set "PORT=8000"

echo ===============================================
echo   SmartContest Documentation Builder
echo ===============================================
echo.

REM Vérifier si PowerShell est disponible
where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] PowerShell requis mais non trouve
    echo Veuillez installer PowerShell ou utiliser Windows 10+
    pause
    exit /b 1
)

REM Vérifier si Python est disponible
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python requis mais non trouve
    echo Veuillez installer Python 3.8+ depuis https://python.org
    pause
    exit /b 1
)

REM Exécuter le script PowerShell principal
echo [INFO] Execution du script PowerShell...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0build-docs.ps1" -Action "%ACTION%"

if %errorlevel% neq 0 (
    echo [ERROR] Erreur lors de l'execution du script PowerShell
    pause
    exit /b %errorlevel%
)

echo.
echo [SUCCESS] Operation terminee avec succes !

REM Si c'est serve, garder la fenêtre ouverte
if "%ACTION%"=="serve" (
    echo.
    echo Appuyez sur une touche pour fermer...
    pause >nul
)

endlocal

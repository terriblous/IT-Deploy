@echo off
:: Force le terminal à rester dans le dossier où se trouve ce fichier .bat
cd /d "%~dp0"

echo [+] Lancement du module de maintenance...
echo [+] Emplacement : %~dp0
echo.

:: Lancement de PowerShell avec NoExit et Bypass
powershell.exe -NoExit -ExecutionPolicy Bypass -File "It-Deploy.ps1"

echo.
echo [+] Le processus batch est arrive a la fin de la commande powershell.
echo [+] Si la fenetre se ferme apres cette ligne, verifiez le contenu du .ps1.
pause

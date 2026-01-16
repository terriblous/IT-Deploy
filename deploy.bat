@echo off
echo [+] Lancement du module de maintenance...
:: -NoExit empeche la fermeture de la console apres l'execution
powershell.exe -NoExit -ExecutionPolicy Bypass -File "shell.ps1"
echo.
echo [+] Le processus batch est termine.
pause

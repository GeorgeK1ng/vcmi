; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Paramètres propres à l'installation VCMI :%n  /USERDATADIR=<chemin>  Définit le dossier des données utilisateur VCMI. Le préfixe expand: développe les constantes Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Installe l'application et les données ensemble sans programme de désinstallation, registre, raccourcis, associations ni règles de pare-feu.%n  /LAUNCH  Lance VCMI après l'installation, y compris en mode silencieux.%n%nParamètre du programme de désinstallation VCMI :%n  /DELETEUSERDATA=1  Supprime tous les dossiers utilisateur VCMI configurés. Pris en compte uniquement avec /SILENT ou /VERYSILENT. Cette action est irréversible.%n%nLes paramètres standard comme /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART et /LOG sont décrits ci-dessus.
WindowsVersionNotSupported=Ce programme ne peut pas s'exécuter sur votre version de Windows. Veuillez vous assurer d'utiliser l'architecture Windows correcte (32 bits ou 64 bits) et la version adaptée de ce programme.
PrivilegesRequiredOverrideTitle=Mode d'installation – Autorisations
PrivilegesRequiredOverrideInstruction=Choisissez comment exécuter le programme d'installation
PrivilegesRequiredOverrideText1=%1 nécessite des privilèges administrateur pour être installé pour tous les utilisateurs.%nVous pouvez également l'installer uniquement pour votre compte sans privilèges administrateur.
PrivilegesRequiredOverrideText2=%1 peut être installé uniquement pour votre compte (sans privilèges administrateur), ou pour tous les utilisateurs (nécessite des privilèges administrateur).
PrivilegesRequiredOverrideAllUsers=Exécuter en tant qu’&administrateur (installation pour tous les utilisateurs)
PrivilegesRequiredOverrideAllUsersRecommended=Exécuter en tant qu’&administrateur (recommandé)
PrivilegesRequiredOverrideCurrentUser=Exécuter en tant qu’&utilisateur standard (installation uniquement pour moi)
PrivilegesRequiredOverrideCurrentUserRecommended=Exécuter en tant qu’&utilisateur standard (recommandé)
ConfirmUninstall=Êtes-vous sûr de vouloir exécuter l'assistant de désinstallation %1 ?

[CustomMessages]
AddFirewallRules=Ajouter des règles de pare-feu pour VCMI
AssociateH3MFiles=Associer les fichiers .h3m avec l'éditeur de cartes VCMI
AssociateVCMIMapFiles=Associer les fichiers .vmap et .vcmp avec l'éditeur de cartes VCMI
CacheDirectory=Cache
CloudDataNotice=Ce dossier de données utilisateur semble être synchronisé par un service de stockage cloud.
CloudDataWarning=Le dossier de données utilisateur sélectionné semble être synchronisé par un service de stockage cloud. La synchronisation peut verrouiller temporairement des fichiers et provoquer l'échec de l'installation de mods, du lancement du jeu ou des sauvegardes.%n%nVoulez-vous quand même utiliser ce dossier ?
CloudInstallNotice=Ce dossier d'installation semble être synchronisé par un service de stockage cloud.
CloudInstallWarning=Le dossier d'installation sélectionné semble être synchronisé par un service de stockage cloud. Une installation portable ou synchronisée peut échouer si le service verrouille temporairement des fichiers de l'application.%n%nVoulez-vous quand même utiliser ce dossier ?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Configuration
CopyH3Files=Copier automatiquement les fichiers nécessaires de Heroes III vers VCMI
CreateDesktopShortcuts=Créer des raccourcis sur le bureau
CreateStartMenuShortcuts=Créer des raccourcis dans le menu Démarrer
DataFolderDescription=Contient une copie des données Heroes III fournies, les modifications, les cartes, les sauvegardes et les autres fichiers utilisateur.
DataFolderTitle=Dossier des données utilisateur
DeleteUserData=Supprimer les données utilisateur
DeleteUserDataDescription=Sélectionnez les dossiers à supprimer définitivement. Les dossiers non cochés seront conservés. Cette action est irréversible.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Fichier de carte Heroes 3
InstallFolderTitle=Dossier d'installation
InstallForAllUsers=Installer pour tous les utilisateurs
InstallForAllUsers1=Nécessite des privilèges administratifs
InstallForMeOnly=Installer uniquement pour moi
InstallForMeOnly1=Un message du pare-feu apparaîtra lors du premier lancement du jeu
InstallForMeOnly2=Les jeux en réseau local ne fonctionneront pas si la règle du pare-feu ne peut pas être autorisée
InstallPortable=Installation portable
InstallPortable1=Conserve l'application et les données utilisateur dans un même dossier
InstallPortable2=Ne crée aucun programme de désinstallation et ne modifie ni le registre ni l'intégration système
LogsDirectory=Journaux
ResetFoldersToDefault=Rétablir par défaut
RunVCMILauncherAfterInstall=Lancer le lanceur VCMI
SavesDirectory=Parties sauvegardées
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI peut être installé pour tous les utilisateurs ou seulement pour vous.
SelectSetupInstallModeSubTitle=Saisissez votre mode d'installation préféré :
SelectSetupInstallModeTitle=Choisissez le mode d'installation
SharedUserDataNotice=Les données utilisateur ne peuvent pas être supprimées, car une autre installation de VCMI utilise le même dossier.
ShortcutDiscord=Discord officiel de VCMI
ShortcutDiscordComment=Visiter le Discord officiel de VCMI
ShortcutLauncher=Lanceur VCMI
ShortcutLauncherComment=Lancer le lanceur VCMI
ShortcutMapEditor=Éditeur de cartes VCMI
ShortcutMapEditorComment=Ouvrir l'éditeur de cartes VCMI
ShortcutWebPage=Site officiel de VCMI
ShortcutWebPageComment=Visiter le site officiel de VCMI
SystemIntegration=Intégration système
Uninstall=Désinstaller
UserDataDirectory=Données utilisateur (données de Heroes III, modifications, cartes et autres fichiers)
VCMISettings=Configuration de VCMI
VCMPDescription=Fichier de campagne VCMI
VMAPDescription=Fichier de carte VCMI
Warning=Avertissement
X86On64BitWarning=Vous installez la version 32 bits (x86) de VCMI sur Windows 64 bits. Cette configuration est prise en charge, mais la version native 64 bits est recommandée lorsqu'elle est disponible.

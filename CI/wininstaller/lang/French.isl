;
; French.isl, part of VCMI engine
;
; Authors: listed in file AUTHORS in main folder
;
; License: GNU General Public License v2.0 or later
; Full text of license available in license.txt file, in main folder
;
; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.
; Translation maintenance: docs/translators/Maintenance.md#translating-the-installer

[Messages]
HelpTextNote=Paramètres d'installation de VCMI :%n  /USERDATADIR=<path>  Définit le dossier des données utilisateur de VCMI. Le préfixe expand: développe les constantes Inno Setup.%n  /ALLOWCLOUDTARGET=1  Autorise un dossier d'installation ou de données synchronisé avec le cloud lors d'une installation silencieuse.%n  /PORTABLE=1  Installe l'application et les données ensemble, sans désinstalleur, modification du registre, raccourci, association de fichiers ni règle de pare-feu.%n  /LAUNCH  Lance VCMI après l'installation, y compris en mode silencieux.%n  /COPYH3DATA=0|1  Active ou désactive la copie automatique des données Heroes III détectées.%n%nNoms des tâches pour /TASKS et /MERGETASKS :%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (installation pour tous les utilisateurs avec des droits d'administrateur uniquement)%n%nParamètre de désinstallation de VCMI :%n  /DELETEUSERDATA=1  Supprime tous les dossiers utilisateur configurés pour VCMI. Fonctionne uniquement avec /SILENT ou /VERYSILENT. Cette action est irréversible.%n%nLes paramètres standard sont décrits ci-dessus : /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Ce programme ne peut pas s'exécuter sur votre version de Windows. Veuillez vous assurer d'utiliser l'architecture Windows correcte (x86 / x64 / ARM64) et la version adaptée de ce programme.
PrivilegesRequiredOverrideTitle=Mode d'installation – Autorisations
PrivilegesRequiredOverrideInstruction=Choisissez comment exécuter le programme d'installation
PrivilegesRequiredOverrideText1=%1 nécessite des privilèges administrateur pour être installé pour tous les utilisateurs. Vous pouvez également l'installer uniquement pour votre compte sans privilèges administrateur.
PrivilegesRequiredOverrideText2=%1 peut être installé uniquement pour votre compte (sans privilèges administrateur), ou pour tous les utilisateurs (nécessite des privilèges administrateur).
PrivilegesRequiredOverrideAllUsers=Exécuter en tant qu’&administrateur (installation pour tous les utilisateurs)
PrivilegesRequiredOverrideAllUsersRecommended=Exécuter en tant qu’&administrateur (recommandé)
PrivilegesRequiredOverrideCurrentUser=Exécuter en tant qu’&utilisateur standard (installation uniquement pour moi)
PrivilegesRequiredOverrideCurrentUserRecommended=Exécuter en tant qu’&utilisateur standard (recommandé)
ConfirmUninstall=Êtes-vous sûr de vouloir exécuter l'assistant de désinstallation %1 ?

[CustomMessages]
DesktopShortcuts=Raccourcis du Bureau
StartMenuShortcuts=Raccourcis du menu Démarrer
WelcomeDescription=VCMI est un moteur libre pour Heroes III qui offre des possibilités nouvelles et étendues. Pour utiliser VCMI, vous devez posséder les fichiers de données du jeu original.%n%nCet assistant installera VCMI - Open Heroes 3 sur votre appareil.%n%nIl est recommandé de fermer toutes les autres applications avant de continuer.%n%nCliquez sur Suivant pour continuer ou sur Annuler pour quitter l’installation.
WelcomeHighlightsTitle=À propos de VCMI
WelcomeHighlights=VCMI est une réimplémentation communautaire du moteur de Heroes of Might and Magic III. Le projet préserve l’esprit du jeu original, dépasse les limites techniques du moteur classique et fournit une base ouverte pour les mods et les futurs développements.
RequirementImportSpaceHelp=Revenez en arrière et sélectionnez un autre dossier de données utilisateur, ou désactivez la copie automatique des données de Heroes III.
RequirementDisableImportQuestion=Voulez-vous continuer sans copier les données de Heroes III ?
RequirementFirewall=Pare-feu
RequirementMultiplayerGames=Parties multijoueur
RequirementSelected=Sélectionné
RequirementNotSelected=Non sélectionné — le jeu à plusieurs sur un même ordinateur reste possible
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Ajouter des règles de pare-feu pour les parties multijoueur
AssociateH3MFiles=Associer les fichiers .h3m avec l'éditeur de cartes VCMI
AssociateVCMIMapFiles=Associer les fichiers .vmap et .vcmp avec l'éditeur de cartes VCMI
CacheDirectory=Cache
CloudDataNotice=Ce dossier de données utilisateur semble être synchronisé par un service de stockage cloud.
CloudDataWarning=Le dossier de données utilisateur sélectionné semble être synchronisé par un service de stockage cloud. La synchronisation peut verrouiller temporairement des fichiers et provoquer l'échec de l'installation de mods, du lancement du jeu ou des sauvegardes.%n%nVoulez-vous quand même utiliser ce dossier ?
CloudInstallNotice=Ce dossier d'installation semble être synchronisé par un service de stockage cloud.
CloudInstallWarning=Le dossier d'installation sélectionné semble être synchronisé par un service de stockage cloud. Une installation portable ou synchronisée peut échouer si le service verrouille temporairement des fichiers de l'application.%n%nVoulez-vous quand même utiliser ce dossier ?
CloudTargetSilentError=L'installation silencieuse ne peut pas utiliser un dossier synchronisé avec le cloud sans /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Impossible de copier les fichiers Heroes III (%s). Certains fichiers ont peut-être déjà été copiés ; vous pouvez relancer l'importation sans risque.
CopyingHeroes3Data=Copie des données Heroes III...
ConfigDirectory=Configuration
CopyH3Files=Copier automatiquement les fichiers nécessaires de Heroes III vers VCMI
CreateDesktopShortcuts=Créer des raccourcis sur le bureau
CreateStartMenuShortcuts=Créer des raccourcis dans le menu Démarrer
DataFolderDescription=Contient une copie des données Heroes III fournies, les modifications, les cartes, les sauvegardes et les autres fichiers utilisateur.
DataFolderTitle=Dossier des données utilisateur
DeleteUserData=Supprimer les données utilisateur
DeleteUserDataDescription=Sélectionnez les dossiers à supprimer définitivement. Les dossiers non cochés seront conservés. Cette action est irréversible.
DeletingUserData=Suppression des données utilisateur...
DirectoryConfigWriteError=Impossible d'enregistrer la configuration des dossiers utilisateur dans %s. L'installation ne peut pas continuer en toute sécurité.
DirectoryNotWritable=Le dossier sélectionné (%s) n'est pas accessible en écriture. Choisissez un autre dossier ou exécutez l'installation avec les droits requis.%n%n%s
DirectoryRootNotAllowed=Le dossier sélectionné (%s) ne peut pas être la racine d'un lecteur ou d'un partage réseau. Choisissez un dossier dédié.%n%n%s
DirectoryOverlapError=Les dossiers d'installation et de données utilisateur ne doivent pas être identiques ni se chevaucher de manière non sûre. Seule une installation portable peut conserver les données dans le dossier d'installation.
ReadyUserDataLocation=Emplacement des données utilisateur :
RequirementPassed=SATISFAIT
RequirementFailed=ÉCHEC
RequirementWarning=AVERTISSEMENT
RequirementInfo=INFORMATION
RequirementOperatingSystem=Système d'exploitation
RequirementOperatingSystemValue=Windows 7 SP1 ou version ultérieure; temps d'exécution de la compatibilité inclus, le cas échéant
RequirementArchitecture=Architecture
RequirementInstallWritable=Dossier d'installation accessible en écriture
RequirementDataWritable=Dossier de données accessible en écriture
RequirementDirectoryLayout=La mise en page du répertoire
RequirementDirectoryLayoutValue=Les dossiers d'installation et de données sont séparés de façon sûre
RequirementApplicationSpace=Espace disque de l'application
RequirementFreeSpaceValue=%s Mo libres ; l'installation vérifie aussi la taille finale du paquet
RequirementHeroesDataSpace=Importation des données Heroes III
RequirementInsufficientSpace=Espace libre insuffisant pour l'importation des données Heroes III sélectionnée
RequirementRequiredSpaceValue=Environ %s Mo nécessaires pour l'importation sélectionnée
RequirementNotRequested=Importation des données Heroes III non sélectionnée
RequirementCloudStorage=Synchronisation du stockage
RequirementCloudStorageValue=Un chemin sélectionné semble utiliser la synchronisation en nuage
RequirementLocalStorageValue=Les chemins sélectionnés semblent utiliser le stockage local
RequirementInstallationMode=Mode d'installation
RequirementModePortable=Portable; aucun désinstalleur, registre ou intégration du système
RequirementModeAllUsers=Tous les utilisateurs
RequirementModeCurrentUser=Utilisateur actuel
RequirementUpgrade=l'installation existante sera mise à niveau
RequirementsCheckTitle=Vérifiez les exigences du système
RequirementsCheckDescription=Configuration a vérifié la configuration sélectionnée avant l'installation.
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
ScanningFiles=Recherche de fichiers...
SelectSetupInstallModeDesc=VCMI peut être installé pour tous les utilisateurs, pour vous uniquement ou en mode portable.
SelectSetupInstallModeSubTitle=Saisissez votre mode d'installation préféré :
SelectSetupInstallModeTitle=Choisissez le mode d'installation
SharedUserDataNotice=Les données utilisateur ne peuvent pas être supprimées, car une autre installation de VCMI utilise le même dossier.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Visiter le Discord officiel de VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Lancer le lanceur VCMI
ShortcutMapEditor=Éditeur de cartes VCMI
ShortcutMapEditorComment=Ouvrir l'éditeur de cartes VCMI
ShortcutWebPage=Site officiel de VCMI
ShortcutWebPageComment=Visiter le site officiel de VCMI
SystemIntegration=Intégration système
FileAssociations=Associations de fichiers
AssociateH3CFiles=Ouvrir les campagnes Heroes III (.h3c) dans l'éditeur de cartes VCMI
H3CDescription=Campagne Heroes III
Uninstall=Désinstaller
UserDataDirectory=Données utilisateur (données de Heroes III, modifications, cartes et autres fichiers)
VCMISettings=Configuration système
VCMPDescription=Fichier de campagne VCMI
VMAPDescription=Fichier de carte VCMI
Warning=Avertissement
X86On64BitWarning=Vous installez la version 32 bits (x86) de VCMI sur Windows 64 bits. Cette configuration est prise en charge, mais la version native 64 bits est recommandée lorsqu'elle est disponible.
Heroes3ImportReparsePoint=Impossible d'importer les données Heroes III en toute sécurité : un dossier cible existant contient une jonction ou un lien symbolique. Supprimez ce lien ou choisissez un autre dossier.
OpenSetupLog=Ouvrez le journal de configuration
OpenSetupLogError=Le journal d'installation n'a pas pu être ouvert.
LegacyUninstallStartFailed=Impossible de lancer l'ancien programme de désinstallation de VCMI :%n%s
LegacyUninstallExitFailed=L'ancien programme de désinstallation de VCMI a échoué avec le code %s.
LegacyUninstallFailureChoice=Abandonner arrête l'installation. Réessayer relance l'ancien désinstalleur. Ignorer poursuit l'installation à vos risques et périls.
LegacyUninstallRequired=L'ancienne installation de VCMI n'a pas pu être supprimée. Aucun nouveau fichier d'installation n'a été copié.
InstallDirectoryUsedByOtherInstallation=Le répertoire de l'installation se chevauche avec un autre répertoire enregistré VCMI l'installation:%n%s%n%nSélectionnez un répertoire différent.
X86OnARM64Warning=Vous installez le 32-bit (x86) de la version suivante: VCMI sur ARM64 Windows. Ceci est pris en charge, mais le natif ARM64 la version est recommandée lorsqu'elle est disponible.
RequirementsColumnComponent=Components
RequirementsColumnDetails=Réservé
RequirementsColumnStatus=Statut de l'entreprise
RequirementsColumnDetected=Votre système
RequirementDetectedWindows=Installation compatible de Windows
RequirementWritableValue=Dossier accessible en écriture
RequirementEnoughSpace=Espace libre suffisant
RequirementProcessor=Le processeur
RequirementProcessorValue=1 GHz ou plus rapide
RequirementMemory=Mémoire vive
RequirementMemoryValue=1 Go de RAM
RequirementMemoryDetected=%s RAM de plusieurs mécanismes
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Environnement d'exécution DirectX 11 disponible
RequirementDirectXMissing=Environnement d'exécution DirectX 11 introuvable
RequirementDetectionUnavailable=Détection impossible
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Dossier d'installation
RequirementUserDataFolder=Dossier des données utilisateur
RequirementDiskSpace=Espace disque libre
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Recommandé
RequirementInternetAvailable=Disponible
RequirementInternetUnavailable=Ne pas détecté
RequirementHeroesData=Données Heroes III
RequirementRequiredToPlay=Nécessaire pour jouer
RequirementHeroesDataAvailable=Présentes dans les données utilisateur
RequirementHeroesDataMissing=Pas trouvé; peut être importé plus tard
RequirementWritableAndSynced=Écrits et synchronisés
RequirementNotWritable=Écriture impossible
TasksCheckboxesTooltip=Choisissez les intégrations et actions facultatives. Les raccourcis facilitent l'accès, les associations ouvrent les cartes prises en charge dans l'éditeur, les règles du pare-feu autorisent le multijoueur et l'importation copie les données Heroes III détectées.
UninstallCheckboxesTooltip=Cochez uniquement les dossiers de données utilisateur à supprimer définitivement. Les entrées partagées désactivées sont utilisées par une autre installation de VCMI.
InstallModeTooltip=Tous les utilisateurs : installe VCMI pour tous les comptes Windows, normalement dans Program Files. Nécessite des droits d'administrateur. Crée les informations de désinstallation, entrées du registre, raccourcis, associations de fichiers et, éventuellement, une règle de pare-feu pour tout le système. Les données restent dans le dossier choisi.%n%nUtilisateur actuel : installe VCMI uniquement pour le compte Windows connecté, normalement dans Local AppData, sans droits d'administrateur. Crée un désinstalleur et des intégrations pour cet utilisateur. Les autres comptes ne verront pas cette installation. Le pare-feu Windows peut demander une autorisation à la première utilisation du multijoueur.%n%nPortable : conserve l'application et les données dans le dossier choisi. Ne crée ni désinstalleur, ni entrée du registre, ni raccourci, ni association de fichiers, ni règle de pare-feu. Le dossier doit rester accessible en écriture. Déplacez-le ou copiez-le pour transférer l'installation ; supprimez-le pour la désinstaller.
CopyH3FilesTooltip=Copie les dossiers Data, Maps et Mp3 de Heroes III détectés dans le dossier de données utilisateur VCMI choisi. Les fichiers d'origine restent inchangés.
ReadyHeroes3Import=Importation des données Heroes III :

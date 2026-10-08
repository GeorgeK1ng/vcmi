; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Parametri specifici dell'installazione VCMI:%n  /USERDATADIR=<percorso>  Imposta la cartella dei dati utente VCMI. Il prefisso expand: espande le costanti di Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Installa applicazione e dati insieme senza disinstallatore, modifiche al registro, collegamenti, associazioni o regole firewall.%n  /LAUNCH  Avvia VCMI dopo l'installazione, anche in modalità silenziosa.%n%nParametro del disinstallatore VCMI:%n  /DELETEUSERDATA=1  Elimina tutte le cartelle utente VCMI configurate. Viene accettato solo con /SILENT o /VERYSILENT. L'operazione è irreversibile.%n%nI parametri standard come /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART e /LOG sono descritti sopra.
WindowsVersionNotSupported=Questo programma non può essere eseguito sulla versione di Windows in uso. Assicurati di utilizzare l'architettura corretta di Windows (32-bit o 64-bit) e la versione corretta di questo programma.
PrivilegesRequiredOverrideTitle=Modalità di installazione – Permessi
PrivilegesRequiredOverrideInstruction=Scegli come eseguire il programma di installazione
PrivilegesRequiredOverrideText1=%1 richiede i privilegi di amministratore per essere installato per tutti gli utenti.%nPuoi anche installarlo solo per il tuo account senza privilegi di amministratore.
PrivilegesRequiredOverrideText2=%1 può essere installato solo per il tuo account (senza privilegi di amministratore) oppure per tutti gli utenti (richiede privilegi di amministratore).
PrivilegesRequiredOverrideAllUsers=Esegui come &Amministratore (installazione per tutti gli utenti)
PrivilegesRequiredOverrideAllUsersRecommended=Esegui come &Amministratore (consigliato)
PrivilegesRequiredOverrideCurrentUser=Esegui come &Utente Standard (installazione solo per me)
PrivilegesRequiredOverrideCurrentUserRecommended=Esegui come &Utente Standard (consigliato)
ConfirmUninstall=Sei sicuro di voler eseguire l'assistente di disinstallazione di %1?

[CustomMessages]
AddFirewallRules=Aggiungi regole del firewall per VCMI
AssociateH3MFiles=Associa i file .h3m all'Editor Mappe VCMI
AssociateVCMIMapFiles=Associa i file .vmap e .vcmp all'Editor Mappe VCMI
CacheDirectory=Cache
CloudDataNotice=Questa cartella dei dati utente sembra essere sincronizzata da un servizio di archiviazione cloud.
CloudDataWarning=La cartella dei dati utente selezionata sembra essere sincronizzata da un servizio di archiviazione cloud. La sincronizzazione può bloccare temporaneamente i file e causare errori durante l'installazione delle mod, l'avvio del gioco o il salvataggio.%n%nVuoi comunque utilizzare questa cartella?
CloudInstallNotice=Questa cartella di installazione sembra essere sincronizzata da un servizio di archiviazione cloud.
CloudInstallWarning=La cartella di installazione selezionata sembra essere sincronizzata da un servizio di archiviazione cloud. Un'installazione portatile o sincronizzata può non riuscire se il servizio blocca temporaneamente i file dell'applicazione.%n%nVuoi comunque utilizzare questa cartella?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Configurazione
CopyH3Files=Copia automaticamente i file richiesti di Heroes III in VCMI
CreateDesktopShortcuts=Crea collegamenti sul desktop
CreateStartMenuShortcuts=Crea collegamenti nel menu Start
DataFolderDescription=Contiene una copia dei dati di Heroes III forniti, le modifiche, le mappe, i salvataggi e altri file utente.
DataFolderTitle=Cartella dei dati utente
DeleteUserData=Elimina i dati utente
DeleteUserDataDescription=Seleziona le cartelle da eliminare definitivamente. Le cartelle non selezionate verranno conservate. L'operazione non può essere annullata.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=File mappa Heroes 3
InstallFolderTitle=Cartella di installazione
InstallForAllUsers=Installa per tutti gli utenti
InstallForAllUsers1=Richiede privilegi amministrativi
InstallForMeOnly=Installa solo per me
InstallForMeOnly1=Quando il gioco viene avviato per la prima volta, apparirà un avviso del firewall
InstallForMeOnly2=I giochi LAN non funzioneranno se la regola del firewall non può essere consentita
InstallPortable=Installazione portatile
InstallPortable1=Mantiene l'applicazione e i dati utente insieme in una cartella
InstallPortable2=Non crea un programma di disinstallazione e non modifica il registro o l'integrazione di sistema
LogsDirectory=Registri
ResetFoldersToDefault=Ripristina predefiniti
RunVCMILauncherAfterInstall=Avvia il Launcher di VCMI
SavesDirectory=Partite salvate
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI può essere installato per tutti gli utenti o solo per te.
SelectSetupInstallModeSubTitle=Seleziona il tipo di installazione preferito:
SelectSetupInstallModeTitle=Scegli il tipo di installazione
SharedUserDataNotice=I dati utente non possono essere eliminati perché un'altra installazione di VCMI utilizza la stessa cartella.
ShortcutDiscord=Discord VCMI
ShortcutDiscordComment=Visita il Discord ufficiale di VCMI
ShortcutLauncher=Launcher VCMI
ShortcutLauncherComment=Avvia il Launcher di VCMI
ShortcutMapEditor=Editor Mappe VCMI
ShortcutMapEditorComment=Apri l'Editor Mappe VCMI
ShortcutWebPage=Sito Web di VCMI
ShortcutWebPageComment=Visita il sito ufficiale di VCMI
SystemIntegration=Integrazione di sistema
Uninstall=Disinstalla
UserDataDirectory=Dati utente (dati di Heroes III, modifiche, mappe e altri file)
VCMISettings=Configurazione VCMI
VCMPDescription=File campagna VCMI
VMAPDescription=File mappa VCMI
Warning=Avviso
X86On64BitWarning=Stai installando la versione a 32 bit (x86) di VCMI su Windows a 64 bit. Questa configurazione è supportata, ma è consigliata la versione nativa a 64 bit, se disponibile.

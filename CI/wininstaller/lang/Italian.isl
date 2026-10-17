;
; Italian.isl, part of VCMI engine
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
HelpTextNote=Parametri di installazione di VCMI:%n  /USERDATADIR=<path>  Imposta la cartella dei dati utente di VCMI. Il prefisso expand: espande le costanti di Inno Setup.%n  /ALLOWCLOUDTARGET=1  Consente una cartella di installazione o di dati sincronizzata con il cloud durante l'installazione silenziosa.%n  /PORTABLE=1  Installa l'applicazione e i dati insieme, senza programma di disinstallazione, modifiche al registro, collegamenti, associazioni di file o regole del firewall.%n  /LAUNCH  Avvia VCMI dopo l'installazione, anche in modalità silenziosa.%n  /COPYH3DATA=0|1  Attiva o disattiva la copia automatica dei dati di Heroes III rilevati.%n%nNomi delle attività per /TASKS e /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (solo installazione per tutti gli utenti con privilegi di amministratore)%n%nParametro di disinstallazione di VCMI:%n  /DELETEUSERDATA=1  Elimina tutte le cartelle utente configurate per VCMI. Funziona solo insieme a /SILENT o /VERYSILENT. L'operazione è irreversibile.%n%nI parametri standard sono descritti sopra: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Questo programma non può essere eseguito sulla versione di Windows in uso. Assicurati di utilizzare l'architettura corretta di Windows (x86 / x64 / ARM64) e la versione corretta di questo programma.
PrivilegesRequiredOverrideTitle=Modalità di installazione – Permessi
PrivilegesRequiredOverrideInstruction=Scegli come eseguire il programma di installazione
PrivilegesRequiredOverrideText1=%1 richiede i privilegi di amministratore per essere installato per tutti gli utenti. Puoi anche installarlo solo per il tuo account senza privilegi di amministratore.
PrivilegesRequiredOverrideText2=%1 può essere installato solo per il tuo account (senza privilegi di amministratore) oppure per tutti gli utenti (richiede privilegi di amministratore).
PrivilegesRequiredOverrideAllUsers=Esegui come &Amministratore (installazione per tutti gli utenti)
PrivilegesRequiredOverrideAllUsersRecommended=Esegui come &Amministratore (consigliato)
PrivilegesRequiredOverrideCurrentUser=Esegui come &Utente Standard (installazione solo per me)
PrivilegesRequiredOverrideCurrentUserRecommended=Esegui come &Utente Standard (consigliato)
ConfirmUninstall=Sei sicuro di voler eseguire l'assistente di disinstallazione di %1?

[CustomMessages]
DesktopShortcuts=Collegamenti sul desktop
StartMenuShortcuts=Collegamenti del menu Start
WelcomeDescription=VCMI è un motore open source per Heroes III che offre possibilità nuove e ampliate. Per usare VCMI è necessario possedere i file di dati del gioco originale.%n%nQuesta procedura guidata installerà VCMI - Open Heroes 3 sul dispositivo.%n%nSi consiglia di chiudere tutte le altre applicazioni prima di continuare.%n%nFare clic su Avanti per continuare o su Annulla per uscire dall'installazione.
WelcomeHighlightsTitle=Informazioni su VCMI
WelcomeHighlights=VCMI è una reimplementazione del motore di Heroes of Might and Magic III sviluppata dalla comunità. Il progetto preserva lo spirito del gioco originale, supera i limiti tecnici del motore classico e offre una base aperta per mod e sviluppi futuri.
RequirementImportSpaceHelp=Torna indietro e seleziona un'altra cartella per i dati utente oppure disattiva la copia automatica dei dati di Heroes III.
RequirementDisableImportQuestion=Vuoi continuare senza copiare i dati di Heroes III?
RequirementFirewall=Firewall
RequirementMultiplayerGames=Partite multigiocatore
RequirementSelected=Selezionato
RequirementNotSelected=Non selezionato — il gioco a turni sullo stesso computer funzionerà comunque
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Aggiungi regole firewall per le partite multigiocatore
AssociateH3MFiles=Associa i file .h3m all'Editor Mappe VCMI
AssociateVCMIMapFiles=Associa i file .vmap e .vcmp all'Editor Mappe VCMI
CacheDirectory=Cache
CloudDataNotice=Questa cartella dei dati utente sembra essere sincronizzata da un servizio di archiviazione cloud.
CloudDataWarning=La cartella dei dati utente selezionata sembra essere sincronizzata da un servizio di archiviazione cloud. La sincronizzazione può bloccare temporaneamente i file e causare errori durante l'installazione delle mod, l'avvio del gioco o il salvataggio.%n%nVuoi comunque utilizzare questa cartella?
CloudInstallNotice=Questa cartella di installazione sembra essere sincronizzata da un servizio di archiviazione cloud.
CloudInstallWarning=La cartella di installazione selezionata sembra essere sincronizzata da un servizio di archiviazione cloud. Un'installazione portatile o sincronizzata può non riuscire se il servizio blocca temporaneamente i file dell'applicazione.%n%nVuoi comunque utilizzare questa cartella?
CloudTargetSilentError=L'installazione silenziosa non può usare una destinazione sincronizzata con il cloud senza /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Impossibile copiare i file di Heroes III (%s). Alcuni file potrebbero essere già stati copiati; è possibile ripetere l'importazione in sicurezza.
CopyingHeroes3Data=Copia dei dati di Heroes III...
ConfigDirectory=Configurazione
CopyH3Files=Copia automaticamente i file richiesti di Heroes III in VCMI
CreateDesktopShortcuts=Crea collegamenti sul desktop
CreateStartMenuShortcuts=Crea collegamenti nel menu Start
DataFolderDescription=Contiene una copia dei dati di Heroes III forniti, le modifiche, le mappe, i salvataggi e altri file utente.
DataFolderTitle=Cartella dei dati utente
DeleteUserData=Elimina i dati utente
DeleteUserDataDescription=Seleziona le cartelle da eliminare definitivamente. Le cartelle non selezionate verranno conservate. L'operazione non può essere annullata.
DeletingUserData=Eliminazione dei dati utente...
DirectoryConfigWriteError=Impossibile salvare la configurazione delle cartelle utente in %s. L'installazione non può continuare in sicurezza.
DirectoryNotWritable=Impossibile scrivere nella cartella selezionata (%s). Scegliere un'altra cartella o avviare l'installazione con i privilegi necessari.%n%n%s
DirectoryRootNotAllowed=La cartella selezionata (%s) non può essere la radice di un'unità o di una condivisione di rete. Scegliere una cartella dedicata.%n%n%s
DirectoryOverlapError=Le cartelle di installazione e dei dati non possono coincidere né sovrapporsi in modo non sicuro. Solo un'installazione portatile può conservare i dati nella cartella di installazione.
ReadyUserDataLocation=Posizione dei dati utente:
RequirementPassed=SODDISFATTO
RequirementFailed=ERRORE
RequirementWarning=AVVISO
RequirementInfo=INFORMAZIONE
RequirementOperatingSystem=Sistema operativo
RequirementOperatingSystemValue=Windows 7 SP1 o successivo; compatibilità con il tempo di esecuzione quando richiesto
RequirementArchitecture=Architettura
RequirementInstallWritable=Cartella di installazione scrivibile
RequirementDataWritable=Cartella dei dati scrivibile
RequirementDirectoryLayout=Disegno del directory
RequirementDirectoryLayoutValue=I percorsi di installazione e dei dati sono separati in sicurezza
RequirementApplicationSpace=Spazio su disco di applicazione
RequirementFreeSpaceValue=%s MB liberi; il programma verifica anche la dimensione finale del pacchetto
RequirementHeroesDataSpace=Importazione di Heroes III
RequirementInsufficientSpace=Spazio libero insufficiente per importare i dati di Heroes III selezionati
RequirementRequiredSpaceValue=Circa %s MB necessari per l'importazione selezionata
RequirementNotRequested=Importazione dei dati di Heroes III non selezionata
RequirementCloudStorage=Sincronizzazione di stoccaggio
RequirementCloudStorageValue=Un percorso selezionato sembra utilizzare la sincronizzazione cloud
RequirementLocalStorageValue=I percorsi selezionati sembrano utilizzare lo spazio di archiviazione locale
RequirementInstallationMode=Modalità di installazione
RequirementModePortable=Portabile; nessun disinstallator, registro o integrazione del sistema
RequirementModeAllUsers=Tutti gli utenti
RequirementModeCurrentUser=Utente corrente
RequirementUpgrade=l'installazione esistente verrà aggiornata
RequirementsCheckTitle=Controllo dei requisiti del sistema
RequirementsCheckDescription=Setup ha verificato la configurazione selezionata prima dell'installazione.
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
ScanningFiles=Ricerca dei file...
SelectSetupInstallModeDesc=VCMI può essere installato per tutti gli utenti, solo per te o in modalità portatile.
SelectSetupInstallModeSubTitle=Seleziona il tipo di installazione preferito:
SelectSetupInstallModeTitle=Scegli il tipo di installazione
SharedUserDataNotice=I dati utente non possono essere eliminati perché un'altra installazione di VCMI utilizza la stessa cartella.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Visita il Discord ufficiale di VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Avvia il Launcher di VCMI
ShortcutMapEditor=Editor Mappe VCMI
ShortcutMapEditorComment=Apri l'Editor Mappe VCMI
ShortcutWebPage=Sito Web di VCMI
ShortcutWebPageComment=Visita il sito ufficiale di VCMI
SystemIntegration=Integrazione di sistema
FileAssociations=Associazioni file
AssociateH3CFiles=Apri le campagne di Heroes III (.h3c) nell'Editor Mappe VCMI
H3CDescription=Campagna Heroes III
Uninstall=Disinstalla
UserDataDirectory=Dati utente (dati di Heroes III, modifiche, mappe e altri file)
VCMISettings=Configurazione di sistema
VCMPDescription=File campagna VCMI
VMAPDescription=File mappa VCMI
Warning=Avviso
X86On64BitWarning=Stai installando la versione a 32 bit (x86) di VCMI su Windows a 64 bit. Questa configurazione è supportata, ma è consigliata la versione nativa a 64 bit, se disponibile.
Heroes3ImportReparsePoint=Impossibile importare i dati di Heroes III in sicurezza: una cartella di destinazione contiene una giunzione o un collegamento simbolico. Rimuovere il collegamento o scegliere un'altra cartella.
OpenSetupLog=Aprire il registro di impostazione
OpenSetupLogError=Non è stato possibile aprire il registro di configurazione.
LegacyUninstallStartFailed=Impossibile avviare il precedente programma di disinstallazione di VCMI:%n%s
LegacyUninstallExitFailed=Il precedente programma di disinstallazione di VCMI è terminato con il codice di errore %s.
LegacyUninstallFailureChoice=Interrompi termina l'installazione. Riprova esegue nuovamente il vecchio programma di disinstallazione. Ignora continua a proprio rischio.
LegacyUninstallRequired=Impossibile rimuovere la precedente installazione di VCMI. Nessun nuovo file di installazione è stato copiato.
InstallDirectoryUsedByOtherInstallation=L'elenco delle installazioni si sovrappone ad un altro registro VCMI installazione:%n%s%n%nSelezionare una directory diversa.
X86OnARM64Warning=Si sta installando il 32-bit (x86) versione di VCMI su ARM64 Windows. Questo è supportato, ma il nativo ARM64 la versione è raccomandata quando disponibile.
RequirementsColumnComponent=Componente
RequirementsColumnDetails=Requisiti
RequirementsColumnStatus=Statuto
RequirementsColumnDetected=Il sistema in uso
RequirementDetectedWindows=Installazione compatibile di Windows
RequirementWritableValue=Cartella scrivibile
RequirementEnoughSpace=Spazio libero sufficiente
RequirementProcessor=Processore
RequirementProcessorValue=1 GHz o più veloci
RequirementMemory=Memoria RAM
RequirementMemoryValue=1 GB di RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Ambiente di esecuzione DirectX 11 disponibile
RequirementDirectXMissing=Ambiente di esecuzione DirectX 11 non trovato
RequirementDetectionUnavailable=Impossibile rilevare
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Cartella di installazione
RequirementUserDataFolder=Cartella dei dati utente
RequirementDiskSpace=Spazio libero sul disco
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Raccomandato
RequirementInternetAvailable=Disponibile
RequirementInternetUnavailable=Non rilevato
RequirementHeroesData=Dati di Heroes III
RequirementRequiredToPlay=Necessario per giocare
RequirementHeroesDataAvailable=Disponibili nei dati utente
RequirementHeroesDataMissing=Non trovato; può essere importato in seguito
RequirementWritableAndSynced=Scritturabile e sincronizzata
RequirementNotWritable=Scrittura non consentita
TasksCheckboxesTooltip=Selezionare le integrazioni e le azioni facoltative. I collegamenti facilitano l'accesso, le associazioni aprono le mappe supportate nell'editor, le regole del firewall consentono il multigiocatore e l'importazione copia i dati di Heroes III rilevati.
UninstallCheckboxesTooltip=Selezionare solo le cartelle dei dati utente da eliminare definitivamente. Le voci condivise disattivate sono usate da un'altra installazione di VCMI.
InstallModeTooltip=Tutti gli utenti: installa VCMI per tutti gli account Windows, normalmente in Program Files. Richiede l'autorizzazione dell'amministratore. Crea informazioni di disinstallazione, voci di registro, collegamenti, associazioni di file e una regola facoltativa del firewall a livello di sistema. I dati restano nella cartella selezionata.%n%nUtente attuale: installa VCMI solo per l'account Windows connesso, normalmente in Local AppData, senza autorizzazione dell'amministratore. Crea un programma di disinstallazione e integrazioni per quell'utente. Gli altri account non vedranno questa installazione. Windows Firewall potrebbe chiedere il permesso al primo utilizzo del multigiocatore.%n%nPortatile: mantiene l'applicazione e i dati insieme nella cartella selezionata. Non crea programma di disinstallazione, voci di registro, collegamenti, associazioni o regole del firewall. La cartella deve restare scrivibile. Spostarla o copiarla per trasferire l'installazione, oppure eliminarla per disinstallare.
CopyH3FilesTooltip=Copia le cartelle Data, Maps e Mp3 di Heroes III rilevate nella cartella dei dati utente di VCMI selezionata. I file originali restano invariati.
ReadyHeroes3Import=Importazione dei dati di Heroes III:

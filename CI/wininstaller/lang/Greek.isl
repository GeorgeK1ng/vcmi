;
; Greek.isl, part of VCMI engine
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
HelpTextNote=Παράμετροι εγκατάστασης του VCMI:%n  /USERDATADIR=<path>  Ορίζει τον φάκελο δεδομένων χρήστη του VCMI. Το πρόθεμα expand: αναπτύσσει τις σταθερές του Inno Setup.%n  /ALLOWCLOUDTARGET=1  Επιτρέπει φάκελο εγκατάστασης ή δεδομένων που συγχρονίζεται με το cloud κατά την αθόρυβη εγκατάσταση.%n  /PORTABLE=1  Εγκαθιστά την εφαρμογή και τα δεδομένα μαζί, χωρίς πρόγραμμα απεγκατάστασης, αλλαγές στο μητρώο, συντομεύσεις, συσχετίσεις αρχείων ή κανόνες τείχους προστασίας.%n  /LAUNCH  Εκκινεί το VCMI μετά την εγκατάσταση, ακόμη και σε αθόρυβη λειτουργία.%n  /COPYH3DATA=0|1  Ενεργοποιεί ή απενεργοποιεί την αυτόματη αντιγραφή των δεδομένων Heroes III που εντοπίστηκαν.%n%nΟνόματα εργασιών για /TASKS και /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (μόνο εγκατάσταση για όλους τους χρήστες με δικαιώματα διαχειριστή)%n%nΠαράμετρος απεγκατάστασης του VCMI:%n  /DELETEUSERDATA=1  Διαγράφει όλους τους καθορισμένους φακέλους χρήστη του VCMI. Ισχύει μόνο μαζί με /SILENT ή /VERYSILENT. Η ενέργεια δεν αναιρείται.%n%nΟι τυπικές παράμετροι περιγράφονται παραπάνω: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Το πρόγραμμα αυτό δεν μπορεί να εκτελεστεί στην έκδοση Windows σας.x86 / x64 / ARM64) και έκδοση για το πρόγραμμα αυτό.
PrivilegesRequiredOverrideTitle=Απαιτούμενα Προνόμια Διοικητή
PrivilegesRequiredOverrideInstruction=Επιλέξτε πώς να εκτελέσετε τον εγκαταστάτη
PrivilegesRequiredOverrideText1=Η εγκατάσταση του %1 για όλους τους χρήστες απαιτεί δικαιώματα διαχειριστή. Μπορείτε επίσης να το εγκαταστήσετε μόνο για τον λογαριασμό σας χωρίς αυτά τα δικαιώματα.
PrivilegesRequiredOverrideText2=Το %1 μπορεί να εγκατασταθεί μόνο για τον λογαριασμό σας χωρίς δικαιώματα διαχειριστή ή για όλους τους χρήστες με δικαιώματα διαχειριστή.
PrivilegesRequiredOverrideAllUsers=Εκτέλεση ως &διαχειριστής (για όλους τους χρήστες)
PrivilegesRequiredOverrideAllUsersRecommended=Εκτέλεση ως &διαχειριστής (συνιστάται)
PrivilegesRequiredOverrideCurrentUser=Εκτέλεση ως &τυπικός χρήστης (μόνο για εμένα)
PrivilegesRequiredOverrideCurrentUserRecommended=Εκτέλεση ως &τυπικός χρήστης (συνιστάται)
ConfirmUninstall=Είστε σίγουροι ότι θέλετε να τρέξετε το %1 αφαιρέστε τον μάγο;

[CustomMessages]
DesktopShortcuts=Συντομεύσεις επιφάνειας εργασίας
StartMenuShortcuts=Συντομεύσεις μενού Έναρξης
WelcomeDescription=Το VCMI είναι μια μηχανή ανοικτού κώδικα για το Heroes III με νέες και διευρυμένες δυνατότητες. Για να χρησιμοποιήσετε το VCMI, πρέπει να διαθέτετε τα αρχικά αρχεία δεδομένων του παιχνιδιού.%n%nΑυτός ο οδηγός θα εγκαταστήσει το VCMI - Open Heroes 3 στη συσκευή σας.%n%nΣυνιστάται να κλείσετε όλες τις άλλες εφαρμογές πριν συνεχίσετε.%n%nΠατήστε Επόμενο για συνέχεια ή Άκυρο για έξοδο από την εγκατάσταση.
WelcomeHighlightsTitle=Σχετικά με το VCMI
WelcomeHighlights=Το VCMI είναι μια επανυλοποίηση της μηχανής του Heroes of Might and Magic III που αναπτύσσεται από την κοινότητα. Διατηρεί το πνεύμα του αρχικού παιχνιδιού, ξεπερνά τους τεχνικούς περιορισμούς της κλασικής μηχανής και παρέχει ανοικτή βάση για mods και συνεχή ανάπτυξη.
RequirementImportSpaceHelp=Επιστρέψτε και επιλέξτε διαφορετικό φάκελο δεδομένων χρήστη ή απενεργοποιήστε την αυτόματη αντιγραφή των δεδομένων Heroes III.
RequirementDisableImportQuestion=Θέλετε να συνεχίσετε χωρίς αντιγραφή των δεδομένων Heroes III;
RequirementFirewall=Τείχος προστασίας
RequirementMultiplayerGames=Παιχνίδια πολλών παικτών
RequirementSelected=Επιλεγμένο
RequirementNotSelected=Δεν επιλέχθηκε — το παιχνίδι στον ίδιο υπολογιστή θα λειτουργεί
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Προσθήκη κανόνων τείχους προστασίας για παιχνίδια πολλών παικτών
AssociateH3MFiles=Σύνδεση αρχείων .h3m με το VCMI Επισκόπηση χάρτης
AssociateVCMIMapFiles=Συνδέστε τα αρχεία .vmap και .vcmp με το VCMI Επισκόπηση χάρτης
CacheDirectory=Κασ
CloudDataNotice=Αυτό το κατάλογο δεδομένων χρηστών φαίνεται να συγχρονίζεται από έναν πάροχο αποθήκευσης cloud.
CloudDataWarning=Ο επιλεγμένος κατάλογος δεδομένων χρήστη φαίνεται να συγχρονίζεται από έναν πάροχο αποθήκευσης cloud.%n%nΘέλεις να χρησιμοποιήσεις αυτό το κατάλογο έτσι κι αλλιώς;
CloudInstallNotice=Αυτό το κατάλογο εγκατάστασης φαίνεται να συγχρονίζεται από έναν πάροχο αποθήκευσης σε σύννεφο.
CloudInstallWarning=Το επιλεγμένο κατάλογο εγκατάστασης φαίνεται να συγχρονίζεται από πάροχο αποθήκευσης cloud. Μια φορητή ή συγχρονισμένη εγκατάσταση μπορεί να αποτύχει όταν ο πάροχος κλειδώσει προσωρινά τα αρχεία εφαρμογής.%n%nΘέλετε να χρησιμοποιήσετε αυτό το κατάλογο ούτως ή άλλως;
CloudTargetSilentError=Η αθόρυβη εγκατάσταση δεν μπορεί να χρησιμοποιήσει προορισμό συγχρονισμένο με το cloud χωρίς /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Δεν ήταν δυνατή η αντιγραφή των αρχείων Heroes III (%s). Ορισμένα αρχεία ίσως έχουν ήδη αντιγραφεί· μπορείτε να επαναλάβετε την εισαγωγή με ασφάλεια.
CopyingHeroes3Data=Αντιγραφή δεδομένων Heroes III...
ConfigDirectory=Διαμόρφωση
CopyH3Files=Απαιτείται αυτόματη αντιγραφή Heroes III αρχεία για VCMI
CreateDesktopShortcuts=Δημιουργήστε συντομεύσεις γραφείου
CreateStartMenuShortcuts=Δημιουργήστε συντομεύσεις του μενού Ξεκίνησης
DataFolderDescription=Αποθηκεύει αντίγραφο του παρασχεθέντος Heroes III δεδομένα, τροποποιήσεις, χάρτες, αποθηκευμένα παιχνίδια και άλλα αρχεία χρήστη.
DataFolderTitle=Λογαριασμός δεδομένων χρήστη
DeleteUserData=Διαγράψτε τα δεδομένα χρήστη
DeleteUserDataDescription=Επιλέξτε φακέλους για να διαγράψετε μόνιμα. Οι μη επιλεγμένες φακέλες θα διατηρηθούν. Αυτό δεν μπορεί να ανακληθεί.
DeletingUserData=Διαγραφή δεδομένων χρήστη...
DirectoryConfigWriteError=Δεν ήταν δυνατή η αποθήκευση των ρυθμίσεων φακέλων χρήστη στο %s. Η εγκατάσταση δεν μπορεί να συνεχιστεί με ασφάλεια.
DirectoryNotWritable=Δεν είναι δυνατή η εγγραφή στον επιλεγμένο φάκελο (%s). Επιλέξτε άλλον φάκελο ή εκτελέστε την εγκατάσταση με τα απαιτούμενα δικαιώματα.%n%n%s
DirectoryRootNotAllowed=Ο επιλεγμένος φάκελος (%s) δεν μπορεί να είναι η ρίζα μονάδας ή κοινόχρηστου πόρου δικτύου. Επιλέξτε ξεχωριστό φάκελο.%n%n%s
DirectoryOverlapError=Οι φάκελοι εγκατάστασης και δεδομένων χρήστη δεν μπορούν να είναι ίδιοι ή να επικαλύπτονται με μη ασφαλή τρόπο. Μόνο η φορητή εγκατάσταση επιτρέπει δεδομένα μέσα στον φάκελο εγκατάστασης.
ReadyUserDataLocation=Τοποθεσία δεδομένων χρήστη:
RequirementPassed=ΕΠΙΤΥΧΙΑ
RequirementFailed=ΑΠΟΤΥΧΙΑ
RequirementWarning=ΠΡΟΕΙΔΟΠΟΙΗΣΗ
RequirementInfo=ΠΛΗΡΟΦΟΡΙΕΣ
RequirementOperatingSystem=Λειτουργικό σύστημα
RequirementOperatingSystemValue=Windows 7 SP1 ή νεότερη έκδοση· περιλαμβάνεται περιβάλλον συμβατότητας όταν απαιτείται
RequirementArchitecture=Αρχιτεκτονική
RequirementInstallWritable=Επιτρέπεται εγγραφή στον φάκελο εγκατάστασης
RequirementDataWritable=Επιτρέπεται εγγραφή στον φάκελο δεδομένων χρήστη
RequirementDirectoryLayout=Διάταξη καταλόγου
RequirementDirectoryLayoutValue=Οι διαδρομές εγκατάστασης και δεδομένων είναι διαχωρισμένες με ασφάλεια
RequirementApplicationSpace=Εφαρμοστικό χώρο σε δίσκο
RequirementFreeSpaceValue=%s MB ελεύθερα· η εγκατάσταση ελέγχει και το τελικό μέγεθος του πακέτου
RequirementHeroesDataSpace=Εισαγωγή δεδομένων Heroes III
RequirementInsufficientSpace=Δεν υπάρχει αρκετός ελεύθερος χώρος για την επιλεγμένη εισαγωγή δεδομένων Heroes III
RequirementRequiredSpaceValue=Απαιτούνται περίπου %s MB για την επιλεγμένη εισαγωγή
RequirementNotRequested=Δεν έχει επιλεγεί εισαγωγή δεδομένων Heroes III
RequirementCloudStorage=Συγχρονισμός αποθήκευσης
RequirementCloudStorageValue=Μια επιλεγμένη διαδρομή φαίνεται να χρησιμοποιεί συγχρονισμό σύννεφου
RequirementLocalStorageValue=Οι επιλεγμένες διαδρομές εμφανίζονται να χρησιμοποιούν τοπική αποθήκευση
RequirementInstallationMode=Τρόπος εγκατάστασης
RequirementModePortable=Φορητό, χωρίς αποσύνδεση, μητρώο ή ενσωμάτωση συστήματος
RequirementModeAllUsers=Όλοι οι χρήστες
RequirementModeCurrentUser=Συγχρόνιος χρήστης
RequirementUpgrade=η υπάρχουσα εγκατάσταση θα αναβαθμιστεί
RequirementsCheckTitle=Έλεγχος των απαιτήσεων του συστήματος
RequirementsCheckDescription=Η εγκατάσταση έλεγξε την επιλεγμένη διαμόρφωση πριν την εγκατάσταση.
H3MDescription=Αρχείο χάρτης Heroes 3
InstallFolderTitle=Πακέτο εγκατάστασης
InstallForAllUsers=Εγκατάσταση για όλους τους χρήστες
InstallForAllUsers1=Απαιτεί διοικητικά προνόμια
InstallForMeOnly=Εγκατάσταση μόνο για μένα
InstallForMeOnly1=Μια προειδοποίηση firewall θα εμφανιστεί κατά την εκκίνηση του παιχνιδιού για πρώτη φορά
InstallForMeOnly2=Τα παιχνίδια τοπικού δικτύου δεν θα λειτουργούν αν δεν επιτρέπεται η πρόσβαση από το τείχος προστασίας
InstallPortable=Η φορητή εγκατάσταση
InstallPortable1=Διατηρεί την εφαρμογή και τα δεδομένα του χρήστη μαζί σε ένα φάκελο
InstallPortable2=Δεν δημιουργεί αποκλειστική εγκατάσταση ή δεν τροποποιεί την ενσωμάτωση του μητρώου και του συστήματος
LogsDirectory=Λογαριασμοί
ResetFoldersToDefault=Επανεγκατάσταση στο προεπιλεγμένο
RunVCMILauncherAfterInstall=Ξεκινήστε το VCMI Πηγή εκτόξευσης
SavesDirectory=Αποθηκευμένα παιχνίδια
ScanningFiles=Αναζήτηση αρχείων...
SelectSetupInstallModeDesc=Το VCMI μπορεί να εγκατασταθεί για όλους τους χρήστες, μόνο για εσάς ή σε φορητή λειτουργία.
SelectSetupInstallModeSubTitle=Επιλέξτε την προτιμώμενη λειτουργία εγκατάστασης:
SelectSetupInstallModeTitle=Επιλέξτε τη λειτουργία εγκατάστασης
SharedUserDataNotice=Τα δεδομένα χρήστη δεν μπορούν να διαγραφούν επειδή VCMI Η εγκατάσταση χρησιμοποιεί τον ίδιο κατάλογο.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Επισκεφτείτε τον αξιωματούχο VCMI Διαφωνία
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Ξεκινήστε το VCMI Πηγή εκτόξευσης
ShortcutMapEditor=VCMI Επισκόπηση χάρτης
ShortcutMapEditorComment=Ανοίξτε το VCMI Επισκόπηση χάρτης
ShortcutWebPage=VCMI Ιστοσελίδα
ShortcutWebPageComment=Επισκεφτείτε τον αξιωματούχο VCMI ιστοσελίδα
SystemIntegration=Ενσωμάτωση του συστήματος
FileAssociations=Συσχετίσεις αρχείων
AssociateH3CFiles=Άνοιγμα εκστρατειών Heroes III (.h3c) στον επεξεργαστή χαρτών VCMI
H3CDescription=Εκστρατεία Heroes III
Uninstall=Αφαίρεση εγκατάστασης
UserDataDirectory=Δεδομένα χρηστών (Heroes III δεδομένα, τροποποιήσεις, χάρτες και άλλα αρχεία)
VCMISettings=Ρύθμιση συστήματος
VCMPDescription=VCMI Αρχείο Εκστρατείας
VMAPDescription=VCMI Αρχείο χάρτης
Warning=Προειδοποίηση
X86On64BitWarning=Εγκαθιστάτε το 32-bit (x86) της έκδοσης του VCMI Υποστηρίζεται, αλλά συνιστάται η εγγενής έκδοση 64 bits όταν είναι διαθέσιμη.
Heroes3ImportReparsePoint=Δεν είναι ασφαλής η εισαγωγή δεδομένων Heroes III, επειδή ένας υπάρχων φάκελος προορισμού περιέχει σημείο συνένωσης ή συμβολικό σύνδεσμο. Αφαιρέστε τον σύνδεσμο ή επιλέξτε άλλον φάκελο.
OpenSetupLog=Ανοίξτε λογισμικό εγκατάστασης
OpenSetupLogError=Το ημερολόγιο εγκατάστασης δεν μπορούσε να ανοίξει.
LegacyUninstallStartFailed=Δεν ήταν δυνατή η εκκίνηση του προηγούμενου προγράμματος απεγκατάστασης VCMI:%n%s
LegacyUninstallExitFailed=Το προηγούμενο πρόγραμμα απεγκατάστασης VCMI απέτυχε με κωδικό %s.
LegacyUninstallFailureChoice=Η Ματαίωση σταματά την εγκατάσταση. Η Επανάληψη εκτελεί ξανά το παλιό πρόγραμμα απεγκατάστασης. Η Παράβλεψη συνεχίζει με δική σας ευθύνη.
LegacyUninstallRequired=Δεν ήταν δυνατή η αφαίρεση της προηγούμενης εγκατάστασης VCMI. Δεν αντιγράφηκαν νέα αρχεία εγκατάστασης.
InstallDirectoryUsedByOtherInstallation=Ο κατάλογος εγκαταστάσεων επικαλύπτεται με άλλο εγγεγραμμένο κατάλογο VCMI εγκατάσταση:%n%s%n%nΕπιλέξτε διαφορετικό κατάλογο.
X86OnARM64Warning=Εγκαθιστάτε το 32-bit (x86) της έκδοσης του VCMI Ειδικότερα ARM64 Windows. Αυτό υποστηρίζεται, αλλά το εγγενές ARM64 συνιστάται η έκδοση όταν είναι διαθέσιμη.
RequirementsColumnComponent=Συστατικό
RequirementsColumnDetails=Απαιτείται
RequirementsColumnStatus=Κατάσταση
RequirementsColumnDetected=Το σύστημά σας
RequirementDetectedWindows=Συγκριτική εγκατάσταση Windows
RequirementWritableValue=Εγγράψιμος φάκελος
RequirementEnoughSpace=Αρκετός ελεύθερος χώρος
RequirementProcessor=Επεξεργαστής
RequirementProcessorValue=1 GHz ή ταχύτερα
RequirementMemory=Μνήμη RAM
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Διαθέσιμο περιβάλλον εκτέλεσης DirectX 11
RequirementDirectXMissing=Δεν βρέθηκε περιβάλλον εκτέλεσης DirectX 11
RequirementDetectionUnavailable=Δεν ήταν δυνατή η ανίχνευση
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Φάκελος εγκατάστασης
RequirementUserDataFolder=Φάκελος δεδομένων χρήστη
RequirementDiskSpace=Ελεύθερο χώρο σε δίσκο
RequirementFreeSpaceShortValue=%s
RequirementInternet=Διαδίκτυο
RequirementRecommended=Συνιστάται
RequirementInternetAvailable=Διαθέσιμη
RequirementInternetUnavailable=Δεν ανιχνεύεται
RequirementHeroesData=Δεδομένα Heroes III
RequirementRequiredToPlay=Απαιτείται για το παιχνίδι
RequirementHeroesDataAvailable=Διαθέσιμα στα δεδομένα χρήστη
RequirementHeroesDataMissing=Δεν βρέθηκε, μπορεί να εισαχθεί αργότερα
RequirementWritableAndSynced=Γράψιμο και συγχρονισμένο
RequirementNotWritable=Δεν επιτρέπεται εγγραφή
TasksCheckboxesTooltip=Επιλέξτε προαιρετικές ενσωματώσεις και ενέργειες. Οι συντομεύσεις διευκολύνουν την πρόσβαση, οι συσχετίσεις ανοίγουν υποστηριζόμενους χάρτες στον επεξεργαστή, οι κανόνες τείχους προστασίας επιτρέπουν παιχνίδι πολλών παικτών και η εισαγωγή αντιγράφει τα δεδομένα Heroes III που εντοπίστηκαν.
UninstallCheckboxesTooltip=Επιλέξτε μόνο τους φακέλους δεδομένων χρήστη που θέλετε να διαγράψετε οριστικά. Οι απενεργοποιημένες κοινόχρηστες εγγραφές χρησιμοποιούνται από άλλη εγκατάσταση του VCMI.
InstallModeTooltip=Όλοι οι χρήστες: εγκαθιστά το VCMI για όλους τους λογαριασμούς Windows, συνήθως στο Program Files. Απαιτεί έγκριση διαχειριστή. Δημιουργεί πληροφορίες απεγκατάστασης, εγγραφές μητρώου, συντομεύσεις, συσχετίσεις αρχείων και προαιρετικό κανόνα τείχους προστασίας για όλο το σύστημα. Τα δεδομένα παραμένουν στον επιλεγμένο φάκελο.%n%nΤρέχων χρήστης: εγκαθιστά το VCMI μόνο για τον συνδεδεμένο λογαριασμό Windows, συνήθως στο Local AppData, χωρίς έγκριση διαχειριστή. Δημιουργεί πρόγραμμα απεγκατάστασης και ενσωματώσεις για αυτόν τον χρήστη. Οι άλλοι λογαριασμοί δεν βλέπουν την εγκατάσταση. Το Τείχος προστασίας των Windows μπορεί να ζητήσει άδεια κατά την πρώτη χρήση παιχνιδιού πολλών παικτών.%n%nΦορητή: κρατά την εφαρμογή και τα δεδομένα μαζί στον επιλεγμένο φάκελο. Δεν δημιουργεί πρόγραμμα απεγκατάστασης, εγγραφές μητρώου, συντομεύσεις, συσχετίσεις ή κανόνες τείχους προστασίας. Ο φάκελος πρέπει να παραμένει εγγράψιμος. Μετακινήστε ή αντιγράψτε τον για μεταφορά της εγκατάστασης ή διαγράψτε τον για απεγκατάσταση.
CopyH3FilesTooltip=Αντιγράφει τους φακέλους Data, Maps και Mp3 του Heroes III που εντοπίστηκαν στον επιλεγμένο φάκελο δεδομένων χρήστη του VCMI. Τα αρχικά αρχεία δεν αλλάζουν.
ReadyHeroes3Import=Εισαγωγή δεδομένων Heroes III:

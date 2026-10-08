; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI-asennuksen omat parametrit:%n  /USERDATADIR=<polku>  Määrittää VCMI-käyttäjätietojen kansion. Etuliite expand: laajentaa Inno Setup -vakiot.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Asentaa sovelluksen ja tiedot samaan kansioon ilman poistajaa, rekisterimuutoksia, pikakuvakkeita, tiedostokytkentöjä tai palomuurisääntöjä.%n  /LAUNCH  Käynnistää VCMI:n asennuksen jälkeen myös hiljaisessa asennuksessa.%n%nVCMI-poistajan parametri:%n  /DELETEUSERDATA=1  Poistaa kaikki määritetyt VCMI-käyttäjäkansiot. Toimii vain /SILENT- tai /VERYSILENT-parametrin kanssa. Toimintoa ei voi kumota.%n%nVakioparametrit, kuten /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART ja /LOG, kuvataan yllä.
WindowsVersionNotSupported=Tämä ohjelma ei voi toimia Windows-versiossasi. Varmista, että käytät oikeaa Windows-arkkitehtuuria (32-bittinen tai 64-bittinen) ja oikeaa ohjelmaversiota.
PrivilegesRequiredOverrideTitle=Asennustila – käyttöoikeudet
PrivilegesRequiredOverrideInstruction=Valitse, miten asennusohjelma suoritetaan
PrivilegesRequiredOverrideText1=%1 vaatii järjestelmänvalvojan oikeudet, jos se asennetaan kaikille käyttäjille.%nVoit myös asentaa sen vain omaan käyttöösi ilman järjestelmänvalvojan oikeuksia.
PrivilegesRequiredOverrideText2=%1 voidaan asentaa vain omaan käyttöösi (ei vaadi järjestelmänvalvojan oikeuksia) tai kaikille käyttäjille (vaatii järjestelmänvalvojan oikeudet).
PrivilegesRequiredOverrideAllUsers=Suorita &järjestelmänvalvojana (asennus kaikille käyttäjille)
PrivilegesRequiredOverrideAllUsersRecommended=Suorita &järjestelmänvalvojana (suositus)
PrivilegesRequiredOverrideCurrentUser=Suorita &normaalina käyttäjänä (asennus vain minulle)
PrivilegesRequiredOverrideCurrentUserRecommended=Suorita &normaalina käyttäjänä (suositus)
ConfirmUninstall=Haluatko varmasti suorittaa %1 asennuksen poistotyökalun?

[CustomMessages]
AddFirewallRules=Lisää palomuurisäännöt VCMI:lle
AssociateH3MFiles=Liitä .h3m-tiedostot VCMI-karttaeditoriin
AssociateVCMIMapFiles=Liitä .vmap- ja .vcmp-tiedostot VCMI-karttaeditoriin
CacheDirectory=Välimuisti
CloudDataNotice=Tämä käyttäjätietohakemisto näyttää olevan pilvitallennuspalvelun synkronoima.
CloudDataWarning=Valittu käyttäjätietohakemisto näyttää olevan pilvitallennuspalvelun synkronoima. Synkronointi voi lukita tiedostoja väliaikaisesti ja aiheuttaa virheitä modien asennuksessa, pelin käynnistyksessä tai tallennuksessa.%n%nHaluatko silti käyttää tätä hakemistoa?
CloudInstallNotice=Tämä asennushakemisto näyttää olevan pilvitallennuspalvelun synkronoima.
CloudInstallWarning=Valittu asennushakemisto näyttää olevan pilvitallennuspalvelun synkronoima. Siirrettävä tai synkronoitu asennus voi epäonnistua, jos palvelu lukitsee sovelluksen tiedostoja väliaikaisesti.%n%nHaluatko silti käyttää tätä hakemistoa?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Asetukset
CopyH3Files=Kopioi automaattisesti Heroes III:n vaaditut tiedostot VCMI:hin
CreateDesktopShortcuts=Luo työpöytäkuvakkeet
CreateStartMenuShortcuts=Luo kuvakkeet Käynnistä-valikkoon
DataFolderDescription=Sisältää kopion annetuista Heroes III -tiedoista, muokkaukset, kartat, tallennetut pelit ja muut käyttäjätiedostot.
DataFolderTitle=Käyttäjätietojen kansio
DeleteUserData=Poista käyttäjätiedot
DeleteUserDataDescription=Valitse pysyvästi poistettavat kansiot. Valitsemattomat kansiot säilytetään. Toimintoa ei voi kumota.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Heroes 3 Karttatiedosto
InstallFolderTitle=Asennuskansio
InstallForAllUsers=Asenna kaikille käyttäjille
InstallForAllUsers1=Vaatii järjestelmänvalvojan oikeudet
InstallForMeOnly=Asenna vain minulle
InstallForMeOnly1=Palomuurikehote ilmestyy pelin ensimmäisen käynnistyksen yhteydessä
InstallForMeOnly2=LAN-pelit eivät toimi, jos palomuurisääntöä ei voida sallia
InstallPortable=Kannettava asennus
InstallPortable1=Säilyttää sovelluksen ja käyttäjätiedot yhdessä kansiossa
InstallPortable2=Ei luo asennuksen poistoa eikä muuta rekisteriä tai järjestelmäintegraatiota
LogsDirectory=Lokit
ResetFoldersToDefault=Palauta oletukset
RunVCMILauncherAfterInstall=Käynnistä VCMI Launcher
SavesDirectory=Tallennetut pelit
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI voidaan asentaa kaikille käyttäjille tai vain sinulle.
SelectSetupInstallModeSubTitle=Valitse haluamasi asennustila:
SelectSetupInstallModeTitle=Valitse asennustila
SharedUserDataNotice=Käyttäjätietoja ei voi poistaa, koska toinen VCMI-asennus käyttää samaa hakemistoa.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Vieraile VCMI:n virallisella Discord-kanavalla
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Käynnistä VCMI Launcher
ShortcutMapEditor=VCMI Karttaeditori
ShortcutMapEditorComment=Avaa VCMI Karttaeditori
ShortcutWebPage=VCMI-verkkosivu
ShortcutWebPageComment=Vieraile VCMI:n virallisella verkkosivustolla
SystemIntegration=Järjestelmäintegraatio
Uninstall=Poista asennus
UserDataDirectory=Käyttäjätiedot (Heroes III -tiedot, muokkaukset, kartat ja muut tiedostot)
VCMISettings=VCMI-asetukset
VCMPDescription=VCMI Kampanjatiedosto
VMAPDescription=VCMI Karttatiedosto
Warning=Varoitus
X86On64BitWarning=Olet asentamassa VCMI:n 32-bittistä (x86) versiota 64-bittiseen Windowsiin. Tätä tuetaan, mutta natiivia 64-bittistä versiota suositellaan, jos se on saatavilla.

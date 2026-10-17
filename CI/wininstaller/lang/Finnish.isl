;
; Finnish.isl, part of VCMI engine
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
HelpTextNote=VCMI-asennuksen parametrit:%n  /USERDATADIR=<path>  Määrittää VCMI:n käyttäjätietokansion. Etuliite expand: laajentaa Inno Setup -vakiot.%n  /ALLOWCLOUDTARGET=1  Sallii pilvipalveluun synkronoidun asennus- tai käyttäjätietokansion hiljaisessa asennuksessa.%n  /PORTABLE=1  Asentaa sovelluksen ja käyttäjätiedot yhdessä ilman poisto-ohjelmaa, rekisterimuutoksia, pikakuvakkeita, tiedostokytkentöjä tai palomuurisääntöjä.%n  /LAUNCH  Käynnistää VCMI:n asennuksen jälkeen myös hiljaisessa asennuksessa.%n  /COPYH3DATA=0|1  Ottaa löydettyjen Heroes III -tietojen automaattisen kopioinnin käyttöön tai poistaa sen käytöstä.%n%nTehtävien nimet parametreille /TASKS ja /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (vain kaikkien käyttäjien asennus järjestelmänvalvojan oikeuksilla)%n%nVCMI:n poisto-ohjelman parametri:%n  /DELETEUSERDATA=1  Poistaa kaikki määritetyt VCMI-käyttäjäkansiot. Toimii vain yhdessä parametrin /SILENT tai /VERYSILENT kanssa. Toimintoa ei voi kumota.%n%nVakioparametrit on kuvattu edellä: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Tämä ohjelma ei voi toimia Windows-versiossasi. Varmista, että käytät oikeaa Windows-arkkitehtuuria (x86 / x64 / ARM64) ja oikeaa ohjelmaversiota.
PrivilegesRequiredOverrideTitle=Asennustila – käyttöoikeudet
PrivilegesRequiredOverrideInstruction=Valitse, miten asennusohjelma suoritetaan
PrivilegesRequiredOverrideText1=%1 vaatii järjestelmänvalvojan oikeudet, jos se asennetaan kaikille käyttäjille. Voit myös asentaa sen vain omaan käyttöösi ilman järjestelmänvalvojan oikeuksia.
PrivilegesRequiredOverrideText2=%1 voidaan asentaa vain omaan käyttöösi (ei vaadi järjestelmänvalvojan oikeuksia) tai kaikille käyttäjille (vaatii järjestelmänvalvojan oikeudet).
PrivilegesRequiredOverrideAllUsers=Suorita &järjestelmänvalvojana (asennus kaikille käyttäjille)
PrivilegesRequiredOverrideAllUsersRecommended=Suorita &järjestelmänvalvojana (suositus)
PrivilegesRequiredOverrideCurrentUser=Suorita &normaalina käyttäjänä (asennus vain minulle)
PrivilegesRequiredOverrideCurrentUserRecommended=Suorita &normaalina käyttäjänä (suositus)
ConfirmUninstall=Haluatko varmasti suorittaa %1 asennuksen poistotyökalun?

[CustomMessages]
DesktopShortcuts=Työpöydän pikakuvakkeet
StartMenuShortcuts=Käynnistä-valikon pikakuvakkeet
WelcomeDescription=VCMI on avoimen lähdekoodin Heroes III -pelimoottori, joka tarjoaa uusia ja laajennettuja mahdollisuuksia. VCMI:n käyttö edellyttää alkuperäisten pelitiedostojen omistamista.%n%nTämä ohjattu toiminto asentaa VCMI - Open Heroes 3:n laitteellesi.%n%nOn suositeltavaa sulkea kaikki muut sovellukset ennen jatkamista.%n%nJatka valitsemalla Seuraava tai poistu asennuksesta valitsemalla Peruuta.
WelcomeHighlightsTitle=Tietoja VCMI:stä
WelcomeHighlights=VCMI on yhteisön kehittämä Heroes of Might and Magic III -pelimoottorin uudelleentoteutus. Projekti säilyttää alkuperäisen pelin hengen, poistaa klassisen moottorin teknisiä rajoituksia ja tarjoaa avoimen perustan modeille ja jatkokehitykselle.
RequirementImportSpaceHelp=Palaa takaisin ja valitse toinen käyttäjätietokansio tai poista Heroes III -tietojen automaattinen kopiointi käytöstä.
RequirementDisableImportQuestion=Haluatko jatkaa kopioimatta Heroes III -tietoja?
RequirementFirewall=Palomuuri
RequirementMultiplayerGames=Moninpelit
RequirementSelected=Valittu
RequirementNotSelected=Ei valittu — samalla tietokoneella pelaaminen toimii
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Lisää palomuurisäännöt moninpelejä varten
AssociateH3MFiles=Liitä .h3m-tiedostot VCMI-karttaeditoriin
AssociateVCMIMapFiles=Liitä .vmap- ja .vcmp-tiedostot VCMI-karttaeditoriin
CacheDirectory=Välimuisti
CloudDataNotice=Tämä käyttäjätietohakemisto näyttää olevan pilvitallennuspalvelun synkronoima.
CloudDataWarning=Valittu käyttäjätietohakemisto näyttää olevan pilvitallennuspalvelun synkronoima. Synkronointi voi lukita tiedostoja väliaikaisesti ja aiheuttaa virheitä modien asennuksessa, pelin käynnistyksessä tai tallennuksessa.%n%nHaluatko silti käyttää tätä hakemistoa?
CloudInstallNotice=Tämä asennushakemisto näyttää olevan pilvitallennuspalvelun synkronoima.
CloudInstallWarning=Valittu asennushakemisto näyttää olevan pilvitallennuspalvelun synkronoima. Siirrettävä tai synkronoitu asennus voi epäonnistua, jos palvelu lukitsee sovelluksen tiedostoja väliaikaisesti.%n%nHaluatko silti käyttää tätä hakemistoa?
CloudTargetSilentError=Hiljainen asennus ei voi käyttää pilvipalveluun synkronoitua kohdetta ilman parametria /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Heroes III -tiedostoja (%s) ei voitu kopioida. Osa tiedostoista on ehkä jo kopioitu; voit toistaa tuonnin turvallisesti.
CopyingHeroes3Data=Kopioidaan Heroes III -tietoja...
ConfigDirectory=Asetukset
CopyH3Files=Kopioi automaattisesti Heroes III:n vaaditut tiedostot VCMI:hin
CreateDesktopShortcuts=Luo työpöytäkuvakkeet
CreateStartMenuShortcuts=Luo kuvakkeet Käynnistä-valikkoon
DataFolderDescription=Sisältää kopion annetuista Heroes III -tiedoista, muokkaukset, kartat, tallennetut pelit ja muut käyttäjätiedostot.
DataFolderTitle=Käyttäjätietojen kansio
DeleteUserData=Poista käyttäjätiedot
DeleteUserDataDescription=Valitse pysyvästi poistettavat kansiot. Valitsemattomat kansiot säilytetään. Toimintoa ei voi kumota.
DeletingUserData=Poistetaan käyttäjätietoja...
DirectoryConfigWriteError=Käyttäjäkansioiden asetuksia ei voitu tallentaa kohteeseen %s. Asennusta ei voi jatkaa turvallisesti.
DirectoryNotWritable=Valittuun kansioon (%s) ei voi kirjoittaa. Valitse toinen kansio tai suorita asennus tarvittavilla oikeuksilla.%n%n%s
DirectoryRootNotAllowed=Valittu kansio (%s) ei voi olla aseman tai verkkojaon juuri. Valitse erillinen kansio.%n%n%s
DirectoryOverlapError=Asennus- ja käyttäjätietokansiot eivät saa olla samoja tai mennä vaarallisesti päällekkäin. Vain siirrettävä asennus voi säilyttää tiedot asennuskansiossa.
ReadyUserDataLocation=Käyttäjätietojen sijainti:
RequirementPassed=HYVÄKSYTTY
RequirementFailed=HYLÄTTY
RequirementWarning=VAROITUS
RequirementInfo=TIEDOKSI
RequirementOperatingSystem=Käyttöjärjestelmä
RequirementOperatingSystemValue=Windows 7 SP1 tai uudempi; yhteensopivuuden ajoaika mukaan luettuna tarvittaessa
RequirementArchitecture=Arkkitehtuuri
RequirementInstallWritable=Asennuskansioon voi kirjoittaa
RequirementDataWritable=Käyttäjätietokansioon voi kirjoittaa
RequirementDirectoryLayout=Ohjelman suunnittelu
RequirementDirectoryLayoutValue=Asennus- ja käyttäjätietopolut on erotettu turvallisesti
RequirementApplicationSpace=Sovelluksen levytilaa
RequirementFreeSpaceValue=%s Mt vapaana; asennusohjelma tarkistaa myös paketin lopullisen koon
RequirementHeroesDataSpace=Heroes III -tietojen tuonti
RequirementInsufficientSpace=Valittujen Heroes III -tietojen tuontiin ei ole riittävästi vapaata tilaa
RequirementRequiredSpaceValue=Valittuun tuontiin tarvitaan noin %s Mt
RequirementNotRequested=Heroes III -tietojen tuontia ei ole valittu
RequirementCloudStorage=Säilytyssynkronointi
RequirementCloudStorageValue=Valittu polku näyttää käyttävän pilvi-synkronointia
RequirementLocalStorageValue=Valitut polut näyttävät käyttävän paikallista tallennusta
RequirementInstallationMode=Asennusmuodi
RequirementModePortable=Lähetävä; ei purkaajaa, rekisteriä tai järjestelmän integrointia
RequirementModeAllUsers=Kaikki käyttäjät
RequirementModeCurrentUser=Nykyinen käyttäjä
RequirementUpgrade=olemassa oleva asennus päivitetään
RequirementsCheckTitle=Systeemivaatimusten tarkistaminen
RequirementsCheckDescription=Asennus tarkisti valitun konfiguraation ennen asennusta.
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
ScanningFiles=Etsitään tiedostoja...
SelectSetupInstallModeDesc=VCMI voidaan asentaa kaikille käyttäjille, vain sinulle tai siirrettävänä asennuksena.
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
FileAssociations=Tiedostoyhdistelmät
AssociateH3CFiles=Avaa Heroes III -kampanjat (.h3c) VCMI-karttaeditorissa
H3CDescription=Heroes III -kampanja
Uninstall=Poista asennus
UserDataDirectory=Käyttäjätiedot (Heroes III -tiedot, muokkaukset, kartat ja muut tiedostot)
VCMISettings=Järjestelmäasetukset
VCMPDescription=VCMI Kampanjatiedosto
VMAPDescription=VCMI Karttatiedosto
Warning=Varoitus
X86On64BitWarning=Olet asentamassa VCMI:n 32-bittistä (x86) versiota 64-bittiseen Windowsiin. Tätä tuetaan, mutta natiivia 64-bittistä versiota suositellaan, jos se on saatavilla.
Heroes3ImportReparsePoint=Heroes III -tietoja ei voi tuoda turvallisesti, koska olemassa oleva kohdekansio sisältää liitoskohdan tai symbolisen linkin. Poista linkki tai valitse toinen kansio.
OpenSetupLog=Avaa asennuspäiväkirja
OpenSetupLogError=Asennuspäiväkirjaa ei voitu avata.
LegacyUninstallStartFailed=Edellistä VCMI-poisto-ohjelmaa ei voitu käynnistää:%n%s
LegacyUninstallExitFailed=Edellinen VCMI-poisto-ohjelma päättyi virhekoodiin %s.
LegacyUninstallFailureChoice=Keskeytä lopettaa asennuksen. Yritä uudelleen käynnistää vanhan poisto-ohjelman uudestaan. Ohita jatkaa omalla vastuullasi.
LegacyUninstallRequired=Edellistä VCMI-asennusta ei voitu poistaa. Uusia asennustiedostoja ei kopioitu.
InstallDirectoryUsedByOtherInstallation=Asennusluettelo kattaa toisen rekisteröidyn VCMI asennus:%n%s%n%nValitse toinen luettelo.
X86OnARM64Warning=Asennat 32-bitin (x86) versio VCMI Ehdotukset ARM64 Windows. Tämä on tukematon, mutta alkuperäinen ARM64 Versio on suositeltavaa, jos se on saatavilla.
RequirementsColumnComponent=Komponentti
RequirementsColumnDetails=Vaatimukset
RequirementsColumnStatus=Tilanne
RequirementsColumnDetected=Järjestelmäsi
RequirementDetectedWindows=Windowsin yhteensopiva asennus
RequirementWritableValue=Kirjoituskelpoinen kansio
RequirementEnoughSpace=Riittävästi vapaata tilaa
RequirementProcessor=Käsittelijä
RequirementProcessorValue=1 GHz tai nopeampi
RequirementMemory=Keskusmuisti
RequirementMemoryValue=1 GB RAM:ta
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 -ajonaikainen ympäristö on saatavilla
RequirementDirectXMissing=DirectX 11 -ajonaikaista ympäristöä ei löytynyt
RequirementDetectionUnavailable=Ei voitu tunnistaa
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Asennuskansio
RequirementUserDataFolder=Käyttäjätietokansio
RequirementDiskSpace=Vapaan levytilaa
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Suositeltu
RequirementInternetAvailable=Käytettävissä
RequirementInternetUnavailable=Ei havaittu
RequirementHeroesData=Heroes III -tiedot
RequirementRequiredToPlay=Tarvitaan pelaamiseen
RequirementHeroesDataAvailable=Löytyvät käyttäjätiedoista
RequirementHeroesDataMissing=Ei löytynyt; voidaan tuoda myöhemmin
RequirementWritableAndSynced=Kirjoittavissa ja synkronoituina
RequirementNotWritable=Ei kirjoitusoikeutta
TasksCheckboxesTooltip=Valitse valinnaiset integraatiot ja toiminnot. Pikakuvakkeet helpottavat käyttöä, tiedostokytkennät avaavat tuetut kartat editorissa, palomuurisäännöt sallivat moninpelin ja tuonti kopioi löydetyt Heroes III -tiedot.
UninstallCheckboxesTooltip=Valitse vain ne käyttäjätietokansiot, jotka haluat poistaa pysyvästi. Käytöstä poistetut jaetut kohteet ovat toisen VCMI-asennuksen käytössä.
InstallModeTooltip=Kaikki käyttäjät: asentaa VCMI:n kaikille Windows-tileille, yleensä Program Files -kansioon. Vaatii järjestelmänvalvojan hyväksynnän. Luo järjestelmänlaajuiset poistotiedot, rekisterimerkinnät, pikakuvakkeet, tiedostokytkennät ja valinnaisen palomuurisäännön. Käyttäjätiedot säilyvät valitussa kansiossa.%n%nNykyinen käyttäjä: asentaa VCMI:n vain kirjautuneelle Windows-tilille, yleensä Local AppData -kansioon, ilman järjestelmänvalvojan hyväksyntää. Luo käyttäjäkohtaisen poisto-ohjelman ja integraatiot. Muut tilit eivät näe tätä asennusta. Windowsin palomuuri voi pyytää lupaa moninpelin ensimmäisellä käyttökerralla.%n%nSiirrettävä: säilyttää sovelluksen ja käyttäjätiedot yhdessä valitussa kansiossa. Ei luo poisto-ohjelmaa, rekisterimerkintöjä, pikakuvakkeita, tiedostokytkentöjä eikä palomuurisääntöjä. Kansion täytyy pysyä kirjoituskelpoisena. Siirrä tai kopioi kansio siirtääksesi asennuksen; poista kansio poistaaksesi asennuksen.
CopyH3FilesTooltip=Kopioi löydetyt Heroes III -kansiot Data, Maps ja Mp3 valittuun VCMI-käyttäjätietokansioon. Alkuperäiset tiedostot säilyvät muuttumattomina.
ReadyHeroes3Import=Heroes III -tietojen tuonti:

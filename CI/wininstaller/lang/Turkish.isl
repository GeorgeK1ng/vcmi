;
; Turkish.isl, part of VCMI engine
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
HelpTextNote=VCMI kurulum parametreleri:%n  /USERDATADIR=<path>  VCMI kullanıcı verileri klasörünü ayarlar. expand: öneki Inno Setup sabitlerini genişletir.%n  /ALLOWCLOUDTARGET=1  Sessiz kurulumda bulutla eşitlenen bir kurulum veya kullanıcı verileri klasörünün kullanılmasına izin verir.%n  /PORTABLE=1  Uygulamayı ve verileri kaldırıcı, kayıt defteri değişiklikleri, kısayollar, dosya ilişkilendirmeleri veya güvenlik duvarı kuralları olmadan birlikte kurar.%n  /LAUNCH  Sessiz kurulum dahil, kurulumdan sonra VCMI'yi başlatır.%n  /COPYH3DATA=0|1  Bulunan Heroes III verilerinin otomatik kopyalanmasını açar veya kapatır.%n%n/TASKS ve /MERGETASKS için görev adları:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (yalnızca yönetici yetkileriyle tüm kullanıcılar için kurulumda)%n%nVCMI kaldırma parametresi:%n  /DELETEUSERDATA=1  Yapılandırılmış tüm VCMI kullanıcı klasörlerini siler. Yalnızca /SILENT veya /VERYSILENT ile birlikte çalışır. Bu işlem geri alınamaz.%n%nStandart parametreler yukarıda açıklanmıştır: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Bu program, Windows sürümünüzde çalistirilamaz. Lütfen dogru Windows mimarisini (x86 / x64 / ARM64) ve bu programa uygun sürümü kullandiginizdan emin olun.
PrivilegesRequiredOverrideTitle=Kurulum Kipi – Yetkiler
PrivilegesRequiredOverrideInstruction=Yükleyicinin nasıl çalıştırılacağını seçin
PrivilegesRequiredOverrideText1=%1 tüm kullanıcılar için kurulacaksa yönetici izinleri gerekir. Yönetici izni olmadan yalnızca kendi hesabınıza da kurabilirsiniz.
PrivilegesRequiredOverrideText2=%1 yalnızca kendi hesabınıza (yönetici izni olmadan) veya tüm kullanıcılar için (yönetici izinleri gerekir) kurulabilir.
PrivilegesRequiredOverrideAllUsers=&Yönetici olarak çalıştır (tüm kullanıcılar için kurulum)
PrivilegesRequiredOverrideAllUsersRecommended=&Yönetici olarak çalıştır (önerilen)
PrivilegesRequiredOverrideCurrentUser=&Standart kullanıcı olarak çalıştır (yalnızca benim için kurulum)
PrivilegesRequiredOverrideCurrentUserRecommended=&Standart kullanıcı olarak çalıştır (önerilen)
ConfirmUninstall=%1 kaldirma sihirbazini çalistirmak istediginizden emin misiniz?

[CustomMessages]
DesktopShortcuts=Masaüstü kısayolları
StartMenuShortcuts=Başlat Menüsü kısayolları
WelcomeDescription=VCMI, Heroes III için yeni ve genişletilmiş olanaklar sunan açık kaynaklı bir oyun motorudur. VCMI'yi kullanmak için özgün oyunun veri dosyalarına sahip olmanız gerekir.%n%nBu sihirbaz cihazınıza VCMI - Open Heroes 3 yükleyecektir.%n%nDevam etmeden önce diğer tüm uygulamaları kapatmanız önerilir.%n%nDevam etmek için İleri'yi, kurulumdan çıkmak için İptal'i tıklayın.
WelcomeHighlightsTitle=VCMI hakkında
WelcomeHighlights=VCMI, Heroes of Might and Magic III motorunun topluluk tarafından geliştirilen yeniden uygulamasıdır. Proje özgün oyunun ruhunu korur, klasik motorun teknik sınırlarını aşar ve modlar ile sürekli geliştirme için açık bir temel sunar.
RequirementImportSpaceHelp=Geri dönüp başka bir kullanıcı verisi klasörü seçin veya Heroes III verilerinin otomatik kopyalanmasını kapatın.
RequirementDisableImportQuestion=Heroes III verilerini kopyalamadan devam etmek istiyor musunuz?
RequirementFirewall=Güvenlik duvarı
RequirementMultiplayerGames=Çok oyunculu oyunlar
RequirementSelected=Seçildi
RequirementNotSelected=Seçilmedi — aynı bilgisayarda sırayla oynama çalışmaya devam eder
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Çok oyunculu oyunlar için güvenlik duvarı kuralları ekle
AssociateH3MFiles=.h3m dosyalarini VCMI Harita Editörü ile iliskilendir
AssociateVCMIMapFiles=.vmap ve .vcmp dosyalarini VCMI Harita Editörü ile iliskilendir
CacheDirectory=Önbellek
CloudDataNotice=Bu kullanıcı verileri dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor.
CloudDataWarning=Seçilen kullanıcı verileri dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor. Eşitleme dosyaları geçici olarak kilitleyebilir ve mod kurulumu, oyunun başlatılması veya kayıt sırasında hatalara neden olabilir.%n%nYine de bu dizini kullanmak istiyor musunuz?
CloudInstallNotice=Bu kurulum dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor.
CloudInstallWarning=Seçilen kurulum dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor. Sağlayıcı uygulama dosyalarını geçici olarak kilitlerse taşınabilir veya eşitlenmiş kurulum başarısız olabilir.%n%nYine de bu dizini kullanmak istiyor musunuz?
CloudTargetSilentError=Sessiz kurulum, /ALLOWCLOUDTARGET=1 olmadan bulutla eşitlenen bir hedefi kullanamaz.
CopyH3FilesError=Heroes III dosyaları (%s) kopyalanamadı. Bazı dosyalar zaten kopyalanmış olabilir; içe aktarmayı güvenle yeniden çalıştırabilirsiniz.
CopyingHeroes3Data=Heroes III verileri kopyalanıyor...
ConfigDirectory=Yapılandırma
CopyH3Files=Gerekli Heroes III dosyalarini VCMI'ya otomatik olarak kopyala
CreateDesktopShortcuts=Masaüstü kisayollari olustur
CreateStartMenuShortcuts=Baslat Menüsüne kisayollar ekle
DataFolderDescription=Sağlanan Heroes III verilerinin bir kopyasını, modifikasyonları, haritaları, kayıtlı oyunları ve diğer kullanıcı dosyalarını içerir.
DataFolderTitle=Kullanıcı verileri klasörü
DeleteUserData=Kullanici verilerini sil
DeleteUserDataDescription=Kalıcı olarak silinecek klasörleri seçin. İşaretlenmeyen klasörler korunur. Bu işlem geri alınamaz.
DeletingUserData=Kullanıcı verileri siliniyor...
DirectoryConfigWriteError=Kullanıcı klasörü ayarları %s konumuna kaydedilemedi. Kurulum güvenli bir şekilde devam edemez.
DirectoryNotWritable=Seçilen klasöre (%s) yazılamıyor. Başka bir klasör seçin veya kurulumu gerekli yetkilerle çalıştırın.%n%n%s
DirectoryRootNotAllowed=Seçilen klasör (%s) bir sürücünün ya da ağ paylaşımının kökü olamaz. Ayrı bir klasör seçin.%n%n%s
DirectoryOverlapError=Kurulum ve kullanıcı verileri klasörleri aynı olamaz veya güvenli olmayan biçimde iç içe geçemez. Yalnızca taşınabilir kurulum, kullanıcı verilerini kurulum klasöründe tutabilir.
ReadyUserDataLocation=Kullanıcı verilerinin konumu:
RequirementPassed=KARŞILANDI
RequirementFailed=HATA
RequirementWarning=UYARI
RequirementInfo=BİLGİ
RequirementOperatingSystem=Çalışma sistemi
RequirementOperatingSystemValue=Windows 7 SP1 veya daha yeni; gerektiğinde uyumluluk çalıştırma süresi dahil
RequirementArchitecture=Mimari
RequirementInstallWritable=Kurulum klasörü yazılabilir
RequirementDataWritable=Kullanıcı verileri klasörü yazılabilir
RequirementDirectoryLayout=Dizin düzenlemesi
RequirementDirectoryLayoutValue=Kurulum ve kullanıcı verileri yolları güvenli biçimde ayrılmış
RequirementApplicationSpace=Uygulama disk alanı
RequirementFreeSpaceValue=%s MB boş; kurulum son paket boyutunu da denetler
RequirementHeroesDataSpace=Heroes III verilerini içe aktarma
RequirementInsufficientSpace=Seçilen Heroes III verilerini içe aktarmak için yeterli boş alan yok
RequirementRequiredSpaceValue=Seçilen içe aktarma için yaklaşık %s MB gerekli
RequirementNotRequested=Heroes III verilerini içe aktarma seçilmedi
RequirementCloudStorage=Depolama senkronizasyonu
RequirementCloudStorageValue=Seçilen bir yol bulut senkronizasyonu kullanıyor gibi görünüyor
RequirementLocalStorageValue=Seçilen yollar yerel depolama kullanıyor gibi görünüyor
RequirementInstallationMode=Kurulum modu
RequirementModePortable=Aktarılabilir; çıkartıcı, kayıtlık veya sistem entegrasyonu yoktur
RequirementModeAllUsers=Tüm kullanıcılar
RequirementModeCurrentUser=Geçerli kullanıcı
RequirementUpgrade=mevcut kurulum yükseltilecek
RequirementsCheckTitle=Sistem Gereksinimleri Kontrolü
RequirementsCheckDescription=Kurulum kurulmadan önce seçilen yapılandırmayı kontrol etti.
H3MDescription=Heroes 3 Harita Dosyasi
InstallFolderTitle=Kurulum klasörü
InstallForAllUsers=Tüm kullanicilar için yükle
InstallForAllUsers1=Yönetici yetkileri gerektirir
InstallForMeOnly=Sadece benim için yükle
InstallForMeOnly1=Oyunu ilk kez baslattiginizda bir güvenlik duvari uyarisi görüntülenecek
InstallForMeOnly2=Güvenlik duvari kuralina izin verilmezse LAN oyunlari çalismaz
InstallPortable=Taşınabilir kurulum
InstallPortable1=Uygulamayı ve kullanıcı verilerini tek bir klasörde birlikte tutar
InstallPortable2=Kaldırıcı oluşturmaz, kayıt defterini veya sistem bütünleştirmesini değiştirmez
LogsDirectory=Günlükler
ResetFoldersToDefault=Varsayılana sıfırla
RunVCMILauncherAfterInstall=VCMI Baslaticiyi Çalistir
SavesDirectory=Kayıtlı oyunlar
ScanningFiles=Dosyalar taranıyor...
SelectSetupInstallModeDesc=VCMI tüm kullanıcılar için, yalnızca sizin için veya taşınabilir modda kurulabilir.
SelectSetupInstallModeSubTitle=Tercih ettiginiz kurulum modunu seçin:
SelectSetupInstallModeTitle=Kurulum Modunu Seçin
SharedUserDataNotice=Başka bir VCMI kurulumu aynı dizini kullandığı için kullanıcı verileri silinemez.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=VCMI Resmi Discord Sunucusunu Ziyaret Et
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=VCMI Baslaticiyi Çalistir
ShortcutMapEditor=VCMI Harita Editörü
ShortcutMapEditorComment=VCMI Harita Editörünü Aç
ShortcutWebPage=VCMI Web Sitesi
ShortcutWebPageComment=VCMI Resmi Web Sitesini Ziyaret Et
SystemIntegration=Sistem Entegrasyonu
FileAssociations=Dosya ilişkilendirmeleri
AssociateH3CFiles=Heroes III seferlerini (.h3c) VCMI Harita Düzenleyicisinde aç
H3CDescription=Heroes III Seferi
Uninstall=Kaldir
UserDataDirectory=Kullanıcı verileri (Heroes III verileri, modifikasyonlar, haritalar ve diğer dosyalar)
VCMISettings=Sistem yapılandırması
VCMPDescription=VCMI Kampanya Dosyasi
VMAPDescription=VCMI Harita Dosyasi
Warning=Uyari
X86On64BitWarning=VCMI'nin 32 bit (x86) sürümünü 64 bit Windows'a yüklüyorsunuz. Bu desteklenir, ancak mevcut olduğunda yerel 64 bit sürüm önerilir.
Heroes3ImportReparsePoint=Mevcut hedef klasör bir bağlantı noktası veya sembolik bağlantı içerdiğinden Heroes III verileri güvenle içe aktarılamaz. Bağlantıyı kaldırın veya başka bir klasör seçin.
OpenSetupLog=Kurulum günlüğünü aç
OpenSetupLogError=Kurulum günlüğü açılamadı.
LegacyUninstallStartFailed=Önceki VCMI kaldırıcısı başlatılamadı:%n%s
LegacyUninstallExitFailed=Önceki VCMI kaldırıcısı %s çıkış koduyla başarısız oldu.
LegacyUninstallFailureChoice=Durdur kurulumu durdurur. Yeniden dene eski kaldırıcıyı tekrar çalıştırır. Yoksay riskleri kabul ederek devam eder.
LegacyUninstallRequired=Önceki VCMI kurulumu kaldırılamadı. Yeni kurulum dosyaları kopyalanmadı.
InstallDirectoryUsedByOtherInstallation=Kurulum Dizini, başka bir kayıtlı dosya ile örtüşmektedir. VCMI Kurulum:%n%s%n%nFarklı bir dizin seçin.
X86OnARM64Warning=32 bit (x86) versiyonu VCMI Üzerinde ARM64 Windows. Bu desteklenir, ama yerel ARM64 kullanılabilir olduğunda bir versiyon önerilmektedir.
RequirementsColumnComponent=Komponent
RequirementsColumnDetails=Gerekli
RequirementsColumnStatus=Durum
RequirementsColumnDetected=Sisteminiz
RequirementDetectedWindows=Uyumlu Windows kurulum
RequirementWritableValue=Yazılabilir klasör
RequirementEnoughSpace=Yeterli boş alan
RequirementProcessor=İşlemci
RequirementProcessorValue=1 GHz veya daha hızlı
RequirementMemory=Bellek
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=DirectX 11 çalışma zamanı kullanılabilir
RequirementDirectXMissing=DirectX 11 çalışma zamanı bulunamadı
RequirementDetectionUnavailable=Algılanamadı
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Kurulum klasörü
RequirementUserDataFolder=Kullanıcı verileri klasörü
RequirementDiskSpace=Boş disk alanı
RequirementFreeSpaceShortValue=%s
RequirementInternet=İnternet
RequirementRecommended=Önerilen
RequirementInternetAvailable=Kullanılabilir
RequirementInternetUnavailable=tespit edilmedi
RequirementHeroesData=Heroes III verileri
RequirementRequiredToPlay=Oynamak için gerekli
RequirementHeroesDataAvailable=Kullanıcı verilerinde bulundu
RequirementHeroesDataMissing=Bulunmadı; daha sonra ithalat edilebilir
RequirementWritableAndSynced=Yazılabilir ve senkronize edilebilir
RequirementNotWritable=Yazılamaz
TasksCheckboxesTooltip=İsteğe bağlı bütünleştirmeleri ve işlemleri seçin. Kısayollar erişimi kolaylaştırır, dosya ilişkilendirmeleri desteklenen haritaları düzenleyicide açar, güvenlik duvarı kuralları çok oyunculu oyuna izin verir ve içe aktarma bulunan Heroes III verilerini kopyalar.
UninstallCheckboxesTooltip=Yalnızca kalıcı olarak silmek istediğiniz kullanıcı verileri klasörlerini seçin. Devre dışı paylaşılan öğeler başka bir VCMI kurulumu tarafından kullanılır.
InstallModeTooltip=Tüm kullanıcılar: VCMI'yi tüm Windows hesapları için, genellikle Program Files klasörüne kurar. Yönetici onayı gerektirir. Sistem genelinde kaldırma bilgileri, kayıt defteri girdileri, kısayollar, dosya ilişkilendirmeleri ve isteğe bağlı güvenlik duvarı kuralı oluşturur. Veriler seçilen klasörde kalır.%n%nGeçerli kullanıcı: VCMI'yi yalnızca oturum açmış Windows hesabı için, genellikle Local AppData klasörüne, yönetici onayı olmadan kurar. Bu kullanıcıya özel kaldırıcı ve bütünleştirmeler oluşturur. Diğer hesaplar bu kurulumu görmez. Çok oyunculu oyun ilk kullanıldığında Windows Güvenlik Duvarı izin isteyebilir.%n%nTaşınabilir: Uygulamayı ve verileri seçilen klasörde bir arada tutar. Kaldırıcı, kayıt defteri girdileri, kısayollar, dosya ilişkilendirmeleri veya güvenlik duvarı kuralları oluşturmaz. Klasör yazılabilir kalmalıdır. Kurulumu aktarmak için klasörü taşıyın veya kopyalayın; kaldırmak için silin.
CopyH3FilesTooltip=Bulunan Heroes III Data, Maps ve Mp3 klasörlerini seçilen VCMI kullanıcı verileri klasörüne kopyalar. Özgün dosyalar değiştirilmez.
ReadyHeroes3Import=Heroes III verilerini içe aktarma:

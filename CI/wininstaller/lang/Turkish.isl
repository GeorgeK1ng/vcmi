; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=VCMI'ye özel kurulum parametreleri:%n  /USERDATADIR=<yol>  VCMI kullanıcı verileri klasörünü ayarlar. expand: öneki Inno Setup sabitlerini genişletir.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Uygulamayı ve verileri kaldırıcı, kayıt defteri değişikliği, kısayol, ilişkilendirme veya güvenlik duvarı kuralı olmadan birlikte kurar.%n  /LAUNCH  Sessiz kurulum dahil, kurulumdan sonra VCMI'yi başlatır.%n%nVCMI kaldırıcısı parametresi:%n  /DELETEUSERDATA=1  Yapılandırılmış tüm VCMI kullanıcı klasörlerini siler. Yalnızca /SILENT veya /VERYSILENT ile birlikte kabul edilir. Bu işlem geri alınamaz.%n%n/DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART ve /LOG gibi standart parametreler yukarıda açıklanmıştır.
WindowsVersionNotSupported=Bu program, Windows sürümünüzde çalistirilamaz. Lütfen dogru Windows mimarisini (32-bit veya 64-bit) ve bu programa uygun sürümü kullandiginizdan emin olun.
PrivilegesRequiredOverrideTitle=Kurulum Kipi – Yetkiler
PrivilegesRequiredOverrideInstruction=Yükleyicinin nasıl çalıştırılacağını seçin
PrivilegesRequiredOverrideText1=%1 tüm kullanıcılar için kurulacaksa yönetici izinleri gerekir.%nYönetici izni olmadan yalnızca kendi hesabınıza da kurabilirsiniz.
PrivilegesRequiredOverrideText2=%1 yalnızca kendi hesabınıza (yönetici izni olmadan) veya tüm kullanıcılar için (yönetici izinleri gerekir) kurulabilir.
PrivilegesRequiredOverrideAllUsers=&Yönetici olarak çalıştır (tüm kullanıcılar için kurulum)
PrivilegesRequiredOverrideAllUsersRecommended=&Yönetici olarak çalıştır (önerilen)
PrivilegesRequiredOverrideCurrentUser=&Standart kullanıcı olarak çalıştır (yalnızca benim için kurulum)
PrivilegesRequiredOverrideCurrentUserRecommended=&Standart kullanıcı olarak çalıştır (önerilen)
ConfirmUninstall=%1 kaldirma sihirbazini çalistirmak istediginizden emin misiniz?

[CustomMessages]
AddFirewallRules=VCMI için güvenlik duvari kurallari ekle
AssociateH3MFiles=.h3m dosyalarini VCMI Harita Editörü ile iliskilendir
AssociateVCMIMapFiles=.vmap ve .vcmp dosyalarini VCMI Harita Editörü ile iliskilendir
CacheDirectory=Önbellek
CloudDataNotice=Bu kullanıcı verileri dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor.
CloudDataWarning=Seçilen kullanıcı verileri dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor. Eşitleme dosyaları geçici olarak kilitleyebilir ve mod kurulumu, oyunun başlatılması veya kayıt sırasında hatalara neden olabilir.%n%nYine de bu dizini kullanmak istiyor musunuz?
CloudInstallNotice=Bu kurulum dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor.
CloudInstallWarning=Seçilen kurulum dizini bir bulut depolama sağlayıcısı tarafından eşitleniyor gibi görünüyor. Sağlayıcı uygulama dosyalarını geçici olarak kilitlerse taşınabilir veya eşitlenmiş kurulum başarısız olabilir.%n%nYine de bu dizini kullanmak istiyor musunuz?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Yapılandırma
CopyH3Files=Gerekli Heroes III dosyalarini VCMI'ya otomatik olarak kopyala
CreateDesktopShortcuts=Masaüstü kisayollari olustur
CreateStartMenuShortcuts=Baslat Menüsüne kisayollar ekle
DataFolderDescription=Sağlanan Heroes III verilerinin bir kopyasını, modifikasyonları, haritaları, kayıtlı oyunları ve diğer kullanıcı dosyalarını içerir.
DataFolderTitle=Kullanıcı verileri klasörü
DeleteUserData=Kullanici verilerini sil
DeleteUserDataDescription=Kalıcı olarak silinecek klasörleri seçin. İşaretlenmeyen klasörler korunur. Bu işlem geri alınamaz.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
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
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI tüm kullanicilar için veya sadece sizin için kurulabilir.
SelectSetupInstallModeSubTitle=Tercih ettiginiz kurulum modunu seçin:
SelectSetupInstallModeTitle=Kurulum Modunu Seçin
SharedUserDataNotice=Başka bir VCMI kurulumu aynı dizini kullandığı için kullanıcı verileri silinemez.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=VCMI Resmi Discord Sunucusunu Ziyaret Et
ShortcutLauncher=VCMI Baslatici
ShortcutLauncherComment=VCMI Baslaticiyi Çalistir
ShortcutMapEditor=VCMI Harita Editörü
ShortcutMapEditorComment=VCMI Harita Editörünü Aç
ShortcutWebPage=VCMI Web Sitesi
ShortcutWebPageComment=VCMI Resmi Web Sitesini Ziyaret Et
SystemIntegration=Sistem Entegrasyonu
Uninstall=Kaldir
UserDataDirectory=Kullanıcı verileri (Heroes III verileri, modifikasyonlar, haritalar ve diğer dosyalar)
VCMISettings=VCMI Ayarlari
VCMPDescription=VCMI Kampanya Dosyasi
VMAPDescription=VCMI Harita Dosyasi
Warning=Uyari
X86On64BitWarning=VCMI'nin 32 bit (x86) sürümünü 64 bit Windows'a yüklüyorsunuz. Bu desteklenir, ancak mevcut olduğunda yerel 64 bit sürüm önerilir.

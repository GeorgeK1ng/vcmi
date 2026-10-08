; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Parámetros específicos de instalación de VCMI:%n  /USERDATADIR=<ruta>  Establece la carpeta de datos de usuario de VCMI. El prefijo expand: expande constantes de Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Instala la aplicación y los datos juntos sin desinstalador, cambios en el registro, accesos directos, asociaciones ni reglas de firewall.%n  /LAUNCH  Inicia VCMI después de la instalación, incluso en modo silencioso.%n%nParámetro del desinstalador de VCMI:%n  /DELETEUSERDATA=1  Elimina todas las carpetas de usuario VCMI configuradas. Solo se admite junto con /SILENT o /VERYSILENT. Esta acción no se puede deshacer.%n%nLos parámetros estándar como /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART y /LOG se describen arriba.
WindowsVersionNotSupported=Este programa no puede ejecutarse en su versión de Windows. Asegúrese de estar utilizando la arquitectura correcta de Windows (32 bits o 64 bits) y la versión adecuada de este programa.
PrivilegesRequiredOverrideTitle=Modo de instalación – Permisos
PrivilegesRequiredOverrideInstruction=Elija cómo ejecutar el instalador
PrivilegesRequiredOverrideText1=%1 requiere privilegios de administrador para instalarse para todos los usuarios.%nTambién puede instalarlo solo para su cuenta sin privilegios de administrador.
PrivilegesRequiredOverrideText2=%1 puede instalarse solo para su cuenta (sin privilegios de administrador) o para todos los usuarios (requiere privilegios de administrador).
PrivilegesRequiredOverrideAllUsers=Ejecutar como &Administrador (instalación para todos los usuarios)
PrivilegesRequiredOverrideAllUsersRecommended=Ejecutar como &Administrador (recomendado)
PrivilegesRequiredOverrideCurrentUser=Ejecutar como &Usuario estándar (instalación solo para mí)
PrivilegesRequiredOverrideCurrentUserRecommended=Ejecutar como &Usuario estándar (recomendado)
ConfirmUninstall=¿Está seguro de que desea ejecutar el asistente de desinstalación de %1?

[CustomMessages]
AddFirewallRules=Añadir reglas de firewall para VCMI
AssociateH3MFiles=Asociar archivos .h3m con el Editor de Mapas de VCMI
AssociateVCMIMapFiles=Asociar archivos .vmap y .vcmp con el Editor de Mapas de VCMI
CacheDirectory=Caché
CloudDataNotice=Este directorio de datos de usuario parece estar sincronizado por un proveedor de almacenamiento en la nube.
CloudDataWarning=El directorio de datos de usuario seleccionado parece estar sincronizado por un proveedor de almacenamiento en la nube. La sincronización puede bloquear archivos temporalmente y provocar fallos al instalar mods, iniciar el juego o guardar partidas.%n%n¿Desea usar este directorio de todos modos?
CloudInstallNotice=Este directorio de instalación parece estar sincronizado por un proveedor de almacenamiento en la nube.
CloudInstallWarning=El directorio de instalación seleccionado parece estar sincronizado por un proveedor de almacenamiento en la nube. Una instalación portátil o sincronizada puede fallar si el proveedor bloquea temporalmente archivos de la aplicación.%n%n¿Desea usar este directorio de todos modos?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Configuración
CopyH3Files=Copiar automáticamente los archivos necesarios de Heroes III a VCMI
CreateDesktopShortcuts=Crear accesos directos en el escritorio
CreateStartMenuShortcuts=Crear accesos directos en el menú Inicio
DataFolderDescription=Contiene una copia de los datos de Heroes III proporcionados, modificaciones, mapas, partidas guardadas y otros archivos de usuario.
DataFolderTitle=Carpeta de datos de usuario
DeleteUserData=Eliminar datos de usuario
DeleteUserDataDescription=Seleccione las carpetas que desea eliminar permanentemente. Las carpetas sin marcar se conservarán. Esta acción no se puede deshacer.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Archivo de mapa de Heroes 3
InstallFolderTitle=Carpeta de instalación
InstallForAllUsers=Instalar para todos los usuarios
InstallForAllUsers1=Requiere privilegios administrativos
InstallForMeOnly=Instalar solo para mí
InstallForMeOnly1=Aparecerá una advertencia del firewall al iniciar el juego por primera vez
InstallForMeOnly2=Los juegos en LAN no funcionarán si no se permite la regla del firewall
InstallPortable=Instalación portátil
InstallPortable1=Mantiene la aplicación y los datos de usuario juntos en una carpeta
InstallPortable2=No crea un desinstalador ni modifica el registro o la integración del sistema
LogsDirectory=Registros
ResetFoldersToDefault=Restablecer valores
RunVCMILauncherAfterInstall=Iniciar el Launcher de VCMI
SavesDirectory=Partidas guardadas
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI puede instalarse para todos los usuarios o solo para ti.
SelectSetupInstallModeSubTitle=Selecciona el modo de instalación preferido:
SelectSetupInstallModeTitle=Elige el modo de instalación
SharedUserDataNotice=Los datos de usuario no se pueden eliminar porque otra instalación de VCMI utiliza el mismo directorio.
ShortcutDiscord=Discord oficial de VCMI
ShortcutDiscordComment=Visitar el Discord oficial de VCMI
ShortcutLauncher=Launcher de VCMI
ShortcutLauncherComment=Iniciar el Launcher de VCMI
ShortcutMapEditor=Editor de Mapas de VCMI
ShortcutMapEditorComment=Abrir el Editor de Mapas de VCMI
ShortcutWebPage=Sitio web oficial de VCMI
ShortcutWebPageComment=Visitar el sitio web oficial de VCMI
SystemIntegration=Integración con el sistema
Uninstall=Desinstalar
UserDataDirectory=Datos de usuario (datos de Heroes III, modificaciones, mapas y otros archivos)
VCMISettings=Configuración de VCMI
VCMPDescription=Archivo de campaña de VCMI
VMAPDescription=Archivo de mapa de VCMI
Warning=Advertencia
X86On64BitWarning=Está instalando la versión de 32 bits (x86) de VCMI en Windows de 64 bits. Es compatible, pero se recomienda la versión nativa de 64 bits cuando esté disponible.

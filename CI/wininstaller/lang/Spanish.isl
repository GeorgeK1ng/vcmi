;
; Spanish.isl, part of VCMI engine
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
HelpTextNote=Parámetros de instalación de VCMI:%n  /USERDATADIR=<path>  Establece la carpeta de datos de usuario de VCMI. El prefijo expand: expande las constantes de Inno Setup.%n  /ALLOWCLOUDTARGET=1  Permite una carpeta de instalación o de datos sincronizada con la nube durante la instalación silenciosa.%n  /PORTABLE=1  Instala la aplicación y los datos juntos, sin desinstalador, cambios en el registro, accesos directos, asociaciones de archivos ni reglas del cortafuegos.%n  /LAUNCH  Inicia VCMI después de la instalación, incluso en modo silencioso.%n  /COPYH3DATA=0|1  Activa o desactiva la copia automática de los datos de Heroes III detectados.%n%nNombres de tareas para /TASKS y /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (solo instalación para todos los usuarios con permisos de administrador)%n%nParámetro de desinstalación de VCMI:%n  /DELETEUSERDATA=1  Elimina todas las carpetas de usuario configuradas de VCMI. Solo funciona junto con /SILENT o /VERYSILENT. Esta acción no se puede deshacer.%n%nLos parámetros estándar se describen arriba: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Este programa no puede ejecutarse en su versión de Windows. Asegúrese de estar utilizando la arquitectura correcta de Windows (x86 / x64 / ARM64) y la versión adecuada de este programa.
PrivilegesRequiredOverrideTitle=Modo de instalación – Permisos
PrivilegesRequiredOverrideInstruction=Elija cómo ejecutar el instalador
PrivilegesRequiredOverrideText1=%1 requiere privilegios de administrador para instalarse para todos los usuarios. También puede instalarlo solo para su cuenta sin privilegios de administrador.
PrivilegesRequiredOverrideText2=%1 puede instalarse solo para su cuenta (sin privilegios de administrador) o para todos los usuarios (requiere privilegios de administrador).
PrivilegesRequiredOverrideAllUsers=Ejecutar como &Administrador (instalación para todos los usuarios)
PrivilegesRequiredOverrideAllUsersRecommended=Ejecutar como &Administrador (recomendado)
PrivilegesRequiredOverrideCurrentUser=Ejecutar como &Usuario estándar (instalación solo para mí)
PrivilegesRequiredOverrideCurrentUserRecommended=Ejecutar como &Usuario estándar (recomendado)
ConfirmUninstall=¿Está seguro de que desea ejecutar el asistente de desinstalación de %1?

[CustomMessages]
DesktopShortcuts=Accesos directos del escritorio
StartMenuShortcuts=Accesos directos del menú Inicio
WelcomeDescription=VCMI es un motor de código abierto para Heroes III que ofrece posibilidades nuevas y ampliadas. Para usar VCMI, debe poseer los archivos de datos del juego original.%n%nEste asistente instalará VCMI - Open Heroes 3 en su dispositivo.%n%nSe recomienda cerrar todas las demás aplicaciones antes de continuar.%n%nHaga clic en Siguiente para continuar o en Cancelar para salir del instalador.
WelcomeHighlightsTitle=Acerca de VCMI
WelcomeHighlights=VCMI es una reimplementación comunitaria del motor de Heroes of Might and Magic III. Su objetivo es conservar el espíritu del juego original, superar las limitaciones técnicas del motor clásico y ofrecer una base abierta para mods y futuros desarrollos.
RequirementImportSpaceHelp=Vuelva atrás y seleccione otra carpeta de datos de usuario, o desactive la copia automática de los datos de Heroes III.
RequirementDisableImportQuestion=¿Desea continuar sin copiar los datos de Heroes III?
RequirementFirewall=Firewall
RequirementMultiplayerGames=Partidas multijugador
RequirementSelected=Seleccionado
RequirementNotSelected=No seleccionado — el juego por turnos en el mismo equipo seguirá funcionando
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Añadir reglas de firewall para partidas multijugador
AssociateH3MFiles=Asociar archivos .h3m con el Editor de Mapas de VCMI
AssociateVCMIMapFiles=Asociar archivos .vmap y .vcmp con el Editor de Mapas de VCMI
CacheDirectory=Caché
CloudDataNotice=Este directorio de datos de usuario parece estar sincronizado por un proveedor de almacenamiento en la nube.
CloudDataWarning=El directorio de datos de usuario seleccionado parece estar sincronizado por un proveedor de almacenamiento en la nube. La sincronización puede bloquear archivos temporalmente y provocar fallos al instalar mods, iniciar el juego o guardar partidas.%n%n¿Desea usar este directorio de todos modos?
CloudInstallNotice=Este directorio de instalación parece estar sincronizado por un proveedor de almacenamiento en la nube.
CloudInstallWarning=El directorio de instalación seleccionado parece estar sincronizado por un proveedor de almacenamiento en la nube. Una instalación portátil o sincronizada puede fallar si el proveedor bloquea temporalmente archivos de la aplicación.%n%n¿Desea usar este directorio de todos modos?
CloudTargetSilentError=La instalación silenciosa no puede usar un destino sincronizado con la nube sin /ALLOWCLOUDTARGET=1.
CopyH3FilesError=No se pudieron copiar los archivos de Heroes III (%s). Es posible que algunos ya se hayan copiado; puede repetir la importación de forma segura.
CopyingHeroes3Data=Copiando datos de Heroes III...
ConfigDirectory=Configuración
CopyH3Files=Copiar automáticamente los archivos necesarios de Heroes III a VCMI
CreateDesktopShortcuts=Crear accesos directos en el escritorio
CreateStartMenuShortcuts=Crear accesos directos en el menú Inicio
DataFolderDescription=Contiene una copia de los datos de Heroes III proporcionados, modificaciones, mapas, partidas guardadas y otros archivos de usuario.
DataFolderTitle=Carpeta de datos de usuario
DeleteUserData=Eliminar datos de usuario
DeleteUserDataDescription=Seleccione las carpetas que desea eliminar permanentemente. Las carpetas sin marcar se conservarán. Esta acción no se puede deshacer.
DeletingUserData=Eliminando datos de usuario...
DirectoryConfigWriteError=No se pudo guardar la configuración de los directorios de usuario en %s. La instalación no puede continuar de forma segura.
DirectoryNotWritable=No se puede escribir en el directorio seleccionado (%s). Elija otra carpeta o ejecute el instalador con los permisos necesarios.%n%n%s
DirectoryRootNotAllowed=El directorio seleccionado (%s) no puede ser la raíz de una unidad o de un recurso compartido de red. Elija una carpeta dedicada.%n%n%s
DirectoryOverlapError=Las carpetas de instalación y de datos no pueden ser la misma ni solaparse de forma insegura. Solo una instalación portátil puede guardar los datos dentro de la carpeta de instalación.
ReadyUserDataLocation=Ubicación de los datos de usuario:
RequirementPassed=CUMPLIDO
RequirementFailed=ERROR
RequirementWarning=ADVERTENCIA
RequirementInfo=INFORMACIÓN
RequirementOperatingSystem=Sistema operativo
RequirementOperatingSystemValue=Windows 7 SP1 o superior; tiempo de ejecución de compatibilidad incluido cuando sea necesario
RequirementArchitecture=Arquitectura
RequirementInstallWritable=Carpeta de instalación con permiso de escritura
RequirementDataWritable=Carpeta de datos con permiso de escritura
RequirementDirectoryLayout=Diseño de directorio
RequirementDirectoryLayoutValue=Las rutas de instalación y de datos están separadas de forma segura
RequirementApplicationSpace=Espacio en disco de aplicación
RequirementFreeSpaceValue=%s MB libres; el instalador también comprueba el tamaño final del paquete
RequirementHeroesDataSpace=Importación de Heroes III
RequirementInsufficientSpace=No hay suficiente espacio libre para importar los datos de Heroes III seleccionados
RequirementRequiredSpaceValue=Se requieren aproximadamente %s MB para la importación seleccionada
RequirementNotRequested=Importación de datos de Heroes III no seleccionada
RequirementCloudStorage=Sincronización de almacenamiento
RequirementCloudStorageValue=Una ruta seleccionada parece utilizar la sincronización en la nube
RequirementLocalStorageValue=Los caminos seleccionados parecen usar almacenamiento local
RequirementInstallationMode=Modo de instalación
RequirementModePortable=Portable; sin desinstalación, registro o integración del sistema
RequirementModeAllUsers=Todos los usuarios
RequirementModeCurrentUser=Usuario actual
RequirementUpgrade=se actualizará la instalación existente
RequirementsCheckTitle=Verificación de los requisitos del sistema
RequirementsCheckDescription=Configuración verificó la configuración seleccionada antes de la instalación.
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
ScanningFiles=Buscando archivos...
SelectSetupInstallModeDesc=VCMI puede instalarse para todos los usuarios, solo para usted o en modo portátil.
SelectSetupInstallModeSubTitle=Selecciona el modo de instalación preferido:
SelectSetupInstallModeTitle=Elige el modo de instalación
SharedUserDataNotice=Los datos de usuario no se pueden eliminar porque otra instalación de VCMI utiliza el mismo directorio.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Visitar el Discord oficial de VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Iniciar el Launcher de VCMI
ShortcutMapEditor=Editor de Mapas de VCMI
ShortcutMapEditorComment=Abrir el Editor de Mapas de VCMI
ShortcutWebPage=Sitio web oficial de VCMI
ShortcutWebPageComment=Visitar el sitio web oficial de VCMI
SystemIntegration=Integración con el sistema
FileAssociations=Asociaciones de archivos
AssociateH3CFiles=Abrir campañas de Heroes III (.h3c) en el Editor de Mapas de VCMI
H3CDescription=Campaña de Heroes III
Uninstall=Desinstalar
UserDataDirectory=Datos de usuario (datos de Heroes III, modificaciones, mapas y otros archivos)
VCMISettings=Configuración del sistema
VCMPDescription=Archivo de campaña de VCMI
VMAPDescription=Archivo de mapa de VCMI
Warning=Advertencia
X86On64BitWarning=Está instalando la versión de 32 bits (x86) de VCMI en Windows de 64 bits. Es compatible, pero se recomienda la versión nativa de 64 bits cuando esté disponible.
Heroes3ImportReparsePoint=No se pueden importar los datos de Heroes III de forma segura porque una carpeta de destino contiene una unión de directorios o un enlace simbólico. Elimine el enlace o elija otra carpeta.
OpenSetupLog=Abre el registro de configuración
OpenSetupLogError=No se pudo abrir el registro de configuración.
LegacyUninstallStartFailed=No se pudo iniciar el desinstalador anterior de VCMI:%n%s
LegacyUninstallExitFailed=El desinstalador anterior de VCMI falló con el código %s.
LegacyUninstallFailureChoice=Abortar detiene la instalación. Reintentar vuelve a ejecutar el desinstalador anterior. Ignorar continúa bajo su responsabilidad.
LegacyUninstallRequired=No se pudo eliminar la instalación anterior de VCMI. No se copiaron archivos nuevos de instalación.
InstallDirectoryUsedByOtherInstallation=El directorio de instalaciones se superpone a otro registrado VCMI instalación:%n%s%n%nSeleccione un directorio diferente.
X86OnARM64Warning=Está instalando el 32-bit (x86) de la versión de VCMI en el ARM64 Windows. Esto es compatible, pero el nativo ARM64 se recomienda una versión cuando esté disponible.
RequirementsColumnComponent=Componente
RequirementsColumnDetails=Requisitos
RequirementsColumnStatus=Estatus
RequirementsColumnDetected=Su sistema
RequirementDetectedWindows=Instalación compatible de Windows
RequirementWritableValue=Carpeta con permiso de escritura
RequirementEnoughSpace=Espacio libre suficiente
RequirementProcessor=Procesador
RequirementProcessorValue=1 GHz o más rápido
RequirementMemory=Memoria RAM
RequirementMemoryValue=1 GB de RAM
RequirementMemoryDetected=%s RAM de MB
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Entorno de ejecución de DirectX 11 disponible
RequirementDirectXMissing=No se encontró el entorno de ejecución de DirectX 11
RequirementDetectionUnavailable=No se pudo detectar
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Carpeta de instalación
RequirementUserDataFolder=Carpeta de datos de usuario
RequirementDiskSpace=Espacio libre en el disco
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Recomendado
RequirementInternetAvailable=Disponible
RequirementInternetUnavailable=No detectado
RequirementHeroesData=Datos de Heroes III
RequirementRequiredToPlay=Necesario para jugar
RequirementHeroesDataAvailable=Disponibles en los datos de usuario
RequirementHeroesDataMissing=No se encuentra; puede importarse más tarde
RequirementWritableAndSynced=Escrita y sincronizada
RequirementNotWritable=Sin permiso de escritura
TasksCheckboxesTooltip=Seleccione las integraciones y acciones opcionales. Los accesos directos facilitan el acceso, las asociaciones abren los mapas compatibles en el editor, las reglas del cortafuegos permiten jugar en red y la importación copia los datos de Heroes III detectados.
UninstallCheckboxesTooltip=Seleccione solo las carpetas de datos de usuario que quiera eliminar permanentemente. Las entradas compartidas deshabilitadas están siendo usadas por otra instalación de VCMI.
InstallModeTooltip=Todos los usuarios: instala VCMI para todas las cuentas de Windows, normalmente en Program Files. Requiere permisos de administrador. Crea información de desinstalación, entradas del registro, accesos directos, asociaciones de archivos y una regla opcional del cortafuegos para todo el equipo. Los datos permanecen en la carpeta seleccionada.%n%nUsuario actual: instala VCMI solo para la cuenta de Windows que ha iniciado sesión, normalmente en Local AppData, sin permisos de administrador. Crea un desinstalador e integraciones para ese usuario. Las demás cuentas no verán esta instalación. El cortafuegos de Windows puede solicitar permiso al usar el multijugador por primera vez.%n%nPortátil: mantiene la aplicación y los datos juntos en la carpeta seleccionada. No crea desinstalador, entradas del registro, accesos directos, asociaciones ni reglas del cortafuegos. La carpeta debe permitir escritura. Muévala o cópiela para trasladar la instalación, o elimínela para desinstalarla.
CopyH3FilesTooltip=Copia las carpetas Data, Maps y Mp3 de Heroes III detectadas en la carpeta de datos de usuario de VCMI seleccionada. Los archivos originales no se modifican.
ReadyHeroes3Import=Importación de datos de Heroes III:

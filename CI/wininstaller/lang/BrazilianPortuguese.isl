; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Parâmetros específicos da instalação do VCMI:%n  /USERDATADIR=<caminho>  Define a pasta de dados do usuário do VCMI. O prefixo expand: expande constantes do Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Instala o aplicativo e os dados juntos sem desinstalador, alterações no registro, atalhos, associações ou regras de firewall.%n  /LAUNCH  Inicia o VCMI após a instalação, inclusive silenciosa.%n%nParâmetro do desinstalador do VCMI:%n  /DELETEUSERDATA=1  Exclui todas as pastas de usuário configuradas do VCMI. Só é aceito com /SILENT ou /VERYSILENT. A ação não pode ser desfeita.%n%nParâmetros padrão como /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART e /LOG são descritos acima.
WindowsVersionNotSupported=Este programa não pode ser executado na versão do Windows instalada. Certifique-se de estar usando a arquitetura correta do Windows (32 bits ou 64 bits) e a versão adequada deste programa.
PrivilegesRequiredOverrideTitle=Modo de Instalação - Permissões
PrivilegesRequiredOverrideInstruction=Escolha como deseja executar o instalador
PrivilegesRequiredOverrideText1=O %1 requer privilégios administrativos para ser instalado para todos os usuários.%nVocê também pode instalá-lo apenas para sua conta sem privilégios administrativos.
PrivilegesRequiredOverrideText2=O %1 pode ser instalado apenas para sua conta (sem privilégios administrativos) ou para todos os usuários (requer privilégios administrativos).
PrivilegesRequiredOverrideAllUsers=Executar como &Administrador (instalar para todos os usuários)
PrivilegesRequiredOverrideAllUsersRecommended=Executar como &Administrador (recomendado)
PrivilegesRequiredOverrideCurrentUser=Executar como &Usuário Padrão (instalar apenas para mim)
PrivilegesRequiredOverrideCurrentUserRecommended=Executar como &Usuário Padrão (recomendado)
ConfirmUninstall=Tem certeza de que deseja executar o assistente de desinstalação %1?

[CustomMessages]
AddFirewallRules=Adicionar regras de firewall para VCMI
AssociateH3MFiles=Associar arquivos .h3m ao Editor de Mapas VCMI
AssociateVCMIMapFiles=Associar arquivos .vmap e .vcmp ao Editor de Mapas VCMI
CacheDirectory=Cache
CloudDataNotice=Este diretório de dados do usuário parece estar sincronizado por um provedor de armazenamento em nuvem.
CloudDataWarning=O diretório de dados do usuário selecionado parece estar sincronizado por um provedor de armazenamento em nuvem. A sincronização pode bloquear arquivos temporariamente e causar falhas na instalação de mods, na inicialização do jogo ou nos salvamentos.%n%nDeseja usar este diretório mesmo assim?
CloudInstallNotice=Este diretório de instalação parece estar sincronizado por um provedor de armazenamento em nuvem.
CloudInstallWarning=O diretório de instalação selecionado parece estar sincronizado por um provedor de armazenamento em nuvem. Uma instalação portátil ou sincronizada pode falhar se o provedor bloquear temporariamente os arquivos do aplicativo.%n%nDeseja usar este diretório mesmo assim?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Configuração
CopyH3Files=Copiar automaticamente os arquivos necessários do Heroes III para o VCMI
CreateDesktopShortcuts=Criar atalhos na área de trabalho
CreateStartMenuShortcuts=Criar atalhos no menu Iniciar
DataFolderDescription=Armazena uma cópia dos dados fornecidos do Heroes III, modificações, mapas, jogos salvos e outros arquivos do usuário.
DataFolderTitle=Pasta de dados do usuário
DeleteUserData=Excluir dados do usuário
DeleteUserDataDescription=Selecione as pastas que serão excluídas permanentemente. As pastas desmarcadas serão mantidas. Esta ação não pode ser desfeita.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
H3MDescription=Arquivo de mapa do Heroes 3
InstallFolderTitle=Pasta de instalação
InstallForAllUsers=Instalar para todos os usuários
InstallForAllUsers1=Requer privilégios administrativos
InstallForMeOnly=Instalar apenas para mim
InstallForMeOnly1=Um aviso do firewall aparecerá ao iniciar o jogo pela primeira vez
InstallForMeOnly2=Jogos em LAN não funcionarão se a regra do firewall não for permitida
InstallPortable=Instalação portátil
InstallPortable1=Mantém o aplicativo e os dados do usuário juntos em uma pasta
InstallPortable2=Não cria desinstalador nem modifica o registro ou a integração do sistema
LogsDirectory=Registros
ResetFoldersToDefault=Restaurar padrão
RunVCMILauncherAfterInstall=Iniciar o Launcher do VCMI
SavesDirectory=Jogos salvos
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI pode ser instalado para todos os usuários ou apenas para você.
SelectSetupInstallModeSubTitle=Selecione o modo de instalação preferido:
SelectSetupInstallModeTitle=Escolha o Modo de Instalação
SharedUserDataNotice=Os dados do usuário não podem ser excluídos porque outra instalação do VCMI usa o mesmo diretório.
ShortcutDiscord=Discord do VCMI
ShortcutDiscordComment=Visite o Discord oficial do VCMI
ShortcutLauncher=Launcher do VCMI
ShortcutLauncherComment=Iniciar o Launcher do VCMI
ShortcutMapEditor=Editor de Mapas VCMI
ShortcutMapEditorComment=Abrir o Editor de Mapas do VCMI
ShortcutWebPage=Site Oficial do VCMI
ShortcutWebPageComment=Visite o site oficial do VCMI
SystemIntegration=Integração com o sistema
Uninstall=Desinstalar
UserDataDirectory=Dados do usuário (dados do Heroes III, modificações, mapas e outros arquivos)
VCMISettings=Configuração do VCMI
VCMPDescription=Arquivo de campanha do VCMI
VMAPDescription=Arquivo de mapa do VCMI
Warning=Aviso
X86On64BitWarning=Você está instalando a versão de 32 bits (x86) do VCMI no Windows de 64 bits. Isso é compatível, mas a versão nativa de 64 bits é recomendada quando disponível.

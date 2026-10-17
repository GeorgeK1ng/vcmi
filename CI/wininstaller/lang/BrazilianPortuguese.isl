;
; BrazilianPortuguese.isl, part of VCMI engine
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
HelpTextNote=Parâmetros de instalação do VCMI:%n  /USERDATADIR=<path>  Define a pasta de dados do usuário do VCMI. O prefixo expand: expande as constantes do Inno Setup.%n  /ALLOWCLOUDTARGET=1  Permite usar uma pasta de instalação ou de dados sincronizada com a nuvem durante a instalação silenciosa.%n  /PORTABLE=1  Instala o aplicativo e os dados juntos, sem desinstalador, alterações no registro, atalhos, associações de arquivos ou regras de firewall.%n  /LAUNCH  Inicia o VCMI após a instalação, inclusive em modo silencioso.%n  /COPYH3DATA=0|1  Ativa ou desativa a cópia automática dos dados do Heroes III detectados.%n%nNomes de tarefas para /TASKS e /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (somente instalação para todos os usuários com privilégios de administrador)%n%nParâmetro do desinstalador do VCMI:%n  /DELETEUSERDATA=1  Exclui todas as pastas de usuário configuradas do VCMI. Só funciona com /SILENT ou /VERYSILENT. Esta ação não pode ser desfeita.%n%nOs parâmetros padrão estão descritos acima: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Este programa não pode ser executado na versão do Windows instalada. Certifique-se de estar usando a arquitetura correta do Windows (x86 / x64 / ARM64) e a versão adequada deste programa.
PrivilegesRequiredOverrideTitle=Modo de Instalação - Permissões
PrivilegesRequiredOverrideInstruction=Escolha como deseja executar o instalador
PrivilegesRequiredOverrideText1=O %1 requer privilégios administrativos para ser instalado para todos os usuários. Você também pode instalá-lo apenas para sua conta sem privilégios administrativos.
PrivilegesRequiredOverrideText2=O %1 pode ser instalado apenas para sua conta (sem privilégios administrativos) ou para todos os usuários (requer privilégios administrativos).
PrivilegesRequiredOverrideAllUsers=Executar como &Administrador (instalar para todos os usuários)
PrivilegesRequiredOverrideAllUsersRecommended=Executar como &Administrador (recomendado)
PrivilegesRequiredOverrideCurrentUser=Executar como &Usuário Padrão (instalar apenas para mim)
PrivilegesRequiredOverrideCurrentUserRecommended=Executar como &Usuário Padrão (recomendado)
ConfirmUninstall=Tem certeza de que deseja executar o assistente de desinstalação %1?

[CustomMessages]
DesktopShortcuts=Atalhos da área de trabalho
StartMenuShortcuts=Atalhos do Menu Iniciar
WelcomeDescription=VCMI é um motor de código aberto para Heroes III que oferece novas possibilidades e amplia as existentes. Para usar o VCMI, você precisa possuir os arquivos de dados originais do jogo.%n%nEste assistente instalará o VCMI - Open Heroes 3 no seu dispositivo.%n%nRecomendamos fechar todos os outros aplicativos antes de continuar.%n%nClique em Avançar para continuar ou em Cancelar para sair da instalação.
WelcomeHighlightsTitle=Sobre o VCMI
WelcomeHighlights=VCMI é uma reimplementação comunitária do mecanismo de Heroes of Might and Magic III. O projeto preserva o espírito do jogo original, supera os limites técnicos do mecanismo clássico e oferece uma base aberta para mods e desenvolvimento contínuo.
RequirementImportSpaceHelp=Volte e selecione outra pasta de dados do usuário ou desmarque a cópia automática dos dados do Heroes III.
RequirementDisableImportQuestion=Deseja continuar sem copiar os dados do Heroes III?
RequirementFirewall=Firewall
RequirementMultiplayerGames=Jogos multijogador
RequirementSelected=Selecionado
RequirementNotSelected=Não selecionado — o modo de jogo no mesmo computador funcionará normalmente
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Adicionar regras de firewall para jogos multijogador
AssociateH3MFiles=Associar arquivos .h3m ao Editor de Mapas VCMI
AssociateVCMIMapFiles=Associar arquivos .vmap e .vcmp ao Editor de Mapas VCMI
CacheDirectory=Cache
CloudDataNotice=Este diretório de dados do usuário parece estar sincronizado por um provedor de armazenamento em nuvem.
CloudDataWarning=O diretório de dados do usuário selecionado parece estar sincronizado por um provedor de armazenamento em nuvem. A sincronização pode bloquear arquivos temporariamente e causar falhas na instalação de mods, na inicialização do jogo ou nos salvamentos.%n%nDeseja usar este diretório mesmo assim?
CloudInstallNotice=Este diretório de instalação parece estar sincronizado por um provedor de armazenamento em nuvem.
CloudInstallWarning=O diretório de instalação selecionado parece estar sincronizado por um provedor de armazenamento em nuvem. Uma instalação portátil ou sincronizada pode falhar se o provedor bloquear temporariamente os arquivos do aplicativo.%n%nDeseja usar este diretório mesmo assim?
CloudTargetSilentError=A instalação silenciosa não pode usar um destino sincronizado com a nuvem sem /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Não foi possível copiar os arquivos do Heroes III (%s). Alguns arquivos podem já ter sido copiados; você pode repetir a importação com segurança.
CopyingHeroes3Data=Copiando dados do Heroes III...
ConfigDirectory=Configuração
CopyH3Files=Copiar automaticamente os arquivos necessários do Heroes III para o VCMI
CreateDesktopShortcuts=Criar atalhos na área de trabalho
CreateStartMenuShortcuts=Criar atalhos no menu Iniciar
DataFolderDescription=Armazena uma cópia dos dados fornecidos do Heroes III, modificações, mapas, jogos salvos e outros arquivos do usuário.
DataFolderTitle=Pasta de dados do usuário
DeleteUserData=Excluir dados do usuário
DeleteUserDataDescription=Selecione as pastas que serão excluídas permanentemente. As pastas desmarcadas serão mantidas. Esta ação não pode ser desfeita.
DeletingUserData=Excluindo dados do usuário...
DirectoryConfigWriteError=Não foi possível salvar a configuração dos diretórios do usuário em %s. A instalação não pode continuar com segurança.
DirectoryNotWritable=Não é possível gravar no diretório selecionado (%s). Escolha outra pasta ou execute o instalador com os privilégios necessários.%n%n%s
DirectoryRootNotAllowed=O diretório selecionado (%s) não pode ser a raiz de uma unidade ou de um compartilhamento de rede. Escolha uma pasta dedicada.%n%n%s
DirectoryOverlapError=As pastas de instalação e de dados não podem ser iguais nem se sobrepor de forma insegura. Apenas uma instalação portátil pode manter os dados dentro da pasta de instalação.
ReadyUserDataLocation=Local dos dados do usuário:
RequirementPassed=ATENDIDO
RequirementFailed=FALHA
RequirementWarning=AVISO
RequirementInfo=INFORMAÇÃO
RequirementOperatingSystem=Sistema operacional
RequirementOperatingSystemValue=Windows 7 SP1 ou mais recente; tempo de execução de compatibilidade incluído quando necessário
RequirementArchitecture=Arquitetura
RequirementInstallWritable=Pasta de instalação com permissão de gravação
RequirementDataWritable=Pasta de dados com permissão de gravação
RequirementDirectoryLayout=Layout do diretório
RequirementDirectoryLayoutValue=Os caminhos de instalação e de dados estão separados com segurança
RequirementApplicationSpace=Espaço em disco do aplicativo
RequirementFreeSpaceValue=%s MB livres; o instalador também verifica o tamanho final do pacote
RequirementHeroesDataSpace=Importação do Heroes III
RequirementInsufficientSpace=Não há espaço livre suficiente para importar os dados selecionados do Heroes III
RequirementRequiredSpaceValue=Aproximadamente %s MB necessários para a importação selecionada
RequirementNotRequested=Importação de dados do Heroes III não selecionada
RequirementCloudStorage=Sincronização de armazenamento
RequirementCloudStorageValue=Um caminho selecionado parece usar a sincronização em nuvem
RequirementLocalStorageValue=Os caminhos selecionados parecem usar armazenamento local
RequirementInstallationMode=Modo de instalação
RequirementModePortable=Portátil; sem desinstalador, registro ou integração de sistema
RequirementModeAllUsers=Todos os usuários
RequirementModeCurrentUser=Usuário atual
RequirementUpgrade=a instalação existente será atualizada
RequirementsCheckTitle=Verificação de requisitos do sistema
RequirementsCheckDescription=A instalação verificou a configuração selecionada antes da instalação.
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
ScanningFiles=Procurando arquivos...
SelectSetupInstallModeDesc=O VCMI pode ser instalado para todos os usuários, apenas para você ou no modo portátil.
SelectSetupInstallModeSubTitle=Selecione o modo de instalação preferido:
SelectSetupInstallModeTitle=Escolha o Modo de Instalação
SharedUserDataNotice=Os dados do usuário não podem ser excluídos porque outra instalação do VCMI usa o mesmo diretório.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Visite o Discord oficial do VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Iniciar o Launcher do VCMI
ShortcutMapEditor=Editor de Mapas VCMI
ShortcutMapEditorComment=Abrir o Editor de Mapas do VCMI
ShortcutWebPage=Site Oficial do VCMI
ShortcutWebPageComment=Visite o site oficial do VCMI
SystemIntegration=Integração com o sistema
FileAssociations=Associações de arquivos
AssociateH3CFiles=Abrir campanhas do Heroes III (.h3c) no Editor de Mapas VCMI
H3CDescription=Campanha do Heroes III
Uninstall=Desinstalar
UserDataDirectory=Dados do usuário (dados do Heroes III, modificações, mapas e outros arquivos)
VCMISettings=Configuração do sistema
VCMPDescription=Arquivo de campanha do VCMI
VMAPDescription=Arquivo de mapa do VCMI
Warning=Aviso
X86On64BitWarning=Você está instalando a versão de 32 bits (x86) do VCMI no Windows de 64 bits. Isso é compatível, mas a versão nativa de 64 bits é recomendada quando disponível.
Heroes3ImportReparsePoint=Não é possível importar os dados do Heroes III com segurança porque uma pasta de destino contém uma junção ou um link simbólico. Remova o link ou escolha outra pasta.
OpenSetupLog=Abrir log de configuração
OpenSetupLogError=O log de configuração não pôde ser aberto.
LegacyUninstallStartFailed=Não foi possível iniciar o desinstalador anterior do VCMI:%n%s
LegacyUninstallExitFailed=O desinstalador anterior do VCMI falhou com o código %s.
LegacyUninstallFailureChoice=Abortar interrompe a instalação. Repetir executa o desinstalador antigo novamente. Ignorar continua por sua conta e risco.
LegacyUninstallRequired=Não foi possível remover a instalação anterior do VCMI. Nenhum arquivo novo de instalação foi copiado.
InstallDirectoryUsedByOtherInstallation=O diretório de instalação se sobrepõe a outra instalação VCMI registrada:%n%s%n%nSelecione um diretório diferente.
X86OnARM64Warning=Você está instalando a versão de 32 bits (x86) do VCMI no Windows ARM64. Isso é compatível, mas a versão nativa ARM64 é recomendada quando disponível.
RequirementsColumnComponent=Componente
RequirementsColumnDetails=Obrigatório
RequirementsColumnStatus=Status
RequirementsColumnDetected=Seu sistema
RequirementDetectedWindows=Instalação compatível com Windows
RequirementWritableValue=Pasta com permissão de gravação
RequirementEnoughSpace=Espaço livre suficiente
RequirementProcessor=Processador
RequirementProcessorValue=1 GHz ou mais rápido
RequirementMemory=Memória RAM
RequirementMemoryValue=1 GB de RAM
RequirementMemoryDetected=%sMB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Ambiente de execução do DirectX 11 disponível
RequirementDirectXMissing=Ambiente de execução do DirectX 11 não encontrado
RequirementDetectionUnavailable=Não foi possível detectar
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Pasta de instalação
RequirementUserDataFolder=Pasta de dados do usuário
RequirementDiskSpace=Espaço livre em disco
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Recomendado
RequirementInternetAvailable=Disponível
RequirementInternetUnavailable=Não detectado
RequirementHeroesData=Dados do Heroes III
RequirementRequiredToPlay=Necessário para jogar
RequirementHeroesDataAvailable=Disponíveis nos dados do usuário
RequirementHeroesDataMissing=Não encontrado; pode ser importado posteriormente
RequirementWritableAndSynced=Gravável e sincronizado
RequirementNotWritable=Sem permissão de gravação
TasksCheckboxesTooltip=Selecione as integrações e ações opcionais. Os atalhos facilitam o acesso, as associações abrem mapas compatíveis no editor, as regras de firewall permitem partidas em rede e a importação copia os dados do Heroes III detectados.
UninstallCheckboxesTooltip=Selecione apenas as pastas de dados do usuário que deseja excluir permanentemente. As entradas compartilhadas desabilitadas são usadas por outra instalação do VCMI.
InstallModeTooltip=Todos os usuários: instala o VCMI para todas as contas do Windows, normalmente em Program Files. Requer aprovação de administrador. Cria informações de desinstalação, entradas no registro, atalhos, associações de arquivos e uma regra opcional de firewall para todo o sistema. Os dados permanecem na pasta selecionada.%n%nUsuário atual: instala o VCMI apenas para a conta conectada ao Windows, normalmente em Local AppData, sem aprovação de administrador. Cria um desinstalador e integrações para esse usuário. As outras contas não verão esta instalação. O Firewall do Windows pode pedir permissão na primeira partida em rede.%n%nPortátil: mantém o aplicativo e os dados juntos na pasta selecionada. Não cria desinstalador, entradas no registro, atalhos, associações nem regras de firewall. A pasta deve permitir gravação. Mova ou copie a pasta para transferir a instalação, ou exclua a pasta para desinstalar.
CopyH3FilesTooltip=Copia as pastas Data, Maps e Mp3 do Heroes III detectadas para a pasta de dados do usuário do VCMI selecionada. Os arquivos originais permanecem inalterados.
ReadyHeroes3Import=Importação de dados do Heroes III:

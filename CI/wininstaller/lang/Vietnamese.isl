;
; Vietnamese.isl, part of VCMI engine
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
HelpTextNote=Tham số cài đặt VCMI:%n  /USERDATADIR=<path>  Đặt thư mục dữ liệu người dùng VCMI. Tiền tố expand: mở rộng các hằng số Inno Setup.%n  /ALLOWCLOUDTARGET=1  Cho phép dùng thư mục cài đặt hoặc dữ liệu đồng bộ với đám mây khi cài đặt im lặng.%n  /PORTABLE=1  Cài ứng dụng và dữ liệu cùng nhau mà không tạo trình gỡ cài đặt, thay đổi sổ đăng ký, lối tắt, liên kết tệp hoặc quy tắc tường lửa.%n  /LAUNCH  Khởi chạy VCMI sau khi cài đặt, kể cả trong chế độ im lặng.%n  /COPYH3DATA=0|1  Bật hoặc tắt tính năng tự động sao chép dữ liệu Heroes III được phát hiện.%n%nTên tác vụ cho /TASKS và /MERGETASKS:%n  startmenu_launcher, startmenu_mapeditor, startmenu_website, startmenu_discord%n  desktop_launcher, desktop_mapeditor%n  fileassociation_vmap, fileassociation_vcmp, fileassociation_h3m, fileassociation_h3c%n  firewallrules (chỉ cài đặt cho mọi người dùng với quyền quản trị viên)%n%nTham số gỡ cài đặt VCMI:%n  /DELETEUSERDATA=1  Xóa mọi thư mục người dùng VCMI đã cấu hình. Chỉ có hiệu lực khi dùng cùng /SILENT hoặc /VERYSILENT. Không thể hoàn tác.%n%nCác tham số tiêu chuẩn được mô tả ở trên: /DIR, /LANG, /TASKS, /MERGETASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART, /LOG.
WindowsVersionNotSupported=Chương trình này không thể chạy trên phiên bản Windows của bạn. Vui lòng đảm bảo rằng bạn đang sử dụng kiến trúc Windows đúng (x86 / x64 / ARM64) và phiên bản phù hợp của chương trình này.
PrivilegesRequiredOverrideTitle=Setup Mode – Permissions
PrivilegesRequiredOverrideInstruction=Chọn cách chạy cài đặt
PrivilegesRequiredOverrideText1=%1 yêu cầu quyền quản trị viên để cài đặt cho tất cả người dùng. Bạn cũng có thể chỉ cài đặt cho tài khoản của mình mà không cần quyền quản trị viên.
PrivilegesRequiredOverrideText2=%1 có thể được cài đặt chỉ cho tài khoản của bạn (không cần quyền quản trị viên) hoặc cho tất cả người dùng (cần quyền quản trị viên).
PrivilegesRequiredOverrideAllUsers=Dạy như &Administrator (làm cài đặt cho tất cả người dùng)
PrivilegesRequiredOverrideAllUsersRecommended=Tiếp tục như &Administrator (được khuyến cáo)
PrivilegesRequiredOverrideCurrentUser=Dạy như người dùng &Standard (đặt chỉ cho tôi)
PrivilegesRequiredOverrideCurrentUserRecommended=Dạy như người dùng &Standard (được khuyến cáo)
ConfirmUninstall=Bạn có chắc chắn muốn chạy trình gỡ cài đặt %1 không?

[CustomMessages]
DesktopShortcuts=Lối tắt trên màn hình nền
StartMenuShortcuts=Lối tắt trong menu Bắt đầu
WelcomeDescription=VCMI là engine mã nguồn mở cho Heroes III với những khả năng mới và mở rộng. Để sử dụng VCMI, bạn cần sở hữu các tệp dữ liệu của trò chơi gốc.%n%nTrình hướng dẫn này sẽ cài đặt VCMI - Open Heroes 3 trên thiết bị của bạn.%n%nBạn nên đóng tất cả ứng dụng khác trước khi tiếp tục.%n%nNhấn Tiếp để tiếp tục hoặc Hủy để thoát trình cài đặt.
WelcomeHighlightsTitle=Giới thiệu VCMI
WelcomeHighlights=VCMI là bản tái triển khai engine Heroes of Might and Magic III do cộng đồng phát triển. Dự án giữ lại tinh thần của trò chơi gốc, vượt qua các giới hạn kỹ thuật của engine cổ điển và cung cấp nền tảng mở cho mod cùng quá trình phát triển lâu dài.
RequirementImportSpaceHelp=Quay lại và chọn thư mục dữ liệu người dùng khác hoặc bỏ chọn tự động sao chép dữ liệu Heroes III.
RequirementDisableImportQuestion=Bạn có muốn tiếp tục mà không sao chép dữ liệu Heroes III không?
RequirementFirewall=Tường lửa
RequirementMultiplayerGames=Trò chơi nhiều người
RequirementSelected=Đã chọn
RequirementNotSelected=Chưa chọn — chế độ chơi luân phiên trên cùng máy tính vẫn hoạt động
RequirementVCMIAndHeroesData=VCMI + Heroes III
AddFirewallRules=Thêm quy tắc tường lửa cho trò chơi nhiều người
AssociateH3MFiles=Liên kết các tệp .h3m với Trình chỉnh sửa Bản đồ VCMI
AssociateVCMIMapFiles=Liên kết các tệp .vmap và .vcmp với Trình chỉnh sửa Bản đồ VCMI
CacheDirectory=Bộ nhớ đệm
CloudDataNotice=Thư mục dữ liệu người dùng này có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây.
CloudDataWarning=Thư mục dữ liệu người dùng đã chọn có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây. Việc đồng bộ hóa có thể tạm thời khóa tệp và gây lỗi khi cài đặt mod, khởi chạy trò chơi hoặc lưu trò chơi.%n%nBạn vẫn muốn sử dụng thư mục này chứ?
CloudInstallNotice=Thư mục cài đặt này có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây.
CloudInstallWarning=Thư mục cài đặt đã chọn có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây. Bản cài đặt di động hoặc được đồng bộ hóa có thể thất bại nếu nhà cung cấp tạm thời khóa các tệp ứng dụng.%n%nBạn vẫn muốn sử dụng thư mục này chứ?
CloudTargetSilentError=Cài đặt im lặng không thể dùng đích đồng bộ với đám mây nếu không có /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Không thể sao chép các tệp Heroes III (%s). Một số tệp có thể đã được sao chép; bạn có thể chạy lại quá trình nhập một cách an toàn.
CopyingHeroes3Data=Đang sao chép dữ liệu Heroes III...
ConfigDirectory=Cấu hình
CopyH3Files=Tự động sao chép các tệp cần thiết của Heroes III vào VCMI
CreateDesktopShortcuts=Tạo phím tắt trên màn hình
CreateStartMenuShortcuts=Tạo phím tắt trong menu Bắt đầu
DataFolderDescription=Lưu bản sao dữ liệu Heroes III được cung cấp, các bản sửa đổi, bản đồ, trò chơi đã lưu và các tệp người dùng khác.
DataFolderTitle=Thư mục dữ liệu người dùng
DeleteUserData=Xóa dữ liệu người dùng
DeleteUserDataDescription=Chọn các thư mục sẽ bị xóa vĩnh viễn. Các thư mục không được chọn sẽ được giữ lại. Không thể hoàn tác thao tác này.
DeletingUserData=Đang xóa dữ liệu người dùng...
DirectoryConfigWriteError=Không thể lưu cấu hình thư mục người dùng vào %s. Quá trình cài đặt không thể tiếp tục an toàn.
DirectoryNotWritable=Không thể ghi vào thư mục đã chọn (%s). Hãy chọn thư mục khác hoặc chạy trình cài đặt với quyền cần thiết.%n%n%s
DirectoryRootNotAllowed=Thư mục đã chọn (%s) không được là gốc ổ đĩa hoặc vùng chia sẻ mạng. Hãy chọn một thư mục riêng.%n%n%s
DirectoryOverlapError=Thư mục cài đặt và dữ liệu người dùng không được trùng nhau hoặc chồng lấn không an toàn. Chỉ bản cài đặt di động mới được lưu dữ liệu người dùng trong thư mục cài đặt.
ReadyUserDataLocation=Vị trí dữ liệu người dùng:
RequirementPassed=ĐẠT
RequirementFailed=LỖI
RequirementWarning=CẢNH BÁO
RequirementInfo=THÔNG TIN
RequirementOperatingSystem=Hệ điều hành
RequirementOperatingSystemValue=Windows 7 SP1 hoặc mới hơn; thời gian chạy tương thích bao gồm khi cần thiết
RequirementArchitecture=Kiến trúc
RequirementInstallWritable=Thư mục cài đặt cho phép ghi
RequirementDataWritable=Thư mục dữ liệu người dùng cho phép ghi
RequirementDirectoryLayout=Layout thư mục
RequirementDirectoryLayoutValue=Đường dẫn cài đặt và dữ liệu người dùng được tách biệt an toàn
RequirementApplicationSpace=Không gian đĩa ứng dụng
RequirementFreeSpaceValue=Còn trống %s MB; trình cài đặt cũng kiểm tra kích thước gói cuối cùng
RequirementHeroesDataSpace=Nhập dữ liệu Heroes III
RequirementInsufficientSpace=Không đủ dung lượng trống để nhập dữ liệu Heroes III đã chọn
RequirementRequiredSpaceValue=Cần khoảng %s MB cho dữ liệu nhập đã chọn
RequirementNotRequested=Chưa chọn nhập dữ liệu Heroes III
RequirementCloudStorage=Đồng bộ hóa lưu trữ
RequirementCloudStorageValue=Một con đường được chọn dường như sử dụng đồng bộ hóa đám mây
RequirementLocalStorageValue=Các con đường được chọn dường như sử dụng lưu trữ địa phương
RequirementInstallationMode=Phương thức cài đặt
RequirementModePortable=Đưa theo; không có trình gỡ cài đặt, đăng ký hoặc tích hợp hệ thống
RequirementModeAllUsers=Tất cả người dùng
RequirementModeCurrentUser=Người dùng hiện tại
RequirementUpgrade=bản cài đặt hiện có sẽ được nâng cấp
RequirementsCheckTitle=Kiểm tra các yêu cầu hệ thống
RequirementsCheckDescription=Setup kiểm tra cấu hình được chọn trước khi cài đặt.
H3MDescription=Tệp bản đồ Heroes 3
InstallFolderTitle=Thư mục cài đặt
InstallForAllUsers=Cài đặt cho tất cả người dùng
InstallForAllUsers1=Yêu cầu quyền quản trị
InstallForMeOnly=Chỉ cài đặt cho tôi
InstallForMeOnly1=Khi khởi chạy trò chơi lần đầu tiên, sẽ xuất hiện thông báo tường lửa
InstallForMeOnly2=Trò chơi LAN sẽ không hoạt động nếu không thể cho phép quy tắc tường lửa
InstallPortable=Cài đặt di động
InstallPortable1=Giữ ứng dụng và dữ liệu người dùng cùng trong một thư mục
InstallPortable2=Không tạo trình gỡ cài đặt và không sửa registry hoặc tích hợp hệ thống
LogsDirectory=Nhật ký
ResetFoldersToDefault=Khôi phục mặc định
RunVCMILauncherAfterInstall=Khởi chạy VCMI Launcher
SavesDirectory=Trò chơi đã lưu
ScanningFiles=Đang tìm tệp...
SelectSetupInstallModeDesc=Có thể cài VCMI cho mọi người dùng, chỉ cho bạn hoặc ở chế độ di động.
SelectSetupInstallModeSubTitle=Chọn chế độ cài đặt bạn muốn:
SelectSetupInstallModeTitle=Chọn Chế độ Cài đặt
SharedUserDataNotice=Không thể xóa dữ liệu người dùng vì một bản cài đặt VCMI khác đang sử dụng cùng thư mục.
ShortcutDiscord=VCMI Discord
ShortcutDiscordComment=Truy cập Discord chính thức của VCMI
ShortcutLauncher=VCMI Launcher
ShortcutLauncherComment=Khởi chạy VCMI Launcher
ShortcutMapEditor=Trình chỉnh sửa Bản đồ VCMI
ShortcutMapEditorComment=Mở Trình chỉnh sửa Bản đồ VCMI
ShortcutWebPage=Trang web chính thức của VCMI
ShortcutWebPageComment=Truy cập trang web chính thức của VCMI
SystemIntegration=Tích hợp hệ thống
FileAssociations=Liên kết tệp
AssociateH3CFiles=Mở chiến dịch Heroes III (.h3c) trong Trình chỉnh sửa Bản đồ VCMI
H3CDescription=Chiến dịch Heroes III
Uninstall=Gỡ cài đặt
UserDataDirectory=Dữ liệu người dùng (dữ liệu Heroes III, bản sửa đổi, bản đồ và các tệp khác)
VCMISettings=Cấu hình hệ thống
VCMPDescription=Tệp chiến dịch VCMI
VMAPDescription=Tệp bản đồ VCMI
Warning=Cảnh báo
X86On64BitWarning=Bạn đang cài đặt phiên bản VCMI 32 bit (x86) trên Windows 64 bit. Cấu hình này được hỗ trợ, nhưng nên dùng phiên bản 64 bit gốc khi có sẵn.
Heroes3ImportReparsePoint=Không thể nhập dữ liệu Heroes III an toàn vì thư mục đích hiện có chứa điểm nối hoặc liên kết tượng trưng. Hãy gỡ liên kết hoặc chọn thư mục khác.
OpenSetupLog=Mở nhật ký cài đặt
OpenSetupLogError=Lập nhật ký cài đặt không thể mở được.
LegacyUninstallStartFailed=Không thể khởi chạy trình gỡ cài đặt VCMI trước đó:%n%s
LegacyUninstallExitFailed=Trình gỡ cài đặt VCMI trước đó thất bại với mã thoát %s.
LegacyUninstallFailureChoice=Hủy bỏ sẽ dừng cài đặt. Thử lại sẽ chạy lại trình gỡ cài đặt cũ. Bỏ qua sẽ tiếp tục và bạn tự chịu rủi ro.
LegacyUninstallRequired=Không thể gỡ bản cài đặt VCMI trước đó. Chưa có tệp cài đặt mới nào được sao chép.
InstallDirectoryUsedByOtherInstallation=Các thư mục lắp đặt chồng chéo với một người khác đã đăng ký VCMI Lắp đặt:%n%s%n%nChọn một thư mục khác.
X86OnARM64Warning=Bạn đang cài đặt 32-bit (x86) phiên bản của VCMI trên ARM64 Windows. điều này được hỗ trợ, nhưng bản địa ARM64 phiên bản được khuyến cáo khi có sẵn.
RequirementsColumnComponent=Thành phần
RequirementsColumnDetails=Cần
RequirementsColumnStatus=Tình trạng
RequirementsColumnDetected=Hệ thống của bạn
RequirementDetectedWindows=Lắp đặt Windows tương thích
RequirementWritableValue=Thư mục cho phép ghi
RequirementEnoughSpace=Đủ dung lượng trống
RequirementProcessor=Bộ xử lý
RequirementProcessorValue=1 GHz hoặc nhanh hơn
RequirementMemory=Bộ nhớ RAM
RequirementMemoryValue=1 GB RAM
RequirementMemoryDetected=%s MB RAM
RequirementDirectX=DirectX
RequirementDirectXValue=DirectX 11
RequirementDirectXDetected=Có môi trường thực thi DirectX 11
RequirementDirectXMissing=Không tìm thấy môi trường thực thi DirectX 11
RequirementDetectionUnavailable=Không thể phát hiện
RequirementOperatingSystemShortValue=Windows 7 SP1
RequirementInstallFolder=Thư mục cài đặt
RequirementUserDataFolder=Thư mục dữ liệu người dùng
RequirementDiskSpace=Không gian đĩa miễn phí
RequirementFreeSpaceShortValue=%s
RequirementInternet=Internet
RequirementRecommended=Ước
RequirementInternetAvailable=Có sẵn
RequirementInternetUnavailable=Không được phát hiện
RequirementHeroesData=Dữ liệu Heroes III
RequirementRequiredToPlay=Cần thiết để chơi
RequirementHeroesDataAvailable=Có trong dữ liệu người dùng
RequirementHeroesDataMissing=Không tìm thấy; có thể nhập khẩu sau đó
RequirementWritableAndSynced=Có thể viết và đồng bộ hóa
RequirementNotWritable=Không thể ghi
TasksCheckboxesTooltip=Chọn các tích hợp và tác vụ tùy chọn. Lối tắt giúp truy cập nhanh, liên kết tệp mở bản đồ được hỗ trợ trong trình biên tập, quy tắc tường lửa cho phép chơi nhiều người và thao tác nhập sao chép dữ liệu Heroes III được phát hiện.
UninstallCheckboxesTooltip=Chỉ chọn các thư mục dữ liệu người dùng cần xóa vĩnh viễn. Các mục dùng chung bị vô hiệu hóa đang được bản cài đặt VCMI khác sử dụng.
InstallModeTooltip=Mọi người dùng: cài VCMI cho mọi tài khoản Windows, thường trong Program Files. Cần quản trị viên chấp thuận. Tạo thông tin gỡ cài đặt, mục sổ đăng ký, lối tắt, liên kết tệp và quy tắc tường lửa tùy chọn cho toàn hệ thống. Dữ liệu vẫn ở thư mục đã chọn.%n%nNgười dùng hiện tại: chỉ cài VCMI cho tài khoản Windows đang đăng nhập, thường trong Local AppData, không cần quản trị viên chấp thuận. Tạo trình gỡ cài đặt và tích hợp cho người dùng đó. Các tài khoản khác sẽ không thấy bản cài đặt này. Tường lửa Windows có thể xin phép khi dùng chế độ nhiều người chơi lần đầu.%n%nDi động: giữ ứng dụng và dữ liệu cùng nhau trong thư mục đã chọn. Không tạo trình gỡ cài đặt, mục sổ đăng ký, lối tắt, liên kết tệp hay quy tắc tường lửa. Thư mục phải cho phép ghi. Di chuyển hoặc sao chép thư mục để chuyển bản cài đặt; xóa thư mục để gỡ cài đặt.
CopyH3FilesTooltip=Sao chép các thư mục Data, Maps và Mp3 của Heroes III được phát hiện vào thư mục dữ liệu người dùng VCMI đã chọn. Các tệp gốc không bị thay đổi.
ReadyHeroes3Import=Nhập dữ liệu Heroes III:

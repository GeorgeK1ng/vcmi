; VCMI-specific Inno Setup message overrides.
; Standard messages are loaded from the matching Inno Setup language file.

[Messages]
HelpTextNote=Tham số cài đặt riêng của VCMI:%n  /USERDATADIR=<đường dẫn>  Đặt thư mục dữ liệu người dùng VCMI. Tiền tố expand: mở rộng hằng số Inno Setup.%n  /ALLOWCLOUDTARGET=1  Allow a cloud-synchronized installation or user data directory during silent setup.%n  /PORTABLE=1  Cài ứng dụng và dữ liệu cùng nhau mà không tạo trình gỡ cài đặt, thay đổi registry, lối tắt, liên kết tệp hoặc quy tắc tường lửa.%n  /LAUNCH  Chạy VCMI sau khi cài đặt, kể cả cài đặt im lặng.%n%nTham số trình gỡ cài đặt VCMI:%n  /DELETEUSERDATA=1  Xóa mọi thư mục người dùng VCMI đã cấu hình. Chỉ được chấp nhận cùng /SILENT hoặc /VERYSILENT. Không thể hoàn tác.%n%nCác tham số chuẩn như /DIR, /LANG, /TASKS, /CURRENTUSER, /ALLUSERS, /SILENT, /VERYSILENT, /SUPPRESSMSGBOXES, /NORESTART và /LOG được mô tả ở trên.
WindowsVersionNotSupported=Chương trình này không thể chạy trên phiên bản Windows của bạn. Vui lòng đảm bảo rằng bạn đang sử dụng kiến trúc Windows đúng (32-bit hoặc 64-bit) và phiên bản phù hợp của chương trình này.
PrivilegesRequiredOverrideTitle=Setup Mode – Permissions
PrivilegesRequiredOverrideInstruction=Choose how to run the installer
PrivilegesRequiredOverrideText1=%1 requires administrative privileges to install for all users.%nYou can also install it only for your account without administrative privileges.
PrivilegesRequiredOverrideText2=%1 can be installed only for your account (without administrative privileges) or for all users (requires administrative privileges).
PrivilegesRequiredOverrideAllUsers=Run as &Administrator (install for all users)
PrivilegesRequiredOverrideAllUsersRecommended=Run as &Administrator (recommended)
PrivilegesRequiredOverrideCurrentUser=Run as &Standard User (install for me only)
PrivilegesRequiredOverrideCurrentUserRecommended=Run as &Standard User (recommended)
ConfirmUninstall=Bạn có chắc chắn muốn chạy trình gỡ cài đặt %1 không?

[CustomMessages]
AddFirewallRules=Thêm quy tắc tường lửa cho VCMI
AssociateH3MFiles=Liên kết các tệp .h3m với Trình chỉnh sửa Bản đồ VCMI
AssociateVCMIMapFiles=Liên kết các tệp .vmap và .vcmp với Trình chỉnh sửa Bản đồ VCMI
CacheDirectory=Bộ nhớ đệm
CloudDataNotice=Thư mục dữ liệu người dùng này có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây.
CloudDataWarning=Thư mục dữ liệu người dùng đã chọn có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây. Việc đồng bộ hóa có thể tạm thời khóa tệp và gây lỗi khi cài đặt mod, khởi chạy trò chơi hoặc lưu trò chơi.%n%nBạn vẫn muốn sử dụng thư mục này chứ?
CloudInstallNotice=Thư mục cài đặt này có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây.
CloudInstallWarning=Thư mục cài đặt đã chọn có vẻ đang được đồng bộ hóa bởi một nhà cung cấp lưu trữ đám mây. Bản cài đặt di động hoặc được đồng bộ hóa có thể thất bại nếu nhà cung cấp tạm thời khóa các tệp ứng dụng.%n%nBạn vẫn muốn sử dụng thư mục này chứ?
CloudTargetSilentError=Silent setup will not use a cloud-synchronized target without /ALLOWCLOUDTARGET=1.
CopyH3FilesError=Failed to copy Heroes III %s files.
CopyingHeroes3Data=Copying Heroes III data...
ConfigDirectory=Cấu hình
CopyH3Files=Tự động sao chép các tệp cần thiết của Heroes III vào VCMI
CreateDesktopShortcuts=Tạo phím tắt trên màn hình
CreateStartMenuShortcuts=Tạo phím tắt trong menu Bắt đầu
DataFolderDescription=Lưu bản sao dữ liệu Heroes III được cung cấp, các bản sửa đổi, bản đồ, trò chơi đã lưu và các tệp người dùng khác.
DataFolderTitle=Thư mục dữ liệu người dùng
DeleteUserData=Xóa dữ liệu người dùng
DeleteUserDataDescription=Chọn các thư mục sẽ bị xóa vĩnh viễn. Các thư mục không được chọn sẽ được giữ lại. Không thể hoàn tác thao tác này.
DeletingUserData=Deleting user data...
DirectoryConfigWriteError=Failed to save the user directory configuration to %s. Setup cannot safely continue.
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
ScanningFiles=Scanning files...
SelectSetupInstallModeDesc=VCMI có thể được cài đặt cho tất cả người dùng hoặc chỉ dành cho bạn.
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
Uninstall=Gỡ cài đặt
UserDataDirectory=Dữ liệu người dùng (dữ liệu Heroes III, bản sửa đổi, bản đồ và các tệp khác)
VCMISettings=Cấu hình VCMI
VCMPDescription=Tệp chiến dịch VCMI
VMAPDescription=Tệp bản đồ VCMI
Warning=Cảnh báo
X86On64BitWarning=Bạn đang cài đặt phiên bản VCMI 32 bit (x86) trên Windows 64 bit. Cấu hình này được hỗ trợ, nhưng nên dùng phiên bản 64 bit gốc khi có sẵn.

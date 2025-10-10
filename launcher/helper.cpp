/*
 * helper.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "helper.h"

#include "mainwindow_moc.h"
#include "settingsView/csettingsview_moc.h"
#include "modManager/cmodlistview_moc.h"

#include "../lib/CConfigHandler.h"

#include <QObject>
#include <QScroller>

#ifdef VCMI_ANDROID
#include <QAndroidJniObject>
#include <QtAndroid>
#endif

#ifdef VCMI_IOS
#include "ios/revealdirectoryinfiles.h"
#include "ios/selectdirectory.h"
#include "iOS_utils.h"
#endif

#ifdef VCMI_MOBILE
static QScrollerProperties generateScrollerProperties()
{
	QScrollerProperties result;

	result.setScrollMetric(QScrollerProperties::OvershootDragResistanceFactor, 0.25);
	result.setScrollMetric(QScrollerProperties::OvershootDragDistanceFactor, 0.25);
	result.setScrollMetric(QScrollerProperties::HorizontalOvershootPolicy, QScrollerProperties::OvershootAlwaysOff);

	return result;
}
#endif

#ifdef VCMI_ANDROID
static QString safeEncode(QString uri)
{
	// %-encode unencoded parts of string.
	// This is needed because Qt returns a mixed content url with %-encoded and unencoded parts. On Android >= 13 this causes problems reading these files, when using spaces and unicode characters in folder or filename.
	// Only these should be encoded (other typically %-encoded chars should not be encoded because this leads to errors).
	// Related, but seems not completly fixed (at least in our setup): https://bugreports.qt.io/browse/QTBUG-114435
	if (!uri.startsWith("content://", Qt::CaseInsensitive))
		return uri;
	return QString::fromUtf8(QUrl::toPercentEncoding(uri, "!#$&'()*+,/:;=?@[]<>{}\"`^~%"));
}
#endif

namespace Helper
{
void loadSettings()
{
	settings.init("config/settings.json", "vcmi:settings");
	persistentStorage.init("config/persistentStorage.json", "");
}

void reLoadSettings()
{
	loadSettings();
	for(const auto widget : qApp->allWidgets())
		if(auto settingsView = qobject_cast<CSettingsView *>(widget))
		{
			settingsView->loadSettings();
			break;
		}
	getMainWindow()->updateTranslation();
	getMainWindow()->getModView()->reload();
}

void enableScrollBySwiping(QObject * scrollTarget)
{
#ifdef VCMI_MOBILE
	QScroller::grabGesture(scrollTarget, QScroller::LeftMouseButtonGesture);
	QScroller * scroller = QScroller::scroller(scrollTarget);
	scroller->setScrollerProperties(generateScrollerProperties());
#endif
}

QString getRealPath(QString path)
{
#ifdef VCMI_ANDROID
	if(path.contains("content://", Qt::CaseInsensitive))
	{
		auto str = QAndroidJniObject::fromString(safeEncode(path));
		return QAndroidJniObject::callStaticObjectMethod("eu/vcmi/vcmi/util/FileUtil", "getFilenameFromUri", "(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;", str.object<jstring>(), QtAndroid::androidContext().object()).toString();
	}
	return path;
#else
	return path;
#endif
}

bool performNativeCopy(QString src, QString dst)
{
#ifdef VCMI_ANDROID
	auto srcStr = QAndroidJniObject::fromString(safeEncode(src));
	auto dstStr = QAndroidJniObject::fromString(safeEncode(dst));
	QAndroidJniObject::callStaticObjectMethod("eu/vcmi/vcmi/util/FileUtil", "copyFileFromUri", "(Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;)V", srcStr.object<jstring>(), dstStr.object<jstring>(), QtAndroid::androidContext().object());

	if(QFileInfo(dst).exists())
		return true;
	else
		return false;
#else
	return QFile::copy(src, dst);
#endif
}

void revealDirectoryInFileBrowser(QString path)
{
	const auto dirUrl = QUrl::fromLocalFile(QFileInfo{path}.absoluteFilePath());
#ifdef VCMI_IOS
	iOS_utils::revealDirectoryInFiles(dirUrl);
#else
	QDesktopServices::openUrl(dirUrl);
#endif
}

MainWindow * getMainWindow()
{
	foreach(QWidget *w, qApp->allWidgets())
		if(auto mainWin = qobject_cast<MainWindow*>(w))
			return mainWin;
	return nullptr;
}


void keepScreenOn(bool isEnabled)
{
#if defined(VCMI_ANDROID)
	QtAndroid::runOnAndroidThread([isEnabled]
	{
		QtAndroid::androidActivity().callMethod<void>("keepScreenOn", "(Z)V", isEnabled);
	});
#elif defined(VCMI_IOS)
	iOS_utils::keepScreenOn(isEnabled);
#endif
}


// ===== Helper::nativeFolderPicker (drop-in) =====
#ifdef VCMI_ANDROID
static constexpr int kFolderPickerReqCode = 4242;

// Receives result from Android's ACTION_OPEN_DOCUMENT_TREE
class FolderPickReceiver : public QtAndroidActivityResultReceiver
{
public:
    std::function<void(QString)> onDone;

    void handleActivityResult(int req, int res, const QAndroidJniObject &data) override
    {
        if (req != kFolderPickerReqCode || res != -1 /*RESULT_OK*/ || !data.isValid())
        {
            if (onDone) onDone({});
            return;
        }

        // Extract Uri as string
        QAndroidJniObject uri = data.callObjectMethod("getData","()Landroid/net/Uri;");
        QAndroidJniObject s   = uri.callObjectMethod("toString","()Ljava/lang/String;");
        const QString picked  = s.toString();

        // Persist permissions so subsequent reads via helper work reliably
        QAndroidJniObject ctx = QtAndroid::androidContext();
        QAndroidJniObject cr  = ctx.callObjectMethod("getContentResolver","()Landroid/content/ContentResolver;");
        cr.callMethod<void>("takePersistableUriPermission",
                            "(Landroid/net/Uri;I)V",
                            uri.object<jobject>(),
                            jint(1 /*READ*/ | 2 /*WRITE*/));

        if (onDone) onDone(picked);
    }
};
static FolderPickReceiver g_receiver;
#endif // VCMI_ANDROID

// Cross-platform folder picker:
// - Android: SAF (asynchronous), returns content:// tree URI
// - iOS:     existing SelectDirectory helper (synchronous)
// - Desktop: QFileDialog (synchronous)
// The API is unified via callback.
void nativeFolderPicker(QWidget *parent, std::function<void(QString)> cb)
{
#if defined(VCMI_ANDROID)
    // SAF – asynchronous folder picker
    g_receiver.onDone = std::move(cb);

    QAndroidJniObject intent("android/content/Intent","()V");
    intent.callObjectMethod("setAction",
                            "(Ljava/lang/String;)Landroid/content/Intent;",
                            QAndroidJniObject::fromString("android.intent.action.OPEN_DOCUMENT_TREE").object<jstring>());

    // Flags: READ | WRITE | PERSIST | PREFIX
    intent.callObjectMethod("addFlags",
                            "(I)Landroid/content/Intent;",
                            jint(1 | 2 | 64 | 128));

    QtAndroid::startActivityForResult(intent.object<jobject>(), kFolderPickerReqCode, &g_receiver);

#elif defined(VCMI_IOS)
    // iOS – use your existing utility
    SelectDirectory iosDirectorySelector;
    const QString dir = iosDirectorySelector.getExistingDirectory();
    if (cb) cb(dir);

#else
    // Desktop – standard dialog (callback for a unified API)
    const QString dir = QFileDialog::getExistingDirectory(
        parent, {}, {}, QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);
    if (cb) cb(dir);
#endif
}
// ===== end of Helper::nativeFolderPicker =====

}



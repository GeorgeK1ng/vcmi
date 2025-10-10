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
#include <QAndroidActivityResultReceiver>
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

// Try to resolve a SAF tree URI to a filesystem path (ExternalStorageProvider only)
static QString tryResolveTreeUriToFsPath(const QString &treeUriStr)
{
    // Uri + authority
    QAndroidJniObject uri = QAndroidJniObject::callStaticObjectMethod(
        "android/net/Uri","parse","(Ljava/lang/String;)Landroid/net/Uri;",
        QAndroidJniObject::fromString(treeUriStr).object<jstring>());

    if (!uri.isValid())
        return {};

    const QString authority = uri.callObjectMethod("getAuthority","()Ljava/lang/String;").toString();

    // Only handle com.android.externalstorage.documents (primary storage / SD card)
    if (authority != QLatin1String("com.android.externalstorage.documents"))
        return {};

    // Get tree documentId, e.g. "primary:Download" or "1234-5678:Games/H3"
    QAndroidJniObject docIdJ = QAndroidJniObject::callStaticObjectMethod(
        "android/provider/DocumentsContract",
        "getTreeDocumentId",
        "(Landroid/net/Uri;)Ljava/lang/String;",
        uri.object());
    const QString docId = docIdJ.toString();
    if (docId.isEmpty())
        return {};

    const int colon = docId.indexOf(':');
    const QString type = colon < 0 ? docId : docId.left(colon);            // "primary" or "XXXX-XXXX"
    const QString rel  = colon < 0 ? QString() : docId.mid(colon + 1);     // "Download" / "Games/H3" / ""

    QString base;
    if (type.compare(QStringLiteral("primary"), Qt::CaseInsensitive) == 0)
    {
        // /storage/emulated/0  (fallback if Environment fails)
        QAndroidJniObject file = QAndroidJniObject::callStaticObjectMethod(
            "android/os/Environment","getExternalStorageDirectory","()Ljava/io/File;");
        if (file.isValid())
        {
            base = file.callObjectMethod("getAbsolutePath","()Ljava/lang/String;").toString();
        }
        if (base.isEmpty())
            base = QStringLiteral("/storage/emulated/0");
    }
    else
    {
        // Secondary volume (SD card): /storage/<volumeId>
        base = QStringLiteral("/storage/") + type;
    }

    const QString full = rel.isEmpty() ? base : (base + QLatin1Char('/') + rel);
    return QDir::cleanPath(full);
}

// One-shot receiver for ACTION_OPEN_DOCUMENT_TREE
class FolderPickReceiver : public QAndroidActivityResultReceiver
{
public:
    std::function<void(QString)> onDone;

    void handleActivityResult(int req, int res, const QAndroidJniObject &data) override
    {
        // Always bounce back to Qt main thread
        auto cb = onDone; onDone = nullptr;

        if (req != kFolderPickerReqCode || res != -1 /*RESULT_OK*/ || !data.isValid())
        {
            QMetaObject::invokeMethod(qApp, [cb]{ if (cb) cb(QString{}); }, Qt::QueuedConnection);
            return;
        }

        // Selected tree URI as string
        QAndroidJniObject uri = data.callObjectMethod("getData","()Landroid/net/Uri;");
        QAndroidJniObject us  = uri.callObjectMethod("toString","()Ljava/lang/String;");
        const QString pickedTree = us.toString();

        // Persist permission for future access via ContentResolver
        QAndroidJniObject ctx = QtAndroid::androidContext();
        QAndroidJniObject cr  = ctx.callObjectMethod("getContentResolver","()Landroid/content/ContentResolver;");
        cr.callMethod<void>("takePersistableUriPermission",
                            "(Landroid/net/Uri;I)V",
                            uri.object<jobject>(),
                            jint(1 /*READ*/ | 2 /*WRITE*/));

        // Try to resolve to FS path (works for ExternalStorageProvider)
        const QString resolved = tryResolveTreeUriToFsPath(pickedTree);
        const QString toReturn = resolved.isEmpty() ? pickedTree : resolved;

        // Return on Qt thread
        QMetaObject::invokeMethod(qApp, [cb, toReturn]{ if (cb) cb(toReturn); }, Qt::QueuedConnection);
    }
};

static FolderPickReceiver g_receiver;
#endif // VCMI_ANDROID

void nativeFolderPicker(QWidget *parent, std::function<void(QString)> cb)
{
#if defined(VCMI_ANDROID)
    Q_UNUSED(parent);
    g_receiver.onDone = std::move(cb);

    QAndroidJniObject intent("android/content/Intent","()V");
    intent.callObjectMethod("setAction",
                            "(Ljava/lang/String;)Landroid/content/Intent;",
                            QAndroidJniObject::fromString("android.intent.action.OPEN_DOCUMENT_TREE").object<jstring>());
    // Flags: READ | WRITE | PERSIST | PREFIX
    intent.callObjectMethod("addFlags","(I)Landroid/content/Intent;", jint(1 | 2 | 64 | 128));

    // Qt 5 API: register + start in one call
    QtAndroid::startActivity(intent, kFolderPickerReqCode, &g_receiver);

#elif defined(VCMI_IOS)
    SelectDirectory iosDirectorySelector;
    const QString dir = iosDirectorySelector.getExistingDirectory();
    if (cb) cb(dir);

#else
    const QString dir = QFileDialog::getExistingDirectory(
        parent, {}, {}, QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);
    if (cb) cb(dir);
#endif
// ===== end of Helper::nativeFolderPicker =====

}



QStringList Helper::findFilesForCopy(const QString &treeUri)
{
#ifdef VCMI_ANDROID
    QAndroidJniObject jUri = QAndroidJniObject::fromString(safeEncode(treeUri));
    QAndroidJniObject jArr = QAndroidJniObject::callStaticObjectMethod(
        "eu/vcmi/vcmi/util/FileUtil",
        "findFilesForCopy",
        "(Ljava/lang/String;Landroid/content/Context;)[Ljava/lang/String;",
        jUri.object<jstring>(),
        QtAndroid::androidContext().object());

    QStringList out;
    if (!jArr.isValid()) return out;

    QAndroidJniEnvironment env;
    jobjectArray arr = static_cast<jobjectArray>(jArr.object<jobject>());
    jsize n = env->GetArrayLength(arr);
    out.reserve(n);
    for (jsize i = 0; i < n; ++i) {
        QAndroidJniObject s((jstring)env->GetObjectArrayElement(arr, i));
        out.push_back(s.toString());
    }
    return out;
#else
    Q_UNUSED(treeUri);
    return {};
#endif
}


}

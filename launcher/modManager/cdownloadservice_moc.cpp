/*
 * cdownloadservice_moc.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "cdownloadservice_moc.h"

#ifdef VCMI_ANDROID
#include <QAndroidJniObject>
#include <QtAndroid>
#endif

#ifdef VCMI_IOS
#include "iOS_utils.h"
#endif

quint64 CDownloadService::enqueue(const QUrl & url, const QString & targetFile, QString & error)
{
	error.clear();

#if defined(VCMI_ANDROID)
	const QAndroidJniObject jUrl = QAndroidJniObject::fromString(url.toString());
	const QAndroidJniObject jTarget = QAndroidJniObject::fromString(targetFile);
	const jlong id = QAndroidJniObject::callStaticMethod<jlong>(
		"eu/vcmi/vcmi/NativeMethods",
		"startBackgroundDownload",
		"(Ljava/lang/String;Ljava/lang/String;)J",
		jUrl.object<jstring>(),
		jTarget.object<jstring>());

	if(id < 0)
		error = QObject::tr("Failed to start background download");

	return static_cast<quint64>(id);
#elif defined(VCMI_IOS)
	std::string nativeError;
	const auto id = iOS_utils::startBackgroundDownload(url.toString().toStdString(), targetFile.toStdString(), nativeError);

	if(id == 0)
		error = QString::fromStdString(nativeError);

	return id;
#else
	Q_UNUSED(url);
	Q_UNUSED(targetFile);

	error = QObject::tr("Background downloads are not supported");
	return 0;
#endif
}

CDownloadService::DownloadStatus CDownloadService::status(quint64 id)
{
	DownloadStatus result;

#if defined(VCMI_ANDROID)
	const auto value = QAndroidJniObject::callStaticObjectMethod(
		"eu/vcmi/vcmi/NativeMethods",
		"backgroundDownloadStatus",
		"(J)Ljava/lang/String;",
		jlong(id)).toString();

	const auto parts = value.split(';');
	if(parts.size() >= 5)
	{
		result.received = parts[0].toLongLong();
		result.total = parts[1].toLongLong();
		result.finished = parts[2] == "1";
		result.failed = parts[3] == "1";
		result.error = parts.mid(4).join(";");
	}
#elif defined(VCMI_IOS)
	std::string error;
	bool finished = false;
	bool failed = false;
	iOS_utils::queryBackgroundDownload(id, result.received, result.total, finished, failed, error);
	result.finished = finished;
	result.failed = failed;
	result.error = QString::fromStdString(error);
#else
	Q_UNUSED(id);
#endif

	return result;
}

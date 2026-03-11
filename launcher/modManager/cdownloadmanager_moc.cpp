/*
 * cdownloadmanager_moc.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "cdownloadmanager_moc.h"
#include "cdownloadservice_moc.h"

#include "../vcmiqt/launcherdirs.h"

#include "../../lib/CConfigHandler.h"

#include <QTimer>

CDownloadManager::CDownloadManager()
	: backgroundPollTimer(nullptr)
{
	connect(&manager, SIGNAL(finished(QNetworkReply *)),
		SLOT(downloadFinished(QNetworkReply *)));
	connect(&manager, &QNetworkAccessManager::sslErrors, [](QNetworkReply * reply, const QList<QSslError> & errors) {
		if(settings["launcher"]["ignoreSslErrors"].Bool())
			reply->ignoreSslErrors();
	});

#if defined(VCMI_MOBILE)
	backgroundPollTimer = new QTimer(this);
	backgroundPollTimer->setInterval(250);
	connect(backgroundPollTimer, &QTimer::timeout, this, &CDownloadManager::processBackgroundDownloads);
#endif
}

void CDownloadManager::downloadFile(const QUrl & url, const QString & file, qint64 bytesTotal)
{
	QNetworkRequest request(url);
	FileEntry entry;
	entry.file.reset(new QFile(QString{QLatin1String{"%1/%2"}}.arg(CLauncherDirs::downloadsPath(), file)));
	entry.bytesReceived = 0;
	entry.totalSize = bytesTotal;
	entry.filename = file;
	entry.backgroundDownloadId = 0;

	if(entry.file->open(QIODevice::WriteOnly | QIODevice::Truncate))
	{
		entry.status = FileEntry::IN_PROGRESS;
#if defined(VCMI_MOBILE)
		QString startError;
		entry.backgroundDownloadId = CDownloadService::enqueue(url, entry.file->fileName(), startError);
		if(entry.backgroundDownloadId != 0)
		{
			entry.reply = nullptr;
			if(backgroundPollTimer && !backgroundPollTimer->isActive())
				backgroundPollTimer->start();
		}
		else
		{
			entry.reply = manager.get(request);
			if(!startError.isEmpty())
				encounteredErrors += startError;
			connect(entry.reply, SIGNAL(downloadProgress(qint64,qint64)),
				SLOT(downloadProgressChanged(qint64,qint64)));
		}
#else
		entry.reply = manager.get(request);

		connect(entry.reply, SIGNAL(downloadProgress(qint64,qint64)),
			SLOT(downloadProgressChanged(qint64,qint64)));
#endif
	}
	else
	{
		entry.status = FileEntry::FAILED;
		entry.reply = nullptr;
		encounteredErrors += entry.file->errorString();
	}

	// even if failed - add it into list to report it in finished() call
	currentDownloads.push_back(entry);
}

CDownloadManager::FileEntry & CDownloadManager::getEntry(QNetworkReply * reply)
{
	assert(reply);
	for(auto & entry : currentDownloads)
	{
		if(entry.reply == reply)
			return entry;
	}
	throw std::runtime_error("Failed to find download entry");
}

void CDownloadManager::downloadFinished(QNetworkReply * reply)
{
	FileEntry & file = getEntry(reply);

	QVariant possibleRedirectUrl = reply->attribute(QNetworkRequest::RedirectionTargetAttribute);
	QUrl qurl = possibleRedirectUrl.toUrl();

	if(possibleRedirectUrl.isValid())
	{
		QString filename;
		qint64 totalSize = 0;

		for(int i = 0; i< currentDownloads.size(); ++i)
		{
			if(currentDownloads[i].file == file.file)
			{
				filename = currentDownloads[i].filename;
				totalSize = currentDownloads[i].totalSize;
				currentDownloads.removeAt(i);
				break;
			}
		}
		downloadFile(qurl, filename, totalSize);
		return;
	}

	if(file.reply->error())
	{
		encounteredErrors += file.reply->errorString();
		file.file->remove();
		file.status = FileEntry::FAILED;
	}
	else
	{
		file.file->write(file.reply->readAll());
		file.file->close();
		file.status = FileEntry::FINISHED;
	}

	bool downloadComplete = true;
	for(auto & entry : currentDownloads)
	{
		if(entry.status == FileEntry::IN_PROGRESS)
		{
			downloadComplete = false;
			break;
		}
	}

	QStringList successful;
	QStringList failed;

	for(auto & entry : currentDownloads)
	{
		if(entry.status == FileEntry::FINISHED)
			successful += entry.file->fileName();
		else
			failed += entry.file->fileName();
	}

	if(downloadComplete)
		Q_EMIT finished(successful, failed, encounteredErrors);

	file.reply->deleteLater();
	file.reply = nullptr;
}

void CDownloadManager::downloadProgressChanged(qint64 bytesReceived, qint64 bytesTotal)
{
	auto reply = dynamic_cast<QNetworkReply *>(sender());
	FileEntry & entry = getEntry(reply);

	entry.file->write(entry.reply->readAll());
	entry.bytesReceived = bytesReceived;
	if(bytesTotal > entry.totalSize)
		entry.totalSize = bytesTotal;

	quint64 total = 0;
	for(auto & queuedEntry : currentDownloads)
		total += queuedEntry.totalSize > 0 ? queuedEntry.totalSize : queuedEntry.bytesReceived;

	quint64 received = 0;
	for(auto & queuedEntry : currentDownloads)
		received += queuedEntry.bytesReceived > 0 ? queuedEntry.bytesReceived : 0;

	if(received > total)
		total = received;

	Q_EMIT downloadProgress(received, total);
}

void CDownloadManager::processBackgroundDownloads()
{
#if defined(VCMI_MOBILE)
	bool hasInProgress = false;
	for(auto & entry : currentDownloads)
	{
		if(entry.status != FileEntry::IN_PROGRESS || entry.backgroundDownloadId == 0)
			continue;

		hasInProgress = true;
		auto state = CDownloadService::status(entry.backgroundDownloadId);
		entry.bytesReceived = state.received;
		entry.totalSize = state.total;

		if(state.finished)
		{
			entry.status = state.failed ? FileEntry::FAILED : FileEntry::FINISHED;
			if(state.failed)
			{
				entry.file->remove();
				if(!state.error.isEmpty())
					encounteredErrors += state.error;
			}
		}
	}

	quint64 total = 0;
	quint64 received = 0;
	for(const auto & entry : currentDownloads)
	{
		total += entry.totalSize > 0 ? entry.totalSize : entry.bytesReceived;
		received += entry.bytesReceived > 0 ? entry.bytesReceived : 0;
		if(entry.status == FileEntry::IN_PROGRESS)
			hasInProgress = true;
	}
	if(received > total)
		total = received;

	Q_EMIT downloadProgress(received, total);

	if(!hasInProgress)
	{
		if(backgroundPollTimer)
			backgroundPollTimer->stop();

		QStringList successful;
		QStringList failed;
		for(const auto & entry : currentDownloads)
		{
			if(entry.status == FileEntry::FINISHED)
				successful += entry.file->fileName();
			else
				failed += entry.file->fileName();
		}
		Q_EMIT finished(successful, failed, encounteredErrors);
	}
#endif
}

bool CDownloadManager::downloadInProgress(const QUrl & url) const
{
	for(auto & entry : currentDownloads)
	{
		if(entry.reply && entry.reply->url() == url)
			return true;
	}
	return false;
}

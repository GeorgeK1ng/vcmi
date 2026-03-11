/*
 * cdownloadservice_moc.h, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#pragma once

#include <QString>
#include <QUrl>

class CDownloadService
{
public:
	struct DownloadStatus
	{
		qint64 received = 0;
		qint64 total = 0;
		bool finished = false;
		bool failed = false;
		QString error;
	};

	static quint64 enqueue(const QUrl & url, const QString & targetFile, QString & error);
	static DownloadStatus status(quint64 id);
};

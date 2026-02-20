/*
 * imageviewer_moc.h, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#pragma once

#include <QDialog>

namespace Ui
{
class ImageViewer;
}

class ImageViewer : public QDialog
{
	Q_OBJECT

	void changeEvent(QEvent *event) override;
public:
	explicit ImageViewer(QWidget * parent = nullptr);
	~ImageViewer();

	void setImages(const QStringList & imagePaths, int startIndex);

	static void showImages(const QStringList & imagePaths, int startIndex, QWidget * parent = nullptr);

protected:
	void keyPressEvent(QKeyEvent * event) override;
	QSize calculateWindowSize();

private:
	void showCurrentImage();
	void showPreviousImage();
	void showNextImage();

	Ui::ImageViewer * ui;
	QStringList images;
	int currentImageIndex = -1;
};

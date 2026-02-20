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

class QShortcut;

namespace Ui
{
class ImageViewer;
}

class ImageViewer : public QDialog
{
	Q_OBJECT

	void changeEvent(QEvent *event) override;
	bool event(QEvent * event) override;
public:
	explicit ImageViewer(QWidget * parent = nullptr);
	~ImageViewer();

	void setImages(const QStringList & imagePaths, int startIndex);

	static void showImages(const QStringList & imagePaths, int startIndex, QWidget * parent = nullptr);

protected:
	void keyPressEvent(QKeyEvent * event) override;
	void resizeEvent(QResizeEvent * event) override;
	void mousePressEvent(QMouseEvent * event) override;
	void mouseReleaseEvent(QMouseEvent * event) override;
	QSize calculateWindowSize();

private:
	void showCurrentImage();
	void showPreviousImage();
	void showNextImage();
	void updateDisplayedPixmap();
	void handleSwipeDelta(int deltaX);

	Ui::ImageViewer * ui;
	QShortcut * shortcutPrevious = nullptr;
	QShortcut * shortcutNext = nullptr;
	QShortcut * shortcutClose = nullptr;
	QStringList images;
	QPixmap currentPixmap;
	int currentImageIndex = -1;
	int touchStartX = 0;
	int mouseStartX = 0;
};

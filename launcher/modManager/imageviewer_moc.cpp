/*
 * imageviewer_moc.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"

#include <QGuiApplication>

#include "imageviewer_moc.h"
#include "ui_imageviewer_moc.h"

ImageViewer::ImageViewer(QWidget * parent)
	: QDialog(parent), ui(new Ui::ImageViewer)
{
	ui->setupUi(this);

	connect(ui->buttonPrevious, &QPushButton::clicked, this, &ImageViewer::showPreviousImage);
	connect(ui->buttonNext, &QPushButton::clicked, this, &ImageViewer::showNextImage);
}

void ImageViewer::changeEvent(QEvent *event)
{
	if(event->type() == QEvent::LanguageChange)
	{
		ui->retranslateUi(this);
	}
	QDialog::changeEvent(event);
}

ImageViewer::~ImageViewer()
{
	delete ui;
}

QSize ImageViewer::calculateWindowSize()
{
	return QGuiApplication::primaryScreen()->availableGeometry().size() * 0.8;
}

void ImageViewer::showImages(const QStringList & imagePaths, int startIndex, QWidget * parent)
{
	if(imagePaths.empty())
		return;

	auto * iw = new ImageViewer(parent);
	iw->setImages(imagePaths, startIndex);
	iw->setAttribute(Qt::WA_DeleteOnClose, true);
	iw->setModal(Qt::WindowModal);
	iw->show();
}

void ImageViewer::setImages(const QStringList & imagePaths, int startIndex)
{
	assert(!imagePaths.empty());

	images = imagePaths;
	const int lastImageIndex = static_cast<int>(images.size() - 1);
	currentImageIndex = std::clamp(startIndex, 0, lastImageIndex);
	showCurrentImage();
}

void ImageViewer::showCurrentImage()
{
	assert(!images.empty());

	QPixmap pixmap(images.at(currentImageIndex));
	assert(!pixmap.isNull());

	QSize size = pixmap.size();
	size.scale(calculateWindowSize(), Qt::KeepAspectRatio);
	resize(size);

	ui->label->setPixmap(pixmap);
	ui->buttonPrevious->setVisible(images.size() > 1);
	ui->buttonNext->setVisible(images.size() > 1);
}

void ImageViewer::showPreviousImage()
{
	if(images.size() <= 1)
		return;

	currentImageIndex = (currentImageIndex - 1 + images.size()) % images.size();
	showCurrentImage();
}

void ImageViewer::showNextImage()
{
	if(images.size() <= 1)
		return;

	currentImageIndex = (currentImageIndex + 1) % images.size();
	showCurrentImage();
}

void ImageViewer::keyPressEvent(QKeyEvent * event)
{
	switch(event->key())
	{
	case Qt::Key_Left:
		showPreviousImage();
		break;
	case Qt::Key_Right:
		showNextImage();
		break;
	case Qt::Key_Escape:
		close();
		break;
	default:
		QDialog::keyPressEvent(event);
		break;
	}
}

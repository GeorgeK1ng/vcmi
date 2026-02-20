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
#include <QGestureEvent>
#include <QShortcut>
#include <QSwipeGesture>
#include <QTouchEvent>

#include "imageviewer_moc.h"
#include "ui_imageviewer_moc.h"

ImageViewer::ImageViewer(QWidget * parent)
	: QDialog(parent), ui(new Ui::ImageViewer)
{
	ui->setupUi(this);

	setFocusPolicy(Qt::StrongFocus);
	setAttribute(Qt::WA_AcceptTouchEvents, true);
	ui->label->setAttribute(Qt::WA_AcceptTouchEvents, true);
	grabGesture(Qt::SwipeGesture);

	shortcutPrevious = new QShortcut(QKeySequence(Qt::Key_Left), this);
	shortcutNext = new QShortcut(QKeySequence(Qt::Key_Right), this);
	shortcutClose = new QShortcut(QKeySequence(Qt::Key_Escape), this);

	connect(shortcutPrevious, &QShortcut::activated, this, &ImageViewer::showPreviousImage);
	connect(shortcutNext, &QShortcut::activated, this, &ImageViewer::showNextImage);
	connect(shortcutClose, &QShortcut::activated, this, &ImageViewer::close);

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

bool ImageViewer::event(QEvent * event)
{
	if(event->type() == QEvent::Gesture)
	{
		auto * gestureEvent = static_cast<QGestureEvent *>(event);
		if(auto * swipe = static_cast<QSwipeGesture *>(gestureEvent->gesture(Qt::SwipeGesture)))
		{
			if(swipe->state() == Qt::GestureFinished)
			{
				if(swipe->horizontalDirection() == QSwipeGesture::Left)
					showNextImage();
				else if(swipe->horizontalDirection() == QSwipeGesture::Right)
					showPreviousImage();
			}
			return true;
		}
	}

	if(event->type() == QEvent::TouchBegin)
	{
		auto * touchEvent = static_cast<QTouchEvent *>(event);
		if(!touchEvent->points().empty())
			touchStartX = static_cast<int>(touchEvent->points().first().position().x());
		return true;
	}

	if(event->type() == QEvent::TouchEnd)
	{
		auto * touchEvent = static_cast<QTouchEvent *>(event);
		if(!touchEvent->points().empty())
		{
			const int touchEndX = static_cast<int>(touchEvent->points().first().position().x());
			handleSwipeDelta(touchEndX - touchStartX);
		}
		return true;
	}

	return QDialog::event(event);
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
	iw->setFocus();
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
	if(pixmap.isNull())
		return;

	currentPixmap = pixmap;

	QSize windowSize = currentPixmap.size();
	windowSize.scale(calculateWindowSize(), Qt::KeepAspectRatio);
	resize(windowSize);
	updateDisplayedPixmap();

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

void ImageViewer::updateDisplayedPixmap()
{
	if(currentPixmap.isNull())
		return;

	const QSize labelSize = ui->label->size();
	if(labelSize.isEmpty())
		return;

	const auto scaledPixmap = currentPixmap.scaled(labelSize, Qt::KeepAspectRatio, Qt::SmoothTransformation);
	ui->label->setPixmap(scaledPixmap);
}

void ImageViewer::handleSwipeDelta(int deltaX)
{
	constexpr int swipeThreshold = 40;
	if(deltaX > swipeThreshold)
		showPreviousImage();
	else if(deltaX < -swipeThreshold)
		showNextImage();
}

void ImageViewer::resizeEvent(QResizeEvent * event)
{
	QDialog::resizeEvent(event);
	updateDisplayedPixmap();
}


void ImageViewer::mousePressEvent(QMouseEvent * event)
{
	mouseStartX = static_cast<int>(event->position().x());
	QDialog::mousePressEvent(event);
}

void ImageViewer::mouseReleaseEvent(QMouseEvent * event)
{
	const int mouseEndX = static_cast<int>(event->position().x());
	handleSwipeDelta(mouseEndX - mouseStartX);
	QDialog::mouseReleaseEvent(event);
}

void ImageViewer::keyPressEvent(QKeyEvent * event)
{
	switch(event->key())
	{
	case Qt::Key_Left:
		showPreviousImage();
		event->accept();
		break;
	case Qt::Key_Right:
		showNextImage();
		event->accept();
		break;
	case Qt::Key_Escape:
		close();
		event->accept();
		break;
	default:
		QDialog::keyPressEvent(event);
		break;
	}
}

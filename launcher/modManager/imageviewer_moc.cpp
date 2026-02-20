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
#include <QPinchGesture>
#include <QShortcut>
#include <QSwipeGesture>
#include <QTouchEvent>

#include "imageviewer_moc.h"
#include "ui_imageviewer_moc.h"

namespace
{
int touchPointsCount(const QTouchEvent * touchEvent)
{
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
	return static_cast<int>(touchEvent->points().size());
#else
	return touchEvent->touchPoints().size();
#endif
}

int touchEventX(const QTouchEvent * touchEvent)
{
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
	if(touchEvent->points().empty())
		return 0;
	return static_cast<int>(touchEvent->points().first().position().x());
#else
	if(touchEvent->touchPoints().empty())
		return 0;
	return static_cast<int>(touchEvent->touchPoints().first().pos().x());
#endif
}

QPointF touchEventPos(const QTouchEvent * touchEvent)
{
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
	if(touchEvent->points().empty())
		return QPointF{};
	return touchEvent->points().first().position();
#else
	if(touchEvent->touchPoints().empty())
		return QPointF{};
	return touchEvent->touchPoints().first().pos();
#endif
}

int mouseEventX(const QMouseEvent * mouseEvent)
{
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
	return static_cast<int>(mouseEvent->position().x());
#else
	return static_cast<int>(mouseEvent->localPos().x());
#endif
}
}

ImageViewer::ImageViewer(QWidget * parent)
	: QDialog(parent), ui(new Ui::ImageViewer)
{
	ui->setupUi(this);

	setFocusPolicy(Qt::StrongFocus);
	setAttribute(Qt::WA_AcceptTouchEvents, true);
	ui->label->setAttribute(Qt::WA_AcceptTouchEvents, true);
	grabGesture(Qt::SwipeGesture);
	grabGesture(Qt::PinchGesture);

	shortcutPrevious = new QShortcut(QKeySequence(Qt::Key_Left), this);
	shortcutNext = new QShortcut(QKeySequence(Qt::Key_Right), this);
	shortcutClose = new QShortcut(QKeySequence(Qt::Key_Escape), this);

	connect(shortcutPrevious, &QShortcut::activated, this, &ImageViewer::showPreviousImage);
	connect(shortcutNext, &QShortcut::activated, this, &ImageViewer::showNextImage);
	connect(shortcutClose, &QShortcut::activated, this, &ImageViewer::close);

	connect(ui->buttonPrevious, &QPushButton::clicked, this, &ImageViewer::showPreviousImage);
	connect(ui->buttonNext, &QPushButton::clicked, this, &ImageViewer::showNextImage);
	connect(ui->buttonClose, &QPushButton::clicked, this, &ImageViewer::close);

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
		if(auto * pinch = static_cast<QPinchGesture *>(gestureEvent->gesture(Qt::PinchGesture)))
		{
			if(pinch->state() == Qt::GestureStarted || pinch->state() == Qt::GestureUpdated)
			{
				suppressTouchSwipe = true;
				touchSwipeActive = false;
			}
			if(pinch->state() == Qt::GestureUpdated)
				applyZoomStep(pinch->scaleFactor());
			return true;
		}

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
		if(touchPointsCount(touchEvent) > 1)
		{
			suppressTouchSwipe = true;
			touchSwipeActive = false;
			return true;
		}

		const auto pos = touchEventPos(touchEvent);
		if(pos.isNull())
			return QDialog::event(event);

		auto * touched = childAt(pos.toPoint());
		if(touched == ui->buttonPrevious || touched == ui->buttonNext || touched == ui->buttonClose)
			return QDialog::event(event);

		touchStartX = static_cast<int>(pos.x());
		touchSwipeActive = true;
		return true;
	}

	if(event->type() == QEvent::TouchEnd)
	{
		auto * touchEvent = static_cast<QTouchEvent *>(event);
		if(suppressTouchSwipe)
		{
			suppressTouchSwipe = false;
			touchSwipeActive = false;
			return true;
		}

		if(!touchSwipeActive)
			return QDialog::event(event);

		const int touchEndX = touchEventX(touchEvent);
		handleSwipeDelta(touchEndX - touchStartX);
		touchSwipeActive = false;
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
#ifdef VCMI_MOBILE
	return QGuiApplication::primaryScreen()->availableGeometry().size();
#else
	return QGuiApplication::primaryScreen()->availableGeometry().size() * 0.8;
#endif
}

void ImageViewer::showImages(const QStringList & imagePaths, int startIndex, QWidget * parent)
{
	if(imagePaths.empty())
		return;

	auto * iw = new ImageViewer(parent);
	iw->setImages(imagePaths, startIndex);
	iw->setAttribute(Qt::WA_DeleteOnClose, true);
	iw->setModal(Qt::WindowModal);
#ifdef VCMI_MOBILE
	iw->showFullScreen();
#else
	iw->show();
#endif
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
	zoomFactor = 1.0;

	#ifndef VCMI_MOBILE
	QSize windowSize = currentPixmap.size();
	windowSize.scale(calculateWindowSize(), Qt::KeepAspectRatio);
	resize(windowSize);
	#endif
	updateDisplayedPixmap();

	ui->buttonPrevious->setVisible(images.size() > 1);
	ui->buttonNext->setVisible(images.size() > 1);
	#ifdef VCMI_MOBILE
	ui->buttonClose->setVisible(true);
	#else
	ui->buttonClose->setVisible(false);
	#endif
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

	QSize targetSize = currentPixmap.size();
	if(targetSize.width() > labelSize.width() || targetSize.height() > labelSize.height())
		targetSize.scale(labelSize, Qt::KeepAspectRatio);

	targetSize = targetSize * zoomFactor;
	targetSize = targetSize.boundedTo(calculateWindowSize() * 2);

	const auto scaledPixmap = currentPixmap.scaled(targetSize, Qt::KeepAspectRatio, Qt::SmoothTransformation);
	ui->label->setPixmap(scaledPixmap);
}

void ImageViewer::applyZoomStep(qreal zoomStep)
{
	if(zoomStep <= 0.0)
		return;

	zoomFactor *= zoomStep;
	zoomFactor = std::clamp(zoomFactor, 0.5, 3.0);
	updateDisplayedPixmap();
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
	mouseStartX = mouseEventX(event);
	QDialog::mousePressEvent(event);
}

void ImageViewer::mouseReleaseEvent(QMouseEvent * event)
{
	const int mouseEndX = mouseEventX(event);
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

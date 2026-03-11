/*
 * iOS_utils.mm, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */

#include "iOS_utils.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/message.h>
#import <sys/utsname.h>

namespace
{

static void requestNotificationPermissionIfNeeded()
{
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	[center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
		if(settings.authorizationStatus == UNAuthorizationStatusNotDetermined)
		{
			[center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
				completionHandler:^(BOOL granted, NSError * _Nullable error) {
					Q_UNUSED(granted);
					Q_UNUSED(error);
				}];
		}
	}];
}

static void showDownloadNotification(NSString *title, NSString *message)
{
	UNMutableNotificationContent *content = [UNMutableNotificationContent new];
	content.title = title ?: @"VCMI";
	content.body = message ?: @"Download finished";
	content.sound = UNNotificationSound.defaultSound;
	NSString *identifier = [NSString stringWithFormat:@"vcmi-download-%f", NSDate.date.timeIntervalSince1970];
	UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:nil];
	[[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}

NSString *standardPathNative(NSSearchPathDirectory directory)
{
	return [NSFileManager.defaultManager URLForDirectory:directory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:NULL].path;
}
const char *standardPath(NSSearchPathDirectory directory) { return standardPathNative(directory).fileSystemRepresentation; }
}


namespace iOS_utils
{
const char *documentsPath() { return standardPath(NSDocumentDirectory); }
const char *cachesPath() { return standardPath(NSCachesDirectory); }

#if TARGET_OS_SIMULATOR
const char *hostApplicationSupportPath()
{
	static NSString *applicationSupportPath;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		auto cachesPath = standardPathNative(NSCachesDirectory);
		auto afterMacOsHomeDirPos = [cachesPath rangeOfString:@"Library/Developer"].location;
		NSCAssert(afterMacOsHomeDirPos != NSNotFound, @"simulator directory location is not under user's home directory: %@", cachesPath);
		applicationSupportPath = [[cachesPath substringToIndex:afterMacOsHomeDirPos] stringByAppendingPathComponent:@"Library/Application Support/vcmi"].stringByResolvingSymlinksInPath;
	});
	return applicationSupportPath.fileSystemRepresentation;
}
#endif

const char *bundlePath() { return NSBundle.mainBundle.bundlePath.fileSystemRepresentation; }
const char *frameworksPath() { return NSBundle.mainBundle.privateFrameworksPath.fileSystemRepresentation; }

const char *bundleIdentifier() { return NSBundle.mainBundle.bundleIdentifier.UTF8String; }

bool isOsVersionAtLeast(unsigned int osMajorVersion)
{
	return NSProcessInfo.processInfo.operatingSystemVersion.majorVersion >= osMajorVersion;
}

void keepScreenOn(bool isEnabled)
{
	UIApplication.sharedApplication.idleTimerDisabled = isEnabled ? YES : NO;
}

void shareFile(const std::string & filePath)
{
	NSString *nsPath = [NSString stringWithUTF8String:filePath.c_str()];
	if (nsPath == nil)
		return;

	NSURL *url = [NSURL fileURLWithPath:nsPath];
	if (!url) return;

	NSArray *items = @[url];
	UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];

	UIViewController *root = UIApplication.sharedApplication.keyWindow.rootViewController;
	if (root.presentedViewController != nil)
		[root.presentedViewController presentViewController:controller animated:YES completion:nil];
	else
		[root presentViewController:controller animated:YES completion:nil];
}

std::string iphoneHardwareId()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return std::string(systemInfo.machine);
}
}

@interface VCMIBackgroundDownloader : NSObject <NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *destinations;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSDictionary *> *states;
@end

@implementation VCMIBackgroundDownloader

+ (instancetype)shared
{
	static VCMIBackgroundDownloader *instance;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		instance = [VCMIBackgroundDownloader new];
		instance.destinations = [NSMutableDictionary dictionary];
		instance.states = [NSMutableDictionary dictionary];
		NSString *identifier = [NSString stringWithFormat:@"%@.launcher.bgdownload", NSBundle.mainBundle.bundleIdentifier ?: @"eu.vcmi.vcmi"];
		NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];
		instance.session = [NSURLSession sessionWithConfiguration:cfg delegate:instance delegateQueue:nil];
	});
	return instance;
}

- (uint64_t)enqueue:(NSString *)url destination:(NSString *)destination error:(NSString **)error
{
	NSURL *nsUrl = [NSURL URLWithString:url];
	if(!nsUrl)
	{
		if(error) *error = @"Invalid URL";
		return 0;
	}
	NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:nsUrl];
	NSNumber *tid = @(task.taskIdentifier);
	@synchronized (self)
	{
		self.destinations[tid] = destination;
		self.states[tid] = @{@"received": @0, @"total": @0, @"finished": @NO, @"failed": @NO, @"error": @""};
	}
	[task resume];
	return task.taskIdentifier;
}

- (NSDictionary *)state:(uint64_t)taskId
{
	@synchronized (self)
	{
		return self.states[@((NSUInteger)taskId)] ?: @{@"received": @0, @"total": @0, @"finished": @YES, @"failed": @YES, @"error": @"Unknown download id"};
	}
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
	Q_UNUSED(session);
	NSNumber *tid = @(downloadTask.taskIdentifier);
	@synchronized (self)
	{
		NSDictionary *prev = self.states[tid] ?: @{};
		self.states[tid] = @{@"received": @(totalBytesWritten), @"total": @(MAX(totalBytesExpectedToWrite, 0)), @"finished": prev[@"finished"] ?: @NO, @"failed": prev[@"failed"] ?: @NO, @"error": prev[@"error"] ?: @""};
	}
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
	Q_UNUSED(session);
	if(!error)
		return;
	NSNumber *tid = @(task.taskIdentifier);
	@synchronized (self)
	{
		NSDictionary *prev = self.states[tid] ?: @{};
		self.states[tid] = @{@"received": prev[@"received"] ?: @0, @"total": prev[@"total"] ?: @0, @"finished": @YES, @"failed": @YES, @"error": error.localizedDescription ?: @"Download failed"};
	}
	showDownloadNotification(@"VCMI", error.localizedDescription ?: @"Download failed");
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
	Q_UNUSED(session);
	NSNumber *tid = @(downloadTask.taskIdentifier);
	NSString *dst = nil;
	@synchronized (self)
	{
		dst = self.destinations[tid];
	}
	NSError *moveError = nil;
	if(dst)
	{
		NSURL *target = [NSURL fileURLWithPath:dst];
		[NSFileManager.defaultManager removeItemAtURL:target error:nil];
		[NSFileManager.defaultManager createDirectoryAtURL:target.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:nil];
		[NSFileManager.defaultManager moveItemAtURL:location toURL:target error:&moveError];
	}
	@synchronized (self)
	{
		NSDictionary *prev = self.states[tid] ?: @{};
		BOOL failed = (moveError != nil);
		self.states[tid] = @{@"received": prev[@"received"] ?: @0, @"total": prev[@"total"] ?: @0, @"finished": @YES, @"failed": @(failed), @"error": moveError.localizedDescription ?: @""};
	}
	if(moveError)
		showDownloadNotification(@"VCMI", moveError.localizedDescription ?: @"Download failed");
	else
		showDownloadNotification(@"VCMI", @"Download ready");
}

@end

namespace iOS_utils
{
quint64 startBackgroundDownload(const std::string & url, const std::string & destinationPath, std::string & error)
{
	requestNotificationPermissionIfNeeded();
	NSString *err = nil;
	auto id = [[VCMIBackgroundDownloader shared] enqueue:[NSString stringWithUTF8String:url.c_str()] destination:[NSString stringWithUTF8String:destinationPath.c_str()] error:&err];
	if(err)
		error = err.UTF8String;
	return id;
}

bool queryBackgroundDownload(quint64 id, qint64 & received, qint64 & total, bool & finished, bool & failed, std::string & error)
{
	auto state = [[VCMIBackgroundDownloader shared] state:id];
	received = [state[@"received"] longLongValue];
	total = [state[@"total"] longLongValue];
	finished = [state[@"finished"] boolValue];
	failed = [state[@"failed"] boolValue];
	error = [state[@"error"] UTF8String] ?: "";
	return true;
}
}

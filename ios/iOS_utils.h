/*
 * iOS_utils.h, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#pragma once

#include <TargetConditionals.h>
#include <string>
#include <cstdint>

#pragma GCC visibility push(default)
namespace iOS_utils
{
const char *documentsPath();
const char *cachesPath();

// share file using system share sheet (e.g. Mail app)
void shareFile(const std::string & filePath);

std::string iphoneHardwareId();

#if TARGET_OS_SIMULATOR
const char *hostApplicationSupportPath();
#endif

const char *bundlePath();
const char *frameworksPath();

const char *bundleIdentifier();

bool isOsVersionAtLeast(unsigned int osMajorVersion);
void keepScreenOn(bool isEnabled);


std::uint64_t startBackgroundDownload(const std::string & url, const std::string & destinationPath, std::string & error);
bool queryBackgroundDownload(std::uint64_t id, std::int64_t & received, std::int64_t & total, bool & finished, bool & failed, std::string & error);
}
#pragma GCC visibility pop

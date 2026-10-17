/*
 * CloudStorageDetection.h, part of VCMI engine
 *
 * License: GNU General Public License v2.0 or later
 */
#pragma once

class DLL_LINKAGE WindowsCloud
{
public:
	static bool isOneDrivePath(const wchar_t * path);
	static bool isCloudStoragePath(const wchar_t * path);
};

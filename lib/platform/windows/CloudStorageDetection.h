/*
 * CloudStorageDetection.h, part of VCMI engine
 *
 * License: GNU General Public License v2.0 or later
 */
#pragma once

#include <windows.h>

#include <cwchar>
#include <string>

namespace VCMI::Windows
{
inline bool isOneDrivePath(const wchar_t * path)
{
	if(!path || !*path)
		return false;

	const DWORD requiredSize = ExpandEnvironmentStringsW(L"%OneDrive%", nullptr, 0);
	if(requiredSize == 0)
		return false;

	std::wstring expanded(requiredSize, L'\0');
	if(ExpandEnvironmentStringsW(L"%OneDrive%", expanded.data(), requiredSize) != requiredSize)
		return false;
	expanded.resize(requiredSize - 1);
	if(expanded == L"%OneDrive%")
		return false;
	while(expanded.size() > 3 && (expanded.back() == L'\\' || expanded.back() == L'/'))
		expanded.pop_back();

	const size_t oneDriveLength = expanded.size();
	return _wcsnicmp(path, expanded.c_str(), oneDriveLength) == 0
		&& (path[oneDriveLength] == L'\0' || path[oneDriveLength] == L'\\' || path[oneDriveLength] == L'/');
}

inline bool isCloudStoragePath(const wchar_t * path)
{
	if(!path || !*path)
		return false;
	if(isOneDrivePath(path))
		return true;

	// The Cloud Files API covers all registered sync providers, but is unavailable on old Windows.
	// Loading it dynamically keeps this code usable on Windows 7 and later.
	using GetSyncRootInfoByPath = HRESULT(WINAPI *)(LPCWSTR, int, PVOID, DWORD, DWORD *);
	static const HMODULE cloudApi = []
	{
		wchar_t systemDirectory[MAX_PATH];
		const UINT length = GetSystemDirectoryW(systemDirectory, MAX_PATH);
		return length > 0 && length < MAX_PATH
			? LoadLibraryW((std::wstring(systemDirectory, length) + L"\\CldApi.dll").c_str())
			: nullptr;
	}();
	static const auto getSyncRootInfoByPath = cloudApi
		? reinterpret_cast<GetSyncRootInfoByPath>(GetProcAddress(cloudApi, "CfGetSyncRootInfoByPath"))
		: nullptr;
	if(!getSyncRootInfoByPath)
		return false;

	std::wstring candidate(path);
	while(candidate.size() > 3 && (candidate.back() == L'\\' || candidate.back() == L'/'))
		candidate.pop_back();
	constexpr int basicSyncRootInfoClass = 0;
	while(!candidate.empty())
	{
		LARGE_INTEGER syncRootFileId{};
		if(SUCCEEDED(getSyncRootInfoByPath(candidate.c_str(), basicSyncRootInfoClass, &syncRootFileId, sizeof(syncRootFileId), nullptr)))
			return true;

		const size_t separator = candidate.find_last_of(L"\\/");
		if(separator == std::wstring::npos || separator < 3)
			break;
		candidate.resize(separator);
	}
	return false;
}
}

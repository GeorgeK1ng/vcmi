/*
 * Heroes3Detection.cpp, part of VCMI engine
 *
 * License: GNU General Public License v2.0 or later
 */

#include <windows.h>

#include <atomic>
#include <cwchar>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <limits>
#include <stdexcept>
#include <string>

#ifdef _M_IX86
#pragma comment(linker, "/EXPORT:StartHeroes3Detection=_StartHeroes3Detection@0")
#pragma comment(linker, "/EXPORT:GetHeroes3DetectionResult=_GetHeroes3DetectionResult@32")
#pragma comment(linker, "/EXPORT:CancelHeroes3Detection=_CancelHeroes3Detection@0")
#endif

// Only this native worker touches filesystem discovery. It never calls Pascal
// Script or accesses wizard controls; the UI polls an immutable completed result.
static std::atomic<bool> cancelled{false};
static std::atomic<int> detectionState{0}; // 0: pending, 1: ready, -1: failed
static bool detectionStarted = false; // Accessed only by the wizard thread.
static std::filesystem::path detectedPath;
static long long folderSizes[3]{};
static int folderCounts[3]{};
static const wchar_t * const folderNames[] = {L"Maps", L"Data", L"Mp3"};

static std::wstring registryString(HKEY hive, const wchar_t * subkey, const wchar_t * name, REGSAM view)
{
	HKEY key = nullptr;
	if(RegOpenKeyExW(hive, subkey, 0, KEY_QUERY_VALUE | view, &key) != ERROR_SUCCESS)
		return {};

	DWORD bytes = 0;
	DWORD type = 0;
	std::wstring value;
	if(RegQueryValueExW(key, name, nullptr, &type, nullptr, &bytes) == ERROR_SUCCESS
		&& (type == REG_SZ || type == REG_EXPAND_SZ) && bytes >= sizeof(wchar_t))
	{
		value.resize((bytes + sizeof(wchar_t) - 1) / sizeof(wchar_t));
		if(RegQueryValueExW(key, name, nullptr, nullptr,
			reinterpret_cast<BYTE *>(value.data()), &bytes) != ERROR_SUCCESS)
			value.clear();
		else if(const auto terminator = value.find(L'\0'); terminator != std::wstring::npos)
			value.resize(terminator);
	}
	RegCloseKey(key);
	return value;
}

static std::wstring registryPath(HKEY hive, const wchar_t * key, const wchar_t * name)
{
	SYSTEM_INFO system{};
	GetNativeSystemInfo(&system);
	if(system.wProcessorArchitecture != PROCESSOR_ARCHITECTURE_INTEL)
	{
		auto value = registryString(hive, key, name, KEY_WOW64_64KEY);
		if(!value.empty())
			return value;
	}
	return registryString(hive, key, name, KEY_WOW64_32KEY);
}

static bool contains(const std::filesystem::path & folder, const wchar_t * pattern)
{
	WIN32_FIND_DATAW data{};
	const HANDLE search = FindFirstFileW((folder / pattern).c_str(), &data);
	if(search == INVALID_HANDLE_VALUE)
		return false;
	FindClose(search);
	return true;
}

static bool validHeroes3Path(const std::filesystem::path & path)
{
	std::error_code error;
	return !cancelled && !path.empty()
		&& std::filesystem::is_regular_file(path / L"Data" / L"H3bitmap.lod", error)
		&& std::filesystem::is_regular_file(path / L"Data" / L"H3sprite.lod", error)
		&& contains(path / L"Maps", L"*.h3m");
}

static std::wstring loadText(const std::filesystem::path & path)
{
	if(cancelled)
		return {};
	std::ifstream stream(path, std::ios::binary);
	const std::string bytes((std::istreambuf_iterator<char>(stream)), {});
	if(bytes.empty() || bytes.size() > static_cast<size_t>(std::numeric_limits<int>::max()))
		return {};
	const int length = MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, bytes.data(), static_cast<int>(bytes.size()), nullptr, 0);
	std::wstring text(length, L'\0');
	if(length > 0)
		MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, bytes.data(), static_cast<int>(bytes.size()), text.data(), length);
	return text;
}

static std::wstring vdfValue(const std::wstring & text, const std::wstring & key, size_t & offset)
{
	const std::wstring quotedKey = L'"' + key + L'"';
	while(!cancelled && (offset = text.find(L'"', offset)) != std::wstring::npos)
	{
		if(_wcsnicmp(text.c_str() + offset, quotedKey.c_str(), quotedKey.size()) != 0)
		{
			++offset;
			continue;
		}
		const auto start = text.find(L'"', offset + quotedKey.size());
		const auto end = start == std::wstring::npos ? start : text.find(L'"', start + 1);
		if(end == std::wstring::npos)
			break;
		offset = end + 1;
		auto value = text.substr(start + 1, end - start - 1);
		for(size_t slash = 0; (slash = value.find(L"\\\\", slash)) != std::wstring::npos; ++slash)
			value.erase(slash, 1);
		return value;
	}
	return {};
}

static std::filesystem::path steamGameInLibrary(const std::filesystem::path & library)
{
	size_t offset = 0;
	const auto manifest = loadText(library / L"steamapps" / L"appmanifest_4921760.acf");
	if(manifest.empty())
		return {};
	auto directory = vdfValue(manifest, L"installdir", offset);
	if(directory.empty())
		directory = L"Heroes of Might and Magic III";
	const auto candidate = library / L"steamapps" / L"common" / directory;
	return validHeroes3Path(candidate) ? candidate : std::filesystem::path{};
}

static std::filesystem::path findHeroes3()
{
	const wchar_t * const keys[] = {
		L"SOFTWARE\\GOG.com\\Games\\1207658787",
		L"SOFTWARE\\New World Computing\\Heroes of Might and Magic\u00AE III\\1.0",
		L"SOFTWARE\\New World Computing\\Heroes of Might and Magic III\\1.0",
		L"SOFTWARE\\Ubisoft\\Launcher\\Installs\\353"
	};
	const wchar_t * const values[] = {L"path", L"AppPath", L"AppPath", L"InstallDir"};
	for(size_t index = 0; index < std::size(keys) && !cancelled; ++index)
	{
		const std::filesystem::path candidate = registryPath(HKEY_LOCAL_MACHINE, keys[index], values[index]);
		if(validHeroes3Path(candidate))
			return candidate; // Do not probe Steam after another valid source was found.
	}

	auto steam = registryPath(HKEY_CURRENT_USER, L"Software\\Valve\\Steam", L"SteamPath");
	if(steam.empty())
		steam = registryPath(HKEY_LOCAL_MACHINE, L"SOFTWARE\\Valve\\Steam", L"InstallPath");
	if(steam.empty() || cancelled)
		return {};
	if(auto candidate = steamGameInLibrary(steam); !candidate.empty())
		return candidate;

	const auto libraries = loadText(std::filesystem::path(steam) / L"steamapps" / L"libraryfolders.vdf");
	size_t offset = 0;
	while(!cancelled)
	{
		const auto library = vdfValue(libraries, L"path", offset);
		if(library.empty())
			break;
		if(auto candidate = steamGameInLibrary(library); !candidate.empty())
			return candidate;
	}
	return {};
}

static void countFolder(const std::filesystem::path & folder, long long & size, int & count)
{
	std::error_code error;
	std::filesystem::directory_iterator entry(folder, error), end;
	while(!error && entry != end && !cancelled)
	{
		const auto path = entry->path();
		const DWORD attributes = GetFileAttributesW(path.c_str());
		if(attributes == INVALID_FILE_ATTRIBUTES)
			throw std::runtime_error("Cannot read Heroes III file attributes");
		if((attributes & FILE_ATTRIBUTE_REPARSE_POINT) == 0)
		{
			if((attributes & FILE_ATTRIBUTE_DIRECTORY) != 0)
				countFolder(path, size, count);
			else
			{
				const auto bytes = entry->file_size(error);
				if(error || bytes > static_cast<unsigned long long>(std::numeric_limits<long long>::max() - size)
					|| count == std::numeric_limits<int>::max())
					throw std::runtime_error("Cannot count Heroes III files");
				size += static_cast<long long>(bytes);
				++count;
			}
		}
		entry.increment(error);
	}
	if(error && error != std::errc::no_such_file_or_directory)
		throw std::runtime_error("Cannot enumerate Heroes III directory");
}

static void CALLBACK detectHeroes3(PTP_CALLBACK_INSTANCE instance, void * module)
{
	// Keep the DLL loaded through the callback's return, even after Setup closes.
	// The Windows thread pool owns the worker lifetime; no loader-lock joins.
	FreeLibraryWhenCallbackReturns(instance, static_cast<HMODULE>(module));
	CallbackMayRunLong(instance);
	try
	{
		detectedPath = findHeroes3();
		for(size_t index = 0; index < std::size(folderNames) && !detectedPath.empty() && !cancelled; ++index)
			countFolder(detectedPath / folderNames[index], folderSizes[index], folderCounts[index]);
		// Release/acquire publishes all paths and counters together, exactly once.
		detectionState.store(cancelled ? -1 : 1, std::memory_order_release);
	}
	catch(...)
	{
		detectionState.store(-1, std::memory_order_release);
	}
}

extern "C" __declspec(dllexport) BOOL __stdcall StartHeroes3Detection()
{
	if(detectionStarted)
		return FALSE;
	HMODULE module = nullptr;
	if(!GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
		reinterpret_cast<LPCWSTR>(&detectHeroes3), &module))
		return FALSE;
	if(!TrySubmitThreadpoolCallback(detectHeroes3, module, nullptr))
	{
		FreeLibrary(module);
		return FALSE;
	}
	detectionStarted = true;
	return TRUE;
}

extern "C" __declspec(dllexport) int __stdcall GetHeroes3DetectionResult(
	LPWSTR path, DWORD capacity, long long * mapsSize, long long * dataSize, long long * mp3Size,
	int * mapsCount, int * dataCount, int * mp3Count)
{
	const int state = detectionState.load(std::memory_order_acquire);
	if(state != 1)
		return state;
	if(!path || capacity <= detectedPath.native().size()
		|| !mapsSize || !dataSize || !mp3Size || !mapsCount || !dataCount || !mp3Count)
		return -1;
	wcscpy_s(path, capacity, detectedPath.c_str());
	*mapsSize = folderSizes[0];
	*dataSize = folderSizes[1];
	*mp3Size = folderSizes[2];
	*mapsCount = folderCounts[0];
	*dataCount = folderCounts[1];
	*mp3Count = folderCounts[2];
	return 1;
}

extern "C" __declspec(dllexport) void __stdcall CancelHeroes3Detection()
{
	// Do not force termination or wait on potentially slow filesystem I/O.
	// The pinned callback stops between entries and releases its own DLL reference.
	cancelled = true;
}

#include <windows.h>
#include <shobjidl.h>

#include "platform/windows/CloudStorageDetection.h"

#ifdef _M_IX86
#pragma comment(linker, "/EXPORT:ModerFolderPicker=_ModerFolderPicker@20")
#pragma comment(linker, "/EXPORT:IsCloudStoragePath=_IsCloudStoragePath@4")
#endif

extern "C" __declspec(dllexport) BOOL __stdcall ModerFolderPicker(
	HWND owner,
	LPCWSTR title,
	LPCWSTR initialPath,
	LPWSTR outPath,
	DWORD outPathSize)
{
	if(!outPath || outPathSize == 0)
		return FALSE;
	outPath[0] = L'\0';

	const HRESULT initializationResult = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
	const bool shouldUninitialize = SUCCEEDED(initializationResult);
	if(FAILED(initializationResult) && initializationResult != RPC_E_CHANGED_MODE)
		return FALSE;

	IFileDialog * dialog = nullptr;
	HRESULT result = CoCreateInstance(CLSID_FileOpenDialog, nullptr, CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&dialog));
	if(FAILED(result))
	{
		if(shouldUninitialize)
			CoUninitialize();
		return FALSE;
	}

	DWORD options = 0;
	if(SUCCEEDED(dialog->GetOptions(&options)))
		dialog->SetOptions(options | FOS_PICKFOLDERS | FOS_FORCEFILESYSTEM | FOS_PATHMUSTEXIST | FOS_NOREADONLYRETURN);
	if(title && *title)
		dialog->SetTitle(title);

	if(initialPath && *initialPath)
	{
		IShellItem * initialFolder = nullptr;
		if(SUCCEEDED(SHCreateItemFromParsingName(initialPath, nullptr, IID_PPV_ARGS(&initialFolder))))
		{
			dialog->SetFolder(initialFolder);
			initialFolder->Release();
		}
	}

	result = dialog->Show(owner);
	if(SUCCEEDED(result))
	{
		IShellItem * selectedItem = nullptr;
		if(SUCCEEDED(dialog->GetResult(&selectedItem)))
		{
			PWSTR selectedPath = nullptr;
			if(SUCCEEDED(selectedItem->GetDisplayName(SIGDN_FILESYSPATH, &selectedPath)))
			{
				wcsncpy_s(outPath, outPathSize, selectedPath, _TRUNCATE);
				CoTaskMemFree(selectedPath);
			}
			selectedItem->Release();
		}
	}

	dialog->Release();
	if(shouldUninitialize)
		CoUninitialize();
	return outPath[0] != L'\0';
}

extern "C" __declspec(dllexport) BOOL __stdcall IsCloudStoragePath(LPCWSTR path)
{
	return VCMI::Windows::isCloudStoragePath(path) ? TRUE : FALSE;
}

// modernPicker.cpp
// Build as DLL (Win32 / x64 / ARM64). Unicode, stdcall.
// Link: Ole32.lib; Shell32.lib; Shlwapi.lib

#include <windows.h>
#include <shobjidl.h>

extern "C" {

// TRUE on success, FALSE on Cancel/error/unsupported OS.
__declspec(dllexport) BOOL __stdcall
ModernPickFolderW(HWND owner,
                  LPCWSTR title,        // optional
                  LPCWSTR initialPath,  // optional
                  LPWSTR  outPath,
                  DWORD   outCch)
{
    if (!outPath || outCch == 0) return FALSE;
    outPath[0] = L'\0';

    HRESULT hr = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
    const bool didInit = SUCCEEDED(hr);

    IFileDialog* dlg = nullptr;
    hr = CoCreateInstance(CLSID_FileOpenDialog, nullptr, CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&dlg));
    if (FAILED(hr)) { if (didInit) CoUninitialize(); return FALSE; }

    DWORD opts = 0;
    if (SUCCEEDED(dlg->GetOptions(&opts))) {
        opts |= FOS_PICKFOLDERS | FOS_FORCEFILESYSTEM | FOS_PATHMUSTEXIST | FOS_NOREADONLYRETURN;
        dlg->SetOptions(opts);
    }

    if (title && *title) dlg->SetTitle(title);

    if (initialPath && *initialPath) {
        IShellItem* folder = nullptr;
        if (SUCCEEDED(SHCreateItemFromParsingName(initialPath, nullptr, IID_PPV_ARGS(&folder)))) {
            dlg->SetFolder(folder);
            folder->Release();
        }
    }

    hr = dlg->Show(owner);
    if (SUCCEEDED(hr)) {
        IShellItem* item = nullptr;
        if (SUCCEEDED(dlg->GetResult(&item)) && item) {
            PWSTR path = nullptr;
            if (SUCCEEDED(item->GetDisplayName(SIGDN_FILESYSPATH, &path)) && path) {
                wcsncpy_s(outPath, outCch, path, _TRUNCATE);
                CoTaskMemFree(path);
                item->Release();
                dlg->Release();
                if (didInit) CoUninitialize();
                return TRUE;
            }
            item->Release();
        }
    }

    dlg->Release();
    if (didInit) CoUninitialize();
    return FALSE;
}

} // extern "C"

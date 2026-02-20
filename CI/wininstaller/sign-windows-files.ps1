param(
    [Parameter(Mandatory = $true)]
    [string]$CertificatePath,

    [Parameter(Mandatory = $true)]
    [string]$CertificatePassword,

    [Parameter(Mandatory = $true)]
    [string[]]$Paths,

    [string]$TimestampUrl = "http://timestamp.digicert.com"
)

$ErrorActionPreference = 'Stop'

$signtool = (Get-Command signtool.exe -ErrorAction SilentlyContinue).Source
if (-not $signtool) {
    throw 'signtool.exe was not found in PATH.'
}

foreach ($path in $Paths) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Path does not exist: $path"
    }

    $items = @()
    if ((Get-Item -LiteralPath $path) -is [System.IO.DirectoryInfo]) {
        $items = Get-ChildItem -LiteralPath $path -Include *.exe,*.dll -Recurse -File
    } else {
        $items = @(Get-Item -LiteralPath $path)
    }

    foreach ($item in $items) {
        Write-Host "Signing $($item.FullName)"
        & $signtool sign /f $CertificatePath /p $CertificatePassword /fd SHA256 /td SHA256 /tr $TimestampUrl /a $item.FullName
        if ($LASTEXITCODE -ne 0) {
            throw "signtool failed for $($item.FullName)"
        }
    }
}

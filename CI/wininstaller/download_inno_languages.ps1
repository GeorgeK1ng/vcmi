param(
    [Parameter(Mandatory = $true)]
    [string] $OutputDirectory
)

$ErrorActionPreference = 'Stop'

# Windows PowerShell on older build hosts may otherwise negotiate obsolete TLS.
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$innoSetupTag = 'is-7_1_0'
$languages = @(
    'Belarusian.isl',
    'Greek.isl',
    'Latvian.isl',
    'Romanian.isl',
    'SerbianCyrillic.isl',
    'Vietnamese.isl'
)

New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null

foreach($language in $languages)
{
    $destination = Join-Path $OutputDirectory $language
    if((Test-Path -LiteralPath $destination) -and
       (Select-String -LiteralPath $destination -Pattern '^\[LangOptions\]$' -Quiet) -and
       (Select-String -LiteralPath $destination -Pattern '^\[Messages\]$' -Quiet))
    {
        continue
    }

    $url = "https://raw.githubusercontent.com/jrsoftware/issrc/$innoSetupTag/Files/Languages/Unofficial/$language"
    $temporaryFile = "$destination.download"
    Remove-Item -LiteralPath $temporaryFile -Force -ErrorAction SilentlyContinue
    Write-Host "Downloading Inno Setup language: $language"
    try
    {
        Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $temporaryFile
    }
    catch
    {
        Remove-Item -LiteralPath $temporaryFile -Force -ErrorAction SilentlyContinue
        & curl.exe --fail --location --silent --show-error --output $temporaryFile $url
        if($LASTEXITCODE -ne 0)
        {
            throw "Unable to download $language with Invoke-WebRequest or curl.exe."
        }
    }

    if(-not (Select-String -LiteralPath $temporaryFile -Pattern '^\[LangOptions\]$' -Quiet) -or
       -not (Select-String -LiteralPath $temporaryFile -Pattern '^\[Messages\]$' -Quiet))
    {
        throw "Downloaded Inno Setup language file is invalid: $language"
    }

    Move-Item -LiteralPath $temporaryFile -Destination $destination -Force
}

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
    $url = "https://raw.githubusercontent.com/jrsoftware/issrc/$innoSetupTag/Files/Languages/Unofficial/$language"
    $temporaryFile = "$destination.download"
    Write-Host "Downloading Inno Setup language: $language"
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $temporaryFile
    Move-Item -LiteralPath $temporaryFile -Destination $destination -Force
}

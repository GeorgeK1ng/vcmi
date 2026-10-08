$ErrorActionPreference = 'Stop'

$installerDirectory = $PSScriptRoot
$repositoryRoot = Resolve-Path (Join-Path $installerDirectory '..\..')
$installerScript = Join-Path $installerDirectory 'installer.iss'
$languageDirectory = Join-Path $installerDirectory 'lang'

$installerLanguages = Select-String -LiteralPath $installerScript -Pattern '^Name: "([^"]+)"; MessagesFile:' |
    ForEach-Object { $_.Matches[0].Groups[1].Value }
$launcherLanguages = @(
    Get-ChildItem (Join-Path $repositoryRoot 'launcher\translation\*.ts') |
        ForEach-Object { $_.BaseName }
) + 'english'

# Inno Setup has no Filipino base translation. Keep this as the only explicit
# exception until an upstream translation becomes available.
$expectedLanguages = $launcherLanguages | Where-Object { $_ -ne 'filipino' } | Sort-Object -Unique
$actualLanguages = $installerLanguages | Sort-Object -Unique
$languageDifference = Compare-Object $expectedLanguages $actualLanguages
if($languageDifference)
{
    throw "Installer and launcher languages differ:`n$($languageDifference | Out-String)"
}

function Read-MessageKeys([string] $Path)
{
    $sections = @{
        Messages = [System.Collections.Generic.HashSet[string]]::new()
        CustomMessages = [System.Collections.Generic.HashSet[string]]::new()
    }
    $section = ''

    foreach($line in Get-Content -LiteralPath $Path)
    {
        if($line -match '^\[(Messages|CustomMessages)\]$')
        {
            $section = $Matches[1]
            continue
        }
        if($line -match '^\[')
        {
            $section = ''
            continue
        }
        if($section -and $line -match '^([^;\s][^=]*)=')
        {
            [void] $sections[$section].Add($Matches[1])
        }
    }

    return $sections
}

$reference = Read-MessageKeys (Join-Path $languageDirectory 'English.isl')
foreach($languageFile in Get-ChildItem (Join-Path $languageDirectory '*.isl'))
{
    $languageText = Get-Content -LiteralPath $languageFile.FullName -Raw
    if($languageText -notmatch '/ALLOWCLOUDTARGET=1')
    {
        throw "$($languageFile.Name) does not document /ALLOWCLOUDTARGET=1"
    }

    $messages = Read-MessageKeys $languageFile.FullName
    foreach($section in @('Messages', 'CustomMessages'))
    {
        $difference = Compare-Object $reference[$section] $messages[$section]
        if($difference)
        {
            throw "$($languageFile.Name) has a different [$section] key set:`n$($difference | Out-String)"
        }
    }
}

$installerText = Get-Content -LiteralPath $installerScript -Raw
foreach($requiredFragment in @(
    "HasCommandLineSwitch('ALLOWCLOUDTARGET')",
    "{cm:CloudTargetSilentError}",
    "{cm:CopyH3FilesError}"
))
{
    if(-not $installerText.Contains($requiredFragment))
    {
        throw "Installer script is missing required fragment: $requiredFragment"
    }
}

Write-Host "Validated $($actualLanguages.Count) installer languages and $($reference.Messages.Count + $reference.CustomMessages.Count) VCMI message keys."

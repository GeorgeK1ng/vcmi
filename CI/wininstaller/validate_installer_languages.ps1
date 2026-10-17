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

function Read-Messages([string] $Path)
{
    $sections = @{
        Messages = @{}
        CustomMessages = @{}
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
        if($section -and $line -match '^([^;\s][^=]*)=(.*)$')
        {
            $key = $Matches[1]
            if($sections[$section].ContainsKey($key))
            {
                throw "$Path has a duplicate [$section] key: $key"
            }
            $sections[$section][$key] = $Matches[2]
        }
    }

    return $sections
}

$reference = Read-Messages (Join-Path $languageDirectory 'English.isl')
foreach($languageFile in Get-ChildItem (Join-Path $languageDirectory '*.isl'))
{
    $languageText = Get-Content -LiteralPath $languageFile.FullName -Raw
    if($languageText -notmatch '/ALLOWCLOUDTARGET=1')
    {
        throw "$($languageFile.Name) does not document /ALLOWCLOUDTARGET=1"
    }

    $messages = Read-Messages $languageFile.FullName
    foreach($section in @('Messages', 'CustomMessages'))
    {
        $difference = Compare-Object @($reference[$section].Keys) @($messages[$section].Keys)
        if($difference)
        {
            throw "$($languageFile.Name) has a different [$section] key set:`n$($difference | Out-String)"
        }

        foreach($key in $reference[$section].Keys)
        {
            $source = $reference[$section][$key]
            $translation = $messages[$section][$key]
            if($source.Trim() -and -not $translation.Trim())
            {
                throw "$($languageFile.Name) has an empty [$section] translation: $key"
            }
            if($languageFile.BaseName -ne 'English' -and ($source -split '\s+').Count -ge 5 -and $source -ceq $translation)
            {
                throw "$($languageFile.Name) still uses an English sentence in [$section] $key"
            }

            # Keep parameter types, counts, line breaks, and literal command-line switches intact.
            $tokenPattern = '%(?:[1-9][0-9]*|[sdiun])|/[A-Z][A-Z0-9]*(?:=[0-9]+(?:\|[0-9]+)?)?'
            $sourceTokens = @([regex]::Matches($source, $tokenPattern) | ForEach-Object { $_.Value } | Sort-Object)
            $translatedTokens = @([regex]::Matches($translation, $tokenPattern) | ForEach-Object { $_.Value } | Sort-Object)
            if(($sourceTokens -join "`n") -cne ($translatedTokens -join "`n"))
            {
                throw "$($languageFile.Name) has different formatting or command-line tokens in [$section] $key"
            }
            if($key -eq 'HelpTextNote')
            {
                $taskPattern = '\b(?:startmenu_\w+|desktop_\w+|fileassociation_\w+|firewallrules)\b'
                $sourceTasks = @([regex]::Matches($source, $taskPattern) | ForEach-Object { $_.Value } | Sort-Object -Unique)
                $translatedTasks = @([regex]::Matches($translation, $taskPattern) | ForEach-Object { $_.Value } | Sort-Object -Unique)
                if(($sourceTasks -join "`n") -cne ($translatedTasks -join "`n"))
                {
                    throw "$($languageFile.Name) has different literal task names in $key"
                }
            }
            if($key -eq 'CopyH3FilesTooltip')
            {
                foreach($folder in @('Data', 'Maps', 'Mp3'))
                {
                    if(-not $translation.Contains($folder))
                    {
                        throw "$($languageFile.Name) does not preserve folder name $folder in $key"
                    }
                }
            }
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

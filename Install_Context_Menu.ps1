# Registra per l'utente corrente il comando del menu contestuale di Windows.
# Conservare questo script nella stessa cartella di "MarkItDown Desktop.exe".

$ErrorActionPreference = 'Stop'
$exe = Join-Path $PSScriptRoot 'MarkItDown Desktop.exe'
if (-not (Test-Path -LiteralPath $exe -PathType Leaf)) {
    throw "Eseguibile non trovato: $exe"
}

$key = 'Registry::HKEY_CURRENT_USER\Software\Classes\*\shell\MarkItDownDesktop'
New-Item -Path "$key\command" -Force | Out-Null
New-ItemProperty -Path $key -Name 'MUIVerb' -PropertyType String -Value 'Converti in Markdown con MarkItDown Desktop' -Force | Out-Null
New-ItemProperty -Path $key -Name 'Icon' -PropertyType String -Value ('"{0}",0' -f $exe) -Force | Out-Null
New-ItemProperty -Path $key -Name 'MultiSelectModel' -PropertyType String -Value 'Player' -Force | Out-Null
Set-Item -Path "$key\command" -Value ('"{0}" "%1"' -f $exe)

Write-Host 'Menu contestuale registrato per l''utente corrente.' -ForegroundColor Green
Write-Host 'In Esplora file: tasto destro su un file > Mostra altre opzioni > Converti in Markdown con MarkItDown Desktop.'

# Rimuove per l'utente corrente il comando MarkItDown Desktop dal menu contestuale di Windows.

$ErrorActionPreference = 'Stop'
$key = 'Registry::HKEY_CURRENT_USER\Software\Classes\*\shell\MarkItDownDesktop'
if (Test-Path -LiteralPath $key) {
    Remove-Item -LiteralPath $key -Recurse -Force
    Write-Host 'Menu contestuale MarkItDown Desktop rimosso.' -ForegroundColor Green
} else {
    Write-Host 'Non è presente alcun comando MarkItDown Desktop da rimuovere.' -ForegroundColor Yellow
}
